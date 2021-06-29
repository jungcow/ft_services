FROM        alpine:3.11.6

RUN         apk update; \
            apk add influxdb;

RUN         mkdir -p /var/lib/influxdb

EXPOSE      8086 8083

ENTRYPOINT  [ "/usr/sbin/influxd" ]
