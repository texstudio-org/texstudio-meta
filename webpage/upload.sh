#/bin/bash

SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi

rsync -v -e ssh index.html "$SFUSER,texstudio@web.sourceforge.net:/home/groups/t/te/texstudio/htdocs"

#svn commit -m "web page $@" index.html
hg commit -m "web page $*" index.html  
hg push

remotepath=/
uploadCommands="put index.html"

OWNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $OWNDIR/.ftpdata
uploadCommands="user $username $password\ncd $remotepath\n$uploadCommands\nbye";

echo -e "$uploadCommands" | ftp -n -v $domain 

