<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/buy/buygame.js"></script>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/shop/gameopt.css"> 




<%-- 캐러셀 함수 --%>
<script>
	$(document).ready(function() {
	    // 이미지 클릭 이벤트 처리
	    $('.imgmove img').click(function() {
	        // 클릭된 이미지의 src 가져오기
	        var newImageSrc = $(this).attr('src');
	        
	        // 캐러셀 이미지 변경
	        $('.carousel-inner .carousel-item.active img').attr('src', newImageSrc);
	    });
	
	    
	});
	
	function imgclick(e) {
		  const img = e.target;
		  img.style.borderBottom = "10px solid #007bff";
		}
	
	function imgmouseout(e) {
	  const img = e.target;
	  img.style.borderBottom = "none"; // 보더를 제거합니다.
	}

</script>
<%-- 캐러셀 함수 --%>

<script>
  
  
  <%-- 버튼 함수 --%>
  $(document).ready(function () {
    
	  $('.custom-transparent-button').click(function () {
      // 모든 버튼에서 'active' 클래스 제거
      $('.custom-transparent-button').removeClass('active');
      // 클릭된 버튼에만 'active' 클래스 추가
      $(this).addClass('active');
    });
    <%-- 버튼 함수 --%>

    
    
	<%-- 개수 조정 함수 --%>
    
	document.addEventListener("keydown", function (e) {
    	// 모든 키보드 입력을 무시
    	e.preventDefault();
    });
    
    $("input#spinner").spinner( {
        spin: function(event, ui) {
           if(ui.value > 100) {
              $(this).spinner("value", 10);
              return false;
           }
           else if(ui.value < 1) {
              $(this).spinner("value", 1);
              return false;
           }
        }
     });// end of $("input#spinner").spinner({});----------------    
    
  });
</script>

<jsp:include page="../header_suc.jsp" />
<%-- 전체 --%>


<c:if test="${not empty requestScope.gameVO}">
	<c:if test="${not empty requestScope.OptiList}">

	<div class="row mx-auto" style="width:95%; margin: 8% 0 0 0">
		<%-- 8분할 --%>	
		<div class="col-8 mr-auto">
