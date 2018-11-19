#!/bin/bash
CONN_STR=$1

cd /var/www/html/wiki && sudo git init && sudo git remote add origin "git@gitserv:$CONN_STR" && sudo git add . && sudo git commit -m "Wiki updated from $HOSTNAME" && sudo git push -u origin master
