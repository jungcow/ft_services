#!/bin/bash

mkdir -p /run/mysqld

# For Starting mysql server(Initialization)
/usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start mysql server
mysqld -u root &

# Check mysql server started
# Because it takes time to get started
echo "SELECT 1" | mysql -u root --skip-password > /dev/null 2>&1
until [ $? -ne "1" ]
do
    echo "아직 안켜졌어요"
    sleep 2
    echo "SELECT 1" | mysql -u root --skip-password > /dev/null 2>&1
done

# Create tables
mysql -u root --skip-password < /phpmyadmin.sql
mysql -u root --skip-password < /wordpress.sql
mysql -u root --skip-password < /dump_wordpress.sql

# For Restarting server
mysqladmin -u root shutdown
mysqld -u root
