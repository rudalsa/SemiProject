package shop.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import shop.domain.GameVO;
import shop.model.*;

public class ShopDisplayItemJSONAction extends AbstractController {

		
		@Override
		public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			// js 안의 json 데이터들을 파라미터로 받아온 것
			String c_no = request.getParameter("c_no"); // 씨크드 받아옴
			String start = request.getParameter("start");
			String amount = request.getParameter("amount");
			
			System.out.println("뜨나?"+c_no);
			
			/*
	        맨 처음에는 s_name("???")상품을  start("1") 부터 amount("8")개를 보여준다.
	        더보기... 버튼을 클릭하면  s_name("???")상품을  start("9") 부터 amount("8")개를 보여준다.
	        또  더보기... 버튼을 클릭하면  s_name("???")상품을  start("17") 부터 amount("8")개를 보여준다.      
			*/
			
			ProductDAO pdao = new ProductDAO_imple();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("c_no", c_no); 
			paraMap.put("start", start); // start    "1"   "9"   "17"    "24"
			
			String end = String.valueOf(Integer.parseInt(start) + Integer.parseInt(amount) - 1);
			paraMap.put("end", end); // end => start + len - 1    
									 // end     "8"   "16"   "24"   "32"   "40"
			
			List<GameVO> gameList = pdao.selectByno(paraMap);
			
			JSONArray jsonArr = new JSONArray(); // [] 이모양임.
			
			if( gameList.size() > 0) {
				// DB에서 조회해온 결과물이 있을 경우
				
				for(GameVO gavo : gameList) { // gameList 사이즈 만큼 반복
					
					JSONObject jsonObj = new JSONObject(); // {}
					jsonObj.put("g_no", gavo.getG_no());   // {"pnum":1}
					jsonObj.put("g_code", gavo.getG_code()); // {코드}
					jsonObj.put("g_name", gavo.getG_name()); // {"pnum":1, "pname":"스마트TV"}
					jsonObj.put("c_name", gavo.getCategvo().getC_name()); // {"pnum":1, "pname":"스마트TV", "cname":"전자제품"}
					jsonObj.put("g_company", gavo.getG_company());
					jsonObj.put("g_img_1", gavo.getG_img_1());
					jsonObj.put("g_img_2", gavo.getG_img_2());
					jsonObj.put("g_qty", gavo.getG_qty());
					jsonObj.put("g_price", gavo.getG_price());
					jsonObj.put("g_sale_price", gavo.getG_sale_price());
					jsonObj.put("s_name", gavo.getSpvo().getS_name());
					jsonObj.put("g_content", gavo.getG_content());
					jsonObj.put("g_coin", gavo.getG_coin());
					jsonObj.put("g_inputdate", gavo.getG_inputdate());
					
					jsonObj.put("discountPercent", gavo.getDiscountPercent()); // productVO 에 이미 함수를 만들어둠.
					
					// 어째 어째 잘 넘어옴 확인했음
					
					jsonArr.put(jsonObj);  
					
				} // end of for ------------------------
				
			} // end of if ---------------------------------------------------------
			
			String json = jsonArr.toString(); // 문자열로 변환
			
			// System.out.println("확인용 json => " + json); 잘나옴
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		
		
	}

}
