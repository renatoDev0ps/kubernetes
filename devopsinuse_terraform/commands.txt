#!/bin/bash
# ******************************************************
# Installing Nginx on Ubuntu/Centos - on bare metal
# ******************************************************

# setup repositories
apt install nginx
yum install nginx

# ******************************************************
# Deploying Nginx to our kubernetes cluster on AWS
# (Docker Containers)
# ******************************************************

# How to proceed deployment on k8s
kubectl \
  create deployment y-nginx-deployment \
  --image=nginx

# How to expose deployment via service
kubectl \
  expose deployment y-nginx-deployment \
  --port=80 \
  --type=NodePort \
  --name=my-nginx-service