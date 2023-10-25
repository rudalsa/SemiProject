/**
 * 
 */

 let coinmoney = 0; // 충전금액
 
 let optname = "";
 
 
 $(document).ready(function(){
	 
     $("td#error").hide(); 
	       
   	 $("input:radio[name='coinmoney']").bind("click", function(e){
			
			coinmoney = $(e.target).val(); // 결제 가격
			optname = $(e.target).attr("id");
      		console.log(coinmoney);
    		console.log(optname);
   });
   
   });
   

 
 
 // "충전결제하기" 를 클릭했을 때 이벤트 처리하기 
 function goCoinPayment(ctx_Path , user_id){
	 
	 	 const checked_cnt = $("input:radio[name='coinmoney']:checked").length;
	 	
	 	 //console.log($("input:radio[name='coinmoney']:checked").length);
	 	 
		 if(checked_cnt==0){
			 // 결제금액을 선택하지 않았을 경우
			 $("td#error").show();
		 }
		 
		 else{
		   // 결제하러 들어간다.
		   // alert(`${coinmoney}원 결제한다`);
		   
		   alert(`확인용 부모창의 함수 호출함\n결제금액 : ${coinmoney}원, 사용자id : ${user_id} 상품이름 : ${optname}`);
			
			
			
		   // 포트원(아임포트) 결제 팝업창 띄우기
		   // 코인충전 결제금액 선택하기 팝업창 띄우기
		   const url = `${ctx_Path}/coinPurchaseEnd.bz?coinmoney=${coinmoney}&user_id=${user_id}`;  
		
		   //너비 100, 높이 600 인 팝업창을 화면 가운데 위치시키기
		   const width = 1000;
		   const height = 600;
		   
		   console.log("모니터의 넓이 :", window.screen.width);
		   // 모니터의 넓이 : 1920
		   console.log("모니터의 높이 :", window.screen.height);
		   // 모니터의 높이 : 1080
		   
		   const left = Math.ceil((window.screen.width - width)/2) ;
		   const top = Math.ceil(( window.screen.height - height)/2) ;
		   window.open(url, "coinPurchaseTypeChoiceEnd", 
		              `left=${left}, top=${top}, width=${width}, height=${height}`);   //\을 빼면 저장소인 request.scope로 인식하기 때문에 앞에다 넣어줘야 한다. 변수로 인식해야한다.
		
		   
		 }
		 
	 
 }
 
 
 
 
 
 