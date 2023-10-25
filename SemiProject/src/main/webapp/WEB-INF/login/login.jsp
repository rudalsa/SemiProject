<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>

	<jsp:include page="../header_suc.jsp" /> 
<script type="text/javascript">
$(document).ready(function(){
	
 
	  
  /////////////////////////////////////////////////
  // === 로그인을 하지 않은 상태일 때 
  //     로컬스토리지(localStorage)에 저장된 key가 'saveid' 인 userid 값을 불러와서 
  //     input 태그 userid 에 넣어주기 ===
	 if(${empty sessionScope.loginuser}) {
		// alert("헤헤헤~~~");
		
		 const user_id = localStorage.getItem('saveid');
		 
		 if(user_id != null) {
			 $("input#user_id").val(user_id);
			 $("input:checkbox[id='saveid']").prop("checked", true);
		 }
		
	 }
  /////////////////////////////////////////////////	  

  
});// end of $(document).ready(function(){})--------------
</script>


<section class="backgroundimg mt-3" style="background-image: url('<%= ctxPath %>/img/vm.jpg'); background-size: 90% auto; background-position: center 5%; background-repeat: no-repeat; height: 80%;">
    <div class="container">
        <div class="row justify-content-center align-items-center" style="min-height: 300px; ">
            <div class="col-lg-12 text-center">
                <div class="text-white">
                    <h1 style="font-weight: bold;">로그인</h1>
                    <br>
                    <h3 style="font-weight: bold;">3조 웹페이지 방문을 환영합니다.!!</h3>
                </div>
            </div>
        </div>
    </div>
</section>

<br>

<section class="mt-5">

    <div class="container">
        <div class="row justify-content-center align-items-center">
	       <c:if test="${empty sessionScope.loginuser}">
	       
	        <!-- 로그인 폼 -->
	        <div class="col-lg-5 text-left border-right pr-5">
	        <h5 class="text-white mb-3" style="font-weight:bord">Login</h5>
	        <form action="<%= ctxPath%>/login/login.bz" method="post">
		        
				<div class="form-group">
				    <div class="input-group">
				        <div class="input-group-prepend">
				            <span class="input-group-text" style="weight=10px"><i class="fa-regular fa-id-card" style="width: 25px;"></i></span>
				        </div>
				        <input type="text" id="user_id" name="user_id" class="form-control" placeholder="User_ID"/>
				    </div>
				</div>
				 
				<div class="form-group">
				    <div class="input-group">
				        <div class="input-group-prepend">
				            <span class="input-group-text"><i class="fa-solid fa-key" style="width: 25px;"></i></span>
				        </div>
				        <input type="password" id="user_pwd" name="user_pwd" class="form-control" placeholder="user_pwd"/>
				    </div>
				</div>
			     		<div class="text-center">
			    	<input type="checkbox" id="saveid" />&nbsp;<label for="saveid" style="color: white;">아이디저장</label>
		        </div>
		        <button type="submit" class="btn btn-primary btn-block"><span style="font-weight:bold;">로그인하기</span></button>
	        
	        </form>
	        <div class="text-center mt-3">
	          <a style="cursor: pointer; color : white;" data-toggle="modal" data-target="#userIdfind" data-dismiss="modal">아이디찾기</a>
	          <span class="text-white"> / </span> 
	          <a style="cursor: pointer; color : white;" data-toggle="modal" data-target="#passwdFind" data-dismiss="modal" data-backdrop="static">비밀번호찾기</a>
	        </div>
	        <br>
				      
			  <%-- ****** 아이디 찾기 Modal ****** --%>
  <div class="modal fade" style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');" id="userIdfind"> <%-- 만약에 모달이 안보이거나 뒤로 가버릴 경우에는 모달의 class 에서 fade 를 뺀 class="modal" 로 하고서 해당 모달의 css 에서 zindex 값을 1050; 으로 주면 된다. --%> 
    <div class="modal-dialog" style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');" >
      <div class="modal-content"style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');" >
      
        <!-- Modal header -->
        <div class="modal-header" style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');">
          <h4 class="modal-title">아이디 찾기</h4>
          <button type="button" class="close idFindClose" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');">
          <div id="idFind" style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');">
          	<iframe id="iframe_idFind" style="border: none; width: 100%; height: 350px;" src="<%= ctxPath%>/login/idFind.bz">
          	</iframe>
          </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer" style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');">
          <button type="button" class="btn btn-danger idFindClose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
  
  <%-- ****** 비밀번호 찾기 Modal ****** --%>
  <div class="modal fade" id="passwdFind"> <%-- 만약에 모달이 안보이거나 뒤로 가버릴 경우에는 모달의 class 에서 fade 를 뺀 class="modal" 로 하고서 해당 모달의 css 에서 zindex 값을 1050; 으로 주면 된다. --%>
    <div class="modal-dialog">
      <div class="modal-content" style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');">
      
        <!-- Modal header -->
        <div class="modal-header" style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');">
          <h4 class="modal-title">비밀번호 찾기</h4>
          <button type="button" class="close passwdFindClose" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body" style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');">
          <div id="pwFind">
          	<iframe style="border: none; width: 100%; height: 350px;" src="<%= ctxPath%>/login/pwdFind.bz">  
          	</iframe>
          </div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer" style="background-image: url('<%= ctxPath %>/img/index_bg.jpg');">
          <button type="button" class="btn btn-danger passwdFindClose" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>  	
</div>
</c:if>
	      <div>
	        </div>
		  	        <!-- 추가 내용 -->
	        <div class="col-lg-5 text-center text-white pl-5">
	            <h3 style="font-weight:bold">간편하게 회원가입 해보세요!</h3>
	            <h5 style="font-weight:bold">다양한 게임들을 만나보실수 있습니다.</h5>
	            <br>
	            <a href="<%= ctxPath%>/member/memberRegister.bz" class="btn btn-danger" style="font-weight:bold">회원가입하기</a>
	        </div>
	        
   		</div>                   
    
	</div>
 
</section>

<section class="mt-3 text-center"> <!-- Add text-center class here -->
    <div class="d-flex row justify-content-center align-items-center">
        <div class="col-lg-6">
            <div class="login__social">
                <div class="row d-flex justify-content-center">
                    <div class="col-lg-6">
                        <div class="login__social__links">
                            <h2 class="text-white" style="text-align: center; font-weight:bold;">or</h2>
                            <ul class="list-unstyled">
                                <li class="btn btn-primary mt-2 text-white btn_text" style="text-align: center; font-weight:bold; width:300px;">
                                    &nbsp;<i class="fa-brands fa-square-facebook"></i> 페이스북으로 로그인하기
                                </li>
                                <li class="btn btn-danger mt-2 text-white btn_text" style="text-align: center; font-weight:bold; width:300px;">
                                    &nbsp;<i class="fa-brands fa-google"></i> 구글로 로그인하기
                                </li>
                                <li class="btn btn-success mt-2 text-white btn_text" style="text-align: center; font-weight:bold; width:300px;">
                                    &nbsp;<i class="fa-brands fa-square-x-twitter"></i> 트위터로 로그인하기
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>
 
 
<!--  이 코드는 Bootstrap의 그리드 시스템 및 클래스를 사용하여 섹션의 레이아웃을 구성하고, 섹션의 높이를 최소 250px로 고정하도록 했습니다. 기존 코드와 Bootstrap을 통합하여 웹 페이지를 디자인할 수 있게 되었습니다. 페이지의 다른 부분에 대해서도 Bootstrap을 활용하여 반응형 디자인을 추가할 수 있습니다. -->





