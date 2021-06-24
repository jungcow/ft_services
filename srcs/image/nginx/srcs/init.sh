#! /bin/sh

mkdir -p /run/nginx

openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Gaepo/O=42Seoul/OU=jungwkim/CN=localhost" -keyout /etc/ssl/private/nginx.ssl.key -out /etc/ssl/certs/nginx.ssl.crt

chmod 600 /etc/ssl/private/nginx.ssl.key
chmod 640 /etc/ssl/certs/nginx.ssl.crt

mv nginx.conf /etc/nginx/
mv ssl.conf /etc/nginx/

nginx -g 'daemon off;'
