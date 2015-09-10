#/bin/bash


METADIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TXS_VERSION_CPP=`grep TXSVERSION utilsVersion.h | head -1 | cut -d " " -f 3 | tr -d "\"" | grep -oE [0-9.]+`
TXS_VERSION_MANPAGE=`grep TH utilities/texstudio.1 | head -1 | cut -d " " -f 5 | tr -d "\""`
TXS_VERSION_CHANGELOG=`grep TeXstudio utilities/manual/CHANGELOG.txt | head -1 | grep -oE [0-9.]+ | tail -1`
TXS_VERSION_DEBIAN_CHANGELOG=`head -1 debian/changelog | grep -oE [0-9.]+ `
TXS_VERSION_SPEC=`grep Version: utilities/texstudio.spec | head -1 | grep -oE "[0-9.]+"`
TXS_VERSION_INFOPLIST=$(grep -A 1 CFBundleShortVersionString Info.plist | grep '<string>' | grep -oE "[0-9.]*")
TXS_VERSION_ISS1=`grep AppVer $METADIR/texstudio.iss | head -1 | grep -oE [0-9.]+`
TXS_VERSION_ISS2=`grep AppVer $METADIR/texstudio.iss | head -1 | grep -oE [0-9.]+`
#TXS_VERSION_MANUAL=`grep SECTIONNEW utilities/manual/usermanual_en.html | head -2 | tail -1 | grep -oE "Version +[0-9.]+" | tail -1 | grep -oE [0-9.]+`
#TXS_VERSION_SETDEFAULTS=`grep VERSION $METADIR/setplatformdefaults.sh | head -1 | grep -oE "[0-9.]+"`


if [[ "$TXS_VERSION_CPP" != "$TXS_VERSION_MANPAGE" ]]; 
then echo Error: Version mismatch: "manpage (utilities/texstudio.1):" -$TXS_VERSION_MANPAGE- cpp: -$TXS_VERSION_CPP-; 
exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_CHANGELOG ]]; then echo Error: Version mismatch: CHANGELOG.txt: $TXS_VERSION_CHANGELOG cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_DEBIAN_CHANGELOG ]]; then echo Error: "Version mismatch: changelog (debian/changelog):" $TXS_VERSION_DEBIAN_CHANGELOG cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_SPEC ]]; then echo "Error: Version mismatch: spec (utitities/texstudio.spec): $TXS_VERSION_SPEC cpp: $TXS_VERSION_CPP"; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_INFOPLIST ]]; then echo Error: Version mismatch: Info.plist: $TXS_VERSION_INFOPLIST cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_ISS1 ]]; then echo Error: Version mismatch: iss: $TXS_VERSION_ISS1 cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_ISS2 ]]; then echo Error: Version mismatch: iss 2: $TXS_VERSION_ISS2 cpp: $TXS_VERSION_CPP; exit; fi
#if [[ $TXS_VERSION_CPP != $TXS_VERSION_MANUAL ]]; then echo Error: Version mismatch: manual: $TXS_VERSION_MANUAL cpp: $TXS_VERSION_CPP; exit; fi
#if [[ $TXS_VERSION_CPP != $TXS_VERSION_SETDEFAULTS ]]; then echo Error: Version mismatch: setplatformdefaults: $TXS_VERSION_SETDEFAULTS cpp: $TXS_VERSION_CPP; exit; fi
