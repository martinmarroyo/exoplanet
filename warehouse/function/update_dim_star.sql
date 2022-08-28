-- FUNCTION: public.update_dim_star()

-- DROP FUNCTION IF EXISTS public.update_dim_star();

CREATE OR REPLACE FUNCTION public.update_dim_star(
	)
    RETURNS void
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
/*
    UPDATE_DIM_STAR
    
    An idempotent function that updates
    the dim_star table when new records 
    arrive from the source database.
*/

WITH deduped_star AS (
    SELECT 
        star_name,
        star_distance,
        star_distance_error_min,
        star_distance_error_max,
        star_spec_type,
        mag_v,
        mag_i,
        mag_j,
        mag_h,
        mag_k,
        star_metallicity,
        star_mass,
        star_radius,
        star_age,
        star_teff,
        magnetic_field,
        detected_disc,
        ra,
        dec,
        modification_date::TIMESTAMP,
        RANK() OVER (
            PARTITION BY star_name
            ORDER BY modification_date::TIMESTAMP DESC
        ) AS recent
    FROM
        raw_exoplanet_data
    WHERE
        star_name<>''
)
, star AS (
    SELECT 
        star_name,
        star_distance,
        star_distance_error_min,
        star_distance_error_max,
        star_spec_type,
        mag_v,
        mag_i,
        mag_j,
        mag_h,
        mag_k,
        star_metallicity,
        star_mass,
        star_radius,
        star_age,
        star_teff,
        magnetic_field,
        detected_disc,
        ra,
        dec,
        modification_date,
        't'::BOOL AS is_current,
        NOW()::DATE AS current_as_of
    FROM deduped_star
    WHERE NOT EXISTS (
    SELECT star_name, modification_date
    FROM dim_star
    WHERE is_current
        AND star_name=deduped_star.star_name
        AND modification_date=deduped_star.modification_date::TIMESTAMP
    ) AND recent=1
)
, updates AS (
    -- Expire old rows
    UPDATE dim_star
    SET is_current='f', date_expired=NOW()::DATE
    FROM star
    WHERE star.star_name=dim_star.star_name
)
INSERT INTO dim_star(
    star_name,star_distance,star_distance_error_min,
    star_distance_error_max,star_spec_type,mag_v,
    mag_i,mag_j,mag_h,mag_k,star_metallicity,
    star_mass,star_radius,star_age,star_teff,
    magnetic_field,detected_disc,ra,dec,
    modification_date,is_current, current_as_of
)
SELECT DISTINCT *
FROM star
$BODY$;

ALTER FUNCTION public.update_dim_star()
    OWNER TO citizen_scientist;

COMMENT ON FUNCTION public.update_dim_star()
    IS 'An idempotent function that updates the dim_star table when new records arrive from the source database.';
