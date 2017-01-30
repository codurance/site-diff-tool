var resemble = require('node-resemble-js');
const args = process.argv;

const SOURCE=args[2];
const TARGET=args[3];

if (SOURCE == "") {
  console.log("Source file location has not been provided")
}

if (TARGET == "") {
  console.log("Target file location has not been provided")
}

var diff = resemble(SOURCE).compareTo(TARGET).ignoreColors().onComplete(function(data){
    if (data.isSameDimensions) {
    	//console.log("The files are the same.")
    } else {
    	console.log(SOURCE + " is different from " + TARGET + " and differs by " + data.misMatchPercentage + "%");
	    console.log("Dimension difference: " + data.dimensionDifference);
    };
    /*
    {
      misMatchPercentage : 100, // %
      isSameDimensions: true, // or false
      dimensionDifference: { width: 0, height: -1 }, // defined if dimensions are not the same
      getImageDataUrl: function(){}
    }
    */
});