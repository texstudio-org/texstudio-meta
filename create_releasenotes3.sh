#/bin/bash

echo "create release note readme file"

VERSION=`grep TXSVERSION utilsVersion.h | head -1 | cut -d " " -f 3 | tr -d "\"" | grep -oE [0-9.]+`

cat <<EOF > /tmp/texstudio$VERSION.readme.txt
Release readme:
  
  This folder contains the downloads for the LaTeX editor TeXstudio $VERSION.
  Explanation of the downloads:

    *.tar.gz: Source tar ball of this release
    *win32*: Windows version, with installer or as usb (= settings stored in the same directory as the executable) version 
    *.deb: Debian version compiled on a developer machine
    *.dmg.zip: Mac version (usually provided externally)

  see http://texstudio.sourceforge.net/index.html#download for links to possible other versions




Excerpt of the changelog:

EOF

#copy first part of the changelog
a=0; 
line=""; 
pline=""; 
while read line && [[ $a -lt 2 ]]; do 
  if [[ $a -gt 0 ]]; then echo $pline; fi; 
  pline=$line; 
  if [[ $line =~ -\>\ TeXs|TeXstudio\ [0-9.]+\ *-\> ]]; then a=$(($a+1)); fi; 
done < utilities/manual/CHANGELOG.txt >> /tmp/texstudio$VERSION.readme.txt

echo Done:

cat /tmp/texstudio$VERSION.readme.txt

SFUSER="";
if [ -e /home/benito ]; then SFUSER="benibela"; else echo "Enter sourceforge user name:"; read SFUSER; fi
if [ "x$SFUSER"  = "x" ]; then echo "no sf user"; exit; fi


cd /tmp/
rsync -avRP -e ssh texstudio$VERSION.readme.txt "$SFUSER,texstudio@frs.sourceforge.net:/home/frs/project/t/te/texstudio/texstudio/TeXstudio\ $VERSION/" 


echo Done, might take a few minutes before sf shows the file as readme
