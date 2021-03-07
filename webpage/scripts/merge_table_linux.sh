#!/bin/bash
xidel index.html -e 'xquery version "3.1-xidel";
  declare variable $newtablerows := doc("file:///tmp/table.html")//tr;
  x:replace-nodes(//tbody[@id eq "linuxdownloads"],
     <tbody id="linuxdownloads">
     {$newtablerows}
     </tbody>
  )' --output-format html > /tmp/new.html && cp /tmp/new.html index.html
 
 

