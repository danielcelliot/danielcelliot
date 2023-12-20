<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pricing - Supreme Cutz Barbershop</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">
        <link rel="stylesheet" href="../css/core.css">
        <link rel="stylesheet" href="../css/prices.css">
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
                        <li><a href="./gallery.jsp" class="page-link">gallery</a></li>
                        <li><a href="#" class="page-link">pricing</a></li>
                        <li><a href="./products.jsp" class="page-link">products</a></li>
                    </ul>
                </div>
            </nav>

            <main>
                <div class="banner">
                    <div class="bg-container">
                        <img id="img1" onload="fadeImage();">
                        <img id="img2" onload="fadeImage();">
                    </div>
                    <div class="caption">
                        <h2>Tailored For You</h2>
                        <p>A Variety of Styles & Packages | View Our Most Popular</p>
                    </div>
                </div>
                <h2>styles</h2>

                <div class="prices-container">
                    <div class="prices-col-1">
                        <h3>hair</h3>
                        <p>Lorem ipsum / $20</p>
                        <p>Lorem ipsum / $20</p>
                        <p>Lorem ipsum / $20</p>
                        <p>Lorem ipsum / $20</p>
                        <p>Lorem ipsum / $20</p>

                        <h3>shave</h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit / $60</p>

                        <h3>massage</h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit / $60</p>
                        <p>Lorem ipsum / $40</p>
                    </div>
                    <div class="prices-col-1">
                        <h3>beard</h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit / $60</p>
                        <p>Lorem ipsum / $40</p>

                        <h3>facial</h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit / $60</p>
                    </div>
                </div>
                <h2>packages</h2>

                <div class="prices-container">
                    <div class="prices-col-2">
                        <h3>classic</h3>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pharetra vel arcu 
                            ac egestas. Nam eget diam nec sem commodo aliquam sed id mi. / $100
                        </p>
                        <h3>night special</h3>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pharetra vel arcu 
                            ac egestas. Nam eget diam nec sem commodo aliquam sed id mi. / $200
                        </p>
                        <h3>board meeting</h3>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pharetra vel arcu 
                            ac egestas. Nam eget diam nec sem commodo aliquam sed id mi. / $200
                        </p>
                        <h3>groom and groomsmen</h3>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pharetra vel arcu 
                            ac egestas. Nam eget diam nec sem commodo aliquam sed id mi. / $300
                        </p>
                    </div>
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
        <script>
            var imgidx = 0;
            var imgtoggle = false;
    
            // Images for our slideshow - have to be at least two
            var images = [
            '../img/bg1.jpg',
            '../img/bg2.jpg',
            '../img/bg4.jpg',
            '../img/bg5.jpg',
            '../img/bg6.jpg',
            '../img/bg7.jpg',
            '../img/bg7.jpg',
            '../img/bg9.jpg',
            '../img/bg10.jpg',
            '../img/bg11.jpg',
            '../img/bg12.jpg',
            '../img/bg13.jpg',
            '../img/bg14.jpg',
            '../img/bg15.jpg',
            '../img/bg16.jpg',
            '../img/bg17.jpg'
            ];
    
            // This function will initialize loading the next image in background
            window.nextImage = function() {
                imgtoggle = !imgtoggle;
    
                imgidx = (imgidx + 1) % images.length;
    
                if (imgtoggle) {
                    document.getElementById('img2').src = images[imgidx];
                } else {
                    document.getElementById('img1').src = images[imgidx];
                }
            }
    
            // This function will trigger the crossfade and then start the timer for the next switch
            window.fadeImage = function() {
                if (imgtoggle) {
                    document.getElementById('img2').style.opacity = '1.0';
                } else {
                    document.getElementById('img2').style.opacity = '0.0';
                }
                window.setTimeout(nextImage, 3000);
            }
    
            // Now load our very first image to start the slideshow
            document.getElementById('img1').src = images[0];
        </script>
    </body>
</html>