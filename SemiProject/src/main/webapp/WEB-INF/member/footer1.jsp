<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>

<!DOCTYPE html>
<html>
<head>
<title>Batttle.net 메인화면</title>
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
<title>Blizzard footer</title>
</head>
<body>
	<section>
   <div>
       <footer class="footer">
           <div class="footer-content text-center">
              <img src="<%= ctxPath %>/img/blizzardlogo.jpg" style="width: 8%;"/>
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

</body>
</html>