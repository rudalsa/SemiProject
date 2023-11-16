package buy.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import game.model.GameOptDAO;
import game.model.GameOptDAO_imple;
import shop.domain.GameVO;

public class OneOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		boolean isLogin = super.checkLogin(request);

		if (!isLogin) { // 로그인을 하지 않은 상태이라면

			/*
			 * 사용자가 로그인을 하지 않은 상태에서 특정제품을 장바구니에 담고자 하는경우 사용자가 로그인을 하면 장바구니에 담고자 했던 그 특정제품
			 * 페이지로 이동하도록 해야한다. 이와 같이 하려고 ProdViewAction 클래스에서 super.goBackURL(request);
			 * 해두었음.
			 */

			request.setAttribute("message", "구매하려면 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()");

			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");

			return;

		}

		else {
			// 로그인 한 상태이라면
			// 장바구니 테이블에 해당 제품이 존재하지 않는 경우에는 tbl_cart 테이블에 insert 를 해야하고,
			// 장바구니 테이블에 해당 제품이 존재하는 경우에는 또 그 제품을 추가해서 장바구니 담기를 한다라면 tbl_cart 테이블에 update 를
			// 해야한다.

			String method = request.getMethod();

			if ("POST".equalsIgnoreCase(method)) {
				
				String optno = request.getParameter("optno"); // 가격
				String oqty = request.getParameter("oqty");

				GameOptDAO goptdao = new GameOptDAO_imple();


				GameVO gvo = goptdao.selectOrder(optno);
				
				Map<String, String> sumMap = goptdao.selectSumPricePoint(oqty, optno);
				
				request.setAttribute("gvo", gvo);
				request.setAttribute("oqty", oqty);
				request.setAttribute("sumMap", sumMap);
				
				// super.setRedirect(false);
				super.setViewPage("/WEB-INF/shop/oneorderinfo.jsp");

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
