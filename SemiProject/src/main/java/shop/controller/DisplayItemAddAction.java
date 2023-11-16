package shop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import shop.model.*;
import shop.domain.*;
public class DisplayItemAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String c_code = request.getParameter("c_code");
		
		// === Ajax(JSON) 를 사용하여 HIT 상품목록 "스크롤" 방식으로 페이징 처리해서 보여주겠다. === //
		ProductDAO pdao = new ProductDAO_imple();
		
		int CateGoryCount = pdao.totalCateGoryCount(c_code); // 나중에 파라미터 밭아 올거임.
		
		int c_no = pdao.CateGoryno(c_code); // 나중에 파라미터 밭아 올거임.
		
		List<GameVO> cateList =  pdao.CarouselList(c_code); // c_code 받아와서 이미지 뿌릴예정
		
		
		// System.out.println("확인용 CateGoryCount => " + CateGoryCount );
		// 확인용 SpecCount => 30
				
		request.setAttribute("CateGoryCount", CateGoryCount);
		
		request.setAttribute("c_no", c_no);
		
		request.setAttribute("cateList", cateList);
		
		// System.out.println("확인용"+c_no);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/itemshop.jsp");
		
	}

}
