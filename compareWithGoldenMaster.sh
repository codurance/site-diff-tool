#!/bin/bash

#
# Usage:
#
#         $ ./compareWithGoldenMaster.sh [source folder] [target folder]
#
#    Example:
#
#         $ ./compareWithGoldenMaster.sh goldenMaster refactor-custom-css-file-media-queries
#

sourceFolder=$1
targetFolder=$2

compare(){
	fileWithListOfUrls=$1

	totalUrls=$(cat $fileWithListOfUrls| wc -l)
    totalUrls=$(echo $totalUrls | tr -d '[:space:]')
    urlCounter=0

	while read -r websiteURL
	do
		# START=$(date +%s)

		urlCounter=$[$urlCounter +1]

		websiteURL="$websiteURL"
		imageFilename="$websiteURL"
		imageFilename=${websiteURL//[\:\/]/-}
		imageFilename="$imageFilename.jpeg"

	    # echo "********************************************************"
	    echo -ne "Progress: $urlCounter of $totalUrls url(s) in $fileWithListOfUrls"
	    # echo "Comparing"
	    # echo "$sourceFolder/$imageFilename"
	    # echo "with"
	    # echo "$targetFolder/$imageFilename"
	    # echo "********************************************************"

	     /usr/bin/time ./compareSourceAndTarget.sh $sourceFolder/$imageFilename $targetFolder/$imageFilename

	 #    END=$(date +%s)
		# DIFF=$(( $END - $START ))
		# echo "...It took $DIFF second(s)."
	    # echo "********************************************************"
	    echo ""
	done < "$fileWithListOfUrls"
}

compareBothSites() {
	compare "urls-en.txt"
	compare "urls-es.txt"
}

#START=$(date +%s)
compareBothSites
#END=$(date +%s)
#DIFF=$(( $END - $START ))
#echo "The whole site comparison took $DIFF second(s)."
