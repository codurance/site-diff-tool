#!/bin/bash

#
# Usage:
#
#         $ ./get-urls-from-site.sh [website]
#
#    Example:
#
#         $ ./get-urls-from-site.sh http://www.google.com
#

PORT="4000"
WEBSITE=${1-"http://localhost"}":$PORT"

crawlSite() {
	LANG=$1
	LANGUAGE_SUBSTITUTION="s/\:$PORT/:$PORT$LANG/g"

	echo "Fetching all urls from $WEBSITE (recursively), saving it into $OUTPUT_FILE"
	rm $OUTPUT_FILE
	wget --spider --recursive --force-html -l3 $WEBSITE 2>&1 \
  | grep '^--' | awk '{ print $3 }' \
  | grep -v '\.\(css\|js\|png\|gif\|jpg\|jpeg\|txt\|svg\|ico\|xml\)$' \
  | grep -v '\%7B\%7Blink\%7D\%7D' \
  | sort \
  | sed 's/\(.*\)\/$/\1/g' \
  | sed $(echo "$LANGUAGE_SUBSTITUTION")   \
  | uniq > $OUTPUT_FILE && rm -fr $WEBSITE
	echo ""
	
	cat $OUTPUT_FILE
	echo "$(cat $OUTPUT_FILE| wc -l) urls found."
}

OUTPUT_FILE="urls-en.txt"
echo ""
echo "****************************************************************"
echo "Crawling for English links to site"
echo "****************************************************************"
crawlSite ""

OUTPUT_FILE="urls-es.txt"
echo ""
echo "****************************************************************"
echo "Crawling for Spanish links to site"
echo "****************************************************************"
crawlSite "\/es"