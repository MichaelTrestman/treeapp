// Constants:

var leftArrow  = 37;  // Key code for the left arrow key.
var upArrow    = 38;
var rightArrow = 39;
var downArrow  = 40;
var panRate    = 10;  // Number of pixels to pan per key press.
var zoomIn = 187;
var zoomOut = 189;
var viewbox;
/* Global variables: */
// var theSvgElement = document.getElementsByClass('svg-canvas')[0];

var theSvgElement = $('svg')[0];

if (theSvgElement) {
  console.log(theSvgElement);
  viewbox = theSvgElement.getAttribute('viewBox');  // Grab the object representing the SVG element's viewBox attribute.

  console.log(viewbox);
};

function processKeyPress(evt)
{


  viewbox = theSvgElement.getAttribute('viewBox');  // Grab the object representing the SVG element's


  var viewBoxValues = viewbox.split(' ').map(function(val){ return parseFloat(val); })

  switch (evt.keyCode)
  {
    case leftArrow:
      evt.preventDefault();
      viewBoxValues[0] += panRate;  // Increase the x-coordinate value of the viewBox attribute by the amount given by panRate.
      break;
    case rightArrow:
      evt.preventDefault();
      viewBoxValues[0] -= panRate;  // Decrease the x-coordinate value of the viewBox attribute by the amount given by panRate.
      break;
    case upArrow:
      evt.preventDefault();
      viewBoxValues[1] += panRate;  // Increase the y-coordinate value of the viewBox attribute by the amount given by panRate.          break;
      break;
    case downArrow:
      evt.preventDefault();
      viewBoxValues[1] -= panRate;  // Decrease the y-coordinate value of the viewBox attribute by the amount given by panRate.          break;
      break;
    case zoomIn:
      evt.preventDefault();
      viewBoxValues[2] -= 10;
      // viewBoxValues[3] += 1;
      break;
    case zoomOut:
      evt.preventDefault();
      viewBoxValues[2] += 10;
      // viewBoxValues[3] -= 1;
      break;
  } // switch

  theSvgElement.setAttribute('viewBox', viewBoxValues.join(' '));

}


  if (theSvgElement) {
    window.addEventListener('keydown', processKeyPress, true);

  };
