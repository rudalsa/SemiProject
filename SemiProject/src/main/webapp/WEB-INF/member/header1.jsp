<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>

<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css">

<!-- 내가만듬 -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/login.css"> 

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"></script>
<%-- <script type="text/javascript" src="<%= ctxPath%>/js/login.js"></script> --%>

<title>Blizzard Mainpage</title>
</head>
<body  style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg'); background-size: cover; background-position: center 5%; background-repeat: no-repeat;">
<!-- background-repeat: no-repeat;를 적용하면 배경 이미지가 한 번만 표시됩니다: -->

<nav class="navbar navbar-expand-lg mx-auto mt-4 fixed-top" id="scrollNavbar" style=" width: 90%; background-image: url('<%= ctxPath %>/img/top_bar.jpg'); background-size: cover; background-position: center 15%; background-repeat: no-repeat;">
<!-- navbar-expand-lg: 네비게이션 바의 크기를 화면 너비에 따라 조절하는 클래스입니다. navbar-expand-lg 클래스는 화면 너비가 대형(Large) 이상일 때 네비게이션 바가 확장되도록 합니다. 작은 화면에서는 기본적으로 접혀 있는 상태가 됩니다. -->
    
    <!-- Brand/logo -->
    <a class="navbar-brand" href="<%= ctxPath %>/index.up">
       	<i class="fa-brands fa-phoenix-framework fa-2xl"></i>
    </a>
    
	<!-- 아코디언 같은 Navigation Bar 만들기 -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="collapsibleNavbar">
    
    <!-- 네비게이션 메뉴들... -->
    <ul class="navbar-nav mr-auto">
    	
    	<li class="nav-item dropdown ml-2">
	        <a class="nav-link dropdown-toggle menufont_size" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	        	워크래프트
	        </a>
            
            <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
	           
	            <a class="dropdown-item" href="#">워크1</a>
	            <a class="dropdown-item" href="#">워크2</a>
	            <a class="dropdown-item" href="#">나가기</a>
            
            </div>
   		</li>
		     
     	<li class="nav-item dropdown ml-2">
        	
        	<a class="nav-link dropdown-toggle menufont_size" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
            	다이블로
        	</a>
        	
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
		        
		        <a class="dropdown-item" href="#">디아블로1</a>
		        <a class="dropdown-item" href="#">디아블로2</a>
		        <a class="dropdown-item" href="#">나가기</a>
		        
	        </div>
	        
    	</li>
   
	    <li class="nav-item dropdown ml-2">
	        
	        <a class="nav-link dropdown-toggle menufont_size" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	        	오버워치
	        </a>
	    
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
	            <a class="dropdown-item" href="#">오버워치1</a>
	            <a class="dropdown-item" href="#">오버워치2</a>
	            <a class="dropdown-item" href="#">나가기</a>
	        </div>
	    
	    </li>

    	<li class="nav-item dropdown ml-2">
	      
	        <a class="nav-link dropdown-toggle menufont_size" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	        	스타크래프트
	        </a>
	      
	        <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
		        <a class="dropdown-item" href="#">스타크래프트1</a>
		        <a class="dropdown-item" href="#">스타크래프트2</a>
		        <a class="dropdown-item" href="#">나가기</a>
	        </div>
	        
    	</li>
    	
	    <li class="nav-item dropdown ml-2">
	         <a class="nav-link dropdown-toggle menufont_size" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	         	젤다의 전설
	         </a>
	         <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
	             <a class="dropdown-item" href="#">젤다의 전설1</a>
	             <a class="dropdown-item" href="#">젤다의 전설2</a>
	             <a class="dropdown-item" href="#">나가기</a>
	         </div>
	    </li>
	</ul>
	
	
    <ul class="navbar-nav ml-auto">
    
    <li class="nav-item active ml-2">
		<a class="nav-link menufont_size" href="#">
		<i class="fa-brands fa-shopify"></i>&nbsp;&nbsp;상점
		</a>
	</li>
		
	<li class="nav-item dropdown ml-2">
		<a class="nav-link dropdown-toggle menufont_size" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	    	<i class="fa-regular fa-user"></i>&nbsp;&nbsp;계정로그인
	    </a>
		<div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
		    <a class="dropdown-item" href="#">로그인</a>
		    <a class="dropdown-item" href="#">회원가입</a>
		    <a class="dropdown-item" href="#">계정관리</a>
		    <a class="dropdown-item" href="#">나가기</a>
		</div>
    </li>
    
 	</ul>
	</div>
</nav>
