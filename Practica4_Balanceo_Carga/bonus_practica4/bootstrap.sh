#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST

sudo apt update && apt upgrade -y


sudo apt-get install apache2 -y
sudo systemctl enable apache2
sudo rm /var/www/html/index.html
touch index.html
echo "<html><body><h1>Hello from web</h1></body></html>" >> index.html
sudo cp index.html  /var/www/html
sudo systemctl restart apache2
sudo service apache2 start