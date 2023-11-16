/**
 * 
 */

 let coinmoney = 0; // 충전금액
 
 let opt_name = "";

 let optno = 0; 
 
 $(document).ready(function(){
	 
     $("td#error").hide(); 
	       
   	 $("input:radio[name='coinmoney']").bind("click", function(e){
			
			coinmoney = $(e.target).val(); // 결제 가격
			opt_name = $(e.target).attr("id");
			optno= $(e.target).attr("class");
   			
   			console.log('옵션번호',optno);
   });
   
   
   
});
  
  
   

 
 
 // "충전결제하기" 를 클릭했을 때 이벤트 처리하기 
 function buygame(ctx_Path , user_id){
	 
 	 const checked_cnt = $("input:radio[name='coinmoney']:checked").length;
 	
 	 //console.log($("input:radio[name='coinmoney']:checked").length);
 	 
	 if(checked_cnt==0){
		 // 결제금액을 선택하지 않았을 경우
		 $("td#error").show();
	 }
	 
	 else{
	   
	   // alert(`${coinmoney}원 결제한다`); 
	   // alert(`확인용 부모창의 함수 호출함\n결제금액 : ${coinmoney}원, 사용자id : ${user_id} 상품이름 : ${optname}`);
		
	   // 포트원(아임포트) 결제 팝업창 띄우기
	   // 코인충전 결제금액 선택하기 팝업창 띄우기
	   const url = `${ctx_Path}/buysuccess.bz?coinmoney=${coinmoney}&user_id=${user_id}&opt_name=${opt_name}`;  
	
	   //너비 100, 높이 600 인 팝업창을 화면 가운데 위치시키기
	   const width = 1000;
	   const height = 600;
	   
	   console.log("모니터의 넓이 :", window.screen.width);
	   // 모니터의 넓이 : 1920
	   console.log("모니터의 높이 :", window.screen.height);
	   // 모니터의 높이 : 1080
	   
	   const left = Math.ceil((window.screen.width - width)/2) ;
	   const top = Math.ceil(( window.screen.height - height)/2) ;
	   window.open(url, "buygame", 
	              `left=${left}, top=${top}, width=${width}, height=${height}`);   //\을 빼면 저장소인 request.scope로 인식하기 때문에 앞에다 넣어줘야 한다. 변수로 인식해야한다.
	
	   window.close 
	 }
	  		 
	 
 }
 
  // ==== DB 상의 tbl_member 테이블에 해당 사용자의 코인금액 및 포인트를 증가(update)시켜주는 함수 === //
 function buy_DB_Update(user_id, coinmoney) {
   
 	//console.log(`~~ 확인용 userid : ${user_id}, coinmoney : ${coinmoney}원`);
 	
    const frm = document.coin_DB_Update_Frm;
    frm.user_id.value = user_id;
    frm.coinmoney.value = coinmoney;
     
    frm.action = `/SemiProject/buy/buyUpdateUser.bz`;
    frm.method="post";
    frm.submit();
   
}

 // *** 장바구니 담기 ***//
   function goCart() {
   	
   
 	 // === 주문량에 대한 유효성 검사하기 === //
     const frm = document.goCartFrm;
     
/////////////////////////////////////////////////////////////////     
     
     const regExp = /^[0-9]+$/;  // 숫자만 체크하는 정규표현식
     let oqty = frm.oqty.value;
     const bool = regExp.test(oqty);
     let g_qty = frm.g_qty.value;
     
     
     // 숫자 이외의 값이 들어온 경우  
     if(!bool) {
         alert("숫자만 입력하세요");
         frm.oqty.value = "1";
         frm.oqty.focus();
         return; // 종료 
      }
      
      // 음수가 들어온 경우
      oqty = parseInt(oqty);
      g_qty = parseInt(g_qty);
      
      if(oqty < 1) {
         alert("주문갯수는 1개 이상이어야 합니다.");
         frm.oqty.value = "1";
         frm.oqty.focus();
         return; // 종료 
      }
      

      if(g_qty < oqty) {
         // 주문개수가 잔고개수 보다 클 경우
         alert("주문개수가 잔고개수 보다 더 커서 진행할 수 없습니다.");
//       alert(g_qty);
//       alert(oqty);
         frm.oqty.value = "1";
         frm.oqty.focus();
         return; // 종료 
      }

//////////////////////////////////////////////////////////////////     
	
	  const checked_cnt = $("input:radio[name='coinmoney']:checked").length;
 	 
	  if(checked_cnt==0){
	      // 결제금액을 선택하지 않았을 경우
		  $("td#error").show();
	 
	 }
    
    else{
		
	    const g_code = frm.g_code.value;	
	   	
	   	frm.paymoney.value = coinmoney; // id 로 받아온값
	   	frm.optno.value = optno;		// 클래스로 받아온값
	   	
	   	let paymoney = frm.paymoney.value;
	   	
	    alert("주문연결" + oqty+ opt_name + g_code+ paymoney+"이거"+optno); 	
	  	alert("결제금액"+ paymoney ); 	
      
  	    // 주문개수가 1개 이상인 경우
    
        frm.method = "POST";
        frm.action = `/SemiProject/buy/cartAdd.bz`;
        frm.submit();
      
      }
   
	}// end of function goCart()-------------------------
   
    function goOneOrder() {
	   
      // === 주문량에 대한 유효성 검사하기 === //
     const frm = document.goCartFrm;
     
/////////////////////////////////////////////////////////////////     
     
     const regExp = /^[0-9]+$/;  // 숫자만 체크하는 정규표현식
     let oqty = frm.oqty.value;
     const bool = regExp.test(oqty);
     let g_qty = frm.g_qty.value;
     
     
     // 숫자 이외의 값이 들어온 경우  
     if(!bool) {
         alert("숫자만 입력하세요");
         frm.oqty.value = "1";
         frm.oqty.focus();
         return; // 종료 
      }
      
      // 음수가 들어온 경우
      oqty = parseInt(oqty);
      g_qty = parseInt(g_qty);
      
      if(oqty < 1) {
         alert("주문갯수는 1개 이상이어야 합니다.");
         frm.oqty.value = "1";
         frm.oqty.focus();
         return; // 종료 
      }
      

      if(g_qty < oqty) {
         // 주문개수가 잔고개수 보다 클 경우
         alert("주문개수가 잔고개수 보다 더 커서 진행할 수 없습니다.");
//       alert(g_qty);
//       alert(oqty);
         frm.oqty.value = "1";
         frm.oqty.focus();
         return; // 종료 
      }

//////////////////////////////////////////////////////////////////     
	
	  const checked_cnt = $("input:radio[name='coinmoney']:checked").length;
 	 
	  if(checked_cnt==0){
	      // 결제금액을 선택하지 않았을 경우
		  $("td#error").show();
	 
	 }
    
    else{
		
	    const g_code = frm.g_code.value;	
	   	
	   	frm.paymoney.value = coinmoney; // id 로 받아온값
	   	frm.optno.value = optno;		// 클래스로 받아온값
	   	
	   	let paymoney = frm.paymoney.value;
	   	
	    alert("주문연결" + oqty+ opt_name + g_code+ paymoney+"이거"+optno); 	
	  	alert("결제금액"+ paymoney ); 	
      
  	    // 주문개수가 1개 이상인 경우
    
        frm.method = "POST";
        frm.action = `/SemiProject/buy/oneOrder.bz`;
        frm.submit();
      
      }
   
   }// end of function goCart()-------------------------
  
   
 
 
 
 
 
 