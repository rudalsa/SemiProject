package buy.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;
import shop.domain.CartVO;
import shop.model.*;


public class CartListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 장바구니 보기는 반드시 해당사용자가 로그인을 해야만 볼 수 있다.
				boolean isLogin = super.checkLogin(request);
				
				if(!isLogin) {
					request.setAttribute("message", "장바구니를 보려면 먼저 로그인 부터 하세요!!");
					request.setAttribute("loc", "javascript:history.back()"); 
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
				
				else {
					// 로그인을 했을 경우 
					
					/*
					 * 
					 * 
					 * String paymoney = (String) session.getAttribute("paymoney");
					 * 
					 * System.out.println("확인용 :" + paymoney);
					 */
					
					HttpSession session = request.getSession();
					MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
					
					ProductDAO pdao = new ProductDAO_imple();
					
					List<CartVO> cartList = pdao.selectProductCart(loginuser.getUser_id());
					Map<String,String> sumMap = pdao.selectCartSumPricePoint(loginuser.getUser_id());
					
					request.setAttribute("cartList", cartList);
					request.setAttribute("sumMap", sumMap);
					
					super.setViewPage("/WEB-INF/shop/cartList.jsp");
				}
				
				
				
			}
		
	}


