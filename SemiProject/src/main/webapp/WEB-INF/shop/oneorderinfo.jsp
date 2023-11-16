<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<%
    String ctxPath = request.getContextPath(); 
%>

<%-- JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/shop/likeshop.css">

<style>

* {
  box-sizing: border-box;
}

.cart {
    display: flex; /* 내부 요소를 가로로 나란히 배치 */
	margin-top: 3% 
	width: 80%;
    margin: auto;
    padding: 3%;
}

#content {
    flex: 1; /* 오른쪽 요소가 확장되어 가득 채우도록 함 */
    padding: 5%; /* 내부 여백 설정 */
    box-sizing: border-box; /* padding을 width에 포함시킴 */
}

.cart_flex {
    flex: 1; /* 왼쪽 요소가 확장되어 가득 채우도록 함 */
    padding: 5%; /* 내부 여백 설정 */
    box-sizing: border-box; /* padding을 width에 포함시킴 */
    
}

<%-- 테이블 css --%>

p,
span {
  margin: 0;
}

a {
  color: black;
}

img {
  display: block;
  width: 100%;
  height: 80px;
  margin: auto;
}


table {
  border-top: solid 1.5px black;
  border-collapse: collapse;
  width: 100%;
  font-size: 13px;
}



thead {
  text-align: center;
  font-weight: bold;
}

tbody {
  font-size: 11px;
}


td {
    padding: 13px 0px;
    border-bottom: 1px solid lightgrey;
}

.cart__list__smartstore {
  font-size: 12px;
  color: gray;
}

.cart__list__option {
  vertical-align: top;
  padding: 20px;
}

.cart__list__option p {
  margin-bottom: 25px;
  position: relative;
}

.cart__list__option p::after {
  content: "";
  width: 90%;
  height: 1px;
  background-color: lightgrey;
  left: 0px;
  top: 25px;
  position: absolute;
}

.cart__list__optionbtn {
  background-color: white;
  font-size: 10px;
  border: lightgrey solid 1px;
  padding: 7px;
}

.cart__list__detail :nth-child(4),
.cart__list__detail :nth-child(5),
.cart__list__detail :nth-child(6) {
  border-left: 2px solid whitesmoke;
}

.cart__list__detail :nth-child(5),
.cart__list__detail :nth-child(6) {
  text-align: center;
}

.cart__list__detail :nth-child(5) button {
  background-color: limegreen;
  color: white;
  border: none;
  border-radius: 5px;
  padding: 4px 8px;
  font-size: 12px;
  margin-top: 5px;
}

.price {
  font-weight: bold;
}

.cart__mainbtns {
  width: 420px;
  height: 200px;
  padding-top: 40px;
  display: block;
  margin: auto;
}

.cart__bigorderbtn {
  width: 200px;
  height: 50px;
  font-size: 16px;
  margin: auto;
  border-radius: 5px;
}

.cart__bigorderbtn.left {
  background-color: white;
  border: 1px lightgray solid;
}

.cart__bigorderbtn.right {
  background-color: limegreen;
  color: white;
  border: none;
}


/* 입력폼 */

input:focus {
    outline: none;
}

h3 {
    margin: auto;
    font-size: 14px;
    font-weight: 700;
}


.box {
    display: block;
    width: 100%;
    height: 51px;
    border: solid 1px #dadada;
    padding: 10px 14px 10px 14px;
    box-sizing: border-box;
    background: #fff;
    position: relative;
}

.int {
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;
}



.box.int_id {
    padding-right: 110px;
}

.box.int_pass {
    padding-right: 40px;
}

.box.int_pass_check {
    padding-right: 40px;
}



#bir_wrap {
    display: table;
    width: 100%;
}

#bir_yy {
    display: table-cell;
    width: 147px;
    
}

#bir_mm {
    display: table-cell;
    width: 147px;
    vertical-align: middle;
}

#bir_dd {
    display: table-cell;
    width: 147px;
}

#bir_mm, #bir_dd {
    padding-left: 10px;
}

select {
    width: 100%;
    height: 29px;
    font-size: 15px;
    background: #fff url(https://static.nid.naver.com/images/join/pc/sel_arr_2x.gif) 100% 50% no-repeat;
    background-size: 20px 8px;
    -webkit-appearance: none;
    display: inline-block;
    text-align: start;
    border: none;
    cursor: default;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}

/* 에러메세지 */

.error_next_box {
    margin-top: 9px;
    font-size: 12px;
    color: red;    
    display: none;
}

#alertTxt {
    position: absolute;
    top: 19px;
    right: 38px;
    font-size: 12px;
    color: red;
    display: none;
}

/* 버튼 */

.btn_area {
    margin: 30px 0 91px;
}

#btnJoin {
    width: 100%;
    padding: 21px 0 17px;
    border: 0;
    cursor: pointer;
    color: #fff;
    background-color: #08a600;
    font-size: 20px;
    font-weight: 400;
    font-family: Dotum,'돋움',Helvetica,sans-serif;
}

