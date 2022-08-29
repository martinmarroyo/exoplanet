#!/bin/bash
echo Running the ETL process...
docker exec -it frontend bash ./run_etl.sh
echo ETL Complete!