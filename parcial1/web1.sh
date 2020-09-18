#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST
echo "We configure the main web container"
echo "Start container"
sudo lxc start web1
echo "Enter in the container"

lxc exec web1 -- sudo apt update && apt upgrade -y

echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
lxc exec web1 -- sudo apt-get install apache2 -y
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
lxc exec web1 -- sudo systemctl enable apache2
touch index1.html;
echo "<html><body><h1>Hello from web1 :3</h1>
<img src="https://thumbs.gfycat.com/AgitatedJubilantConure.webp" width="640"></body></html>" > index1.html
sudo lxc file push index1.html web1/var/www/html/index.html
lxc exec web1 -- sudo systemctl restart apache2
lxc exec web1 -- sudo service apache2 restart


echo "We configure the backup container"

echo "Start backup container"
sudo lxc start web3
echo "Enter in the container"


echo "Update and upgrade the image"
lxc exec web3 -- sudo apt update && apt upgrade -y
echo "Install apache2 service"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
lxc exec web3 -- sudo apt-get install apache2 -y
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Apache2 configuration"
lxc exec web3 -- sudo systemctl enable apache2
lxc exec web3 -- sudo rm /var/www/html/index.html
touch index3.html
echo "<html><body><h1>Hello from web1 backup container :3</h1>
<img src="https://thumbs.gfycat.com/AgitatedJubilantConure.webp" width="640"></body></html>" > index3.html
sudo lxc file push index3.html web3/var/www/html/index.html
lxc exec web3 -- sudo systemctl restart apache2
lxc exec web3 -- sudo service apache2 restart
