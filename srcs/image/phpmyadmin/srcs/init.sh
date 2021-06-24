#! /bin/bash

# Prepare
mkdir -p /run/nginx
mkdir -p /var/www/html

# install phpMyAdmin
mkdir -p /usr/share/webapps/

cd /usr/share/webapps
wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz

tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz
rm phpMyAdmin-5.0.2-all-languages.tar.gz
mv phpMyAdmin-5.0.2-all-languages phpmyadmin

chmod -R 777 /usr/share/webapps/

ln -s /usr/share/webapps/phpmyadmin/ /var/www/html/phpmyadmin
mv config.inc.php /var/www/html/phpmyadmin/
rm -rf /var/www/html/phpmyadmin/config-sample.inc.php

echo "Run php-fpm7 & nginx -g 'daemon off;'"
php-fpm7 && nginx -g 'daemon off;'
