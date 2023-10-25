package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;
import member.model.*;

public class MemberOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getUser_id())) {
		// 관리자 계정으로 로그인 했을때,
			
			String method = request.getMethod(); // "GET" 또는 "POST"
			System.out.println("method : " + method);
			
			if("POST".equalsIgnoreCase(method)) {
			
				String user_id = request.getParameter("user_id");
				String goBackURL = request.getParameter("goBackURL");
				
				System.out.println("goBackURL : " + goBackURL);

				
				MemberDAO mdao = new MemberDAO_imple();
				MemberVO mvo =  mdao.selectOneMember(user_id);
				request.setAttribute("mvo", mvo);
				request.setAttribute("goBackURL", goBackURL);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/admin/memberOneDetail.jsp");
			}
	
		}
		
	}

}
