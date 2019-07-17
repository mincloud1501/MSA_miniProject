#!/bin/bash



docker build --rm -t mincloud1501/nginx .
docker run -d --name nginx1 -p 8888:80 mincloud1501/nginx
# curl http://docker-machine ip:8888
docker stop nginx1