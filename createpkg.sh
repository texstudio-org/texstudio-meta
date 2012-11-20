#!/bin/bash
if [ ! -f texstudio ]; then echo "./texstudio doesn't exist"; exit; fi

if ( readelf -d texstudio | grep QtTest ) then  echo "txs linked against QtTest => ABORT"; exit; fi

#get qt version
QTVERSION=`qmake -v | grep -oE "4\.[2-9]\.[0-9]"`;
#QTVERSION="$QTVERSION.0";  (real version? or erase last digit?)

GCCVERSION=`gcc -v 2>&1 | grep -m 1  -Eo "4\.[0-9]\.[0-9]"`;

#TODO: remove dpkg dependency
POPPLERVERSION=`dpkg -s libpoppler-qt4-3 | grep Version | grep -Eo "0\.[0-9]+\.[0-9]"`
LIBCVERSION=`dpkg -s libc6 | grep Version  | grep -Eo "2\.[0-9]+([.][0-9]+)?"`;

if [ "x$GCCVERSION" = "x" ]; then echo "no gcc"; exit; fi;
if [ "x$LIBCVERSION" = "x" ]; then echo "no libc"; exit; fi;
if [ "x$QTVERSION" = "x" ]; then echo "no qt"; exit; fi;
if [ "x$POPPLERVERSION" = "x" ]; then echo "no poppler"; exit; fi;

DEPENDENCIES="libc6 (>=$LIBCVERSION), libgcc1 (>=$GCCVERSION), libqtcore4 (>=$QTVERSION) | libqt4-core (>=$QTVERSION), libqtgui4 (>=$QTVERSION) | libqt4-gui (>=$QTVERSION), libqt4-network (>=$QTVERSION), libqt4-xml (>=$QTVERSION), libstdc++6 (>=$GCCVERSION), libpoppler-qt4-3 (>=$POPPLERVERSION)"

if ( readelf -d texstudio | grep libphonon ) then DEPENDENCIES="$DEPENDENCIES, libphonon4 (>=4.5.0)"; fi


echo "Enter new txs version:"
read TMXVERSION

if [ "x$TMXVERSION" = "x" ]; then echo "no txs version"; exit; fi;




echo $DEPENDENCIES

export REQUIRES=$DEPENDENCIES
export SOURCE="svn://svn.code.sf.net/p/texstudio/code/trunk"

checkinstall --install=no --pkgname=TeXstudio  --default --pkgversion=$TMXVERSION --nodoc --maintainer="Benito van der Zander \<benito@benibela.de\>" 

if [ "$1" != "--release" ]; then echo "no release made (use --release option to release it)";  exit; fi;

#MACHINE=`uname -r |  grep -oE "[^-]*$"`
#if [ "x$MACHINE" = "x" ]; then echo "couldn't detect machine (i386/amd64) version"; exit; fi;

PKGFILE=`ls -t texstudio*.deb | grep -m 1  -oE "texstudio[^ ]*\.deb"`

SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi
SFUSER="$SFUSER,texstudio";



rsync -avRP -e ssh $PKGFILE "$SFUSER@frs.sourceforge.net:/home/frs/project/t/te/texstudio/texstudio/TeXstudio\ $TMXVERSION/"



