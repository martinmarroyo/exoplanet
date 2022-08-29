#!/bin/bash
# Starts docker and launches the frontend application
docker compose -f ../../../docker-compose.yml up -d 
wait
chmod +x run_etl.sh
chmod +x start_db.sh
./run_etl.sh
./start_db.sh
sleep 3
clear
echo Welcome to
cat ../../../frontend/logo.txt
echo A tool to collect and visualize exoplanet data from the Extrasolar Planet Encyclopedia
echo
echo You can interact with the data here: http://localhost:8800/
echo Visualize it here: http://localhost:3000/
read