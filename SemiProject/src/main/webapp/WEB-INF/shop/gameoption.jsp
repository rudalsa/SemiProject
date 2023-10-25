<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>

<%-- 직접 만든 JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/member/coinPurchaseTypeChoice.js"></script>





<style>

/* 버튼 관련 라디오 */
  input[type="radio"] {
  	display: none;
  }
  
  body > div.row.mx-auto > div.col-4 > div > div.table-responsive > table > tbody > tr:nth-child(1) > td:nth-child(1) > label
  ,body > div.row.mx-auto > div.col-4 > div > div.table-responsive > table > tbody > tr:nth-child(2) > td:nth-child(1) > label
  ,body > div.row.mx-auto > div.col-4 > div > div.table-responsive > table > tbody > tr:nth-child(3) > td:nth-child(1) > label {
  
  text-align: left;
  
  }

  .custom-transparent-button {
    background-color: transparent;
    border: none;
    width: 250px;
  }

  .custom-transparent-button:focus {
    outline: none; /* 클릭 포커스 효과 제거 */
  }

  .custom-transparent-button:active {
    opacity: 0.5; /* 클릭 시 투명도 조절 (0.5은 예시, 필요에 따라 조절 가능) */
  }
  
   .custom-transparent-button.active {
    border-left:  solid 10px #007bff !important; /* 클릭된 버튼의 배경 색상을 지정 */
    color: #fff; /* 클릭된 버튼의 텍스트 색상을 지정 */
  }
/* 버튼 관련 라디오 */


a>i{

    color: white;
    font-size:20pt;
    font-weight: bold;  
}


div.imgsm img {
	width: 100%;
	height: 150px;
}

div.carousel-item.active img,
div.carousel-item img {
	
	/* border: solid 1px white; */
	width: 1000px; 
	height: 500px;
	

}

.game_logo{
	width: 75px;
	height: 75px;

}

li.btn{

	width:100%;
	height: 50px;
	color:white;
	text-align: center; 
	font-weight:bold;
	font-size: 16pt;

}

tr.price{
	height: 70px;
	border-bottom: 1px solid rgba(192, 192, 192, 0.5);

}

td.per{
	text-align: right;
	vertical-align: bottom !important;
} 
td.per>span{
	
	background-color:#00FF00;
	color:black;
	font-weight:bold;
	font-size: 14pt;
	border-radius: 5px;
	width:1%;
	
}

span.opttitle{
	
	font-weight:bold;
	font-size: 16pt;
	font-weight:bold;
	color:white;
}

span.panmaeprice{
	
	font-weight:bold;
	font-size: 16pt;
	font-weight:bold;
	color:#00FF00;

}

span.saleprice{
	
	text-decoration: line-through;
	color:#ccc;
	font-size: 14pt;
	font-weight:bold;
} 

td#error {
  vertical-align: middle;
  text-align: center; /* 텍스트를 수평 중앙에 배치하기 위해서 */
  color: red;
 
  font-size: 14pt;
  font-weight:bold;
}


</style>






<%-- <br><br><br><br><br><br><br><br><br>
구매해야할 제품번호 : ${requestScope.imgsetno} --%>
<%-- 
   <div>
       ${requestScope.제품번호VO.jepumname}
   </div>
--%>

<jsp:include page="header_shop.jsp" />
<%-- 전체 --%>

<script>
  $(document).ready(function () {
    $('.custom-transparent-button').click(function () {
      // 모든 버튼에서 'active' 클래스 제거
      $('.custom-transparent-button').removeClass('active');
      // 클릭된 버튼에만 'active' 클래스 추가
      $(this).addClass('active');
    });
  });
</script>



<c:if test="${not empty requestScope.gameOptionVO}">

