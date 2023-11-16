package game.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import shop.domain.GameCarinfoVO;
import shop.model.*;

public class OvwcarinfoAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String g_code = request.getParameter("g_code");
		
		OvwcarinfoDAO odao = new OvwcarinfoDAO_imple();
		
		// System.out.println(g_code);
		
		try { 
		List<GameCarinfoVO> ociList = odao.ovwCarinfoListSelectAll(g_code);
		
		request.setAttribute("ociList", ociList); 
		//super.setRedirect(false);
		super.setViewPage("/WEB-INF/shop/ovwcarinfo.jsp");
		
		
		} catch (SQLException e) { 
			e.printStackTrace(); 
		super.setRedirect(true);
		super.setViewPage(request.getContextPath()+"/error.bz"); }
		
	}

}
