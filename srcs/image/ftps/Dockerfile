FROM	alpine:3.12.0

RUN		apk update; \
		apk add openssl; \
		apk add vsftpd;

COPY	./srcs/init.sh ./
COPY	./srcs/vsftpd.conf ./

EXPOSE	21 50000 50001 50002

CMD		["sh", "init.sh"]