<div class="row mx-auto" style="width:95%; margin: 6% 0 0 0">


    
	<%-- 8분할 --%>	
	<div class="col-8">
	<%-- Bootstrap 그리드 시스템 클래스는 기본적으로 패딩과 간격을 포함하는데, 이로 인해 캐러셀이 왼쪽 끝에 붙이지 않을 수 있습니다. 또한, margin: 0을 명시적으로 지정하면서 간격을 줄여버릴 수도 있습니다. 
	
	--%>
		
		
		<%-- 캐러셀 시작 --%>
		
		<div id="carousel_slide" class="carousel slide carousel-fade" data-ride="carousel" style="width:95%; margin:0 0 0 0">
	 		
	 		<%-- Bootstrap 캐러셀(Carousel)의 인디케이터(Indicator) --%>
	 		<%-- 현재 표시되는 슬라이드와 그 개수를 나타내며, 사용자가 특정 슬라이드로 직접 이동할 수 있도록 돕는 역할을 합니다. --%>
	 		<ol class="carousel-indicators">
	            <li data-target="#carousel_slide" data-slide-to="0" class="active"></li>
	            <li data-target="#carousel_slide" data-slide-to="1"></li>
				<li data-target="#carousel_slide" data-slide-to="2"></li>
				<li data-target="#carousel_slide" data-slide-to="3"></li>
			</ol>
			<%-- Bootstrap 캐러셀(Carousel)의 인디케이터(Indicator) --%>
			<%-- 캐러셀 이너 --%>
			<div class="carousel-inner">
	
				<div class="carousel-item active">
					<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename}" class="img-fluid">
				</div>
				
				<div class="carousel-item">
		    		<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_2}" class="img-fluid">
				</div>
							
				<div class="carousel-item">
					<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_3}" class="img-fluid">
				</div>
				
				<div class="carousel-item">
		    		<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_4}" class="img-fluid">
				</div>
				


			</div>   
			<%-- 캐러셀 이너 끝 --%>
			
			<%--캐러셀(Carousel)의 화살표 컨트롤--%>	
			<a class="carousel-control-prev" href="#carousel_slide" role="button" data-slide="prev">
	            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	            <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carousel_slide" role="button" data-slide="next">
	            <span class="carousel-control-next-icon" ariahidden="true"></span>
	            <span class="sr-only">Next</span>
            </a>
			<%--캐러셀(Carousel)의 화살표 컨트롤--%>
		
		
		</div>
		<%-- 캐러셀 끝 --%>
	
	<div class="row mt-3" style="width: 950px;" >	
		<div class="col-3 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename}" class="img-fluid">
		</div>
		
		<div class="col-3 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_2}" class="img-fluid">
		</div>
		
		<div class="col-3 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_3}" class="img-fluid">
		</div>
		
		<div class="col-3 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_4}" class="img-fluid">
		</div>
	
	</div>
	<div class="text-white">
	<h1>지옥에 오신 것을 환영합니다</h1>
<h5>디아블로 IV는 궁극의 액션 RPG 어드벤처입니다. 지옥의 세력과 맞서 싸우십시오. 수많은 능력을 익히며 전설적인 전리품을 모으고, 사악한 적이 넘쳐나는 악몽의 던전을 정벌하십시오. 혼자서 또는 친구들과 함께 캠페인을 탐험하며 잊지 못할 개성을 자랑하는 캐릭터를 만나고, 아름답지만 암울한 세상을 누비며 마음을 사로잡는 이야기에 빠져들어 보십시오. 재미는 여기서 끝이 아닙니다. 방대한 종반 콘텐츠가 여러분을 기다립니다. 공유 오픈 월드를 자유롭게 탐험하며 플레이어를 만나십시오. 힘을 합쳐 야외 우두머리를 처치하거나, PVP 구역의 전투에 뛰어들어 서로의 기량을 시험해 보십시오. 모든 플랫폼에서 크로스플레이와 진행 데이터 동기화를 지원합니다. 언제 어디서든 원하는 방식으로 플레이하십시오.

