<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
   String ctxPath = request.getContextPath();
    //     /MyMVC
%>


<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/shop/likeshop.css"> 


<style>


body {
  background-color: white;
}


</style>



<jsp:include page="../header_suc.jsp" />
   
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
      $(".chkbox_optinfono").click(function(){
         
         let bFlag = false;
         $(".chkbox_optinfono").each(function(){
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
      
      $(".chkbox_optinfono").prop("checked", bool);
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
      
      const opt_qty = $("input.opt_qty").eq(index).val();  // 잔고개수
      alert("주문량 : "+ oqty + ", 잔고량 : " + opt_qty);
  	  alert(typeof oqty + " , " + typeof opt_qty)	
      
  	  //   !!! 조심할 것 !!! //
  	  //   if(oqty > pqty) { 으로 하면 꽝됨!! 왜냐하면 string 타입으로 비교하기에
  	  //   if("2" > "19") {  참이됨
  	  //   if(2 > 19) {  거짓이됨     
      if(Number(oqty) > Number(opt_qty)) {
         alert("주문개수가1"+ oqty +"잔고개수1" +opt_qty+ "보다 더 커서 진행할 수 없습니다.");
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
	   
      const g_name = $(event.target).parent().parent().find("span.cart_optinfono").text();
   
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
       const checkCnt = $("input:checkbox[name='optinfono']:checked").length;
       
       if(checkCnt < 1) {
           alert("주문하실 제품을 선택하세요!!");
           return; // 종료 
       }
       
       else {
           //// == 체크박스에서 체크된 value값(checked 속성이용) == ////
           ///  == 체크가 된 것만 값을 읽어와서 배열에 넣어준다. /// 
           const allCnt = $("input:checkbox[name='optinfono']").length;
           const optinfonoArr = new Array();      // 또는 const pnumArr = [];
           const oqtyArr = new Array();        // 또는 const oqtyArr = [];
           const opt_qtyArr = new Array();        // 또는 const pqtyArr = [];
           const cartnoArr = new Array();      // 또는 const cartnoArr = [];
           const totalPriceArr = new Array();  // 또는 const totalPriceArr = [];
           const totalPointArr = new Array();  // 또는 const totalPointArr = [];
             
           for(let i=0; i<allCnt; i++) {
                
        	   if( $("input:checkbox[name='optinfono']").eq(i).prop("checked") ) {
					
        		   
        		   console.log("제품번호 : " , $("input:checkbox[name='optinfono']").eq(i).val() ); 
        		   console.log("주문량 : " , $("").eq(i).val() );
        		   console.log("잔고량 : " ,  $("input.opt_qty").eq(i).val() );
        		   console.log("삭제해야할 장바구니 번호 : " + $("input.cartno").eq(i).val() ); 
                   console.log("주문한 제품의 개수에 따른 가격합계 : " , $("input.totalPrice").eq(i).val() );
                   console.log("주문한 제품의 개수에 따른 포인트합계 : " , $("input.totalPoint").eq(i).val() );
                   console.log("======================")
          		               <%--윗 줄 불린타입이 나온다.       
                   
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
                   
                  optinfonoArr.push( $("input:checkbox[name='optinfono']").eq(i).val() );
                  oqtyArr.push( $("input.oqty").eq(i).val() );
                  opt_qtyArr.push( $("input.opt_qty").eq(i).val() );
                  cartnoArr.push( $("input.cartno").eq(i).val() );
                  totalPriceArr.push( $("input.totalPrice").eq(i).val() );
                  totalPointArr.push( $("input.totalPoint").eq(i).val() ); 
               
               } // end of if -----
            
           }// end of for---------------------------
           
           <%-- 확인용입니다.
           for(let i=0; i<checkCnt; i++) {
               console.log("확인용 제품번호: " + optinfonoArr[i] + " 잔고량: " + opt_qtyArr[i] + 주문량: " + oqtyArr[i] + ", 장바구니번호 : " + cartnoArr[i] + ", 주문금액: " + totalPriceArr[i] + ", 포인트: " + totalPointArr[i]);
            /*
				확인용 제품번호: 300, 주문량: 1, 장바구니번호 : 24, 주문금액: 230000, 포인트: 0
				확인용 제품번호: 332, 주문량: 5, 장바구니번호 : 17, 주문금액: 230000, 포인트: 100
            */
            
           }// end of for---------------------------
           --%>
          
   
           for(let i=0; i<checkCnt; i++) {
               if(Number(opt_qtyArr[i]) < Number(oqtyArr[i])) {
                  // 주문할 제품중 아무거나 하나가 잔고량이 주문량 보다 적을 경우
                  
                  alert("제품번호 "+ optinfonoArr[i] +" 의 주문개수"+ oqtyArr[i] +"가 잔고개수"+ opt_qtyArr[i]  +"보다 더 커서 진행할 수 없습니다.");
               location.href="javascript:history.go(0)";
               return; // goOrder 함수 종료
               } 
            }// end of for---------------------------
           
           
          // , 을 기준으로 합쳤다. 
          const optinfono_join = optinfonoArr.join();
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
          console.log("확인용 optinfono_join : " + optinfono_join);         // 확인용 optinfonojoin : 300,332
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
                            "optinfono_join":optinfono_join,
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
   
   
   function goOrderinfo() {
	   const ctxPath = '<%= ctxPath %>';
	   const url = ctxPath+'/buy/orderinfo.bz';
	   window.open(url, "goOrderinfo");
   
   }
	   
   
   
   
   
   
   
   
 
   
   
   
   
   
   
   
   
   
   
   
   
</script>






	
	<div class="container-fluid mt-5" style="border: solid 0px red">
	
	  	<%-- 캐러셀 시작 --%>
		<div id="carousel_slide" class="carousel slide carousel-fade mt-5" data-ride="carousel" style="width:100%; margin:0 0 0 0">
			<%-- 캐러셀 이너 --%>
		<div class="row col-12 mx-auto mt-5">
			<div class="carousel-inner mt-5">
		
			<div class="carousel-item active">
				<img style="height:400px; width:100%;" src="<%= ctxPath %>/img/tbl_game_product_image/cartmain.jpg" class="img-fluid">
			</div>
			
			<div class="carousel-item">
		    	<img style="height:400px; width:100%;" src="<%= ctxPath%>/img/tbl_game_product_image/ovwt_sm_5.jpg" class="img-fluid">
		    </div>
			
			<div class="carousel-item">
		    	<img style="height:400px; width:100%;" src="<%= ctxPath%>/img/tbl_game_product_image/ovwt_sm_6.jpg" class="img-fluid">
		    </div>
		         
		</div>
			
		<%-- 캐러셀 이너 끝 --%>
		<%--캐러셀(Carousel)의 화살표 컨트롤--%>	
		<a class="carousel-control-prev" href="#carousel_slide" role="button" data-slide="prev">
	    	<span class="carousel-control-prev-icon"></span>
	        <span class="sr-only">Previous</span>
	    </a>
	    <a class="carousel-control-next" href="#carousel_slide" role="button" data-slide="next">
	    	<span class="carousel-control-next-icon"></span>
	        <span class="sr-only">Next</span>
	    </a>
		<%--캐러셀(Carousel)의 화살표 컨트롤--%>
				
		</div>
	</div>
	<%-- 캐러셀 끝 --%>
	
	
	<div class="my-3 text-center">
		<a class="h3 ">${(sessionScope.loginuser).user_name}님 이런 상품은 어떠세요? 다시 상점으로 이동합니다.</a>
		<br><br>
		<p class="h4 text-center">${(sessionScope.loginuser).user_name} [${(sessionScope.loginuser).user_id}]님 장바구니 목록</p>
	</div>
	
	
	
	<section class="cart">
	    
	    <div class="cart__information">
	        <ul>
	            <li>장바구니 상품은 최대 30일간 저장됩니다.</li>
	            <li>가격, 옵션 등 정보가 변경된 경우 주문이 불가할 수 있습니다.</li>
	            <li>오늘출발 상품은 판매자 설정 시점에 따라 오늘출발 여부가 변경될 수 있으니 주문 시 꼭 다시 확인해 주시기 바랍니다.</li>
	        </ul>
	    </div>
	    <table class="cart__list">
	
	        <thead>
	            <tr>
	               <td><input type="checkbox" id="allCheckOrNone" onclick="allCheckBox();"></td>
	               <td colspan="2">상품정보</td>
	               <td>옵션</td>
	               <td>상품금액</td>
	               <td>주문총액/총포인트</td>
	               <td>삭제하기</td>
	        	</tr>
	        </thead>
	        
	        <tbody>
	            
	    <c:if test="${empty requestScope.cartList}">
	 		<tr>
	 			<td colspan="7" align="center">
	   			<span style="color: red; font-weight: bold;">
	      		장바구니에 담긴 상품이 없습니다.
	   			</span>
	 			</td>   
	 		</tr>
	 	</c:if>   
	 	
	 	<c:if test="${not empty requestScope.cartList}">
	 		<c:forEach var="cartvo" items="${requestScope.cartList}" varStatus="status"> 
			
			  <tr class="cart__list__detail">
						
						<td><input type="checkbox" name="optinfono" class="chkbox_optinfono optinfono" id="optinfono${status.index}" value="${cartvo.fk_optno}" /></td>
                        
                        <td><img src="<%= ctxPath%>/img/tbl_game_product_image/${cartvo.opvo.imgfile}" alt=""></td> 
                                               
                        <td><a href="#">${cartvo.gavo.g_name}</a>
	                        <span class="cart__list__smartstore cart_optinfono">${cartvo.gavo.g_content}</span>
	                        <p>${cartvo.opvo.opt_name}</p>
	                        <span class="price">${cartvo.opvo.opt_sale_price}</span>
	                        <span style="text-decoration: line-through; color: lightgray;">${cartvo.opvo.opt_price}</span>
                        </td>
                        
                  
                        <td class="cart__list__option">
                            <p><input class="spinner oqty" name="oqty" value="${cartvo.oqty}" style="width: 14px; height: 14px;">&nbsp;개</p>
                            <button class="cart__list__optionbtn updateBtn" onclick="goOqtyEdit(this)">주문수량 추가/변경${cartvo.fk_optno}</button>
                        	<%-- 잔고량 --%>                        	
                        	<input type="text" class="opt_qty" value="${cartvo.opvo.opt_qty}" /> 
                              
                        	<%-- 장바구니 테이블에서 특정제품의 현재주문수량을 변경하여 적용하려면 먼저 장바구니번호(시퀀스)를 알아야 한다 --%>
                        	<input type="text" class="cartno" value="${cartvo.cartno}" /> 
                        
                        </td>
                        
                        <td>
                        	<fmt:formatNumber value="${cartvo.opvo.opt_sale_price}" pattern="###,###" />원
                        	<br><br>
                        	<fmt:formatNumber value="${cartvo.gavo.g_coin}" pattern="###,###" />POINT
                        </td>
                       
                        <td> <%-- 주문총액/총포인트 --%> 
	                		<fmt:formatNumber value="${cartvo.opvo.opt_totalPrice}" pattern="###,###" /> 원<br>
	                    	<fmt:formatNumber value="${cartvo.gavo.g_totalPoint}" pattern="###,###" /> POINT
	                   		<input type="hidden" class="totalPrice" value="${cartvo.opvo.opt_totalPrice}" />
	                    	<input type="hidden" class="totalPoint" value="${cartvo.gavo.g_totalPoint}" />
	                	</td>
          
                        <td><button type="button" class="cart__list__optionbtn" onclick="goDel('${cartvo.cartno}')">삭제</button></td>
                    </tr>
                    
			</c:forEach>		   	
		</c:if>
		
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
	
        <div class="cart__mainbtns">         	
        	<button class="cart__bigorderbtn left">쇼핑 계속하기</button>
        	<button type="button" class="cart__bigorderbtn right" onclick="goOrder()">주문하기</button>
	   		<button type="button" class="cart__bigorderbtn right" onclick="goOrderinfo()">주문정보입력하기</button>
        </div>
        
        
	</section>
	
    <div>
  		<p id="order_error_msg" class="text-center text-danger font-weight-bold h4"></p>
    </div>
    
    <%-- CSS 로딩화면 구현한것--%>
    <div style="display: flex">
    	<div class="loader" style="margin: auto"></div>
    </div>
    
    
 </div>
    
<jsp:include page="../footer_suc.jsp" />  
  