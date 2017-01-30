#!/bin/bash

#
# Usage:
#
#         $ ./take-a-screenshot-of-a-page.sh [website URL] [output filename]
#
#    Example:
#
#         $ ./take-a-screenshot-of-a-page.sh http://www.google.com GoogleHomePage.jpeg
#

webURL=$1
outputFile=$2

START=$(date +%s)
echo "Taking screenshots with WebShot..."
node take-shot-with-webshot.js "$webURL" "$outputFile"

while [ ! -f $outputFile  ] ;
do
      echo -ne "."
      sleep 1
done

END=$(date +%s)
DIFF=$(( $END - $START ))
echo "...It took $DIFF seconds."
echo ""