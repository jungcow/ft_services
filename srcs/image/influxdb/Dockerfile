FROM        alpine:3.11.6

RUN         apk update; \
            apk add influxdb; \
			mkdir -p /etc/influxdb; \
			mkdir -p /var/lib/influxdb;

EXPOSE      8086

ENTRYPOINT  [ "/usr/sbin/influxd" ]
