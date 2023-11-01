<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<jsp:include page="../header_suc.jsp" />

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/shop/wowcarinfo.css"/>

	<div class="video-container">
	   <c:if test="${not empty requestScope.wciList}">
		 <c:forEach var="wcivo" items="${requestScope.wciList}" varStatus="status">
			<video autoplay loop muted>
				<source src="<%= ctxPath%>/img/wowcarinfo_img/${wcivo.carinfo_bg_gif}" type="video/mp4">
			</video>
			
			<div class="content">
				<div class="content-1">
					<h1 style="font-weight: bold;">현신의 격노 출시</h1>
					<p style="font-size: 14pt; color: #ebdec2; margin: 3% 0 3% 0;">
						원시의 현신들이 세계수의 힘을 차지할 목적으로 병력을 집결시키고 있습니다. 용사<br> 여러분은 이들에 맞서야
						합니다. 새로운 공개 이벤트 꿈결쇄도에서 화염의 드루이드의<br> 거센 맹공에 맞서고, 새로운 포세이큰 및 나이트
						엘프 유산 방어구로 종족의 유산을<br> 기념해 보세요. 그리고 영웅 난이도 무한의 여명에서 a힘을 합쳐 무한의
						용군단에 맞서고<br> 아제로스를 수호하세요. 그 외에도 다양한 콘텐츠가 준비되어 있습니다.
					</p>
					<button onclick="location.href='mainShop.bz'" type="button" class="mb-3">용군단 구매하기</button><br>
			
					<span>최신 소식 & 업데이트</span> <span>새소식 모두 보기</span>
				</div>
				<div class="row mb-4">
					<div class="col-md-3 img" style="background-image: url('<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_card_img1}'); background-size: cover; background-position: center;"  >
						
						<ul class="list-unstyled text-white text-left pl-2">
							<li>2023년 10월 10일</li>
							<li style="color: orange; font-weight: bold;">블리즈컨® 컬렉션 판매 개시!</li>
						</ul>
					</div>
		
					<div class="col-md-3 img" style="background-image: url('<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_card_img2}'); background-size: cover; background-position: center; ">
						
						<ul class="list-unstyled text-white text-left pl-2">
							<li>2023년 10월 10일</li>
							<li style="color: orange; font-weight: bold;">이번 주의 WoW: 2023년 10월 10일</li>
						</ul>
					</div>
		
					<div class="col-md-3 img" style="background-image: url('<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_card_img3}'); background-size: cover; background-position: center; ">
											
						<ul class="list-unstyled text-white text-left pl-2">
							<li>2023년 10월 10일</li>
							<li style="color: orange; font-weight: bold;">용에 올라타 동부 왕국 우승컵을<br>준비하세요
							</li>
						</ul>
					</div>
		
					<div class="col-md-3 img" style="background-image: url('<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_card_img4}'); background-size: cover; background-position: center; ">
						
						
						<ul class="list-unstyled text-white text-left pl-2">
							<li>2023년 10월 4일</li>
							<li style="color: orange; font-weight: bold; width:100%;">아기 지옥의 군주 꼬마 마그를 입양하세요!</li>
						</ul>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>
	</div>
	
	<div class="container-2">
		<c:if test="${not empty requestScope.wciList}">
			<c:forEach var="wcivo" items="${requestScope.wciList}" varStatus="status">
				<div>
					<div style="height:350px; background-image: url('<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_bg_img1}'); background-size: cover;">
						<br><br>
						<p style="color: #ebdbc2; font-size: 10pt;">BLIZZCON 2023</p>
						<h1 style="font-weight: bold; color:white;">블리즈컨® 컬렉션 판매 개시!</h1>
						<p style="color: #ebdbc2; font-size: 10pt;">
						월드오브 워크래프트와 기타 블리자드 게임 디지털 상품 등 풍성한 콘텐츠가<br>
						포함되어있는 세트로 블리즈컨 개최를 기념해 보세요. 지금 바로 Battle.net 샵에서<br>
						구매하실 수 있습니다.
						</p>
						<button onclick="location.href='mainShop.bz'" type="button">지금 구매하기</button>
					</div>
				</div>
				
				<div>
					<div class="text-right" style="height:350px; background-image: url('<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_bg_img2}'); background-size: cover;">		
						<br><br>
						<p style="color: #ebdbc2; font-size: 10pt;">WOW 클래식 하드코어</p>
						<h1 style="font-weight: bold; color:white;">부활도, 후회도 없습니다!</h1>
						<p style="color: #ebdbc2; font-size: 10pt;">
						WoW 클래식 하드코어 서버에서 아제로스에 산적한 위험 요소를 극복하고<br> 
						얼마나 성장할 수 있는지 스스로를 시험해 보세요. 주어지는 목숨은 단<br> 
						하나뿐이며,	 산 자의 세계로 돌려보내 줄 영혼의 치유사는 없습니다.
						</p>
						<button onclick="location.href='mainShop.bz'" type="button">지금 구매하기</button>
					</div>
				</div>
				
				<div>
					<div style="height:350px; background-image: url('<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_bg_img3}'); background-size: cover;">
						<br><br>
						<p style="color: #ebdbc2; font-size: 10pt;">블리즈컨 2023</p>
						<h1 style="font-weight: bold; color:white;">입장권 추가 판매 실시</h1>
						<p style="color: #ebdbc2; font-size: 10pt;">
						2023년 11월 4~5일 개최되는 블리즈컨®에 참여할 마지막 기회를 놓치지<br>
						마세요. 올해 마지막 입장권 판매입니다. 
						</p>
						<button onclick="location.href='mainShop.bz'" type="button" >지금 구매하기</button>
					</div>
				</div>
				
				<div style="background-color: black; text-align: center; color: #ebdec2;">
					
					<div class="in1" style="display: inline-block; width: 49.8%;">
						<img class="inimg" src="<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_fr_img1}" width="100%" />
						<div class="inner">
							<h5>wow 신규 플레이어</h5>
							<h2 style="color: #f8b700; font-size:25pt; font-weight:bold;">모험을 시작하세요</h2>
							<span>여기서 아제로스로 떠나는 모험을 시작하고 wow를 무료로 플레이해보세요!</span>
						</div>
					</div>
					
					<div class="in2" style="display: inline-block; width: 49.9%">			
						<img class="inimg" src="<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_fr_img2}" width="100%"  />
						<div class="inner">
							<h5>wow 신규 플레이어</h5>
							<h2 style="color: #f8b700; font-size:25pt; font-weight:bold;">모험을 시작하세요</h2>
							<span>여기서 아제로스로 떠나는 모험을 시작하고 wow를 무료로 플레이해보세요!</span>
						</div>	
					</div>
				</div>
				
				<div>
					<div style="height:350px; background-image: url('<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_bg_img4}'); background-size: cover;">
						<br><br><br>
						<h1 style="font-weight: bold; color:white;">교역소 영업 개시!</h1>
						<p style="color: #ebdbc2; font-size: 10pt;">
						교역소가 본격적인 영업을 개시했습니다. 여행자의 인장으로 온갖 신비롭고<br>
						환상적인 물품을 수집품에 추가할 수 있죠. 여행자의 인장은 어떻게 얻냐고요?<br>
						다양한 게임 내 활동을 수행하면 된답니다.
						</p>
						<button onclick="location.href='mainShop.bz'" type="button">지금 구매하기</button>
					</div>
				</div>
				
				<div>
					<div class="text-right" style="height:350px; background-image: url('<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_bg_img5}'); background-size: cover;">			
						<br><br>
						<p style="color: #ebdbc2; font-size: 10pt;">180일 게임 시간 묶음 상품</p>
						<h1 style="font-weight: bold; color:white;">신나는 모험을 즐기세요!</h1>
						<p style="color: #ebdbc2; font-size: 10pt;">
						멋진 지느러미를 뽐내는 경이로운 파도수염 탈것을 탈것 수집품에 추가하세요!<br>
						180일 게임 시간을 구매하고 월드 오브 워크래프트: 리치 왕의 분노 클래식 전용<br>
						깜찍한 글럽 애완동물과 함께 손에 넣으세요.
						</p>
						<button onclick="location.href='mainShop.bz'" type="button">지금 구매하기</button>
					</div>
				</div>
				
				<div>
					<div style="height:350px; background-image: url('<%= ctxPath %>/img/wowcarinfo_img/${wcivo.carinfo_bg_img6}'); background-size: cover;">
						<br><br>
						<p style="color: #ebdbc2; font-size: 10pt;">리치 왕의 분노 클래식</p>
						<h1 style="font-weight: bold; color:white;">리치 왕이 돌아왔습니다</h1>
						<p style="color: #ebdbc2; font-size: 10pt;">
						리치 왕의 분노 클래식이 전 세계에 출시되었습니다. WoW 게임 시간이 남아<br>
						있다면 추가 요금 없이 이용이 가능합니다. 선택 상품인 노스렌드 업그레이드를<br>
						구매하고 70 레벨 캐릭터 업그레이드와 모험에 도움이 되는 각종 상품을 받아<br>
						화려하게 노스렌드로 복귀하세요. 영웅 여러분, 지금 바로 얼어붙은 황무지를<br>
						정복하세요!
						</p>
						<button onclick="location.href='mainShop.bz'" type="button">지금 구매하기</button>
					</div>
					
				</div>
			</c:forEach>
		</c:if>
	</div>
    

<jsp:include page="../footer_suc.jsp" />