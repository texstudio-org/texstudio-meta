#/bin/bash

if [[ -e /home/benito ]]; then eval `keychain -q --eval --agents ssh id_rsa `; fi

OWNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $OWNDIR/checkversion.sh
# $OWNDIR/createsrctar1.sh 
# $OWNDIR/createpkg.sh --release
# $OWNDIR/create_releasenotes3.sh should probably be pushed to github somewhere (or into index.html)
#echo uploaded. wait a while for platform defaults
#read 
# $OWNDIR/setplatformdefaults.sh 
cd $OWNDIR/webpage
scripts/update_links_CALLTHISONE.sh $TXS_VERSION_CPP
# scripts/update_update.sh $TXS_VERSION_CPP

