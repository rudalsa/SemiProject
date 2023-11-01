package shop.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import shop.model.*;
public class NewshopAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// === Ajax(JSON) 를 사용하여 HIT 상품목록 "스크롤" 방식으로 페이징 처리해서 보여주겠다. === //
		ProductDAO pdao = new ProductDAO_imple();
		
		
		int SpecCount = pdao.totalSpecCount("100"); // 나중에 파라미터 밭아 올거임.
		System.out.println("확인용 SpecCount => " + SpecCount );
		// 확인용 SpecCount => 30
				
		request.setAttribute("SpecCount", SpecCount);
		
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/newshop.jsp");
		
	}

}
