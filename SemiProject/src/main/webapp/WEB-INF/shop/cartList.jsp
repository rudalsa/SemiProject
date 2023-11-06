<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
   String ctxPath = request.getContextPath();
    //     /MyMVC
%>

<jsp:include page="header_shop.jsp" />
   
<style type="text/css" >
   
   table#tblCartList {width: 90%;
                      border: solid gray 1px;
                      margin-top: 20px;
                      margin-left: 10px;
                      margin-bottom: 20px;}
                      
   table#tblCartList th {border: solid gray 1px;}
   table#tblCartList td {border: dotted gray 1px;} 
   
   div.loader {
       border: 12px solid #f3f3f3;
       border-radius: 50%;
    /* border-top: 16px solid blue; */
	   border-top: 12px dotted blue;
    /* border-right: 16px solid green; */
       border-right: 12px dotted green;
    /* border-bottom: 16px solid red; */
       border-bottom: 12px dotted red;
       border-left: 12px dotted pink;
       
       width: 80px;
       height: 80px;
       -webkit-animation: spin 2s linear infinite;
       animation: spin 2s linear infinite;
   }

   @-webkit-keyframes spin {
       0% { -webkit-transform: rotate(0deg); }
       100% { -webkit-transform: rotate(360deg); }
   }

   @keyframes spin {
       0% { transform: rotate(0deg); }
       100% { transform: rotate(360deg); }
   }
   
     
</style>

