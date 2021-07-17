#docker compose is a script that specifies how to compose the app from multiple docker containers

#from dir with docker-compose.yml
# up starts the container from the built image
# --build forces to rebuild the container against latest image
docker-compose up --build

#show a list of running containers
#ONLY those specified in docker compose file
docker-compose ps

#stop the app but not remove the contaienrs
docker-compose stop

#stop and remove the containers
docker-compose down

#restart the apps
docker compose down && docker-compose up --build

#up and log into a file
 # 2>&1 redirects standart output and standart error
 # | redirects output to the command on the right 
 # tee copies ints input into terminal and file
docker-compose up --build 2>&1 | tee debug.log