피의 시즌에 참여해 흡혈귀의 위협에 맞서 싸우십시오. 이것은 디아블로® IV의 시작일 뿐입니다. 새로운 이벤트와 스토리, 시즌, 보상 등의 풍부한 콘텐츠가 지속해서 추가됩니다.</h5>
</div>
	
	
	
	
	</div> 
	<%-- 8분할 --%>		
		
    <div class="col-4">
    
    <div class="container text-white" style="">
     <div class="row">	
     <div class="col-3">
     	<img class="game_logo" src="<%= ctxPath%>/img/tbl_game_option/logo-d4.png"></img>
     </div>
     <div>
	     <h2 class="mt-3">디아블로® IV</h2>
	     <p>액션 RPG</p> 
     </div>
     </div>
     
     <div class="table-responsive">           
        <table class="table table-borderless">
        
          <thead>
            <tr class="price">
              <th class="h3 text-white">상품 선택</th>
              <th class="h5 text-right" style="color: #00FF00;">할인</th>
            </tr>
          </thead>
          
          <tbody>
           	
  <tr class="price custom-radio">
    <td>
      <label class="btn custom-transparent-button">
        <input type="radio" id="${requestScope.gameOptionVO.imgslidefilename}" name="coinmoney" value="${requestScope.gameOptionVO.gameopt_price}"/>
        <span class="opttitle">${requestScope.gameOptionVO.gameopt_name}</span>
        <br>
        <span class="panmaeprice">${requestScope.gameOptionVO.gameopt_price}</span><span class="saleprice">(1-${requestScope.gameOptionVO.gameopt_discount})*${requestScope.gameOptionVO.gameopt_price}</span>
      </label>
    </td>
    <td class="per">
      <span>${requestScope.gameOptionVO.gameopt_discount}*10</span>
    </td>
  </tr>
  
  <tr class="price custom-radio">
    <td>
      <label class="btn custom-transparent-button">
        <input type="radio" id="${requestScope.gameOptionVO.imgslidefilename_2}" name="coinmoney" value="${requestScope.gameOptionVO.gameopt_price_2}"/>
        
        <span class="opttitle">스탠다드 에디션</span>
        <br>
        <span class="panmaeprice">${requestScope.gameOptionVO.gameopt_price_2}</span>
        <span class="saleprice">${requestScope.gameOptionVO.gameopt_price_3}</span>
      </label>
    </td>
    <td class="per">
      <span>${requestScope.gameOptionVO.gameopt_discount_2}*10</span>
    </td>
  </tr>
  
  <tr class="price custom-radio">
    <td>
      <label class="btn custom-transparent-button">
        <input type="radio"  id="${requestScope.gameOptionVO.imgslidefilename_2}" name="coinmoney" value="${requestScope.gameOptionVO.gameopt_price_3}"/>
        <span class="opttitle">${requestScope.gameOptionVO.gameopt_name}</span>
       
		<br>
        
        <span class="panmaeprice">${requestScope.gameOptionVO.gameopt_price_3}</span>
        <span class="saleprice">${requestScope.gameOptionVO.gameopt_price_3}</span>
      
      </label>
    </td>
    <td class="per">
      <span>${requestScope.gameOptionVO.gameopt_price_3}</span>
    </td>
  </tr>		
       	
            <tr>
               <td id="error" colspan="3"><br>결제종류에 따른 금액을 선택하세요!!</td>
            </tr>
             
          </tbody>
        </table>
     </div>
     
     <div class="purchase-btn text-center">
	 	<ul class="list-unstyled">
	 	
	    	<li id="purchase" onclick="goCoinPayment('<%=ctxPath %>','${sessionScope.loginuser.user_id}')" class="btn btn-primary">
	          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기시발
	    	</li>
	      	
	      	<li class="btn btn-danger mt-2">
	          &nbsp;<i class="fa-brands fa-google"></i> 장바구니
	      	</li>
	      	
	      	<li class="btn btn-success mt-2">
	          &nbsp;<i class="fa-brands fa-square-x-twitter"></i> 코인구매
	        </li>
	    
	    </ul>
	 </div>
	<ul class="text-white">
     	<li>플레이하려면 인터넷 연결, Battle.net® 계정, Battle.net® 데스크톱 앱이 필요합니다.
     	</li>
		<li>* 탈것은 사용 전 게임 내에서 미리 해제해야 합니다.</li>
		<li>** 디아블로® III 및 월드 오브 워크래프트는 별도 판매되거나 별도 다운로드가 필요합니다.</li>
		<li>***배틀 패스 잠금 해제는 디아블로® IV 시즌 배틀 패스에만 적용됩니다.</li>
		<li><a>시스템 요구사양</a></li>     
     	<li><a>제품 설명</a></li>   
     </ul>
   </div>
  
  </div>

