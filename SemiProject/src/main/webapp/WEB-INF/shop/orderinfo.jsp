<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String ctxPath = request.getContextPath(); 
%>
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/shop/likeshop.css"> 
<script type="text/javascript" src="<%= ctxPath%>/js/buy/newpay.js"></script>
<<<<<<< HEAD
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
=======
<<<<<<< HEAD
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
=======
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<style>

<<<<<<< HEAD
body{
	color:white;
=======
<<<<<<< HEAD
body{
	color:white;
=======

body > section > table > tbody > tr > td.cart__list__option{

text-align: center;
vertical-align: middle; /* 세로 중앙 정렬 */

>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
}

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
body > section > table > tbody > tr > td.cart__list__option{

text-align: center;
vertical-align: middle; /* 세로 중앙 정렬 */

}
=======
#cart__bigorderbtn{
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<<<<<<< HEAD
#cart__bigorderbtn{
=======
<<<<<<< HEAD
#cart__bigorderbtn{
=======
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
	text-align: center;
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<<<<<<< HEAD
	text-align: center;
=======
<<<<<<< HEAD
	text-align: center;
=======
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<<<<<<< HEAD
=======
=======
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
}


</style>

<script type="text/javascript">

//제품번호의 모든 체크박스가 체크가 되었다가 그 중 하나만 이라도 체크를 해제하면 전체선택 체크박스에도 체크를 해제하도록 한다.

$(document).ready(function(){
	
	$(document).ready(function() {
	    // 모든 체크박스 숨기기
	    $("input:checkbox").hide();
	});
	
	
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


<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
}); // end of $(document).ready()-------------------------- 다했음
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<<<<<<< HEAD
});
=======
<<<<<<< HEAD
});
=======
//Function declaration
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
function allCheckBox() {
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
   const bool = $("#allCheckOrNone").is(":checked");
   /*
      $("#allCheckOrNone").is(":checked"); 은
        선택자 $("#allCheckOrNone") 이 체크되어지면 true를 나타내고,
        선택자 $("#allCheckOrNone") 이 체크가 해제되어지면 false를 나타내어주는 것이다.
   */
   
   $(".chkbox_optinfono").prop("checked", bool);
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<<<<<<< HEAD
//Function declaration
=======
<<<<<<< HEAD
//Function declaration
=======
}// end of function allCheckBox()------------------------- 다했음

</script>
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git


<<<<<<< HEAD
function allCheckBox() {

   const bool = $("#allCheckOrNone").is(":checked");
   /*
      $("#allCheckOrNone").is(":checked"); 은
        선택자 $("#allCheckOrNone") 이 체크되어지면 true를 나타내고,
        선택자 $("#allCheckOrNone") 이 체크가 해제되어지면 false를 나타내어주는 것이다.
   */
   
   $(".chkbox_optinfono").prop("checked", bool);

}// end of function allCheckBox()------------------------- 다했음




let cnt=2;

