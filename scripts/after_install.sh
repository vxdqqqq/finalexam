#!/bin/bash

# 1. Встановлюємо unzip (потрібен для розпаковки інсталятора)
sudo apt-get update
sudo apt-get install -y unzip curl

# 2. Скачуємо та встановлюємо офіційний AWS CLI v2 (це працює скрізь)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -o awscliv2.zip
sudo ./aws/install --update

# 3. Зупиняємо старий контейнер (ігноруємо помилки, якщо це перший запуск)
docker stop my-nodejs-app || true
docker rm my-nodejs-app || true

# 4. Логінимось в ECR (Ваш ID: 137568342949)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 137568342949.dkr.ecr.us-east-1.amazonaws.com

# 5. Запускаємо новий контейнер
docker run -d --name my-nodejs-app -p 80:8080 137568342949.dkr.ecr.us-east-1.amazonaws.com/my-nodejs-app:latest