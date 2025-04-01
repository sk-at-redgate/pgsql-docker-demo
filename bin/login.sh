#!/usr/bin/env bash
#
#
username=dbuser
password=password
host=localhost
port=5555
db_name=dbuser

psql -d "postgres://$username:$password@$host:$port/$dbname"
