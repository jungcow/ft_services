FROM        alpine:3.11.6

RUN         wget http://dl-cdn.alpinelinux.org/alpine/v3.13/community/x86_64/telegraf-1.17.0-r0.apk; \
			apk update; \
			apk add telegraf-1.17.0-r0.apk; \
			mkdir -p /etc/telegraf


ENTRYPOINT  [ "/usr/bin/telegraf" ]
