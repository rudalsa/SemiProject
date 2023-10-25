<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

<body style="background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
<!-- background-repeat: no-repeat;를 적용하면 배경 이미지가 한 번만 표시됩니다: -->

<nav class="navbar navbar-expand-lg mx-auto mt-3 bg-dark" id="scrollNavbar" style=" width: 80%;  background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat; height: 70px">
<!-- navbar-expand-lg: 네비게이션 바의 크기를 화면 너비에 따라 조절하는 클래스입니다. navbar-expand-lg 클래스는 화면 너비가 대형(Large) 이상일 때 네비게이션 바가 확장되도록 합니다. 작은 화면에서는 기본적으로 접혀 있는 상태가 됩니다. -->
    
    <!-- Brand/logo -->
    <a class="navbar-brand" href="<%= ctxPath %>/index.bz">
       	<i class="fa-brands fa-phoenix-framework fa-2xl" style="color: white;"></i>
    </a>
    
    <!-- 아코디언 같은 Navigation Bar 만들기 -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="collapsibleNavbar">
    
    <!-- 네비게이션 메뉴들... -->
    <ul class="navbar-nav mr-auto">
    	<li class="nav-item dropdown">
	        <a class="nav-link dropdown-toggle menufont_size text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	        	게임
	        </a>
            
            <div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
    <!-- 네비게이션 메뉴들... -->

	            <a class="dropdown-item text-white" href="#">워크레프트</a>
	            <a class="dropdown-item text-white" href="#">디아블로</a>
	            <a class="dropdown-item text-white" href="#">오버워치</a>
	            <a class="dropdown-item text-white" href="#">스타크래프트</a>
	            <a class="dropdown-item text-white" href="#">젤다의 전설</a>
	            
            </div>
   		</li>
		     
     	<li class="nav-item dropdown ml-2">
        	
        	<a class="nav-link menufont_size text-white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
            	상점 바로가기
        	</a>
        	

	        
    	</li>
   
	</ul>
	
	
    <ul class="navbar-nav ml-auto">

    <li class="nav-item active ml-2">
		<a class="nav-link menufont_size text-white" href="#">
		<i class="fa-solid fa-circle-info"></i>&nbsp;&nbsp;고객지원
		</a>
	</li>
		
	<li class="nav-item dropdown ml-2">
		<a class="nav-link dropdown-toggle menufont_size" href="#" id="navbarDropdown" role="button" data-toggle="dropdown">
	    	<i class="fa-solid fa-gear"></i>&nbsp;&nbsp;계정 관리
	    </a>
		<div class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
		    <a class="dropdown-item text-white" href="<%= ctxPath%>/member/pwdUpdateEnd.bz">비밀번호 변경</a>
		    <a class="dropdown-item text-white" href="#">구매내역</a>
		    <a class="dropdown-item text-white" href="#">장바구니</a>
		    <a class="dropdown-item text-white" href="<%= ctxPath%>/login/logout.bz">로그아웃</a>
		</div>
    </li>
    
 	</ul>
	</div>
