<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath(); 
%>

<%-- JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/shop/likeshop.css"> 

<script>

function goitem(g_code) {
  console.log(g_code);

  const ctxPath = '<%= ctxPath %>';
  console.log(g_code);
  const url = ctxPath+'/gameopt.bz?g_code='+g_code;
  console.log(url);
  window.open(url, "likeg_code");
}

function  gologin(){
	
	const ctxPath = '<%= ctxPath %>';
	const url = ctxPath+'/login/login.bz';
	window.open(url, "login");
}

function  gores(){
	
	const ctxPath = '<%= ctxPath %>';
	const url = ctxPath+'/member/memberRegister.bz';
	window.open(url, "login");
}

</script>

</head>
<body>

  <section class="cart">
      
      <div class="cart__information">
          <ul>
              <li>찜목록은 최대 3개 까지만 저장됩니다.</li>
              <li>상품을 구매하시려면 로그인 하셔야합니다.</li>
              <li>로그인을 하시고 찜목록 창을 닫으시면 다시 볼 수 없으니 주의하세요!</li>
          </ul>
       </div>
       
       <c:if test="${empty requestScope.likeList}">
	       <div>
		       <span>찜목록에 담긴 상품이 없습니다.!</span>
		   </div>
	   </c:if>
	   
	   <c:if test="${not empty requestScope.likeList}">
	   <table class="cart__list">
            
            <form>
            <thead>
                <tr>
                	<td colspan="3">제품정보</td>
                    <td>상품설명</td>
                    <td>상품금액</td>
                    <td>배송비</td>
                </tr>
            </thead>
            
            <tbody>
			   	<c:forEach var="gavo" items="${requestScope.likeList}">	
	                <tr class="cart__list__detail">
	                    <td></td>
	                    <td><img src="<%=ctxPath %>/img/tbl_game_product_image/${gavo.g_img_1}" alt="magic keyboard"></td>
	                    <td><a href="#">${gavo.g_name}</a><span class="cart__list__smartstore">&nbsp;${gavo.g_company}</span>
	                    <p>${gavo.g_content}</p>
	                    <sapn class="price">${gavo.g_sale_price}</sapn><span
	                        style="text-decoration: line-through; color: lightgray;">${gavo.g_price}</span>
	                    </td>
	                    <td class="cart__list__option">
	                        <p>${gavo.g_info}</p>
	                    </td>
	                    <td><span class="price">${gavo.g_sale_price}~</span><br>
	                    	<button type="button" class="cart__list__orderbtn" onclick="goitem(`${gavo.g_code}`)">이 상품 보러가기</button>
	                    </td>
	                        <td>무료</td>
	                    </tr>
		    	</c:forEach>
	    	</tbody>
        	</form>
        	
       </table>

      <div class="cart__mainbtns">
          <button class="cart__bigorderbtn left" onclick="gologin()">로그인하로가기</button>
          <button class="cart__bigorderbtn right" onclick="gores()">회원가입하로가기</button>
      </div> 
        
         
      </c:if>
     	
   </section>

</body>
</html>