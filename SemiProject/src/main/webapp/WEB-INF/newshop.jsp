<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>
<style>

    table {
        border-collapse: collapse;
        width: 100%;
    }

    tr.img td {
        padding: 0;
        text-align: center;
        width: 100px;
        height: 75px;
        
    }
    

    tr.img td img {
    
        width: 50%;
        height: 100%;
    }
    
    tr.text-cor td {
    	text-align:center;
    	height: 25px;
    	color: white;
    
    }
</style>

<jsp:include page="header_suc.jsp" />

<script type="text/javascript" src="<%= ctxPath%>/js/shop/newshop.js"></script>

	
	<div class="mx-auto" style="width:90%; margin-top: 10%;">
		
		
		<table class="table mx-auto" style="width:75%">
		    
		    <tr class="img">
		    
		        <td><img src="<%= ctxPath %>/img/newshop/games_cod-mw.svg" name="" ></td>
		        <td><img src="<%= ctxPath %>/img/newshop/games_diablo.svg" name="" ></td>
		        <td><img src="<%= ctxPath %>/img/newshop/games_hearthstone.svg" name="" ></td>
		        <td><img src="<%= ctxPath %>/img/newshop/games_heroes.svg" name="" ></td>
		        <td><img src="<%= ctxPath %>/img/newshop/games_overwatch.svg" name="" ></td>
		        <td><img src="<%= ctxPath %>/img/newshop/games_sc2.svg" name="" ></td>
		        <td><img src="<%= ctxPath %>/img/newshop/games_scr.svg" name="" ></td>
		        <td><img src="<%= ctxPath %>/img/newshop/games_wow.svg" name="" ></td>
		    
		    </tr>
		    
		    <tr class="text-cor">
		    
		        <td>게임1</td>
		        <td>게임2</td>
		        <td>게임3</td>
		        <td>게임4</td>
		        <td>게임5</td>
		        <td>게임6</td>
		        <td>게임7</td>
		    	<td>게임8</td>
		    </tr>
		
		</table>	
		
		
		<div>
			<span class="h5 text-white">게임명/카테고리/갯수</span>
		</div>
		
		<%-- === HIT 상품을 모두 가져와서 디스플레이(더보기 방식으로 페이징 처리한 것) === --%>
   		<div>
        	<p class="h3 my-3 text-center">- - HIT 상품 -(스크롤) -</p>
      
      	<div class="row" id="display"></div>
      
      	<div style="background-color:red;">
         	<p class="text-center">
            	<span id="end" style="display:block; margin:20px; font-size: 30pt; font-weight: bold; color: white;"></span> 
               
                <span id="countSum">0</span>
                <span id="totalCount">${requestScope.SpecCount}</span>
         	
         	</p>
        </div>
      
        <div style="display: flex;">
        	<div style="margin: 20px 0 20px auto;">
            	<button class="btn btn-info" onclick="goTop();">맨위로가기(scrollTop 1로 설정함)</button>
            </div>
      	</div>
      
      
   	    </div>
		
	</div>	
	

		



<jsp:include page="footer_suc.jsp" />