<%-- Bootstrap 그리드 시스템 클래스는 기본적으로 패딩과 간격을 포함하는데, 이로 인해 캐러셀이 왼쪽 끝에 붙이지 않을 수 있습니다. 또한, margin: 0을 명시적으로 지정하면서 간격을 줄여버릴 수도 있습니다. --%>
		
		<%----------------------------------------------------------------------------------------------------------- 캐러셀 시작 --%>
		<div id="carousel_slide" class="carousel slide carousel-fade" data-ride="carousel" style="width:100%; margin:0 0 0 0">
		 		
			<%-- 캐러셀 이너 --%>
			<div class="carousel-inner">
	
				<div class="carousel-item active">
					<img src="<%= ctxPath %>/img/tbl_game_product_image/${requestScope.gameVO.g_img_1}" class="img-fluid">
				</div>
				
                <c:if test="${not empty requestScope.OptiList}">
                	<c:forEach var="optvo" items="${requestScope.OptiList}">	
				    	<div class="carousel-item">
                        	<img src="<%= ctxPath%>/img/tbl_game_product_image/${optvo.imgfile}" class="img-fluid">
                        </div>
                    </c:forEach>
                </c:if>
			</div>
			<%-- 캐러셀 이너 끝 --%>
			
			<%--캐러셀(Carousel)의 화살표 컨트롤--%>	
			<a class="carousel-control-prev" href="#carousel_slide" role="button" data-slide="prev">
	            <span class="carousel-control-prev-icon"></span>
	            <span class="sr-only">Previous</span>
	        </a>
            <a class="carousel-control-next" href="#carousel_slide" role="button" data-slide="next">
            	<span class="carousel-control-next-icon"></span>
            	<span class="sr-only">Next</span>
            </a>
			<%--캐러셀(Carousel)의 화살표 컨트롤--%>
			
		</div>
		<%--------------------------------------------------------------------------------------------------- 캐러셀 끝 --%>
		
		
		<div class="text-white mt-3">
			<h1 class="font-weight-bold">${requestScope.gameVO.g_content}</h1>
			<h5> ${requestScope.gameVO.g_info}</h5>
		</div>
		
		
		<div class="row mt-3" >	
			
			<div class="col-3 imgsm imgmove">
				<img src="<%= ctxPath %>/img/tbl_game_product_image/${requestScope.gameVO.g_img_1}" class="img-fluid" onclick="imgclick(event)" onmouseout="imgmouseout(event)"> 
			</div>
			<c:if test="${not empty requestScope.OptiList}">
            	<c:forEach var="optvo" items="${requestScope.OptiList}">	
	    			<div class="col-3 imgsm imgmove">
                    	<img src="<%= ctxPath%>/img/tbl_game_product_image/${optvo.imgfile}" class="img-fluid" onclick="imgclick(event)" onmouseout="imgmouseout(event)">
                    </div>
                </c:forEach>
                
            </c:if>
            
         </div>	
	
	</div> 
	<%-- 8분할 ----------------------------------------------------------------------------------------------%>		
		
    <div class="col-4">
    
    <div class="container text-white" style="">	    	
   		
   		<div class="container text-white" style="">	
			<div class="row">
				
				<div class="col-3">
			    	<img class="game_logo" src="<%= ctxPath%>/img/img/tbl_game_option/logo-hs-93512467e87f82c6.png"></img>
				</div>
				
				<div class="col-9">
					<span class="h3 ml-auto font-weight-bold">${requestScope.gameVO.g_content}</span>
					<br><br>
					<span class="font-weight-bold" style="color:#ccc;">${requestScope.gameVO.g_company}</span>
		    	</div>
		    	
     		</div>
    	
    	<div class="table-responsive">           
    	
    	<table class="table table-borderless">
	        
	        <thead>
	        	<tr class="price">
	            	<th><span class="h3 text-white font-weight-bold">Choose Option</span><span class="h3" style="color: #00FF00;">SALE</span></th>
	            </tr>
	        </thead>
          
        	
        	
        	<%-- 주문 돈 부터 버튼 --------------------------------------------------------------------%>
        	<tbody>
           	
	           <c:if test="${not empty requestScope.OptiList}">
	            	<c:forEach var="optvo" items="${requestScope.OptiList}">
			  			<tr class="price custom-radio">
						    <td>
							    <label class="btn custom-transparent-button">
							    <input type="radio" class="${optvo.optinfono}" id="${optvo.opt_name}" name="coinmoney" value="${optvo.opt_sale_price}"/>
							    <span class="opttitle">${optvo.opt_name}</span>
							    <br>
							    <span class="panmaeprice">${optvo.opt_sale_price}</span>
							    <span class="saleprice">${optvo.opt_price}</span>
							    <span class="per" style="color:#0074E4; font-weight: bold;">&nbsp;${optvo.getDiscountPercent()}%&nbsp;</span>
							    </label>
						    </td>
			 		 	</tr>
	  				</c:forEach>
	  			</c:if>
	  			
	  			<%-- <c:if test="${not empty requestScope.gameVO}"> 옵션이 비었을경우 --%>
	  			<c:if test="${empty requestScope.OptiList}">
				<tr class="price custom-radio">
				  	<td>
				   		<label class="btn custom-transparent-button">
				   		<input type="radio" id="${requestScope.gameVO.g_name}" name="coinmoney" value="${requestScope.gameVO.g_price}"/>
				 		<span class="opttitle">${requestScope.gameVO.g_name}</span>
				 		<span class="panmaeprice">${requestScope.gameVO.g_sale_price}</span>
				 		<span class="saleprice">${requestScope.gameVO.g_price}</span>
				 		</label>
					</td>
					<td class="per">
				  	<span>${requestScope.gameVO.g_code}</span>
				  	</td>
				</tr>
			 	</c:if>
	  			<%-- <c:if test="${not empty requestScope.gameVO}"> 옵션이 비었을경우 --%>
  			
       	
	            <tr>
	               <td id="error" colspan="3"><br>결제종류에 따른 금액을 선택하세요!!</td>
	            </tr>
             
          </tbody>
        
        </table>
     
     </div>
     
     <div class="purchase-btn text-center">
	 	
	 	 <%-- ==== 장바구니 주문 개수 폼 ==== --%>
         <form name="goCartFrm">       
            <ul class="list-unstyled mt-3">
        		<li>남은수량: <span style="color: maroon; font-weight: bold;">${requestScope.gameVO.g_qty} 개</span></li> 
                <li>
                    <label for="spinner">주문개수&nbsp;</label>
                    <input id="spinner"  name="oqty"   value="1" style="width: 110px;">
                    <input type="hidden" name="g_code" value="${requestScope.gameVO.g_code}" >
                    <input type="hidden" name="g_qty" value="${requestScope.gameVO.g_qty}">
                    <input type="hidden" name="optno">
                    <input type="hidden" name="paymoney" > 
                </li>
            </ul>
         </form> 
		 <%-- ==== 장바구니 주문 개수 끝 ==== --%> 
		  
	 	<ul class="list-unstyled">
	    	
	    	<li id="purchase" class="btn" onclick="buygame('<%=ctxPath %>','${sessionScope.loginuser.user_id}')" >
	          &nbsp;구매하기
	    	</li>
		    <c:if test="${not empty sessionScope.loginuser}">
		      	<li id="cart" class="btn mt-3" onclick="goCart()">
		          	&nbsp;장바구니
		      	</li>
	    	</c:if>
	    	<c:if test="${empty sessionScope.loginuser}">
		      	<li id="like" class="btn mt-3" onclick="golike('<%= ctxPath%>')">
		          	&nbsp;찜하기
		      	</li>
	    	</c:if>
	    
	    </ul>
	  
	   <%-- PG(Payment Gateway 결제대행)에 코인금액을 카드(카카오페이등)로 결제후 DB상에 사용자의 코인액을 update 를 해주는 폼이다. --%>

	   <form name="coin_DB_Update_Frm">
		   	<input type="hidden" name="user_id" />
		   	<input type="hidden" name="coinmoney" />	
	   </form>
	  	
	    
	</div>
	
	<div class="row">
				<div class="col-3">
			    	<img class="game_logo" src="<%= ctxPath%>/img/tbl_game_product_image/12age.png"></img>
				</div>
				<div class="col-9">
					<span class="h5 ml-auto font-weight-bold">12세 이용가 입니다. 그 이하의 나이는 보호자의 지도가 필요합니다.</span>
					<br><br>
					<span class="font-weight-bold" style="color:#ccc;">12세이용가</span>
		    	</div>
     		</div>
   
   </div>
  
  </div>

