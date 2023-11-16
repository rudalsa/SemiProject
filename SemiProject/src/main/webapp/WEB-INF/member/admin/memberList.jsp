<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<jsp:include page="../../header_suc.jsp" /> 

<style type="text/css">
	
	table#memberTbl{
		width:80%;
		margin: 0 auto;
	}
	
	table#memberTbl th{
		text-align:center;
		font-size:14pt;
	}
	
	table#memberTbl tr.memberinfo:hover{
		background-color:#e6ffe6;
		cursor:poniter;
	}
	
	form[name="member_search_frm"]{
		width:80%;
		margin: 0 auto 1% auto;
	}
	
	form[name="member_search_frm"] button.btn-secondary{
		margin-left:2%;
		margin-right:10%;
	}
	div#pageBar {
      border: solid 0px red;
      width: 80%;
      margin: 3% auto 0 auto;
      display: flex;
   }
   
   div#pageBar > nav {
      margin: auto;
   }
	
</style>

<script type="text/javascript">
$(document).ready(function(){


	if("${requestScope.searchType}" != "" &&
	   "${requestScope.searchWord}" != ""){
		$("select[name='searchType']").val("${requestScope.searchType}");
		$("input[name='searchWord']").val("${requestScope.searchWord}");
		}
	
    $("input[name='searchWord']").bind("keydown", function(e){
        if(e.keyCode == 13){
            goSearch();                
        }
	    });
    if("${requestScope.sizePerPage}" != ""){
    	$("select[name='sizePerPage']").val("${requestScope.sizePerPage}");
    	}
    
    $("select[name='sizePerPage']").bind("change",function(e){
       	// !!!! select 태그의 이벤트는 click 이 아니라 change 이다. !!!!
        goSearch();
    });

    // 특정 회원을 클릭하면 회원의 상세정보를 보여주도록 한다.
    $("table#memberTbl tr.memberinfo").click( e => {
    	// alert($(e.target).parent().html());
    	// 또는 $(e.target).parent().find(".userid").text();
    	const user_id = $(e.target).parent().children(".user_id").text();
    	// alert(userid);
    	const frm = document.memberOneDetail_frm;
		frm.user_id.value = user_id;
		
		frm.action = "<%= ctxPath%>/member/memberOneDetail.bz";
		frm.method = "POST"
		frm.submit();
    })
    
    
    
	});
function goSearch(){
    const searchType = $("select[name='searchType']").val();

    const frm = document.member_search_frm;
    <%--frm.action = "<%= ctxPath%>/member/memberList.up";--%>
    frm.submit();
}

</script>



	<div class="container text-white" style="padding: 3% 0;">
	<h2 class="text-center mb-5"> ::: 회원 전체 목록 ::: </h2>
	
	<form name = "member_search_frm">
		<select name="searchType">
			<option value="">검색대상</option>
			<option value="user_name">회원명</option>
			<option value="user_id">아이디</option>
			<option value="user_gender">성별</option>
		</select>
		&nbsp;
		<input type="text" name="searchWord" />
		<%--
             form 태그내에서 데이터를 전송해야 할 input 태그가 만약에 1개 밖에 없을 경우에는
             input 태그내에 값을 넣고나서 그냥 엔터를 해버리면 submit 되어져 버린다.
             그래서 유효성 검사를 거친후 submit 을 하고 싶어도 input 태그가 만약에 1개 밖에 없을 경우라면 
             유효성검사가 있더라도 유효성검사를 거치지 않고 바로 submit 되어진다. 
             이것을 막으려면 input 태그가 2개 이상 존재하면 된다.  
             그런데 실제 화면에 보여질 input 태그는 1개 이어야 한다.
             이럴 경우 아래와 같이 해주면 된다.   
             또한 form 태그에 action 이 명시되어 있지 않으면 현재보이는 url 경로로 submit 된다.
        --%>
        <input type="text" style="display:none;" />
        <%-- <input type="hidden" /> 으로 처리하면 안된다.--%>
        
		<button type="button" class="btn btn-secondary" onclick="goSearch()">검색</button>
		&nbsp;
		<span style="font-size:15pt;">페이지당 회원명수-- </span>
			<select name="sizePerPage">
				<option value="10">10명</option>
				<option value="5">5명</option>
				<option value="3">3명</option>
			</select>
	</form>
	
	<table class="table table-bordered text-white" id="memberTbl">
		<thead>
			<tr>
				<th>아이디</th>
				<th>회원명</th>
				<th>이메일</th>
				<th>성별</th>
			</tr>
		</thead>
		
		<tbody>
			<c:if test="${not empty requestScope.memberList}">
				<c:forEach var="membervo" items="${requestScope.memberList}">
					<tr class="memberinfo">
						<td class="user_id">${membervo.user_id}</td>
						<td>${membervo.user_name}</td>
						<td>${membervo.user_email}</td>
						<td>
                        <c:choose>
                           <c:when test="${membervo.user_gender == '1'}"> 
                              남
                           </c:when>
                           <c:otherwise>
                              여
                           </c:otherwise>
                        </c:choose>
                    </td>
					</tr>
				</c:forEach>
			</c:if>
	
			<c:if test="${empty requestScope.memberList}">
				<tr>
					<td colspan="4">선택한 데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	<div id="pageBar">
		<nav class="my-5">
		  <ul class="pagination justify-content-center" style="margin:20px 0">
		   		${requestScope.pageBar}
		    </ul>
		</nav>
	</div>
</div>

<form name="memberOneDetail_frm">
	<input type="hidden" name="user_id" />
	<input type="hidden" name="goBackURL" value="${requestScope.currentURL}"/>
</form>


<jsp:include page="../../footer_suc.jsp" />    