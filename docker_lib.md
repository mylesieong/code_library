# Docker

## Dashboard
* docker images
* docker container ls -a
* docker ps

## Operations towards Dockerfile
* docker build -t {my_name_tag} . //Must be done under same folder with Dockerfile

## Operations towards images
* docker run -d --privileged=true {image_id}
* docker run -it {image_id} /bin/bash

## Operations towards containers
* docker logs {container_id}  # dump the logs but not following
* docker logs -f {container_id}  # dump and follow logs
* docker stop {container_id}
* docker kill {container_id}
* docker exec -it {container_id} /bin/bash   # login to a daemon container

## Pruning
* docker image prune
* docker container prune
* docker system prune //Includes aboves

## Dockerfile keywords
* CMD: a command that is run when the container first started. Can be override if container is started with command line
* ENTRYPOINT: now i am using it to run entrypoint.sh. Note that if ENTRYPOINT is a script that is finite, and you set the container to be a restarting daemon, it will restart again and again
* USER: state what is the user when we enter the container. Note the rest of the Dockerfile is still run as root's perspective and has nothing to do with what is in USER

## Compose yml
* CMD counter part: command
* ENTRYPOINT counter part: entrypoint
