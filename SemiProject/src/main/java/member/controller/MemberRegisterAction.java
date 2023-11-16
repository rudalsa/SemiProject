package member.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.domain.MemberVO;
import member.model.*;

public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST" 
		
		if("GET".equalsIgnoreCase(method)) {
        //  super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/memberRegister.jsp");
		}
		
		else {

			String user_name = request.getParameter("user_name");
			String user_id = request.getParameter("user_id");
			String user_pwd = request.getParameter("user_pwd");
			String user_email = request.getParameter("user_email");
			String user_phone = request.getParameter("user_phone");
			String user_zipcode = request.getParameter("user_zipcode");
			String user_address = request.getParameter("user_address");
			String user_detail_address = request.getParameter("user_detail_address");
			String user_extraaddress = request.getParameter("user_extraaddress");
			String user_gender = request.getParameter("user_gender");
			String user_birthday = request.getParameter("user_birthday");
			
			
			MemberVO member = new MemberVO(user_id, user_pwd, user_name, user_phone, user_email, user_zipcode, user_address, user_detail_address, user_extraaddress, user_birthday, user_gender);  
			
			MemberDAO mdao = new MemberDAO_imple();
		
			// === 회원가입이 성공되어지면 "회원가입 성공" 이라는 alert 를 띄우고 시작페이지로 이동한다. === //
	
			String message = "";
			String loc = "";
			
			try {
				int n = mdao.registerMember(member);
				
				if(n==1) {
					message = "회원가입 성공";
					loc = request.getContextPath()+"/index.bz"; // 시작페이지로 이동한다.
				}
			} catch(SQLException e) {
				message = "SQL구문 에러발생";
				loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는 것. 
				e.printStackTrace();
			
			}
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false); 
			super.setViewPage("/WEB-INF/msg.jsp");
			
			
			 		// #### 회원가입이 성공되어지면 자동으로 로그인 되도록 하겠다. ### //
			 /*
		   try {
				int n = mdao.registerMember(member);
				
				if(n==1) {
				   request.setAttribute("user_id", user_id); 
				   request.setAttribute("user_pwd", user_pwd); 
					
				   super.setRedirect(false);
				   super.setViewPage("/WEB-INF/login/memberRegister_after_autoLogin.jsp");
				}
			} catch(SQLException e) {
				e.printStackTrace();
				
				String message = "SQL구문 에러발생";
				String loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동하는 것. 
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false); 
				super.setViewPage("/WEB-INF/msg.jsp");
			}	
			 */
			
		}
		
	
		
	}

}
