CREATE TABLE IF NOT EXISTS public.raw_exoplanet_data
(
    granule_uid text COLLATE pg_catalog."default",
    granule_gid text COLLATE pg_catalog."default",
    obs_id text COLLATE pg_catalog."default",
    dataproduct_type text COLLATE pg_catalog."default",
    target_name text COLLATE pg_catalog."default",
    target_class text COLLATE pg_catalog."default",
    time_min double precision,
    time_max double precision,
    time_sampling_step_min double precision,
    time_sampling_step_max double precision,
    time_exp_min double precision,
    time_exp_max double precision,
    spectral_range_min double precision,
    spectral_range_max double precision,
    spectral_sampling_step_min double precision,
    spectral_sampling_step_max double precision,
    spectral_resolution_min double precision,
    spectral_resolution_max double precision,
    c1min double precision,
    c1max double precision,
    c2min double precision,
    c2max double precision,
    c3min double precision,
    c3max double precision,
    s_region text COLLATE pg_catalog."default",
    c1_resol_min double precision,
    c1_resol_max double precision,
    c2_resol_min double precision,
    c2_resol_max double precision,
    c3_resol_min double precision,
    c3_resol_max double precision,
    spatial_frame_type text COLLATE pg_catalog."default",
    incidence_min double precision,
    incidence_max double precision,
    emergence_min double precision,
    emergence_max double precision,
    phase_min double precision,
    phase_max double precision,
    instrument_host_name text COLLATE pg_catalog."default",
    instrument_name text COLLATE pg_catalog."default",
    measurement_type text COLLATE pg_catalog."default",
    processing_level integer,
    creation_date text COLLATE pg_catalog."default",
    modification_date text COLLATE pg_catalog."default",
    release_date text COLLATE pg_catalog."default",
    service_title text COLLATE pg_catalog."default",
    time_scale text COLLATE pg_catalog."default",
    publisher text COLLATE pg_catalog."default",
    bib_reference text COLLATE pg_catalog."default",
    target_region text COLLATE pg_catalog."default",
    species text COLLATE pg_catalog."default",
    detection_type text COLLATE pg_catalog."default",
    publication_status text COLLATE pg_catalog."default",
    mass double precision,
    mass_error_min double precision,
    mass_error_max double precision,
    radius double precision,
    radius_error_min double precision,
    radius_error_max double precision,
    semi_major_axis double precision,
    semi_major_axis_error_min double precision,
    semi_major_axis_error_max double precision,
    period double precision,
    period_error_min double precision,
    period_error_max double precision,
    eccentricity double precision,
    eccentricity_error_min double precision,
    eccentricity_error_max double precision,
    periastron double precision,
    periastron_error_min double precision,
    periastron_error_max double precision,
    tzero_tr real,
    tzero_tr_error_min double precision,
    tzero_tr_error_max double precision,
    tzero_vr double precision,
    tzero_vr_error_min double precision,
    tzero_vr_error_max double precision,
    t_peri double precision,
    t_peri_error_min double precision,
    t_peri_error_max double precision,
    t_conj double precision,
    t_conj_error_min double precision,
    t_conj_error_max double precision,
    inclination double precision,
    inclination_error_min double precision,
    inclination_error_max double precision,
    tzero_tr_sec double precision,
    tzero_tr_sec_error_min double precision,
    tzero_tr_sec_error_max double precision,
    lambda_angle double precision,
    lambda_angle_error_min double precision,
    lambda_angle_error_max double precision,
    discovered integer,
    updated text COLLATE pg_catalog."default",
    remarks text COLLATE pg_catalog."default",
    other_web text COLLATE pg_catalog."default",
    angular_distance double precision,
    temp_calculated double precision,
    temp_measured double precision,
    hot_point_lon double precision,
    log_g double precision,
    albedo double precision,
    albedo_error_min double precision,
    albedo_error_max double precision,
    mass_detection_type text COLLATE pg_catalog."default",
    radius_detection_type text COLLATE pg_catalog."default",
    mass_sin_i double precision,
    mass_sin_i_error_min double precision,
    mass_sin_i_error_max double precision,
    impact_parameter double precision,
    impact_parameter_error_min double precision,
    impact_parameter_error_max double precision,
    k double precision,
    k_error_min double precision,
    k_error_max double precision,
    alt_target_name text COLLATE pg_catalog."default",
    star_name text COLLATE pg_catalog."default",
    star_distance double precision,
    star_distance_error_min double precision,
    star_distance_error_max double precision,
    star_spec_type text COLLATE pg_catalog."default",
    mag_v double precision,
    mag_i double precision,
    mag_j double precision,
    mag_h double precision,
    mag_k double precision,
    star_metallicity double precision,
    star_mass double precision,
    star_radius double precision,
    star_age double precision,
    star_teff double precision,
    magnetic_field boolean,
    detected_disc text COLLATE pg_catalog."default",
    ra double precision,
    "dec" double precision,
    external_link text COLLATE pg_catalog."default",
    uuid text COLLATE pg_catalog."default",
    load_date date
);