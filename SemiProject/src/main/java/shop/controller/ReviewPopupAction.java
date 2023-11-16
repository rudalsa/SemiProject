package shop.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import shop.domain.GameVO;
import shop.model.MainShopDAO;
import shop.model.MainShopDAO_imple;

public class ReviewPopupAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		MainShopDAO sdao = new MainShopDAO_imple();
		
		String g_code = request.getParameter("g_code");
		
		System.out.println(g_code);
		
		try {
	         List<GameVO> gameList = sdao.ShopListSelectAll();
	         
	         
	         request.setAttribute("g_code", g_code);
	         
	         super.setRedirect(false);
	 		 super.setViewPage("/WEB-INF/shop/popup.jsp");
	         
	      } catch(SQLException e) {
	         e.printStackTrace();
	         super.setRedirect(true);
	         super.setViewPage(request.getContextPath()+"/error.bz");
	      }
		
		/*
		 * request.setAttribute(getViewPage(), response);
		 */
		
		

	}

}
