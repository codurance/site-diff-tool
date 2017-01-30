#!/bin/bash

#
# Usage:
#
#         $ ./compareImages.sh [source image] [target image]
#
#    Example:
#
#         $ ./compareImages.sh goldenMaster/somePage.jpeg anotherBranch/someOtherPage.jpeg
#

checkIfFileExists() {
	if [ -f $1 ];
		then
		echo "1"
		return
	fi

	echo "$1 does not exist"
}

sourceImage=$1
targetImage=$2

sourceExists=$(checkIfFileExists $sourceImage)
targetExists=$(checkIfFileExists $targetImage)

if [[ "$sourceExists" == "1" ]] && [[ "$targetExists" == "1" ]];
	then
	node compareImages.js "$sourceImage" "$targetImage"
else 
	echo "Skipping comparison as source or target or both are missing."
fi