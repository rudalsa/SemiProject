<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String ctxPath = request.getContextPath(); // tempSemi
%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index/main_shop.css"> 

<jsp:include page="header_shop.jsp" />

<jsp:include page="slide.jsp" />

    
    
    
<%-- 추천게임 시작 --%> 
<div class="mt-5" style="">
	<div>
	    <h2 class="mt-5 mb-5 text-white" style="font-weight: bold; font-size: 27pt; margin-left: 6%;">추천 게임</h2>
    </div>
    <div class="row mb-5 pl-1" style="margin: 5px 5%;">
  		<c:if test="${not empty requestScope.imgProductList}">
  			<c:forEach var="imgProductvo" items="${requestScope.imgProductList}" varStatus="status">
  				<c:if test="${status.index >= 0}">
			         <div class="col-md-3 img"> <a href="gameoption.bz?imgsetno=${imgProductvo.product_no}" >
			        	<div class="img-container">
			        		<img src="<%= ctxPath %>/img/tbl_list_image/${imgProductvo.img_file_name}" alt="이미지 5" class="img-fluid" style="width: 100%; height: 200px;">
				            <ul class="list-unstyled text-white text-left">
				                <li style="font-size: 8pt;">${imgProductvo.product_name}</li>
				                <li style="font-weight: bold;">${imgProductvo.product_event_name}</li>
				                <li style="font-size: 8pt; color:orange;">${imgProductvo.gamegenre}</li>
				                <br><br><br>
				                <li><fmt:formatNumber value="${imgProductvo.product_price}" pattern="#,###" />&nbsp;원 <div style="margin-left: 50%; pointer-events: none;" class="btn btn-success btn-sm" >-${imgProductvo.product_sale_percent}%</div></li>
				            </ul>
			        	</div>
			        	</a>
			        </div>
			 	</c:if>	
			  <c:if test="${status.index % 4 == 3}">
			 	</div>
			
			 	
			 	<div class="row mb-5 pl-1" style="margin: 5px 5%;">  
		     </c:if>
	
       	    </c:forEach>
      	
      	</c:if>
    </div>

</div>
<%-- 추천게임 끝 --%>



<%-- ================ 실시간 인기상품 시작 ================ --%>
<h2 class="mt-5 mb-5 text-white" style="font-weight: bold; margin-left: 6%;">실시간 인기상품</h2>
<div class="mt-5" style="">
	<div>
	    <h2 class="mt-5 mb-5 text-white" style="font-weight: bold; font-size: 27pt; margin-left: 6%;">추천 게임</h2>
    </div>
    <div class="row mb-5 pl-1" style="margin: 5px 5%;">
  		<c:if test="${not empty requestScope.popProductList}">
  			<c:forEach var="imgProductvo" items="${requestScope.popProductList}" varStatus="status">
  				<c:if test="${status.index >= 0}">
			         <div class="col-md-3 img"> <a href="gameoption.bz?imgsetno=${imgProductvo.product_no}" >
			        	<div class="img-container">
			        		<img src="<%= ctxPath %>/img/tbl_list_image/${imgProductvo.img_file_name}" alt="이미지 5" class="img-fluid" style="width: 100%; height: 200px;">
				            <ul class="list-unstyled text-white text-left">
				                <li style="font-size: 8pt;">${imgProductvo.product_name}</li>
				                <li style="font-weight: bold;">${imgProductvo.product_event_name}</li>
				                <li style="font-size: 8pt; color:orange;">${imgProductvo.gamegenre}</li>
				                <br><br><br>
				                <li><fmt:formatNumber value="${imgProductvo.product_price}" pattern="#,###" />&nbsp;원 <div style="margin-left: 50%; pointer-events: none;" class="btn btn-success btn-sm" >-${imgProductvo.product_sale_percent}%</div></li>
				            </ul>
			        	</div>
			        	</a>
			        </div>
			 	</c:if>	
			  <c:if test="${status.index % 4 == 3}">
			 	</div>
			
			 	
			 	<div class="row mb-5 pl-1" style="margin: 5px 5%;">  
		     </c:if>
	
       	    </c:forEach>
      	
      	</c:if>
    </div>

</div>
   
<%-- ================ 실시간 인기상품 끝 ================ --%>