//체크박스의 상태 변화(클릭) 이벤트를 처리합니다.
function myinfo(){

=======
<<<<<<< HEAD
function allCheckBox() {

   const bool = $("#allCheckOrNone").is(":checked");
   /*
      $("#allCheckOrNone").is(":checked"); 은
        선택자 $("#allCheckOrNone") 이 체크되어지면 true를 나타내고,
        선택자 $("#allCheckOrNone") 이 체크가 해제되어지면 false를 나타내어주는 것이다.
   */
   
   $(".chkbox_optinfono").prop("checked", bool);

}// end of function allCheckBox()------------------------- 다했음




let cnt=2;

//체크박스의 상태 변화(클릭) 이벤트를 처리합니다.
function myinfo(){

=======












<%-- JSP 페이지 내에서 JavaScript로 세션 스토리지 데이터 처리 --%>
<script>
  // 세션 스토리지에서 데이터 가져오기
  var jsonString  = sessionStorage.getItem("editorderArray");
  
  var editorderArray = JSON.parse(jsonString);
  const arrlength = editorderArray.length; // 제품 배열의 길이
    
    


  
  
  $(document).ready(function(){
  		
	  var ALLtotalPrice= 0;
	  var ALLtotalPoint= 0;

	  // 세션스토리지에 저장된 배열의 길이만큼 상품 정보를 출력한다 시작 
	  
	  let html = "";

	  for (let i = 0; i < arrlength; i++) {
		    
		  	html += '<tr class="cart__list__detail">';
		  	html += '<td><input type="checkbox" name="optinfono" class="chkbox_optinfono optinfono" id="optinfono' + i + '" value="' + editorderArray[i].optionno + '" checked/></td>';
		    html += '<td><img src="' + '<%= ctxPath %>' + '/img/tbl_game_product_image/' + editorderArray[i].optionimgfile + '" alt=""></td>';
		    
		    html += '<td><a href="#">'+editorderArray[i].gamename+'</a>';
		    html += '<span class="cart__list__smartstore cart_optinfono">&nbsp;' + editorderArray[i].gamecontent + '</span>';
		    html += '<p>' + editorderArray[i].optionname + '</p>';
		    html += '<span class="price">' + editorderArray[i].optionsaleprice + '</span>';
		    html += '<span style="text-decoration: line-through; color: lightgray;">' + editorderArray[i].optionprice + '</span></td>';
		    
		    html += '<td class="cart__list__option">';
		    html += '<input type="hidden" class="spinner oqty" name="oqty" value="' + editorderArray[i].oqty + '" style="width: 14px; height: 14px;">';
		    html += '<h4>&nbsp;' + editorderArray[i].oqty + '개 </h2>';
		    // html += '<button class="cart__list__optionbtn updateBtn" onclick="goOqtyEdit(this)">' + editorderArray[i].optionno + '</button>'; 버튼 안쓴다.
		    html += '<input type="hidden" class="opt_qty" value="' + editorderArray[i].optionqty + '" />';
		    html += '<input type="hidden" class="cartno" value="' + editorderArray[i].cartnumber + '" />';
		    html += '</td>';
		    
		    html += '<td>';
		    html += '' + editorderArray[i].optionsaleprice + '&nbsp;원<br><br>';
		    html += '' + editorderArray[i].gcoin + '&nbsp;POINT';
		    html += '</td>';

		    html += '<td>';
		    html += '' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].optionsaleprice)) + ' 원<br><br>';
		    html += '' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].gcoin)) + ' POINT';
		    html += '<input type="hidden" class="totalPrice" value="' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].optionsaleprice)) + '" />';
		    html += '<input type="hidden" class="totalPoint" value="' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].gcoin)) + '" />';
		    html += '</td>';
			
			ALLtotalPrice += (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].optionsaleprice)) ;
			ALLtotalPoint += (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].gcoin)) ;
		    
		    
		    html += '<td><button type="button" class="cart__list__optionbtn" onclick="goDel(' + editorderArray[i].cartnumber + ')">삭제</button></td>';
		    
		    
		    // 이곳에 원하는 데이터를 추가하세요.
		    html += '</tr>';
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
		
<<<<<<< HEAD
    console.log(cnt);
  
  if(cnt%2 == 0){
	  cnt++
	  $("input[name='order_name']").val("${sessionScope.loginuser.user_name}");
	  $("input[name='order_phone']").val("${sessionScope.loginuser.user_phone}");
	  $("input[name='order_zipcode']").val("${sessionScope.loginuser.user_zipcode}");
	  $("input[name='order_address']").val("${sessionScope.loginuser.user_address}");
	  $("input[name='order_detailaddress']").val("${sessionScope.loginuser.user_detail_address}");
	  $("input[name='order_extraaddress']").val("${sessionScope.loginuser.user_extraaddress}");
	  
  }
  
  else{
	  
	    cnt++
	    $("input[name='order_name']").val("");
        $("input[name='order_phone']").val("");
        $("input[name='order_zipcode']").val("");
        $("input[name='order_address']").val("");
        $("input[name='order_detailaddress']").val("");
        $("input[name='order_extraaddress']").val("");
	  
	  
	  
	  
	  
	  
	  
	  
  }
 