#zipcodefind {
	width: auto;
	background-image:linear-gradient(180deg, #1888EF 0%, #009FE9 100%);
	border: 2px solid rgba(255, 255, 255, 0.15);
    border-radius: 100px;
    text-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    box-sizing: border-box;
    white-space: normal;
    font-size: 8pt;
    font-weight: bold;
}

#purchase {
	width: auto;
	background-image:linear-gradient(180deg, #1888EF 0%, #009FE9 100%);
	border: 2px solid rgba(255, 255, 255, 0.15);
    border-radius: 100px;
    text-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    box-sizing: border-box;
    white-space: normal;
    width: 22%;
	height: 70px;
    font-size: 15pt;
    font-weight: bold;
}

.font {
	font-weight: bold;
	color: white;
}

p.error {
	color: red;
}

div.loader {
  border: 10px solid transparent;
  border-top: 10px solid #3498db;
  border-radius: 50%;
  width: 80px;
  height: 80px;
  animation: spin 2s linear infinite;
  margin: 0 auto;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 999;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<script type="text/javascript" src="<%= ctxPath%>/js/order/order.js"></script>

>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
<script type="text/javascript" src="<%= ctxPath%>/js/buy/onebuygame.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	
	$("div.loader").hide(); // CSS 로딩화면 감추기
	
    // "user_info" 체크박스 요소를 선택합니다.
    const checkbox = $("#origin_add");

    // 체크박스의 상태 변화(클릭) 이벤트를 처리합니다.
    checkbox.on("change", function() {
        // 체크박스가 체크되었는지 여부를 확인합니다.
        const isChecked = checkbox.is(":checked");

        
        if (isChecked) {
            
        	$("input[name='order_name']").val("${sessionScope.loginuser.user_name}");
        	$("input[name='order_phone']").val("${sessionScope.loginuser.user_phone}");
            $("input[name='order_zipcode']").val("${sessionScope.loginuser.user_zipcode}");
            $("input[name='order_address']").val("${sessionScope.loginuser.user_address}");
            $("input[name='order_detailaddress']").val("${sessionScope.loginuser.user_detail_address}");
            $("input[name='order_extraaddress']").val("${sessionScope.loginuser.user_extraaddress}");
          
        } else {
            
        	$("input[name='order_name']").val("");
        	$("input[name='order_phone']").val("");
             $("input[name='order_zipcode']").val("");
             $("input[name='order_address']").val("");
             $("input[name='order_detailaddress']").val("");
             $("input[name='order_extraaddress']").val("");
        }
    });
    
    
    
});

