#!/bin/bash
sudo apt update
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
echo "<h1>welcome to Terraform</h1>" | sudo tee /var/www/html/index.html