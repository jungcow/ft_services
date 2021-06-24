#! /bin/bash

# Copy nginx.conf to /etc/nginx/
mkdir -p /run/nginx

wget https://wordpress.org/latest.tar.gz
tar -xvf latest.tar.gz
rm -rf latest.tar.gz
mkdir -p /var/www/html
mv wordpress/ /var/www/html/

#chmod -R 0777 /var/www

echo '$?': $?
mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

sed -i "s/database_name_here/wordpress/" /var/www/html/wordpress/wp-config.php
sed -i "s/username_here/admin/" /var/www/html/wordpress/wp-config.php
sed -i "s/password_here/1234/" /var/www/html/wordpress/wp-config.php
sed -i "s/localhost/mysql/" /var/www/html/wordpress/wp-config.php

echo '$?': $?
php-fpm7 && nginx -g "daemon off;"
