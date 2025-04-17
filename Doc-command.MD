
docker info
docker search centos
docker run -it centos bin/bash
docker commit -m "What did you do to the image" -a "Author Name" container-id repository/new_image_name
docker commit -m "added maria nd git" -a "pandian" e8e285951825 dockerpandian/centos-mariadb:v1
docker images
docker login -u dockerpandian

docker exec -it <CONTAINER ID > bin/bash



docker build -t dir_containing_dockerfile .  # Create image using this directory's Dockerfile
docker run -p 4000:80 container_name # Run "friendlyname" mapping port 4000 to 80
docker run -d -p 4000:80 friendlyname         # Same thing, but in detached mode
docker ps                                 # See a list of all running containers
docker stop <hash>                     # Gracefully stop the specified container
docker ps -a           # See a list of all containers, even the ones not running
docker kill <hash>                   # Force shutdown of the specified container
docker rm <hash>              # Remove the specified container from this machine
docker rm $(docker ps -a -q)           # Remove all containers from this machine
docker images -a                               # Show all images on this machine
docker rmi <imagename>            # Remove the specified image from this machine
docker rmi $(docker images -q)             # Remove all images from this machine
docker login             # Log in this CLI session using your Docker credentials
docker tag <imageID> username/repository:tag  # Tag <image> for upload to registry
docker push username/repository:tag            # Upload tagged image to registry
docker run username/repository:tag                   # Run image from a registry

docker inspect <container-id>

docker export loving_morse > mybuild4.tar 

docker import mybuild4.tar mybuild:importv5

docker login --username=dockerpandian



docker run --help | grep memory
docker run --help | grep cpu

docker run -d --name nginx --memory "200mb" nginx-alphine 
docker run -d --name nginx --memory "200mb" --cpuset-cpu 0,1 nginx-alphine 


```
ctl + p + q  // command to come out from the container without exit
```
