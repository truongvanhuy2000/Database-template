#!/bin/bash

if [ ! -f /app/script/backup.sh ]; then
    echo "backup.sh file not found!"
    exit 1
fi
echo "backup.sh file found!"

if [ ! -f /app/script/remove.sh ]; then
    echo "remove.sh file not found!"
    exit 1
fi
echo "remove.sh file found!"

if [ ! -f /app/cron/automatic-cron ]; then
    echo "automatic-cron file not found!"
    exit 1
fi
echo "automatic-cron file found!"

# Check if any required environment variables are empty
if [[ -z "${DB_HOST}" || -z "${DB_USER}" || -z "${DB_PASSWORD}" || -z "${DB_NAME}" || -z "${DB_PORT}" ]]; then
    echo "One or more required environment variables are empty:"
    [[ -z "${DB_HOST}" ]] && echo "DB_HOST is empty"
    [[ -z "${DB_USER}" ]] && echo "DB_USER is empty"
    [[ -z "${DB_PASSWORD}" ]] && echo "DB_PASSWORD is empty"
    [[ -z "${DB_NAME}" ]] && echo "DB_NAME is empty"
    [[ -z "${DB_PORT}" ]] && echo "DB_PORT is empty"
    exit 1
fi