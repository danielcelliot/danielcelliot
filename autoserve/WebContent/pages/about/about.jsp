<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>About Us - AutoServe</title>
    <link rel="stylesheet" href="../../css/main.css">
    <link rel="stylesheet" href="../../css/pages.css">
    <!-- <link rel="stylesheet" type="text/css" href="courses.css"> -->
  </head>
  <style>
    /* a{text-decoration:none;}
    
    body {
    padding: 0;
    margin: 0;
    font-family: Arial;
    font-size: 20px;
    background-image: url(wb.jpg);
    background-size:cover;
	color: #000000  ;
} */
#nav {

	background-image: url(cbb.jpg);
  position: relative;
  top: 0px;
  height: 100px

}

}

#nav ul {

    list-style-type: none;
    padding: 0;
    margin: 0;
    position: relative;
    min-width: 200px;

}
#nav ul li {
   display: inline-block;

}
#nav ul li:hover {
    background-color: #FEFEFE;
display: inline-block;
}
#nav ul li a, visited {
  color: black;
    display: inline-block;
    padding: 5px;
    text-decoration: none;
}
#nav ul li:hover ul {
    display: block;
}
#nav ul ul {
    display: none;
    position: absolute;
    background-color: #333;
    border: 5px solid #222;
    border-top: 0;
    margin-left: -5px;
}
#nav ul ul li {
    display: block;
}

#nav ul ul li a:hover {
    color: #699;
    display: block;
}

.courses{
overflow: hidden;
text-align:center;
background: #00000;
padding: 60px;

}

.courses h1{
text-transform:uppercase;
margin-bottom:60px;
color: black;
font-size: 30px;
}

.border{
display: block;
margin: auto;
width: 160px;
height: 3px;
background: #807A7A   ;
margin-bottom: 40px;
}

.ps{
margin-bottom: 40px;

}

.ps a{
display:inline-block;
margin: 0 30px;
width: 160px;
height: 160px;
overflow: hidden;
border-radius:70%;
}

.ps a img{
  width: 100%;
  filter: grayscale(100%);
  transition: 0.4s all;
}

.ps a:hover> img{
  filter:none;
}
.section{
  width: 600px;
  margin: auto;
  font-size: 20px;
  color: black;
  text-align:justify;
  height: 0;
  overflow: hidden;
}

.section:target{
  height: auto;
}


.name{
  display: block;
  margin-bottom: 30px;
  text-align: center;
  text-transform: uppercase;
  font-size: 22px;
}

.button{
  text-align: center;

  color: black;
}
.btn
{
    border: 3px solid black;
    padding: 10px 30px;
    color: black;
    text-decoration: none;
    margin-right: 5px;
    font-size: 17px;
    text-transform: uppercase;
}
.btn-one
{
    font-family: "Roboto", sans-serif;
}
.btn-one:hover
{
    background-color: gray;
    transition: all 0.5s ease-in;


}
    
  </style>
  <body a link="white" vlink="black">


  <jsp:include page="/includes/header-alt.jsp" />

<div class="courses">
  <h1> About us</h1>
  <span class="border"></span>
"Company NAME" Started as nothing more as a dream and a will, ten years ago right here in Trinidad and Tobago, due to the talents of "Person name".
His talent as an auto mechanic and his reputation for quality work at a fair price, and excellent customer service, saw his small garage grow to be a major player in the auto-maintenance industry Trinidad and Tobago.
Winstonattributes his success to ensuring his mechanics are well trained and most importantly, not being afraid to innovate in an effort to improve productivity and hence customer satisfaction.
"Person Name" and a group of well trusted board of directors intend to continue taking T&T by storm with intentions of expanding branding into all carribbean islands.
<p>



</div>
<div class="team">
  The Founders
</div>



<div class="ps">
  <a href="#d1"><img src="woman.jpg" alt=""></a>
  <a href="#d2"><img src="male.jpg" alt=""></a>
  <a href="#d3"><img src="man.jpg" alt=""></a>
</div>

<div class="section" id="d2">
  <span class="name">Jason Nash</span>

  <p>

    <ul>
    Jason Experience Here <p>
      Academic Cerifications:
      <li>Degree in Project Management</li>
      <li>Degree in Petroleum Engineering</li>
      <li>Diploma in Mechanical Engineering</li>
      <li>Diploma in Utilities Engineering</li>

  </p>
</div>

<div class="section" id="d3">
  <span class="name">Chidi Anagonya</span>

  <p>
    <ul>

      <li>Degree in Enviromental Science</li>
      <li>Diploma in Database Administration</li>
      <li>Degree in Human Resource Management</li>

    </ul>

    <p>

  </p>
</p>

</div>
<div class="section" id="d1">
  <span class="name">Lisa Cavalere</span>

  <p>
<ul>
  Marketing Manager <p>
    Academic Cerifications:
    <li>Project Management and Civil Infrastructure Systems</li>
    <li>Petroleum Engineering</li>
    <li>Process Engineering</li>
    <li>Utilities Engineering</li>

</ul>

  </p>
</div>

   <jsp:include page="/includes/footer.jsp" />
   <script type="text/javascript" src="../../js/main.js"></script>
  </body>
</html>
