#!/bin/bash

kubectl delete deploy/nginx1
kubectl create -f ./deploy.yaml

kubectl delete svc/nginx1
kubectl create -f ./service.yaml