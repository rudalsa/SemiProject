<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
    String ctxPath = request.getContextPath(); // MyMVC
%>
<jsp:include page="../header_suc.jsp"></jsp:include>

<style type="text/css">
#maininfo > div:nth-child(3) > table > tbody > tr > td > div:nth-child(1) > table > tbody > tr{
	cursor: pointer;
}
#sideinfo > div > div > ul > li:hover{
	cursor: pointer;
	background-color:gray;
}

</style>

<script type="text/javascript">
function goResignation(){
	const frm = document.memberResignation_frm;
    frm.action = "<%= ctxPath%>/member/memberResignation.bz";
    frm.method = "POST";
    frm.submit();   	
}

function redirectToGamePage(url) {
    window.location.href = url;
}


$(document).ready(function(){

document.getElementById('accountMainLink').addEventListener('click', function() {
    document.getElementById('maininfo').style.display = 'block';
    document.getElementById('accountDetails').style.display = 'none';
});

document.getElementById('accountDetailsLink').addEventListener('click', function() {
    document.getElementById('maininfo').style.display = 'none';
    document.getElementById('accountDetails').style.display = 'block';
});

});

</script>

</head>

<body style="background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
<!-- background-repeat: no-repeat;를 적용하면 배경 이미지가 한 번만 표시됩니다: -->
<div class="mt-5"></div>
<!-- <hr style="background-color: gold; height: 1.2px;"> -->
        <hr style="background-color: gray; height: 1.2px; position: relative; top:20px; margin: 0 1.7%;"> 

    <div class="container-fluid" id="container" style="position: relative; top:50px; padding: 0.1% 2.5%;">
      
     <div class="row">
     
		<div class="col-md-2 offset-md-1" id="sideinfo" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg') ;">
          
               <div class="col-lg-12" >
            	<div class="mt-5">
            		<ul class="nav flex-column mt-2 ">
					  <li class="nav-item ">
					    <a class="nav-link text-white active" id="accountMainLink"> <span class="rounded-sm">계정 정보</span></a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link text-white" id="accountDetailsLink" >계정 상세 정보</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link text-white" href="<%= ctxPath%>/mainShop.bz">게임 & 요금제</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link text-white" href="<%= ctxPath%>/buy/cartList.bz">결제 및 주문 내역</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link text-white" href="<%= ctxPath%>/login/logout.bz">로그아웃</a>
					  </li>
					</ul>
				</div>
            </div>
        </div>
        
          <div class="col-md-8  mt-1">
          		<c:set var="phone" value="${loginuser.user_phone}" />
               <div class="col-lg-12 mt-6" id="maininfo">
            	<div>
            		<h2 style="color:white;">계정정보</h2>
				</div>
				<div class="row">
					<table class="col-md-6 table table-dark" style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th colspan="2">내 정보</th>
					      <td class="text-right"><a type="button" class="btn btn-sm btn-primary text-right" href="<%= ctxPath%>/member/memberEditEnd.bz">변경하기</a></td>
					  
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
					      <td><fmt:formatNumber value="${loginuser.user_coin}" pattern="###,###" /> POINT </td>
					    </tr>
					    <tr>
					      <td colspan="2">연락처</td>
		     			 <td>${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 7)}-${fn:substring(phone, 7, 11)}</td>
					    </tr>
					  </tbody>
					</table>
					<table class="col-md-5 ml-1 table table-dark "style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th colspan="2">누적 결제금액</th>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      	<td colspan="3" class="text-center"><fmt:formatNumber value="${loginuser.user_payment}" pattern="###,###" /> 원 </td>		
					    </tr>
					    
					  </tbody>
					</table>
				</div>
				
				
				<div class="row">
					<table class="col-md-11 table table-dark"style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th colspan="2">구매 정보</th>
					      <td class="text-right"><a class="btn btn-success btn-sm"href="<%= ctxPath %>/buy/cartList.bz">장바구니 바로가기</a></td>
					    </tr>
					  </thead>
					  <tbody>
					  	<tr>
					<td colspan="3">

   <div>
 	    <table class="cart__list  w-100">
	
	        <thead>
	            <tr>
	               <td colspan="2" class="center">상품정보</td>
	               <td>옵션</td>
	               <td>상품금액</td>
	        	</tr>
	        </thead>
	        
	        <tbody>
	            
	    <c:if test="${empty requestScope.cartList}">
	 		<tr>
	 			<td colspan="7" align="center">
	   			<span style="color: red; font-weight: bold;">
	      		장바구니에 담긴 상품이 없습니다.
	   			</span>
	 			</td>   
	 		</tr>
	 	</c:if>   
	 	
	 	<c:if test="${not empty requestScope.cartList}">
	 		<c:forEach var="cartvo" items="${requestScope.cartList}" varStatus="status"> 
			
			  <tr class="cart__list__detail" onclick="redirectToGamePage('<%= ctxPath%>/gameopt.bz?g_code=${cartvo.gavo.g_code}')">
						
						
                        
                		<td><img src="<%= ctxPath%>/img/tbl_game_product_image/${cartvo.opvo.imgfile}" style="width:150px" alt=""></td> 
                                               
                        <td><span style="font-size:14pt; font-weight:bold;">${cartvo.gavo.g_name}</span>
	                        <span class="cart__list__smartstore cart_optinfono">${cartvo.gavo.g_content}</span>
	                      
                        </td>
                        
                  
                        <td class="cart__list__option">
                            <p><input class="spinner oqty" name="oqty" value="${cartvo.oqty}" style="width: 14px; height: 14px;">&nbsp;개</p>
                            <%--<button class="cart__list__optionbtn updateBtn" onclick="goOqtyEdit(this)">주문수량 추가/변경${cartvo.fk_optno}</button>
                        	 잔고량 --%>                        	
                        	<input type="hidden" class="opt_qty" value="${cartvo.opvo.opt_qty}" /> 
                              
                        	<%-- 장바구니 테이블에서 특정제품의 현재주문수량을 변경하여 적용하려면 먼저 장바구니번호(시퀀스)를 알아야 한다 --%>
                        	<input type="hidden" class="cartno" value="${cartvo.cartno}" /> 
                        
                        </td>
                        
                        <td>
                        	<fmt:formatNumber value="${cartvo.opvo.opt_sale_price}" pattern="###,###" />원
                        	<br><br>
                        	<fmt:formatNumber value="${cartvo.gavo.g_coin}" pattern="###,###" />POINT
                        </td>
                       
                    </tr>
                    
			</c:forEach>		   	
		</c:if>
		
		</tbody>
			
           <tfoot>
               <tr>
                   <td></td>
                   <td></td>
                   <td></td>
                    
	                		
                  	<td colspan="2" align="center">
            		<span style="font-weight: bold;">장바구니 총액 :</span>
         			<span style="color: red; font-weight: bold;"><fmt:formatNumber value="${requestScope.sumMap.SUMTOTALPRICE}" pattern="###,###" /></span> 원  
            		<br>
            		<span style="font-weight: bold;">총 포인트 :</span> 
         			<span style="color: red; font-weight: bold;"><fmt:formatNumber value="${requestScope.sumMap.SUMTOTALPOINT}" pattern="###,###" /></span> POINT 
        		</td>

			
               </tr>
           </tfoot>
	
        </table> 
   </div>
   
    <div>
        <p id="order_error_msg" class="text-center text-danger font-weight-bold h4"></p>
    </div>
 </td>
						</tr>
					  </tbody>
					</table>
				</div>
				
            </div>
