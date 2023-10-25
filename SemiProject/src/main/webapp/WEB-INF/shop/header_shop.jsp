<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

<title>상품구매페이지</title> 

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<%-- Bootstrap CSS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<%-- Font Awesome 6 Icons --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<%-- Optional JavaScript --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>



  <style>
    a {
      color: white;
      font-weight: bold;
	  color: white;
	  font-size:14pt
    }
    
    .dropdown-menu{
    	background-color:#3c3c3c;
    }
    
    .dropdown-item{
      color: white;
      font-weight: bold;
	  color: white;
	  font-size:11pt  
    }
    
	#navbarDropdown:hover,
	#collapsibleNavbar > ul > li > div  a:hover,
	#collapsibleNavbar > ul.navbar-nav.ml-auto > li.nav-item.active.ml-2 > a:hover {
    
    color: white;
    background-color: rgba(0, 0, 0, 0.25);   
    border-radius: 10px;   
    }
    
  </style>
  
</head>

<body style="background-color:#0d0d0d; width:100%">
<!-- background-repeat: no-repeat;를 적용하면 배경 이미지가 한 번만 표시됩니다: -->

<div class="mx-auto"  style=" width: 97%;">
    
    <a href="<%= ctxPath %>/index.bz" class="" id="logo">
    	<img src="<%= ctxPath %>/img/footer_logo.jpg" style="width:210px; height:70px; margin: 1% 0;" class="mr-atuo"   />
    </a>

</div>

<nav class="navbar navbar-expand-lg fixed-top mx-auto" id="top-nav" style=" width: 97%; height: 70px; margin:6.5% 0; background-color:#323232;">
<!-- navbar-expand-lg: 네비게이션 바의 크기를 화면 너비에 따라 조절하는 클래스입니다. navbar-expand-lg 클래스는 화면 너비가 대형(Large) 이상일 때 네비게이션 바가 확장되도록 합니다. 작은 화면에서는 기본적으로 접혀 있는 상태가 됩니다. -->
    
   <!-- 아코디언 같은 Navigation Bar 만들기 -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="collapsibleNavbar">
    
    <!-- 네비게이션 메뉴들... -->
    <ul class="navbar-nav mr-auto">
       
       <li class="nav-item dropdown ml-2">
       
           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              워크래프트
           </a>
            
           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="#">월드 오브 워크래프트</a>
              <a class="dropdown-item" href="#">월드 오브 워크래프트 클래식</a>
              <a class="dropdown-item rumble"  href="#">워크래프트 럼블</a>
              <a class="dropdown-item" href="#">월드 오브 워크래프트III:리포지드</a>
              <a class="dropdown-item" href="#">하스스톤</a>
           </div>
         </li>
           
        <li class="nav-item dropdown ml-2">
        
           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
               디아블로
           </a>
           
           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="#">디아블로IV</a>
              <a class="dropdown-item" href="#">디아블로 이모탈</a>              
              <a class="dropdown-item" href="#">디아블로II:레져렉션</a>              
           </div>
           
       </li>
   
       <li class="nav-item dropdown ml-2">
           
           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              오버워치
           </a>
       
           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
               <a class="dropdown-item" href="#">오버워치2</a>
           </div>
       
       </li>

       <li class="nav-item dropdown ml-2">
         
           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              스타크래프트
           </a>
         
           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="#">스타크래프트I</a>
              <a class="dropdown-item" href="#">스타크래프트II</a>
           </div>
           
       </li>
       
      <li class="nav-item dropdown ml-2">
         
           <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
              젤다의 전설
           </a>
         
           <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <a class="dropdown-item" href="#">젤다의 전설III</a>
              <a class="dropdown-item" href="#">젤다의 전설IV</a>
           </div>
           
       </li>
   
   </ul>
   
   
   <ul class="navbar-nav ml-auto">
          
   <li class="nav-item dropdown ml-2">
      

     <c:if test="${empty sessionScope.loginuser}">
		<a class="nav-link dropdown-toggle menufont_size" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	    	<i class="fa-regular fa-user"></i>&nbsp;&nbsp;계정로그인
	    </a>
	    
		<div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
		    <a class="dropdown-item" href="<%= ctxPath%>/login/login.bz">로그인</a>
		    <a class="dropdown-item" href="<%= ctxPath%>/member/memberRegister.bz">회원가입</a>
		    <a class="dropdown-item" href="#">나가기</a>
		</div>
		
	    </c:if>
		
		<c:if test="${not empty sessionScope.loginuser}">
		<a class="nav-link dropdown-toggle menufont_size" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	    	<i class="fa-regular fa-user"></i>&nbsp;&nbsp;${sessionScope.loginuser.user_name} 님
	    </a>
	    <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
		    <a class="dropdown-item" href="<%= ctxPath%>/member/memberEdit.bz">계정관리</a>
		    <a class="dropdown-item" href="#">장바구니</a>
		    <a class="dropdown-item" href="<%= ctxPath%>/login/logout.bz">로그아웃</a>
		</div>
		
	    </c:if>
      
      
    </li>
    
    <li class="nav-item dropdown ml-2">
      
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
        	<i class="fa-solid fa-coins fa-lg"></i>&nbsp;&nbsp;코인
        </a>
              
	    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">코인 충전</a>
          <a class="dropdown-item" href="#">코인 충전/사용내역</a>
          <a class="dropdown-item" href="#">코인 도움말</a>
	    </div>
      
    </li>
    
    <li class="nav-item active ml-2">     
        <a  href="mainShop.bz" class="nav-link menufont_size" id="shopPage">
       		<i class="fa-brands fa-shopify fa-lg"></i>&nbsp;&nbsp;상점
        </a>  
    </li>
    
    </ul>
   
   </div>
</nav>