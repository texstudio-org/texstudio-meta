#!/bin/bash
if [ ! -f texmakerx ]; then echo "./texmakerx doesn't exist"; exit; fi

if ( readelf -d texmakerx | grep QtTest ) then  echo "tmx linked against QtTest => ABORT"; exit; fi

#get qt version
QTVERSION=`qmake -v | grep -oE "4\.[2-9]\.[0-9]"`;
#QTVERSION="$QTVERSION.0";  (real version? or erase last digit?)

GCCVERSION=`gcc -v 2>&1 | grep -m 1  -Eo "4\.[0-9]\.[0-9]"`;

#TODO: remove dpkg dependency
POPPLERVERSION=`dpkg -s libpoppler-qt4-3 | grep Version | grep -Eo "0\.[0-9]+\.[0-9]"`
LIBCVERSION=`dpkg -s libc6 | grep Version  | grep -Eo "2\.[0-9]+\.[0-9]+"`;

if [ "x$GCCVERSION" = "x" ]; then echo "no gcc"; exit; fi;
if [ "x$LIBCVERSION" = "x" ]; then echo "no libc"; exit; fi;
if [ "x$QTVERSION" = "x" ]; then echo "no qt"; exit; fi;
if [ "x$POPPLERVERSION" = "x" ]; then echo "no poppler"; exit; fi;

DEPENDENCIES="libc6,libgcc1,libqtcore4\|libqt4-core,libqtgui4\|libqt4-gui,libqt4-network,libqt4-xml,libstdc++6,libpoppler-qt4-3"

echo "Enter new tmx version:"
read TMXVERSION

if [ "x$TMXVERSION" = "x" ]; then echo "no tmx version"; exit; fi;




echo $DEPENDENCIES


checkinstall --install=no --pkgname=TexMakerX --default  --pkgversion=$TMXVERSION --nodoc --maintainer="Benito van der Zander \<benito@benibela.de\>" --requires="$DEPENDENCIES" 

if [ "$1" != "--release" ]; then echo "no release made";  exit; fi;

#MACHINE=`uname -r |  grep -oE "[^-]*$"`
#if [ "x$MACHINE" = "x" ]; then echo "couldn't detect machine (i386/amd64) version"; exit; fi;

PKGFILE=`ls -t texmakerx*.deb | grep -m 1  -oE "texmakerx[^ ]*\.deb"`

SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi
SFUSER="$SFUSER,texmakerx";



rsync -avRP -e ssh $PKGFILE "$SFUSER@frs.sourceforge.net:/home/frs/project/t/te/texmakerx/texmakerx/TexMakerX\ $TMXVERSION/"

