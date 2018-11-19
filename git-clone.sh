#!/bin/bash
CONN_STR=$1
cd /var/www/html && sudo git clone "git@gitserv:$CONN_STR" wiki
