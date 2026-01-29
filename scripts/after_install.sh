#!/bin/bash

# 1. Встановлюємо необхідні інструменти (щоб все працювало стабільно)
sudo apt-get update
sudo apt-get install -y unzip curl

# Встановлюємо AWS CLI v2 (якщо ще не встановлено або оновлюємо)
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -o awscliv2.zip
sudo ./aws/install --update

# 2. Зупиняємо старий контейнер
docker stop my-nodejs-app || true
docker rm my-nodejs-app || true

# 3. Логінимось в ECR (Ваш ID: 137568342949)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 137568342949.dkr.ecr.us-east-1.amazonaws.com

# --- ГОЛОВНА ЗМІНА ТУТ ---
# 4. ПРИМУСОВО скачуємо нову версію образу
docker pull 137568342949.dkr.ecr.us-east-1.amazonaws.com/my-nodejs-app:latest
# -------------------------

# 5. Запускаємо новий контейнер
docker run -d --name my-nodejs-app -p 80:8080 137568342949.dkr.ecr.us-east-1.amazonaws.com/my-nodejs-app:latest