# MSA_miniProject
MSA mini Project using Kubernetes

## Info
- 목적 : Docker Build & Kubernetes Build
- 구성요소 : Nginx/HtmlCode
- 요건 : Docker Build와 Kubernetes 배포 Script

## Folder Architecture
* DockerScript : ./docker
* KubernetesScript : ./kubernetes

## Pre requisites
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
```

* Docker Build
```
cd ./docker
. build.sh
```

* Docker Hub Push
```
. push.sh
```

* Kubernetes Provisioning
```
cd ./Kubernetes
. kubProvisioning.sh
```