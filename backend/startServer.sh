#!/bin/sh


echo "Waiting for postgres..."

while ! nc -z $SQL_HOST $SQL_PORT; do
    sleep 5
done

echo "PostgreSQL started"

exec venv/bin/python server/__init__.py