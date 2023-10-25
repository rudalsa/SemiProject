package member.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;
import member.model.MemberDAO;
import member.model.MemberDAO_imple;

public class MemberEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String method = request.getMethod(); // "GET" 또는 "POST" 
		
		String message = "";
		String loc = "";
		
		if(!"POST".equalsIgnoreCase(method)) {
		
//			super.setRedirect(false); 
			super.setViewPage("/WEB-INF/member/memberEdit.jsp");
			
		}
		else {
           // **** POST 방식으로 넘어온 것이라면 **** //
		
		   String user_id = request.getParameter("user_id");	
		   String user_name = request.getParameter("user_name");
		   String user_pwd = request.getParameter("user_pwd");
		   String user_email = request.getParameter("user_email");
    	   String hp1 = request.getParameter("hp1");
		   String hp2 = request.getParameter("hp2");
		   String hp3 = request.getParameter("hp3");
 		   String user_zipcode = request.getParameter("user_zipcode");
		   String user_address = request.getParameter("user_address");
		   String user_detail_address = request.getParameter("user_detail_address");
		   String user_extraaddress = request.getParameter("user_extraaddress");
			
		   String user_phone = hp1+hp2+hp3;
			
		   MemberVO member = new MemberVO(user_id, user_name, user_pwd, user_email, user_phone, user_zipcode, user_address, user_detail_address, user_extraaddress);  
			
		   MemberDAO mdao = new MemberDAO_imple();
		
		   // === 회원수정이 성공되어지면 "회원정보 수정 성공!!" 이라는 alert 를 띄우고 시작페이지로 이동한다. === //
		
			
			try {
				int n = mdao.updateMember(member);
				
				if(n==1) {
					
					// !!!! session 에 저장된 loginuser 를 변경된 사용자의 정보값으로 변경해주어야 한다. !!!!
					HttpSession session = request.getSession();
					MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
					
					loginuser.setUser_name(user_name);
					loginuser.setUser_pwd(user_pwd);
					loginuser.setUser_email(user_email);
					loginuser.setUser_phone(user_phone);
					loginuser.setUser_zipcode(user_zipcode);
					loginuser.setUser_address(user_address);
					loginuser.setUser_detail_address(user_detail_address);
					loginuser.setUser_extraaddress(user_extraaddress);
					
					message = "회원정보 수정 성공!!";
					loc = request.getContextPath()+"/index.bz"; // 시작페이지로 이동한다.
				}
			} catch(SQLException e) {
				message = "SQL구문 에러발생";
				loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는 것. 
				e.printStackTrace();
			}
		
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false); 
			super.setViewPage("/WEB-INF/msg.jsp");
			}
		
		}		
		
	}


