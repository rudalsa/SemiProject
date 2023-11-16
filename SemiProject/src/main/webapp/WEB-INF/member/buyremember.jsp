<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
   String ctxPath = request.getContextPath();

%>

<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/shop/likeshop.css"> 

<jsp:include page="../header_suc.jsp" />

	<section class="cart">
	    
	    <div class="cart__information text-center" style="margin-top:7%; width: 60%; margin:7% auto;">
	        <ul>
	            <li>이용해주셔서 감사합니다.</li>
	            <li>주문이 늦거나 상이할 경우 고객센터로 전화주세요.</li>
	            <li>오늘출발 상품은 판매자 설정 시점에 따라 오늘출발 여부가 변경될 수 있으니 주문 시 꼭 다시 확인해 주시기 바랍니다.</li>
	        </ul>
	    </div>
	    
	   
	    <table class="cart__list" style="width: 80%; margin: 0 auto;">
			<thead>
				<tr>
	                
	                <td colspan="7" align="center">
	               		<h2 style="color: whitesmoke;"><span style="color:orange;">${sessionScope.loginuser.user_name}</span>님의 구매내역</h2> 
	        		</td>
				
	           </tr>
	           <tr style="color:whitesmoke;">
	               <td>주문번호</td>
	               <td colspan="2">상품정보</td>
	               <td>주문총액</td>
	               <td>배송상태</td>

	        	</tr>
	   
	        </thead>
	        <tbody>
	            
	    <c:if test="${empty requestScope.rememberList}">
	 		<tr>
	 			<td colspan="7" align="center">
	   			<span style="color: red; font-weight: bold;">
	      		장바구니에 담긴 상품이 없습니다.
	   			</span>
	 			</td>   
	 		</tr>
	 	</c:if>   
	 	
          

	 	
	 	
	 	<c:if test="${not empty requestScope.rememberList}">
	 		<c:forEach var="viewvo" items="${requestScope.rememberList}" varStatus="status"> 
			
			  
			  
			  
			  
			  
			  
			  <tr class="cart__list__detail">
						
						<td style="text-align:center; color:whitesmoke; "><h5 style="font-size:10pt;">${viewvo.fk_odrcode}</h5></td>
                        
                        <td><img src="<%= ctxPath%>/img/tbl_game_product_image/${viewvo.imgfile}" alt=""></td> 
                                               
                        <td>
	                        <span style="color:orange; font-size:12pt; font-weight: bold; border:none; " class="cart__list__smartstore cart_optinfono">${viewvo.opt_name}</span>
	                        <p style="color:whitesmoke; border:none;">${viewvo.opt_content}</p>
	                        <p style="color:white; border:none;"><fmt:formatNumber value="${viewvo.opt_sale_price}" pattern="###,###" />원</p>
	                        <span style="color: lightgray; border:none;">주문량&nbsp;${viewvo.oqty}&nbsp;개</span>
                        </td>
                        
                  
                        <td style="text-align:center; color:whitesmoke;">
                        	<h5><fmt:formatNumber value="${viewvo.odrprice}" pattern="###,###" />원</h5>
                        	<h5 style="font-size:10pt;  border:none;">${viewvo.odrdate}</h5>
                        </td>
                       
                        <td> 
	                		<span class="price">${viewvo.deliverstatus}</span>
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
            		<span style="font-weight: bold; color:whitesmoke;">누적결제금액 :</span>
         			<span class="carttotalprice" style="color: red; font-weight: bold;"><fmt:formatNumber value="${sessionScope.loginuser.user_payment}" pattern="###,###" /></span> <span style="color:whitesmoke;">&nbsp;원</span>  
            		<br>
            		<span style="font-weight: bold; color:whitesmoke;">보유포인트 :</span> 
         			<span class="carttotalpoint" style="color: red; font-weight: bold;"><fmt:formatNumber value="${sessionScope.loginuser.user_coin}" pattern="###,###" /></span><span style="color:whitesmoke;">&nbsp;POINT</span> 
        		</td>
			
               </tr>
           </tfoot>
	
        </table> 
	 
	</section>
















</body>
</html>