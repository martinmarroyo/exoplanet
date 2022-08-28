-- FUNCTION: public.update_dim_exoplanet()

-- DROP FUNCTION IF EXISTS public.update_dim_exoplanet();

CREATE OR REPLACE FUNCTION public.update_dim_exoplanet(
	)
    RETURNS void
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
/*
    UPDATE_DIM_EXOPLANET
    
    An idempotent function that updates
    the dim_exoplanet table when new 
    records arrive from the source database.
*/
WITH exoplanet AS (
    -- Get the latest data
    SELECT
        target_name,
        target_class,
        spatial_frame_type,
        instrument_host_name,
        instrument_name,
        measurement_type,
        processing_level,
        creation_date::TIMESTAMP,
        modification_date::TIMESTAMP,
        release_date::TIMESTAMP,
        service_title,
        publisher,
        bib_reference,
        target_region,
        species,
        detection_type,
        publication_status,
        discovered,
        remarks,
        other_web,
        mass_detection_type,
        radius_detection_type,
        alt_target_name,
        star_name,
        't'::BOOL AS is_current,
        NOW()::DATE AS current_as_of
    FROM 
        raw_exoplanet_data
    -- Make sure records don't already exist in dimension table
    WHERE NOT EXISTS (
        SELECT target_name, modification_date
        FROM dim_exoplanet
        WHERE is_current
            AND target_name=raw_exoplanet_data.target_name
            AND modification_date=raw_exoplanet_data.modification_date::TIMESTAMP
    )
)
, updates AS (
    -- Expire old entries
    UPDATE dim_exoplanet
    SET is_current='f', date_expired=NOW()
    FROM exoplanet
    WHERE exoplanet.target_name=dim_exoplanet.target_name
)
-- Add new entries
INSERT INTO dim_exoplanet (
    target_name, target_class,spatial_frame_type,
    instrument_host_name,instrument_name,measurement_type,
    processing_level,creation_date,modification_date,
    release_date,service_title,publisher,bib_reference,
    target_region,species,detection_type,publication_status,
    discovered,remarks,other_web,mass_detection_type,
    radius_detection_type,alt_target_name,star_name,is_current,
    current_as_of
)
SELECT *
FROM exoplanet;
$BODY$;

ALTER FUNCTION public.update_dim_exoplanet()
    OWNER TO citizen_scientist;

COMMENT ON FUNCTION public.update_dim_exoplanet()
    IS 'An idempotent function that updates the dim_exoplanet table when new records arrive from the source database.';