<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>

<jsp:include page="header_suc.jsp" />

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Reem+Kufi+Ink&display=swap" rel="stylesheet">
<script type="text/javascript" src="<%= ctxPath%>/js/shop/displayitem.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/shop/displayitem.css" />
	
	<div style="width:100%; margin-top: 10%;">
		
		
		<input type="text" id="c_no" value="${requestScope.c_no}">
		
			
		<%-- === HIT 상품을 모두 가져와서 디스플레이(더보기 방식으로 페이징 처리한 것) === --%>
      	<div class="main mx-auto" id="displayitem">
      	   
      	</div>
      	
      	
    </div>
    
      	<div style="background-color:red;">
         	<p class="text-center">
            	<span id="end" style="display:block; margin:20px; font-size: 30pt; font-weight: bold; color: white;"></span> 
                <span id="countSum">0</span>
                <span id="totalCount">${requestScope.CateGoryCount}</span>
         	</p>
        </div>
        
        <%-- 
        <div style="display: flex; align: center;">
        	<div style="margin: 20px 0 20px auto;">
            	<button class="btn btn-info" onclick="goTop();">맨위로가기(scrollTop 1로 설정함)</button>
            </div>
      	</div>
    	--%>  

	

		



<jsp:include page="footer_suc.jsp" />