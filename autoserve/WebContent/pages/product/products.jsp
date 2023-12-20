<!DOCTYPE html>
<html>
<head>
    <title>Accessories - AutoServe</title>
    <link rel="stylesheet" href="../../css/main.css">
    <link rel="stylesheet" href="../../css/pages.css">
</head>
<body>
    <div class="container">

        <jsp:include page="/includes/header-alt.jsp" />

        <div class="content">
            
            <section class="products">
                <div class="products-container">
                    <aside class="filters">
                        <form>
                            <div class="filter-criteria">
                                <span>Category 1</span>
                                <label><input type="checkbox" name="category-1" value="item-1">Item 1</label>
                                <label><input type="checkbox" name="category-1" value="item-2">Item 2</label>
                                <label><input type="checkbox" name="category-1" value="item-3">Item 3</label>
                                <label><input type="checkbox" name="category-1" value="item-4">Item 4</label>
                                <label><input type="checkbox" name="category-1" value="item-5">Item 5</label>
                                <label><input type="checkbox" name="category-1" value="item-6">Item 6</label>
                            </div>
                            <div class="filter-criteria">
                                <span>Category 2</span>
                                <label><input type="checkbox" value="item-1" name="category-2">Item 1</label>
                                <label><input type="checkbox" value="item-2" name="category-2">Item 2</label>
                            </div>
                            <div class="filter-criteria">
                                <span>Category 3</span>
                                <label><input type="checkbox" value="item-1" name="category-3">Item 1</label>
                                <label><input type="checkbox" value="item-2" name="category-3">Item 2</label>
                                <label><input type="checkbox" value="item-3" name="category-3">Item 3</label>
                            </div>
                            <div class="filter-criteria">
                                <span>Category 4</span>
                                <label><input type="checkbox" value="item-1" name="category-4">Item 1</label>
                                <label><input type="checkbox" value="item-2" name="category-4">Item 2</label>
                                <label><input type="checkbox" value="item-3" name="category-4">Item 3</label>
                                <label><input type="checkbox" value="item-4" name="category-4">Item 4</label>
                            </div>
                            <button>clear filters</button>
                        </form>
                    </aside>
                    
                    <ul class="products-list">
                        <li data-index="" class="product-card">
                            <a href="#" class="product-photo"><img src="https://picsum.photos/200?random=1" height="150" alt=""/></a>
                            <h2><a href="#">item 1</a></h2>
                            <ul class="product-description">
                                <li><span>Sub-category 1: </span>info</li>
                                <li><span>Sub-category 2: </span>info</li>
                                <li><span>Sub-category 3: </span>info</li>
                                <li><span>Sub-category 4: </span>info</li>
                            </ul>
                            <button>More info</button>
                            <p class="product-price">$99.99</p>
                            <div class="highlight"></div>
                        </li>
                        
                        
                        <li data-index="" class="product-card">
                            <a href="#" class="product-photo"><img src="https://picsum.photos/200?random=2" height="150" alt=""/></a>
                            <h2><a href="#">item 2</a></h2>
                            <ul class="product-description">
                                <li><span>Sub-category 1: </span>info</li>
                                <li><span>Sub-category 2: </span>info</li>
                                <li><span>Sub-category 3: </span>info</li>
                                <li><span>Sub-category 4: </span>info</li>
                            </ul>
                            <button>More info</button>
                            <p class="product-price">$99.99</p>
                            <div class="highlight"></div>
                        </li>
                        
                        <li data-index="" class="product-card">
                            <a href="#" class="product-photo"><img src="https://picsum.photos/200?random=3" height="150" alt=""/></a>
                            <h2><a href="#">item 3</a></h2>
                            <ul class="product-description">
                                <li><span>Sub-category 1: </span>info</li>
                                <li><span>Sub-category 2: </span>info</li>
                                <li><span>Sub-category 3: </span>info</li>
                                <li><span>Sub-category 4: </span>info</li>
                            </ul>
                            <button>More info</button>
                            <p class="product-price">$99.99</p>
                            <div class="highlight"></div>
                        </li>
                        
                        <li data-index="" class="product-card">
                            <a href="#" class="product-photo"><img src="https://picsum.photos/200?random=4" height="150" alt=""/></a>
                            <h2><a href="#">item 4</a></h2>
                            <ul class="product-description">
                                <li><span>Sub-category 1: </span>info</li>
                                <li><span>Sub-category 2: </span>info</li>
                                <li><span>Sub-category 3: </span>info</li>
                                <li><span>Sub-category 4: </span>info</li>
                            </ul>
                            <button>More info</button>
                            <p class="product-price">$99.99</p>
                            <div class="highlight"></div>
                        </li>
                        
                        <li data-index="" class="product-card">
                            <a href="#" class="product-photo"><img src="https://picsum.photos/200?random=5" height="150" alt=""/></a>
                            <h2><a href="#">item 5</a></h2>
                            <ul class="product-description">
                                <li><span>Sub-category 1: </span>info</li>
                                <li><span>Sub-category 2: </span>info</li>
                                <li><span>Sub-category 3: </span>info</li>
                                <li><span>Sub-category 4: </span>info</li>
                            </ul>
                            <button>More info</button>
                            <p class="product-price">$99.99</p>
                            <div class="highlight"></div>
                        </li>
                        
                        <li data-index="" class="product-card">
                            <a href="#" class="product-photo"><img src="https://picsum.photos/200?random=6" height="150" alt=""/></a>
                            <h2><a href="#">item 6</a></h2>
                            <ul class="product-description">
                                <li><span>Sub-category 1: </span>info</li>
                                <li><span>Sub-category 2: </span>info</li>
                                <li><span>Sub-category 3: </span>info</li>
                                <li><span>Sub-category 4: </span>info</li>
                            </ul>
                            <button>More info</button>
                            <p class="product-price">$99.99</p>
                            <div class="highlight"></div>
                        </li>
                        
                        <li data-index="" class="product-card">
                            <a href="#" class="product-photo"><img src="https://picsum.photos/200?random=7" height="150" alt=""/></a>
                            <h2><a href="#">item 7</a></h2>
                            <ul class="product-description">
                                <li><span>Sub-category 1: </span>info</li>
                                <li><span>Sub-category 2: </span>info</li>
                                <li><span>Sub-category 3: </span>info</li>
                                <li><span>Sub-category 4: </span>info</li>
                            </ul>
                            <button>More info</button>
                            <p class="product-price">$99.99</p>
                            <div class="highlight"></div>
                        </li>
                        
                        
                        <li data-index="" class="product-card">
                            <a href="#" class="product-photo"><img src="https://picsum.photos/200?random=8" height="150" alt=""/></a>
                            <h2><a href="#">item 8</a></h2>
                            <ul class="product-description">
                                <li><span>Sub-category 1: </span>info</li>
                                <li><span>Sub-category 2: </span>info</li>
                                <li><span>Sub-category 3: </span>info</li>
                                <li><span>Sub-category 4: </span>info</li>
                            </ul>
                            <button>More info</button>
                            <p class="product-price">$99.99</p>
                            <div class="highlight"></div>
                        </li>
                        
                    </ul>
                </div>
            </section>

            <jsp:include page="/includes/header.jsp" />
        </div>

    </div>
    <script type="text/javascript" src="../../js/main.js"></script>
</body>
</html>