package buy.controller;


import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;
import member.model.MemberDAO;
import member.model.MemberDAO_imple;

public class BuyUpdateUserAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("POST".equalsIgnoreCase(method)) {
			
			// POST 방식이라면
			
			String user_id = request.getParameter("user_id");
			String coinmoney = request.getParameter("coinmoney");
			
			System.out.println(user_id + coinmoney);
			
			
			Map<String,String> paraMap = new HashMap<>();
			
			paraMap.put("user_id",user_id);
			paraMap.put("coinmoney",coinmoney);
			
			MemberDAO mdao = new MemberDAO_imple();
			
			String message = "";
		    String loc = "";
			
			try {
				
				int n = mdao.BuyUpdateUser(paraMap); // DB에 코인 및 포인트를 올려준다.
				
				if (n==1) {
					
					System.out.println("시발성공이다.");
					
					HttpSession session = request.getSession(); 
					MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
					
					DecimalFormat df = new DecimalFormat("#,###");
					
					message = loginuser.getUser_name() + " 님의 " + df.format(Long.parseLong(coinmoney)) + "원 결제가 완료되었습니다. "; 
					loc = request.getContextPath()+"/index.bz";
					
					/*
					 * HttpSession session = request.getSession(); MemberVO loginuser = (MemberVO)
					 * session.getAttribute("loginuser");
					 * 
					 * // !!!! 세션값을 변경하기 !!! //
					 * 
					 * loginuser.setUser_payment(loginuser.getUser_payment() +
					 * Integer.parseInt(coinmoney) );
					 * 
					 * 
					 * loginuser.setUser_coin(loginuser.getUser_coin() +
					 * (int)(Integer.parseInt(coinmoney)*0.01) );
					 * 
					 * DecimalFormat df = new DecimalFormat("#,###"); // 예를 들어 //
					 * System.out.println(df.format(2005100)); // "2,005,100"
					 * 
					 * message = loginuser.getUser_name() + " 님의 " +
					 * df.format(Long.parseLong(coinmoney)) + "원 결제가 완료되었습니다. "; loc =
					 * request.getContextPath()+"/index.bz";
					 */
					
				}
				
			
			} catch(SQLException e){
				
				message = " 코인의 결제가 DB오류로 인해 실패되었습니다. ";
				loc = "javascript:history.back()";
			
			}
		
			
			  request.setAttribute("message", message);
		      request.setAttribute("loc", loc);
		      
		 //   super.setRedirect(false);
		      super.setViewPage("/WEB-INF/msg.jsp");
			
		
		}
		
		else {
			
			  String message = "비정상적인 경로로 들어왔습니다.";
		      String loc = "javascript:history.back()";
		      
		      request.setAttribute("message", message);
		      request.setAttribute("loc", loc);
		      
		 //   super.setRedirect(false);
		      super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
	}

}
