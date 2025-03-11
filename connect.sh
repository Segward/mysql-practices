#!/bin/bash

# Check if a session name is provided
DATABASE_NAME=${1:-"mysql"}

# Connect to MySQL with a unique session name
docker exec -it mysql-practices-container mysql \
    -u root \
    -proot \
    $DATABASE_NAME \
    --default-character-set=utf8