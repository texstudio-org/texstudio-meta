#/bin/bash

echo "create svn tag and src tarball"


if [[ ! (-e ./texstudio.pro) ]]; then echo need to be called in txs root; exit; fi 

SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; eval `keychain -q --eval --agents ssh id_rsa `; 
else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi

svn update


TMXREVISION=`svn info | grep Revision | grep -oE [0-9]+`
echo "Assuming i should tag revision $TMXREVISION"

OWNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $OWNDIR/checkversion.sh



#echo "Enter new txs version:"
#read TMXVERSION
TMXVERSION=$TXS_VERSION_CPP

echo "Publishing version $TMXVERSION"



svn rm --keep-local  -m "remove possible broken tag" svn+ssh://$SFUSER@svn.code.sf.net/p/texstudio/code/tags/TeXstudio/$TMXVERSION

RELEASESVNPATH=`svn info | grep URL | grep -oE "svn.*"`


svn copy -r $TMXREVISION  -m "TAGGED $TMXVERSION RELEASE" $RELEASESVNPATH svn+ssh://$SFUSER@svn.code.sf.net/p/texstudio/code/tags/TeXstudio/$TMXVERSION



#get tar from svn
rm -Rf /tmp/tmxsrc /tmp/tmxsrc2
mkdir /tmp/tmxsrc2
svn export . /tmp/tmxsrc2/texstudio$TMXVERSION

#add svn_revision.cpp
#cp svn_revision.cpp /tmp/tmxsrc2/$TMXVERSION/  
echo "const char* TEXSTUDIO_SVN_VERSION = \"$TMXREVISION\";" > /tmp/tmxsrc2/texstudio$TMXVERSION/svn_revision.cpp

#create
cd /tmp/tmxsrc2
mkdir /tmp/tmxsrc
tar -czf /tmp/tmxsrc/texstudio-$TMXVERSION.tar.gz  texstudio$TMXVERSION

cd /tmp/tmxsrc/
rsync -avRP -e ssh texstudio-$TMXVERSION.tar.gz "$SFUSER,texstudio@frs.sourceforge.net:/home/frs/project/t/te/texstudio/texstudio/TeXstudio\ $TMXVERSION/"
