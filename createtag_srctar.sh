#/bin/bash

echo "create svn tag and src tarball"





TMXREVISION=`svn info | grep Revision | grep -oE [0-9]+`
echo "Assuming i should tag revision $TMXREVISION"

OWNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $OWNDIR/checkversion.sh



#echo "Enter new txs version:"
#read TMXVERSION
TMXVERSION=$TXS_VERSION_CPP

echo "Publishing version $TMXVERSION"

SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; eval `keychain -q --eval --agents ssh id_rsa `; 
else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi



svn rm --keep-local  -m "remove possible broken tag" svn+ssh://$SFUSER@svn.code.sf.net/p/texstudio/code/tags/TeXstudio/$TMXVERSION

svn copy -r $TMXREVISION  -m "TAGGED $TMXVERSION RELEASE" svn+ssh://$SFUSER@svn.code.sf.net/p/texstudio/code/trunk svn+ssh://$SFUSER@svn.code.sf.net/p/texstudio/code/tags/TeXstudio/$TMXVERSION



#get tar from svn
rm -Rf /tmp/tmxsrc /tmp/tmxsrc2
mkdir -p /tmp/tmxsrc
wget  http://texstudio.svn.sf.net/viewvc/texstudio/tags/TeXstudio/$TMXVERSION/?view=tar -O /tmp/tmxsrc/tmx.tar.gz

#add svn_revision.cpp
mkdir -p /tmp/tmxsrc2
tar -xf /tmp/tmxsrc/tmx.tar.gz -C /tmp/tmxsrc2
#cp svn_revision.cpp /tmp/tmxsrc2/$TMXVERSION/  
echo "const char* TEXSTUDIO_SVN_VERSION = \"$TMXREVISION\";" > /tmp/tmxsrc2/$TMXVERSION/svn_revision.cpp
mv /tmp/tmxsrc2/$TMXVERSION/ /tmp/tmxsrc2/texstudio$TMXVERSION

#create
cd /tmp/tmxsrc2
tar -czf /tmp/tmxsrc/texstudio-$TMXVERSION.tar.gz  texstudio$TMXVERSION

cd /tmp/tmxsrc/
rsync -avRP -e ssh texstudio-$TMXVERSION.tar.gz "$SFUSER,texstudio@frs.sourceforge.net:/home/frs/project/t/te/texstudio/texstudio/TeXstudio\ $TMXVERSION/"
