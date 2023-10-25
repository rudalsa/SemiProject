<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
	<ol class="carousel-indicators">
		<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
        <li data-target="#carouselExampleIndicators" data-slide-to="5"></li>

	</ol>
	<div class="carousel-inner">
        <div class="carousel-item active">
        	<img src="<%= ctxPath %>/img/carousel/carouselbg1.jpg" style="max-height:700px" class="d-block w-100 img-fluid" alt="..."> <!-- d-block 은 display: block; 이고  w-100 은 width 의 크기는 <div class="carousel-item active">의 width 100% 로 잡으라는 것이다. -->
          	<div class="carousel-caption d-none d-md-block"> <!-- d-none 은 display : none; 이므로 화면에 보이지 않다가, d-md-block 이므로 d-md-block 은 width 가 768px이상인 것에서만 display: block; 으로 보여라는 말이다.  --> 
	           	<h5>Koala</h5>
	           	<p>Koala Content</p>
        	</div>
    	</div>
    	<div class="carousel-item">
        	<img src="<%= ctxPath %>/img/carousel/carouselbg2.jpg" style="max-height:700px" class="d-block w-100 img-fluid" alt="...">
	          	<div class="carousel-caption d-none d-md-block">
		           	<h5>Lighthouse</h5>
		           	<p>Lighthouse Content</p>
       	 		</div>            
    	</div>
        <div class="carousel-item">
          	<img src="<%= ctxPath %>/img/carousel/carouselbg3-1.jpg" style="max-height:700px"  class="d-block w-100 img-fluid" alt="...">
	          	<div class="carousel-caption d-none d-md-block">
		           	<h5>Penguins</h5>
		           	<p>Penguins Content</p>
	        	</div>            
    	</div>
        <div class="carousel-item">
          	<img src="<%= ctxPath %>/img/carousel/carouselbg4.jpg" style="max-height:700px"  class="d-block w-100 img-fluid" alt="...">
          		<div class="carousel-caption d-none d-md-block">
	          		<h5>Penguins</h5>
		          	<p>Penguins Content</p>
        		</div>            
    	</div>
    	<div class="carousel-item">
         	<img src="<%= ctxPath %>/img/carousel/carouselbg5.jpg" style="max-height:700px"  class="d-block w-100 img-fluid" alt="...">
	         	<div class="carousel-caption d-none d-md-block">
	         	<h5>Penguins</h5>
	          	<p>Penguins Content</p>
         		</div>            
        </div>
        <div class="carousel-item">
            <img src="<%= ctxPath %>/img/carousel/carouselbg6.jpg" style="max-height:700px"  class="d-block w-100 img-fluid" alt="...">
		    	<div class="carousel-caption d-none d-md-block">
		        	<h5>Penguins</h5>
		            <p>Penguins Content</p>
		        </div>            
        </div>
	</div>
	<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
	</a>
	<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
	</a>
</div>