</div>


<hr class="mx-auto" style="background-color: white; width:100%;">


<div class="row mx-auto mt-3" style="width:95%;">

	<div class="col-4">
        <div class="h2 text-white text-left font-weight-bold mt-3">
           <span >상품비교</span>
        </div>
	</div>
	
	<div class="col-8">
	   
		<div class="row mt-3" style="width: 100%;" >	
			 
			 <c:if test="${not empty requestScope.OptiList}">
            	
            	<c:forEach var="optvo" items="${requestScope.OptiList}">	
	    			<div class="col-6 imgsm">
                    	<img src="<%= ctxPath%>/img/tbl_game_product_image/${optvo.imgfile}" class="img-fluid">
                    	<ul class="mt-3">
			       			<li><span class="opttitle">${optvo.opt_name}</span></li>
							<li> <span class="panmaeprice">${optvo.opt_sale_price}</span></li>
							<li><span class="saleprice">${optvo.opt_price}</span></li>
							<li class="btn btn-primary font-weight-bold">
					          &nbsp;자세히보기
					    	</li>
					    	<li class="text-left">
					    		<span class="opttitle">${optvo.opt_content}</span>
					    	</li>
						</ul>
                    </div>
                </c:forEach>
                
            </c:if> 
		</div>
	</div>
