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


function build_metallb()
{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml
#	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	sed -i '' "s/MINIKUBE_IP/$MINIKUBE_IP/g" ./srcs/yaml/metallb.yaml
	kubectl apply -f ./srcs/yaml/metallb.yaml
	sed -i '' "s/$MINIKUBE_IP/MINIKUBE_IP/g" ./srcs/yaml/metallb.yaml
}

function build_images()
{
	docker build ./srcs/image/phpmyadmin -t phpmyadmin
	docker build ./srcs/image/wordpress -t wordpress
	docker build ./srcs/image/mysql -t mysql
}

function build_minikube()
{
	build_metallb
	kubectl apply -f ./srcs/yaml/nginx.yaml
	kubectl apply -f ./srcs/yaml/mysql.yaml
	kubectl apply -f ./srcs/yaml/phpmyadmin.yaml
	kubectl apply -f ./srcs/yaml/wordpress.yaml
}

ready_minikube
build_nginx
build_images
build_minikube
