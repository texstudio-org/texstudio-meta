#!/bin/bash
scripts/create_table_linux.sh $1 > /tmp/table.html
scripts/merge_table_linux.sh

