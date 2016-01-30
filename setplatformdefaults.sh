#!/bin/bash

OWNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $OWNDIR/checkversion.sh


VERSION=$TXS_VERSION_CPP
if [[ "$(whoami)" = benito ]]; then USERNAME=benibela; 
else USERNAME=jsundermeyer; 
fi
echo Version: $VERSION
echo Password for sf user $USERNAME
read PASSWORD

xidel https://sourceforge.net/projects/texstudio/files/texstudio/TeXstudio%20$VERSION/ -e 'css("#files .name")' > /tmp/txsfiles

function setDef(){
  FILEGREP=$1
  PLATFORM=$2
  FILEGREPFALLBACK=$3
  FILE=$(grep -E $FILEGREP /tmp/txsfiles | head -1)
  if [[ -z "$FILE" ]] &&  [[ -n "$FILEGREPFALLBACK" ]]; then FILE=$(grep -E $FILEGREPFALLBACK /tmp/txsfiles | head -1); fi
  if [[ -n "$FILE" ]]; then 
    echo $FILE on $PLATFORM
  
    xidel https://sourceforge.net/auth/         \
      -f "form((//form)[2], {'username': '$USERNAME', 'password': '$PASSWORD'})"            \
      -f "{'method': 'PUT', 
           'post': 'name=$FILE&download_label=&default=$PLATFORM', 
           'url': 'https://sourceforge.net/projects/texstudio/files/texstudio/TeXstudio%20$VERSION/$FILE'}" 
    echo
  fi
}


 
setDef 'qt5.*exe$' windows '\.exe$'
setDef '\.dmg\.|-osx-' mac 
setDef '\.deb$' linux
setDef '\.tar.gz$' "solaris&default=bsd&default=others"

rm /tmp/txsfiles
