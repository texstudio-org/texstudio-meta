#!/bin/bash

VERSION=$1

DEBIAN=`xidel https://sourceforge.net/projects/texstudio/files/texstudio/TeXstudio%202.5.1/ -e '//tr[th/a[contains(text(), "_amd64.deb")]]' --printed-node-format xml`
DEBIANLINK=`xidel "$DEBIAN" -e '(//a/@href)[1]' 2> /dev/null`
DEBIANSIZE=`xidel "$DEBIAN" -e '(//td[@headers="files_size_h"])[1]' 2> /dev/null`

echo "<table>"
echo ""

xidel \
     http://download.opensuse.org/repositories/home:/jsundermeyer/                                    \
     --extract-exclude=u,plat,os,lastos,release-version,release-date                                  \
     -e "<body>{os := (), release-version := '$VERSION', lastos := '', debianlink := '$DEBIANLINK', debiansize := '$DEBIANSIZE'}</body>"   \
     -e '<img src="/icons/folder.png"/><a/>{release-date:=filter("2012", " *([^ ]*)", 1)}'            \
     -f "<BODY><PRE><A/><A/><A/><A/><t:loop><A>{.}</A></t:loop></PRE></BODY>"                         \
     -e '()'                                                                                          \
     -f '//a[text() = ("i386/", "i586/", "i686/", "x86_64/", "amd64/")]'                              \
     --hide-variable-names                                                                            \
     -e '<body><t:s><![CDATA[
         xquery version "1.0";
         declare function entry($os, $u, $plat, $size){
           let $temp := <tr>
           <td>{if ($os = $lastos) then "" else $os}</td>
           <td>{if ($os = $lastos) then "" else $release-version}</td>
           <td><a href="{$u}">{$plat}</a> Package</td>
           <td>{$size}</td>
           <td><a href="{$u}">download</a> and open it with your package manager{
                if (contains($os, "openSUSE 12.1")) then "(use the 11.4 version above, if you do not have qt 4.8)"
                else ""}</td>
           </tr>,
           $temptemp := ($lastos := $os)
           return $temp
         };
         result := for $a in (//text()[contains(., $release-date)]/preceding-sibling::a[1][contains(@href, $release-version)])[1]
         let $u :=resolve-uri($a, $url),
             $plat := filter($u,"meyer/(.*)/", 1), 
             $os := translate(filter($plat,"(.*)/", 1),"_", " "),
             $realplat := filter($plat,"[^/]+$$;")
         return (
           if (contains($os, "Fedora") and not(contains($lastos, "Fedora"))) then entry("Debian wheezy", $debianlink, "amd64", $debiansize) else (),
           entry($os, $u, $realplat, concat(filter($a/following-sibling::text(),"([0-9.]+[MK])$$;"),"iB"))
         )
         ]]></t:s></body>'     --printed-node-format html                                                                          
     #2> /dev/null
     
echo "</table>"     
     
     
exit

 -e 'xquery version "1.0";
          declare function specialOSComment($osname) {
            if (contains($osname, "openSUSE 12.1")) then "use the 11.4 version above, if you do not have qt 4.8)"
            else ""
          }'      
          
           result := concat(
             "<tr><td>",
               (if ($os = $lastos) then "" else $os),
             "</td><td>",
               (if ($os = $lastos) then "" else $release-version),
             "</td><td>",
               "<a href=""$u;"">", filter($plat,"[^/]+$$;"),"</a> Package",
             "</td><td>",
                filter($a/following-sibling::text(),"([0-9.]+[MK])$$;"),"iB", 
             "</td><td>",
                "<a href=""$u;"">download</a> and open it with your package manager ",
                if (contains($os, "openSUSE 12.1")) then "(use the 11.4 version above, if you do not have qt 4.8)"
                else "",
             "</td></tr>"
           )
