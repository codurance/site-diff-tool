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

export outputFolder=${1:-'goldenMaster'};

createOutput() {
    fileWithListOfUrls=$1
    totalUrls=$(cat $fileWithListOfUrls| wc -l)
    totalUrls=$(echo $totalUrls | tr -d '[:space:]')
    urlCounter=0

    if [ ! -d "$outputFolder" ];
    then
        mkdir -p $outputFolder
    fi

    echo "Using $fileWithListOfUrls and creating screenshots in $outputFolder"
    cat $fileWithListOfUrls | parallel -k --bar --use-cpus-instead-of-cores take-a-screenshot-of-a-page
}

take-a-screenshot-of-a-page() {
    websiteURL=$1
    urlCounter=$[$urlCounter +1]

    time {
        outputfileFromTheUrl="$websiteURL"
        outputfileFromTheUrl=${websiteURL//[\:\/]/-}
        outputfileFromTheUrl="$outputfileFromTheUrl.jpeg"
        outputFileWithFullPath="$outputFolder/$outputfileFromTheUrl"

        echo "Taking screenshots with WebShot..."
        echo "********************************************************"
        echo "Progress: $urlCounter of $totalUrls url(s)"
        echo "Visiting $websiteURL"

        node take-shot-with-webshot.js "$websiteURL" "$outputFileWithFullPath"

        while [ ! -f $outputFileWithFullPath  ] ;
        do
              echo -ne "."
              sleep 1
        done
        echo "********************************************************"
    }
}

export -f take-a-screenshot-of-a-page
export -f createOutput
export urlCounter=0
export totalUrls=0

createOutput "urls-en.txt"
createOutput "urls-es.txt"