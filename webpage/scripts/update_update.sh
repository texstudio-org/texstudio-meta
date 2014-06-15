#!/bin/bash
if [[ "$1" = "" ]]; then echo "need version number"; exit; fi
sed -e "s/stable *value=\".*\"/stable value=\"$1\"/" -i update/txsUpdate.xml

SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi

rsync -v -e ssh update/txsUpdate.xml "$SFUSER,texstudio@web.sourceforge.net:/home/groups/t/te/texstudio/htdocs/update"


hg commit -m "update update to $1" 
hg push

