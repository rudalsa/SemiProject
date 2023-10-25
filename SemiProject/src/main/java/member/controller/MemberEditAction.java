package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;

public class MemberEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		if(super.checkLogin(request)) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		System.out.println("확인용"+loginuser.getUser_id());
		if(loginuser.getUser_id()!=null) {
			// 로그인한 사용자가 자신의 정보를 수정하는 경우
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/mypage.jsp");
		}
		else {
			// 로그인한 사용자가 다른 사용자의 정보를 수정하려는 경우
			// 로그인을 안했으면
			String message = "본인의 회원정보만 수정 가능합니다.!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			
		}
		}
		else {
			// 로그인을 안했으면
			String message = "회원정보를 수정하기 위해서는 먼저 로그인을 하세요!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");	
			
			
		}
		
	}

}
