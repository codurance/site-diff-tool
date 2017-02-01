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

    if [ ! -d "$outputFolder" ];
    then
        mkdir -p $outputFolder
    fi

    echo "Using $fileWithListOfUrls and creating screenshots in $outputFolder"
    cat $fileWithListOfUrls | parallel --keep-order -j10 --bar --use-cpus-instead-of-cores take-a-screenshot-of-a-page
}

take-a-screenshot-of-a-page() {
    websiteURL=$1
    
    time {
        outputfileFromTheUrl="$websiteURL"
        outputfileFromTheUrl=${websiteURL//[\:\/]/-}
        outputfileFromTheUrl="$outputfileFromTheUrl.jpeg"
        outputFileWithFullPath="$outputFolder/$outputfileFromTheUrl"

        echo "Taking screenshots with WebShot..."
        echo "********************************************************"
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

createOutput "urls-en.txt"
createOutput "urls-es.txt"