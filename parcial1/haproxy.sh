#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST
echo "Start container"
sudo lxc start haproxy
echo "Enter in the container"


echo "Update and upgrade the image"
lxc exec haproxy -- sudo apt-get update && apt-get upgrade -y
lxc exec haproxy -- sudo apt-get autoremove -y
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
lxc exec haproxy -- sudo apt-get install haproxy -y
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
echo "Install haproxy"
echo "Enable haproxy"
lxc exec haproxy -- sudo systemctl enable haproxy

echo "backend web-backend"
touch haproxy.cfg
cat <<TEST> haproxy.cfg 
global
	log /dev/log	local0
	log /dev/log	local1 notice
	chroot /var/lib/haproxy
	stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
	stats timeout 30s
	user haproxy
	group haproxy
	daemon

	# Default SSL material locations
	ca-base /etc/ssl/certs
	crt-base /etc/ssl/private

	# Default ciphers to use on SSL-enabled listening sockets.
	# For more information, see ciphers(1SSL). This list is from:
	#  https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
	# An alternative list with additional directives can be obtained from
	#  https://mozilla.github.io/server-side-tls/ssl-config-generator/?server=haproxy
	ssl-default-bind-ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS
	ssl-default-bind-options no-sslv3

defaults
    log    global
    mode    http
    option    httplog
    option    dontlognull
        timeout connect 5000
        timeout client  50000
        timeout server  50000
    errorfile 400 /etc/haproxy/errors/400.http
    errorfile 403 /etc/haproxy/errors/403.http
    errorfile 408 /etc/haproxy/errors/408.http
    errorfile 500 /etc/haproxy/errors/500.http
    errorfile 502 /etc/haproxy/errors/502.http
    errorfile 503 /etc/haproxy/errors/503.http
    errorfile 504 /etc/haproxy/errors/504.http


backend web-backend
   balance roundrobin
   stats enable
   stats auth admin:admin
   stats uri /haproxy?stats

   server web1 240.8.0.209:80 check
   server web2 240.9.0.89:80 check
   server web3 240.8.0.112:80 check backup
   server web4 240.9.0.118:80 check backup

frontend http
  bind *:80
  default_backend web-backend
TEST
sudo lxc file push haproxy.cfg haproxy/etc/haproxy/haproxy.cfg
touch 503.http
cat <<TEST> 503.http
HTTP/1.0 503 Service Unavailable
Cache-Control: no-cache
Connection: close
Content-Type: text/html

<html><body><h1>503 Service Unavailable</h1>
<p>Sorry for the inconvenients the server is not working right now :'c. Please come back</p><img src="https://images3.alphacoders.com/999/thumb-350-999707.png" width="640"></body$




TEST
sudo lxc file push 503.http haproxy/etc/haproxy/errors/503.http
lxc exec haproxy -- systemctl start haproxy
lxc exec haproxy -- systemctl restart haproxy


lxc config device add haproxy http proxy listen=tcp:0.0.0.0:80 connect=tcp:127.0.0.1:80
lxc config device add haproxy http2 proxy listen=tcp:192.168.100.7:5080 connect=tcp:127.0.0.1:80
