#!/bin/bash

#
# Usage:
#
#         $ ./compareSites.sh [source folder] [target folder]
#
#    Example:
#
#         $ ./compareSites.sh goldenMaster refactor-custom-css-file-media-queries
#

export sourceFolder=$1
export targetFolder=$2

compareAnyTwoSites(){
	websiteURL=$1

	imageFilename="$websiteURL"
	imageFilename=${websiteURL//[\:\/]/-}
	imageFilename="$imageFilename.jpeg"

    compareSourceAndTarget $sourceFolder/$imageFilename $targetFolder/$imageFilename $websiteURL
}

compareAnyTwoSitesSitesForBothLanguages() {
	cat "urls-en.txt" | parallel --keep-order -j10 --bar --use-cpus-instead-of-cores compareAnyTwoSites
	cat "urls-es.txt" | parallel --keep-order -j10 --bar --use-cpus-instead-of-cores compareAnyTwoSites	
}

checkIfFileExists() {
	if [ -f $1 ];
		then
		echo "1"
		return
	fi

	echo "$1 does not exist"
}

compareSourceAndTarget() {
	sourceImage=$1
	targetImage=$2
	url=$3

	sourceExists=$(checkIfFileExists $sourceImage)
	targetExists=$(checkIfFileExists $targetImage)

	if [[ "$sourceExists" == "1" ]] && [[ "$targetExists" == "1" ]];
		then
		node compareImages.js "$sourceImage" "$targetImage" "$url"
	else 
		echo "Skipping comparison as source or target or both are missing."
	fi	
}

export -f compareAnyTwoSites
export -f compareAnyTwoSitesSitesForBothLanguages
export -f checkIfFileExists
export -f compareSourceAndTarget

compareAnyTwoSitesSitesForBothLanguages
