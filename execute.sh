#!/bin/bash

# Variables
CONTAINER_NAME="mysql-practices-container"
MYSQL_USER="root"
MYSQL_PASSWORD="root"

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Please provide the SQL file path as an argument"
    exit 1
fi

# Get the SQL file path
SQL_FILE=$1

# Check if the SQL file exists
if [ ! -f $SQL_FILE ]; then
    echo "The SQL file does not exist"
    exit 1
fi

# Run the SQL file and ignore the errors
docker exec -i $CONTAINER_NAME mysql -u $MYSQL_USER -p$MYSQL_PASSWORD < $SQL_FILE 2> /dev/null
