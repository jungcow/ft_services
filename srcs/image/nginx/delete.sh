docker stop $(docker ps -f "ancestor=nginx" -aq);
docker rm $(docker ps -f "ancestor=nginx" -aq);
