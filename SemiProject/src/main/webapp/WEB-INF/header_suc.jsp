<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    String ctxPath = request.getContextPath();

%>
<!DOCTYPE html>
<html>
<head>

<title>3조홈페이지_suc</title> 

<%-- Required meta tags --%>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 내가만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/header.css">

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
<script type="text/javascript" src="<%= ctxPath%>/js/shop/likeshop.js"></script>


<style type="text/css">

#collapsibleNavbar > ul.navbar-nav.ml-auto > li.nav-item.dropdown.show > div > a:hover{
	 
	 background-color: rgba(255, 255, 255, 0.25); /* 마우스 호버 시 투명한 밝은 배경색으로 변경 */

}


</style>

</head>


<%-- --%>
<body style="background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
<!-- background-repeat: no-repeat;를 적용하면 배경 이미지가 한 번만 표시됩니다: -->

<nav class="navbar navbar-expand-lg mx-auto mt-3 bg-dark fixed-top" id="scrollNavbar" style=" width: 97%;  background-color: black; height: 75px">
<!-- navbar-expand-lg: 네비게이션 바의 크기를 화면 너비에 따라 조절하는 클래스입니다. navbar-expand-lg 클래스는 화면 너비가 대형(Large) 이상일 때 네비게이션 바가 확장되도록 합니다. 작은 화면에서는 기본적으로 접혀 있는 상태가 됩니다. -->
    
   <!-- Brand/logo -->
    <a class="navbar-brand" href="<%= ctxPath %>/index.bz">
    	<img src="<%= ctxPath %>/img/newshop/logo_steam.svg" style="width: 180px; height: 60px" />
    </a> 
    
   <!-- 아코디언 같은 Navigation Bar 만들기 -->
   <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
       <span class="navbar-toggler-icon"></span>
   </button>

   <div class="collapse navbar-collapse" id="collapsibleNavbar">
    
   <!-- 네비게이션 메뉴들... -->
   <ul class="navbar-nav d-flex flex-row">
	    
	    
	    
	    <li class="nav-item active">
	      <a class="nav-link d-flex align-items-center text-nowrap" href="<%= ctxPath %>/shop/displayitemshop.bz?c_code=${sessionScope.categoryList0.c_code}">
	        <img src="<%= ctxPath %>/img/newshop/${sessionScope.categoryList0.category_img}" alt="디아블로" style="width: 45px; height: 45px">
	        <span class="ml-3" style="color:white; font-weight:bold;">디아블로</span>
	      </a>
	    </li>
	    <li class="nav-item active">
	      <a class="nav-link d-flex align-items-center text-nowrap" href="<%= ctxPath %>/shop/displayitemshop.bz?c_code=${sessionScope.categoryList1.c_code}">
	        <img src="<%= ctxPath %>/img/newshop/${sessionScope.categoryList1.category_img}" alt="하스스톤" style="width: 45px; height: 45px">
	        <span class="ml-3" style="color:white; font-weight:bold;">하스스톤</span>
	      </a>
	    </li>
	    
	    
	    <li class="nav-item active">
	      <a class="nav-link d-flex align-items-center text-nowrap" href="<%= ctxPath %>/shop/displayitemshop.bz?c_code=${sessionScope.categoryList2.c_code}">
	        <img src="<%= ctxPath %>/img/newshop/${sessionScope.categoryList2.category_img}" alt="스타크래프트" style="width: 45px; height: 45px">
	        <span class="ml-3" style="color:white; font-weight:bold;">워크래프트</span>
	      </a>
	    </li>
	    
	    
	    <li class="nav-item active">
	      <a class="nav-link d-flex align-items-center text-nowrap" href="<%= ctxPath %>/shop/displayitemshop.bz?c_code=${sessionScope.categoryList3.c_code}">
	        <img src="<%= ctxPath %>/img/newshop/${sessionScope.categoryList3.category_img}" alt="오버워치" style="width: 40px; height: 40px">
	        <span class="ml-3" style="color:white; font-weight:bold;">오버워치</span>
	      </a>
	    </li>
	    
	    
	    <li class="nav-item active">
	      <a class="nav-link d-flex align-items-center text-nowrap" href="<%= ctxPath %>/shop/displayitemshop.bz?c_code=${sessionScope.categoryList4.c_code}">
	        <img src="<%= ctxPath %>/img/newshop/${sessionScope.categoryList4.category_img}" alt="스타크래프트" style="width: 40px; height: 40px">
	        <span class="ml-3" style="color:white; font-weight:bold;">스타크래프트</span>
	      </a>
	    </li>
	    
	    
	    
	</ul>
	<ul class="navbar-nav ml-auto">
	
		<li class="nav-item active">
	      <a class="nav-link d-flex align-items-center text-nowrap" href="<%= ctxPath %>/mainShop.bz">
	        <img src="<%= ctxPath %>/img/newshop/games_cod-mw.svg" alt="상점" style="width: 40px; height: 40px">
	        <span class="ml-3" style="color:white; font-weight:bold;">상점</span>
	      </a>
	    </li>
   	    
   	    <li class="nav-item dropdown">
        	<c:if test="${empty sessionScope.loginuser}">
				<a class="nav-link d-flex dropdown-toggle align-items-center text-nowrap ml-3" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	    			<img src="<%= ctxPath %>/img/newshop/games_cod-vanguard.svg" alt="로그인" style="width: 40px; height: 40px">
	        		<span class="ml-3" style="color:white; font-weight:bold;">로그인</span>
	    		</a>
			    <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-color: black; font-weight:bold; text-align:center;">
					<a class="dropdown-item text-white font-weight-bold" href="<%= ctxPath%>/login/login.bz">로그인</a>
				    <a class="dropdown-item text-white font-weight-bold" href="<%= ctxPath%>/member/memberRegister.bz">회원가입</a>
				    <a class="dropdown-item text-white font-weight-bold" href="#">나가기</a>
				</div>
		
	    	</c:if>
			<c:if test="${not empty sessionScope.loginuser}">
		        <c:choose>
		           <c:when test="${not empty sessionScope.loginuser and sessionScope.loginuser.user_id eq 'admin'}">
		              <!-- admin인 경우 -->
		              <a class="nav-link d-flex dropdown-toggle align-items-center text-nowrap ml-3" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	    			      <img src="<%= ctxPath %>/img/newshop/games_cod-vanguard.svg" alt="로그인" style="width: 40px; height: 40px">
	        		      <span class="ml-3" style="color:white; font-weight:bold;">${sessionScope.loginuser.user_name}님</span>
	    			  </a>	
		              <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-color: black; text-align:center;">
		                  <a class="dropdown-item text-white font-weight-bold" href="<%= ctxPath%>/member/memberList.bz">회원관리</a>
		                  <a class="dropdown-item text-white font-weight-bold" href="<%= ctxPath %>/shop/admin/productRegister.bz">제품추가</a>
		                  <a class="dropdown-item text-white font-weight-bold" href="<%= ctxPath%>/login/logout.bz">로그아웃</a>
		              </div>
		          </c:when>
		          <c:otherwise>
		              <!-- admin가 아닌 경우 -->
		              <a class="nav-link d-flex dropdown-toggle align-items-center text-nowrap ml-3" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	    			      <img src="<%= ctxPath %>/img/newshop/games_cod-vanguard.svg" alt="로그인" style="width: 40px; height: 40px">
	        		      <span class="ml-3" style="color:white; font-weight:bold;">${sessionScope.loginuser.user_name}님</span>
	    			  </a>	
		              <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-color: black; text-align:center;">
		                  <a class="dropdown-item text-white font-weight-bold" href="<%= ctxPath%>/member/memberEdit.bz">계정관리</a>
		                  <a class="dropdown-item text-white font-weight-bold" href="<%= ctxPath%>/buy/cartList.bz">장바구니</a>
		                  <a class="dropdown-item text-white font-weight-bold" href="<%= ctxPath%>/login/logout.bz">로그아웃</a>
		              </div>
		          </c:otherwise>
				</c:choose>
		    </c:if>
      	
      	</li>	    	    
	</ul>
	
	</div>
</nav>