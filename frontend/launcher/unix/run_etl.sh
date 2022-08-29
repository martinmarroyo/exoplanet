#!/bin/bash
echo Initializing the database...
docker exec -it frontend bash ./initialize_db
echo Database initialized!
echo You can interact with the data here: http://localhost:8800/