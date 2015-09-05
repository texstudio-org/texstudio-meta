#/bin/bash

OWNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $OWNDIR/checkversion.sh


echo "create src tarball"


if [[ ! (-e ./texstudio.pro) ]]; then echo need to be called in txs root; exit; fi 

SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; eval `keychain -q --eval --agents ssh id_rsa `; 
else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi

#hg pull
#hg update
./hg_revision.sh echo > /dev/null


#TMXREVISION=`svn info | grep Revision | grep -oE [0-9]+`
#echo "Assuming i should tag revision $TMXREVISION"




#echo "Enter new txs version:"
#read TMXVERSION
TMXVERSION=$TXS_VERSION_CPP

#echo "Publishing version $TMXVERSION"

rm -rf /tmp/tmxsrc2
mkdir /tmp/tmxsrc /tmp/tmxsrc2


hg archive -v /tmp/tmxsrc2/texstudio$TMXVERSION
cp hg_revision.cpp /tmp/tmxsrc2/texstudio$TMXVERSION

cd /tmp/tmxsrc2


tar -cvzf /tmp/tmxsrc/texstudio-$TMXVERSION.tar.gz  texstudio$TMXVERSION
cd /tmp/tmxsrc/
rsync -avRP -e ssh texstudio-$TMXVERSION.tar.gz "$SFUSER,texstudio@frs.sourceforge.net:/home/frs/project/t/te/texstudio/texstudio/TeXstudio\ $TMXVERSION/"
