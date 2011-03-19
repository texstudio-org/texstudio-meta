#/bin/bash

echo "create svn tag and src tarball"





TMXREVISION=`svn info | grep Revision | grep -oE [0-9]+`
echo "Assuming i should tag revision $TMXREVISION"


echo "Enter new tmx version:"
read TMXVERSION


SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi


svn copy -r $TMXREVISION  -m "TAGGED $TMXVERSION RELEASE" https://$SFUSER@texmakerx.svn.sourceforge.net/svnroot/texmakerx/trunk https://$SFUSER@texmakerx.svn.sourceforge.net/svnroot/texmakerx/tags/TexMakerX/$TMXVERSION



#get tar from svn
mkdir -p /tmp/tmxsrc
wget  http://texmakerx.svn.sf.net/viewvc/texmakerx/tags/TexMakerX/$TMXVERSION/?view=tar -O /tmp/tmxsrc/tmx.tar.gz

#add svn_revision.cpp
mkdir -p /tmp/tmxsrc2
tar -xf /tmp/tmxsrc/tmx.tar.gz -C /tmp/tmxsrc2
cp svn_revision.cpp /tmp/tmxsrc2/$TMXVERSION/
mv /tmp/tmxsrc2/$TMXVERSION/ /tmp/tmxsrc2/texmakerx$TMXVERSION

#create
cd /tmp/tmxsrc2
tar -czf /tmp/tmxsrc/texmakerx-$TMXVERSION.tar.gz  texmakerx$TMXVERSION

cd /tmp/tmxsrc/
rsync -avRP -e ssh texmakerx-$TMXVERSION.tar.gz "$SFUSER,texmakerx@frs.sourceforge.net:/home/frs/project/t/te/texmakerx/texmakerx/TexMakerX\ $TMXVERSION/"
