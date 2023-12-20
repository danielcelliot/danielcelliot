<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome - Supreme Cutz Barbershop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <link rel="icon" href="./favicon.ico" type="image/x-icon">
</head>
<body>
    <div class="bg-container">
        <img id="img1" src="./img/barber-shop/barbering-bnw.png">
    </div>
    <div class="container">
        <header>
            <ul>
                <li><a href="./pages/cart.jsp" title="View cart"><i class="fas fa-shopping-cart fa-2x"></i></a></li>
                <li><a href="./scriptlets/verifySession.jsp?param1=../pages/customer-login.jsp" title="Sign in"><i class="fas fa-user-circle fa-2x"></i></a></li>
            </ul>
        </header>
        <nav>
            <ul>
                <li><a href="./pages/about.jsp" class="page-link about">about</a></li>
                <li><a href="./pages/barbers.jsp" class="page-link barbers">barbers</a></li>
                <li><a href="./pages/contact-us.jsp" class="page-link location">contact us</a></li>
                <li>
                    <div class="logo-container">
                        <%-- <svg class="logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 177.778 100"><path d="M31.941,62.825h25.65V37.175H31.941ZM52.654,47.532h-5.42v-5.42h5.42Zm-15.777-5.42H42.3V52.468H52.654v5.42H36.877Zm37.417-4.937A12.825,12.825,0,1,0,87.119,50,12.84,12.84,0,0,0,74.294,37.175Zm0,20.713A7.888,7.888,0,1,1,82.182,50,7.9,7.9,0,0,1,74.294,57.888Zm58.719-20.713A12.825,12.825,0,1,0,145.837,50,12.84,12.84,0,0,0,133.013,37.175Zm0,20.713A7.888,7.888,0,1,1,140.9,50,7.9,7.9,0,0,1,133.013,57.888Zm-29.36-20.713A12.825,12.825,0,1,0,116.478,50,12.84,12.84,0,0,0,103.653,37.175Zm0,20.713a7.888,7.888,0,1,1,7.488-10.356h-7.488v4.936h7.488A7.9,7.9,0,0,1,103.653,57.888Z" fill="#394149"/></svg> --%>
                        <svg id="logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200.416 166.352">
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
                </li>
                <li><a href="./pages/gallery.jsp" class="page-link gallery">gallery</a></li>
                <li><a href="./pages/prices.jsp" class="page-link prices">pricing</a></li>
                <li><a href="./pages/products.jsp" class="page-link products">products</a></li>
            </ul>
        </nav>
        <footer>
            <div class="copyright">&copy 2020 Supreme Cutz Barbershop Ltd.</div>
            <div class="proudtt-logo"><img src="./img/proud-logo.png" alt="" srcset=""></div>
        </footer>
    </div>
    
    <script src="./js/detect.js"></script>
</body>
</html>