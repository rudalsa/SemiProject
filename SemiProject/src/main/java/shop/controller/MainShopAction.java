package shop.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import shop.domain.*;
import common.controller.AbstractController;
import shop.model.*;

public class MainShopAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		MainShopDAO sdao = new MainShopDAO_imple();
		MainpageDAO mpdao = new MainPage_imple();
		
		try {
	         List<MainsdVO> sdList = mpdao.sdimageSelectAll();
	         request.setAttribute("sdList", sdList);

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
