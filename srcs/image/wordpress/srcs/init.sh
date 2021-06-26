#! /bin/bash

# Copy nginx.conf to /etc/nginx/
mkdir -p /run/nginx

mv /nginx.conf /etc/nginx

wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
rm -rf latest.tar.gz

mkdir -p /var/www/html

mv wordpress/ /var/www/html/

chmod -R 0777 /var/www

rm -rf /var/www/html/wordpress/wp-config-sample.php
mv /wp-config.php /var/www/html/wordpress/


php-fpm7 && nginx -g "daemon off;"
