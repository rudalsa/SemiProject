<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>


<script>
    // JavaScript를 사용하기 위해 해당 코드를 추가해 주세요.
    document.addEventListener("DOMContentLoaded", function () {
        // 모든 요소를 선택합니다.
        var elements = document.querySelectorAll(".video");

        // 각 요소에 대한 마우스 이벤트를 등록합니다.
        elements.forEach(function (element) {
            
        	var ImgBackground = element.style.backgroundImage;
            var videoname = element.querySelector("img");
			
            // 마우스가 요소 위로 올라갈 때
            element.addEventListener("mouseover", function () {
            	
            	
            	console.log(videoname.name);
            	
            	var videoPath = '<%= ctxPath %>/img/tbl_list_image/' + videoname.name;
            	console.log(videoPath);
            	element.style.backgroundImage = "url('"+videoPath+"')";
            	// 배경 이미지 변경
               
            });

            // 마우스가 요소에서 벗어날 때
            element.addEventListener("mouseout", function () {
                // 원래의 배경 이미지로 복원
                element.style.backgroundImage = ImgBackground;
            });
        });
    });
</script>


<jsp:include page="header_suc.jsp" />

<%-- 캐러셀 시작 --%>
<div class="container">
    <div class="row">
        <div class="col-12 text-center">
            <div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
                
                <ol class="carousel-indicators">
                    <c:if test="${not empty requestScope.sdList}">
                        <c:forEach items="${requestScope.sdList}" varStatus="status">
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
                    <c:if test="${not empty requestScope.sdList}">
                        <c:forEach var="sdvo" items="${requestScope.sdList}" varStatus="status">
                            <c:if test="${status.index == 0}">
                                <div class="carousel-item active" style="height: 300px; background-image: url('<%= ctxPath %>/img/${sdvo.ms_bg_file}'); background-size: 100% 100%; background-position: center;">
                                    <div class="carousel-caption d-none d-md-block" style="display: flex; align-items: center;">
                                    	
                                        <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 25%; height: auto; margin-right: 20px;" alt="하...">
                                        <div>
                                        
                                        	<a href="gameoption.bz?imgsetno=${sdvo.ms_img_no}" id="purchasepage" class="btn btn-info">구매하기</a>
                                        	
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${status.index > 0}">
                                <div class="carousel-item" style="height: 300px; background-image: url('<%= ctxPath %>/img/${sdvo.ms_bg_file}'); background-size: 100% 100%; background-position: center;">
                                    <div class="carousel-caption d-none d-md-block" style="display: flex; align-items: center;">
                                        <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 25%; height: auto; margin-right: 20px;" alt="...">
                                    	<div>
                                        
                                        	<a href="gameoption.bz?imgsetno=${sdvo.ms_img_no}" id="purchasepage" class="btn btn-info">구매하기</a>
                                        
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
    <h1 class="text-white mt-5" style="font-weight: bold">추천게임</h1>
</div>
 <%-- 캐러셀 끝 --%>


<div class="row mb-5 pl-1" style="margin: 0px 5%;">  
        <c:if test="${not empty requestScope.videoList}">
           <c:forEach var="videovo" items="${requestScope.videoList}" varStatus="status">
              <c:if test="${status.index >= 0}">
              
             
              
	              <div class="col-md-2 mx-auto video" 
	                
	                style="background-image: url('<%= ctxPath %>/img//tbl_list_image/${videovo.video_set_bg_img}' ); background-size: 100%,100%; height:300px; width:100%">   
	                 <a href="gameoption.bz?imgsetno=${videovo.video_set_no}">
	                <img src="<%= ctxPath %>/img//tbl_list_image/${videovo.video_set_logo_img}" alt="..." class="img-fluid" name="${videovo.video_set_gif}" >   
	                 </a>
	             </div>
           
             </c:if>   
          
          <c:if test="${status.index % 5 == 4}">
             </div>
             
             <div class="row mb-5 pl-1" style="margin: 0px 5%;">  
           </c:if>
   
              </c:forEach>
         
         </c:if>
      </div>
 </div>     

<jsp:include page="footer_suc.jsp" />