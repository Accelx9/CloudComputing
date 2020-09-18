#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST
echo "Install vsftpd"
sudo apt-get install vsftpd -y
echo “Modificando vsftpd.conf con sed”
sed -i 's/#write_enable=YES/write_enable=YES/g' /etc/vsftpd.conf
echo "configurando ip forwarding con echo"
sudo echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo echo "ftpd_banner=Bienvenido a Servicio FTP" >> /etc/vsftpd.conf
sed -i 's/ssl_enable=NO/ssl_enable=YES/g' /etc/vsftpd.conf

echo "Change the Banner"

sed -i 's/#ftpd_banner=Welcome to blah FTP service./ftpd_banner=Bienvenido al server ftp gg./g' /etc/vsftpd.conf

echo "User Creation"

sudo adduser accel --gecos "accel,1234 ,1234 ,1234 " --disabled-password
echo "accel:password" | sudo chpasswd

echo "Install lxd"


sudo snap install lxd 
sudo newgrp lxd
sudo lxd init --auto
sudo lxc launch ubuntu:18.04 webi 
echo "Install and restart apache2 inside the lxc container" 

sudo lxc exec webi -- apt-get install apache2 -y
sudo lxc exec webi -- systemctl restart apache2


echo "Personalizando sitio"
lxc exec webi -- ls /var/www/html
nano index.html 
cat <<TEST> index.html 

<!DOCTYPE html>
<html>
<body>
<h1>Contenedorcito</h1>
<p>Prueba funcionando</p>
</body>
</html>

TEST

lxc file push index.html webi/var/www/html/index.html
lxc exec webi -- systemctl restart apache2

echo "Configure the lxc device"

sudo lxc config device add webi portesito80 proxy listen=tcp:192.168.100.5:5087 connect=tcp:127.0.0.1:80