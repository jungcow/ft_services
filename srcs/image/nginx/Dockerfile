FROM	alpine:3.12.0

LABEL	maintainer="jungwkim@student.42seoul.kr"

RUN		apk update; \
		apk add nginx; \
		apk add openssl;

COPY	./srcs/init.sh ./

COPY	./srcs/nginx.conf ./

COPY	./srcs/ssl.conf ./

COPY	./srcs/index.html /var/www/html/

EXPOSE	80 443

CMD		sh init.sh
