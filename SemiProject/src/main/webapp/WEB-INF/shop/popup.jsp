
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>


<html>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.2-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 6 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.2-dist/js/bootstrap.bundle.min.js" ></script> 
<script type="text/javascript" src="<%= ctxPath%>/js/template/template.js"></script>

<%-- jQueryUI CSS 및 JS --%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.css" />
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.min.js"></script>

<%-- 달콤달콤 alert --%>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" /> 
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<script type="text/javascript"> 

let isOrderOK = false;
// 로그인한 사용자가 해당 제품을 구매한 상태인지 구매하지 않은 상태인지 알아오는 용도.
// isOrderOK 값이 true 이면   로그인한 사용자가 해당 제품을 구매한 상태이고,
// isOrderOK 값이 false 이면  로그인한 사용자가 해당 제품을 구매하지 않은 상태로 할 것임.
$(document).ready(function() {
   
   $("button#btnCommentOK").click(function() {
      isOrderOK = true;
      if(${empty sessionScope.loginuser}) {
            alert("제품사용 후기를 작성하시려면 먼저 로그인 하셔야 합니다.");
            return;
        }
      
      if(isOrderOK == false) {  
            alert("제품을 구매하셔야만 후기작성이 가능합니다.");
        }
        else {   
            var commentContents = $("textarea[name=contents]").val().trim();
            
            if(commentContents == "") {
               alert("제품후기 내용을 입력하세요!!");
               return; 
            }
         // 보내야할 데이터를 선정하는 첫번째 방법
         <%-- 
         var queryString = {"fk_userid":'${sessionScope.loginuser.userd}', 
                            "fk_pnum" : '${requestScope.pvo.pnum}',
                            "contents" : $("textarea[name=contents]").val()};
         --%>
         // 보내야할 데이터를 선정하는 두번째 방법
         // jQuery에서 사용하는 것으로써,
         // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
         var queryString = $("form[name=commentFrm]").serialize();
         // console.log(queryString);
         // contents=very%20Good&fk_userid=seoyh&fk_pnum=57
         // %20 은 공백이다.
         
         $.ajax({
            url:"<%= request.getContextPath()%>/shop/reviewRegister.bz",
            type:"POST",
            data:queryString,
            dataType:"JSON",
            success:function(json){ // {"n":1} 또는 {"n":-1} 또는  {"n":0}
               if(json.n == 1) {
                   // 제품후기 등록(insert)이 성공했으므로 제품후기글을 새로이 보여줘야(select) 한다.
                   alert("후기등록성공"); //goCommentListView(); // 제품후기글을 보여주는 함수 호출하기 
                 }
                 else if(json.n == -1)  {
                 // 동일한 제품에 대하여 동일한 회원이 제품후기를 2번 쓰려고 경우 unique 제약에 위배됨 
                 // alert("이미 후기를 작성하셨습니다.\n작성하시려면 기존의 제품후기를\n삭제하시고 다시 쓰세요.");
                  swal("이미 후기를 작성하셨습니다.\n작성하시려면 기존의 제품후기를\n삭제하시고 다시 쓰세요.");
                 }
                 else  {
                    // 제품후기 등록(insert)이 실패한 경우 
                    alert("제품후기 글쓰기가 실패했습니다.");
                 }
               
               $("textarea['name=contents']").val("").focus();
            },
            error: function(request, status, error){
               alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
         });
      
       }// end of if ~ else -------------------------
   });
   
});

</script>
<body style="background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">
<head>
    <title>리뷰 팝업</title>
    <style>
        body {
            text-align: center;
            margin: 20px;
        }
        button#closePopup {
        border-radius: 10px; /* 픽셀 값을 조절하여 원하는 라운드 모서리 정도를 지정합니다. */
      padding: 10px 15px; /* 버튼 내부 여백 설정 */
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 18px;
        }
    </style>
</head>

<body>
    <h2 style="font-weight: bold; color:white; "><span style="color: orange;">${sessionScope.loginuser.user_id}</span> 님 환영합니다</h2>
    <p style="font-size: 10pt; color:white;" class="mt-3">제품을 구매하신 고객님만 후기작성이 가능합니다.</p>
    
    <div class="row mt-5">
        <div class="col-9">
          <form name="commentFrm">
              <textarea name="contents" style="font-size: 12pt; width: 100%; height: 150px;"></textarea>
              <input type="hidden" name="fk_user_id" value="${sessionScope.loginuser.user_id}" />
              <input type="hidden" name="fk_g_code" value="${requestScope.g_code}" />
          </form>
       </div>
       <div class="col-3" style="display: flex;">
          <button type="button" class="btn btn-outline-secondary w-100 h-100" id="btnCommentOK" style="margin: auto; width: 10%; color:white;"><span class="h5">후기등록</span></button>
       </div>
    </div>
    
    <button class="mt-5" id="closePopup" style="background-color: gray; color:black;" onclick="window.close()">닫기</button>
</body>
</html>