<div id="accountDetails" style="display: none;" class="col-lg-12 mt-6">
    <div class="col-lg-12 mt-6" >
            	
				<div class="row">
					<table class="col-md-11 table table-dark"style="background-image: url('<%= ctxPath %>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th style="width:150px">내 정보</th>
						 <td class="text-right"><a type="button" class="btn btn-sm btn-primary text-right" href="<%= ctxPath%>/member/memberEditEnd.bz">변경하기</a></td>					    </tr>
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
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <td >연락처</td>
		     			 <td>${fn:substring(phone, 0, 3)}-${fn:substring(phone, 3, 7)}-${fn:substring(phone, 7, 11)}</td>
					    </tr>
					  </tbody>
					</table>
					<table class="col-md-11 table table-dark" style="background-image: url('<%= ctxPath%>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th style="width:150px">회원 비밀번호 변경</th>
					      <td class="text-right"><a type="button" class="btn btn-sm btn-info text-right" href="<%= ctxPath%>/member/pwdUpdateEnd.bz">비밀번호 변경하기</a></td>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <td colspan="3">회원의 비밀번호를 변경하려면 버튼을 눌러주세요</td>
					      
					    </tr>
					  </tbody>
					</table>
			
						<table class="col-md-11 table table-dark" style="background-image: url('<%= ctxPath%>/img/bg_blz.jpg');">
					  <thead>
					    <tr>
					      <th style="width:150px">회원 탈퇴</th>
					      <td class="text-right"><button type="button" class="btn btn-sm btn-danger text-right" onclick="goResignation()">회원 탈퇴</button></td>
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

<form name="memberResignation_frm">
	<input type="hidden" name="user_id" value="${loginuser.user_id}" />
</form>



</body>
</html>
 
 
<!--  이 코드는 Bootstrap의 그리드 시스템 및 클래스를 사용하여 섹션의 레이아웃을 구성하고, 섹션의 높이를 최소 250px로 고정하도록 했습니다. 기존 코드와 Bootstrap을 통합하여 웹 페이지를 디자인할 수 있게 되었습니다. 페이지의 다른 부분에 대해서도 Bootstrap을 활용하여 반응형 디자인을 추가할 수 있습니다. -->