</div>

<hr class="mx-auto" style="background-color: white; width:95%;">


<div class="row mx-auto mt-3" style="width:95%;">
	
	<div class="col-4">
	        <div class="h1 text-white">
	           상품비교
	        </div>
	</div>
	
	<div class="col-8">
	   
	   <div class="row mt-3" style="width: 950px;" >	
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename}" class="img-fluid">
			<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">${requestScope.gameOptionVO.gameopt_price_3}</span></li>
				<li><span class="saleprice">${requestScope.gameOptionVO.gameopt_price_3}</span></li>
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
		
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_2}" class="img-fluid">
			<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">35,000</span></li>
				<li><span class="saleprice">50,000</span></li>
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
		
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_3}" class="img-fluid">
						<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">35,000</span></li>
				<li><span class="saleprice">50,000</span></li>
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
			
	</div>
	   	
	</div>
</div>

<hr style="background-color: white;">

<div class="row mx-auto mt-3" style="width:95%;">
	
	<div class="col-4">
	        <div class="h1 text-white">
	           주요특징
	        </div>
	</div>
	
	<div class="col-8">
	   
	   <div class="row mt-3" style="width: 950px;" >	
		
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename}" class="img-fluid">
			<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">35,000</span></li>
				<li><span class="saleprice">50,000</span></li>
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
		
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_2}" class="img-fluid">
			<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">35,000</span></li>
				<li><span class="saleprice">50,000</span></li>
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
		
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_3}" class="img-fluid">
						<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">35,000</span></li>
				<li><span class="saleprice">50,000</span></li>
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
		
		</div>
		<div class="row">
		<div class="col-4 mr-auto imgsm">
			<img src="<%= ctxPath%>/img/tbl_game_option/${requestScope.gameOptionVO.imgslidefilename_2}" class="img-fluid">
			<ul class="text-center">
       			<li><span class="opttitle">베이직 에디션</span></li>
				<li> <span class="panmaeprice">35,000</span></li>
				<li><span class="saleprice">50,000</span></li>
				
				<li id="purchase" class="btn btn-primary">
		          &nbsp;<i class="fa-brands fa-square-facebook"></i> 구매하기
		    	</li>
		    	
		    	<li><span class="opttitle">일반판
일반판에는 디아블로® III 내에서 지급되는 이나리우스 날개 및 이나리우스 멀록 애완동물**, 월드 오브 워크래프트® 내에서 지급되는 격노의 융합체 탈것**이 포함되어 있습니다.
</span>
		    	</li>
			</ul>
		</div>
		
		</div>
		
			
	</div>
	   	
	</div>



<hr style="background-color: white;">

