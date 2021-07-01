
# For New minikube Cluster
function ready_minikube ()
{
	minikube delete --all
	export MINIKUBE_HOME=~/goinfre
	minikube config set memory 2048
	minikube config set disk-size 4096
	minikube start --driver=virtualbox
	eval $(minikube -p minikube docker-env)
	MINIKUBE_IP=$(minikube ip)
}

###############################################################################
##############################      Nginx      ################################
###############################################################################
function build_nginx()
{
	sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/image/nginx/srcs/nginx.conf
	docker build ./srcs/image/nginx -t nginx
	sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/image/nginx/srcs/nginx.conf
}

###############################################################################
##############################    Phpmyadmin   ################################
###############################################################################
function build_phpmyadmin()
{
	sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/image/phpmyadmin/srcs/config.inc.php
	docker build ./srcs/image/phpmyadmin -t phpmyadmin
	sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/image/phpmyadmin/srcs/config.inc.php
}

###############################################################################
##############################    Wordpress    ################################
###############################################################################
function build_wordpress()
{
	docker build ./srcs/image/wordpress -t wordpress
}

###############################################################################
##############################      MySQL      ################################
###############################################################################
function build_mysql()
{
	sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/image/mysql/srcs/dump_wordpress.sql
	docker build ./srcs/image/mysql -t mysql
	sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/image/mysql/srcs/dump_wordpress.sql
}

###############################################################################
##############################     Metallb     ################################
###############################################################################
function build_metallb()
{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml
	sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/yaml/metallb.yaml
	kubectl apply -f ./srcs/yaml/metallb.yaml
	sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/yaml/metallb.yaml
}

###############################################################################
##############################      ftps       ################################
###############################################################################
function build_ftps()
{
	sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/image/ftps/srcs/vsftpd.conf
	docker build ./srcs/image/ftps -t ftps
	sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/image/ftps/srcs/vsftpd.conf
}

###############################################################################
##############################    influxDB     ################################
###############################################################################
function build_influxdb()
{
	kubectl create secret generic influxdb-secret \
		--from-literal=INFLUX_CONFIG_PATH=/etc/influxdb/influxdb.conf \
		--from-literal=INFLUXDB_DATABASE=telegraf \
		--from-literal=INFLUXDB_USERNAME=admin \
		--from-literal=INFLUXDB_PASSWORD="1234" \
		--from-literal=INFLUXDB_HOST=influxdb
	docker build ./srcs/image/influxdb -t influxdb
}

###############################################################################
##############################     Grafana     ################################
###############################################################################
function build_grafana()
{
	docker build ./srcs/image/grafana -t grafana
}

###############################################################################
##############################    Telegraf     ################################
###############################################################################
function build_telegraf()
{
	docker build ./srcs/image/telegraf -t telegraf
}

function build_images()
{
	build_nginx
	build_phpmyadmin
	build_wordpress
	build_mysql
	build_ftps
	build_influxdb
	build_grafana
	build_telegraf
}

function build_minikube()
{
	build_images
	build_metallb
	kubectl apply -f ./srcs/yaml/mysql.yaml
	kubectl apply -f ./srcs/yaml/nginx.yaml
	kubectl apply -f ./srcs/yaml/phpmyadmin.yaml
	kubectl apply -f ./srcs/yaml/wordpress.yaml
	kubectl apply -f ./srcs/yaml/ftps.yaml
	kubectl apply -f ./srcs/yaml/influxdb.yaml
	kubectl apply -f ./srcs/yaml/grafana.yaml
	kubectl apply -f ./srcs/yaml/telegraf.yaml
}

ready_minikube
build_minikube
minikube dashboard
