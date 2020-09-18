#!/bin/bash
echo "Update and upgrade the image"
sudo apt-get update && apt-get upgrade -y
echo "Install apache2"
sudo apt-get install apache2 -y
echo "Create index.html"

cat <<TEST> index.html 

<!DOCTYPE html>
<html>
<body>
<h1>Contenedorcito</h1>
<p>Holi desde web1 uwu</p>
</body>
</html>

TEST

echo "Replace index.html file"
lxc file push index.html webi/var/www/html/index.html

sudo systemctl restart apache2
sudo systemctl enable apache2
exit

sudo lxc exec webi2 /bin/bash 
sudo apt-get update && apt-get upgrade -y
sudo apt-get install apache2 -y

cat <<TEST> index.html 

<!DOCTYPE html>
<html>
<body>
<h1>Contenedorcito</h1>
<p>Holi desde web2 uwu gg wawee</p>
</body>
</html>

TEST

lxc file push index.html webi/var/www/html/index.html
exit

sudo systemctl restart apache2
sudo systemctl enable apache2

sudo lxc launch ubuntu:18.04 haproxy
sudo lxc exec haproxy /bin/bash

sudo apt update && apt upgrade -y
sudo apt install haproxy -y
sudo systemctl enable haproxy -y
echo "backend web-backend
balance roundrobin
stats enable
stats auth admin:admin
stats uri /haproxy?stats
server web1 240.101.0.172:80 check
server web2 240.102.0.58:80 check
frontend http
bind *:80
default_backend web-backend"  >> archivo.txt

systemctl start haproxy
lxc config device add haproxy http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80

webi1  10.74.21.140
webi2  10.74.21.24