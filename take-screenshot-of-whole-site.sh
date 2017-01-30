#!/bin/bash

#
# Usage:
#
#         $ ./take-screenshot-of-whole-site.sh [output folder]
#
#    Example:
#
#         $ ./take-screenshot-of-whole-site.sh refactor-css-and-html
#

outputFolder=${1:-'goldenMaster'};

take-screen-of-url() {
    urlCounter=$[$urlCounter +1]
    websiteURL="$websiteURL"
    outputfileWithListOfUrls="$websiteURL"
    outputfileWithListOfUrls=${websiteURL//[\:\/]/-}
    outputfileWithListOfUrls="$outputfileWithListOfUrls.jpeg"

    echo ""
    echo "********************************************************"
    echo "Progress: $urlCounter of $totalUrls url(s) from $fileWithListOfUrls"
    echo "Visiting $websiteURL"
    ./take-a-screenshot-of-a-page.sh "$websiteURL" "$outputFolder/$outputfileWithListOfUrls"
    echo "Page captured to $outputFolder/$outputfileWithListOfUrls"
    echo "********************************************************"
}

createOutput() {
    fileWithListOfUrls=$1
    totalUrls=$(cat $fileWithListOfUrls| wc -l)
    totalUrls=$(echo $totalUrls | tr -d '[:space:]')
    urlCounter=0

    if [ ! -d "$outputFolder" ];
    then
        mkdir -p $outputFolder
    fi

    while read -r websiteURL
    do
        #parallel -k take-screen-of-url --pipe < "$fileWithListOfUrls"
        take-screen-of-url websiteURL
    done < "$fileWithListOfUrls"
}

START=$(date +%s)
createOutput "urls-en.txt"
createOutput "urls-es.txt"
END=$(date +%s)
DIFF=$(( $END - $START ))
echo "The process of capturing the whole site took $DIFF second(s)."
