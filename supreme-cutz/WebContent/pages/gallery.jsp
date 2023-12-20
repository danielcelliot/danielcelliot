<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - Supreme Cutz Barbershop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">
    <link rel="stylesheet" href="../css/core.css">
    <link rel="stylesheet" href="../css/gallery.css">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <link rel="icon" href="../favicon.ico" type="image/x-icon">
</head>
<body>
  <div class="container">
    <header>
      <div class="menu-logo--wrapper">
          <div class="menu-btn" onclick="show()">
              <div class="menu-btn--burger"></div>
          </div>
          <div class="logo-container">
              <a href="../index.jsp">
                <%-- <svg class="logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 177.778 100"><path d="M31.941,62.825h25.65V37.175H31.941ZM52.654,47.532h-5.42v-5.42h5.42Zm-15.777-5.42H42.3V52.468H52.654v5.42H36.877Zm37.417-4.937A12.825,12.825,0,1,0,87.119,50,12.84,12.84,0,0,0,74.294,37.175Zm0,20.713A7.888,7.888,0,1,1,82.182,50,7.9,7.9,0,0,1,74.294,57.888Zm58.719-20.713A12.825,12.825,0,1,0,145.837,50,12.84,12.84,0,0,0,133.013,37.175Zm0,20.713A7.888,7.888,0,1,1,140.9,50,7.9,7.9,0,0,1,133.013,57.888Zm-29.36-20.713A12.825,12.825,0,1,0,116.478,50,12.84,12.84,0,0,0,103.653,37.175Zm0,20.713a7.888,7.888,0,1,1,7.488-10.356h-7.488v4.936h7.488A7.9,7.9,0,0,1,103.653,57.888Z" fill="#394149"/></svg> --%>
                <svg id="logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 396.876 55.547">
                  <title>brand-name</title>
                  <g id="supreme">
                      <path d="M114.284,525.527a2.557,2.557,0,0,1-.715,1.875,2.494,2.494,0,0,1-1.863.727h-9.234a2.575,2.575,0,0,1-1.887-.727,2.515,2.515,0,0,1-.738-1.875v-9.3H103.1v9.023h7.922V516.5L100.9,504.27a4.26,4.26,0,0,1-1.054-2.79v-7.429a2.515,2.515,0,0,1,.738-1.875,2.575,2.575,0,0,1,1.887-.727h9.234a2.494,2.494,0,0,1,1.863.727,2.557,2.557,0,0,1,.715,1.875v8.531h-3.258v-8.25H103.1v7.734L113.276,514.3a4.189,4.189,0,0,1,1.008,2.742Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                      <path d="M148.7,525.527a2.512,2.512,0,0,1-.739,1.875,2.574,2.574,0,0,1-1.886.727h-9.985a2.489,2.489,0,0,1-2.6-2.6V491.449h3.258v33.8h8.7v-33.8H148.7Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                      <path d="M182.531,510.949a2.527,2.527,0,0,1-2.625,2.625h-8.648v14.555H168v-36.68h11.906a2.575,2.575,0,0,1,1.887.727,2.515,2.515,0,0,1,.738,1.875Zm-3.258-.281V494.332h-8.015v16.336Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                      <path d="M216.737,528.129h-3.422l-6.82-19.641.445-.656h5.812v-13.5h-8.367v33.8h-3.258v-36.68h12.282a2.489,2.489,0,0,1,2.6,2.6v13.922q0,2.647-3.562,2.648c-.235,0-.578-.012-1.031-.035s-.782-.035-.985-.035Q213.6,519.317,216.737,528.129Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                      <path d="M247.1,528.129H235.052v-36.68h11.906v2.883H238.31V508.02h7.875v2.929H238.31v14.3H247.1Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                      <path d="M283.766,528.129H280.7V504.9q0-.492.328-2.882l-6,22.664h-.656l-6-22.664q.329,2.414.328,2.882v23.227h-3.07v-36.68h3.023l5.954,23.86a8.423,8.423,0,0,1,.093,1.054,8.858,8.858,0,0,1,.094-1.054l5.953-23.86h3.024Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                      <path d="M315.111,528.129H303.064v-36.68h11.907v2.883h-8.649V508.02H314.2v2.929h-7.875v14.3h8.789Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                  </g>
                  <g id="cutz">
                      <path d="M395.043,524.777q0,3.352-3.352,3.352H380.254q-3.258,0-3.258-3.352V494.824q0-3.375,3.258-3.375h11.437q3.353,0,3.352,3.375V503.4h-5.461V496.16h-7.1v27.258h7.1v-7.711h5.461Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                      <path d="M431.146,524.777q0,3.352-3.375,3.352H416.123q-3.329,0-3.328-3.352V491.449h5.484v31.969h7.383V491.449h5.484Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                      <path d="M464.931,496.3h-6.047v31.828h-5.461V496.3h-6.047v-4.852h17.555Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                      <path d="M496.723,528.129H479.871V525.2l10.266-28.8h-9.446v-4.946h15.985v3.164l-10.242,28.571h10.289Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                  </g>
                  <g id="separator">
                      <path d="M349.476,535.728h-4.571V480.181h4.571Z" transform="translate(-99.847 -480.181)" style="fill: #ed1c24"/>
                  </g>
                </svg>
              </a>
          </div>
      </div>
      <ul class="nav-pri">
        <li>
            <a href="mailto:contact@supremecutz.com"><div class="link"><i class="fas fa-calendar-alt"></i>
                <span>make appointment</span>
            </div></a>
        </li>
        <li>
            <a href="callto:1868-555-1234"><div class="link"><i class="fas fa-phone-alt"></i>
                <span>call now</span>
            </div></a>
        </li>
        <li>
          <a target="_blank" href="https://www.google.com/maps/dir//10.6364788,-61.274698/@10.636479,-61.274698,16z?hl=en"><div class="link"><i class="fas fa-directions"></i>
                <span>get directions</span>
            </div></a>
        </li>
    </ul>
      <ul class="nav-sec">
          <li><a href="./cart.jsp" title="View cart">
              <i class="fas fa-shopping-cart fa-2x is-showing"></i>
              <i class="fas fa-cart-plus fa-2x"></i>
          </a></li>
                <li><a href="../scriptlets/verifySession.jsp?param1=../pages/customer-login.jsp" title="Sign in"><i class="fas fa-user-circle fa-2x"></i></a></li>
      </ul>
    </header>

    <nav class="sidebar-nav">
      <div class="nav-wrapper">
          <ul class="nav-vert">
              <li><a href="./about.jsp" class="page-link">about</a></li>
              <li><a href="./barbers.jsp" class="page-link">barbers</a></li>
              <li><a href="./contact-us.jsp" class="page-link">contact us</a></li>
              <li><a href="#" class="page-link">gallery</a></li>
              <li><a href="./prices.jsp" class="page-link">pricing</a></li>
              <li><a href="./products.jsp" class="page-link">products</a></li>
          </ul>
      </div>
    </nav>

    <main>
      <div class="m-p-g" style="margin-top: 1%; margin-bottom: 1%;">
        <div class="m-p-g__thumbs" data-google-image-layout data-max-height="350">
            <img src="../img/gallery/0-thumb.jpg" data-full="../img/gallery/0.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/1-thumb.jpg" data-full="../img/gallery/1.jpg" class="m-p-g__thumbs-img" />
            <!-- <img src="../img/gallery/2-thumb.jpg" data-full="../img/gallery/2.jpg" class="m-p-g__thumbs-img" /> -->
            <img src="../img/gallery/3-thumb.jpg" data-full="../img/gallery/3.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/4-thumb.jpg" data-full="../img/gallery/4.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/5-thumb.jpg" data-full="../img/gallery/5.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/6-thumb.jpg" data-full="../img/gallery/6.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/7-thumb.jpg" data-full="../img/gallery/7.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/8-thumb.jpg" data-full="../img/gallery/8.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/9-thumb.jpg" data-full="../img/gallery/9.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/10-thumb.jpg" data-full="../img/gallery/10.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/11-thumb.jpg" data-full="../img/gallery/11.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/12-thumb.jpg" data-full="../img/gallery/12.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/13-thumb.jpg" data-full="../img/gallery/13.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/14-thumb.jpg" data-full="../img/gallery/14.jpg" class="m-p-g__thumbs-img" />
            <img src="../img/gallery/15-thumb.jpg" data-full="../img/gallery/15.jpg" class="m-p-g__thumbs-img" />
        </div>
          <div class="m-p-g__fullscreen"></div>
      </div>
    </main>

    <footer>
      <div class="footer-wrapper">
          <div class="footer-heading">
              <%-- <svg class="footer-logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 177.778 100"><path d="M31.941,62.825h25.65V37.175H31.941ZM52.654,47.532h-5.42v-5.42h5.42Zm-15.777-5.42H42.3V52.468H52.654v5.42H36.877Zm37.417-4.937A12.825,12.825,0,1,0,87.119,50,12.84,12.84,0,0,0,74.294,37.175Zm0,20.713A7.888,7.888,0,1,1,82.182,50,7.9,7.9,0,0,1,74.294,57.888Zm58.719-20.713A12.825,12.825,0,1,0,145.837,50,12.84,12.84,0,0,0,133.013,37.175Zm0,20.713A7.888,7.888,0,1,1,140.9,50,7.9,7.9,0,0,1,133.013,57.888Zm-29.36-20.713A12.825,12.825,0,1,0,116.478,50,12.84,12.84,0,0,0,103.653,37.175Zm0,20.713a7.888,7.888,0,1,1,7.488-10.356h-7.488v4.936h7.488A7.9,7.9,0,0,1,103.653,57.888Z" fill="#394149"/></svg> --%>
              <svg id="footer-logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200.416 166.352">
                <title>brand-logo-alt</title>
                <rect id="SC-box" x="6.5" y="6.5" width="187.416" height="153.352" style="fill: none;stroke: #231f20;stroke-miterlimit: 10;stroke-width: 13px"/>
                <g id="s">
                    <path d="M304.129,514.079q0,8.939-8.876,8.937l-29.437,0q-8.812,0-8.812-8.938V490.764H271.63V510.7H289.5V491.516L260.2,463.764a10.359,10.359,0,0,1-3.187-7.813V434.2q0-9,8.813-9l29.438,0q8.874,0,8.874,8.876v21.875H289.508V437.516H271.634V455.2l29.31,27.627a10.388,10.388,0,0,1,3.187,7.938Z" transform="translate(-210.815 -389.29)" style="fill: #231f20"/>
                </g>
                <g id="c">
                    <path d="M365.133,514.076q0,8.938-8.938,8.938H325.7q-8.688,0-8.687-8.938V434.2q0-9,8.687-9h30.5q8.937,0,8.938,9v22.875H350.57V437.764H331.633v72.687H350.57V489.889h14.563Z" transform="translate(-210.815 -389.29)" style="fill: #ed1c24"/>
                </g>
              </svg>
          </div>
          <div class="footer-links-container">
              <div class="site-links">
                  <span>Main pages</span>
                  <a href="./about.jsp">About</a>
                  <a href="./barbers.jsp">Barbers</a>
                  <a href="./contact-us.jsp">Contact Us</a>
                  <a href="./gallery.jsp">Gallery</a>
                  <a href="./prices.jsp">Pricing</a>
                  <a href="./products.jsp">Products</a>
              </div>
              <div class="site-links">
                  <span>Book Appointment</span>
                  <a href="mailto:contact@supremecutz.com"><i class="fas fa-envelope"></i>contact@supremecutz.com</a>
                  <a href="callto:1868-555-1234"><i class="fas fa-phone-alt"></i>(868)-555-1234</a>
                  <a target="_blank" href="https://www.google.com/maps/dir//10.6364788,-61.274698/@10.636479,-61.274698,16z?hl=en"><i class="fas fa-directions"></i>#22 Fiddlers Dream St., Arima</a>
              </div>
              <div class="site-links">
                <span>Follow us</span>
                  <div class="social-media">
                      <i class="fab fa-instagram"></i>
                      <i class="fab fa-whatsapp"></i>
                      <i class="fab fa-facebook"></i>
                      <i class="fab fa-twitter"></i>
                  </div>
                  <div class="proudtt-logo"><img src="../img/proud-logo.png" alt="" srcset=""></div>
                  <div class="copyright">&copy 2020 Supreme Cutz Barbershop Ltd.</div>
              </div>
          </div>
      </div>
  </footer>
  </div>

  <script src="../js/index.js"></script>
  <!-- Material Photo Gallery JavaScript library-->
  <script>