<div class="row mx-auto mt-3" style="width:95%;">
	
	<div class="col-4">
	        <div class="h1 text-white">
	           시스템 요구사항
	        </div>
	</div>
	
	<div class="col-8">
	   	<div>
	   			<span class="text-white h3"><i class="fa-brands fa-windows"></i>&nbsp;Windows&nbsp;&&nbsp;</span> 
	   			<span class="text-white h3"><i class="fa-brands fa-apple"></i>&nbsp;MAC</span> 
	   	</div>
	   	
	   	<hr style="background-color: white;">
	   	
		<div class="row">
	   		<div class="col-6">
	   			
	   			<span class="text-white h3"><i class="fa-brands fa-windows"></i>&nbsp;Windows</span> 
	   		
	   		<div class="text-white">
	   			
	   		<div class="row mt-4">
   				<div class="col-6">
		   			<h5>OS</h5>
		   			<span>윈도우® 7 64-bit</span>
	   			</div>
	   				
	   		<div class="col-6">
 				<h5>CPU</h5> 
 				<span>인텔® Core™ i5-760 또는 AMD FX™-8100 또는 그 이상</span>
 				<br>
 
	   		</div>
		   		
		   </div>
   		
   		   <div class="row mt-4">
  				<div class="col-6">
	   			<h5>비디오카드</h5>
	   			<span>윈도우® 7 64-bit</span>
   		   </div>
  				
  		   <div class="col-6">
  		   	   <h5>RAM</h5> 
  			   <span>4 GB RAM (Intel HD Graphics 530의 경우 8GB)</span>
  		   </div>
   		
   		  </div>
		   	
				 		
   		 <div class="row mt-4">
			<div class="col-6">
	 			<h5>저장공간</h5>
	 			<span>70GB 이상의 하드디스크 여유 공간(7200RPM)</span>
			</div>
			
			<div class="col-6">
				<h5>인터넷</h5> 
				<span>광대역 인터넷 연결</span>
			</div>
   		
   		 </div>
		   		
   		 		
   		<div class="row mt-2">
  				<div class="col-6">
	   			<h5>입력장치</h5>
	   			<span>키보드 및 마우스. 그 외의 입력장치는 지원하지 않습니다.</span>
   			</div>
  				
				<div class="col-6">
					<h5>해상도</h5> 
					<span>최소 1024 x 768 디스플레이 해상도</span>
				</div>
   		
   		</div>		   		
	
	   			
	   	</div>
	   		
   		</div>
   		
   		<div class="col-6">
   			<span class="text-white h3"><i class="fa-brands fa-apple"></i>&nbsp;MAC</span>  
			
			<div class="text-white">
   			
   			<div class="row mt-4">
   				<div class="col-6">
		   			<h5>OS</h5>
		   			<span>윈도우® 7 64-bit</span>
	   			</div>
   				
   				<div class="col-6">
   					<h5>CPU</h5> 
   						<span>인텔® Core™ i5-760 또는 AMD FX™-8100 또는 그 이상</span>
   					<br>
   
   				</div>
	   		
	   		</div>
	   		
	   		<div class="row mt-4">
   				<div class="col-6">
		   			<h5>비디오카드</h5>
		   			<span>윈도우® 7 64-bit</span>
	   			</div>
   				
   				<div class="col-6">
   					<h5>RAM</h5> 
   					<span>4 GB RAM (Intel HD Graphics 530의 경우 8GB)</span>
   				</div>
	   		
	   		</div>
	   	
			 		
	   		<div class="row mt-4">
   				<div class="col-6">
		   			<h5>저장공간</h5>
		   			<span>70GB 이상의 하드디스크 여유 공간(7200RPM)</span>
	   			</div>
   				
   				<div class="col-6">
   					<h5>인터넷</h5> 
   					<span>광대역 인터넷 연결</span>
   				</div>
	   		
	   		</div>
	   		
	   		 		
	   		<div class="row mt-2">
   				<div class="col-6">
		   			<h5>입력장치</h5>
		   			<span>키보드 및 마우스. 그 외의 입력장치는 지원하지 않습니다.</span>
	   			</div>
   				
   				<div class="col-6">
   					<h5>해상도</h5> 
   					<span>최소 1024 x 768 디스플레이 해상도</span>
   				</div>
	   		
	   		</div>		   		

   			
   		</div>
				
		</div>
	</div>
	</div>
</div>
</c:if>


<hr style="background-color: white;">

