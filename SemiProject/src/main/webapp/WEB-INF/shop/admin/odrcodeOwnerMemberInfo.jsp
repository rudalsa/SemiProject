<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath(); // MyMVC
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  
<style type="text/css">
   table#personInfoTbl {
      border: 0px solid gray;
      border-collapse: collapse;
      width: 90%;
      margin-top: 3%;
   }
   
   table#personInfoTbl tr {
      line-height: 200%;
   }
   
   table#personInfoTbl td {
      border: 0px solid gray;
      border-collapse: collapse;
      font-size: 14pt;
   }
   
   table#personInfoTbl td.title {
      text-align: justify;
      font-size: 14pt;
      font-weight: bold;
   }
   
   div.head {
      border: 1px solid gray;
      margin: 20px 0;
      padding: 15px 0;
      background-color: #ffffe6;
      font-size: 18pt;
      text-align: center;
      vertical-align: middle;
   }
    
</style>    
<body style="background-image: url('<%= ctxPath %>/img/index_bg.jpg'); background-size: cover; background-position: center; background-repeat: no-repeat;">

<c:set var="mobile" value="${requestScope.mvo.user_phone}" />

<div style="width: 80%; margin: 0 auto;" class="text-white">
   <div class="head border-radius">::: 회원상세정보 :::</div>
      <table id="personInfoTbl">
         
         <tr>
           <td class="title">▷ 아이디</td>
           <td>${requestScope.mvo.user_id}</td>
         </tr>
                  
         <tr>
           <td class="title">▷ 성명</td>
           <td>${requestScope.mvo.user_name}</td>
         </tr>
                  
         <tr>
           <td class="title">▷ 이메일</td>
           <td>${requestScope.mvo.user_email}</td>
         </tr>
         
         <tr>
           <td class="title">▷ 연락처</td>
           <td>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</td>
         </tr>
         
         <tr>
           <td class="title">▷ 우편번호</td>
           <td>${requestScope.mvo.user_zipcode}</td>
         </tr>
         
         <tr>
           <td class="title">▷ 주소</td>
           <td>${requestScope.mvo.user_address}<br>${requestScope.mvo.user_detail_address}&nbsp;${requestScope.mvo.user_extraaddress}</td>
         </tr>
                  
         <tr>
            <td colspan="2" align="center">
                <button type="button" style="margin-top: 30px; background-color: navy; color: white; width: 100px; height: 30px; border: none; font-size: 13pt;" onclick="javascript:self.close();">닫기</button>  
            </td>
         </tr>
      </table>
</div>