<%-- =============== 타이머 시작 =============== --%>
<body>
    <nav class="navbar navbar-expand-lg mx-auto mt-4" id="scrollNavbar" style="width: 90%; background-image: url('<%= ctxPath %>/img/nav_btm_img.jpg'); background-size: cover; background-position: center 15%; background-repeat: no-repeat;">
        <a class="navbar-brand ml-4" href="<%= ctxPath %>/mainShop.up">
            <i class="fa-solid fa-dragon"></i>
        </a>
        <div style="color: white;">오픈 베타 시작까지:&nbsp;&nbsp;</div>
        <div style="display: flex;">
            <div style="color: orange; font-size: 16pt; background-color: black; padding: 5px; border-radius: 5px; margin:3px;" id="hours">:</div><span style="color:orange; position: relative; top: 12px;">:</span>
            <div style="color: orange; font-size: 16pt; background-color: black; padding: 5px; border-radius: 5px; margin:3px;" id="minutes">:</div><span style="color:orange; position: relative; top: 12px;">:</span>
            <div style="color: orange; font-size: 16pt; background-color: black; padding: 5px; border-radius: 5px; margin:3px;" id="seconds"></div>
        </div>
    </nav>

    <script>
        // 2023년 10월 15일까지의 초 계산
        var targetDate = new Date("2023-10-26T00:00:00").getTime();
        var currentDate = new Date().getTime();
        var countdown = Math.max(0, Math.floor((targetDate - currentDate) / 1000));

        // 타이머 업데이트 함수
        function updateTimer() {
            var hours = Math.floor(countdown / 3600);
            var minutes = Math.floor((countdown % 3600) / 60);
            var seconds = countdown % 60;

            // 각 시간 요소에 업데이트
            document.getElementById('hours').textContent = hours;
            document.getElementById('minutes').textContent = minutes.toString().padStart(2, '0');
            document.getElementById('seconds').textContent = seconds.toString().padStart(2, '0');

            if (countdown === 0) {
                clearInterval(timerInterval); // 타이머가 0이면 중지
                document.getElementById('hours').textContent = "시간 종료";
                document.getElementById('minutes').textContent = "";
                document.getElementById('seconds').textContent = "";
            } else {
                countdown--; // 1초씩 감소
            }
        }

        // 초기 업데이트 호출
        updateTimer();

        // 1초마다 업데이트 호출
        var timerInterval = setInterval(updateTimer, 1000);
    </script>
</body>

<%-- =============== 타이머 끝 =============== --%>


<%-- =============== PS5 홍보창 시작 =============== --%>
<section class="backgroundimg mt-4" style="background-image: url('<%= ctxPath %>/img/main_page_img/desktop.jpg'); background-size: 90% 90%; background-position: center; background-repeat: no-repeat; height: 600px;">
    <div class="container" style="width: 80%; margin: 0 auto;">
        <div class="row">
            <div id="buy_of_ps5" class="text-white text-center" style="margin-top: 10%;">
                <h1 style="font-weight: bold;">PS5™ 콘솔을 구매하세요</h1>
                <br>
                <h5 style="font-weight: bold;">무엇을 선택하든 즐거운 게임과 엔터테인먼트 세상을 누릴 수 있습니다.</h5>
                <br>
                <a href="<%= ctxPath %>/psPurchase.bz" class="btn btn-primary mt-2 text-white btn_text" style="text-align: center; font-weight: bold; width: 250px; height: 50px; margin: 0 auto;" >
                    &nbsp;<i class="fa-brands fa-xbox mt-2" style="font-weight: bold; font-size: 14pt;">&nbsp;PS 구매하기</i> 
                </a> 
                <a href="<%= ctxPath %>/psPurchase.bz" class="btn btn-success mt-2 text-white ml-2 btn_text" style="text-align: center; font-weight: bold; width: 250px; height: 50px; margin: 0 auto;">
                    &nbsp;<i class="fa-brands fa-xbox mt-2" style="font-weight: bold; font-size: 14pt;">&nbsp;PS 악세사리 구매하기</i> 
                </a>
            </div>
        </div>
    </div>
</section>
<%-- =============== PS5 홍보창 끝 =============== --%>

<jsp:include page="age_of_use.jsp" />


<jsp:include page="../footer_suc.jsp" />
