package buy.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;
import shop.model.*;

public class OrderAddAction extends AbstractController {

	private ProductDAO pdao = new ProductDAO_imple();
		
	// === 전표(주문코드)를 생성해주는 메소드 생성하기 === // 
		
	private String getOdrcode() {
			
		// 주문코드 형식 : s+날짜+sequence ==> s20230503-1
		int seq = 0;
			
		// 날짜 생성
		Date now = new Date();
		SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd"); 
		String today = smdatefm.format(now);
			
		try {
			seq =pdao.get_seq_tbl_order();
			// 이것은 "주문코드(명세서번호) 시퀀스" seq_tbl_order 값을 채번해오는 것.
		}catch(SQLException e) {
			e.printStackTrace();
		}
			
		return "bz"+today+"-"+seq;
		
		} // end of private String getOdrcode() ------

	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		String method = request.getMethod();
			
		if("POST".equalsIgnoreCase(method)) {
			
			//POST 방식이라면
		    		
			String sum_totalPrice = request.getParameter("sum_totalPrice");
			String sum_totalPoint = request.getParameter("sum_totalPoint");
			String g_code_join = request.getParameter("g_code_join");
			String oqty_join = request.getParameter("oqty_join");
			String totalPrice_join = request.getParameter("totalPrice_join");
			String cartno_join = request.getParameter("cartno_join");
			
			/*
			System.out.println(sum_totalPrice); // 460000
			System.out.println(sum_totalPoint); // 100 
			System.out.println(g_code_join);    // 300,332
			System.out.println(oqty_join);		// 3,5
			System.out.println(totalPrice_join);// 230000,230000
			System.out.println(cartno_join);	// 24,17
			System.out.println(getOdrcode());   // bz20231101-1
			*/
			
			// ===== Transaction 처리하기 ===== // 
			// 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기 
	        // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
	        // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
	        // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
			        
	        // 5. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete)하기(수동커밋처리)
	        // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 
			        
	        // 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sumtotalPrice 만큼 감하고, point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
	        // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
	        // 8. **** SQL 장애 발생시 rollback 하기(rollback) **** 
			   
	        // === Transaction 처리가 성공시 세션에 저장되어져 있는 loginuser 정보를 새로이 갱신하기 ===
			// === 주문이 완료되었을시 주문이 완료되었다라는 email 보내주기  === // 	
			
			
			Map<String, Object> paraMap = new HashMap<>();
				
		    // 주문테이블(tbl_order) 에 insert 할 데이터
			paraMap.put("odrcode", getOdrcode()); // 주문코드(명세서번호)
		    // getOdrcode() 메소드는 위에서 정의한 전표 (주문코드)를 생성해주는 것이다.
		        
				
				
			HttpSession session = request.getSession();
		    MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		         
				
		    // 주문테이블(tbl_order) 에 insert 할 데이터
		    paraMap.put("user_id", loginuser.getUser_id()); // 회원ID
		    paraMap.put("sum_totalPrice", sum_totalPrice ); // 주문총액
		    paraMap.put("sum_totalPoint", sum_totalPoint ); // 주문총포인트
		         
		    // === 주문상세테이블(tbl_orderdetail)에 insert 할 데이터 ===
		         
		    String[] g_code_arr = g_code_join.split("\\,"); // 여러개 제품을 주문한 경우          ex) "5,4,61".split("\\,"); ==> ["5","4","61"]
		                                     				// 장바구니에서 제품 1개만 주문한 경우  ex) "5".split("\\,");      ==> ["5"]
		                                     			    // 특정제품을 바로주문하기를 한 경우    ex) "5".split("\\,");      ==> ["5"]
		         							 			    // 
		         
		   String[] oqty_arr = oqty_join.split("\\,");
		   String[] totalPrice_arr = totalPrice_join.split("\\,");
		         
		         
           paraMap.put("g_code_arr", g_code_arr);
           paraMap.put("oqty_arr", oqty_arr);
           paraMap.put("totalPrice_arr", totalPrice_arr);
		 
	
		   // === 장바구니테이블(tbl_tbl_order)에 delete 할 데이터 ===
		   if(cartno_join != null) {
		       //  특정제품을 바로주문하기를 한 경우라면 str_cartno_join 값은 null 이 된다.
		            
		       String[] cartno_arr = cartno_join.split("\\,");
		        
		       paraMap.put("cartno_arr", cartno_arr);
		     
		   }
		         
		   // **** Transaction 처리를 해주는 메소드 호출하기 **** //
				
		   // int isSuccess = pdao.orderAdd(paraMap); 내일 11-02 일에 할 것임
		   
			
		   // **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고  
		   //      이어서 주문이 완료되었다라는 email 보내주기  **** //
				
		   /*		
		   if(isSuccess == 1) {
					
		   // 세션에 저장되어져 있는 loginuser 정보를 갱신
					
		   ////////// === 주문이 완료되었다는 email 보내기 시작 === ///////////
					
		   }
		   */	
				
				
		
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


