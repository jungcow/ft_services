FROM	alpine:3.12.0

RUN		apk update && \
		apk add mysql mysql-client

COPY	./srcs/init.sh /
COPY	./srcs/phpmyadmin.sql /
COPY	./srcs/wordpress.sql /
COPY	./srcs/dump_wordpress.sql /
COPY	./srcs/my.cnf /etc/

EXPOSE	3306

CMD		["sh", "init.sh"]
