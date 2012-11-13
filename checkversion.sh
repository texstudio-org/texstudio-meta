#/bin/bash

TXS_VERSION_CPP=`grep TXSVERSION smallUsefulFunctions.h | head -1 | cut -d " " -f 3 | tr -d "\"" | grep -oE [0-9.]+`
TXS_VERSION_MANPAGE=`grep TH utilities/texstudio.1 | head -1 | cut -d " " -f 5 | tr -d "\""`
TXS_VERSION_DEBIAN_CHANGELOG=`head -1 debian/changelog | grep -oE [0-9.]+ `
TXS_VERSION_ISS1=`grep AppVer utilities/notInBinary/texstudio.iss | head -1 | grep -oE [0-9.]+`
TXS_VERSION_ISS2=`grep AppVer utilities/notInBinary/texstudio.iss | head -1 | grep -oE [0-9.]+`
TXS_VERSION_MANUAL=`grep SECTIONNEW utilities/usermanual_en.html | head -2 | tail -1 | grep -oE "Version +[0-9.]+" | tail -1 | grep -oE [0-9.]+`

if [[ "$TXS_VERSION_CPP" != "$TXS_VERSION_MANPAGE" ]]; 
then echo Error: Version mismatch: "manpage (utilities/texstudio.1):" -$TXS_VERSION_MANPAGE- cpp: -$TXS_VERSION_CPP-; 
exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_DEBIAN_CHANGELOG ]]; then echo Error: "Version mismatch: changelog (debian/changelog):" $TXS_VERSION_DEBIAN_CHANGELOG cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_ISS1 ]]; then echo Error: Version mismatch: iss: $TXS_VERSION_ISS1 cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_ISS2 ]]; then echo Error: Version mismatch: iss 2: $TXS_VERSION_ISS2 cpp: $TXS_VERSION_CPP; exit; fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_MANUAL ]]; then echo Error: Version mismatch: manual: $TXS_VERSION_MANUAL cpp: $TXS_VERSION_CPP; exit; fi
