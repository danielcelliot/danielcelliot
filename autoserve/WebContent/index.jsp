<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to AutoServe - Best in class auto repair</title>
    <link rel="stylesheet" href="./css/main.css">
</head>
<body>
    <div class="container">

        <jsp:include page="/includes/header.jsp" />

        <div class="content">
            <section class="hero">
                <div class="feature">
                    <h1>Best-in-class Auto Repair</h1>
                    <p>
                        Car repair & servicing done differently | Dealer quality service at non-dealer prices | Mechanics you can trust
                    </p>
                    <a href="#" class="button feature-btn">Get an instant quote</a>
                </div>
                <div class="customers">
                    <h3>our customers</h3>
                    <img src="./img/b-mobile-small.png" alt="b-mobile" id="b-mobile">
                    <img src="./img/guardian-small.png" alt="Guardian Group" id="guardian-group">
                    <img src="./img/republic-small.png" alt="Republic Bank" id="republic-bank">
                    <img src="./img/utt-small.png" alt="UTT" id="utt">
                    <img src="./img/newspaper-small.png" alt="Guardian Newspaper" id="newspaper">
                    <img src="./img/medassoc-small.png" alt="Medical Associates" id="medical">
                </div>
            </section>
            <section class="services-container">
                <div class="services-header">
                    <h1>What can we help you with?</h1>
                </div>
                <div class="services-outer">
                    <div class="services-overlay">
                        <a href="#">air-conditioning</a>
                        <a href="#">air filter</a>
                        <a href="#">battery</a>
                        <a href="#">engine</a>
                        <a href="#">headlights</a>
                        <a href="#">water pump</a>
                        <a href="#">radiator</a>
                        <a href="#">wheels</a>
                    </div>
                    <div class="services">
                        <div class="parent-item">
                            <div class="service-item" id="ac"></div>
                        </div>
                        
                        <div class="parent-item">
                            <div class="service-item" id="air-filter"></div>
                        </div>
        
                        <div class="parent-item">
                            <div class="service-item" id="battery"></div>
                        </div>
        
                        <div class="parent-item">
                            <div class="service-item" id="engine"></div>
                        </div>
        
                        <div class="parent-item">
                            <div class="service-item" id="headlight"></div>
                        </div>

                        <div class="parent-item">
                            <div class="service-item" id="water-pump"></div>
                        </div>

                        <div class="parent-item">
                            <div class="service-item" id="radiator"></div>
                        </div>
                        
                        <div class="parent-item">
                            <div class="service-item" id="wheels"></div>
                        </div>
                    </div>
                </div>
                <div class="services-btn">
                    <ul>
                        <li>
                            <a href="#" class="button">See all services</a>
                        </li>
                    </ul>
                </div>
            </section>
            <section class="home-products">
                <div class="home-products-desc">
                    <h1>Accessories for your auto</h1>
                    <p>Get chargers, toolkits and more.</p>
                    <ul>
                        <li>
                            <a href="#" class="button">See all accessories</a>
                        </li>
                    </ul>
                </div>
                        
                <div class="item item-1"></div>
                <div class="item item-2"></div>
                <div class="item item-3"></div>
            </section>
            <section class="testimonials">
                <div class="title"><h3>What our customers are saying</h3></div>
                <div class="card-container">
                    <div class="card">
                        <div class="card-image"></div>
                        <div class="card-text">
                            <h2>jane smith</h2>
                            <blockquote>
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut 
                                labore et dolore magna aliqua. Magna eget est lorem ipsum.
                            </blockquote>
                        </div>
                        <div class="card-stats">
                            <div class="stat">
                                <img src="./ico/cars/brake.svg" title   ="Replace brake pads" id="brake">
                                <!-- <h6>Replace brake pads</h6> -->
                            </div>
                            <div class="stat">
                                <img src="./ico/cars/audi.svg" title="Audi" id="audi">
                                <!-- <h6>Audi A6</h6> -->
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-image"></div>
                        <div class="card-text">
                            <h2>john smith</h2>
                            <blockquote>
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut 
                                labore et dolore magna aliqua. Magna eget est lorem ipsum.
                            </blockquote>
                        </div>
                        <div class="card-stats">
                            <div class="stat">
                                <img src="./ico/cars/oil.svg" title="Oil change" id="oil">
                            </div>
                            <div class="stat">
                                <img src="./ico/cars/bmw.svg" title="BMW" id="bmw">
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-image"></div>
                        <div class="card-text">
                            <h2>jane doe</h2>                            
                            <blockquote>
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut 
                                labore et dolore magna aliqua. Magna eget est lorem ipsum.
                            </blockquote>
                        </div>
                        <div class="card-stats">
                            <div class="stat">
                                <img src="./ico/cars/car.svg" title="Replace rear window" id="car-window">                                
                            </div>
                            <div class="stat">
                                <img src="./ico/cars/toyota.svg" title="Toyota" id="toyota">                                
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section class="recruit">
                <div class="recruit-desc">
                    <h1>join our team</h1>
                    <p>
                        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod 
                        tempor incididunt ut labore et dolore magna aliqua. Quam pellentesque nec 
                        nam aliquam sem et. Enim ut sem viverra aliquet eget sit amet tellus cras.
                    </p>
                    <ul>
                        <li>
                            <a href="#" class="button">Read more</a>
                        </li>
                    </ul>
                </div>
                <div class="recruit-image"></div>
            </section>

            <section class="directions">
                <div class="google-maps">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3921.3180056622255!2d-61.28707018536238!3d10.632384592419392!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8c49ff8341682be9%3A0x4e1b0040a9ebe274!2sWade&#39;s%20Auto%20World!5e0!3m2!1sen!2stt!4v1571241990349!5m2!1sen!2stt" width="100%" height="100%" frameborder="0" style="border:0;" allowfullscreen=""></iframe>
                </div>
                <div class="business-info">
                    <div>
                        <h3>come visit us</h3>
                        <dl>
                            <dt>Address</dt>
                            <dd>Pro Queen St, Arima</dd>
                            <dt>Opening Hours</dt>
                            <dd>Mon - Fri</dd>
                            <dd>8:00AM - 5:00PM</dd>
                            <dt>Contact</dt>
                            <dd>675-5555</dd>
                            <dd><a href="mailto: contact@autoserve.com">contact@autoserve.com</a></dd>
                        </dl>
                    </div>
                </div>
            </section>
            
        	<jsp:include page="/includes/footer.jsp" />
        	
        </div>

    </div>
    <script type="text/javascript" src="./js/main.js"></script>
</body>
</html>