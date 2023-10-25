
let b_idcheck_click = false;
// "아이디중복확인" 을 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

let b_emailcheck_click = false;
// "이메일중복확인" 을 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도

let b_zipcodeSearch_click = false;
// "우편번호찾기" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도


$(document).ready(function(){
	
	$("input#user_name").blur( (e) => {
		
		
		const regExp_name = /^[가-힣]{2,6}$/;
  		
  		const bool_name = regExp_name.test($(e.target).val());
	    // frm.passwd.value 값이 regExp_passwd 패턴에 맞으면 true,
	    // frm.passwd.value 값이 regExp_passwd 패턴에 틀리면 false
	    
	    if(!bool_name){
			// 입력하지 않거나 공백만 입력했을 경우 
			/*	
			   >>>> .prop() 와 .attr() 의 차이 <<<<	         
		            .prop() ==> form 태그내에 사용되어지는 엘리먼트의 disabled, selected, checked 의 속성값 확인 또는 변경하는 경우에 사용함. 
		            .attr() ==> 그 나머지 엘리먼트의 속성값 확인 또는 변경하는 경우에 사용함.
			*/ 
			$("form#memberRegisterFrm :input").prop("disabled", true);  
			$(e.target).prop("disabled", false); 
			
		    $(e.target).closest(".div1").find("p.error").show();
		     	
			$(e.target).val("").focus(); 
			
		}
		else {
			// 공백이 아닌 글자를 입력했을 경우
			$("form#memberRegisterFrm :input").prop("disabled", false);
			
		    $(e.target).closest(".div1").find("p.error").hide();
		    
		    $("div#useridInput").show();
		    $("input#user_id").focus();
			
		}
		
		
		
		
		
	});// 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
	
	
	$("input#user_id").blur( (e) => {
		
			const regExp_userid = /^[A-Za-z0-9]{4,12}$/;
		    
		    // 위에 생성한 정규표현식 객체에 데이터값을 넣어서 검사를 한다.
		    const bool_userid = regExp_userid.test($(e.target).val());
		    // frm.useid.value 값이 regExp_userid 패턴에 맞으면 true,
		    // frm.useid.value 값이 regExp_userid 패턴에 틀리면 false
			
			if(!bool_userid){
			// 입력하지 않거나 공백만 입력했을 경우 
			
			$("form#memberRegisterFrm :input").prop("disabled", true);  
			$(e.target).prop("disabled", false); 
			
		//	$(e.target).next().next().next().show();
		//  또는
		    $(e.target).closest(".div1").find("p.error").show();
		     	
			$(e.target).val("").focus(); 
		}
		else {
			// 공백이 아닌 글자를 입력했을 경우
			$("form#memberRegisterFrm :input").prop("disabled", false);
			
			//	$(e.target).next().next().next().hide();
		    //  또는
		    $(e.target).closest(".div1").find("p.error").hide();
		    
		    $("div#pwdInput").show();
		    $("input#user_pwd").focus();
		}
		
	});// 아이디가 userid 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
	
	
	$("input#user_pwd").blur( (e) => {
		
	//	const regExp_pwd = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g; 
	//  또는
	    const regExp_pwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g); 
	    // 숫자/문자/특수문자 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성 
	    
	    const bool = regExp_pwd.test($(e.target).val());	
		
		if(!bool) {
			// 암호가 정규표현식에 위배된 경우 
			
			$("form#memberRegisterFrm :input").prop("disabled", true);  
			$(e.target).prop("disabled", false); 
			
		//	$(e.target).next().show();
		//  또는
		    $(e.target).closest(".div1").find("p.error").show();
		     	
			$(e.target).val("").focus(); 
		}
		else {
			// 암호가 정규표현식에 맞는 경우 
			$("form#memberRegisterFrm :input").prop("disabled", false);
			
			//	$(e.target).next().hide();
		    //  또는
		    $(e.target).closest(".div1").find("p.error").hide();
		    
		    $("div#pwdCheckInput").show();
		    $("input#pwdCheck").focus();
		}
		
	});// 아이디가 pwd 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
	
	
	$("input#pwdCheck").blur( (e) => {
		
		if( $("input#user_pwd").val() != $(e.target).val() ) {
			// 암호와 암호확인값이 틀린 경우 
			
			$("form#memberRegisterFrm :input").prop("disabled", true);  
			$("input#user_pwd").prop("disabled", false);
			$(e.target).prop("disabled", false); 
			
		//	$(e.target).next().show();
		//  또는
		    $(e.target).closest(".div1").find("p.error").show();
		    
			$("input#user_pwd").focus();
		}
		else {
			// 암호와 암호확인값이 같은 경우
			$("form#memberRegisterFrm :input").prop("disabled", false);
			
			//	$(e.target).next().hide();
		    //  또는
		    $(e.target).closest(".div1").find("p.error").hide();
		    
		    $("div#emailInput").show();
		    $("input#user_email").focus();
		}
		
	});// 아이디가 pwdcheck 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.	
	
	
	$("input#user_email").blur( (e) => {
		
	//	const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
	//  또는
	    const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);  
	    // 이메일 정규표현식 객체 생성 
	    
	    const bool = regExp_email.test($(e.target).val());	
		
		if(!bool) {
			// 이메일이 정규표현식에 위배된 경우 
			
			$("form#memberRegisterFrm :input").prop("disabled", true);  
			$(e.target).prop("disabled", false); 
			
		//	$(e.target).next().show();
		//  또는
		    $(e.target).closest(".div1").find("p.error").show();
		     	
			$(e.target).val("").focus(); 
		}
		else {
			// 이메일이 정규표현식에 맞는 경우 
			$("form#memberRegisterFrm :input").prop("disabled", false);
			
			//	$(e.target).next().hide();
		    //  또는
		    $(e.target).closest(".div1").find("p.error").hide();
		    
		    $("div#phoneInput").show();
		    $("input#user_phone").focus();
		}
		
	});// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
	
	$("input#user_phone").blur( (e) => {
		
	//	const regExp_hp3 = /^[0-9]{4}$/;  
	//  또는
	//	const regExp_hp3 = /^\d{4}$/;
	    const regExp_user_phone = new RegExp(/^\d{11}$/);  
	    // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성 
	    
	    const bool = regExp_user_phone.test($(e.target).val());		
		
		if(!bool) {
			// 마지막 전화번호 4자리가 정규표현식에 위배된 경우 
			
			$("form#memberRegisterFrm :input").prop("disabled", true);  
			$(e.target).prop("disabled", false); 
			
		//	$(e.target).next().show();
		//  또는
		    $(e.target).closest(".div1").find("p.error").show();
		    
			$(e.target).val("").focus();
		}
		else {
			// 마지막 전화번호 4자리가 정규표현식에 맞는 경우 
			$("form#memberRegisterFrm :input").prop("disabled", false);
			
			//	$(e.target).next().hide();
		    //  또는
		    $(e.target).closest(".div1").find("p.error").hide();
		    
		    
		    $("div#zipcodeInput").show();
		    
		}
		
	});// 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
	
	
	// === "우편번호찾기"를 클릭했을 때 이벤트 처리하기 === //
	$("input#user_zipcode").click(function(){
		
		b_zipcodeSearch_click = true;
		// "우편번호찾기" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도  
		
		// 주소를 쓰기가능 으로 만들기
		$("input#user_address").removeAttr("readonly");
        
        // 참고항목을 쓰기가능 으로 만들기
        $("input#user_extraaddress").removeAttr("readonly");
        
        // 주소를 활성화 시키기
	//	$("input#address").removeAttr("disabled");
        
        // 참고항목을 활성화 시키기
    //  $("input#extraAddress").removeAttr("disabled");
		
		new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("user_extraaddress").value = extraAddr;
                
                } else {
                    document.getElementById("user_extraaddress").value = '';
                }
				
				$("div#addressInput").show();
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('user_zipcode').value = data.zonecode;
                document.getElementById("user_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("user_detail_address").focus();
            }
        }).open();
        
        
        
        // 주소를 읽기전용(readonly) 로 만들기
        $("input#user_address").attr("readonly", true);
        
        // 참고항목을 읽기전용(readonly) 로 만들기
        $("input#user_extraaddress").attr("readonly", true);
        
        // 주소를 비활성화 로 만들기
    //  $("input#address").attr("disabled", true);
        
        // 참고항목을 비활성화 로 만들기
    //  $("input#extraAddress").attr("disabled", true);
    
    	
        
	});// end of $("img#zipcodeSearch").click()------------
	
	
	// === jQuery UI 의 datepicker === //
	$('input#datepicker').datepicker({
             dateFormat: 'yy-mm-dd'  //Input Display Format 변경
            ,showOtherMonths: true   //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true        //콤보박스에서 년 선택 가능
            ,changeMonth: true       //콤보박스에서 월 선택 가능                
        //  ,showOn: "both"          //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
        //  ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
        //  ,buttonImageOnly: true   //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
        //  ,buttonText: "선택"       //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
            ,yearSuffix: "년"         //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
        //  ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        //  ,maxDate: "+1M" //최대 선택일자(+1D:하루후, +1M:한달후, +1Y:일년후)                
     });
     
     // 초기값을 오늘 날짜로 설정
  // $('input#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후) 
	 
	 
	 // === 전체 datepicker 옵션 일괄 설정하기 ===  
	 //     한번의 설정으로 $("input#fromDate"), $('input#toDate')의 옵션을 모두 설정할 수 있다.
     $(function() {
         //모든 datepicker에 대한 공통 옵션 설정
         $.datepicker.setDefaults({
              dateFormat: 'yy-mm-dd' //Input Display Format 변경
             ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
             ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
             ,changeYear: true //콤보박스에서 년 선택 가능
             ,changeMonth: true //콤보박스에서 월 선택 가능                
          // ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시됨. both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시됨.  
          // ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
          // ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
          // ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
             ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
             ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
             ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
             ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
             ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
          // ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
          // ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
         });
  
         // input을 datepicker로 선언
         $("input#fromDate").datepicker();                    
         $("input#toDate").datepicker();
         
         // From의 초기값을 오늘 날짜로 설정
         $('input#fromDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
         
         // To의 초기값을 3일후로 설정
         $('input#toDate').datepicker('setDate', '+3D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
      });
	 
	 ///////////////////////////////////////////////////////////////////////
	 
	 $('input#datepicker').bind("change", (e) => {
		 if( $(e.target).val() != "" ) {
			 $(e.target).next().hide();
		 }
	 });// 생년월일에 마우스로 달력에 있는 날짜를 선택한 경우 이벤트 처리 한것
	
	
	
	
	// "아이디중복확인" 을 클릭했을 때 이벤트 처리하기
	 $("img#idcheck").click(function(){
		 
		 b_idcheck_click = true;
		 
		 $.ajax({
			 url:"idDuplicateCheck.bz",
			 data:{"user_id":$("input#user_id").val()}, 
			 type:"post",  
			 
			 async:true,   
			 
			 dataType:"json",
			  
			 success:function(json){
				 
				 
				 if(json.isExists) {
					 
					 $("p#idcheckResult").html($("input#user_id").val() + " 은 이미 사용중 이므로 다른 아이디를 입력하세요").css({"color":"red"}); 
					 $("input#user_id").val(""); 
				 }
				 else {
					 // 입력한 userid 가 존재하지 않는 경우라면 
					 $("p#idcheckResult").html($("input#user_id").val() + " 은 사용가능 합니다").css({"color":"navy"});  
				 }
				 
			 },
			 
			 error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 }
		 });
		 
	 });// end of $("img#idcheck").click()--------------------
	 
	 
	 // "이메일중복확인" 을 클릭했을 때 이벤트 처리하기
	 $("span#emailcheck").click(function(){
		 
		 b_emailcheck_click = true;
		 
		 
		 $.ajax({
			 url:"emailDuplicateCheck.bz",
			 data:{"user_email":$("input#user_email").val()}, 
			 type:"post",  
			 
			 async:true,   
			 
			 dataType:"json", 
			  
			 success:function(json){
				 
				 if(json.isExists) {
					
					 $("p#emailCheckResult").html($("input#user_email").val() + " 은 이미 사용중 이므로 다른 이메일을 입력하세요").css({"color":"red"}); 
					 $("input#user_email").val(""); 
				 }
				 else {
					 // 입력한 email 이 존재하지 않는 경우라면 
					 $("p#emailCheckResult").html($("input#user_email").val() + " 은 사용가능 합니다").css({"color":"navy"});  
				 }
				 
			 },
			 
			 error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			 }
		 });
		 
	 });
	 
	 
	 // 아이디값이 변경되면 가입하기 버튼을 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도 초기화 시키기 
	 $("input#user_id").bind("change", function(){
		 b_idcheck_click = false;
	 });
	 
	 // 이메일값이 변경되면 가입하기 버튼을 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도 초기화 시키기 
	 $("input#user_email").bind("change", function(){
		 b_emailcheck_click = false;
	 });
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
});// end of $(document).ready(function(){})----------------




