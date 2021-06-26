
openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Gaepo/O=42Seoul/OU=jungwkim/CN=localhost" -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

chmod 600 /etc/ssl/private/vsftpd.key
chmod 640 /etc/ssl/certs/vsftpd.crt

mv ./vsftpd.conf /etc/vsftpd/vsftpd.conf

vsftpd