=======
<<<<<<< HEAD
    console.log(cnt);
  
  if(cnt%2 == 0){
	  cnt++
	  $("input[name='order_name']").val("${sessionScope.loginuser.user_name}");
	  $("input[name='order_phone']").val("${sessionScope.loginuser.user_phone}");
	  $("input[name='order_zipcode']").val("${sessionScope.loginuser.user_zipcode}");
	  $("input[name='order_address']").val("${sessionScope.loginuser.user_address}");
	  $("input[name='order_detailaddress']").val("${sessionScope.loginuser.user_detail_address}");
	  $("input[name='order_extraaddress']").val("${sessionScope.loginuser.user_extraaddress}");
	  
  }
  
  else{
	  
	    cnt++
	    $("input[name='order_name']").val("");
        $("input[name='order_phone']").val("");
        $("input[name='order_zipcode']").val("");
        $("input[name='order_address']").val("");
        $("input[name='order_detailaddress']").val("");
        $("input[name='order_extraaddress']").val("");
	  
	  
	  
	  
	  
	  
	  
	  
  }
 
=======
	  }
	  		html += '</tbody>';
	  		html += '<tfoot>';
	  		
	  		html += '<tr>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	 		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td colspan="2" align="center">';
	  		html += '<span style="font-weight: bold;">장바구니 총액 :</span>';
	  		html += '<span class="carttotalprice" style="color: red; font-weight: bold;">' + ALLtotalPrice + ' 원</span>';
	  		html += '<br>';
	  		html += '<span style="font-weight: bold;">총 포인트 :</span>';
	  		html += '<span class="carttotalpoint" style="color: red; font-weight: bold;">' + ALLtotalPoint + ' POINT</span>';
		    html += '<input type="hidden" class="ALLtotalPoint" value="' + ALLtotalPrice + '" />';
		    html += '<input type="hidden" class="ALLtotalPoint" value="' + ALLtotalPoint + '" />';
	  		
	  		
	  		
	  		
	  		html += '</td>';
	  		html += '</tr>';
	  		
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

<<<<<<< HEAD
   
 } 

















</script>














