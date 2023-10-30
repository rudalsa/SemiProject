package member.controller;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.MemberDAO;
import member.model.MemberDAO_imple;


public class MemberResignationAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String user_id = request.getParameter("user_id");
		
		String method = request.getMethod(); // "GET" 또는 "POST" 
		
		if("POST".equalsIgnoreCase(method)) {
			// "회원탈퇴하기" 버튼을 클릭했을 경우 
			
			MemberDAO mdao = new MemberDAO_imple();
			
			int n = 0;
			try {
				 n = mdao.deleteUser(user_id);
			} catch (SQLException e) {
				
			}
		
			request.setAttribute("n", n); 
			//  n ==> 1 또는 n ==> 0
 			
		}// end of if("POST".equalsIgnoreCase(method))-------
		
		request.setAttribute("userid", user_id);
		request.setAttribute("method", method);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/member/admin/memberOneDetail.jsp");
		
	
	}

}
