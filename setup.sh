function ready_minikube ()
{
	minikube delete --all
	export MINIKUBE_HOME=~
#	export MINIKUBE_HOME=~/goinfre
	minikube config set memory 2048
	minikube config set disk-size 4096
	minikube start --driver=virtualbox
	eval $(minikube -p minikube docker-env)
	MINIKUBE_IP=$(minikube ip)
}

function build_nginx()
{
	sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/image/nginx/srcs/nginx.conf
	docker build ./srcs/image/nginx -t nginx
	sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/image/nginx/srcs/nginx.conf
}

function build_phpmyadmin()
{
	sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/image/phpmyadmin/srcs/config.inc.php
	docker build ./srcs/image/phpmyadmin -t phpmyadmin
	sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/image/phpmyadmin/srcs/config.inc.php
}

function build_wordpress()
{
	docker build ./srcs/image/wordpress -t wordpress
}

function build_mysql()
{
	sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/image/mysql/srcs/dump_wordpress.sql
	docker build ./srcs/image/mysql -t mysql
	sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/image/mysql/srcs/dump_wordpress.sql
}

function build_metallb()
{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml
	sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/yaml/metallb.yaml
	kubectl apply -f ./srcs/yaml/metallb.yaml
	sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/yaml/metallb.yaml
}

function build_images()
{
	build_nginx
	build_phpmyadmin
	build_wordpress
	build_mysql
}

function build_minikube()
{
	build_metallb
	kubectl apply -f ./srcs/yaml/mysql.yaml
	kubectl apply -f ./srcs/yaml/nginx.yaml
	kubectl apply -f ./srcs/yaml/phpmyadmin.yaml
	kubectl apply -f ./srcs/yaml/wordpress.yaml
}

ready_minikube
build_images
build_minikube
