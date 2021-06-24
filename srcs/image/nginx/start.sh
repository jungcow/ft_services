docker stop $(docker ps -f "ancestor=nginx" -aq);
docker rm $(docker ps -f "ancestor=nginx" -aq);
docker build . -t nginx
docker run -d -p 80:80 -p 443:443 nginx

