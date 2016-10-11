#/bin/bash

if [[ ! (-e ./texstudio.pro) ]]; then echo "ERROR: This script needs to be called in the texstudio-hg root directory."; exit; fi 

OWNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $OWNDIR/checkversion.sh
TXS_VERSION=$TXS_VERSION_CPP
HG_VERSION=$(hg identify -n)
HG_REVISION=$(hg identify -i)

echo "creating src tarball for TeXstudio $TXS_VERSION hg $HG_VERSION:$HG_REVISION"

# update hg_revision.cpp
./hg_revision.sh echo > /dev/null


# get sourceforge user
SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; eval `keychain -q --eval --agents ssh id_rsa `; 
else echo "Please enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "ERROR: no sourceforge user"; exit; fi

rm -rf /tmp/tmxsrc2
mkdir /tmp/tmxsrc /tmp/tmxsrc2


hg archive -v /tmp/tmxsrc2/texstudio$TXS_VERSION
cp hg_revision.cpp /tmp/tmxsrc2/texstudio$TXS_VERSION

cd /tmp/tmxsrc2


tar -cvzf /tmp/tmxsrc/texstudio-$TXS_VERSION.tar.gz  texstudio$TXS_VERSION
cd /tmp/tmxsrc/
rsync -avRP -e ssh texstudio-$TXS_VERSION.tar.gz "$SFUSER,texstudio@frs.sourceforge.net:/home/frs/project/t/te/texstudio/texstudio/TeXstudio\ $TXS_VERSION/"
