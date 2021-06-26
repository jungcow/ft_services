#! /bin/bash

# Prepare
mkdir -p /run/nginx
mkdir -p /usr/share/webapps/
mkdir -p /var/www/html
mv /nginx.conf /etc/nginx

# install phpMyAdmin

wget https://files.phpmyadmin.net/phpMyAdmin/4.9.7/phpMyAdmin-4.9.7-all-languages.tar.gz

tar -xvf phpMyAdmin*
rm -rf *.tar.gz 
mv phpMyAdmin* /usr/share/webapps/

mv /usr/share/webapps/phpMyAdmin* /usr/share/webapps/phpmyadmin

chmod -R 777 /usr/share/webapps/

ln -s /usr/share/webapps/phpmyadmin/ /var/www/html/phpmyadmin

mv /config.inc.php /var/www/html/phpmyadmin/

php-fpm7 && nginx -g 'daemon off;'
