#!/bin/bash
FILE_CHANGED=`cd /var/www/html/wiki && git status --porcelain 2>/dev/null| egrep "^(M| M)" | wc -l`
FILE_CREATED=`cd /var/www/html/wiki && git status --porcelain 2>/dev/null| grep "^??" | wc -l`

if [ "$FILE_CHANGED" -gt 0 ] || [ "$FILE_CREATED" -gt 0 ]
then
        echo "Executing git stuff."
        cd /var/www/html/wiki && sudo git add . && sudo git commit -m "Wiki updated from $HOSTNAME" && sudo git push -u origin master
else
	echo "Nothing to backup."
fi
