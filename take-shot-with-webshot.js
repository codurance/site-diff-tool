'use.strict'

var webshot = require('webshot');
var fileExists = require('file-exists');

var args = process.argv;

var maxWidth = 1024;
var maxHeight = 768;

var options = {
  screenSize: {
    width: maxWidth
  , height: maxHeight
  }
, shotSize: {
    width: maxWidth
  , height: 'all'
  }
, userAgent: 'Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_2 like Mac OS X; en-us)'
    + ' AppleWebKit/531.21.20 (KHTML, like Gecko) Mobile/7B298g'
};

const websiteURL = args[2];
const outputFile = args[3];

if (fileExists(outputFile)) {
	console.log("*** Skipping " + outputFile + " , already exists ***");
} else {
	console.log("Working on " + outputFile);
	webshot(websiteURL, outputFile, options, function(err) {
  		// screenshot now saved to Output file
	});	
}