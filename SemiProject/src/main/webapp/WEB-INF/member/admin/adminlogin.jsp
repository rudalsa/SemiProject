<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>

<!DOCTYPE html>
<html>
<head>
<title>Batttle.net 계정관리</title>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css">

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/mypage.js"></script>
</head>
<section class="backgroundimg mt-3" style="background-image: url('<%= ctxPath %>/img/vm.jpg'); background-size: 90% auto; background-position: center 5%; background-repeat: no-repeat; height: 80%;">
    <div class="container">
        <div class="row justify-content-center align-items-center" style="min-height: 300px; ">
            <div class="col-lg-12 text-center">
                <div class="text-white">
                    <h1 style="font-weight: bold;">관리자 페이지</h1>
                    <br>
                    <h3 style="font-weight: bold;">관리자 계정으로 로그인 해주세요</h3>
                </div>
            </div>
        </div>
    </div>
</section>

<br>

<section class="mt-5">

    <div class="container">
        <div class="row justify-content-center align-items-center">
	       <c:if test="${empty sessionScope.loginuser}">
	       
	        <!-- 로그인 폼 -->
	        <div class="col-lg-5 text-left pr-5">
	        <h5 class="text-white mb-3" style="font-weight:bord">Login</h5>
	        <form action="<%= ctxPath%>/admin.bz" method="post">
		        
				<div class="form-group">
				    <div class="input-group">
				        <div class="input-group-prepend">
				            <span class="input-group-text" style="weight=10px"><i class="fa-regular fa-id-card" style="width: 25px;"></i></span>
				        </div>
				        <input type="text" id="user_id" name="user_id" class="form-control" placeholder="User_ID"/>
				    </div>
				</div>
				 
				<div class="form-group">
				    <div class="input-group">
				        <div class="input-group-prepend">
				            <span class="input-group-text"><i class="fa-solid fa-key" style="width: 25px;"></i></span>
				        </div>
				        <input type="password" id="user_pwd" name="user_pwd" class="form-control" placeholder="user_pwd"/>
				    </div>
				</div>
			     
		        <button type="submit" class="btn btn-primary btn-block"><span style="font-weight:bold;">로그인하기</span></button>
	        
	        </form>
        </div>
    </c:if>    
</div>
		  	        
</div>                   
</section>


</body>
</html>
 
 
<!--  이 코드는 Bootstrap의 그리드 시스템 및 클래스를 사용하여 섹션의 레이아웃을 구성하고, 섹션의 높이를 최소 250px로 고정하도록 했습니다. 기존 코드와 Bootstrap을 통합하여 웹 페이지를 디자인할 수 있게 되었습니다. 페이지의 다른 부분에 대해서도 Bootstrap을 활용하여 반응형 디자인을 추가할 수 있습니다. -->





