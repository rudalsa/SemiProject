<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<jsp:include page="../header_suc.jsp" />

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/shop/ovwcarinfo.css"/>

<style>
html{
    overflow-x:hidden;
}

</style>

	
	<div class="video-container">
		<c:if test="${not empty requestScope.ociList}">
			 <c:forEach var="ocivo" items="${requestScope.ociList}" varStatus="status">
				<video autoplay loop muted >
					<source src="<%= ctxPath%>/img/ovwcarinfo_img/${ocivo.carinfo_bg_gif}" type="video/mp4" style="background-size: cover;">			
				</video>
				<div class="content" style="background-color:black;">
					<div class="content-1" style="text-align:center; z-index: 1;">
						<div>
							<img src="<%= ctxPath %>/img/ovwcarinfo_img/${ocivo.carinfo_fr_img1}" style="width:37%; margin-top: 10%;"   />
						</div>									
						<p style="font-weight: bold; color: white; font-size: 14pt;">르세라핌 X 오버워치 2는 오버워치 2의 기간 한정 콜라보 이벤트로, 2023년 11월 2일부터<br> 11월 21일까지 진행됩니다.</p>
						<button onclick="location.href='mainShop.bz'" type="button" class="btn btn-danger text-white btn_text mt-5 mr-3" style="margin-bottom: 6%; width: 17%; height: 60px; 
			              border: none; border-radius: 50px; font-size: 14pt; font-weight: bold; float:center; ">지금 플레이하기</button>
						<button onclick="location.href='mainShop.bz'" type="button" class="btn btn-secondary text-white btn_text mt-5 mr-3" style="margin-bottom: 6%; width: 17%; height: 60px; 
			              border: none; border-radius: 50px; font-size: 14pt; font-weight: bold; float: center; ">배틀패스 업그레이드</button>	              					
					</div>			
				</div>
		  	</c:forEach>
		</c:if>
	</div>
	
	<div class="container-2">
	  <c:if test="${not empty requestScope.ociList}">
		 <c:forEach var="ocivo" items="${requestScope.ociList}" varStatus="status">
		<div>
			<div style=" height:820px; background-image: url('<%= ctxPath %>/img/ovwcarinfo_img/${ocivo.carinfo_bg_img1}'); background-size: cover; ">			
				<img src="<%= ctxPath %>/img/ovwcarinfo_img/${ocivo.carinfo_fr_img2}" width="50%" style="margin-top: 23%" />
				<div class="inner-text1" style="width:35%; float:right; margin: 15% 5% 0 0;">
					<h1 style="font-weight: bold; color: white; font-size: 45pt; text-align:left; padding-right: 5%; margin-top: 23%">르세라핌 게임 내 이벤트</h1>
					<p style=" font-weight: medium; color: white; font-size: 15pt; text-align:left; padding-right: 7%;">
					오버워치 2가 최초의 음악 콜라보를 진행하며 르세라핌과 힘을 
					합칩니다. 슈팅스타 D.Va, 차트 역행 트레이서, 여우길의 요정 
					키리코, 걸크러시 솜브라, 정비돌 브리기테가 되어 마을에서 열리는 
					르세라핌의 초대형 콘서트 티켓을 모아야 합니다. 새롭고 특별한 
					3대3 팀 데스매치 모드에서 치열하게 전투를 펼치고 우스꽝스러운 
					폭시 제임스 정크랫 스킨을 획득하세요.
					</p>
				</div>
			</div>
		</div>
		
		<div>
			<div style=" height:800px; background-color:black;">		
				<br><br>
				<div class="inner-text2_1" style="text-align:center;">
					<h5 style="font-weight: bold; color:grey;">하이라이트</h5>
					<h1 style="font-weight: bold; color:#ebdbc2; font-size: 45pt;">새 소식</h1>
					<h5 style="color: #ebdbc2; font-weight: bold; font-size: 15pt; color:grey;">이번 시즌에 준비되어 있는 콘텐츠를 확인하세요.</h5>			
				</div>
			   	  <!-- row 시작-->
		       <div class="row card-container">
		          <div class="col-sm-4 col-sm-4;" >
		             <div class="card border-0">
		               <img src="<%= ctxPath %>/img/ovwcarinfo_img/${ocivo.carinfo_card_img1}" class="card-img-top" alt="..." />
		               <div class="card-body" style="background-color: black;">
		                 <h5 style="font-weight: bold; font-size:12pt; color:grey;">11월 2일부터 11월 21일까지</h5>
		                 <h5 class="card-title">콘서트 대격돌</h5>
		                 <p class="card-text" style="font-weight: bold; color:lightgrey;">콘서트 대격돌은 새로운 기간 한정 게임 모드입니다. 팀 데스매치 유형의 이 게임 모드에서는 3인으로 이루어진 두 팀이 티켓을 모아 반환하기 위해 경쟁합니다. 새로운 도전 과제를 완료하여 정크랫 전설 스킨을 비롯한 신규 보상을 획득하세요.</p>
		               </div>
		             </div>
		          </div>
		          
		          <div class="col-sm-4 col-sm-4">
		             <div class="card border-0">
		               <img src="<%= ctxPath %>/img/ovwcarinfo_img/${ocivo.carinfo_card_img2}" class="card-img-top" alt="..." />
		               <div class="card-body" style="background-color: black;">
		                 <h5 style="font-weight: bold; font-size:12pt; color:grey;">모든 시즌에서 플레이 가능</h5>
		                 <h5 class="card-title">신규 전장: 사모아</h5>
		                 <p class="card-text" style="font-weight: bold; color:lightgrey;">숨 막히는 3개의 거점으로 구성된 열대의 낙원으로 떠날 준비는 되셨나요? 이 전장은 특출난 수직 공간과 전략적인 통로를 갖추고 있습니다.</p>
		               </div>
		             </div>
		          </div>
		          
		          <div class="col-sm-4 col-sm-4">
		             <div class="card border-0">
		               <img src="<%= ctxPath %>/img/ovwcarinfo_img/${ocivo.carinfo_card_img3}" class="card-img-top" alt="..." />
		               <div class="card-body" style="background-color: black;">
		                 <h5 style="font-weight: bold; font-size:12pt; color:grey;">모든 시즌에서 플레이 가능</h5>
		                 <h5 class="card-title">솜브라 개편</h5>
		                 <p class="card-text" style="font-weight: bold; color:lightgrey;">새롭게 개편된 솜브라의 기술들을 확인하세요. 새로워진 바이러스 능력과 더불어 개편 사항이 적용되었습니다.</p>
		               </div>
		             </div>
		          </div>
		       
		          
		       </div>
		       <!-- row 끝-->
			</div>
		</div>
		
		
			<div class="text-left" style=" border:solid 0px grey; height:850px; background-image: url('<%= ctxPath %>/img/ovwcarinfo_img/${ocivo.carinfo_bg_img2}'); background-size: cover; ">		
					<br><br>
					<h1 style="font-weight: bold; color:white; font-size: 45pt; text-align:center;">배틀 패스 비교</h1>								
			   	  <!-- row 시작-->
		       <div class="row card-container" style="margin: 3% 0 0 12%;">
		         
		          <div class="col-sm-3 col-sm-3" >
		             <div class="card border-0">
		               <img src="<%= ctxPath %>/img/ovwcarinfo_img/${ocivo.carinfo_card_img4}" class="card-img-top" alt="..." />
		               <div class="card-body2" style=" font-weight:bold; font-size:13pt;">		                 
		                 <br>
		                 <h4 class="card-title" style=" text-align:center; font-weight:bold; font-size: 22pt;">무료 배틀 패스</h4>
		                 <ul>
		                 	<li>특급 스킨 2개</li>
		                 	<li>무기 장식품 1개</li>
		                 	<li>하이라이트 연출 1개</li>
		                 	<li>감정 표현 2개</li>
		                 	<li>음성 대사 5개</li>
		                 	<li>프레스티지 단계 칭호</li>
		                 	<li>1,500 크레딧</li>
		                 	<li>추가 보상 10여 종</li>		                 	
		                 </ul>
		               </div>
		             </div>
		          </div>
		          
		          <div class="col-sm-3 col-sm-3;" >
		             <div class="card border-0">
		               <img src="<%= ctxPath %>/img/ovwcarinfo_img/${ocivo.carinfo_card_img5}" class="card-img-top" alt="..." />
		               <div class="card-body2" style="padding-bottom:10%; font-weight:bold;">
		                 <h5 style=" margin-top: 3%; text-align:center; font-weight:bold; color: #ebdbc2; font-size: 13pt;">1000 오버워치 코인</h5>
		                 <h4 class="card-title" style=" text-align:center; font-weight:bold; font-size: 22pt;">프리미엄 배틀 패스</h4>
		                 <span style="text-align:left;">&nbsp;&nbsp;무료 배틀 패스의 모든 전리품 +</span>
		                 <ul style="text-align:left; font-size: 13pt;">		                 			                 	
		                 	<li>맞춤 쌍룡 테마가 적용된 신화 한조 스킨</li>
		                 	<li>배틀 패스 경험치 20% 부스트</li>
		                 	<li>전설 스킨 5개와 특급 스킨 2개</li>
		                 	<li>무기 장식품 4개</li>
		                 	<li>하이라이트 연출 3개</li>
		                 	<li>감정 표현 3개</li>
		                 	<li>음성 대사 9개</li>
		                 	<li>승리 포즈 4개</li>
		                 	<li>500 추가 크레딧</li>
		                 	<li>추가 보상 20여 종</li>
		                 </ul>
		               </div>
		             </div>
		          </div>
		          
		          <div class="col-sm-3 col-sm-3;" >
		             <div class="card border-0">
		               <img src="<%= ctxPath %>/img/ovwcarinfo_img/${ocivo.carinfo_card_img6}" class="card-img-top" alt="..." />
		               <div class="card-body2" style="font-weight:bold;">
		                 <h5 style=" margin-top: 3%; text-align:center; color: #ebdbc2; font-weight:bold; font-size: 13pt;">￦49,600</h5>
		                 <h4 class="card-title" style=" text-align:center; font-weight:bold; font-size: 22pt;">궁극의 배틀 패스 묶음 상품</h4>		                 
		                 <span style="text-align:left;">&nbsp;&nbsp;프리미엄 배틀 패스의 모든 전리품 +</span>
		                 <ul style="text-align:left; font-size: 13pt;">
		                 	<li>2,000 오버워치 코인</li>
		                 	<li>20단계 건너뛰기</li>
		                 	<li>호박 맛 바스티온 특급 스킨</li>
		                 	<li>릴리트 모이라 전설 스킨</li>
		                 	<li>이나리우스 파라 전설 스킨</li>
		                 </ul>
		               </div>
		             </div>
		          </div>		          
		       
		       
		       <!-- row 끝-->
		       </div>
			</div>
		
			</c:forEach>
		</c:if>
	</div>
    

<jsp:include page="../footer_suc.jsp" />