<section>
   <div id="p_tag" class="text-center mt-5 mb-5" style="width: 50%; margin: 0 auto; color: #999999;">
      <h2 class="mb-4" style="font-weight: bold; color:white;">이용 연령</h2>
      <div class="row ">
      <img class="col-3" src="<%= ctxPath %>/img/로고모음/esports-hsm-5b1ed3fe5cf5d4f8.png" class="mr-1" />
      <img class="col-3" src="<%= ctxPath %>/img/로고모음/esports-hsm-5b1ed3fe5cf5d4f8.png" class="mr-1" />
      <img class="col-3 " src="<%= ctxPath %>/img/로고모음/esports-hsm-5b1ed3fe5cf5d4f8.png" class="mr-1" />
      <img class="col-3 " src="<%= ctxPath %>/img/로고모음/esports-hsm-5b1ed3fe5cf5d4f8.png" class="mr-1" />
      </div>
      <p>정액제 상품</p>
      <p>구매 후 7일 이내에 청약철회가 가능합니다. 다만, 상품을 구매한 지 7일이 지났거나, 서비스의 이용 개시 또는 상품의 일부를 이용한 경우에는 환불신청이 가능합니다.</p>
      <p>(이용금액 및 환불수수료 공제)</p>
      <p>디지털 딜럭스 상품, 사전구매 상품 및 게임 내 콘텐츠/서비스</p>
      <p>구매 후 7일 이내에 청약철회가 가능합니다. 다만, 서비스의 이용을 개시하였거나 상품의 일부를 이용한 경우 청약철회가 제한됩니다.</p>
      <p>제품 구매에 부수하여 보너스로 제공받거나 이벤트나 게임이용 등으로 획득한 상품의 경우에는 환불되지 않습니다</p>
      <hr style="background-color: gray;">
      <p>상품 이용기간: 서비스 종료 시까지</p>
      <p>본 상품은 디지털 다운로드 방식으로 제공되는 상품으로서 구매 즉시 계정에 자동 등록됩니다.</p>
      <p>예약 구매 상품의 경우에는 출시전까지 환불 가능합니다.</p>
      <p>시험사용상품이 제공되거나 구매 후 즉시 서비스의 이용이 개시되는 경우 등 구매 상품의 특성에 따라 청약철회가 제한되는 경우가 있습니다. 게임 플레이를 통해</p>
      <p>획득한 아이템 또는 이를 사용하여 획득한 상품은 환불이 불가능합니다. 환불은 청약 철회일로부터 3일 영업일 이내에 이루어 집니다. 자세한 사항은 <a href="">환불정책</a> 을</p>
      <p>참고해 주세요.</p>
      <p>법정대리인의 동의가 없는 미성년자의 결제는 취소될 수 있습니다.</p>
      <p>선물한 상품은 구매 후 7일 이내에 청약철회가 가능합니다. 다만, 구매 후 수신인이 수령한 경우에는 청약철회가 제한됩니다.</p>
      <p>본 거래는 <a href="">Blizzard 최종 사용자 라이선스 계약</a> 및 판매 시 제공된 조건에 따릅니다. 지불이나 환불과 관련한 문제가 발생한 경우, 해당 계정은 관련 문제가 해결될 때까지 잠시 정지될 수 있습니다.</p>
      <p>청약철회, 환불, 회원탈퇴, 소비자 불만과 관련한 내용은 <a href="">고객지원</a>에 연락해야 합니다.</p>
      <p>본 상품은 구매안전서비스를 제공하지 않습니다. 소비자피해보상은 판매 시 제공된 조건, 약관 및 소비자 분쟁 해결 기준 등 법령에 따릅니다.</p>
      <hr style="background-color: gray;">
      <p>판매자 정보: 김경민 엔터테인먼트 주식 회사</p>
      <p>대표이사: 서영학 | 개인정보 보호책임자: 박승우</p>
      <p>주소: 서울특별시 마포구 월드컵북로 21 풍성빌딩 2,3,4층 쌍용강북교육센터</p>
      <p>연락처: (전화) 02-336-8546~8 (팩스) (02)334-5405 (이메일) zxnm46@daum.net</p>
      <p>사업자 등록 번호: 214-85-29296</p>
      
      <span style="font-weight: bold;" class="mr-2" >배급사</span><img src="<%= ctxPath %>/img/logo-ow2-40a23e181ae5418a.png" class="mr-4" />
      <span style="font-weight: bold;" class="mr-2" >개발사</span><img src="<%= ctxPath %>/img/logo-ow2-40a23e181ae5418a.png" />
      
   </div>
</section>

<%-- ============ 이용 연령 안내 끝 ============ --%>


<jsp:include page="../footer_suc.jsp" />
