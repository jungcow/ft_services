#!/bin/bash

mkdir -p /run/mysqld

# For Starting mysql server(Initialization)
/usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start mysql server
mysqld -u root &

# Check mysql server started
# Because it takes time to get started
while :
do
	if [ `echo $?;` -ne 1 ]; then
		break
	fi
	echo "Not started yet!"
	sleep 1
done

# Create tables
mysql < /phpmyadmin.sql
mysql < /wordpress.sql

# For Restarting server
mysqladmin -u root shutdown
mysqld -u root
