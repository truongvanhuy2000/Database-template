FROM debian:12.5-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y cron rsyslog

RUN apt-get install -y default-mysql-client

WORKDIR /app
COPY ./script /app/script
COPY ./cron /app/cron

RUN chmod +x /app/script/init.sh 

CMD /app/script/init.sh