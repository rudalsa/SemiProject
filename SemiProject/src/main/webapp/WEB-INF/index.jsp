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

<link rel="stylesheet" href="<%= ctxPath%>/css/index/index.css">

<jsp:include page="header_suc.jsp" />
<div style="background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
<div id="main">
<%-- 캐러셀 시작 --%>
    <div class="row">
        <div class="col-12">
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
                                <div class="carousel-item active" style="height: 700px; background-image: url('<%= ctxPath %>/img/${sdvo.ms_bg_file}'); background-position: center;">
                                    <div class=" d-none d-md-block" style="display: flex; margin: 15% 0 0 10%;">
                                       <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 28%; height: auto;" alt="...">
                                    	<div>
                                        	<span style="color:white; font-size: 50pt; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">한정 기간 이벤트</span>
                                     	</div>
                                     	<div style="margin-top: -5%">
                                        	<a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btn-primary btnBlue mr-3" style="padding-top: 2%;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        	 <a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btnGray" style="padding-top: 2%; color:white;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${status.index == 1}">
                                <div class="carousel-item bgimg" style="height: 700px; background-image: url('<%= ctxPath %>/img/${sdvo.ms_bg_file}'); background-position: center;">
                                    <div class="d-none d-md-block" style="display: flex; margin: 15% 0 0 10%; align-items: center;">
                                        <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 28%; height: auto;" alt="...">
                                    	
                                     	<div class="mt-4" style="color:white; font-size: 40pt; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">블리즈컨 컬렉션 확인하기</div>
                                       	<div style="color:#FFFFFFB2; font-size: 20pt; text-shadow: rgba(0, 0, 0, 0.3) 0px 4px 8px;;">어디에서든지 모험을 즐기세요!</div>
                                     	<div>
                                        	<a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btn-primary btnBlue mt-5" style="padding-top: 2%;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        	 <a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btnGray mt-5" style="padding-top: 2%; color:white;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        </div>
                                    
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${status.index == 2}">
                                <div class="carousel-item bgimg" style="height: 700px; background-image: url('<%= ctxPath %>/img/${sdvo.ms_bg_file}'); background-position: center;">
                                    <div class="d-none d-md-block" style="display: flex; margin: 15% 0 0 10%;">
                                        <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 28%; height: auto;" alt="...">
                                    	<div>
                                        	<span style="color:white; font-size: 50pt; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">한정 기간 이벤트</span>
                                     	</div>
                                     	<div style="margin-top: -5%">
                                        	<a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btn-primary btnBlue mr-3" style="padding-top: 2%;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        	 <a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btnGray" style="padding-top: 2%; color:white;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${status.index == 3}">
                                <div class="carousel-item bgimg" style="height: 700px; background-image: url('<%= ctxPath %>/img/${sdvo.ms_bg_file}'); background-position: center;">
                                    <div class="d-none d-md-block" style="display: flex; margin: 18% 0 0 10%;">
                                        <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 28%; height: auto;" alt="...">
                                    	<div>
                                        	<span style="color:white; font-size: 50pt; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">한정 기간 이벤트</span>
                                     	</div>
                                     	<div style="margin-top: -5%">
                                        	<a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btn-primary btnBlue mr-3" style="padding-top: 2%;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        	 <a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btnGray" style="padding-top: 2%; color:white;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${status.index == 4}">
                                <div class="carousel-item bgimg" style="height: 700px; background-image: url('<%= ctxPath %>/img/${sdvo.ms_bg_file}'); background-position: center;">
                                    <div class="d-none d-md-block" style="display: flex; margin: 15% 0 0 10%;">
                                        <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 28%; height: auto;" alt="...">
                                    	<div class="mt-4">
                                        	<span style="color:white; font-size: 40pt; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); line-height: 1.2;">대격변의 새로운 시대를<br>대비하세요</span>
                                     	</div>
                                     	<div style="margin-top: -5%">
                                        	<a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btn-primary btnBlue mr-3" style="padding-top: 2%;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        	 <a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btnGray" style="padding-top: 2%; color:white;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${status.index == 5}">
                                <div class="carousel-item bgimg" style="height: 700px; background-image: url('<%= ctxPath %>/img/${sdvo.ms_bg_file}'); background-position: center;">
                                    <div class="d-none d-md-block" style="display: flex; margin: 12% 0 0 10%;">
                                        <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 28%; height: auto;" alt="...">
                                    	<div class="mt-4">
                                        	<span style="color:white; font-size: 40pt; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); line-height: 1.2;">워크래프트 럼블이 11월<br>4일 출시됩니다</span>
                                     	</div>
                                     	<div>
                                        	<a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btn-primary btnBlue mt-5" style="padding-top: 2%;
                                        	 border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
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
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </div>
    <h1 class="text-white my-5" style="font-weight: bold">추천게임</h1>
	 <%-- 캐러셀 끝 --%>
	
	

    <div class="row mb-5">
        <c:if test="${not empty requestScope.videoList}">
            <c:forEach var="videovo" items="${requestScope.videoList}" varStatus="status">
            <c:if test="${status.index >= 0}">
                <div class="col-md-2 col-sm-4 mx-auto video-container" style="padding: 0;">
                    <div class="video-container img-fluid video" style="background-image: url('<%= ctxPath %>/img//tbl_list_image/${videovo.video_set_bg_img}'); background-size: 100% 100%; height: 300px;">
					    <a href="gameopt.bz?g_code=${videovo.fk_g_code}">
					        <img src="<%= ctxPath %>/img//tbl_list_image/${videovo.video_set_logo_img}" alt="..." class="img-fluid" name="${videovo.video_set_gif}">
					    </a>
					</div>
                    <span style="font-size: 15pt; font-weight: bold; color: white;">${videovo.gvo.g_name}</span><br>
                    <span style="font-size: 11pt; font-weight: bold; color: rgba(208, 233, 255, 0.6);">${videovo.cvo.c_name}</span>
                </div>
                </c:if>
                <c:if test="${status.index % 5 == 4}">
             </div>
             
             <div class="row" >  
           </c:if>
   
            </c:forEach>
        </c:if>
    </div>
      <div style="text-align: center;"> 
      <button type="button" class="btn btn-primary btnBlue" style="border-radius: 100px">모든 게임 보기</button>
      </div>
      
      
 </div>  
</div>
	<div style="width: 80%; margin: 5% auto;">
      <iframe width="100%" height="100%" src="https://www.youtube.com/embed/hLvWy2b857I?si=b6oKda86CgMdD2QM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
   </div>


<div style="background-color: black; padding-top: 5%">
<jsp:include page="footer_suc.jsp" />
</div>