</div>




<hr class="mx-auto" style="background-color: white; width:100%;">

<div class="row mx-auto mt-3" style="width:95%;">
	
	<div class="col-4">
	     <div class="h2 text-white text-left font-weight-bold mt-3">
           <span >영상</span>
        </div>
	</div>
	
	<div class="col-8">
		<iframe width="100%" height="600px" src="https://www.youtube.com/embed/hLvWy2b857I?si=b6oKda86CgMdD2QM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
	</div>

</div>

<hr class="mx-auto" style="background-color: white; width:100%;">
	
<div class="row mx-auto mt-3" style="width:95%;">
	<div class="col-4">
	     <div class="h2 text-white text-left font-weight-bold mt-3">
           <span >이용약관</span>
        </div>
	</div>
	
	<div class="col-8">
		<div class="text-white"><hr>
			<p>상품 이용기간: 별도 표기가 없을 경우 서비스 종료 시까지. 이용기간에 관한 별도 표기가 있는 경우 해당 기간 동안 이용 가능합니다.</p>
			<p>본 상품은 디지털 다운로드 방식으로 제공되는 상품으로서 구매 즉시 계정에 자동 등록됩니다.</p>
			<p>예약 구매 상품의 경우에는 출시전까지 환불 가능합니다.</p>
			<p>시험사용상품이 제공되거나 구매 후 즉시 서비스의 이용이 개시되는 경우 등 구매 상품의 특성에 따라 청약철회가 제한되는 경우가 있습니다. 게임 플레이를 통해 획득한 아이템 또는 이를 사용하여 획득한 상품은 환불이 불가능합니다. 환불은 청약 철회일로부터 3일 영업일 이내에 이루어 집니다. 자세한 사항은 <a href="https://kr.battle.net/support/ko/article/75828" target="_blank" rel="external">환불정책</a> 을 참고해 주세요.</p>
			<p>법정대리인의 동의가 없는 미성년자의 결제는 취소될 수 있습니다.</p>
			<p>선물한 상품은 구매 후 7일 이내에 청약철회가 가능합니다. 다만, 구매 후 수신인이 수령한 경우에는 청약철회가 제한됩니다.</p>
			<p>본 거래는 <a href="https://kr.blizzard.com/eula" target="_blank" rel="external">Blizzard 최종 사용자 라이선스 계약</a> 및 판매 시 제공된 조건에 따릅니다. 지불이나 환불과 관련한 문제가 발생한 경우, 해당 계정은 관련 문제가 해결될 때까지 잠시 정지될 수 있습니다.</p>
			<p>청약철회, 환불, 회원탈퇴, 소비자 불만과 관련한 내용은 <a href="https://kr.battle.net/support/ko/" target="_blank" rel="external">고객지원</a>에 연락해야 합니다.</p>
			<p>본 상품은 구매안전서비스를 제공하지 않습니다. 소비자피해보상은 판매 시 제공된 조건, 약관 및 소비자 분쟁 해결 기준 등 법령에 따릅니다.</p>
		</div>
		<div class="text-white"><hr>
			<p>판매자 정보: 블리자드 엔터테인먼트 유한회사</p>
			<p>대표이사: 박승우 | 개인정보 보호책임자: 이요섭</p>
			<p>주소: 00000 서울시 강남구 롯데타워 521 시그니처타워 15층</p>
			<p>연락처: (전화) 1688-0000 (팩스) 02-777-7777 (이메일) k8910275@naver.com</p>
			<p>사업자 등록 번호: 112-112-119911</p>
			<p>통신 판매업 신고 번호: 강남-9999호</p>
		</div>

	</div>
