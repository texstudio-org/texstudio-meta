#!/bin/bash

VERSION=2.6.4
USERNAME=benibela
echo Password for sf user $USERNAME
read PASSWORD

xidel https://sourceforge.net/projects/texstudio/files/texstudio/TeXstudio%20$VERSION/ -e 'css("#files .name")' > /tmp/txsfiles

function setDef(){
  FILEGREP=$1
  PLATFORM=$2
  FILE=$(grep $FILEGREP /tmp/txsfiles | head -1)
  if [[ -n $FILE ]]; then 
    echo $FILE on $PLATFORM
  
    /home/benito/hg/programs/internet/xidel/xidel https://sourceforge.net/account/login.php         \
      -f "form((//form)[2], {'form_loginname': '$USERNAME', 'form_pw': '$PASSWORD', 'login': 'Log in'})"            \
      -f "object(('method', 'PUT', 
                'post', 'name=$FILE&download_label=&default=$PLATFORM', 
                'url', 'https://sourceforge.net/projects/texstudio/files/texstudio/TeXstudio%20$VERSION/$FILE'))" 
    echo
  fi
}


 
setDef '\.exe$' windows
setDef '\.dmg\.' mac
setDef '\.deb$' linux
setDef '\.tar.gz$' "solaris&default=bsd&default=others"

rm /tmp/txsfiles
