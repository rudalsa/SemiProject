package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;

public class CoinPurchaseEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 원포트(구 아임포트) 결제창을 하기 위한 전제조건은 먼저 로그인을 해야한다.
		if(super.checkLogin(request)) {
			
			// 로그인을 했으면
			String user_id = request.getParameter("user_id");
			
			HttpSession session = request.getSession();
	        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	         
	         if(loginuser.getUser_id().equals(user_id)) {
	        	 // 로그인한 사용자가 자신의 코인을 수정하는 경우
	     		
	        	String coinmoney = request.getParameter("coinmoney");
	     		
	        	String productName = "코인충전"; // :"새우깡"; 등등 으로 변경가능 받아와야함
	     		int productPrice = 100;	// 가격 변경가능
	     		
	     		//Integer.parseInt(coinmoney)
	     		
	     		request.setAttribute("productName", productName);
	     		request.setAttribute("productPrice", productPrice);
	     		request.setAttribute("email", loginuser.getUser_email());
	     		request.setAttribute("name", loginuser.getUser_name());
	     		request.setAttribute("mobile", loginuser.getUser_phone());
	     		
	     		request.setAttribute("user_id", user_id);
	     		request.setAttribute("coinmoney", coinmoney);
	     		
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/shop/paymentGateway.jsp");
	         }
			else {
				// 로그인한 사용자가 다른 사용자의 코인충전 결제를 시도하는 경우
	
				String message = "다른 사용자의 코인충전 결제 시도는 불가합니다.!!";
				String loc = "javascript:history.back()";			
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
		
		}
		
		
		else {
			// 로그인을 안했으면
			String message = "코인충전을 하기 위해서는 먼저 로그인을 하세요";
			String loc = "javascript:history.back()";			
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}

}
