package buy.controller;

import java.sql.SQLException;

import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;
import member.domain.OrderViewVO;
import member.model.MemberDAO;
import member.model.MemberDAO_imple;

public class OrderlistAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boolean isLogin = super.checkLogin(request);
	
		
		if(!isLogin) { // 로그인을 하지 않은 상태이라면
					
			
			request.setAttribute("message", "구매내력을 보려면 로그인을 하세요!!");
	        request.setAttribute("loc", "javascript:history.back()");
	            
	   //   super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
	            
	        return;
					
		}
		
		else {
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			loginuser.getUser_id();
			loginuser.getUser_payment();
			
			
			MemberDAO mdao = new MemberDAO_imple();
			
			// System.out.println("user_id==>>"+loginuser.getUser_id()+"loginuser.getUser_payment()==>"+loginuser.getUser_payment());

	    	
	    	try {
				
				List<OrderViewVO> rememberList = mdao.Buyremember(loginuser.getUser_id()); 
				request.setAttribute("rememberList", rememberList);
				
				
			} catch(SQLException e){
					
					String message = "";
					String loc = "";	
					
					message = " 목록보기에 실패했습니다. ";
					loc = "javascript:history.back()";
			        
					request.setAttribute("message", message);
			        request.setAttribute("loc", loc);
				    
			        // super.setRedirect(false);   
			        super.setViewPage("/WEB-INF/msg.jsp");
			
			
			
			}

			super.setRedirect(false);
			super.setViewPage("/WEB-INF/member/buyremember.jsp");
		
		}
		
	}
	
}
		
		
		

		

