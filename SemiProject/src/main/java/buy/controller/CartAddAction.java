package buy.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;
import game.model.*;



public class CartAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// === 로그인 유무 검사하기 === //
		
		boolean isLogin = super.checkLogin(request);
		
		if(!isLogin) { // 로그인을 하지 않은 상태이라면
					
			/*
			  사용자가 로그인을 하지 않은 상태에서 특정제품을 장바구니에 담고자 하는경우
			  사용자가 로그인을 하면 장바구니에 담고자 했던 그 특정제품 페이지로 이동하도록 해야한다.
			  이와 같이 하려고 ProdViewAction 클래스에서 super.goBackURL(request); 해두었음.
			*/
			
			request.setAttribute("message", "장바구니에 담으려면 먼저 로그인 부터 하세요!!");
	        request.setAttribute("loc", "javascript:history.back()");
	            
	   //   super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
	            
	        return;
					
		}
		
		else {
			// 로그인 한 상태이라면
			// 장바구니 테이블에 해당 제품이 존재하지 않는 경우에는 tbl_cart 테이블에 insert 를 해야하고, 
	        // 장바구니 테이블에 해당 제품이 존재하는 경우에는 또 그 제품을 추가해서 장바구니 담기를 한다라면 tbl_cart 테이블에 update 를 해야한다.
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {
				
				String g_code = request.getParameter("g_code"); // 제품번호
				String oqty = request.getParameter("oqty");     // 주문량		
				String paymoney = request.getParameter("paymoney"); // 가격
				String optno = request.getParameter("optno"); // 가격  
				
				
				/// System.out.println("이건 뭐고" + paymoney);
				//  System.out.println("이건 뭐고" + optno);
				
				
				HttpSession session = request.getSession();
				//session.setAttribute("paymoney", paymoney);
				
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				String user_id = loginuser.getUser_id();
				
				GameOptDAO goptdao = new GameOptDAO_imple();
				
				Map<String, String> paraMap = new HashMap<>();
				paraMap.put("g_code", g_code);
				paraMap.put("oqty", oqty);
				paraMap.put("optno", optno);
				paraMap.put("user_id", user_id);
				
				try {
					
					int n = goptdao.addCart(paraMap);  // 장바구니에 기존 제품이 없을경우 insert 하고,
													// 장바구니에 기존 제품이 있을경우 update 한다.
					
					if(n==1) {
					  request.setAttribute("message", "장바구니 담기 성공");
		              request.setAttribute("loc", request.getContextPath()+"/buy/cartList.bz");
		              								// 장바구니 목록 보여주기 페이지로 이동한다.
					
					}
				
				}catch(SQLException e) {
					 request.setAttribute("message", "장바구니 담기 실패");
		             request.setAttribute("loc", "javascript:histoy.back()");
		     
				}
				  // super.setRedirect(false);   
	              super.setViewPage("/WEB-INF/msg.jsp");
								
			}
			
			else {
				
				String message = "비정상적인 경로로 들어왔습니다";
	              String loc = "javascript:history.back()";
	               
	              request.setAttribute("message", message);
	              request.setAttribute("loc", loc);
	              
	           // super.setRedirect(false);   
	              super.setViewPage("/WEB-INF/msg.jsp");
				
				
			}
			
		}
				
		
		
	}
		
		
		


}
