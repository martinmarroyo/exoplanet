-- FUNCTION: public.insert_fact_observation()

-- DROP FUNCTION IF EXISTS public.insert_fact_observation();

CREATE OR REPLACE FUNCTION public.insert_fact_observation(
	)
    RETURNS void
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
/*
    INSERT_FACT_OBSERVATION
    
    An idempotent function used to insert the 
    most recent facts from the Extrasolar Planet
    Encyclopedia API.
*/
WITH observations AS (
    SELECT
        target_name,
        star_name,
        time_min,
        time_max,
        time_sampling_step_min,
        time_sampling_step_max,
        time_exp_min,
        time_exp_max,
        spectral_range_min,
        spectral_range_max,
        spectral_sampling_step_min,
        spectral_sampling_step_max,
        spectral_resolution_min,
        spectral_resolution_max,
        c1min,
        c1max,
        c2min,
        c2max,
        c3min,
        c3max,
        s_region,
        c1_resol_min,
        c1_resol_max,
        c2_resol_min,
        c2_resol_max,
        c3_resol_min,
        c3_resol_max,
        incidence_min,
        incidence_max,
        emergence_min,
        emergence_max,
        phase_min,
        phase_max,
        time_scale,
        mass,
        mass_error_min,
        mass_error_max,
        radius,
        radius_error_min,
        radius_error_max,
        semi_major_axis,
        semi_major_axis_error_min,
        semi_major_axis_error_max,
        period,
        period_error_min,
        period_error_max,
        eccentricity,
        eccentricity_error_min,
        eccentricity_error_max,
        periastron,
        periastron_error_min,
        periastron_error_max,
        tzero_tr,
        tzero_tr_error_min,
        tzero_tr_error_max,
        tzero_vr,
        tzero_vr_error_min,
        tzero_vr_error_max,
        t_peri,
        t_peri_error_min,
        t_peri_error_max,
        t_conj,
        t_conj_error_min,
        t_conj_error_max,
        inclination,
        inclination_error_min,
        inclination_error_max,
        tzero_tr_sec,
        tzero_tr_sec_error_min,
        tzero_tr_sec_error_max,
        lambda_angle,
        lambda_angle_error_min,
        lambda_angle_error_max,
        angular_distance,
        temp_calculated,
        temp_measured,
        hot_point_lon,
        log_g,
        albedo,
        albedo_error_min,
        albedo_error_max,
        mass_sin_i,
        mass_sin_i_error_min,
        mass_sin_i_error_max,
        impact_parameter,
        impact_parameter_error_min,
        impact_parameter_error_max,
        k,
        k_error_min,
        k_error_max,
        modification_date::TIMESTAMP
    FROM
        raw_exoplanet_data
    WHERE NOT EXISTS (
        SELECT target_name, star_name, modification_date, load_date
        FROM fact_observation
        WHERE target_name=raw_exoplanet_data.target_name
            AND star_name=raw_exoplanet_data.star_name
            AND modification_date=raw_exoplanet_data.modification_date::TIMESTAMP
            AND load_date=raw_exoplanet_data.load_date
    )
)
, facts AS (
    SELECT exo.planet_key, star.star_key, observations.*
    FROM observations
    -- Get planet keys
    INNER JOIN (
        SELECT planet_key, target_name
        FROM dim_exoplanet
        WHERE is_current
    ) exo
    ON observations.target_name=exo.target_name
    -- Get star keys
    LEFT JOIN (
        SELECT star_key, star_name
        FROM dim_star
        WHERE is_current
    ) star
    ON observations.star_name=star.star_name
)
INSERT INTO fact_observation
SELECT *
FROM facts;
$BODY$;

ALTER FUNCTION public.insert_fact_observation()
    OWNER TO citizen_scientist;

COMMENT ON FUNCTION public.insert_fact_observation()
    IS 'An idempotent function used to insert the most recent facts from the Extrasolar Planet Encyclopedia API.';
