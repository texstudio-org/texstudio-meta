#!/bin/bash

OWNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $OWNDIR/checkversion.sh


VERSION=$TXS_VERSION_CPP
USERNAME=jsundermeyer
echo Version: $VERSION
echo Password for sf user $USERNAME
read PASSWORD

xidel https://sourceforge.net/projects/texstudio/files/texstudio/TeXstudio%20$VERSION/ -e 'css("#files .name")' > /tmp/txsfiles

function setDef(){
  FILEGREP=$1
  PLATFORM=$2
  FILEGREPFALLBACK=$3
  FILE=$(grep $FILEGREP /tmp/txsfiles | head -1)
  if [[ -z  ]]; then FILE=$(grep $FILEGREPFALLBACK /tmp/txsfiles | head -1); fi
  if [[ -n $FILE ]]; then 
    echo $FILE on $PLATFORM
  
    /home/benito/hg/programs/internet/xidel/xidel https://sourceforge.net/auth/         \
      -f "form((//form)[2], {'username': '$USERNAME', 'password': '$PASSWORD'})"            \
      -f "object(('method', 'PUT', 
                'post', 'name=$FILE&download_label=&default=$PLATFORM', 
                'url', 'https://sourceforge.net/projects/texstudio/files/texstudio/TeXstudio%20$VERSION/$FILE'))" 
    echo
  fi
}


 
setDef 'qt5.*exe$' windows '\.exe$'
setDef '\.zip\.' mac
setDef '\.deb$' linux
setDef '\.tar.gz$' "solaris&default=bsd&default=others"

rm /tmp/txsfiles
