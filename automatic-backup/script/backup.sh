#!/bin/bash
# Current date in YYYY-MM-DD-HHMMSS format for unique backup filenames
source /app/script/bootstrap.sh

DATE=$(date +%F-%H%M%S)

BACKUP_DIR=""

if [[ -z "${BACKUP_DIR}" ]]; then
  BACKUP_DIR="/backup"
else
  BACKUP_DIR="${BACKUP_DIR}"
fi

if [ ! -d $BACKUP_DIR ]; then
  mkdir -p $BACKUP_DIR;
fi

# Database credentials and details
DB_HOST="${DB_HOST}" #name of the mysql container
DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"
DB_NAME="${DB_NAME}"
DB_PORT="${DB_PORT}"

DUMP_OPTION="--add-drop-table --add-locks --skip-comments --quick"

mysqldump -h$DB_HOST -u$DB_USER -p$DB_PASSWORD --port $DB_PORT --protocol tcp $DUMP_OPTION  $DB_NAME > $BACKUP_DIR/mydb-$DATE.sql
# Compress the backup file
gzip $BACKUP_DIR/mydb-$DATE.sql

echo "Backing up $BACKUP_DIR/mydb-$DATE.gz"