</nav>
<!-- <hr style="background-color: gold; height: 1.2px;"> -->
        <hr style="background-color: gray; height: 1.2px; position: relative; top:20px; margin: 0 1.7%;"> 

    <div class="container-fluid" id="container" style="position: relative; top:50px; padding: 0.1% 2.5%;">
      
     <div class="row">
     
		<div class="col-md-2 offset-md-1" id="sideinfo" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg') ;">
          
               <div class="col-lg-12" >
            	<div>
            		<ul class="nav flex-column mt-2 ">
					  <li class="nav-item ">
					    <a class="nav-link text-white active" href="#"> <span class="rounded-sm">계정 정보</span></a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link text-white" href="#">계정 상세 정보</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link text-white" href="#">게임 & 요금제</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link text-white" href="#">보안</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link text-white" href="#">결제 수단</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link text-white" href="#">결제 및 주문 내역</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link text-white" href="#">로그아웃</a>
					  </li>
					</ul>
				</div>
            </div>
        </div>
        
          <div class="col-md-8  mt-1">
          
               <div class="col-lg-12 mt-6" >
            	<div>
            		<h2 style="color:white;">계정정보</h2>
				</div>
				<div class="row">
					<table class="col-md-6 table table-dark" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th colspan="2">내 정보</th>
					      <td class="text-right"><a href="<%= ctxPath%>/member/memberEditEnd.bz">변경하기</a></td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <td colspan="2">아이디</td>
					      <td>${loginuser.user_id}</td>
					    </tr>
					    <tr>
					      <td colspan="2">가입일자</td>
					      <td >${loginuser.user_registerday}</td>
					    <tr>
					      <td colspan="2">보유 포인트</td>
					      <td>${loginuser.user_coin}</td>
					    </tr>
					    <tr>
					      <td colspan="2">연락처</td>
					      <td>${loginuser.user_phone}</td>
					    </tr>
					  </tbody>
					</table>
					<table class="col-md-5 ml-1 table table-dark "style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th colspan="2">포인트</th>
					      <td>[<a href="javascript:goCoinPurchaseTypeChoice('${(sessionScope.loginuser).user_id}','<%= ctxPath%>')">코인충전</a>]</td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      	<td colspan="3" class="text-center"><fmt:formatNumber value="${loginuser.user_coin}" pattern="###,###" /> POINT </td>		
					    </tr>
					    
					  </tbody>
					</table>
				</div>
				
				
				<div class="row">
					<table class="col-md-11 table table-dark"style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th colspan="2">구매 정보</th>
					      <td class="text-right"><a href="#">장바구니 바로가기</a></td>
					    </tr>
					  </thead>
					  <tbody>
					  	<tr>
					  		<td colspan="3" class="text-center">장바구니 내용 뿌리기</td>
						</tr>
					  </tbody>
					</table>
				</div>
				
            </div>
            
                           <div class="col-lg-12 mt-6" >
            	<div>
            		<h2 style="color:white;">계정 상세 정보(정보 변경 --- 더보기 배우고 처리)</h2>
				</div>
				<div class="row">
					<table class="col-md-11 table table-dark"style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th style="width:150px">내 정보</th>
					      <td class="text-right"><a href="#">변경하기</a></td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <td >아이디</td>
					      <td>${loginuser.user_id}</td>
					    </tr>
					  </tbody>
					</table>
					
					<table class="col-md-11 table table-dark"style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th style="width:150px">성명</th>
					      <td class="text-right"><a href="#">변경하기</a></td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <td >이름</td>
					      <td>${loginuser.user_name}</td>
					    </tr>
					  </tbody>
					</table>
					
					<table class="col-md-11 table table-dark"style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th style="width:150px">이메일</th>
					      <td class="text-right"><a href="#">변경하기</a></td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <td >이메일</td>
					      <td >${loginuser.user_email}</td>
					    </tr>
					  </tbody>
					</table>
					
					<table class="col-md-11 table table-dark"style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th style="width:150px">주소</th>
					      <td class="text-right"><a href="#">변경하기</a></td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <td >주소</td>
					      <td >${loginuser.user_address}, ${loginuser.user_detail_address} ${loginuser.user_extraaddress}</td>
					    </tr>
					  </tbody>
					</table>
					
					<table class="col-md-11 table table-dark"style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th style="width:150px">연락처</th>
					      <td class="text-right"><a href="#">변경하기</a></td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <td >연락처</td>
					      <td >${loginuser.user_phone}</td>
					    </tr>
					  </tbody>
					</table>
					
						<table class="col-md-11 table table-dark"style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th style="width:150px">회원 탈퇴</th>
					      <td class="text-right"><a href="#">탈퇴하기</a></td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <td colspan="3">회원에서 탈퇴하려면 탈퇴하기 버튼을 눌러주세요</td>
					      
					    </tr>
					  </tbody>
					</table>
				</div>
				
            </div>
        </div>
    </div>
</div>
<br>
<br><br>
<br>
<br>

	<section>
   <div>
       <footer class="footer">
           <div class="footer-content text-center">
              <img src="<%= ctxPath%>/img/blz.jpg" style="width: 8%;"/>
               <div class="footer-btn" style="font-size: 10pt;">
                   <a href="#" style="text-decoration: none"><span style="color: gray;">인재채용</span></a>
                   <a href="#" style="text-decoration: none"><span style="color: gray;">회사소개</span></a>
                   <a href="#" style="text-decoration: none"><span style="color: gray;">고객지원</span></a>
                   <a href="#" style="text-decoration: none"><span style="color: gray;">문의등록</span></a>
                   <a href="#" style="text-decoration: none"><span style="color: gray;">보도자료</span></a>
                   <a href="#" style="text-decoration: none"><span style="color: gray;">API</span></a>
                   <a href="#" style="text-decoration: none"><span style="color: gray;">사이트맵</span></a>
               </div>
               <div class="footer-links">
                   <a href="#" style="text-decoration: none">홈</a>
                   <a href="" style="text-decoration: none">게임</a>
                   <a href="" style="text-decoration: none">커뮤니티</a>
                   <a href="" style="text-decoration: none">지원</a>
               </div>
               <p style="color: gray;">&copy; 2023 | 3조 | 판권 소유</p>
               
               <br>
               
               <div>
                  <span style="color: gray;">김경민 엔터테인먼트 주식 회사</span> <br>
                  <span style="color: gray;">주소: 06164 서울시 강남구 테헤란로 521 파르나스타워 15층</span> <br>
                  <span style="color: gray;">대표 번호: 1644-0727 | 팩스 번호: (02)544-3038 | 이메일: websupport@blizzard.co.kr</span> <br>
                  <span style="color: gray;">사업자 등록 번호: 211-87-49910 | 통신 판매업 신고 번호: 강남-6017호</span> <br>
                  <span style="color: gray;">대표이사: 서영학 | 개인정보 보호책임자: 박승우</span>
               </div>
               
               
               
           </div>
       </footer>
   </div>
</section>

               <br>
               <br>




</body>
</html>
 
 
<!--  이 코드는 Bootstrap의 그리드 시스템 및 클래스를 사용하여 섹션의 레이아웃을 구성하고, 섹션의 높이를 최소 250px로 고정하도록 했습니다. 기존 코드와 Bootstrap을 통합하여 웹 페이지를 디자인할 수 있게 되었습니다. 페이지의 다른 부분에 대해서도 Bootstrap을 활용하여 반응형 디자인을 추가할 수 있습니다. -->


