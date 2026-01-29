#!/bin/bash

docker stop my-nodejs-app || true
docker rm my-nodejs-app || true

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 137568342949.dkr.ecr.us-east-1.amazonaws.com

docker run -d --name my-nodejs-app -p 80:8080 137568342949.dkr.ecr.us-east-1.amazonaws.com/my-nodejs-app:latest