<%-- JSP 페이지 내에서 JavaScript로 세션 스토리지 데이터 처리 --%>
<script>
  // 세션 스토리지에서 데이터 가져오기
  var jsonString  = sessionStorage.getItem("editorderArray");
  
  var editorderArray = JSON.parse(jsonString);
  const arrlength = editorderArray.length; // 제품 배열의 길이
    
    


  
  
  $(document).ready(function(){
  		
	  var ALLtotalPrice= 0;
	  var ALLtotalPoint= 0;

	  // 세션스토리지에 저장된 배열의 길이만큼 상품 정보를 출력한다 시작 
	  
	  let html = "";

	  for (let i = 0; i < arrlength; i++) {
		    
		  	html += '<tr class="cart__list__detail">';
		  	html += '<td><input type="checkbox" name="optinfono" class="chkbox_optinfono optinfono" id="optinfono' + i + '" value="' + editorderArray[i].optionno + '" checked/></td>';
		    html += '<td><img src="' + '<%= ctxPath %>' + '/img/tbl_game_product_image/' + editorderArray[i].optionimgfile + '" alt=""></td>';
		    
		    html += '<td><a href="#">'+editorderArray[i].gamename+'</a>';
		    html += '<span class="cart__list__smartstore cart_optinfono">&nbsp;' + editorderArray[i].gamecontent + '</span>';
		    html += '<p>' + editorderArray[i].optionname + '</p>';
		    html += '<span class="price">' + editorderArray[i].optionsaleprice + '</span>';
		    html += '<span style="text-decoration: line-through; color: lightgray;">' + editorderArray[i].optionprice + '</span></td>';
		    
		    html += '<td class="cart__list__option">';
		    html += '<input type="hidden" class="spinner oqty" name="oqty" value="' + editorderArray[i].oqty + '" style="width: 14px; height: 14px;">';
		    html += '<h4>&nbsp;' + editorderArray[i].oqty + '개 </h4>';
		    // html += '<button class="cart__list__optionbtn updateBtn" onclick="goOqtyEdit(this)">' + editorderArray[i].optionno + '</button>'; 버튼 안쓴다.
		    html += '<input type="hidden" class="opt_qty" value="' + editorderArray[i].optionqty + '" />';
		    html += '<input type="hidden" class="cartno" value="' + editorderArray[i].cartnumber + '" />';
		    html += '</td>';
		    
		    html += '<td>';
		    html += '' + editorderArray[i].optionsaleprice + '&nbsp;원<br><br>';
		    html += '' + editorderArray[i].gcoin + '&nbsp;POINT';
		    html += '</td>';

		    html += '<td>';
		    html += '' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].optionsaleprice)) + ' 원<br><br>';
		    html += '' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].gcoin)) + ' POINT';
		    html += '<input type="hidden" class="totalPrice" value="' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].optionsaleprice)) + '" />';
		    html += '<input type="hidden" class="totalPoint" value="' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].gcoin)) + '" />';
		    html += '</td>';
			
			ALLtotalPrice += (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].optionsaleprice)) ;
			ALLtotalPoint += (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].gcoin)) ;
		    
		    
		    html += '<td><button type="button" class="cart__list__optionbtn" onclick="goDel(' + editorderArray[i].cartnumber + ')">삭제</button></td>';
		    
		    
		    // 이곳에 원하는 데이터를 추가하세요.
		    html += '</tr>';
		
	  }
	  		html += '</tbody>';
	  		html += '<tfoot>';
	  		
	  		html += '<tr>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	 		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td colspan="2" align="center">';
	  		html += '<span style="font-weight: bold;">장바구니 총액 :</span>';
	  		html += '<span class="carttotalprice" style="color: red; font-weight: bold;">' + ALLtotalPrice + ' 원</span>';
	  		html += '<br>';
	  		html += '<span style="font-weight: bold;">총 포인트 :</span>';
	  		html += '<span class="carttotalpoint" style="color: red; font-weight: bold;">' + ALLtotalPoint + ' POINT</span>';
		    html += '<input type="hidden" class="ALLtotalPoint" value="' + ALLtotalPrice + '" />';
		    html += '<input type="hidden" class="ALLtotalPoint" value="' + ALLtotalPoint + '" />';
	  		
	  		
	  		
	  		
	  		html += '</td>';
	  		html += '</tr>';
	  		

	  		html += '<tr>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	 		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td colspan="2" align="center">';
	  		html += '<button type="button" class="cart__bigorderbtn right" onclick="goOrder()">주문하기</button>';
	  		html += '<button type="button" class="cart__bigorderbtn right" onclick="goCard('+'<%= ctxPath %>/'+')">결제하기</button>';
	  		html += '</td>';
	  		
	  		
	  		
	  		
	  		html += '</tfoot>';
	  		html += '</table>';
			

		        	
			  		
	  		

			// 적절한 요소에 HTML을 추가하려면 해당 요소를 선택하고 innerHTML을 사용합니다.
			document.querySelector('.in').innerHTML += html;

	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
  });  
  
  
  
  // Function declaration
 
