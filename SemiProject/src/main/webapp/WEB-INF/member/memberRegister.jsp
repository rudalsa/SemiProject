<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	String ctxPath = request.getContextPath();
	// tempSemi
%>

<jsp:include page="../header_suc.jsp"></jsp:include>


<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<link rel="stylesheet" href="<%= ctxPath%>/css/member/memberRegister.css">
<script type="text/javascript" src="<%= ctxPath%>/js/member/memberRegister.js"></script>



	<br><br><br><br><br><br>
	<div id="container" class="text-white">
		<form name="memberRegisterFrm">
			<div>
				<h2>::: 회원가입 :::</h2>
				<h6 class="mb-5">::: 태그를 누르시면 입력칸이 나옵니다 :::</h6>
			</div>
			<div class="div1">
				<label onclick="showInputTag('nameInput');">
				<span style="font-size: 12pt;">이름</span> <span style="font-size: 9pt; color: gray;">실명 입력</span>
				</label>
				<div id="nameInput" class="hideInput">
					<input type="text" name="user_name" id="user_name" class="inputFocus requiredInfo" maxlength="10" autocomplete="off" />
					<button type="button" class="close" onclick="inputClose('user_name')">&times;</button>
				</div>
				<p class="error">실명을 입력해 주세요.</p>
			</div>
		
			<div class="div1">
				<label onclick="showInputTag('useridInput');">
				<span style="font-size: 12pt;" >아이디</span> <span style="font-size: 9pt; color: gray;">영문 또는 영문+숫자 조합 4~12자</span>
				</label>
				<div id="useridInput" class="hideInput">
					<input type="text" name="user_id" id="user_id" class="inputFocus requiredInfo" maxlength="12" autocomplete="off" >
					<button type="button" class="close" onclick="inputClose('user_id')">&times;</button>
					<img src="<%= ctxPath%>/img/b_id_check.gif" id="idcheck" />
				</div>
				<p id="idcheckResult"></p>
				<p class="error">영문 또는 영문+숫자 조합 4~12자로 입력해주세요.</p>
			</div>
			
			<div class="div1">
				<label onclick="showInputTag('pwdInput');">
				<span style="font-size: 12pt;">비밀번호</span> <span style="font-size: 9pt; color: gray;">영문 대.소문자+숫자+특수문자 조합 8~15자</span>
				</label>
				<div id="pwdInput" class="hideInput">
					<input type="password" name="user_pwd" id="user_pwd" class="inputFocus requiredInfo" maxlength="15" autocomplete="off">
					<button type="button" class="close" onclick="inputClose('user_pwd')">&times;</button>
				</div>
				<p class="error">영문 대.소문자+숫자+특수문자 조합 8~15자로 입력해 주세요.</p>
			</div>
			
			<div class="div1">
				<label onclick="showInputTag('pwdCheckInput');">
				<span style="font-size: 12pt;">비밀번호 확인</span> <span style="font-size: 9pt; color: gray;">비밀번호 재입력</span>
				</label>
				<div id="pwdCheckInput" class="hideInput">
					<input type="password" id="pwdCheck" class="inputFocus requiredInfo" maxlength="15" autocomplete="off">
					<button type="button" class="close" onclick="inputClose('pwdCheck')">&times;</button>
				</div>
				<p class="error">비밀번호가 일치하지 않습니다</p>
			</div>
			
			<div class="div1">
				<label onclick="showInputTag('emailInput');">
				<span style="font-size: 12pt;">이메일</span> <span style="font-size: 9pt; color: gray;">이메일 형식에 맞게 입력</span>
				</label>
				<div id="emailInput" class="hideInput">
					<input type="text" name="user_email" id="user_email" class="inputFocus requiredInfo" maxlength="30" autocomplete="off">
					<button type="button" class="close" onclick="inputClose('user_email')">&times;</button>
					<span id="emailcheck">이메일중복확인</span>
				</div>
				<p id="emailCheckResult"></p>
				<p class="error">이메일 형식에 맞지 않습니다.</p>
			</div>
			
			<div class="div1">
				<label onclick="showInputTag('phoneInput');">
				<span style="font-size: 12pt;">휴대폰번호</span> <span style="font-size: 9pt; color: gray;">하이픈(-) 없이 입력</span>
				</label>
				<div id="phoneInput" class="hideInput">
					<input type="text" name="user_phone" id="user_phone" class="inputFocus" maxlength="11" autocomplete="off">
					<button type="button" class="close" onclick="inputClose('user_phone')">&times;</button>
				</div>
				<p class="error">정확히 입력해 주세요.</p>
			</div>
			
			<div class="div1">
				<label id="zipcodeSearch" onclick="showInputTag('zipcodeInput');">
				<span style="font-size: 12pt;">우편번호</span>
				</label>
				<div id="zipcodeInput" class="hideInput">
					<input type="text" name="user_zipcode" id="user_zipcode" class="inputFocus" maxlength="11" autocomplete="off">
					<button type="button" class="close" onclick="inputClose('user_zipcode')">&times;</button>
					<img src="<%= ctxPath%>/img/b_zipcode.gif" id="zipcodeSearch" />
				</div>
				<p class="error">마우스 클릭으로 입력하세요.</p>
			</div>
			
			<div class="div1 div3">
				<label onclick="showInputTag('addressInput');">
				<span style="font-size: 12pt;">주소</span>
				</label>
				<div id="addressInput" class="hideInput">
					<input type="text" name="user_address" id="user_address" class="inputFocus" maxlength="11" autocomplete="off">
					<input type="text" name="user_detail_address" id="user_detail_address" class="inputFocus" maxlength="11" autocomplete="off" placeholder="상세주소">
					<input type="text" name="user_extraaddress" id="user_extraaddress" class="inputFocus" maxlength="11" autocomplete="off">
					<button type="button" class="close" onclick="inputClose('user_address,user_detail_address,user_extraaddress')">&times;</button>
				</div>
				<p class="error">주소를 입력해 주세요.</p>
			</div>
			
			
			
			<div class="div1 div2" >
				<label onclick="showInputTag('birthdayInput');">
				<span style="font-size: 12pt;">생년월일(선택)</span>
				</label>
				<div id="birthdayInput" class="hideInput">
					<input type="text" name="user_birthday" id="datepicker" class="inputFocus" maxlength="12" autocomplete="off">
					<button type="button" class="close" onclick="inputClose('birthday')">&times;</button>
				</div>
			</div>
			
			<div class="div1 div3">
				<label>
				<span style="font-size: 12pt;">성별 선택</span> 
				</label>
				<span id="gender">
					<input type="radio" name="user_gender" id="male" value="1" /><label for="male">남자</label>
		            <input type="radio" name="user_gender" id="female" value="2" /><label for="female">여자</label>
				</span>
				
			</div>
			
			<div>
				<label for="agree" class="mt-5 mb-3">이용약관에 동의합니다</label>&nbsp;&nbsp;<input type="checkbox" id="agree" /><br>
				<iframe src="<%= ctxPath%>/iframe_agree/agree.html" width="45%" height="200px" style="border: solid 1px navy;"></iframe>
			</div>
			
			<div class="my-5">
				<input type="button" class="btn btn-primary btn-lg mr-5" value="가입하기" onclick="goRegister()" />
	        	<input type="reset"  class="btn btn-danger btn-lg" value="취소하기" onclick="goReset()" />
			</div>
		</form>
	</div>



	





<jsp:include page="../footer_suc.jsp"></jsp:include>