  function goCard(ctxpath){
	  
      const requiredInfo_list = document.querySelectorAll("input.requiredInfo"); 
      for(let i=0; i<requiredInfo_list.length; i++){
      const val = requiredInfo_list[i].value.trim();
      if(val == "") {
          alert("주문자 정보/ 배송지를 전부 입력하세요");
          b_requiredInfo = true;
          break; 
      }
   }// end of for-----------------------------
   
   // *** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 *** //
   const order_zipcode = $("input#order_zipcode").val().trim();
   const order_address = $("input#order_address").val().trim();
   const order_detail_address = $("input#order_detailaddress").val().trim();
   
   if(order_zipcode == "" || order_address == "" || order_detail_address == "") {
      alert("우편번호 및 주소를 입력하셔야 합니다.");
      return; // goRegister() 함수를 종료한다.
   }
   // *** 우편번호 및 주소에 값을 입력했는지 검사하기 끝 *** //
	  
      var ALLtotalPrice = $("input.ALLtotalPoint").val();
	  var user_id = $("input.user_id").val();
	  var user_coin = $("input.user_coin").val();
	  var user_name = $("input.user_name").val();
	  
	  var realpaymoney = parseInt(ALLtotalPrice) - parseInt(user_coin);
	  
	  console.log("ALLtotalPrice:", ALLtotalPrice);
	  console.log("user_coin:", user_coin);
	  console.log("user_name",user_name);
	  console.log("realpaymoney:", realpaymoney);
	  
	  alert(ALLtotalPrice + user_id + user_coin + " 이게 떠야된다. "+ realpaymoney  + " 입니다." + user_name);

 	  const width = 1200;
 	  const height = 800;
	  
 	  const left = Math.ceil((window.screen.width - width)/2) ;
	  const top = Math.ceil(( window.screen.height - height)/2) ;
	  
	  // URL에 변수를 추가하여 URL 문자열을 구성합니다.
	  var url = `${ctxpath}payend.bz?realpaymoney=${realpaymoney}&user_id=${user_id}&user_name=${user_name}`;
	  
	  console.log(url);
	  
	  window.open(url, "buygame", 
	              `left=${left}, top=${top}, width=${width}, height=${height}`);
 	   		
 	  // 포트원(아임포트) 결제 팝업창 띄우기
 	  // 코인충전 결제금액 선택하기 팝업창 띄우기
 	  
  }
  
  
  
  