
$(document).ready(function(){
	
	$("button#btnSubmit").click(function(){
		  goLogin(); // 로그인 시도한다.
	});
	
	$("input#loginPwd").bind("keydown", function(e){
	    if(e.keyCode == 13) { // 암호입력란에 엔터를 했을 경우 
		  goLogin(); // 로그인 시도한다.	
		}	
	});
	
	
	
});// end of $(document).ready(function(){})------------------


// === 로그인 처리 함수 === //
function goLogin() {
 //	alert("확인용 로그인 처리 하러 간다.");
	
	const user_id = $("input#user_id").val().trim();
	const user_pwd = $("input#user_pwd").val().trim();
	
	if(user_id == "") {
		alert("아이디를 입력하세요!!");
		$("input#user_id").val("").focus();
		return; // goLogin() 함수 종료
	}
	
	if(user_pwd == "") {
		alert("암호를 입력하세요!!");
		$("input#user_pwd").val("").focus();
		return; // goLogin() 함수 종료
	}
	
	
	if( $("input:checkbox[id='saveid']").prop("checked") ) {
		// alert("아이디저장 체크를 하셨네요~~^^");
		
		localStorage.setItem('saveid', $("input#user_id").val());
	}
	else {
		// alert("아이디저장 체크를 해제 하셨네요!!");
		
		localStorage.removeItem('saveid');
	}
	
	const frm = document.loginFrm;
	frm.submit();
	
}// end of function goLogin()-------------


function goLogOut(ctx_Path) {
	
	// 로그아웃을 처리해주는 페이지로 이동
	location.href=`${ctx_Path}/login/logout.bz`;
}// end of function goLogOut(ctx_Path)------------







 
 