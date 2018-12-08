#!/bin/bash
cd /var/www/html/wiki && sudo git pull
sudo chown -R apache:apache /var/www/html/wiki
sudo chmod 755 -R /var/www/html/wiki
sudo chmod 700 -R /var/www/html/wiki/data
sudo chmod 700 -R /var/www/html/wiki/conf
