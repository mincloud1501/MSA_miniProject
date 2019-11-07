# MSA_miniProject
Micro Service Architecture mini Project using Kubernetes

☞ 하기 모든 내용의 출처는 [![Sources](https://img.shields.io/badge/출처-Kubernetes-yellow)](https://kubernetes.io/ko/docs/home/)

## Kubernetes v.1.16
- Kubernetes is a portable, extensible, open-source platform for managing containerized workloads(Pods, Replicaset..) and services. (쿠버네티스는 컨테이너화된 워크로드와 서비스를 관리하기 위한 이식성이 있고, 확장가능한 오픈소스 플랫폼이다.)

[Kubernetes Architecture & Ecosystem] [![Sources](https://img.shields.io/badge/출처-learnitguide-yellow)](https://www.learnitguide.net/2018/08/what-is-kubernetes-learn-kubernetes.html) [![Sources](https://img.shields.io/badge/출처-magalix-yellow)](https://www.magalix.com/blog/kubernetes-101-concepts-and-why-it-matters)

![Kubernetes](images/kubernetes.png)

## Info
- 목적 : Docker Build & Kubernetes Build & Provisioning
- 구성요소 : Nginx, Html Code
- 요건
	- VM과 Container의 개념을 정확히 이해하고 있어야 합니다.
	- Docker Build와 Kubernetes 배포 Script
	- 개인 PC 사양 최소 16GB Memory, VirtualBox v.5.2.20 or later
- Kubernetes 환경 (출처)
<div><a href="https://github.com/rootsongjc/kubernetes-vagrant-centos-cluster.git"><img src="https://www.dennyzhang.com/wp-content/uploads/sns/github.png" alt="github" /></a></div>

- 사전 준비 사항 : Kubernetes에 대한 이해
	- [![Sources](https://img.shields.io/badge/출처-Kubernetes-yellow)](https://kubernetes.io/ko/docs/home/)
	- [![Sources](https://img.shields.io/badge/출처-katacoda-yellow)](https://www.katacoda.com/courses/kubernetes)
		- Launch A Single Node Cluster
		- Launch a multi-node cluster using Kubeadm
		- Deploy Containers Using Kubectl
		- Deploy Containers Using YAML
		- Getting Started with Kubeless
		-...

## Folder Architecture
* DockerScript : ./docker
* KubernetesScript : ./kubernetes

## Prerequisites (Docker QuickStart Deamon에서 실행)
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

*http://docker-machine ip:8888*

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

---

### ■ Component (Master/Node)

![Kubernetes_Architecture](images/kubernetes_architecture.jpg)

#### Master Component

`kube-apiserver`

- API 서버는 k8s API를 노출하는 k8s Control plane component의 Frontend
- kube-apiserver는 수평으로 확장되도록 디자인되어 더 많은 instance를 배포해서 확장/실행/인스턴스간 트래픽을 조절 기능

`kube-scheduler`

- node가 배정되지 않은 새로 생성된 pod를 감지하고, 구동될 node를 선택하는 master component
- 스케줄링 결정을 위해서 고려되는 요소는 리소스에 대한 개별 및 총체적 요구 사항, 하드웨어/소프트웨어/정책적 제약, affinity 및 anti-affinity 명세, 데이터 지역성, 워크로드-간 간섭, 데드라인을 포함

`kube-controller-manager`

- controller를 구동하는 master component
- 논리적으로, 각 controller는 개별 process이지만, 복잡성을 낮추기 위해 모두 단일 binary로 compile되고 단일 process 내에서 실행
	- node controller : node가 down되었을 때 통지와 대응에 관한 책임
	- replication controller : 시스템의 모든 replication controller object에 대해 알맞는 수의 pod들을 유지
	- endpoint controller : endpoint object를 채운다 (service와 pod를 연결)
	- service account & token controller : 새로운 namespace에 대한 기본 계정과 API access token을 생성

`etcd`

- 모든 cluster data를 담는 k8s backend 저장소로 사용되는 일관성·고가용성 key-value 저장소

`cloud-controller-manager`

- cloud 제공 사업자와 상호작용하는 controller를 작동
- cloud-controller-manager binary는 k8s release 1.6에서 도입된 alpha 기능
- cloud vendor code와 k8s code가 서로 독립적으로 발전시켜 나갈 수 있도록 해준다.

#### Node Component

`kubelet`

- cluster의 각 node에서 실행되는 agent. Kubelet은 pod에서 container가 확실하게 동작하도록 관리
- Kubelet은 k8s를 통해 생성되지 않는 container는 관리하지 않는다.

`kube-proxy`

- kube-proxy는 cluster의 각 node에서 실행되는 network proxy로, k8s의 service 개념의 구현부
- node의 network 규칙을 유지 관리하며 이 네트워크 규칙이 내부 network session이나 cluster 외부에서 pod로 network 통신을 할 수 있도록 해준다.

`container runtime`

- container 실행을 담당하는 software
- k8s 여러 container runtime 지원 (Docker,containerd,cri-o,rktlet,Kubernetes CRI를 구현한 모든 software)

![Kubernetes_Cluster](images/cluster.png)

![Kubernetes_Deploy](images/deploy.png)

---

### ■ Object

- k8s object는 k8s system에서 영속성을 가지는 개체로 k8s는 cluster의 status를 나타내기 위해 이 개체를 이용
	- 어떤 컨테이너화된 application이 동작 중인지 (그리고 어느 node에서 동작 중인지)
	- 그 application이 이용할 수 있는 resource
	- 그 application이 어떻게 재구동 정책, upgrade, 그리고 내고장성과 같은 것에 동작해야 하는지에 대한 정책

- object를 생성하게 되면, k8s는 그 object 생성을 보장하기 위해 지속적으로 작동
- 생성/수정/삭제를 위해 k8s object를 동작시키려면, 쿠버네티스 API를 이용해야 한다. kubectl CLI를 이용할 때, 필요한 k8s API를 호출

[k8s deployment를 위한 요청 필드와 object spec을 보여주는 .yaml 파일 예시]

```yaml
apiVersion: apps/v1 # apps/v1beta2를 사용하는 1.9.0보다 더 이전의 버전용
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2 # 템플릿에 매칭되는 파드 2개를 구동하는 디플로이먼트임
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
```

---

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
