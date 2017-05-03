#!/bin/sh

PROJECT="ClearSpotifyCache"
APPNAME="Clear Spotify Cache"
VERSION="1.0.0"
SDK="macosx"
ARCHIVE="./archive"
APPDIR="./Applications"
SIGN_FOR_APP="Developer ID Application"
SIGN_FOR_INSTALLER="Developer ID Installer"
SIGNED=0
TEST=0

function usage()
{
	CMDNAME=`basename $0`
	echo "Usage: $CMDNAME [-s] [-c] [-a VALUE] [-i VALUE]" 1>&2
	echo "Options" 1>&2
	echo " -s  signed app and installer " 1>&2
	echo " -c  clean build, means build jar file and do xcode testing" 1>&2
	echo " -a: signed identifier for app file. Default value is \"Developer ID Application\"" 1>&2
	echo " -i: signed identifier for installer. Default value is \"Developer ID Installer\"" 1>&2
}

# set variable
while getopts sca:i: OPT
do
	case $OPT in
	"s" ) SIGNED=1;;
	"c" ) TEST=1;;
	"a" ) SIGN_FOR_APP="$OPTARG" ;;
	"i" ) SIGN_FOR_INSTALLER="$OPTARG" ;;
	* ) usage; exit 1 ;;
	esac
done

# move script root dir
cd `dirname $0`

# do test
if [ $TEST == 1  ]; then
	# Create dummy server setting file if not exist
	if [ ! -f ${TEST_SERVER_INFO} ]; then
		touch ${TEST_SERVER_INFO}
	fi

	# test xcode project
	xcodebuild test -project ${PROJECT}.xcodeproj \
		-scheme ${PROJECT} || exit 1
fi

# Build xcode project

# Create temporary dir
if [ ! -d $APPDIR ]; then
	mkdir $APPDIR
fi

xcodebuild -project ${PROJECT}.xcodeproj \
	-scheme $PROJECT \
	-archivePath $ARCHIVE archive \
	-sdk $SDK || exit 1

xcodebuild -exportArchive -exportFormat app \
	-archivePath ${ARCHIVE}.xcarchive -exportPath "${APPDIR}/${APPNAME}"

if [ $SIGNED == 1 ]; then
	# signed to app itself
	codesign -f -s "${SIGN_FOR_APP}" "${APPDIR}/${APPNAME}.app"
	echo "Add signature to app file"
fi

# packaging
pkgbuild --root $APPDIR \
	--identifier com.spotify.$PROJECT \
	--version $VERSION \
	--install-location /Applications \
	${PROJECT}.pkg || exit 1

# clean up
rm -r $APPDIR
rm -r ${ARCHIVE}.xcarchive

exit 0
