#!/bin/bash

if [ ! -f /app/script/verify.sh ]; then
    echo "verify.sh file not found!"
    exit 1
fi

source /app/script/verify.sh

ENV_FILE="/app/script/bootstrap.sh"
touch $ENV_FILE
# Write the environment variables to the file
echo "#!/bin/bash" > $ENV_FILE
echo "export DB_HOST=${DB_HOST}" >> $ENV_FILE
echo "export DB_PORT=${DB_PORT}" >> $ENV_FILE
echo "export DB_NAME=${DB_NAME}" >> $ENV_FILE
echo "export DB_USER=${DB_USER}" >> $ENV_FILE
echo "export DB_PASSWORD=${DB_PASSWORD}" >> $ENV_FILE

# chmod +x /app/script/bootstrap.sh
chmod +x /app/script/backup.sh
chmod +x /app/script/remove.sh
# Copy hello-cron file to the cron.d directory
cp /app/cron/automatic-cron /etc/cron.d
service cron start

# Give execution rights on the cron job
chmod 644 /etc/cron.d/automatic-cron

# Apply cron job
crontab /etc/cron.d/automatic-cron


touch /var/log/cron.log
tail -f /var/log/cron.log