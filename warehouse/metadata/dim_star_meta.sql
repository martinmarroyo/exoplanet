COMMENT ON COLUMN dim_star.star_name IS 'Name of the host star';
COMMENT ON COLUMN dim_star.star_distance IS 'Distance of the star to the observer';
COMMENT ON COLUMN dim_star.star_distance_error_min IS 'Distance of the star error min';
COMMENT ON COLUMN dim_star.star_distance_error_max IS 'Distance of the star error max';
COMMENT ON COLUMN dim_star.star_spec_type IS 'Stellar spectral type';
COMMENT ON COLUMN dim_star.mag_v IS 'Apparent magnitude in the V band';
COMMENT ON COLUMN dim_star.mag_i IS 'Apparent magnitude in the I band';
COMMENT ON COLUMN dim_star.mag_j IS 'Apparent magnitude in the J band';
COMMENT ON COLUMN dim_star.mag_h IS 'Apparent magnitude in the H band';
COMMENT ON COLUMN dim_star.mag_k IS 'Apparent magnitude in the K band';
COMMENT ON COLUMN dim_star.star_metallicity IS 'Decimal logarithm of the massive elements (Â« metals Â») to hydrogen ratio in solar units (i.e. Log [(metals/H)star/(metals/H)Sun])';
COMMENT ON COLUMN dim_star.star_mass IS 'Star mass';
COMMENT ON COLUMN dim_star.star_radius IS 'Star radius';
COMMENT ON COLUMN dim_star.star_age IS 'Stellar age';
COMMENT ON COLUMN dim_star.star_teff IS 'Effective stellar temperature';
COMMENT ON COLUMN dim_star.magnetic_field IS 'Stellar magnetic field detected';
COMMENT ON COLUMN dim_star.detected_disc IS '(direct imaging or IR excess) disc detected';
COMMENT ON COLUMN dim_star.ra IS 'Right ascension of the host star';
COMMENT ON COLUMN dim_star.dec IS 'Declination of the host star';
COMMENT ON COLUMN dim_star.external_link IS 'Url of the planet page on exoplanet.eu';