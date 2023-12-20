// Chrome 1 - 79
// var isChrome = !!window.chrome && (!!window.chrome.webstore || !!window.chrome.runtime);
var isChrome = navigator.userAgent.indexOf("Chrome") !== -1;

// Edge (based on chromium) detection
var isEdgeChromium = navigator.userAgent.indexOf("Edg") != -1;

var newLine = "\r\n"

if(!isEdgeChromium && !isChrome) {
    var msg = 'NOTICE: Website under development!';
    msg += newLine;
    msg += newLine;
    msg += 'This website may not display correctly in this browser.';
    msg += newLine;
    msg += 'We recommend using Chrome or a Chromium-based browser to view this site.';
    alert(msg);
}