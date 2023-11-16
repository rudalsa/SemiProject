package buy.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import net.nurigo.java_sdk.api.Message;
import login.controller.GoogleMail;
import member.domain.MemberVO;
import shop.domain.GameVO;
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
			String optinfono_join = request.getParameter("optinfono_join");
			String oqty_join = request.getParameter("oqty_join");
			String totalPrice_join = request.getParameter("totalPrice_join");
			String cartno_join = request.getParameter("cartno_join");
			
			
			
			System.out.println(sum_totalPrice); // 460000
			System.out.println(sum_totalPoint); // 100 
			System.out.println(optinfono_join);    // 300,332
			System.out.println(oqty_join);		// 3,5
			System.out.println(totalPrice_join);// 230000,230000
			System.out.println(cartno_join);	// 24,17
			System.out.println(getOdrcode());   // bz20231101-1
			
			
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
			String odrcode = getOdrcode();	
		    // 주문테이블(tbl_order) 에 insert 할 데이터
			paraMap.put("odrcode", odrcode); // 주문코드(명세서번호)
		    // getOdrcode() 메소드는 위에서 정의한 전표 (주문코드)를 생성해주는 것이다.
		        
			HttpSession session = request.getSession();
		    MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		         
				
		    // 주문테이블(tbl_order) 에 insert 할 데이터
		    paraMap.put("user_id", loginuser.getUser_id()); // 회원ID
		    paraMap.put("sum_totalPrice", sum_totalPrice ); // 주문총액
		    paraMap.put("sum_totalPoint", sum_totalPoint ); // 주문총포인트
		    
		    
		    // === 주문상세테이블(tbl_orderdetail)에 insert 할 데이터 ===
		         
		    String[] optinfono_arr = optinfono_join.split("\\,"); // 여러개 제품을 주문한 경우          ex) "5,4,61".split("\\,"); ==> ["5","4","61"]
		                                     				// 장바구니에서 제품 1개만 주문한 경우  ex) "5".split("\\,");      ==> ["5"]
		                                     			    // 특정제품을 바로주문하기를 한 경우    ex) "5".split("\\,");      ==> ["5"]
		         							 			    // 
		         
		   String[] oqty_arr = oqty_join.split("\\,");
		   String[] totalPrice_arr = totalPrice_join.split("\\,");
		         
		         
           paraMap.put("optinfono_arr", optinfono_arr);
           paraMap.put("oqty_arr", oqty_arr);
           paraMap.put("totalPrice_arr", totalPrice_arr);
		 
	
		   // === 장바구니테이블(tbl_tbl_order)에 delete 할 데이터 ===
		   if(cartno_join != null) {
		       //  특정제품을 바로주문하기를 한 경우라면 str_cartno_join 값은 null 이 된다.
		            
		       String[] cartno_arr = cartno_join.split("\\,");
		        
		       paraMap.put("cartno_arr", cartno_arr);
		     
		   }
		         
		   // **** Transaction 처리를 해주는 메소드 호출하기 **** //
				
		   int isSuccess = pdao.orderAdd(paraMap); // 내일 11-02 일에 할 것임
		   
			
		   // **** 주문이 완료되었을시 세션에 저장되어져 있는 loginuser 정보를 갱신하고  
		   //      이어서 주문이 완료되었다라는 email 보내주기  **** //
				
		  	
		   if(isSuccess == 1) {
					
		   // 세션에 저장되어져 있는 loginuser 정보를 갱신
		   
		   loginuser.setUser_payment(loginuser.getUser_payment() + Integer.parseInt(sum_totalPrice) );
	       loginuser.setUser_coin(loginuser.getUser_coin() + Integer.parseInt(sum_totalPoint) );   
		   
	       
	    // 시작 이어서 주문이 완료되었다라는 email 보내주기  **** //
			GoogleMail mail = new GoogleMail(); 
			
			// str_pnum_join 5,4,61 "swkm,kjkm,kkk" 우리조는 '' 꼭해줘야함 "'kkk','kdjh','ajls'" ;
			
			String optnoes = "'"+String.join("','", optinfono_join.split("\\,"))+"'";	// str_pnum_join.split("\\,") ==> ["5","4","61"]
			// ["5","4","61"]
			// " 5 ' , 4 ' , 61 ' " 띄워쓰기는 잘보이게 하려고 한 것 임
			// " ' 5 ' , ' 4 ' , ' 61 ' " 띄워쓰기는 잘보이게 하려고 한 것 임
			
			//System.out.println("확인용 주문한 제품번호 optnoes "+ optnoes);
			
			// 주문한 제품에 대해 email 보내기시 email 내용에 넣을 주문한 제품번호들에 대한 제품정보를 얻어오는 것
			List<GameVO> jumungameList = pdao.getJumungameList(optnoes);
			
			// 주문한 제품에 대해 email 보내기시 email 내용에 넣을 주문한 제품번호들에 대한 제품정보를 얻어오는 것
			StringBuilder sb = new StringBuilder();
	              
	            sb.append("<body style='margin-top: 5%; box-sizing: border-box;'>");
	            sb.append("<section class='cart' style='width: 80%; margin: auto; padding: 30px;'>");
	            sb.append("<div class='cart__information'>");
	            sb.append("<ul style='background-color: whitesmoke; padding: 30px; margin-bottom: 50px; border: whitesmoke solid 1px; border-radius: 5px; font-size: 13px; font-weight: 300;'>");
	            sb.append("<li><span style='color: limegreen;'>저희 쇼핑몰을 찾아주셔서 감사합니다.</span></li>");
	            sb.append("<li>청약철회는 7일 이내 가능합니다.</li>");
	            sb.append("<li>오늘출발 상품은 판매자 설정 시점에 따라 오늘출발 여부가 변경될 수 있으니 주문 시 꼭 다시 확인해 주시기 바랍니다.</li>");
	            
	            sb.append("</ul>");
	            sb.append("</div>");
	            
	            sb.append("<table class='cart__list' style='border-top: solid 1.5px black; border-collapse: collapse; width: 100%; font-size: 14px;'>");
	            sb.append("<thead style='text-align: center; font-weight: bold;'>");
	            sb.append("<div style='text-align: center; margin-bottom: 3%;'><span style='font-size: 20pt;'>"+loginuser.getUser_name()+"님 주문 내역입니다.</span></div>");
	            sb.append("<tr>");
	            sb.append("<td style='padding: 15px 0px; border-bottom: 1px solid lightgrey;'><input type='hidden'></td>");
	            sb.append("<td style='padding: 15px 0px; border-bottom: 1px solid lightgrey;' colspan='2'>상품정보</td>");
	            sb.append("<td style='padding: 15px 0px; border-bottom: 1px solid lightgrey;'>상품금액</td>");
	            sb.append("<td style='padding: 15px 0px; border-bottom: 1px solid lightgrey;'>배송비</td>");
	            sb.append("</tr>");
	            sb.append("</thead>");
	            
	            sb.append("<tbody style='font-size: 12px;'>");
	            
	            
	            for(int i=0; i<jumungameList.size(); i++) {
	            	
	            sb.append("<tr class='cart__list__detail' style='vertical-align: top;'>");
	            sb.append("<td style='padding: 15px 0px; border-bottom: 1px solid lightgrey;'></td>");
	            sb.append("<td style=\'padding: 15px 0px; border-bottom: 1px solid lightgrey;'><img style='display: block; width: 80%; height: 80px; margin: auto;' src='http://127.0.0.1:9090/SemiProject/img/tbl_game_product_image/"+jumungameList.get(i).getOptvo().getImgfile()+"' alt='blz'></td>");
	            sb.append("<td style='padding: 15px 0px; border-bottom: 1px solid lightgrey; border-left: 2px solid whitesmoke; text-align: center;'><a style='color: black; font-size: 12px;'>"+jumungameList.get(i).getG_company()+"</a><span style='margin: 0; font-size: 12px; color: gray' class='cart__list__smartstore'> 스마트스토어</span>");
	            sb.append("<p style=\'margin: 0; margin-top: 6px; font-weight: bold; text-align: center;'>"+jumungameList.get(i).getG_content()+"</p>");
	            sb.append("<span style='margin: 0; text-align: center;' class='price'>"+jumungameList.get(i).getOptvo().getOpt_sale_price()+"</span>");
	            sb.append("</td>");
	            sb.append("<td style='padding: 20px;; border-bottom: 1px solid lightgrey; vertical-align: top; border-left: 2px solid whitesmoke;' class='cart__list__option'>");
	            sb.append("<p style='margin: 0; margin-bottom: 10px; position: relative;'>상품명 : "+jumungameList.get(i).getOptvo().getOpt_name()+"</p>");
	            sb.append("</td>");
	            sb.append("<td style='margin-top:5%'>");
	            sb.append("<span style='line-height: 500%;'>무료배송</span>");
	            sb.append("</td>");
	            sb.append("</tr>");
	            
	            sb.append("<br/>");
	        	
	        	
	        } // end of for -----
	            
	        sb.append("</tbody>");
	        sb.append("</table>");
	        sb.append("</section>");    
	        
	        sb.append("<div style='text-align: center;'><img src='http:/127.0.0.1:9090/SemiProject/img/tbl_game_product_image/mail.jpg'/></div>");
            sb.append("<div style='text-align: center; margin-top:2%'>");
            sb.append("<span>김경민 엔터테인먼트 주식 회사</span> <br>");
            sb.append("<span>주소: 06164 서울시 강남구 테헤란로 521 파르나스타워 15층</span> <br>");
            sb.append("<span>대표 번호: 1644-0727 | 팩스 번호: (02)544-3038 | 이메일: websupport@blizzard.co.kr</span> <br>");
            sb.append("<span>사업자 등록 번호: 211-87-49910 | 통신 판매업 신고 번호: 강남-6017호</span> <br>");
            sb.append("<span>대표이사: 서영학 | 개인정보 보호책임자: 박승우</span>");
            sb.append("<br/><br/>이용해 주셔서 감사합니다.");
            sb.append("</div>");
            sb.append("</body>");
			
	        
	         
	        String emailContents = sb.toString();
	         
	        mail.sendmail_OrderFinish(loginuser.getUser_email(), loginuser.getUser_name(), emailContents);
	        // 끝 이어서 주문이 완료되었다라는 email 보내주기  **** //
			
	        // 메일 끝나고  
	        
	        //String api_key = "발급받은 본인의 API Key";  // 발급받은 본인 API Key
            String api_key = "NCSIQDXMOEEYSYZC";  // 서영학꺼임
            //String api_secret = "발급받은 본인의 API Secret";  // 발급받은 본인 API Secret
            String api_secret = "OIBOXYYZA7AN4XMMUPO7WATULJYXXAL6";  // 서영학꺼임
            Message coolsms = new Message(api_key, api_secret);
            // net.nurigo.java_sdk.api.Message 임. 
            // 먼저 다운 받은  javaSDK-2.2.jar 를 /MyMVC/WebContent/WEB-INF/lib/ 안에 넣어서  build 시켜야 함.
                        
            // == 4개 파라미터(to, from, type, text)는 필수사항이다. == 
            HashMap<String, String> Map = new HashMap<String, String>();
            Map.put("to", loginuser.getUser_phone() ); // 수신번호
            Map.put("from", "01031417056"); // 발신번호
            Map.put("type", "SMS"); // Message type ( SMS(단문), LMS(장문), MMS, ATA )
            
          
	
            Map.put("text", "저희 쇼핑몰에서 "+loginuser.getUser_name()+"님 의"+sum_totalPrice+" 가 정상적으로 결제되었습니다. 적립된 포인트는" +sum_totalPoint+ " 입니다. 적립된 포인트는 다음결제에 자동으로 사용됩니다. "); // 문자내용    
            Map.put("app_version", "JAVA SDK v2.2"); // application name and version
                        
            //    ==  아래의 파라미터는 필요에 따라 사용하는 선택사항이다. == 
            //   paraMap.put("mode", "test"); // 'test' 모드. 실제로 발송되지 않으며 전송내역에 60 오류코드로 뜹니다. 차감된 캐쉬는 다음날 새벽에 충전 됩니다.
            //   paraMap.put("image", "desert.jpg"); // image for MMS. type must be set as "MMS"
            //   paraMap.put("image_encoding", "binary"); // image encoding binary(default), base64 
            //   paraMap.put("delay", "10"); // 0~20사이의 값으로 전송지연 시간을 줄 수 있습니다.
            //   paraMap.put("force_sms", "true"); // 푸시 및 알림톡 이용시에도 강제로 SMS로 발송되도록 할 수 있습니다.
            //   paraMap.put("refname", ""); // Reference name
            //   paraMap.put("country", "KR"); // Korea(KR) Japan(JP) America(USA) China(CN) Default is Korea
            //   paraMap.put("sender_key", "5554025sa8e61072frrrd5d4cc2rrrr65e15bb64"); // 알림톡 사용을 위해 필요합니다. 신청방법 : http://www.coolsms.co.kr/AboutAlimTalk
            //   paraMap.put("template_code", "C004"); // 알림톡 template code 입니다. 자세한 설명은 http://www.coolsms.co.kr/AboutAlimTalk을 참조해주세요. 
            //   paraMap.put("datetime", "20230106153000"); // Format must be(YYYYMMDDHHMISS) 2023 01 06 15 30 00 (2023 Jan 06th 3pm 30 00)
            //   paraMap.put("mid", "mymsgid01"); // set message id. Server creates automatically if empty
            //   paraMap.put("gid", "mymsg_group_id01"); // set group id. Server creates automatically if empty
            //   paraMap.put("subject", "Message Title"); // set msg title for LMS and MMS
            //   paraMap.put("charset", "euckr"); // For Korean language, set euckr or utf-8
            //   paraMap.put("app_version", "Purplebook 4.1") // 어플리케이션 버전
                                          
            JSONObject jsonbj = (JSONObject) coolsms.send(Map);
                      
		   ////////// === 주문이 완료되었다는 email 보내기 시작 === ///////////
					
		   }
		   
		   JSONObject jsobj = new JSONObject(); // {}
	       jsobj.put("isSuccess", isSuccess);    // {"isSuccess":0} or 1
	             
	       String json = jsobj.toString();
	       request.setAttribute("json", json);
	             
	       super.setRedirect(false);
	       super.setViewPage("/WEB-INF/jsonview.jsp");

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


