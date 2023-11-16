<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>
<jsp:include page="../header_suc.jsp" />

<%-- 캐러셀 시작 --%>
    <div class="row mb-5">
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
                                            <a href="wowcarinfo.bz?g_code=${sdvo.fk_g_code}" id="car_info"  class="btn btnGray" style="padding-top: 2%; color:white;
                                            border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">자세히 보기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${status.index == 1}">
                                <div class="carousel-item bgimg" style="height: 700px; background-image: url('<%= ctxPath%>/img/${sdvo.ms_bg_file}'); background-position: center;">
                                    <div class="d-none d-md-block" style="display: flex; margin: 15% 0 0 10%; align-items: center;">
                                        <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 28%; height: auto;" alt="...">
                                       
                                        <div class="mt-4" style="color:white; font-size: 40pt; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">블리즈컨 컬렉션 확인하기</div>
                                          <div style="color:#FFFFFFB2; font-size: 20pt; text-shadow: rgba(0, 0, 0, 0.3) 0px 4px 8px;;">어디에서든지 모험을 즐기세요!</div>
                                        <div>
                                           <a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btn-primary btnBlue mt-5" style="padding-top: 2%;
                                            border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                            <a href="ovwcarinfo.bz?g_code=${sdvo.fk_g_code}" id="car_info"  class="btn btnGray mt-5" style="padding-top: 2%; color:white;
                                            border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">자세히 보기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        </div>
                                    
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${status.index == 2}">
                                <div class="carousel-item bgimg" style="height: 700px; background-image: url('<%= ctxPath%>/img/${sdvo.ms_bg_file}'); background-position: center;">
                                    <div class="d-none d-md-block" style="display: flex; margin: 15% 0 0 10%;">
                                        <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 28%; height: auto;" alt="...">
                                       <div>
                                           <span style="color:white; font-size: 50pt; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">한정 기간 이벤트</span>
                                        </div>
                                        <div style="margin-top: -5%">
                                           <a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btn-primary btnBlue mr-3" style="padding-top: 2%;
                                            border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                            <a href="ovwcarinfo.bz?g_code=${sdvo.fk_g_code}" id="car_info"  class="btn btnGray" style="padding-top: 2%; color:white;
                                            border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">자세히 보기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${status.index == 3}">
                                <div class="carousel-item bgimg" style="height: 700px; background-image: url('<%= ctxPath %>/img/tbl_game_product_image/${sdvo.ms_bg_file}'); background-position: center;">
                                    <div class="d-none d-md-block" style="display: flex; margin: 18% 0 0 10%;">
                                        <img src="<%= ctxPath%>/img/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 28%; height: auto;" alt="...">
                                       <div>
                                           <span style="color:white; font-size: 50pt; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);">한정 기간 이벤트</span>
                                        </div>
                                        <div style="margin-top: -5%">
                                           <a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btn-primary btnBlue mr-3" style="padding-top: 2%;
                                            border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                            <a href="ovwcarinfo.bz?g_code=${sdvo.fk_g_code}" id="car_info"  class="btn btnGray" style="padding-top: 2%; color:white;
                                            border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">자세히 보기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${status.index == 4}">
                                <div class="carousel-item bgimg" style="height: 700px; background-image: url('<%= ctxPath %>/img/tbl_game_product_image/${sdvo.ms_bg_file}'); background-position: center;">
                                    <div class="d-none d-md-block" style="display: flex; margin: 15% 0 0 10%;">
                                        <img src="<%= ctxPath%>/img/tbl_game_product_image/${sdvo.ms_logo_file}" class="d-flex img-fluid" style="width: 28%; height: auto;" alt="...">
                                       <div class="mt-4">
                                           <span style="color:white; font-size: 40pt; font-weight: bold; text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); line-height: 1.2;">대격변의 새로운 시대를<br>대비하세요</span>
                                        </div>
                                        <div style="margin-top: -5%">
                                           <a href="gameopt.bz?g_code=${sdvo.fk_g_code}" id="purchasepage"  class="btn btn-primary btnBlue mr-3" style="padding-top: 2%;
                                            border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">구매하기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
                                            <a href="ovwcarinfo.bz?g_code=${sdvo.fk_g_code}" id="car_info"  class="btn btnGray" style="padding-top: 2%; color:white;
                                            border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">자세히 보기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
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
                                            <a href="ovwcarinfo.bz?g_code=${sdvo.fk_g_code}" id="car_info"  class="btn btnGray mt-5" style="padding-top: 2%; color:white;
                                            border: none; border-radius: 50px; font-size: 14pt; font-weight: bold;">자세히 보기</a> <%-- ?g_code=${sdvo.fk_g_code} --%>
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
            </div>
        </div>
    </div>