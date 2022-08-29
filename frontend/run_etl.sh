#!/bin/bash
# Runs the ETL process on the ETL worker
echo Running the ETL process
dbclient -l exoplanet etl -y "cd ../../src && python main.py"
echo ETL process has completed!
echo Check the database at http://localhost:8800/