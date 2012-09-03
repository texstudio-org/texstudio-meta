#/bin/bash

echo "create svn tag and src tarball"





TMXREVISION=`svn info | grep Revision | grep -oE [0-9]+`
echo "Assuming i should tag revision $TMXREVISION"

TXS_VERSION_CPP=`grep TXSVERSION smallUsefulFunctions.h | head -1 | cut -d " " -f 3 | tr -d "\"" | grep -oE [0-9.]+`
TXS_VERSION_MANPAGE=`grep TH utilities/texstudio.1 | head -1 | cut -d " " -f 5 | tr -d "\""`
TXS_VERSION_DEBIAN_CHANGELOG=`head -1 debian/changelog | grep -oE [0-9][.][0-9] `
TXS_VERSION_ISS1=`grep AppVer utilities/notInBinary/texmakerx.iss | head -1 | grep -oE [0-9][.][0-9]`
TXS_VERSION_ISS2=`grep AppVer utilities/notInBinary/texmakerx.iss | head -1 | grep -oE [0-9][.][0-9]`
TXS_VERSION_MANUAL=`grep SECTIONNEW utilities/usermanual_en.html | head -2 | tail -1 | grep -oE "Version +[0-9][.][0-9]" | tail -1 | grep -oE [0-9][.][0-9]`

if [[ "$TXS_VERSION_CPP" != "$TXS_VERSION_MANPAGE" ]]; 
then echo Error: Version mismatch: manpage: -$TXS_VERSION_MANPAGE- cpp: -$TXS_VERSION_CPP-; 
exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_DEBIAN_CHANGELOG ]]; then echo Error: Version mismatch: changelog: $TXS_VERSION_DEBIAN_CHANGELOG cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_ISS1 ]]; then echo Error: Version mismatch: iss: $TXS_VERSION_ISS1 cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_ISS2 ]]; then echo Error: Version mismatch: iss 2: $TXS_VERSION_ISS2 cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_MANUAL ]]; then echo Error: Version mismatch: manual: $TXS_VERSION_MANUAL cpp: $TXS_VERSION_CPP; exit; fi



#echo "Enter new txs version:"
#read TMXVERSION
TMXVERSION=$TXS_VERSION_CPP

echo "Publishing version $TMXVERSION"

SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi

svn rm --keep-local  -m "remove possible broken tag" https://$SFUSER@texstudio.svn.sourceforge.net/svnroot/texstudio/tags/TeXstudio/$TMXVERSION

svn copy -r $TMXREVISION  -m "TAGGED $TMXVERSION RELEASE" https://$SFUSER@texstudio.svn.sourceforge.net/svnroot/texstudio/trunk https://$SFUSER@texstudio.svn.sourceforge.net/svnroot/texstudio/tags/TeXstudio/$TMXVERSION



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