//=== 장바구니에서 제품 주문하기 === // 
  function goOrder() {
    
  	  //  alert("클릭되었습니다.");
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
             // const bool = confirm("총주문액 : "+str_sum_totalPrice+"원 결제하시겠습니까?");
             bool = true;
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
                           "cartno_join":cartno_join,
                           "order_name":$("input#order_name").val(),
                           "order_phone":$("input#order_phone").val(),
                           "order_zipcode":$("input#order_zipcode").val(),
                           "order_address":$("input#order_address").val(),
                           "order_detailaddress":$("input#order_detailaddress").val(),
                           "order_extraaddress":$("input#order_extraaddress").val(),
                           "order_content":$("textarea#order_content").val()
                       
                       
                       
                       
                       
                       
                       
                       
                       
      
=======
<<<<<<< HEAD
   
 } 

















</script>














<%-- JSP 페이지 내에서 JavaScript로 세션 스토리지 데이터 처리 --%>
<script>
  // 세션 스토리지에서 데이터 가져오기
  var jsonString  = sessionStorage.getItem("editorderArray");
  
  var editorderArray = JSON.parse(jsonString);
  const arrlength = editorderArray.length; // 제품 배열의 길이
    
    


  
  
  $(document).ready(function(){
  		
	  var ALLtotalPrice= 0;
	  var ALLtotalPoint= 0;

	  // 세션스토리지에 저장된 배열의 길이만큼 상품 정보를 출력한다 시작 
	  
	  let html = "";

	  for (let i = 0; i < arrlength; i++) {
		    
		  	html += '<tr class="cart__list__detail">';
		  	html += '<td><input type="checkbox" name="optinfono" class="chkbox_optinfono optinfono" id="optinfono' + i + '" value="' + editorderArray[i].optionno + '" checked/></td>';
		    html += '<td><img src="' + '<%= ctxPath %>' + '/img/tbl_game_product_image/' + editorderArray[i].optionimgfile + '" alt=""></td>';
		    
		    html += '<td><a href="#">'+editorderArray[i].gamename+'</a>';
		    html += '<span class="cart__list__smartstore cart_optinfono">&nbsp;' + editorderArray[i].gamecontent + '</span>';
		    html += '<p>' + editorderArray[i].optionname + '</p>';
		    html += '<span class="price">' + editorderArray[i].optionsaleprice + '</span>';
		    html += '<span style="text-decoration: line-through; color: lightgray;">' + editorderArray[i].optionprice + '</span></td>';
		    
		    html += '<td class="cart__list__option">';
		    html += '<input type="hidden" class="spinner oqty" name="oqty" value="' + editorderArray[i].oqty + '" style="width: 14px; height: 14px;">';
		    html += '<h4>&nbsp;' + editorderArray[i].oqty + '개 </h4>';
		    // html += '<button class="cart__list__optionbtn updateBtn" onclick="goOqtyEdit(this)">' + editorderArray[i].optionno + '</button>'; 버튼 안쓴다.
		    html += '<input type="hidden" class="opt_qty" value="' + editorderArray[i].optionqty + '" />';
		    html += '<input type="hidden" class="cartno" value="' + editorderArray[i].cartnumber + '" />';
		    html += '</td>';
		    
		    html += '<td>';
		    html += '' + editorderArray[i].optionsaleprice + '&nbsp;원<br><br>';
		    html += '' + editorderArray[i].gcoin + '&nbsp;POINT';
		    html += '</td>';

		    html += '<td>';
		    html += '' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].optionsaleprice)) + ' 원<br><br>';
		    html += '' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].gcoin)) + ' POINT';
		    html += '<input type="hidden" class="totalPrice" value="' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].optionsaleprice)) + '" />';
		    html += '<input type="hidden" class="totalPoint" value="' + (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].gcoin)) + '" />';
		    html += '</td>';
			
			ALLtotalPrice += (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].optionsaleprice)) ;
			ALLtotalPoint += (parseInt(editorderArray[i].oqty) * parseInt(editorderArray[i].gcoin)) ;
		    
		    
		    html += '<td><button type="button" class="cart__list__optionbtn" onclick="goDel(' + editorderArray[i].cartnumber + ')">삭제</button></td>';
		    
		    
		    // 이곳에 원하는 데이터를 추가하세요.
		    html += '</tr>';
		
	  }
	  		html += '</tbody>';
	  		html += '<tfoot>';
	  		
	  		html += '<tr>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	 		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td colspan="2" align="center">';
	  		html += '<span style="font-weight: bold;">장바구니 총액 :</span>';
	  		html += '<span class="carttotalprice" style="color: red; font-weight: bold;">' + ALLtotalPrice + ' 원</span>';
	  		html += '<br>';
	  		html += '<span style="font-weight: bold;">총 포인트 :</span>';
	  		html += '<span class="carttotalpoint" style="color: red; font-weight: bold;">' + ALLtotalPoint + ' POINT</span>';
		    html += '<input type="hidden" class="ALLtotalPoint" value="' + ALLtotalPrice + '" />';
		    html += '<input type="hidden" class="ALLtotalPoint" value="' + ALLtotalPoint + '" />';
	  		
	  		
	  		
	  		
	  		html += '</td>';
	  		html += '</tr>';
	  		

	  		html += '<tr>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	 		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td colspan="2" align="center">';
	  		html += '<button type="button" class="cart__bigorderbtn right" onclick="goOrder()">주문하기</button>';
	  		html += '<button type="button" class="cart__bigorderbtn right" onclick="goCard('+'<%= ctxPath %>/'+')">결제하기</button>';
	  		html += '</td>';
	  		
	  		
	  		
	  		
	  		html += '</tfoot>';
	  		html += '</table>';
			

		        	
			  		
	  		

			// 적절한 요소에 HTML을 추가하려면 해당 요소를 선택하고 innerHTML을 사용합니다.
			document.querySelector('.in').innerHTML += html;

	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
  });  
  
  
  
  // Function declaration
 
