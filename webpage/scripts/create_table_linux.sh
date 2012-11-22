#!/bin/bash

VERSION=$1

echo "<table>"
echo ""
xidel \
     http://download.opensuse.org/repositories/home:/jsundermeyer/                                    \
     --extract-exclude=u,plat,os,lastos,release-version,release-date                                  \
     -e "<body>{os := (), release-version := '$VERSION'}</body>"                                      \
     -e '<img src="/icons/folder.png"/><a/>{release-date:=filter(text(), " *([^ ]*)", 1)}'            \
     -f "<BODY><PRE><A/><A/><A/><A/><t:loop><A>{.}</A></t:loop></PRE></BODY>"                         \
     -e '()'                                                                                          \
     -f '//a[text() = ("i386/", "i586/", "i686/", "x86_64/", "amd64/")]'                              \
     --hide-variable-names                                                                            \
     -e '<body><![CDATA[{
         for $a in //text()[starts-with(., $release-date)][1]/preceding-sibling::a[1] 
         return (
           $u :=resolve-uri($a, $url), 
           plat := filter($u,"meyer/(.*)/", 1), 
           lastos := $os, 
           os := translate(filter($plat,"(.*)/", 1),"_", " "), 
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
                "<!--needs 4.6?-->",
             "</td><td>",
             "</td><td>",
                "<a href=""$u;"">download</a> and open it with your package manager ",
                if (contains($os, "openSUSE 12.1")) then "(use the 11.4 version above, if you do not have qt 4.8)"
                else "",
             "</td></tr>"
           )
         )}]]></body>'                                                                              
     #2> /dev/null
     
echo "</table>"     
     
     
exit

 -e 'xquery version "1.0";
          declare function specialOSComment($osname) {
            if (contains($osname, "openSUSE 12.1")) then "use the 11.4 version above, if you do not have qt 4.8)"
            else ""
          }'      
