package shop.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import shop.domain.*;
import shop.model.*;

public class MainShopAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		MainShopDAO msdao = new MainShopDAO_imple();
		
		try {
	         List<MainShopVO> imgProductList = msdao.ShopListSelectAll();
	         List<ShopPopProductVO> popProductList = msdao.PopListSelectAll();
	         
	         request.setAttribute("imgProductList", imgProductList);
	         request.setAttribute("popProductList", popProductList);
	         
	         super.setRedirect(false);
	         super.setViewPage("/WEB-INF/shop/mainShop.jsp");
	         
	      } catch(SQLException e) {
	         e.printStackTrace();
	         super.setRedirect(true);
	         super.setViewPage(request.getContextPath()+"/error.bz");
	      }

	} // end of public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception --- 

}
