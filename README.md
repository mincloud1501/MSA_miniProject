# MSA_miniProject
Micro Service Architecture mini Project using Kubernetes

## Info
- 목적 : Docker Build & Kubernetes Build
- 구성요소 : Nginx/HtmlCode
- 요건 : Docker Build와 Kubernetes 배포 Script
- Kubernetes 환경 : https://github.com/rootsongjc/kubernetes-vagrant-centos-cluster.git


## Folder Architecture
* DockerScript : ./docker
* KubernetesScript : ./kubernetes


## Pre requisites (Docker QuickStart Deamon에서 실행)
```
$ cd ~/MSA_miniProject
$ mdir docker
$ mkdir kubernetes
$ touch docker/build.sh
$ touch docker/push.sh
$ touch kubernetes/kubProvisioning.sh
$ git config --global user.name "mincloud1501"
$ git config --global user.email "mincloud1501@naver.com"
$ cat .git/config
```

## Usage
* Git Push
```
$ git add -A
$ git commit -m "first"	// Local Repository
$ git push // Remote Repository
```

* Docker File Edit [/docker/build.sh]
```
docker build --rm -t mincloud1501/nginx .
docker run -d --rm --name nginx1 -p 8888:80 mincloud1501/nginx
```
* Docker Build
```
cd ./docker
. build.sh
```
* Docker Check
```
$ docker images
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
mincloud1501/nginx   latest              40f4b6da1e0f        24 seconds ago      109MB

$ docker ps -a
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS                  NAMES
b9c7b72516dc        mincloud1501/nginx   "nginx -g 'daemon of…"   7 seconds ago       Up 7 seconds        0.0.0.0:8888->80/tcp   nginx1

$ docker-machine ip
192.168.99.100
```

[Test Page Connection]
* http://docker-machine ip:8888/

* Docker Hub Push
```
. push.sh
```

* Kubernetes Provisioning

- [kubernetes Node1] 에서 실행
```
[root@node1 ~]# kubectl delete deploy/nginx1; kubectl run nginx1 --image=mincloud1501/nginx --port=80 -o yaml > deploy.yaml

[root@node1 ~]# kubectl create -f deploy.yaml 로 확인
```

```
[root@node1 ~]# kubectl expose deployment/nginx1 --type="NodePort" --port 80 -o yaml > sevice.yaml
```

- [kubProvisioning.sh 편집]
```
#!/bin/bash

kubectl delete deploy/nginx1
kubectl create -f ./deploy.yaml

kubectl delete svc/nginx1
kubectl create -f ./service.yaml
```

[kubProvisioning.sh 실행]
```
[root@node1 ~]#. kubProvisioning.sh
```

# Result
![result](images/result.png)

# MAP
![Map](images/map.png)

## Bugs

Please report bugs to mincloud1501@naver.com

## Contributing

The github repository is at https://github.com/mincloud1501/MSA_miniProject.git

## See Also

Some other stuff.

## Author

J.Ho Moon, <mincloud1501@naver.com>

## Copyright and License

(c) Copyright 1997~2019 by SKB Co. LTD
