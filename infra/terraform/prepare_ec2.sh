#! /bin/bash
sudo apt update
sudo apt install -y unzip make docker
sudo groupadd docker
sudo usermod -aG docker $USER
sudo iptables -t filter -F
sudo iptables -t filter -X
sudo systemctl restart docker
sudo apt install -y docker-compose
