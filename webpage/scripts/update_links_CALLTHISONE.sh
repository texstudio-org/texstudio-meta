#!/bin/bash
if [[ "$1" = "" ]]; then echo "need version number"; exit; fi
scripts/update_table_linux.sh $1
scripts/update_version.pl $1 > /tmp/index.html
mv /tmp/index.html index.html