</div>
		

</div>
</c:if>
</c:if>



	<div class="mt-5" style="width:100%; display: flex; justify-content: center; align-items: center;">
	    <img src="<%= ctxPath %>/img/newshop/logo_steam.svg" style="width: 20%;"/>
	</div>
	
	<div class="mt-5" style="width:100%; display: flex; justify-content: center; align-items: center; text-white">
	    <h2> 이런 게임은 어떠세요???</h2>
	</div>
	
	<div class="mt-5" style="width:100%; display: flex; justify-content: center; align-items: center;">
	    <img class="mr-3" style="width:75px; height:75px;" src="<%= ctxPath %>/img/newshop/games_cod-mw.svg" name="">
	    <img class="mr-3" style="width:75px; height:75px;" src="<%= ctxPath %>/img/newshop/games_diablo.svg" name="">
	    <img class="mr-3" style="width:75px; height:75px;" src="<%= ctxPath %>/img/newshop/games_hearthstone.svg" name="">
	    <img class="mr-3" style="width:75px; height:75px;" src="<%= ctxPath %>/img/newshop/games_heroes.svg" name="">
	    <img class="mr-3" style="width:75px; height:75px;" src="<%= ctxPath %>/img/newshop/games_overwatch.svg" name="">
	    <img class="mr-3" style="width:75px; height:75px;" src="<%= ctxPath %>/img/newshop/games_sc2.svg" name="">
	    <img class="mr-3" style="width:75px; height:75px;" src="<%= ctxPath %>/img/newshop/games_scr.svg" name="">
	    <img class="mr-3" style="width:75px; height:75px;" src="<%= ctxPath %>/img/newshop/games_wow.svg" name="">
	</div>
	
	<div class="mt-5" style="width:100%; display: flex; justify-content: center; align-items: center;">
	    <div class="footer-btn" style="font-size: 10pt;">
	        <a href="#" style="text-decoration: none"><span style="color: gray;">인재채용&nbsp;</span></a>
	        <a href="#" style="text-decoration: none"><span style="color: gray;">회사소개&nbsp;</span></a>
	        <a href="#" style="text-decoration: none"><span style="color: gray;">고객지원&nbsp;</span></a>
	        <a href="#" style="text-decoration: none"><span style="color: gray;">문의등록&nbsp;</span></a>
	        <a href="#" style="text-decoration: none"><span style="color: gray;">보도자료&nbsp;</span></a>
	        <a href="#" style="text-decoration: none"><span style="color: gray;">API&nbsp;</span></a>
	        <a href="#" style="text-decoration: none"><span style="color: gray;">사이트맵&nbsp;</span></a>
	    </div>
	</div>

    <div class="mt-3" style="width:100%; display: flex; justify-content: center; align-items: center;">
        <a href="#" style="text-decoration: none">홈&nbsp;</a>
        <a href="" style="text-decoration: none">게임&nbsp;</a>
        <a href="" style="text-decoration: none">커뮤니티&nbsp;</a>
        <a href="" style="text-decoration: none">지원&nbsp;</a>
    </div>
               
  
	<div class="mt-3 mb-5 text-white" style="width: 100%; text-align: center;">
	   <p>판매자 정보: 블리자드 엔터테인먼트 유한회사</p>
		<p>대표이사: 박승우 | 개인정보 보호책임자: 이요섭</p>
		<p>주소: 00000 서울시 강남구 롯데타워 521 시그니처타워 15층</p>
		<p>연락처: (전화) 1688-0000 (팩스) 02-777-7777 (이메일) k8910275@naver.com</p>
		<p>사업자 등록 번호: 112-112-119911</p>
		<p>통신 판매업 신고 번호: 강남-9999호</p>
	</div>
	
	
    
<br><br>


</body>
</html>

