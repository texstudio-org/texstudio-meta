#!/bin/bash
if [[ "$1" = "" ]]; then echo "need version number"; exit; fi

VERSION=$1



eval "$(xidel https://github.com/texstudio-org/texstudio/releases/tag/$VERSION/  --xquery '
  let $root := (/)
  let $find := function($searched){ 
    let $link := ($root//a[contains(@href, $searched)])[1] 
    return map { 
      "url": $link/resolve-html(), 
      "size": $link//small[matches(., "[MG]B")]!string() 
    } }
  return (
    $find("exe")!( WININSTALLER := ?url, WININSTALLERSIZE := ?size  ),
    $find("dmg")!( MACDMG := ?url, MACDMGSIZE := ?size  ),
    $find("qt5")!( WINUSB := ?url, WINUSBSIZE := ?size  ),
    $find("app")!( APPIMAGE := ?url, APPIMAGESIZE := ?size  ),
    $find("tar.gz")!( TARBALL := ?url, TARBALLSIZE := ?size  )
  )  
' --output-format bash)"



#OS2=$(xidel /tmp/txsfiles -e 'css("#files .file th a")[contains(., "os2")]/@href')
#if [ $? -eq 0 ] && [ -n "$OS2" ]; then OS2SIZE=$(getSize $OS2); else OS2=""; fi

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
    else if (\$e/@class eq "appImageDownload") then local:changeHref(\$e, "$APPIMAGE")
    else if (\$e/@class eq "appImageDownloadSize") then local:changeText(\$e, "($APPIMAGESIZE)")
    else if ("$OS2" ne "" and \$e/@class eq "currentVersionOS2") then local:changeText(\$e, "$VERSION")
    else if ("$OS2" ne "" and \$e/@class eq "os2Download") then local:changeHref(\$e, "$OS2")
    else if ("$OS2" ne "" and \$e/@class eq "os2DownloadSize") then local:changeText(\$e, "$OS2SIZE")
    else
      element {node-name(\$e)} {\$e / @*, for \$i in \$e/node() return local:update(\$i)}
  };
  local:update(/html)
EOF

cp /tmp/new.html index.html
