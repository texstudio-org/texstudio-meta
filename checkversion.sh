#/bin/bash


METADIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TXS_VERSION_CPP=`grep TXSVERSION src/utilsVersion.h | head -1 | cut -d " " -f 3 | tr -d "\"" | grep -oE [0-9.]+`
TXS_VERSION_MANPAGE=`grep TH utilities/texstudio.1 | head -1 | cut -d " " -f 5 | tr -d "\""`
TXS_VERSION_CHANGELOG=`grep TeXstudio utilities/manual/CHANGELOG.txt | head -1 | grep -oE [0-9.]+ | tail -1`
TXS_VERSION_DEBIAN_CHANGELOG=`head -1 debian/changelog | grep -oE [0-9.]+ `
TXS_VERSION_SPEC=`grep Version: utilities/texstudio.spec | head -1 | grep -oE "[0-9.]+"`
TXS_VERSION_INFOPLIST=$(grep -A 1 CFBundleShortVersionString Info.plist | grep '<string>' | grep -oE "[0-9.]*")
TXS_NSI_MAJOR=`grep -oE "define VERSIONMAJOR.*[0-9]+" utilities/texstudio.nsi |grep -oE "[0-9]+"`
TXS_NSI_MINOR=`grep -oE "define VERSIONMINOR.*[0-9]+" utilities/texstudio.nsi |grep -oE "[0-9]+"`
TXS_NSI_BUILD=`grep -oE "define VERSIONBUILD.*[0-9]+" utilities/texstudio.nsi |grep -oE "[0-9]+"`
TXS_MAJOR=`echo $TXS_VERSION_CPP |cut -d "." -f 1`
TXS_MINOR=`echo $TXS_VERSION_CPP |cut -d "." -f 2`
TXS_BUILD=`echo $TXS_VERSION_CPP |cut -d "." -f 3`

if [[ "$TXS_VERSION_CPP" != "$TXS_VERSION_MANPAGE" ]]; 
then echo Error: Version mismatch: "manpage (utilities/texstudio.1):" -$TXS_VERSION_MANPAGE- cpp: -$TXS_VERSION_CPP-; 
exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_CHANGELOG ]]; then echo Error: Version mismatch: CHANGELOG.txt: $TXS_VERSION_CHANGELOG cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_DEBIAN_CHANGELOG ]]; then echo Error: "Version mismatch: changelog (debian/changelog):" $TXS_VERSION_DEBIAN_CHANGELOG cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_SPEC ]]; then echo "Error: Version mismatch: spec (utitities/texstudio.spec): $TXS_VERSION_SPEC cpp: $TXS_VERSION_CPP"; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_INFOPLIST ]]; then echo Error: Version mismatch: Info.plist: $TXS_VERSION_INFOPLIST cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_NSI_MAJOR != $TXS_MAJOR ]]; then echo Error: Version mismatch \(major\): texstudio.nsi: $TXS_NSI_MAJOR cpp: $TXS_MAJOR; exit; fi
if [[ $TXS_NSI_MINOR != $TXS_MINOR ]]; then echo Error: Version mismatch \(minor\): texstudio.nsi: $TXS_NSI_MINOR cpp: $TXS_MINOR; exit; fi
if [[ $TXS_NSI_BUILD != $TXS_BUILD ]]; then echo Error: Version mismatch \(build\): texstudio.nsi: $TXS_NSI_BUILD cpp: $TXS_BUILD; exit; fi
