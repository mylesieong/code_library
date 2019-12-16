# Docker

## Dashboard
docker images
docker container ls -a
docker ps

## Operations towards Dockerfile
docker build -t {my_name_tag} . //Must be done under same folder with Dockerfile

## Operations towards images
docker run -d --privileged=true {image_id}
docker run -it {image_id} /bin/bash

## Operations towards containers
docker logs {container_id} 
docker logs -f {container_id} 

## Pruning
docker image prune
docker container prune
docker system prune //Includes aboves