//=== 장바구니에서 제품 주문하기 === // 
  function goOrder() {
    
  	  //  alert("클릭되었습니다.");
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
             // const bool = confirm("총주문액 : "+str_sum_totalPrice+"원 결제하시겠습니까?");
             bool = true;
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
                           "cartno_join":cartno_join,
                           "order_name":$("input#order_name").val(),
                           "order_phone":$("input#order_phone").val(),
                           "order_zipcode":$("input#order_zipcode").val(),
                           "order_address":$("input#order_address").val(),
                           "order_detailaddress":$("input#order_detailaddress").val(),
                           "order_extraaddress":$("input#order_extraaddress").val(),
                           "order_content":$("textarea#order_content").val()
                       
                       
                       
                       
                       
                       
                       
                       
                       
      
=======
	  		html += '<tr>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td></td>';
	 		html += '<td></td>';
	  		html += '<td></td>';
	  		html += '<td colspan="2" align="center">';
	  		html += '<button type="button" class="cart__bigorderbtn right" onclick="goOrder()">주문하기</button>';
	  		html += '<button type="button" class="cart__bigorderbtn right" onclick="goCard('+'<%= ctxPath %>/'+')">결제하기</button>';
	  		html += '</td>';
	  		
	  		
	  		
	  		
	  		html += '</tfoot>';
	  		html += '</table>';
			

		        	
			  		
	  		

			// 적절한 요소에 HTML을 추가하려면 해당 요소를 선택하고 innerHTML을 사용합니다.
			document.querySelector('.in').innerHTML += html;

	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
  });  
  
  
  
  // Function declaration
 
