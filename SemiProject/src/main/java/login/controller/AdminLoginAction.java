package login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;
import member.model.MemberDAO;
import member.model.MemberDAO_imple;

public class AdminLoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	String method = request.getMethod(); // "GET" 또는 "POST" 
	HttpSession session = request.getSession();
	MemberDAO mdao = new MemberDAO_imple();

		if("GET".equalsIgnoreCase(method)) {
            super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/admin/adminlogin.jsp");
			}
		
		else {
		
				String user_id = request.getParameter("user_id");
				String user_pwd = request.getParameter("user_pwd");
	
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("user_id", user_id);
				paraMap.put("user_pwd", user_pwd);
				
				//System.out.println("확인용 user_id : "+ user_id);
				//System.out.println("확인용 user_pwd : "+ user_pwd);

				MemberVO loginuser = mdao.selectOneMember(paraMap);
				session.setAttribute("loginuser", loginuser);

				if("admin".equals(loginuser.getUser_id())) {

	
					// 로그인 성공시
					// System.out.println(">>> 확인용 로그인한 사용자명 : " + loginuser.getName());
					System.out.println("~~~ 확인용 로그인 성공 ^___^"+user_id);
					System.out.println(">>> 확인용 로그인한 사용자명 : " + loginuser.getUser_name());
					
					super.setRedirect(true);
					super.setViewPage(request.getContextPath()+"/index.bz");	
					}
			
				else {
					// 로그인을 안했으면 
					String message = "관리자만 접근이 가능합니다!!";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
		
			}
		}

	}


