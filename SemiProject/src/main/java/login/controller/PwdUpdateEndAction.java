package login.controller;

import java.sql.SQLException;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class PwdUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST" 
		String user_id = request.getParameter("user_id");	

		if("POST".equalsIgnoreCase(method)) {
			// "암호변경하기" 버튼을 클릭했을 경우 
			
			String new_pwd = request.getParameter("pwd");
			
			MemberDAO mdao = new MemberDAO_imple();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("user_id", user_id);
			paraMap.put("new_pwd", new_pwd);
			
			int n = 0;
			try {
				 n = mdao.pwdUpdate(paraMap);
			} catch (SQLException e) {
				
			}
			request.setAttribute("n", n); 
			//  n ==> 1 또는 n ==> 0
			String message = "회원정보 수정 성공!!";
			String loc = request.getContextPath()+"/index.bz"; // 시작페이지로 이동한다.
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");

 			
		}// end of if("POST".equalsIgnoreCase(method))-------
		request.setAttribute("user_id", user_id);
		request.setAttribute("method", method);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/pwdUpdateEnd.jsp");
		
	}

}
