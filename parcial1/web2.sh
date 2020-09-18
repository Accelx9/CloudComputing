#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST
echo "We configure the main web container"
echo "Start container"
sudo lxc start web2
echo "Enter in the container"
lxc exec web2 -- sudo apt update && apt upgrade -y


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
lxc exec web2 -- sudo apt-get install apache2 -y
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"sudo systemctl enable apache2
lxc exec web2 -- sudo rm /var/www/html/index.html
touch index2.html
echo "<html><body><h1>Hello from web2 :3</h1><img src="https://i.imgur.com/tQiuPW4.gif" width="640"></body></html>" > index2.html
sudo lxc file push index2.html web2/var/www/html/index.html
lxc exec web2 -- sudo systemctl restart apache2
lxc exec web2 -- sudo service apache2 start


echo "We configure the backup container"

echo "Start backup container"
sudo lxc start web4
echo "Enter in the container"


echo "Update and upgrade the image"
lxc exec web4 -- sudo apt update && apt upgrade -y
lxc exec web4 -- echo "Install apache2 service"
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
lxc exec web4 -- sudo apt-get install apache2 -y
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Install Apache2"
echo "Apache2 configuration"
lxc exec web4 -- sudo systemctl enable apache2
lxc exec web4 -- sudo rm /var/www/html/index.html
touch index4.html
echo "<html><body><h1>Hello from web2 backup container :3</h1><img src="https://i.imgur.com/tQiuPW4.gif" width="640"></body></html>" > index4.html
sudo lxc file push index4.html web4/var/www/html/index.html
lxc exec web4 -- sudo systemctl restart apache2
lxc exec web4 -- sudo service apache2 start


