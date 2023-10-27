package b_shop.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import b_shop.domain.*;
import b_shop.model.*;
import common.controller.AbstractController;

public class MainShopAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		MainShopDAO sdao = new MainShopDAO_imple();
		
		try {
	         List<GameVO> gameList = sdao.ShopListSelectAll();
	         
	         request.setAttribute("gameList", gameList);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/shop/mainShop.jsp");
	         
	      } catch(SQLException e) {
	         e.printStackTrace();
	         super.setRedirect(true);
	         super.setViewPage(request.getContextPath()+"/error.bz");
	      }

	} // end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception --- 

}
