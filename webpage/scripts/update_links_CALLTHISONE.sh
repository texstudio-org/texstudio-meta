#!/bin/bash
if [[ "$1" = "" ]]; then echo "need version number"; exit; fi
scripts/update_table_linux.sh $1
scripts/merge_table_others.sh $1