(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
/*!
 * eventie v1.0.6
 * event binding helper
 *   eventie.bind( elem, 'click', myFn )
 *   eventie.unbind( elem, 'click', myFn )
 * MIT license
 */

/*jshint browser: true, undef: true, unused: true */
/*global define: false, module: false */

( function( window ) {

'use strict';

var docElem = document.documentElement;

var bind = function() {};

function getIEEvent( obj ) {
  var event = window.event;
  // add event.target
  event.target = event.target || event.srcElement || obj;
  return event;
}

if ( docElem.addEventListener ) {
  bind = function( obj, type, fn ) {
    obj.addEventListener( type, fn, false );
  };
} else if ( docElem.attachEvent ) {
  bind = function( obj, type, fn ) {
    obj[ type + fn ] = fn.handleEvent ?
      function() {
        var event = getIEEvent( obj );
        fn.handleEvent.call( fn, event );
      } :
      function() {
        var event = getIEEvent( obj );
        fn.call( obj, event );
      };
    obj.attachEvent( "on" + type, obj[ type + fn ] );
  };
}

var unbind = function() {};

if ( docElem.removeEventListener ) {
  unbind = function( obj, type, fn ) {
    obj.removeEventListener( type, fn, false );
  };
} else if ( docElem.detachEvent ) {
  unbind = function( obj, type, fn ) {
    obj.detachEvent( "on" + type, obj[ type + fn ] );
    try {
      delete obj[ type + fn ];
    } catch ( err ) {
      // can't delete window object properties
      obj[ type + fn ] = undefined;
    }
  };
}

var eventie = {
  bind: bind,
  unbind: unbind
};

// ----- module definition ----- //

if ( typeof define === 'function' && define.amd ) {
  // AMD
  define( eventie );
} else if ( typeof exports === 'object' ) {
  // CommonJS
  module.exports = eventie;
} else {
  // browser global
  window.eventie = eventie;
}

})( window );

},{}],2:[function(require,module,exports){
/*!
 * imagesLoaded v3.2.0
 * JavaScript is all like "You images are done yet or what?"
 * MIT License
 */

( function( window, factory ) { 'use strict';
  // universal module definition

  /*global define: false, module: false, require: false */

  if ( typeof define == 'function' && define.amd ) {
    // AMD
    define( [
      'eventEmitter/EventEmitter',
      'eventie/eventie'
    ], function( EventEmitter, eventie ) {
      return factory( window, EventEmitter, eventie );
    });
  } else if ( typeof module == 'object' && module.exports ) {
    // CommonJS
    module.exports = factory(
      window,
      require('wolfy87-eventemitter'),
      require('eventie')
    );
  } else {
    // browser global
    window.imagesLoaded = factory(
      window,
      window.EventEmitter,
      window.eventie
    );
  }

})( window,

// --------------------------  factory -------------------------- //

function factory( window, EventEmitter, eventie ) {

'use strict';

var $ = window.jQuery;
var console = window.console;

// -------------------------- helpers -------------------------- //

// extend objects
function extend( a, b ) {
  for ( var prop in b ) {
    a[ prop ] = b[ prop ];
  }
  return a;
}

var objToString = Object.prototype.toString;
function isArray( obj ) {
  return objToString.call( obj ) == '[object Array]';
}

// turn element or nodeList into an array
function makeArray( obj ) {
  var ary = [];
  if ( isArray( obj ) ) {
    // use object if already an array
    ary = obj;
  } else if ( typeof obj.length == 'number' ) {
    // convert nodeList to array
    for ( var i=0; i < obj.length; i++ ) {
      ary.push( obj[i] );
    }
  } else {
    // array of single index
    ary.push( obj );
  }
  return ary;
}

  // -------------------------- imagesLoaded -------------------------- //

  /**
   * @param {Array, Element, NodeList, String} elem
   * @param {Object or Function} options - if function, use as callback
   * @param {Function} onAlways - callback function
   */
  function ImagesLoaded( elem, options, onAlways ) {
    // coerce ImagesLoaded() without new, to be new ImagesLoaded()
    if ( !( this instanceof ImagesLoaded ) ) {
      return new ImagesLoaded( elem, options, onAlways );
    }
    // use elem as selector string
    if ( typeof elem == 'string' ) {
      elem = document.querySelectorAll( elem );
    }

    this.elements = makeArray( elem );
    this.options = extend( {}, this.options );

    if ( typeof options == 'function' ) {
      onAlways = options;
    } else {
      extend( this.options, options );
    }

    if ( onAlways ) {
      this.on( 'always', onAlways );
    }

    this.getImages();

    if ( $ ) {
      // add jQuery Deferred object
      this.jqDeferred = new $.Deferred();
    }

    // HACK check async to allow time to bind listeners
    var _this = this;
    setTimeout( function() {
      _this.check();
    });
  }

  ImagesLoaded.prototype = new EventEmitter();

  ImagesLoaded.prototype.options = {};

  ImagesLoaded.prototype.getImages = function() {
    this.images = [];

    // filter & find items if we have an item selector
    for ( var i=0; i < this.elements.length; i++ ) {
      var elem = this.elements[i];
      this.addElementImages( elem );
    }
  };

  /**
   * @param {Node} element
   */
  ImagesLoaded.prototype.addElementImages = function( elem ) {
    // filter siblings
    if ( elem.nodeName == 'IMG' ) {
      this.addImage( elem );
    }
    // get background image on element
    if ( this.options.background === true ) {
      this.addElementBackgroundImages( elem );
    }

    // find children
    // no non-element nodes, #143
    var nodeType = elem.nodeType;
    if ( !nodeType || !elementNodeTypes[ nodeType ] ) {
      return;
    }
    var childImgs = elem.querySelectorAll('img');
    // concat childElems to filterFound array
    for ( var i=0; i < childImgs.length; i++ ) {
      var img = childImgs[i];
      this.addImage( img );
    }

    // get child background images
    if ( typeof this.options.background == 'string' ) {
      var children = elem.querySelectorAll( this.options.background );
      for ( i=0; i < children.length; i++ ) {
        var child = children[i];
        this.addElementBackgroundImages( child );
      }
    }
  };

  var elementNodeTypes = {
    1: true,
    9: true,
    11: true
  };

  ImagesLoaded.prototype.addElementBackgroundImages = function( elem ) {
    var style = getStyle( elem );
    // get url inside url("...")
    var reURL = /url\(['"]*([^'"\)]+)['"]*\)/gi;
    var matches = reURL.exec( style.backgroundImage );
    while ( matches !== null ) {
      var url = matches && matches[1];
      if ( url ) {
        this.addBackground( url, elem );
      }
      matches = reURL.exec( style.backgroundImage );
    }
  };

  // IE8
  var getStyle = window.getComputedStyle || function( elem ) {
    return elem.currentStyle;
  };

  /**
   * @param {Image} img
   */
  ImagesLoaded.prototype.addImage = function( img ) {
    var loadingImage = new LoadingImage( img );
    this.images.push( loadingImage );
  };

  ImagesLoaded.prototype.addBackground = function( url, elem ) {
    var background = new Background( url, elem );
    this.images.push( background );
  };

  ImagesLoaded.prototype.check = function() {
    var _this = this;
    this.progressedCount = 0;
    this.hasAnyBroken = false;
    // complete if no images
    if ( !this.images.length ) {
      this.complete();
      return;
    }

    function onProgress( image, elem, message ) {
      // HACK - Chrome triggers event before object properties have changed. #83
      setTimeout( function() {
        _this.progress( image, elem, message );
      });
    }

    for ( var i=0; i < this.images.length; i++ ) {
      var loadingImage = this.images[i];
      loadingImage.once( 'progress', onProgress );
      loadingImage.check();
    }
  };

  ImagesLoaded.prototype.progress = function( image, elem, message ) {
    this.progressedCount++;
    this.hasAnyBroken = this.hasAnyBroken || !image.isLoaded;
    // progress event
    this.emit( 'progress', this, image, elem );
    if ( this.jqDeferred && this.jqDeferred.notify ) {
      this.jqDeferred.notify( this, image );
    }
    // check if completed
    if ( this.progressedCount == this.images.length ) {
      this.complete();
    }

    if ( this.options.debug && console ) {
      console.log( 'progress: ' + message, image, elem );
    }
  };

  ImagesLoaded.prototype.complete = function() {
    var eventName = this.hasAnyBroken ? 'fail' : 'done';
    this.isComplete = true;
    this.emit( eventName, this );
    this.emit( 'always', this );
    if ( this.jqDeferred ) {
      var jqMethod = this.hasAnyBroken ? 'reject' : 'resolve';
      this.jqDeferred[ jqMethod ]( this );
    }
  };

  // --------------------------  -------------------------- //

  function LoadingImage( img ) {
    this.img = img;
  }

  LoadingImage.prototype = new EventEmitter();

  LoadingImage.prototype.check = function() {
    // If complete is true and browser supports natural sizes,
    // try to check for image status manually.
    var isComplete = this.getIsImageComplete();
    if ( isComplete ) {
      // report based on naturalWidth
      this.confirm( this.img.naturalWidth !== 0, 'naturalWidth' );
      return;
    }

    // If none of the checks above matched, simulate loading on detached element.
    this.proxyImage = new Image();
    eventie.bind( this.proxyImage, 'load', this );
    eventie.bind( this.proxyImage, 'error', this );
    // bind to image as well for Firefox. #191
    eventie.bind( this.img, 'load', this );
    eventie.bind( this.img, 'error', this );
    this.proxyImage.src = this.img.src;
  };

  LoadingImage.prototype.getIsImageComplete = function() {
    return this.img.complete && this.img.naturalWidth !== undefined;
  };

  LoadingImage.prototype.confirm = function( isLoaded, message ) {
    this.isLoaded = isLoaded;
    this.emit( 'progress', this, this.img, message );
  };

  // ----- events ----- //

  // trigger specified handler for event type
  LoadingImage.prototype.handleEvent = function( event ) {
    var method = 'on' + event.type;
    if ( this[ method ] ) {
      this[ method ]( event );
    }
  };

  LoadingImage.prototype.onload = function() {
    this.confirm( true, 'onload' );
    this.unbindEvents();
  };

  LoadingImage.prototype.onerror = function() {
    this.confirm( false, 'onerror' );
    this.unbindEvents();
  };

  LoadingImage.prototype.unbindEvents = function() {
    eventie.unbind( this.proxyImage, 'load', this );
    eventie.unbind( this.proxyImage, 'error', this );
    eventie.unbind( this.img, 'load', this );
    eventie.unbind( this.img, 'error', this );
  };

  // -------------------------- Background -------------------------- //

  function Background( url, element ) {
    this.url = url;
    this.element = element;
    this.img = new Image();
  }

  // inherit LoadingImage prototype
  Background.prototype = new LoadingImage();

  Background.prototype.check = function() {
    eventie.bind( this.img, 'load', this );
    eventie.bind( this.img, 'error', this );
    this.img.src = this.url;
    // check if image is already complete
    var isComplete = this.getIsImageComplete();
    if ( isComplete ) {
      this.confirm( this.img.naturalWidth !== 0, 'naturalWidth' );
      this.unbindEvents();
    }
  };

  Background.prototype.unbindEvents = function() {
    eventie.unbind( this.img, 'load', this );
    eventie.unbind( this.img, 'error', this );
  };

  Background.prototype.confirm = function( isLoaded, message ) {
    this.isLoaded = isLoaded;
    this.emit( 'progress', this, this.element, message );
  };

  // -------------------------- jQuery -------------------------- //

  ImagesLoaded.makeJQueryPlugin = function( jQuery ) {
    jQuery = jQuery || window.jQuery;
    if ( !jQuery ) {
      return;
    }
    // set local variable
    $ = jQuery;
    // $().imagesLoaded()
    $.fn.imagesLoaded = function( options, callback ) {
      var instance = new ImagesLoaded( this, options, callback );
      return instance.jqDeferred.promise( $(this) );
    };
  };
  // try making plugin
  ImagesLoaded.makeJQueryPlugin();

  // --------------------------  -------------------------- //

  return ImagesLoaded;

});

},{"eventie":1,"wolfy87-eventemitter":3}],3:[function(require,module,exports){
/*!
 * EventEmitter v4.2.11 - git.io/ee
 * Unlicense - http://unlicense.org/
 * Oliver Caldwell - http://oli.me.uk/
 * @preserve
 */

;(function () {
    'use strict';

    /**
     * Class for managing events.
     * Can be extended to provide event functionality in other classes.
     *
     * @class EventEmitter Manages event registering and emitting.
     */
    function EventEmitter() {}

    // Shortcuts to improve speed and size
    var proto = EventEmitter.prototype;
    var exports = this;
    var originalGlobalValue = exports.EventEmitter;

    /**
     * Finds the index of the listener for the event in its storage array.
     *
     * @param {Function[]} listeners Array of listeners to search through.
     * @param {Function} listener Method to look for.
     * @return {Number} Index of the specified listener, -1 if not found
     * @api private
     */
    function indexOfListener(listeners, listener) {
        var i = listeners.length;
        while (i--) {
            if (listeners[i].listener === listener) {
                return i;
            }
        }

        return -1;
    }

    /**
     * Alias a method while keeping the context correct, to allow for overwriting of target method.
     *
     * @param {String} name The name of the target method.
     * @return {Function} The aliased method
     * @api private
     */
    function alias(name) {
        return function aliasClosure() {
            return this[name].apply(this, arguments);
        };
    }

    /**
     * Returns the listener array for the specified event.
     * Will initialise the event object and listener arrays if required.
     * Will return an object if you use a regex search. The object contains keys for each matched event. So /ba[rz]/ might return an object containing bar and baz. But only if you have either defined them with defineEvent or added some listeners to them.
     * Each property in the object response is an array of listener functions.
     *
     * @param {String|RegExp} evt Name of the event to return the listeners from.
     * @return {Function[]|Object} All listener functions for the event.
     */
    proto.getListeners = function getListeners(evt) {
        var events = this._getEvents();
        var response;
        var key;

        // Return a concatenated array of all matching events if
        // the selector is a regular expression.
        if (evt instanceof RegExp) {
            response = {};
            for (key in events) {
                if (events.hasOwnProperty(key) && evt.test(key)) {
                    response[key] = events[key];
                }
            }
        }
        else {
            response = events[evt] || (events[evt] = []);
        }

        return response;
    };

    /**
     * Takes a list of listener objects and flattens it into a list of listener functions.
     *
     * @param {Object[]} listeners Raw listener objects.
     * @return {Function[]} Just the listener functions.
     */
    proto.flattenListeners = function flattenListeners(listeners) {
        var flatListeners = [];
        var i;

        for (i = 0; i < listeners.length; i += 1) {
            flatListeners.push(listeners[i].listener);
        }

        return flatListeners;
    };

    /**
     * Fetches the requested listeners via getListeners but will always return the results inside an object. This is mainly for internal use but others may find it useful.
     *
     * @param {String|RegExp} evt Name of the event to return the listeners from.
     * @return {Object} All listener functions for an event in an object.
     */
    proto.getListenersAsObject = function getListenersAsObject(evt) {
        var listeners = this.getListeners(evt);
        var response;

        if (listeners instanceof Array) {
            response = {};
            response[evt] = listeners;
        }

        return response || listeners;
    };

    /**
     * Adds a listener function to the specified event.
     * The listener will not be added if it is a duplicate.
     * If the listener returns true then it will be removed after it is called.
     * If you pass a regular expression as the event name then the listener will be added to all events that match it.
     *
     * @param {String|RegExp} evt Name of the event to attach the listener to.
     * @param {Function} listener Method to be called when the event is emitted. If the function returns true then it will be removed after calling.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.addListener = function addListener(evt, listener) {
        var listeners = this.getListenersAsObject(evt);
        var listenerIsWrapped = typeof listener === 'object';
        var key;

        for (key in listeners) {
            if (listeners.hasOwnProperty(key) && indexOfListener(listeners[key], listener) === -1) {
                listeners[key].push(listenerIsWrapped ? listener : {
                    listener: listener,
                    once: false
                });
            }
        }

        return this;
    };

    /**
     * Alias of addListener
     */
    proto.on = alias('addListener');

    /**
     * Semi-alias of addListener. It will add a listener that will be
     * automatically removed after its first execution.
     *
     * @param {String|RegExp} evt Name of the event to attach the listener to.
     * @param {Function} listener Method to be called when the event is emitted. If the function returns true then it will be removed after calling.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.addOnceListener = function addOnceListener(evt, listener) {
        return this.addListener(evt, {
            listener: listener,
            once: true
        });
    };

    /**
     * Alias of addOnceListener.
     */
    proto.once = alias('addOnceListener');

    /**
     * Defines an event name. This is required if you want to use a regex to add a listener to multiple events at once. If you don't do this then how do you expect it to know what event to add to? Should it just add to every possible match for a regex? No. That is scary and bad.
     * You need to tell it what event names should be matched by a regex.
     *
     * @param {String} evt Name of the event to create.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.defineEvent = function defineEvent(evt) {
        this.getListeners(evt);
        return this;
    };

    /**
     * Uses defineEvent to define multiple events.
     *
     * @param {String[]} evts An array of event names to define.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.defineEvents = function defineEvents(evts) {
        for (var i = 0; i < evts.length; i += 1) {
            this.defineEvent(evts[i]);
        }
        return this;
    };

    /**
     * Removes a listener function from the specified event.
     * When passed a regular expression as the event name, it will remove the listener from all events that match it.
     *
     * @param {String|RegExp} evt Name of the event to remove the listener from.
     * @param {Function} listener Method to remove from the event.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.removeListener = function removeListener(evt, listener) {
        var listeners = this.getListenersAsObject(evt);
        var index;
        var key;

        for (key in listeners) {
            if (listeners.hasOwnProperty(key)) {
                index = indexOfListener(listeners[key], listener);

                if (index !== -1) {
                    listeners[key].splice(index, 1);
                }
            }
        }

        return this;
    };

    /**
     * Alias of removeListener
     */
    proto.off = alias('removeListener');

    /**
     * Adds listeners in bulk using the manipulateListeners method.
     * If you pass an object as the second argument you can add to multiple events at once. The object should contain key value pairs of events and listeners or listener arrays. You can also pass it an event name and an array of listeners to be added.
     * You can also pass it a regular expression to add the array of listeners to all events that match it.
     * Yeah, this function does quite a bit. That's probably a bad thing.
     *
     * @param {String|Object|RegExp} evt An event name if you will pass an array of listeners next. An object if you wish to add to multiple events at once.
     * @param {Function[]} [listeners] An optional array of listener functions to add.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.addListeners = function addListeners(evt, listeners) {
        // Pass through to manipulateListeners
        return this.manipulateListeners(false, evt, listeners);
    };

    /**
     * Removes listeners in bulk using the manipulateListeners method.
     * If you pass an object as the second argument you can remove from multiple events at once. The object should contain key value pairs of events and listeners or listener arrays.
     * You can also pass it an event name and an array of listeners to be removed.
     * You can also pass it a regular expression to remove the listeners from all events that match it.
     *
     * @param {String|Object|RegExp} evt An event name if you will pass an array of listeners next. An object if you wish to remove from multiple events at once.
     * @param {Function[]} [listeners] An optional array of listener functions to remove.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.removeListeners = function removeListeners(evt, listeners) {
        // Pass through to manipulateListeners
        return this.manipulateListeners(true, evt, listeners);
    };

    /**
     * Edits listeners in bulk. The addListeners and removeListeners methods both use this to do their job. You should really use those instead, this is a little lower level.
     * The first argument will determine if the listeners are removed (true) or added (false).
     * If you pass an object as the second argument you can add/remove from multiple events at once. The object should contain key value pairs of events and listeners or listener arrays.
     * You can also pass it an event name and an array of listeners to be added/removed.
     * You can also pass it a regular expression to manipulate the listeners of all events that match it.
     *
     * @param {Boolean} remove True if you want to remove listeners, false if you want to add.
     * @param {String|Object|RegExp} evt An event name if you will pass an array of listeners next. An object if you wish to add/remove from multiple events at once.
     * @param {Function[]} [listeners] An optional array of listener functions to add/remove.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.manipulateListeners = function manipulateListeners(remove, evt, listeners) {
        var i;
        var value;
        var single = remove ? this.removeListener : this.addListener;
        var multiple = remove ? this.removeListeners : this.addListeners;

        // If evt is an object then pass each of its properties to this method
        if (typeof evt === 'object' && !(evt instanceof RegExp)) {
            for (i in evt) {
                if (evt.hasOwnProperty(i) && (value = evt[i])) {
                    // Pass the single listener straight through to the singular method
                    if (typeof value === 'function') {
                        single.call(this, i, value);
                    }
                    else {
                        // Otherwise pass back to the multiple function
                        multiple.call(this, i, value);
                    }
                }
            }
        }
        else {
            // So evt must be a string
            // And listeners must be an array of listeners
            // Loop over it and pass each one to the multiple method
            i = listeners.length;
            while (i--) {
                single.call(this, evt, listeners[i]);
            }
        }

        return this;
    };

    /**
     * Removes all listeners from a specified event.
     * If you do not specify an event then all listeners will be removed.
     * That means every event will be emptied.
     * You can also pass a regex to remove all events that match it.
     *
     * @param {String|RegExp} [evt] Optional name of the event to remove all listeners for. Will remove from every event if not passed.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.removeEvent = function removeEvent(evt) {
        var type = typeof evt;
        var events = this._getEvents();
        var key;

        // Remove different things depending on the state of evt
        if (type === 'string') {
            // Remove all listeners for the specified event
            delete events[evt];
        }
        else if (evt instanceof RegExp) {
            // Remove all events matching the regex.
            for (key in events) {
                if (events.hasOwnProperty(key) && evt.test(key)) {
                    delete events[key];
                }
            }
        }
        else {
            // Remove all listeners in all events
            delete this._events;
        }

        return this;
    };

    /**
     * Alias of removeEvent.
     *
     * Added to mirror the node API.
     */
    proto.removeAllListeners = alias('removeEvent');

    /**
     * Emits an event of your choice.
     * When emitted, every listener attached to that event will be executed.
     * If you pass the optional argument array then those arguments will be passed to every listener upon execution.
     * Because it uses `apply`, your array of arguments will be passed as if you wrote them out separately.
     * So they will not arrive within the array on the other side, they will be separate.
     * You can also pass a regular expression to emit to all events that match it.
     *
     * @param {String|RegExp} evt Name of the event to emit and execute listeners for.
     * @param {Array} [args] Optional array of arguments to be passed to each listener.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.emitEvent = function emitEvent(evt, args) {
        var listenersMap = this.getListenersAsObject(evt);
        var listeners;
        var listener;
        var i;
        var key;
        var response;

        for (key in listenersMap) {
            if (listenersMap.hasOwnProperty(key)) {
                listeners = listenersMap[key].slice(0);
                i = listeners.length;

                while (i--) {
                    // If the listener returns true then it shall be removed from the event
                    // The function is executed either with a basic call or an apply if there is an args array
                    listener = listeners[i];

                    if (listener.once === true) {
                        this.removeListener(evt, listener.listener);
                    }

                    response = listener.listener.apply(this, args || []);

                    if (response === this._getOnceReturnValue()) {
                        this.removeListener(evt, listener.listener);
                    }
                }
            }
        }

        return this;
    };

    /**
     * Alias of emitEvent
     */
    proto.trigger = alias('emitEvent');

    /**
     * Subtly different from emitEvent in that it will pass its arguments on to the listeners, as opposed to taking a single array of arguments to pass on.
     * As with emitEvent, you can pass a regex in place of the event name to emit to all events that match it.
     *
     * @param {String|RegExp} evt Name of the event to emit and execute listeners for.
     * @param {...*} Optional additional arguments to be passed to each listener.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.emit = function emit(evt) {
        var args = Array.prototype.slice.call(arguments, 1);
        return this.emitEvent(evt, args);
    };

    /**
     * Sets the current value to check against when executing listeners. If a
     * listeners return value matches the one set here then it will be removed
     * after execution. This value defaults to true.
     *
     * @param {*} value The new value to check for when executing listeners.
     * @return {Object} Current instance of EventEmitter for chaining.
     */
    proto.setOnceReturnValue = function setOnceReturnValue(value) {
        this._onceReturnValue = value;
        return this;
    };

    /**
     * Fetches the current value to check against when executing listeners. If
     * the listeners return value matches this one then it should be removed
     * automatically. It will return true by default.
     *
     * @return {*|Boolean} The current value to check for or the default, true.
     * @api private
     */
    proto._getOnceReturnValue = function _getOnceReturnValue() {
        if (this.hasOwnProperty('_onceReturnValue')) {
            return this._onceReturnValue;
        }
        else {
            return true;
        }
    };

    /**
     * Fetches the events object and creates one if required.
     *
     * @return {Object} The events storage object.
     * @api private
     */
    proto._getEvents = function _getEvents() {
        return this._events || (this._events = {});
    };

    /**
     * Reverts the global {@link EventEmitter} to its previous value and returns a reference to this version.
     *
     * @return {Function} Non conflicting EventEmitter class.
     */
    EventEmitter.noConflict = function noConflict() {
        exports.EventEmitter = originalGlobalValue;
        return EventEmitter;
    };

    // Expose the class either via AMD, CommonJS or the global object
    if (typeof define === 'function' && define.amd) {
        define(function () {
            return EventEmitter;
        });
    }
    else if (typeof module === 'object' && module.exports){
        module.exports = EventEmitter;
    }
    else {
        exports.EventEmitter = EventEmitter;
    }
}.call(this));

},{}],4:[function(require,module,exports){
;(function(root, factory) {
  if (typeof exports === 'object') {
    module.exports = factory()
  } else {
    root.CreateControls = factory()
  }
})(this, function() {
  'use strict'

  var CreateControls = {}

  var _cssClasses = {
    CONTROLS: 'm-p-g__controls',
    CONTROLS_CLOSE: 'm-p-g__controls-close',
    CONTROLS_ARROW: 'm-p-g__controls-arrow',
    CONTROLS_NEXT: 'm-p-g__controls-arrow--next',
    CONTROLS_PREV: 'm-p-g__controls-arrow--prev',
    CONTROLS_BTN: 'm-p-g__btn'
  }

  var controlsCloseSvg =
    '<svg fill="#FFFFFF" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/><path d="M0 0h24v24H0z" fill="none"/></svg>'

  var controlsPrevSvg =
    '<svg fill="#FFFFFF" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M0 0h24v24H0z" fill="none"/><path d="M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z"/></svg>'

  var controlsNextSvg =
    '<svg fill="#FFFFFF" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M0 0h24v24H0z" fill="none"/><path d="M12 4l-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8z"/></svg>'

  function _createEl(el, className, attr) {
    var element = document.createElement(el)
    if (className && typeof className === 'object') {
      className.forEach(function(c) {
        element.classList.add(c)
      })
    } else {
      element.classList.add(className)
    }
    return element
  }

  function init() {
    var controls = _createEl('div', _cssClasses.CONTROLS)
    var close = _createEl('button', _cssClasses.CONTROLS_CLOSE)
    var next = _createEl('button', [
      _cssClasses.CONTROLS_ARROW,
      _cssClasses.CONTROLS_NEXT
    ])
    var prev = _createEl('button', [
      _cssClasses.CONTROLS_ARROW,
      _cssClasses.CONTROLS_PREV
    ])

    var childrenControls = [close, next, prev]

    for (var i = 0; i < childrenControls.length; i++) {
      controls.appendChild(childrenControls[i])
    }

    var closeBtn = _createEl('span', _cssClasses.CONTROLS_BTN)
    var nextBtn = _createEl('span', _cssClasses.CONTROLS_BTN)
    var prevBtn = _createEl('span', _cssClasses.CONTROLS_BTN)

    closeBtn.innerHTML = controlsCloseSvg
    nextBtn.innerHTML = controlsNextSvg
    prevBtn.innerHTML = controlsPrevSvg

    close.appendChild(closeBtn)
    next.appendChild(nextBtn)
    prev.appendChild(prevBtn)

    return controls
  }

  CreateControls.init = init

  return CreateControls
})

},{}],5:[function(require,module,exports){
// Expose MaterialPhotoGallery to Global Scope
var MaterialPhotoGallery = require('./material-photo-gallery')
window.MaterialPhotoGallery = MaterialPhotoGallery

},{"./material-photo-gallery":6}],6:[function(require,module,exports){
/**
 *
 * Material Photo Gallery v0.1.0
 * A photo gallery inspired by Google Photos.
 *
 * Free to use under the MIT License.
 *
 */

;(function(root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(factory)
  } else if (typeof exports === 'object') {
    module.exports = factory(
      require('imagesLoaded'),
      require('./vendor/google-image-layout'),
      require('./create-controls')
    )
  } else {
    root.Gallery = factory(window.imagesLoaded, window.GoogleImageLayout)
  }
})(this, function(imagesLoaded, GoogleImageLayout, CreateControls) {
  'use strict'

  /**
   * Class constructor for Gallery component.
   *
   * @constructor
   * @param {HTMLElement} element - The gallery element.
   */

  var Gallery = function(element) {
    this._element = element
    this._layout()
  }

  /**
   * Detect CSS transform support
   */

  var transform = false,
    transformString = 'transform',
    domPrefixes = 'Webkit Moz ms'.split(' '),
    pfx = '',
    elem = document.createElement('div')

  if (elem.style.transform !== undefined) {
    transform = true
  }

  if (transform === false) {
    for (var i = 0; i < domPrefixes.length; i++) {
      if (elem.style[domPrefixes[i] + 'Transform'] !== undefined) {
        pfx = domPrefixes[i]
        transformString = pfx + 'Transform'
        transform = true
        break
      }
    }
  }

  /**
   * Detect transitionend event support
   */

  var transitions = {
      transition: 'transitionend',
      WebkitTransition: 'webkitTransitionEnd',
      MozTransition: 'transitionend',
      OTransition: 'otransitionend'
    },
    transitionendString,
    elem = document.createElement('div')

  for (var t in transitions) {
    if (typeof elem.style[t] !== 'undefined') {
      transitionendString = transitions[t]
      break
    }
  }

  function debounce(func, wait, immediate) {
    var timeout
    return function() {
      var context = this,
        args = arguments
      var later = function() {
        timeout = null
        if (!immediate) func.apply(context, args)
      }
      var callNow = immediate && !timeout
      clearTimeout(timeout)
      timeout = setTimeout(later, wait)
      if (callNow) func.apply(context, args)
    }
  }

  /**
   * handle touch events
   */
  var xDown = null
  var yDown = null

  function getTouches(evt) {
    return (
      evt.touches || evt.originalEvent.touches // browser API
    ) // jQuery
  }

  function handleTouchStart(evt) {
    xDown = getTouches(evt)[0].clientX
    yDown = getTouches(evt)[0].clientY
  }

  function handleTouchMove(evt) {
    if (!xDown || !yDown) {
      return
    }

    var xUp = evt.touches[0].clientX
    var yUp = evt.touches[0].clientY

    var xDiff = xDown - xUp
    var yDiff = yDown - yUp

    if (Math.abs(xDiff) > Math.abs(yDiff)) {
      /*most significant*/
      if (xDiff > 0) {
        /* left swipe */
        // alert('left swipe')
        this._handleNext()
      } else {
        /* right swipe */
        // alert('right swipe')
        this._handlePrev()
      }
    } else {
      if (yDiff > 0) {
        /* up swipe */
      } else {
        /* down swipe */
      }
    }
    /* reset values */
    xDown = null
    yDown = null
  }

  /**
   * Css class names stored as strings.
   *
   * @private
   */

  Gallery.prototype._cssClasses = {
    GALLERY: 'm-p-g',
    THUMBS_BOX: 'm-p-g__thumbs',
    THUMB_IMG: 'm-p-g__thumbs-img',
    FULL_BOX: 'm-p-g__fullscreen',
    FULL_IMG: 'm-p-g__fullscreen-img',
    CONTROLS: 'm-p-g__controls',
    CONTROLS_CLOSE: 'm-p-g__controls-close',
    CONTROLS_NEXT: 'm-p-g__controls-arrow--next',
    CONTROLS_PREV: 'm-p-g__controls-arrow--prev'
  }

  /**
   * Init the Google Image Layout.
   */

  Gallery.prototype._layout = function() {
    var gallery = this
    var imgLoad = imagesLoaded(
      document.querySelector('div[data-google-image-layout]')
    )

    imgLoad.on('progress', function(instance, image) {
      image.img.setAttribute('data-width', image.img.offsetWidth)
      image.img.setAttribute('data-height', image.img.offsetHeight)
    })

    imgLoad.on('done', function(instance) {
      var g = new GoogleImageLayout().init({
        after: function() {
          gallery.init()
        }
      })
    })

    imgLoad.on('fail', function(instance) {
      var galleryEl = gallery._element
      var alertBox = document.createElement('div')
      alertBox.className = 'm-p-g__alertBox'
      var alertBoxTitle = document.createElement('h2')
      alertBoxTitle.innerHTML = 'Error'
      var alertBoxMessage = document.createElement('p')
      alertBox.appendChild(alertBoxTitle)
      alertBox.appendChild(alertBoxMessage)
      galleryEl.appendChild(alertBox)

      var brokenImages = []
      instance.images.forEach(function(image) {
        if (!image.isLoaded) {
          brokenImages.push(image.img.currentSrc)
        }
      })

      alertBoxMessage.innerHTML = 'Failed to load:' + ' ' + brokenImages
    })

    window.onresize = debounce(function() {
      var g = new GoogleImageLayout().init({
        after: function() {
          setTimeout(function() {
            gallery._handleResize()
          }, 500)
        }
      })
    }, 25)
  }

  /**
   * Init the Gallery component.
   */

  Gallery.prototype.init = function() {
    var controls = CreateControls.init()
    this._element.appendChild(controls)

    // Root element.
    this._gallery = this._element

    // Container element for thumbnails.
    this._thumbsBox = this._gallery.querySelector(
      '.' + this._cssClasses.THUMBS_BOX
    )

    // Nodelist of thumbnails.
    this._thumbsNodeList = this._thumbsBox.querySelectorAll(
      '.' + this._cssClasses.THUMB_IMG
    )

    // Array of thumbnails.
    this._thumbs = Array.prototype.slice.call(this._thumbsNodeList)

    // Container of full size images.
    this._fullBox = this._gallery.querySelector('.' + this._cssClasses.FULL_BOX)

    // Container of controls.
    this._controls = this._gallery.querySelector(
      '.' + this._cssClasses.CONTROLS
    )
    // this._controls = CreateControls.init();

    // Close control button.
    this._closeBtn = this._controls.querySelector(
      '.' + this._cssClasses.CONTROLS_CLOSE
    )

    // Prev control button.
    this._prevBtn = this._controls.querySelector(
      '.' + this._cssClasses.CONTROLS_PREV
    )

    // Next control button.
    this._nextBtn = this._controls.querySelector(
      '.' + this._cssClasses.CONTROLS_NEXT
    )

    // Is true when the full size images have been loaded.
    this._fullImgsLoaded = false

    // Is true when a full size image is being viewed.
    this._fullImgOpen = false

    // Bind events to elements.
    this._bindEvents.call(this)

    // Load full size images.
    this._loadFullImgs.call(this)
  }

  /**
   * Add event listeners to elements.
   *
   * @private
   */

  Gallery.prototype._bindEvents = function() {
    for (var i = 0, ii = this._thumbs.length; i < ii; i++) {
      // Add click event to each thumbnail.
      this._thumbs[i].addEventListener(
        'click',
        this._handleThumbClick.bind(this)
      )

      // Add hover event to each thumbnail.
      this._thumbs[i].addEventListener(
        'mouseover',
        this._handleThumbHover.bind(this)
      )
    }

    // Add click event to close button.
    this._closeBtn.addEventListener('click', this._handleClose.bind(this))

    // Add click event to next button.
    this._nextBtn.addEventListener('click', this._handleNext.bind(this))

    // Add click event to prev button.
    this._prevBtn.addEventListener('click', this._handlePrev.bind(this))

    window.addEventListener('scroll', this._handleScroll.bind(this))

    // touch events
    document.addEventListener('touchstart', handleTouchStart.bind(this))
    document.addEventListener('touchmove', handleTouchMove.bind(this))
  }

  Gallery.prototype._handleScroll = debounce(function() {
    this._resetFullImg.call(this)
  }, 25)

  Gallery.prototype._handleResize = function() {
    this._resetFullImg.call(this)
  }

  /**
   * Load the full size images from the 'data-full' attribute.
   *
   * @private
   */

  Gallery.prototype._loadFullImgs = function() {
    var src, img

    for (var i = 0, ii = this._thumbs.length; i < ii; i++) {
      // Source of full size image.
      src = this._thumbs[i].getAttribute('data-full')

      // Create empty Image object.
      img = new Image()

      // Give new Image full size image src value.
      img.src = src

      // Give new Image appropriate class name.
      img.classList.add(this._cssClasses.FULL_IMG)

      // Append full size image to full size image container.
      this._fullBox.appendChild(img)
    }

    this._loadFullImgsDone.call(this)
  }

  Gallery.prototype._loadFullImgsDone = function() {
    var imgLoad = imagesLoaded(this._fullBox)
    imgLoad.on(
      'done',
      function(instance) {
        var imgArr = instance.images

        this._fullImgs = []
        this._fullImgDimensions = []
        this._fullImgsTransforms = []

        for (var i = 0, ii = imgArr.length; i < ii; i++) {
          var rect = imgArr[i].img.getBoundingClientRect()
          this._fullImgs.push(imgArr[i].img)
          this._positionFullImgs.call(this, imgArr[i].img, i)
          this._fullImgDimensions.push(rect)
        }

        this._fullImgsLoaded = true
      }.bind(this)
    )
  }

  Gallery.prototype._positionFullImgs = function(img, i, applyTransform) {
    var transform = this._transformFullImg(img, this._thumbs[i])
    this._fullImgsTransforms.push(transform)

    img.style.marginTop = -img.height / 2 + 'px'
    img.style.marginLeft = -img.width / 2 + 'px'
    if (applyTransform !== false) {
      img.style[transformString] = transform
    }
  }

  /**
   * Makes the thumbnail transform to the same size and position as the full
   * size image.
   *
   * @private
   */

  Gallery.prototype._transformFullImg = function(fullImg, thumb, fullImgSize) {
    var scaleX, scaleY, transX, transY

    fullImg = fullImg.getBoundingClientRect()
    thumb = thumb.getBoundingClientRect()

    if (fullImgSize) {
      scaleX = (thumb.width / fullImgSize.width).toFixed(3)
      scaleY = (thumb.height / fullImgSize.height).toFixed(3)
      transX = thumb.left - fullImgSize.left + fullImgSize.width / 2
      transY = thumb.top - fullImgSize.top + fullImgSize.height / 2
    } else {
      scaleX = (thumb.width / fullImg.width).toFixed(3)
      scaleY = (thumb.height / fullImg.height).toFixed(3)
      transX = thumb.left - fullImg.left + fullImg.width / 2
      transY = thumb.top - fullImg.top + fullImg.height / 2
    }

    var transform =
      'translate(' +
      transX +
      'px,' +
      transY +
      'px) scale(' +
      scaleX +
      ',' +
      scaleY +
      ')'

    return transform
  }

  Gallery.prototype._resetFullImg = function() {
    this._fullImgsTransforms = []

    for (var i = 0, ii = this._fullImgs.length; i < ii; i++) {
      var size = {
        width: this._fullImgDimensions[i].width,
        height: this._fullImgDimensions[i].height,
        left: this._fullImgDimensions[i].left,
        top: this._fullImgDimensions[i].top
      }

      if (i === this._thumbIndex && this._fullImgOpen) {
        this._fullImgs[i].removeAttribute('style')
        this._positionFullImgs.call(this, this._fullImgs[i], i, false)
      } else {
        this._fullImgs[i].removeAttribute('style')
        this._positionFullImgs.call(this, this._fullImgs[i], i)
      }
    }
  }

  /**
   * Thumbnail hover event.
   *
   * @param {Event} event - The event.
   * @private
   */

  Gallery.prototype._handleThumbHover = function(event) {
    if (this._fullImgsLoaded && !this._fullImgOpen) {
      this._transformThumbSetup.call(this, event)
    }
  }

  /**
   * Thumbnail click event.
   *
   * @param {Event} event - The event.
   * @private
   */

  Gallery.prototype._handleThumbClick = function(event) {
    if (this._thumb != event.target) {
      // Cache the thumb being hovered over.
      this._thumb = event.target

      // Index of thumb.
      this._thumbIndex = this._thumbs.indexOf(this._thumb)

      // The full size image of that thumbnail.
      this._fullImg = this._fullImgs[this._thumbIndex]
    }

    if (this._setupComplete && this._fullImgsLoaded && !this._fullImgOpen) {
      this._activateFullImg.call(this)
      this._activateControls.call(this)
      this._activateFullBox.call(this)
      this._disableScroll()
    }
  }

  /**
   * Caches the thumbnail and full size image that was just hovered over.
   * Stores the css transform value so we can use it later.
   *
   * @param {Event} event - The event.
   * @param {Function} fn - An optional callback function.
   * @private
   */

  Gallery.prototype._transformThumbSetup = function(event, fn) {
    this._setupComplete = false

    // Cache the thumb being hovered over.
    this._thumb = event.target

    // Index of thumb.
    this._thumbIndex = this._thumbs.indexOf(this._thumb)

    // The full size image of that thumbnail.
    this._fullImg = this._fullImgs[this._thumbIndex]

    this._setupComplete = true

    if (fn) fn()
  }

  Gallery.prototype._activateFullImg = function() {
    this._thumb.classList.add('hide')
    this._fullImg.classList.add('active')
    this._fullImg.style[transformString] = 'translate3d(0,0,0)'
    this._fullImgOpen = true

    this._fullImgs.forEach(function(img) {
      if (!img.classList.contains('active')) {
        img.classList.add('almost-active')
      }
    })
  }

  /**
   * Show the fullBox.
   *
   * @private
   */

  Gallery.prototype._activateFullBox = function() {
    this._fullBox.classList.add('active')
  }

  /**
   * Show the controls.
   *
   * @private
   */

  Gallery.prototype._activateControls = function() {
    this._controls.classList.add('active')
  }

  /**
   * CloseBtn click event.
   *
   * @private
   */

  Gallery.prototype._handleClose = function() {
    if (this._fullImgOpen) {
      this._closeFullImg.call(this)
    }
  }

  Gallery.prototype._closeFullImg = function() {
    var animation = function() {
      this._fullBox.classList.remove('active')
      this._controls.classList.remove('active')
      this._fullImg.style[transformString] = this._fullImgsTransforms[
        this._thumbIndex
      ]
      this._thumb.classList.remove('hide')

      this._fullImgs.forEach(function(img) {
        img.classList.remove('almost-active')
      })

      var fullImgTransEnd = function() {
        this._fullImg.classList.remove('active')
        this._fullImg.removeEventListener(transitionendString, fullImgTransEnd)

        this._fullImgOpen = false
      }.bind(this)

      this._fullImg.addEventListener(transitionendString, fullImgTransEnd)
      this._enableScroll()
    }.bind(this)

    window.requestAnimationFrame(animation)
  }

  /**
   * NextBtn click event.
   *
   * @private
   */

  Gallery.prototype._handleNext = function() {
    if (this._fullImgOpen) {
      this._changeImg.call(this, 'next')
    }
  }

  /**
   * PrevBtn click event.
   *
   * @private
   */

  Gallery.prototype._handlePrev = function() {
    if (this._fullImgOpen) {
      this._changeImg.call(this, 'prev')
    }
  }

  /**
   * Changes the active full size image and active thumbnail based on which
   * arrow was click (prev || next).
   *
   * @param {String} dir - A string to determine if we're going Prev or Next.
   * @private
   */

  Gallery.prototype._changeImg = function(dir) {
    this._thumbIndex = this._fullImgs.indexOf(this._fullImg)
    dir === 'next' ? (this._thumbIndex += 1) : (this._thumbIndex -= 1)

    this._newFullImg =
      dir === 'next'
        ? this._fullImg.nextElementSibling
        : this._fullImg.previousElementSibling

    if (!this._newFullImg || this._newFullImg.nodeName !== 'IMG') {
      this._newFullImg =
        dir === 'next'
          ? (this._newFullImg = this._fullImgs[0])
          : (this._newFullImg = this._fullImgs[this._fullImgs.length - 1])
      dir === 'next'
        ? (this._thumbIndex = 0)
        : (this._thumbIndex = this._fullImgs.length - 1)
    }

    this._newFullImg.style[transformString] = 'translate3d(0,0,0)'
    this._fullImg.classList.remove('active')
    this._fullImg.style[transformString] = this._fullImgsTransforms[
      this._thumbIndex - 1
    ]

    this._fullImg = this._newFullImg
    this._fullImg.classList.add('active')
  }

  /**
   * Disables scrolling. Activated when a full size image is open.
   *
   * @private
   */

  Gallery.prototype._disableScroll = function() {
    function preventDefault(e) {
      e = e || window.event
      if (e.preventDefault) e.preventDefault()
      e.returnValue = false
    }

    window.onwheel = preventDefault
    window.ontouchmove = preventDefault
  }

  /**
   * Enables scrolling. Activated when a full size image is closed.
   *
   * @private
   */

  Gallery.prototype._enableScroll = function() {
    window.onwheel = null
    window.ontouchmove = null
  }

  return Gallery
})

},{"./create-controls":4,"./vendor/google-image-layout":7,"imagesLoaded":2}],7:[function(require,module,exports){
/**
 *
 * Google Image Layout v0.0.1
 * Description, by Anh Trinh.
 * http://trinhtrunganh.com
 *
 * Free to use under the MIT License.
 *
 */

;(function(root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(function() {
      return factory(root)
    })
  } else if (typeof exports === 'object') {
    module.exports = factory
  } else {
    root.GoogleImageLayout = factory(root)
  }
})(this, function(root) {
  'use strict'

  var GoogleImageLayout = {}

  var HEIGHTS = [],
    margin = 5

  var turnObjToArray = function(obj) {
    return [].map.call(obj, function(element) {
      return element
    })
  }

  var _debounceOrThrottle = function() {
    if (!useDebounce && !!poll) {
      return
    }
    clearTimeout(poll)
    poll = setTimeout(function() {
      echo.render()
      poll = null
    }, delay)
  }

  /**
   * Get the height that make all images fit the container
   *
   * width = w1 + w2 + w3 + ... = r1*h + r2*h + r3*h + ...
   *
   * @param  {[type]} images the images to be calculated
   * @param  {[type]} width  the container witdth
   * @param  {[type]} margin the margin between each image
   *
   * @return {[type]}        the height
   */
  var _getHeigth = function(images, width, margin) {
    // width -= images.length * margin;
    // width -= images.length;

    var r = 0,
      img

    for (var i = 0; i < images.length; i++) {
      img = images[i]
      r +=
        parseInt(img.getAttribute('data-width')) /
        parseInt(img.getAttribute('data-height'))
    }

    return width / r //have to round down because Firefox will automatically roundup value with number of decimals > 3
  }

  var _setHeight = function(images, height) {
    // console.log("set height");

    HEIGHTS.push(height)

    var img

    for (var i = 0; i < images.length; i++) {
      img = images[i]
      img.style.width =
        (height * parseInt(img.getAttribute('data-width'))) /
          parseInt(img.getAttribute('data-height')) +
        'px'
      img.style.height = height + 'px'
      img.classList.add('layout-completed')
    }
  }

  GoogleImageLayout.init = function(opts) {
    opts = opts || {}
    var nodes = document.querySelectorAll('div[data-google-image-layout]')
    var length = nodes.length
    var elem

    for (var i = 0; i < length; i++) {
      elem = nodes[i]
      GoogleImageLayout.align(elem)
    }

    if (opts.after) opts.after()
  }

  GoogleImageLayout.align = function(elem) {
    //get the data attribute

    var containerWidth = elem.clientWidth,
      maxHeight = parseInt(elem.getAttribute('data-max-height') || 120)

    var imgNodes = turnObjToArray(elem.querySelectorAll('img'))

    w: while (imgNodes.length > 0) {
      for (var i = 1; i <= imgNodes.length; i++) {
        var slice = imgNodes.slice(0, i)
        var h = _getHeigth(slice, containerWidth, margin)

        if (h < maxHeight) {
          _setHeight(slice, h)
          imgNodes = imgNodes.slice(i)
          continue w
        }
      }

      _setHeight(slice, Math.min(maxHeight, h))
      break
    }
  }

  return GoogleImageLayout
})

},{}]},{},[5]);
    </script>
    <!-- Init Photo Gallery -->
    <script>
        var elem = document.querySelector('.m-p-g')
        var gallery = new MaterialPhotoGallery(elem)
    </script>
</body>
</html>