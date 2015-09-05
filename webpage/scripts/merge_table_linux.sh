#!/bin/bash
xidel index.html -e 'xquery version "1.0";
  declare variable $newtablerows := doc("file:///tmp/table.html")//tr;
  declare function local:update($e) {
    if (not($e instance of element())) then $e
    else if (name($e) eq "tbody" and $e/@id eq "linuxdownloads") then
     <tbody id="linuxdownloads">
     {$newtablerows}
     </tbody>
    else
      element {node-name($e)} {$e / @*, for $i in $e/node() return local:update($i)}
  };
  local:update(/html)' --output-format html > /tmp/new.html
 cp /tmp/new.html index.html
 
 exit
 
 xidel index.html -e 'xquery version "3.0";
  declare variable $newtablerows := doc("file:///tmp/table.html")//tr;
  transform(function($e){
    if ($e instance of element() and name($e) eq "tbody" and $e/@id eq "linuxdownloads") then
     <tbody id="linuxdownloads">
     {$newtablerows}
     </tbody>
    else $e
  })' --output-format html > /tmp/new.html

