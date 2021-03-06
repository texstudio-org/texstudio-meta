#!/bin/bash

RELEASE=2.5.2

#abort on error
set -e

#don't ask for ssh password on every ssh call
eval `keychain -q --eval --agents ssh id_rsa `


svn update
svn commit -m "$@"
svn update

REV=`svn info | grep "Last Changed Rev" | grep -oE [0-9]+`

echo MERGE REVISION $REV

cd ~/texmakerxAdditions/release$RELEASE
svn update
svn merge -c$REV ^/trunk
svn commit -m "auto merge r$REV in $RELEASE: $@"

