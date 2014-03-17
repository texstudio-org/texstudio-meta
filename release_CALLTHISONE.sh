#/bin/bash
echo untested!
OWNDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $OWNDIR/checkversion.sh
$OWNDIR/createsrctar1.sh 
$OWNDIR/createpkg.sh --release
$OWNDIR/create_releasenotes3.sh 
echo uploaded. wait a while for platform defaults
read 
$OWNDIR/setplatformdefaults.sh 
cd $OWNDIR/webpage
scripts/update_links_CALLTHISONE.sh $TXS_VERSION_CPP
scripts/update_update.sh $TXS_VERSION_CPP

