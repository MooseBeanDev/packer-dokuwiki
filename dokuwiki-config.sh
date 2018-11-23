#!/bin/bash
sudo sed -i s/GITDOMAIN/$GIT_DOMAIN/g /home/centos/sshconfig

sudo cp /home/centos/sshconfig /home/centos/.ssh/config
sudo chmod 0400 /home/centos/.ssh/config
sudo chown centos:centos /home/centos/.ssh/config

sudo cp /home/centos/sshconfig /root/.ssh/config
sudo chmod 0400 /root/.ssh/config
sudo chown root:root /root/.ssh/config

sudo chmod 0400 /home/centos/gitkey
sudo chown centos:centos /home/centos/gitkey

sudo chmod 755 /scripts/*
sudo chown centos:centos /scripts/*

if [[ $GIT_INITIALIZED = "true" ]]
then
	/scripts/git-clone.sh $GIT_PROJECT
else
	/scripts/git-init.sh $GIT_PROJECT
fi

sudo chown -R apache:apache /var/www/html/wiki
sudo chmod 755 -R /var/www/html/wiki
sudo chmod 700 -R /var/www/html/wiki/data
sudo chmod 700 -R /var/www/html/wiki/conf

if ! sudo grep '/var/www/html/wiki' /etc/httpd/conf/httpd.conf
then echo -e '<Directory "/var/www/html/wiki">\n    Options FollowSymLinks\n    AllowOverride All\n    Require all granted\n</Directory>' | sudo tee -a /etc/httpd/conf/httpd.conf
fi

sudo sed -i s/SERVERADMIN/$SERVER_ADMIN/g /scripts/encrypt-dokuwiki.sh
sudo sed -i s/SERVERNAME/$SERVER_NAME/g /scripts/encrypt-dokuwiki.sh
sudo sed -i s/SERVERALIAS/$SERVER_ALIAS/g /scripts/encrypt-dokuwiki.sh
