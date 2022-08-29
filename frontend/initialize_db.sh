#!/bin/bash
# Initializes the database by connecting to the db_init worker and running init_warehouse
echo Initializing the database...
dbclient -l exoplanet db_init -y "cd ../../warehouse && python init_warehouse.py"
echo Database has been initialized!
echo Check the database at http://localhost:8800/