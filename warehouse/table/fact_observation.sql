CREATE TABLE IF NOT EXISTS fact_observation(
    planet_key BIGINT,
    star_key BIGINT,
    target_name TEXT,
    star_name TEXT,
    time_min DOUBLE PRECISION,
    time_max DOUBLE PRECISION,
    time_sampling_step_min DOUBLE PRECISION,
    time_sampling_step_max DOUBLE PRECISION,
    time_exp_min DOUBLE PRECISION,
    time_exp_max DOUBLE PRECISION,
    spectral_range_min DOUBLE PRECISION,
    spectral_range_max DOUBLE PRECISION,
    spectral_sampling_step_min DOUBLE PRECISION,
    spectral_sampling_step_max DOUBLE PRECISION,
    spectral_resolution_min DOUBLE PRECISION,
    spectral_resolution_max DOUBLE PRECISION,
    c1min DOUBLE PRECISION,
    c1max DOUBLE PRECISION,
    c2min DOUBLE PRECISION,
    c2max DOUBLE PRECISION,
    c3min DOUBLE PRECISION,
    c3max DOUBLE PRECISION,
    s_region TEXT,
    c1_resol_min DOUBLE PRECISION,
    c1_resol_max DOUBLE PRECISION,
    c2_resol_min DOUBLE PRECISION,
    c2_resol_max DOUBLE PRECISION,
    c3_resol_min DOUBLE PRECISION,
    c3_resol_max DOUBLE PRECISION,
    incidence_min DOUBLE PRECISION,
    incidence_max DOUBLE PRECISION,
    emergence_min DOUBLE PRECISION,
    emergence_max DOUBLE PRECISION,
    phase_min DOUBLE PRECISION,
    phase_max DOUBLE PRECISION,
    time_scale TEXT,
    mass DOUBLE PRECISION,
    mass_error_min DOUBLE PRECISION,
    mass_error_max DOUBLE PRECISION,
    radius DOUBLE PRECISION,
    radius_error_min DOUBLE PRECISION,
    radius_error_max DOUBLE PRECISION,
    semi_major_axis DOUBLE PRECISION,
    semi_major_axis_error_min DOUBLE PRECISION,
    semi_major_axis_error_max DOUBLE PRECISION,
    period DOUBLE PRECISION,
    period_error_min DOUBLE PRECISION,
    period_error_max DOUBLE PRECISION,
    eccentricity DOUBLE PRECISION,
    eccentricity_error_min DOUBLE PRECISION,
    eccentricity_error_max DOUBLE PRECISION,
    periastron DOUBLE PRECISION,
    periastron_error_min DOUBLE PRECISION,
    periastron_error_max DOUBLE PRECISION,
    tzero_tr DOUBLE PRECISION,
    tzero_tr_error_min DOUBLE PRECISION,
    tzero_tr_error_max DOUBLE PRECISION,
    tzero_vr DOUBLE PRECISION,
    tzero_vr_error_min DOUBLE PRECISION,
    tzero_vr_error_max DOUBLE PRECISION,
    t_peri DOUBLE PRECISION,
    t_peri_error_min DOUBLE PRECISION,
    t_peri_error_max DOUBLE PRECISION,
    t_conj DOUBLE PRECISION,
    t_conj_error_min DOUBLE PRECISION,
    t_conj_error_max DOUBLE PRECISION,
    inclination DOUBLE PRECISION,
    inclination_error_min DOUBLE PRECISION,
    inclination_error_max DOUBLE PRECISION,
    tzero_tr_sec DOUBLE PRECISION,
    tzero_tr_sec_error_min DOUBLE PRECISION,
    tzero_tr_sec_error_max DOUBLE PRECISION,
    lambda_angle DOUBLE PRECISION,
    lambda_angle_error_min DOUBLE PRECISION,
    lambda_angle_error_max DOUBLE PRECISION,
    angular_distance DOUBLE PRECISION,
    temp_calculated DOUBLE PRECISION,
    temp_measured DOUBLE PRECISION,
    hot_point_lon DOUBLE PRECISION,
    log_g DOUBLE PRECISION,
    albedo DOUBLE PRECISION,
    albedo_error_min DOUBLE PRECISION,
    albedo_error_max DOUBLE PRECISION,
    mass_sin_i DOUBLE PRECISION,
    mass_sin_i_error_min DOUBLE PRECISION,
    mass_sin_i_error_max DOUBLE PRECISION,
    impact_parameter DOUBLE PRECISION,
    impact_parameter_error_min DOUBLE PRECISION,
    impact_parameter_error_max DOUBLE PRECISION,
    k DOUBLE PRECISION,
    k_error_min DOUBLE PRECISION,
    k_error_max DOUBLE PRECISION,
    modification_date TIMESTAMP
);