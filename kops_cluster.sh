#!/bin/bash

kops create cluster \
  --name=kops.infordigi.tk \
  --state=s3://kops.infordigi.tk
  --authorization RBAC \
  --zones=us-east-2a \
  --node-count=2 \
  --node-size=t2.micro \
  --master-size=t2.micro \
  --master-count=1 \
  --dns-zone=kops.infordigi.tk \
  --out=devopsinuse_terraform \
  --target=terraform \
  --ssh-public-key=~/.ssh/devopsinuse_key.pub