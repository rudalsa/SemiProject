package shop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import shop.domain.PurchaseReviewsVO;
import shop.model.*;

public class ReviewListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_g_code = request.getParameter("fk_g_code"); // prodView.jsp 에서 getParameter를 이용해 "fk_pnum" 을 가져옴

		ProductDAO pdao = new ProductDAO_imple();
	      List<PurchaseReviewsVO> reviewList = pdao.reviewList(fk_g_code);
	      
	      JSONArray jsArr = new JSONArray(); // 결과물이 복수개 이므로 배열형식으로 json 생성
	      
	      if(reviewList != null && reviewList.size() > 0) { // new 해왔기 때문에 null 은 있을 수 없다.
	         for(PurchaseReviewsVO reviewsvo : reviewList) {
	            JSONObject jsobj = new JSONObject();                // {} {}
	            jsobj.put("contents", reviewsvo.getContents());     // {"contents":"제품후기내용물"}  {"contents":"제품후기내용물2"}
	            jsobj.put("name", reviewsvo.getMvo().getUser_name());    // {"contents":"제품후기내용물", "name":"작성자이름"}   {"contents":"제품후기내용물2", "name":"작성자이름2"}      
	            jsobj.put("writeDate", reviewsvo.getWriteDate());   // {"contents":"제품후기내용물", "name":"작성자이름", "writeDate":"작성일자"}   {"contents":"제품후기내용물2", "name":"작성자이름2", "writeDate":"작성일자2"}  
	            jsobj.put("userid", reviewsvo.getFk_user_id());      // {"contents":"제품후기내용물", "name":"작성자이름", "writeDate":"작성일자", "userid":"사용자아이디1"}   {"contents":"제품후기내용물2", "name":"작성자이름2", "writeDate":"작성일자2", "userid":"사용자아이디2"}  
	            jsobj.put("review_seq", reviewsvo.getReview_seq()); // {"contents":"제품후기내용물", "name":"작성자이름", "writeDate":"작성일자", "userid":"사용자아이디1", "review_seq":제품후기글번호}   {"contents":"제품후기내용물2", "name":"작성자이름2", "writeDate":"작성일자2", "userid":"사용자아이디2", "review_seq":제품후기글번호2} 
	            
	            jsArr.put(jsobj);

	         }// end of for----------------------
	      }
	      
	      String json = jsArr.toString();  // 문자열 형태로 변환해줌.
	      System.out.println(json);
	      request.setAttribute("json", json);
	      
	   //   super.setRedirect(false);
	      super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
