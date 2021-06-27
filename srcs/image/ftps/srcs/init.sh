#!/bin/sh

# ftps 사용자를 만들어서 익명이 아닌 허용된 사용자만 사용하도록 함.
adduser -h /var/lib/ftp/jungwkim -D jungwkim
echo "jungwkim:1234" | chpasswd
echo "jungwkim" > /etc/vsftpd/vsftpd.userlist

openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Gaepo/O=42Seoul/OU=jungwkim/CN=localhost" -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

chmod 600 /etc/ssl/private/vsftpd.key
chmod 640 /etc/ssl/certs/vsftpd.crt

mv /vsftpd.conf /etc/vsftpd/vsftpd.conf

vsftpd /etc/vsftpd/vsftpd.conf
