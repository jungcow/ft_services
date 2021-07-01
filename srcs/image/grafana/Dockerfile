FROM	alpine:3.12.0

RUN		wget http://dl-cdn.alpinelinux.org/alpine/v3.14/community/x86_64/grafana-7.5.7-r1.apk; \
		apk update; \
		apk add grafana-7.5.7-r1.apk; \
		mkdir -p /etc/grafana;

COPY	dashboards /usr/share/grafana/public/dashboards

EXPOSE	3000

ENTRYPOINT	[ "grafana-server", "--homepath=/usr/share/grafana" ]
