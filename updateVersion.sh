#/bin/bash


METADIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TXS_VERSION_CPP=`grep TXSVERSION src/utilsVersion.h | head -1 | cut -d " " -f 3 | tr -d "\"" | grep -oE [0-9.]+`
TXS_VERSION_MANPAGE=`grep TH utilities/texstudio.1 | head -1 | cut -d " " -f 5 | tr -d "\""`
TXS_VERSION_MANUAL=`grep release utilities/manual/source/conf.py | head -1 | grep -oE [0-9.]+ | tail -1`
TXS_VERSION_CHANGELOG=`grep TeXstudio utilities/manual/source/CHANGELOG.md | head -1 | grep -oE [0-9.]+ | tail -1`
TXS_VERSION_DEBIAN_CHANGELOG=`head -1 debian/changelog | grep -oE [0-9.]+ `
TXS_VERSION_SPEC=`grep Version: utilities/texstudio.spec | head -1 | grep -oE "[0-9.]+"`
TXS_VERSION_INFOPLIST=$(grep -A 1 CFBundleShortVersionString Info.plist | grep '<string>' | grep -oE "[0-9.]*")
TXS_VERSION_CMAKE=`grep ' VERSION' CMakeLists.txt | grep -oE [0-9.]+`
TXS_MAJOR=`echo $TXS_VERSION_CPP |cut -d "." -f 1`
TXS_MINOR=`echo $TXS_VERSION_CPP |cut -d "." -f 2`
TXS_BUILD=`echo $TXS_VERSION_CPP |cut -d "." -f 3`
TXS_NSI_MAJOR=`grep -oE "define VERSIONMAJOR.*[0-9]+" utilities/texstudio.nsi |grep -oE "[0-9]+"`
TXS_NSI_MINOR=`grep -oE "define VERSIONMINOR.*[0-9]+" utilities/texstudio.nsi |grep -oE "[0-9]+"`
TXS_NSI_BUILD=`grep -oE "define VERSIONBUILD.*[0-9]+" utilities/texstudio.nsi |grep -oE "[0-9]+"`
TXS_NSI2_MAJOR=`grep -oE "define VERSIONMAJOR.*[0-9]+" utilities/texstudio-msys.nsi |grep -oE "[0-9]+"`
TXS_NSI2_MINOR=`grep -oE "define VERSIONMINOR.*[0-9]+" utilities/texstudio-msys.nsi |grep -oE "[0-9]+"`
TXS_NSI2_BUILD=`grep -oE "define VERSIONBUILD.*[0-9]+" utilities/texstudio-msys.nsi |grep -oE "[0-9]+"`
DT=`date -R`
DT2=`date +%y\\-%m\\-%d`

if [[ "$TXS_VERSION_CPP" != "$TXS_VERSION_MANPAGE" ]]; 
then 
  echo "update manpage (utilities/texstudio.1):"
  sed -i "s/$TXS_VERSION_MANPAGE/$TXS_VERSION_CPP/" utilities/texstudio.1 
  sed -i "s/[0-9]\{4\}.-[0-9]\{1,2\}.-[0-9]\{1,2\}/$DT2/" utilities/texstudio.1
fi
if [[ "$TXS_VERSION_CPP" != "$TXS_VERSION_MANUAL" ]]; 
then 
  echo "update manual (utilities/manual/source):"
  sed -i "s/$TXS_VERSION_MANUAL/$TXS_VERSION_CPP/" utilities/manual/source/conf.py
fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_CHANGELOG ]]; then 
  echo "update: CHANGELOG.md:"
  sed -i "2s;^;TeXstudio $TXS_VERSION_CPP\n\n- \n\n;" utilities/manual/source/CHANGELOG.md
fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_DEBIAN_CHANGELOG ]]; then 
  echo "update: changelog (debian/changelog):"
  sed -i "1s;^;texstudio ($TXS_VERSION_CPP) unstable\; urgency=low\n\n   * new release\n\n -- Benito van der Zander <benibela@users.sourceforge.net>  $DT\n\n;" debian/changelog   
fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_SPEC ]]; then 
  echo "update spec (utitities/texstudio.spec)"
  sed -i "s/$TXS_VERSION_SPEC/$TXS_VERSION_CPP/" utilities/texstudio.spec
fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_INFOPLIST ]]; then 
  echo "update Info.plist"
  sed -i "s/$TXS_VERSION_INFOPLIST/$TXS_VERSION_CPP/" Info.plist
fi
if [[ $TXS_VERSION_CPP != $TXS_VERSION_CMAKE ]]; then 
  echo "update CMakeLists.txt"
  sed -i "s/ VERSION [0-9.]\+/ VERSION $TXS_VERSION_CPP/" CMakeLists.txt
fi
if [[ $TXS_NSI_MAJOR != $TXS_MAJOR ]]; then 
  echo "update texstudio.nsi \(major\)"
  sed -i "s/VERSIONMAJOR [0-9]\+/VERSIONMAJOR $TXS_MAJOR/" utilities/texstudio.nsi
fi
if [[ $TXS_NSI_MINOR != $TXS_MINOR ]]; then 
  echo "update texstudio.nsi \(minor\)"
  sed -i "s/VERSIONMINOR [0-9]\+/VERSIONMINOR $TXS_MINOR/" utilities/texstudio.nsi
fi
if [[ $TXS_NSI_BUILD != $TXS_BUILD ]]; then 
  echo "update texstudio.nsi \(build\)"
  sed -i "s/VERSIONBUILD [0-9]\+/VERSIONBUILD $TXS_BUILD/" utilities/texstudio.nsi
fi
if [[ $TXS_NSI2_MAJOR != $TXS_MAJOR ]]; then 
  echo "update texstudio-msys.nsi \(major\)"
  sed -i "s/VERSIONMAJOR [0-9]\+/VERSIONMAJOR $TXS_MAJOR/" utilities/texstudio-msys.nsi
fi
if [[ $TXS_NSI2_MINOR != $TXS_MINOR ]]; then 
  echo "update texstudio-msys.nsi \(minor\)"
  sed -i "s/VERSIONMINOR [0-9]\+/VERSIONMINOR $TXS_MINOR/" utilities/texstudio-msys.nsi
fi
if [[ $TXS_NSI2_BUILD != $TXS_BUILD ]]; then 
  echo "update texstudio-msys.nsi \(build\)"
  sed -i "s/VERSIONBUILD [0-9]\+/VERSIONBUILD $TXS_BUILD/" utilities/texstudio-msys.nsi
fi