//=== 장바구니에서 제품 주문하기 === // 
  function goOrder() {
    
  	  //  alert("클릭되었습니다.");
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
             // const bool = confirm("총주문액 : "+str_sum_totalPrice+"원 결제하시겠습니까?");
             bool = true;
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
                         
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
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
	
<jsp:include page="../header_suc.jsp" />	
	
<<<<<<< HEAD
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<input type="hidden" class="user_id" value="${sessionScope.loginuser.user_id}" />
	<input type="hidden" class="user_coin" value="${sessionScope.loginuser.user_coin}" />
	<input type="hidden" class="user_name" value="${sessionScope.loginuser.user_name}" />
	
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
	                <td><input type="checkbox" id="allCheckOrNone" onclick="allCheckBox();" checked></td>
	                <td colspan="2">상품정보</td>
	                <td>주문갯수</td>
	                <td>상품금액</td>
	                <td>주문총액/총포인트</td>
	                <td>배송비</td>
	        	</tr>
	        </thead>
	        
	        <tbody class="in">
	       
		
		
		
		
		
		
		
		
		<div style="margin-top: 10%;">
            

            <div style="position: -webkit-sticky; position: sticky; top: 100px;">
            
               <table class="cart__list">
                  <thead style="font-size: 23pt">
                     <tr>
                        <td colspan="4" class="text-left">주문자 정보/ 배송지</td>
                     </tr>
                  </thead>
                  
                  
                  <tbody style="font-size: 13pt; color: whitesmoke;">
                     <tr>
                        <td width="10%;">주문자명 :</td>
                        <td width="40%;">${sessionScope.loginuser.user_name}</td>
                        <td width="15%;">기본정보<button type="button" onclick="myinfo()">내정보불러오기</button></td>
                        <td width="35%;"><input type="checkbox" id="origin_add" /></td>
                     </tr>
                     <tr>
                        <td width="10%;">E-Mail :</td>
                        <td>${sessionScope.loginuser.user_email}</td>
                        <td>받으실분</td>
                        <td>
                           <input type="text" name="order_name" id="order_name" class="requiredInfo" />
                           <p class="error">실명을 입력해 주세요.</p>
                        </td>
                     </tr>
                     <tr>
                        <td>휴대폰번호 :</td>
                        <td>${sessionScope.loginuser.user_phone}</td>
                        <td>수취인 연락처 </td>
                        <td>
                           <input type="text" name="order_phone" id="order_phone" class="requiredInfo" />
                           <p class="error">하이픈(-)없이 11글자로 입력하세요.</p>
                        </td>
                     </tr>
                     <tr>
                        <td colspan="2"></td>
                        <td>우편번호</td>
                        <td><input type="text" name="order_zipcode" id="order_zipcode" class="zipcodeSearch" size="15" maxlength="11" autocomplete="off"> 
                           <span id="zipcodefind" class="btn btn-primary zipcodeSearch requiredInfo">우편번호찾기</span>
                        </td>
                     </tr>
                     <tr>
                        <td colspan="2"></td>
                        <td>배송지</td>
                        <td>
                           <input type="text" name="order_address" id="order_address" class="zipcodeSearch requiredInfo" size="15" maxlength="20" autocomplete="off"> 
                           <input type="text" name="order_detailaddress" id="order_detailaddress" class="requiredInfo" size="15" maxlength="20" autocomplete="off" placeholder="상세주소"> 
                           <input type="text" name="order_extraaddress" id="order_extraaddress" size="15" maxlength="20" autocomplete="off">
                        </td>
                     </tr>
                     <tr>
                        <td colspan="2"></td>
                        <td>배달요청사항</td>
                        <td><textarea name="order_content" class="requiredInfo" id="order_content"></textarea></td>
                     </tr>
                  </tbody>
               </table>
            
         </div>
      </div>
      

=======
<<<<<<< HEAD
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	<input type="hidden" class="user_id" value="${sessionScope.loginuser.user_id}" />
	<input type="hidden" class="user_coin" value="${sessionScope.loginuser.user_coin}" />
	<input type="hidden" class="user_name" value="${sessionScope.loginuser.user_name}" />
	
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
	                <td><input type="checkbox" id="allCheckOrNone" onclick="allCheckBox();" checked></td>
	                <td colspan="2">상품정보</td>
	                <td>주문갯수</td>
	                <td>상품금액</td>
	                <td>주문총액/총포인트</td>
	                <td>배송비</td>
	        	</tr>
	        </thead>
	        
	        <tbody class="in">
	       
		
		
		
		
		
		
		
		
		<div style="margin-top: 10%;">
            

            <div style="position: -webkit-sticky; position: sticky; top: 100px;">
            
               <table class="cart__list">
                  <thead style="font-size: 23pt">
                     <tr>
                        <td colspan="4" class="text-left">주문자 정보/ 배송지</td>
                     </tr>
                  </thead>
                  
                  
                  <tbody style="font-size: 13pt; color: whitesmoke;">
                     <tr>
                        <td width="10%;">주문자명 :</td>
                        <td width="40%;">${sessionScope.loginuser.user_name}</td>
                        <td width="15%;">기본정보<button type="button" onclick="myinfo()">내정보불러오기</button></td>
                        <td width="35%;"><input type="checkbox" id="origin_add" /></td>
                     </tr>
                     <tr>
                        <td width="10%;">E-Mail :</td>
                        <td>${sessionScope.loginuser.user_email}</td>
                        <td>받으실분</td>
                        <td>
                           <input type="text" name="order_name" id="order_name" class="requiredInfo" />
                           <p class="error">실명을 입력해 주세요.</p>
                        </td>
                     </tr>
                     <tr>
                        <td>휴대폰번호 :</td>
                        <td>${sessionScope.loginuser.user_phone}</td>
                        <td>수취인 연락처 </td>
                        <td>
                           <input type="text" name="order_phone" id="order_phone" class="requiredInfo" />
                           <p class="error">하이픈(-)없이 11글자로 입력하세요.</p>
                        </td>
                     </tr>
                     <tr>
                        <td colspan="2"></td>
                        <td>우편번호</td>
                        <td><input type="text" name="order_zipcode" id="order_zipcode" class="zipcodeSearch" size="15" maxlength="11" autocomplete="off"> 
                           <span id="zipcodefind" class="btn btn-primary zipcodeSearch requiredInfo">우편번호찾기</span>
                        </td>
                     </tr>
                     <tr>
                        <td colspan="2"></td>
                        <td>배송지</td>
                        <td>
                           <input type="text" name="order_address" id="order_address" class="zipcodeSearch requiredInfo" size="15" maxlength="20" autocomplete="off"> 
                           <input type="text" name="order_detailaddress" id="order_detailaddress" class="requiredInfo" size="15" maxlength="20" autocomplete="off" placeholder="상세주소"> 
                           <input type="text" name="order_extraaddress" id="order_extraaddress" size="15" maxlength="20" autocomplete="off">
                        </td>
                     </tr>
                     <tr>
                        <td colspan="2"></td>
                        <td>배달요청사항</td>
                        <td><textarea name="order_content" class="requiredInfo" id="order_content"></textarea></td>
                     </tr>
                  </tbody>
               </table>
            
         </div>
      </div>
      

=======
	<input type="hidden" class="user_id" value="${sessionScope.loginuser.user_id}" />
	<input type="hidden" class="user_coin" value="${sessionScope.loginuser.user_coin}" />
	<input type="hidden" class="user_name" value="${sessionScope.loginuser.user_name}" />
	
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
	                <td><input type="checkbox" id="allCheckOrNone" onclick="allCheckBox();" checked></td>
	                <td colspan="2">상품정보</td>
	                <td>주문갯수</td>
	                <td>상품금액</td>
	                <td>주문총액/총포인트</td>
	                <td>배송비</td>
	        	</tr>
	        </thead>
	        
	        <tbody class="in">
	       
	       
	
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
		
		
		
		
		
		

	
	
	</section>
    </body>

</html>