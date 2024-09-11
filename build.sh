#!/usr/bin/env bash

# get commit hash
TAG=$(git rev-parse HEAD)

docker build -t hmada15/eks-webapp:${TAG} --platform linux/amd64 ./webapp

docker tag hmada15/eks-webapp:${TAG} hmada15/eks-webapp:latest

docker push hmada15/eks-webapp:${TAG}
