#!/bin/bash
if [[ "$1" = "" ]]; then echo "need version number"; exit; fi

VERSION=$1

xidel https://github.com/texstudio-org/texstudio/releases/tag/$VERSION/ --download /tmp/txsfiles

function getSize(){
  xidel /tmp/txsfiles -e "<tr><th><a href='$1'></th><td headers='files_size_h'>{.}</td></tr>" --hide-variable-names
}

WININSTALLER=$(xidel /tmp/txsfiles --xpath 'let $urls := //a/@href return ($urls[contains(., "exe")], $urls)[1]')
WININSTALLER="https://github.com$WININSTALLER"
WININSTALLERSIZE=$(getSize $WININSTALLER)
MACDMG=$(xidel /tmp/txsfiles --xpath 'let $urls := //a/@href return ($urls[contains(., "dmg")], $urls)[1]')
MACDMG="https://github.com$MACDMG"
MACDMGSIZE=$(getSize $MACDMG)
WINUSB=$(xidel /tmp/txsfiles --xpath 'let $urls := //a/@href return ($urls[contains(., "qt5")], $urls)[1]')
WINUSB="https://github.com$WINUSB"
if [ $? -eq 0 ] && [ -n "$WINUSB" ]; then WINUSBSIZE=$(getSize $WINUSB); else WINUSB=""; fi
APPIMAGE=$(xidel /tmp/txsfiles --xpath 'let $urls := //a/@href return ($urls[contains(., "app")], $urls)[1]')
APPIMAGE="https://github.com$APPIMAGE"
if [ $? -eq 0 ] && [ -n "$APPIMAGE" ]; then APPIMAGESIZE=$(getSize $APPIMAGE); else APPIMAGE=""; fi
TARBALL=$(xidel /tmp/txsfiles --xpath 'let $urls := //a/@href return ($urls[contains(., "tar.gz")], $urls)[1]')
TARBALL="https://github.com$TARBALL"
TARBALLSIZE=$(getSize $TARBALL)
OS2=$(xidel /tmp/txsfiles -e 'css("#files .file th a")[contains(., "os2")]/@href')
if [ $? -eq 0 ] && [ -n "$OS2" ]; then OS2SIZE=$(getSize $OS2); else OS2=""; fi

#echo $WININSTALLER
#echo $WININSTALLERSIZE
#echo $MACDMG
#echo $WINUSB
#echo $WINUSBSIZE
#echo $APPIMAGE
#echo $TARBALL
#echo $TARBALLSIZE

#exit

xidel index.html --extract-kind=xquery -e - --output-format html > /tmp/new.html <<EOF 
  declare function local:changeText(\$e, \$newtext) {
    element {node-name(\$e)} {\$e / @*, for \$i in \$e/element() return local:update(\$i), text {\$newtext } }
  };
  declare function local:changeHref(\$e, \$newlink) {
    element {node-name(\$e)} {\$e / @*[name() ne "href"], attribute href {\$newlink}, for \$i in \$e/node() return local:update(\$i)}
  };
  declare function local:update(\$e) {
    if (not(\$e instance of element())) then \$e
    else if (\$e/@class = ("currentVersion", "currentVersionMac")) then local:changeText(\$e, "$VERSION")
    else if (\$e/@id eq "winDownload" or \$e/@class eq "winDownloadInstaller") then local:changeHref(\$e, "$WININSTALLER")
    else if (\$e/@class eq "winDownloadInstallerSize") then local:changeText(\$e, "$WININSTALLERSIZE")
    else if ("$WINUSB" ne "" and \$e/@class eq "currentVersionUSB") then local:changeText(\$e, "$VERSION")
    else if ("$WINUSB" ne "" and \$e/@class eq "winDownloadUSB") then local:changeHref(\$e, "$WINUSB")
    else if ("$WINUSB" ne "" and \$e/@class eq "winDownloadUSBSize") then local:changeText(\$e, "$WINUSBSIZE")
    else if (\$e/@id eq "macDownload" or \$e/@class eq "macDownload") then local:changeHref(\$e, "$MACDMG")
    else if (\$e/@class eq "macDownloadSize") then local:changeText(\$e, "$MACDMGSIZE")
    else if (\$e/@class eq "srcDownload") then local:changeHref(\$e, "$TARBALL")
    else if (\$e/@class eq "srcDownloadSize") then local:changeText(\$e, "$TARBALLSIZE")
    else if ("$OS2" ne "" and \$e/@class eq "currentVersionOS2") then local:changeText(\$e, "$VERSION")
    else if ("$OS2" ne "" and \$e/@class eq "os2Download") then local:changeHref(\$e, "$OS2")
    else if ("$OS2" ne "" and \$e/@class eq "os2DownloadSize") then local:changeText(\$e, "$OS2SIZE")
    else
      element {node-name(\$e)} {\$e / @*, for \$i in \$e/node() return local:update(\$i)}
  };
  local:update(/html)
EOF

cp /tmp/new.html index.html
