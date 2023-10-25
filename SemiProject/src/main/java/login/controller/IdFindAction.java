package login.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			// 아이디 찾기 모달창에서 "찾기" 버튼을 클릭했을 경우
			String user_name = request.getParameter("user_name");
			String user_email = request.getParameter("user_email");
			
			MemberDAO mdao = new MemberDAO_imple();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("user_name", user_name);
			paraMap.put("user_email", user_email);
			
			String user_id = mdao.findUserid(paraMap);
			
			if(user_id != null) {
				request.setAttribute("user_id", user_id);
			}
			else {
				request.setAttribute("user_id", "존재하지 않습니다.");
			}
			
			request.setAttribute("user_name", user_name);
			request.setAttribute("user_email", user_email);
			
		}// end of if("POST".equalsIgnoreCase(method)){}------
		
		request.setAttribute("method", method);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/idFind.jsp");
		
	}

}