<script type="text/javascript">

   $(document).ready(function(){
      
	  $("div.loader").hide(); // CSS 로딩화면 감추기            
	  $("p#order_error_msg").css({'display':'none'}); // 코인잔액 부족시 주문이 안된다는 표시를 해주는 곳.
                        
      
      $(".spinner").spinner({
         
    	  spin: function(event, ui) {
            if(ui.value > 100) {
               $(this).spinner("value", 10);
               return false;
            }
            
            else if(ui.value < 0) {
               $(this).spinner("value", 0);
               return false;
            }
         
    	  }
      
      });// end of $(".spinner").spinner({});-----------------
      
            
      // 제품번호의 모든 체크박스가 체크가 되었다가 그 중 하나만 이라도 체크를 해제하면 전체선택 체크박스에도 체크를 해제하도록 한다.
      $(".chkbox_g_code").click(function(){
         
         let bFlag = false;
         $(".chkbox_g_code").each(function(){
            const bChecked = $(this).prop("checked");
            if(!bChecked) {
               $("#allCheckOrNone").prop("checked",false);
               bFlag = true;
               return false;
            }
         });
         
         if(!bFlag) {
            $("#allCheckOrNone").prop("checked",true);
         }
         
      });
      
   }); // end of $(document).ready()-------------------------- 다했음
   
   
   // Function declaration
   
   function allCheckBox() {
   
      const bool = $("#allCheckOrNone").is(":checked");
      /*
         $("#allCheckOrNone").is(":checked"); 은
           선택자 $("#allCheckOrNone") 이 체크되어지면 true를 나타내고,
           선택자 $("#allCheckOrNone") 이 체크가 해제되어지면 false를 나타내어주는 것이다.
      */
      
      $(".chkbox_g_code").prop("checked", bool);
   }// end of function allCheckBox()------------------------- 다했음
   
   
   // === 장바구니 현재주문수량 수정하기 === // 
   function goOqtyEdit(obj) {
      
      const index = $("button.updateBtn").index(obj);
      alert(index);
      
      const cartno = $("input.cartno").eq(index).val();
      alert(cartno);   
      
      const oqty = $("input.oqty").eq(index).val();
   	  alert(oqty);
      
      const regExp = /^[0-9]+$/g; // 숫자만 체크하는 정규표현식
      const bool = regExp.test(oqty);
   
      if(!bool) {
         alert("수정하시려는 수량은 0개 이상이어야 합니다.");
         location.href="javascript:history.go(0);";
         return;
      }
      
      const g_qty = $("input.g_qty").eq(index).val();  // 잔고개수
      alert("주문량 : "+ oqty + ", 잔고량 : " + g_qty);
  	  alert(typeof oqty + " , " + typeof g_qty)	
      
  	  //   !!! 조심할 것 !!! //
  	  //   if(oqty > pqty) { 으로 하면 꽝됨!! 왜냐하면 string 타입으로 비교하기에
  	  //   if("2" > "19") {  참이됨
  	  //   if(2 > 19) {  거짓이됨     
      if(Number(oqty) > Number(g_qty)) {
         alert("주문개수가 잔고개수 보다 더 커서 진행할 수 없습니다.");
         location.href="javascript:history.go(0)";
         return; // goOqtyEdit 함수 종료
      }
  	  
            
 	  alert("장바구니번호 "+cartno+"을 "+oqty+"개로 수정합니다.");
      if(oqty == "0") {
    	  goDel(cartno);
      }
      
      else {
         $.ajax({
               
        	   url:"<%= ctxPath%>/buy/cartEdit.bz",
               type:"POST",
               data:{"cartno":cartno,
                    "oqty":oqty},
               dataType:"JSON",
               success:function(json){
                  
            	   // console.log("~~~ 확인용 ", JSON.stringify(json));
                   // ~~~ 확인용 {"n":1}
               
                  if(json.n == 1) {
                     alert("주문수량이 변경되었습니다.");   
                     location.href = "cartList.bz";  // 장바구니 보기 페이지로 가야 한다.
                  }
               
               },
               
               error: function(request, status, error){
                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
               }
               
            });
      
      }
   
   }// end of function goOqtyEdit(obj)----------------- 다했음
   
   
   // === 장바구니에서 특정 제품을 비우기 === //  
   function goDel(cartno) {
      
	  alert("클릭되었습니다.");
	   
      const g_name = $(event.target).parent().parent().find("span.cart_g_code").text();
   
      if(confirm(`\${g_name}을(를) 장바구니에서 제거하시는 것이 맞습니까?`)) {
         
         $.ajax({
            url:"<%= ctxPath%>/buy/cartDel.bz",
            type:"POST",
            data:{"cartno":cartno},
            dataType:"JSON",
            success:function(json){
               // console.log("~~~ 확인용 ", JSON.stringify(json) );
               // ~~~ 확인용 {"n":1}
               
               if(json.n == 1) { 
                  location.href = "cartList.bz"; 
                  // 장바구니 보는 페이지로 이동한다.
               }
            },
            error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
         });
         
      }
      
      else {
         alert("장바구니에서 "+g_name+" 제품 삭제를 취소하셨습니다.");
      }
      
   }// end of function goDel(cartno) --- 다했음
   

   
   
   // === 장바구니에서 제품 주문하기 === // 
   function goOrder() {
       
   	   alert("클릭되었습니다.");
       ///// == 체크박스의 체크된 갯수(checked 속성이용) == /////
       const checkCnt = $("input:checkbox[name='g_code']:checked").length;
       
       if(checkCnt < 1) {
           alert("주문하실 제품을 선택하세요!!");
           return; // 종료 
       }
       
       else {
           //// == 체크박스에서 체크된 value값(checked 속성이용) == ////
           ///  == 체크가 된 것만 값을 읽어와서 배열에 넣어준다. /// 
           const allCnt = $("input:checkbox[name='g_code']").length;
           const g_codeArr = new Array();      // 또는 const pnumArr = [];
           const oqtyArr = new Array();        // 또는 const oqtyArr = [];
           const g_qtyArr = new Array();        // 또는 const pqtyArr = [];
           const cartnoArr = new Array();      // 또는 const cartnoArr = [];
           const totalPriceArr = new Array();  // 또는 const totalPriceArr = [];
           const totalPointArr = new Array();  // 또는 const totalPointArr = [];
             
           for(let i=0; i<allCnt; i++) {
                
               if( $("input:checkbox[name='g_code']").eq(i).prop("checked") ) {
               <%--윗 줄 불린타입이 나온다.    
        		   
        		   console.log("제품번호 : " , $("input:checkbox[name='g_code']").eq(i).val() ); 
        		   console.log("주문량 : " , $("input.oqty").eq(i).val() );
        		   console.log("잔고량 : " ,  $("input.g_qty").eq(i).val() );
        		   console.log("삭제해야할 장바구니 번호 : " + $("input.cartno").eq(i).val() ); 
                   console.log("주문한 제품의 개수에 따른 가격합계 : " , $("input.totalPrice").eq(i).val() );
                   console.log("주문한 제품의 개수에 따른 포인트합계 : " , $("input.totalPoint").eq(i).val() );
                   console.log("======================")
          		   
          		   제품번호 : 300 옵션번호?
			       주문량 :  1    옵션재고도 있어야되고?
				   삭제해야할 장바구니 번호 : 24 건들거 없음
				   주문한 제품의 개수에 따른 가격합계 :  230000 세션값이라서 자꾸 동기화됨 옵션 가격도 있어야함?
				   주문한 제품의 개수에 따른 포인트합계 :  0 옵션재고 포인트 있어야되고?
				   ======================
				   제품번호 :  332
				   주문량 :  5
				   장바구니 번호 : 17
				   주문한 제품의 개수에 따른 가격합계 :  230000
				   주문한 제품의 개수에 따른 포인트합계 :  100
				   ======================
				   
          		--%> 
                   
                  g_codeArr.push( $("input:checkbox[name='g_code']").eq(i).val() );
                  oqtyArr.push( $("input.oqty").eq(i).val() );
                  g_qtyArr.push( $("input.g_qty").eq(i).val() );
                  cartnoArr.push( $("input.cartno").eq(i).val() );
                  totalPriceArr.push( $("input.totalPrice").eq(i).val() );
                  totalPointArr.push( $("input.totalPoint").eq(i).val() ); 
               
               } // end of if -----
            
           }// end of for---------------------------
           
           <%-- 확인용입니다.
           for(let i=0; i<checkCnt; i++) {
               console.log("확인용 제품번호: " + g_codeArr[i] + " 잔고량: " + g_qtyArr[i] + 주문량: " + oqtyArr[i] + ", 장바구니번호 : " + cartnoArr[i] + ", 주문금액: " + totalPriceArr[i] + ", 포인트: " + totalPointArr[i]);
            /*
				확인용 제품번호: 300, 주문량: 1, 장바구니번호 : 24, 주문금액: 230000, 포인트: 0
				확인용 제품번호: 332, 주문량: 5, 장바구니번호 : 17, 주문금액: 230000, 포인트: 100
            */
            
           }// end of for---------------------------
           --%>
          
           for(let i=0; i<checkCnt; i++) {
               if(Number(g_qtyArr[i]) < Number(oqtyArr[i])) {
                  // 주문할 제품중 아무거나 하나가 잔고량이 주문량 보다 적을 경우
                  
                  alert("제품번호 "+ g_codeArr[i] +" 의 주문개수가 잔고개수 보다 더 커서 진행할 수 없습니다.");
               location.href="javascript:history.go(0)";
               return; // goOrder 함수 종료
               } 
            }// end of for---------------------------
           
           
          // , 을 기준으로 합쳤다. 
          const g_code_join = g_codeArr.join();
          const oqty_join = oqtyArr.join();
          const cartno_join = cartnoArr.join();
          const totalPrice_join = totalPriceArr.join();
          const totalPoint_join = totalPointArr.join();
		  
          let sum_totalPrice = 0;
          for(var i=0; i<totalPriceArr.length; i++) {
              sum_totalPrice += parseInt(totalPriceArr[i]);
          }

          let sum_totalPoint = 0;
          for(var i=0; i<totalPointArr.length; i++) {
              sum_totalPoint += parseInt(totalPointArr[i]);
          }
          
          const currentcoin = ${sessionScope.loginuser.user_coin};
      	  <%--
          console.log("확인용 g_code_join : " + g_code_join);         // 확인용 g_codejoin : 300,332
          console.log("확인용 oqty_join : " + oqty_join);             // 확인용 oqtyjoin : 1,5
          console.log("확인용 cartno_join : " + cartno_join);         // 확인용 cartnojoin : 24,17
          console.log("확인용 totalPrice_join : " + totalPrice_join); // 확인용 totalPricejoin : 230000,230000
          console.log("확인용 totalPoint_join : " + totalPoint_join); // 확인용 totalPointjoin : 0,100 옵션포인트 해야될 것 같아. 
          console.log("확인용 sum_totalPrice : " + sum_totalPrice);   // 확인용 sumtotalPrice : 460000
          console.log("확인용 sum_totalPoint : " + sum_totalPoint);   // 확인용 sumtotalPoint : 100
          console.log("확인용 currentcoin : " + currentcoin);       // 확인용 currentcoin : 6100
		  --%>      
          
          const str_sum_totalPrice = sum_totalPrice.toLocaleString('en'); // 자바스크립트에서 숫자 3자리마다 콤마 찍어주기  
          const str_currentcoin = currentcoin.toLocaleString('en');     // 자바스크립트에서 숫자 3자리마다 콤마 찍어주기 
          
          <%-- 보유 포인트가 얼마 있습니다 사용하시고 결제 하시겠습니까?
          
          if(sum_totalPrice > currentcoin ) {
              $("p#order_error_msg").html("코인잔액이 부족하므로 주문이 불가합니다.<br>주문총액 : "+str_sum_totalPrice+"원 / 코인잔액 : "+str_currentcoin+"원").css('display',''); 
              return;
          }
          --%>
          
          //else {
              
        	  $("p#order_error_msg").css('display','none'); 
              const bool = confirm("총주문액 : "+str_sum_totalPrice+"원 결제하시겠습니까?");
              
              if(bool) {	
                    $("div.loader").show(); // CSS 로딩화면 보여주기
                  
                    $.ajax({
                        url:"<%= request.getContextPath()%>/buy/orderAdd.bz",
                        type:"POST",
                        data:{
                           	"sum_totalPrice":sum_totalPrice,
                            "sum_totalPoint":sum_totalPoint,
                            "g_code_join":g_code_join,
                            "oqty_join":oqty_join, 
                            "totalPrice_join":totalPrice_join,
                            "cartno_join":cartno_join
                          
                        },
                        dataType:"JSON",     
                        success:function(json){
                            if(json.isSuccess == 1) {
                                location.href="<%= request.getContextPath()%>/buy/orderList.bz";
                        
                            }
                            else {
                                location.href="<%= request.getContextPath()%>/buy/orderError.bz";
                        
                            }
                     
                        },
                     
                        error: function(request, status, error){
                            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                     
                        }
                  
                    });
               
              } 
            
          //}  
          
       }
      
   }// end of function goOrder()----------------------
   
</script>

<div class="container-fluid" style="border: solid 0px red">
   <div class="my-3">
      <p class="h4 text-center">&raquo;&nbsp;&nbsp;${(sessionScope.loginuser).user_name} [${(sessionScope.loginuser).user_id}]님 장바구니 목록&nbsp;&nbsp;&laquo;</p>
   </div>
   <div>
       <table id="tblCartList" class="mx-auto" style="width: 90%">
         <thead>
            <tr>
             <th style="border-right-style: none;">
                 <input type="checkbox" id="allCheckOrNone" onClick="allCheckBox();" />
                 <span style="font-size: 10pt;"><label for="allCheckOrNone">전체선택</label></span>
             </th>
             <th colspan="5" style="border-left-style: none; font-size: 12pt; text-align: center;">
                 <marquee>주문을 하시려면 먼저 제품번호를 선택하신 후 [주문하기] 를 클릭하세요</marquee>
             </th>
            </tr>
         
            <tr style="background-color: #cfcfcf;">
              <th style="width:10%; text-align: center; height: 30px;">제품번호</th>
              <th style="width:23%; text-align: center;">제품명</th>
                 <th style="width:17%; text-align: center;">현재주문수량</th>
                 <th style="width:20%; text-align: center;">판매가/포인트(개당)</th>
                 <th style="width:20%; text-align: center;">주문총액/총포인트</th>
                 <th style="width:10%; text-align: center;">비우기</th>
            </tr>   
         </thead>
       
         <tbody>
            <c:if test="${empty requestScope.cartList}">
               <tr>
                    <td colspan="6" align="center">
                      <span style="color: red; font-weight: bold;">
                         장바구니에 담긴 상품이 없습니다.
                      </span>
                    </td>   
               </tr>
            </c:if>   
            
            <c:if test="${not empty requestScope.cartList}">
               <c:forEach var="cartvo" items="${requestScope.cartList}" varStatus="status"> 
                   <tr>
                        <td> <%-- 체크박스 및 제품번호 --%>
                             <%-- c:forEach 에서 선택자 id를 고유하게 사용하는 방법  
                                  varStatus="status" 을 이용하면 된다.
                                  status.index 은 0 부터 시작하고,
                                  status.count 는 1 부터 시작한다. 
                             --%> 
                            <input type="checkbox" name="g_code" class="chkbox_g_code" id="g_code${status.index}" value="${cartvo.fk_g_code}" /> &nbsp;<label for="g_code${status.index}">${cartvo.fk_g_code}</label>   
                        	<input type="hidden" name="optinfono" value="${cartvo.opvo.optinfono}" />
                        </td>
                        <td align="center"> <%-- 제품이미지1 및 제품명 --%> 
                           <a href="<%= ctxPath%>>shop/prodView.up?g_code=${cartvo.fk_g_code}">
                              <img src="<%= ctxPath%>/images/${cartvo.gavo.g_img_1}" class="img-thumbnail" width="130px" height="100px" />
                           </a> 
                           <br/><span class="cart_g_code">${cartvo.gavo.g_name}:${cartvo.opvo.opt_name}</span> 
                        </td>
                        <td align="center"> 
                            <%-- 현재주문수량 --%>
                              <input class="spinner oqty" name="oqty" value="${cartvo.oqty}" style="width: 30px; height: 20px;">개
                              <button type="button" class="btn btn-outline-secondary btn-sm updateBtn" onclick="goOqtyEdit(this)">수정</button>
                              
                              <%-- 잔고량 --%>
                              <input type="text" class="g_qty" value="${cartvo.gavo.g_qty}" />
                              
                              <%-- 장바구니 테이블에서 특정제품의 현재주문수량을 변경하여 적용하려면 먼저 장바구니번호(시퀀스)를 알아야 한다 --%>
                              <input type="text" class="cartno" value="${cartvo.cartno}" /> 
                        </td>
                        
                        <td align="right"> <%-- 판매가/포인트(개당) --%> 
                            <fmt:formatNumber value="${cartvo.opvo.opt_sale_price}" pattern="###,###" /> 원<br>
                            <fmt:formatNumber value="${cartvo.gavo.g_coin}" pattern="###,###" /> POINT
                        </td>
                        <td align="right"> <%-- 주문총액/총포인트 --%> 
                            <fmt:formatNumber value="${cartvo.opvo.opt_sale_price}" pattern="###,###" /> 원<br>
                            <fmt:formatNumber value="${cartvo.gavo.g_coin}" pattern="###,###" /> POINT
                            <input type="hidden" class="totalPrice" value="${cartvo.opvo.opt_sale_price}" />
                            <input type="hidden" class="totalPoint" value="${cartvo.gavo.g_coin}" />
                        </td>
                        <td align="center"> <%-- 장바구니에서 해당 특정 제품 비우기 --%> 
                            <button type="button" class="btn btn-outline-danger btn-sm" onclick="goDel('${cartvo.cartno}')">삭제</button>  
                        </td>
                    </tr>
                 </c:forEach>
            </c:if>   
      
            <tr>
                 <td colspan="3" align="right">
                     <span style="font-weight: bold;">장바구니 총액 :</span>
                  <span style="color: red; font-weight: bold;"><fmt:formatNumber value="${requestScope.sumMap.SUMTOTALPRICE}" pattern="###,###" /></span> 원  
                     <br>
                     <span style="font-weight: bold;">총 포인트 :</span> 
                  <span style="color: red; font-weight: bold;"><fmt:formatNumber value="${requestScope.sumMap.SUMTOTALPOINT}" pattern="###,###" /></span> POINT 
                 </td>
                 <td colspan="3" align="center">
                  <button type="button" class="btn btn-outline-dark btn-sm mr-3" onclick="goOrder()">주문하기</button>
                    <a class="btn btn-outline-dark btn-sm" href="<%= request.getContextPath() %>/shop/mallHomeMore.up" role="button">계속쇼핑</a>
                 </td>
            </tr>

         </tbody>
      </table> 
   </div>
   
    <div>
        <p id="order_error_msg" class="text-center text-danger font-weight-bold h4"></p>
    </div>
    
    <%-- CSS 로딩화면 구현한것--%>
    <div style="display: flex">
    	<div class="loader" style="margin: auto"></div>
    </div>
    
    
 </div>
    
<jsp:include page="../footer_suc.jsp" />  
  