// hide된 input태그 꺼내기
function showInputTag(tagName){

	$("div#"+tagName).removeClass("hideInput");
}

// x버튼 누르면 해당 input태그 비우기
function inputClose(inputTag) {
    var tags = inputTag.split(','); // 입력 필드 ID 목록을 쉼표로 구분하여 배열로 변환
    for (var i = 0; i < tags.length; i++) {
        $("input#" + tags[i]).val("");
    }
}



function goRegister() {
	
	// *** 필수입력사항에 모두 입력이 되었는지 검사하기 시작 *** //
	let b_requiredInfo = false;
	
/*	
	$("input.requiredInfo").each(function(index, elmt){
		const data = $(elmt).val().trim();
		if(data == "") {
			alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
		    b_requiredInfo = true;
		    return false; // break; 라는 뜻이다.	
		}
	});
*/ 
//  또는
    const requiredInfo_list = document.querySelectorAll("input.requiredInfo"); 
    for(let i=0; i<requiredInfo_list.length; i++){
		const val = requiredInfo_list[i].value.trim();
		if(val == "") {
			alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
		    b_requiredInfo = true;
		    break; 
		}
	}// end of for-----------------------------
     	
	
	if(b_requiredInfo) {
		return; // goRegister() 함수를 종료한다.
	}
	// *** 필수입력사항에 모두 입력이 되었는지 검사하기 끝 *** //
	
	
	// *** "아이디중복확인" 을 클릭했는지 검사하기 시작 *** //
	if(!b_idcheck_click) {
		// "아이디중복확인" 을 클릭 안 했을 경우
		alert("아이디 중복확인을 클릭하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}
	// *** "아이디중복확인" 을 클릭했는지 검사하기 끝 *** //	
	
	
	// *** "이메일중복확인" 을 클릭했는지 검사하기 시작 *** //
	if(!b_emailcheck_click) {
		// "이메일중복확인" 을 클릭 안 했을 경우
		alert("이메일 중복확인을 클릭하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}
	// *** "이메일중복확인" 을 클릭했는지 검사하기 끝 *** //
	
	
	// *** "우편번호찾기" 를 클릭했는지 검사하기 시작 *** //
	if(!b_zipcodeSearch_click) {
		// "우편번호찾기" 를 클릭 안 했을 경우
		alert("우편번호찾기를 클릭하셔서 우편번호를 입력하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}
	// *** "우편번호찾기" 를 클릭했는지 검사하기 끝 *** //
	
	
	// *** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 *** //
	const user_zipcode = $("input#user_zipcode").val().trim();
	const user_address = $("input#user_address").val().trim();
	const user_detail_address = $("input#user_detail_address").val().trim();
	const user_extraaddress = $("input#user_extraaddress").val().trim();
	
	if(user_zipcode == "" || user_address == "" || user_detail_address == "" || user_extraaddress == "") {
		alert("우편번호 및 주소를 입력하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}
	// *** 우편번호 및 주소에 값을 입력했는지 검사하기 끝 *** //
	
	
	// *** 성별을 선택했는지 검사하기 시작 *** //
	const radio_checked_length = $("input:radio[name='user_gender']:checked").length; 
	
	if(radio_checked_length == 0) {
		alert("성별을 선택하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}
	// *** 성별을 선택했는지 검사하기 끝 *** //
	
	
	// *** 생년월일 값을 입력했는지 검사하기 시작 *** //
	const birthday = $("input#datepicker").val().trim();
	
	if(birthday == "") {
		alert("생년월일을 입력하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}
	// *** 생년월일 값을 입력했는지 검사하기 끝 *** //
	
	
	// *** 약관에 동의를 했는지 검사하기 시작 *** //
	const checkbox_checked_length = $("input:checkbox[id='agree']:checked").length; 
	
	if(checkbox_checked_length == 0) {
		alert("이용약관에 동의하셔야 합니다.");
		return; // goRegister() 함수를 종료한다.
	}
	// *** 약관에 동의를 했는지 검사하기 끝 *** //
	
	
	const frm = document.memberRegisterFrm;
	frm.action = "memberRegister.bz";
	frm.method = "post";
	frm.submit();
	
}// end of function goRegister()----------------------

function goReset() {
	
	
	$("p.error").hide();
	
	
	$("p#idcheckResult").empty();
	$("p#emailCheckResult").empty();
	
}// end of function goReset()------------------------- 


