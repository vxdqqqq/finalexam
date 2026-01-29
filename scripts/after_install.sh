#!/bin/bash

# Встановлюємо AWS CLI, якщо його немає (це виправить помилку)
apt-get update && apt-get install -y awscli

# Зупиняємо старий застосунок
docker stop my-nodejs-app || true
docker rm my-nodejs-app || true

# Логін
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 137568342949.dkr.ecr.us-east-1.amazonaws.com

# Запуск
docker run -d --name my-nodejs-app -p 80:8080 137568342949.dkr.ecr.us-east-1.amazonaws.com/my-nodejs-app:latest