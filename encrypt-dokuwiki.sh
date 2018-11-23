#!/bin/bash
sudo yum install -y python2-certbot-apache

if ! sudo grep '<VirtualHost \*:80>' /etc/httpd/conf/httpd.config
then
	echo -e '<VirtualHost *:80>\n    ServerAdmin SERVERADMIN\n    ServerName SERVERNAME\n    ServerAlias SERVERALIAS\n    DocumentRoot /var/www/html/wiki\n</VirtualHost>' | sudo tee -a /etc/httpd/conf/httpd.conf
fi

if ! sudo ls /etc/letsencrypt/live/SERVERNAME/fullchain.pem
then
	sudo certbot --apache -d SERVERNAME -n --agree-tos -m SERVERADMIN
fi

sudo systemctl restart httpd
