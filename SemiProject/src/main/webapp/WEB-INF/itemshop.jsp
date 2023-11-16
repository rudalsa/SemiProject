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
		
		
		<input type="hidden" id="c_no" value="${requestScope.c_no}">
		
		      <div>
         <span>${request.cateList.gvo.c_name}</span>
      </div>
      <%-- 캐러셀 시작 --%>
      
      
      <div class="container">
          <div class="row">
             <span>${request.cateList.cvo.c_name}</span>
              <div class="col-12 text-center">
                  <div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
                      
                      <ol class="carousel-indicators">
                          <c:if test="${not empty requestScope.cateList}">
                              <c:forEach items="${requestScope.cateList}" varStatus="status">
                                  <c:if test="${status.index == 0}">
                                      <li data-target="#carouselExampleIndicators" data-slide-to="${status.index}" class="active"></li>
                                  </c:if>
                                  <c:if test="${status.index > 0}">
                                      <li data-target="#carouselExampleIndicators" data-slide-to="${status.index}"></li>
                                  </c:if>
                              </c:forEach>
                          </c:if>
                      </ol>
      
                      <div class="carousel-inner">
                          <c:if test="${not empty requestScope.cateList}">
                              <c:forEach var="cateList" items="${requestScope.cateList}" varStatus="status">
                                  <c:if test="${status.index == 0}">
                                      <div class="carousel-item active" style="height: 500px; background-image: url('<%= ctxPath %>/img/tbl_game_product_image/${cateList.g_img_1}'); background-size: 100% 100%; background-position: center;">
                                          <div class="carousel-caption d-none d-md-block" style="display: flex; align-items: center;">
                                             
                                              <%-- <img src="<%= ctxPath%>/img/tbl_game_product_image/${cateList.g_img_1}" class="d-flex img-fluid" style="width: 25%; height: auto; margin-right: 20px;" alt="하..."> --%>
                                              <div>
                                                 <a href="gameopt.bz?g_code=${cateList.g_code}" id="purchasepage" class="btn btn-info">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                                 <%-- <a href="wowcarinfo.bz?imgsetno=${sdvo.ms_img_no}" id="car_info" class="btn btn-danger">자세히보기</a> --%>
                                              </div>
                                          </div>
                                      </div>
                                  </c:if>
                                  <c:if test="${status.index > 0}">
                                      <div class="carousel-item" style="height: 500px; background-image: url('<%= ctxPath %>/img/tbl_game_product_image/${cateList.g_img_1}'); background-size: 100% 100%; background-position: center;">
                                          <div class="carousel-caption d-none d-md-block" style="display: flex; align-items: center;">
                                              <%-- <img src="<%= ctxPath%>/img/tbl_game_product_image/${cateList.g_img_1}" class="d-flex img-fluid" style="width: 25%; height: auto; margin-right: 20px;" alt="..."> --%>
                                             <div>
                                              
                                                 <a href="gameopt.bz?g_code=${cateList.g_code}" id="purchasepage" class="btn btn-info">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                                 <%-- <a href="wowcarinfo.bz?imgsetno=${sdvo.ms_img_no}" id="car_info" class="btn btn-danger">자세히보기</a> --%>
                                              </div>
                                          
                                          </div>
                                      </div>
                                  </c:if>
                              </c:forEach>
                          </c:if>
                      </div>
      
                      <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                          <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                          <span class="sr-only">Previous</span>
                      </a>
                      <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                          <span class="carousel-control-next-icon" ariahidden="true"></span>
                          <span class="sr-only">Next</span>
                      </a>
                  </div>
              </div>
          </div>
          <h1 class="text-white mt-5 mb-4" style="font-weight: bold">추천게임</h1>
      </div>
       <%-- 캐러셀 끝 --%>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
			
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