#!/bin/bash

VERSION=$1

if [[ "$VERSION" = "" ]]; then echo "need version number"; exit; fi

CURYEAR=`date  +%Y`

DEBIAN=`xidel https://sourceforge.net/projects/texstudio/files/texstudio/TeXstudio%20$VERSION/ -e '//tr[th/a[contains(text(), "_amd64.deb")]]' --printed-node-format xml`
DEBIANLINK=`xidel "$DEBIAN" -e '(//a/@href)[1]' 2> /dev/null`
DEBIANSIZE=`xidel "$DEBIAN" -e '(//td[@headers="files_size_h"])[1]' 2> /dev/null`

echo "<table>"
echo ""

xidel \
     http://download.opensuse.org/repositories/home:/jsundermeyer/                                    \
     --extract-exclude=u,plat,os,lastos,lastqt4,lastplat,release-version,release-date,debianlink,debiansize            \
     -e "<body>{os := (), release-version := '$VERSION', lastos := '', lastqt4 := (), lastplat := (), debianlink := '$DEBIANLINK', debiansize := '$DEBIANSIZE', release-date:= '$CURYEAR'}</body>"   \
     -f "<BODY><PRE><A/><A/><A/><A/><t:loop><A>{.}</A></t:loop></PRE></BODY>"                         \
     -f '//a[text() = ("i386/", "i586/", "i686/", "x86_64/", "amd64/")]'                              \
     --hide-variable-names                                                                            \
     -e 'xquery version "3.0-xidel";
         declare function entry($os, $u, $plat, $size){
           if (not($u)) then ()
           else let $qt4 := contains($u, "qt4"), 
                    $sameos := $os = $lastos,
           $temp := (if ($sameos) then () else <tr><td colspan="5"><br/> </td></tr>, <tr>
           <td>{if ($sameos) then "" else ($os)}</td>
           <td>{if ($sameos and $plat = $lastplat) then "" else $plat}</td>
           <td><a href="{$u}">{$release-version},&#160;QT&#160;{if ($qt4) then 4 else 5}</a></td>
           <td>{replace(normalize-space($size), " ", "&#160;")}</td>
           <td><a href="{$u}">download</a> and open it with your package manager{
                if (contains($os, "openSUSE 12.1")) then "(use the 11.4 version above, if you do not have qt 4.8)"
                else ""}</td>
           </tr>),
           $temptemp := ($lastos := $os, $lastqt4 := $qt4, $lastplat := $plat)
           return $temp
         };
         result := for $a in   (//text()[contains(., $release-date)]/preceding-sibling::a[1][contains(@href, $release-version) and not(contains(@href, "debuginfo"))])  
         let $u :=resolve-uri($a, $url),
             $plat := extract($u,"meyer/(.*)/", 1), 
             $os := translate(extract($plat,"(.*)/", 1),"_", " "),
             $realplat := extract($plat,"[^/]+$")
         return (
           if (contains($os, "Fedora") and not(contains($lastos, "Fedora"))) then entry("Debian Jessie", $debianlink, "amd64", $debiansize) else (),
           entry($os, $u, $realplat, replace(extract($a/following-sibling::text(),"[0-9.]+ *[MK]$"), "([0-9.]+) *([MK])", "$1 $2iB"))
         )'     --printed-node-format html                                                                          
     #2> /dev/null
     
echo "</table>"     
     
     
