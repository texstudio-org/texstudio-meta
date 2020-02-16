#/bin/bash

SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi

rsync -v -e ssh index.html legal.html "$SFUSER,texstudio@web.sourceforge.net:/home/groups/t/te/texstudio/htdocs"

#svn commit -m "web page $@" index.html
git commit -m "web page $*" index.html legal.html 
git push

remotepath=/
uploadCommands=$"put index.html\nput legal.html"

OWNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $OWNDIR/.ftpdata
if [ ! -e $OWNDIR/.ftpdata ]; then echo Create file $OWNDIR/.ftpdata with ftp connection data; exit; fi 
uploadCommands="user $username $password\ncd $remotepath\n$uploadCommands\nbye";

echo -e "$uploadCommands" | ftp -n -v $domain 

