<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath(); 
%>

<%-- JS --%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/js/shop/orderinfo.js"></script>


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
</style>



<jsp:include page="../header_suc.jsp" />

    
  
<section class="cart">    
  
   <div id="content">
   <!-- ID -->
   
	<div>
	    <h3 class="join_title">
	        <label for="id">아이디</label>
	    </h3>
	    <span class="box int_id">
	        <input type="text" id="id" class="int" maxlength="20">
	        <span class="step_url">@naver.com</span>
	    </span>
	    <span class="error_next_box"></span>
	</div>
	<!-- PW1 -->
       <div>
           <h3 class="join_title"><label for="pswd1">비밀번호</label></h3>
           <span class="box int_pass">
               <input type="text" id="pswd1" class="int" maxlength="20">
               <span id="alertTxt">사용불가</span>
               <img src="m_icon_pass.png" id="pswd1_img1" class="pswdImg">
           </span>
           <span class="error_next_box"></span>
       </div>
	<!-- PW2 -->
       <div>
       	<h3 class="join_title"><label for="pswd2">비밀번호 재확인</label></h3>
          	<span class="box int_pass_check">
              	<input type="text" id="pswd2" class="int" maxlength="20">
              	<img src="m_icon_check_disable.png" id="pswd2_img1" class="pswdImg">
          	</span>
          	<span class="error_next_box"></span>
        </div>
	 <!-- NAME -->
        <div>
            <h3 class="join_title"><label for="name">이름</label></h3>
            <span class="box int_name">
                <input type="text" id="name" class="int" maxlength="20">
            </span>
            <span class="error_next_box"></span>
        </div>
	<!-- BIRTH -->
       <div>
           <h3 class="join_title"><label for="yy">생년월일</label></h3>
           <div id="bir_wrap">
           <!-- BIRTH_YY -->
           <div id="bir_yy">
               <span class="box">
                   <input type="text" id="yy" class="int" maxlength="4" placeholder="년(4자)">
               </span>
           </div>

          	<!-- BIRTH_MM -->
          	<div id="bir_mm">
            <span class="box">
                <select id="mm" class="sel">
                    <option>월</option>
                    <option value="01">1</option>
                    <option value="02">2</option>
                    <option value="03">3</option>
                    <option value="04">4</option>
                    <option value="05">5</option>
                    <option value="06">6</option>
                    <option value="07">7</option>
                    <option value="08">8</option>
                    <option value="09">9</option>                                    
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                </select>
            </span>
          	</div>

           <!-- BIRTH_DD -->
           <div id="bir_dd">
               <span class="box">
                   <input type="text" id="dd" class="int" maxlength="2" placeholder="일">
               </span>
           </div>

           </div>
           	<span class="error_next_box"></span>    
           </div>

           <!-- GENDER -->
           <div>
               <h3 class="join_title"><label for="gender">성별</label></h3>
               <span class="box gender_code">
                   <select id="gender" class="sel">
                       <option>성별</option>
                       <option value="M">남자</option>
                       <option value="F">여자</option>
                   </select>                            
               </span>
               <span class="error_next_box">필수 정보입니다.</span>
           </div>

           <!-- EMAIL -->
           <div>
               <h3 class="join_title"><label for="email">본인확인 이메일<span class="optional">(선택)</span></label></h3>
               <span class="box int_email">
                   <input type="text" id="email" class="int" maxlength="100" placeholder="선택입력">
               </span>
               <span class="error_next_box">이메일 주소를 다시 확인해주세요.</span>    
           </div>

           <!-- MOBILE -->
           <div>
               <h3 class="join_title"><label for="phoneNo">휴대전화</label></h3>
               <span class="box int_mobile">
                   <input type="tel" id="mobile" class="int" maxlength="16" placeholder="전화번호 입력">
               </span>
               <span class="error_next_box"></span>    
           </div>
       </div>
             

       
       
	   <div class="cart_flex">       
	   
	   
	   <div style="position: -webkit-sticky; position: sticky; top: 100px;">
	   
	   <table class="cart__list">   
	    
	    <thead>
	     	<tr>
	            <td><input type="checkbox"></td>
	            <td colspan="2">상품정보</td>
	            <td>옵션</td>
	            <td>상품금액</td>
	            <td>주문총액/총포인트</td>
	            <td>삭제하기</td>
	       </tr>
	    </thead>
	 
	 	<tbody>
	
	 
			
		<tr class="cart__list__detail">
		
			<td><input type="checkbox" name="g_code" class="chkbox_g_code" id="g_code${status.index}" value="${cartvo.fk_g_code}" /></td>
			<td><img src="<%= ctxPath%>/img/tbl_game_product_image/${cartvo.opvo.imgfile}" alt=""></td> 
	       	<td><a href="#">${cartvo.gavo.g_name}</a>
			<span class="cart__list__smartstore cart_g_code">${cartvo.gavo.g_content}</span>
			<p>${cartvo.opvo.opt_name}</p>
			<span class="price">${cartvo.opvo.opt_sale_price}</span>
			<span style="text-decoration: line-through; color: lightgray;">${cartvo.opvo.opt_price}</span>
			</td>
			<td class="cart__list__option">
	    	<p><input class="spinner oqty" name="oqty" value="${cartvo.oqty}" style="width: 14px; height: 14px;">&nbsp;개</p>
			<button class="cart__list__optionbtn updateBtn" onclick="goOqtyEdit(this)">주문수량 추가/변경</button>
			<%-- 잔고량 --%>
			<input type="hidden" class="g_qty" value="${cartvo.gavo.g_qty}" /> 
			<%-- 장바구니 테이블에서 특정제품의 현재주문수량을 변경하여 적용하려면 먼저 장바구니번호(시퀀스)를 알아야 한다 --%>
			<input type="hidden" class="cartno" value="${cartvo.cartno}" /> 
			</td>
			<td>
			<fmt:formatNumber value="${cartvo.opvo.opt_sale_price}" pattern="###,###" />원
			<br><br>
			<fmt:formatNumber value="${cartvo.gavo.g_coin}" pattern="###,###" />POINT
			</td>
			<td> <%-- 주문총액/총포인트 --%> 
			<fmt:formatNumber value="${cartvo.opvo.opt_sale_price}" pattern="###,###" /> 원<br>
			<fmt:formatNumber value="${cartvo.gavo.g_coin}" pattern="###,###" /> POINT
			<input type="hidden" class="totalPrice" value="${cartvo.opvo.opt_sale_price}" />
			<input type="hidden" class="totalPoint" value="${cartvo.gavo.g_coin}" />
			</td>
			<td><button type="button" class="cart__list__optionbtn" onclick="goDel('${cartvo.cartno}')">삭제</button></td>
		</tr>
		</tbody>
				
	    <tfoot>
			 <tr>
			    <td></td>
			    <td></td>
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
	</div> 

</section>             
	
    </body>
</html>