#!/bin/bash
if [[ "$1" = "" ]]; then echo "need version number"; exit; fi

scripts/create_table_linux.sh $1 > /tmp/table.html
scripts/merge_table_linux.sh