function goOrder() {
	

    
   
    
	const oqty = $("input.oqty").val();
	const qty = ${requestScope.gvo.g_qty} - oqty; // 잔고량
	const totalPrice = ${requestScope.sumMap.SUMTOTALPRICE};
	const totalPoint = ${requestScope.sumMap.SUMTOTALPOINT};
	
	
			   
	console.log("제품번호 : " , ${requestScope.gvo.optvo.optinfono} ); 
	console.log("주문량 : " , oqty );
	console.log("잔고량 : " ,  qty  );
	console.log("주문한 제품의 개수에 따른 가격합계 : " , totalPrice );
	console.log("주문한 제품의 개수에 따른 포인트합계 : " , totalPoint );
    console.log("======================")
       		               
	<%-- const bool = confirm("총주문액 : "+totalPrice+"원 결제하시겠습니까?"); --%>
	var bool = true;
	
	if(bool) {	
		$("div.loader").show();
		
		$.ajax({
			url:"<%= request.getContextPath()%>/buy/oneOrderAdd.bz",
			type:"POST",
			data:{"totalPrice":totalPrice,
				  "totalPoint":totalPoint,
				  "optinfono":${requestScope.gvo.optvo.optinfono},
				  "oqty":oqty,
				  "order_name":$("input#order_name").val(),
				  "order_phone":$("input#order_phone").val(),
				  "order_zipcode":$("input#order_zipcode").val(),
				  "order_address":$("input#order_address").val(),
				  "order_detailaddress":$("input#order_detailaddress").val(),
				  "order_extraaddress":$("input#order_extraaddress").val(),
				  "order_content":$("textarea#order_content").val()
				  
			},
			dataType:"JSON",     
			success:function(json){
				
				if(json.isSuccess == 1) {
					location.href="<%= request.getContextPath()%>/buy/orderList.bz";
				
				}
				else {
					location.href="<%= request.getContextPath()%>/buy/orderError.bz";
				
				} 
			
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		
		});

	} 
	


   
}// end of function goOrder()----------------------

</script>

<jsp:include page="../header_suc.jsp" />

    
  
<section class="cart" style="background-color: black;">    
  
   
   
       
	   <div class="cart_flex">       
	   
	   
	   <div style="position: -webkit-sticky; position: sticky; top: 100px;">
	   
	   <table class="cart__list">   
	    
	    <thead>
	     	<tr>
	            <td colspan="2">상품정보</td>
	            <td>옵션</td>
	            <td>상품금액</td>
	            <td>주문총액/총포인트</td>
	       </tr>
	    </thead>
	 
	 	<tbody>
		
		
		<tr class="cart__list__detail">
			<td>
				<img src="<%= ctxPath%>/img/tbl_game_product_image/${requestScope.gvo.optvo.imgfile}" style="width: 90%" alt="" >
			</td> 
	       	<td style="border-left: none;">
	       		<a href="#">${requestScope.gvo.g_name}
	       	</a>
			<span class="cart__list__smartstore cart_g_code" style="border-left: none;">${requestScope.gvo.g_content}</span>
			<p style="color: lightgrey; border-left: none;">${requestScope.gvo.optvo.opt_name}</p>
			<span class="price" style="border-left: none;">${requestScope.gvo.optvo.opt_sale_price}</span>
			<span style="text-decoration: line-through; border-left: none; color: lightgray;">${requestScope.gvo.optvo.opt_price}</span>
			</td>
			<td class="cart__list__option">
	    	<p style="border-top: none; text-align: center; vertical-align: middle;">${requestScope.oqty}개</p>
			
			<input type="hidden" class="oqty" value="${requestScope.oqty}" />
			<%-- 잔고량 --%>
			<input type="hidden" class="g_qty" value="" /> 
			</td>
			<td style="color: whitesmoke; text-align: center;">
			<fmt:formatNumber value="${requestScope.gvo.optvo.opt_sale_price}" pattern="###,###" />원
			<br><br>
			<fmt:formatNumber value="${requestScope.gvo.g_coin}" pattern="###,###" />POINT
			</td>
			<td> <%-- 주문총액/총포인트 --%> 
			<fmt:formatNumber value="${requestScope.sumMap.SUMTOTALPRICE}" pattern="###,###" /> 원<br><br>
			<fmt:formatNumber value="${requestScope.sumMap.SUMTOTALPOINT}" pattern="###,###" /> POINT
			<input type="hidden" class="totalPrice" value="" />
			<input type="hidden" class="totalPoint" value="" />
			<input type="hidden" class="totalSalePrice" value="${requestScope.sumMap.SUMTOTALPRICE}" />
			<input type="hidden" class="user_id" value="${sessionScope.loginuser.user_id}" />
	 	    <input type="hidden" class="user_coin" value="${sessionScope.loginuser.user_coin}" />
		    <input type="hidden" class="user_name" value="${sessionScope.loginuser.user_name}" />
			</td>
			
		</tr>
		</tbody>
				
	  
	
	</table> 
	
	
	<div style="margin-top: 10%;">
				<div style="position: -webkit-sticky; position: sticky; top: 100px;">
				
					<table class="cart__list">
						<thead style="font-size: 23pt">
							<tr>
								<td colspan="4" class="text-left">주문자 정보/ 배송지</td>
							</tr>
						</thead>
						
						<tbody style="font-size: 13pt; color: whitesmoke;">
							<tr>
								<td width="10%;">주문자명 :</td>
								<td width="40%;">${sessionScope.loginuser.user_name}</td>
								<td width="15%;">기본정보</td>
								<td width="35%;"><input type="checkbox" id="origin_add" /></td>
							</tr>
							<tr>
								<td width="10%;">E-Mail :</td>
								<td>${sessionScope.loginuser.user_email}</td>
								<td>받으실분</td>
								<td>
									<input type="text" name="order_name" id="order_name" class="requiredInfo" />
									<p class="error">실명을 입력해 주세요.</p>
								</td>
							</tr>
							<tr>
								<td>휴대폰번호 :</td>
								<td>${sessionScope.loginuser.user_phone}</td>
								<td>수취인 연락처 </td>
								<td>
									<input type="text" name="order_phone" id="order_phone" class="requiredInfo" />
									<p class="error">하이픈(-)없이 11글자로 입력하세요.</p>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
								<td>우편번호</td>
								<td><input type="text" name="order_zipcode" id="order_zipcode" class="zipcodeSearch" size="15" maxlength="11" autocomplete="off"> 
									<span id="zipcodefind" class="btn btn-primary zipcodeSearch requiredInfo">우편번호찾기</span>
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
								<td>배송지</td>
								<td>
									<input type="text" name="order_address" id="order_address" class="zipcodeSearch requiredInfo" size="15" maxlength="20" autocomplete="off"> 
									<input type="text" name="order_detailaddress" id="order_detailaddress" class="requiredInfo" size="15" maxlength="20" autocomplete="off" placeholder="상세주소"> 
									<input type="text" name="order_extraaddress" id="order_extraaddress" size="15" maxlength="20" autocomplete="off">
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
								<td>배달요청사항</td>
								<td><textarea name="order_content" class="requiredInfo" id="order_content"></textarea></td>
							</tr>
						</tbody>
					</table>
				
			</div>
		</div>
		
	<div class="text-center mt-5">
		<a id="purchase" class="btn btn-primary btnBlue" onclick="goCard(<%= ctxPath%>/)" >구매하기</a>
   	</div>
   	
	</div>
	</div> 
	<input type="hidden" class="g_name" value="${requestScope.gvo.g_name}" />



	<div style="display: flex; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); border: solid 0px blue;">
	    <div class="loader" style="margin: auto;"></div>
	</div>
	
</section>             
	
