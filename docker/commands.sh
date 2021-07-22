
#------------------CONTAINERS

#instantiate container from image
# -d runs in detached mode
# -p sets PORT
docker run -d -p <host-port>:<contaner-port> <image-name>
docker run -d -p 3000:3000 app-name
#run container from remote
docker run -d -p 3000:3000 <registry-url>/<image-name>:<version>

#list running containers
docker container list

#list all containers
docker ps

#get logs from container
docker logs <dontainer-id>

#stop a container
docker stop <name/id>

#get port
docker port <name/id>

#stop and remove a container
docker kill <id>
docker rm <id>

#remove all containers
docker container prune

#------------------IMAGES

#build an image
# -t tags image with name
# --file allows to set specific Dockerfile
# . in the end tells to run against current dir
docker build -t app-name --file Dockerfile .

#list images
docker image list

#remove image
# --force removes all instances
docker rmi <image-id> --force

#pull image from remote
docker pull <image-name>

#push image
docker push <uname>/<repo name>:<tagname>