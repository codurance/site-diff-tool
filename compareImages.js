var resemble = require('node-resemble-js');
const args = process.argv;

const SOURCE=args[2];
const TARGET=args[3];
const TARGET_URL=args[4];

if (SOURCE == "") {
  console.log("Source file location has not been provided.")
}

if (TARGET == "") {
  console.log("Target file location has not been provided.")
}

var templateCompareResults = 
 `<div>
    <div>
      <div class='panel note'><p><strong>Target url:</strong> <a href='$TARGET_URL'/>$TARGET_URL</a></p>
      <p>Images are <strong>different</strong> and differs by <strong>$misMatchPercentage%</strong>. <strong>Dimension difference:</strong> $dimensionDifference</p>
      <p><strong>Source:</strong> $SOURCE <strong>Target:</strong> $TARGET </p>
    </div>
    <div class='container'>
      <img class="source-target-image-dimensions" alt='$SOURCE' src='$SOURCE'>
      <img class="source-target-image-dimensions" alt='$TARGET' src='$TARGET'>
    </div>
  </div>
  <br>
  <hr>`;

var diff = resemble(SOURCE).compareTo(TARGET).ignoreColors().onComplete(function(data){
    if (data.isSameDimensions) {
    } else {
      const result = templateCompareResults
                        .replace("$TARGET_URL", TARGET_URL)
                        .replace("$TARGET_URL", TARGET_URL)
                        .replace("$SOURCE", SOURCE)
                        .replace("$SOURCE", SOURCE)
                        .replace("$SOURCE", SOURCE)                        
                        .replace("$TARGET", TARGET)
                        .replace("$TARGET", TARGET)
                        .replace("$TARGET", TARGET)
                        .replace("$misMatchPercentage", data.misMatchPercentage)
                        .replace("$dimensionDifference", JSON.stringify(data.dimensionDifference));
      console.log(result);
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