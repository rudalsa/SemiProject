package shop.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import gameopt.domain.OptVO;
import shop.domain.*;


public class ProductDAO_imple implements ProductDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.  
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public ProductDAO_imple() {
		
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
		    
		} catch(NamingException e) {
			e.printStackTrace();
		}
		
	}
	
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}

	
	// 카테고리 목록을 조회해오기
	@Override
	public List<CategoryVO> selectCategoryList() throws SQLException{
		
		List<CategoryVO> categoryList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select c_no, c_code, c_name "
					   + " from tbl_game_category "
					   + " order by c_no asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CategoryVO cvo = new CategoryVO();
				cvo.setC_no(rs.getInt(1));
				cvo.setC_code(rs.getString(2));
				cvo.setC_name(rs.getString(3));
			
				categoryList.add(cvo);
				
			} // end of while

			
		} finally {
			close();
		}
		
		return categoryList;
	}// end of public List<CategoryVO> selectCategoryList() throws SQLException-------------------


	
	// SPEC 목록을 조회해오기
	@Override
	public List<SpecVO> selectSpecList() throws SQLException {
		
		List<SpecVO> specList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select s_code, s_name "
					   + " from tbl_game_spec "
					   + " order by s_code asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				SpecVO spvo = new SpecVO();
				spvo.setS_code(rs.getString(1));
				spvo.setS_name(rs.getString(2));

				specList.add(spvo);
				
			} // end of while -----


			
			
		} finally {
			close();
		}
		return specList;
	}// end of public List<SpecVO> selectSpecList() throws SQLException----------------


	
	// 게임순서번호 채번 해오기
	@Override
	public int getG_codeOfProduct() throws SQLException {
		
		int g_code = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select seq_tbl_game_product_g_code.nextval AS G_CODE "
					   + " from dual ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			g_code = Integer.parseInt(rs.getString(1));
		} finally {
			close();
		}

		return g_code;
	}// end of public int getG_noOfProduct() throws SQLException------------------------------


	
	// tbl_product 테이블에 제품정보 insert 하기
	@Override
	public int productInsert(GameVO gamevo) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_game_product(g_no, g_code, g_name, fk_c_code, g_company, g_img_1, g_img_2, g_qty, g_price, g_sale_price, fk_s_code, g_content, g_coin) "
					   + " values(seq_tbl_game_product_g_no.nextval,?,?,?,?,?,?,?,?,?,?,?,?) "; 
					   
			
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setString(1, gamevo.getG_code());
	        pstmt.setString(2, gamevo.getG_name());
	        pstmt.setString(3, gamevo.getFk_c_code());    
	        pstmt.setString(4, gamevo.getG_company()); 
	        pstmt.setString(5, gamevo.getG_img_1());    
	        pstmt.setString(6, gamevo.getG_img_2());
	        pstmt.setInt(7, gamevo.getG_qty()); 
	        pstmt.setInt(8, gamevo.getG_price());
	        pstmt.setInt(9, gamevo.getG_sale_price());
	        pstmt.setString(10, gamevo.getFk_s_code());
	        pstmt.setString(11, gamevo.getG_content());
	        pstmt.setInt(12, gamevo.getG_coin());
			
	        result = pstmt.executeUpdate();
			
		} finally {
			close();
		}

		return result;
	}// end of public int productInsert(ProductVO pvo) throws SQLException---------------


	
	// tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 하기
	@Override
	public int tbl_product_optinfo_insert(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_product_optinfo(optinfono, fk_g_code, imgfile, opt_name, opt_price, opt_sale_price) "
					   + " values(tbl_product_optinfo_optinfono.nextval, ?, ?, ?, ?, ?) "; 
					   
			
			pstmt = conn.prepareStatement(sql);
			
	        pstmt.setInt(1, Integer.parseInt(paraMap.get("g_code")));
	        pstmt.setString(2, paraMap.get("attachimg"));
	        pstmt.setString(3, paraMap.get("attachName"));
	        pstmt.setInt(4, Integer.parseInt(paraMap.get("attachPrice")));
	        pstmt.setInt(5, Integer.parseInt(paraMap.get("attachSalePrice")));
	        
			
	        result = pstmt.executeUpdate();
			
		} finally {
			close();
		}

		return result;
	}

	// 로그인한 사용자의 장바구니 목록을 조회하기
	@Override
	public List<CartVO> selectProductCart(String user_id, String paymoney) throws SQLException {
		
		List<CartVO> cartList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT C.cartno, C.fk_userid, C.fk_g_code, C.oqty, p.g_name, P.g_img_1, o.opt_name, o.opt_sale_price, p.g_coin, p.g_qty "
					+ "    FROM ( "
					+ "    SELECT cartno, fk_userid, fk_g_code, registerday, oqty "
					+ "    FROM tbl_game_cart "
					+ "    WHERE fk_userid = ? "
					+ "    ) C "
					+ "    JOIN tbl_game_product P ON C.fk_g_code = P.g_code "
					+ "    JOIN TBL_PRODUCT_OPTINFO O ON o.opt_sale_price = ?" ;
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			pstmt.setString(2, paymoney);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				
				cnt++;
				
				if(cnt == 1) {
					cartList = new ArrayList<>();
				}
				
			
				int cartno = rs.getInt("CARTNO");
				
				String fk_userid = rs.getString("FK_USERID");
				String fk_g_code = rs.getString("FK_G_CODE");
				int oqty = rs.getInt("OQTY"); // 주문량
				String g_name = rs.getString("G_NAME");
				String g_img_1 = rs.getString("G_IMG_1");
				String opt_name = rs.getString("opt_name");
				int opt_sale_price = rs.getInt("OPT_SALE_PRICE");
				int g_coin = rs.getInt("G_COIN"); 
				int g_qty = rs.getInt("g_qty"); // 잔고량
				
				GameVO gvo = new GameVO();
				gvo.setG_code(fk_g_code);
				gvo.setG_name(g_name);
				gvo.setG_img_1(g_img_1);
				gvo.setG_coin(g_coin);
				gvo.setG_qty(g_qty);
				
				// ***** !!!! 중요함 !!!! ***** //
				gvo.setTotalPriceTotalPoint(oqty);
				// ***** !!!! 중요함 !!!! ***** //
				
				// 우리는 옵션도 해야함 //
				
				OptVO ovo = new OptVO();
				ovo.setOpt_sale_price(opt_sale_price);
				ovo.setOpt_name(opt_name);
				// 나중에 더 추가 //
				
				CartVO cvo = new CartVO();
				cvo.setCartno(cartno);
				cvo.setFk_userid(fk_userid);
				cvo.setFk_g_code(fk_g_code);
				cvo.setOqty(oqty);
				
				cvo.setGavo(gvo);
				cvo.setOpvo(ovo);
				
				cartList.add(cvo);
			}// end of while(rs.next())-------------------------------
			
			
		} finally {
			close();
		}
		
		return cartList;
		
		
	}

	// 장바구니 테이블에서 특정제품을 장바구니에서 비우기
	@Override
	public int delCart(String cartno) throws SQLException {
		
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_game_cart "
	                    + " where cartno = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, cartno);
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         
	    	  close();
	      
	      }
	      
	      return n;
		
	}

	// 장바구니 테이블에서 특정제품 수량을 수정하기
	@Override
	public int updateCart(Map<String, String> paraMap) throws SQLException {
		
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = "   update tbl_game_cart set oqty = ? "
	         			+ "   where cartno =  ?      ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, paraMap.get("oqty"));
	         pstmt.setString(2, paraMap.get("cartno"));
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
		}


	@Override
	public int get_seq_tbl_order() throws SQLException {
		
		int seq = 0;
	       
		try {
	           
			conn = ds.getConnection();
	           
	           
			String sql = " select seq_tbl_order_code.nextval AS seq "
	                   + " from dual";
	           
	           
			pstmt = conn.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	          
	        rs.next();
	          
	        seq = rs.getInt("seq");
	           
	       	  
		}  finally {
			close();
	       
		}
	      
		return seq;
		
		
	}

	// 하나의 스펙에 몇개의 게임이있는지 알아오는 것
	
	@Override
	public int totalSpecCount(String fk_s_code) throws SQLException {
		
	int SpecCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) "
					   + " from tbl_game_product "
					   + " where fk_s_code = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fk_s_code);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			SpecCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return SpecCount;
		
	}
	
	// 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라(start ~ end) 조회해오기
	@Override
	
	public List<GameVO> selectBySpecName(Map<String, String> paraMap) throws SQLException {
		
		List<GameVO> gameList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "\r\n"
					+ " SELECT g_no, g_code, g_name, c_name, G_COMPANY, G_IMG_1, G_IMG_2, g_qty, g_price, g_sale_price, s_name, g_content, g_coin, G_INPUTDATE "
					+ "	FROM "
					+ "	( " 
					+ "	select row_number() over(order by g_no desc) AS RNO "
					+ "	, g_no, g_code, g_name, C.c_name, G_COMPANY, G_IMG_1, G_IMG_2, g_qty, g_price, g_sale_price, S.s_name, g_content, g_coin "
					+ "	, to_char(G_INPUTDATE, 'yyyy-mm-dd') AS G_INPUTDATE "
					+ "	from tbl_game_product P "
					+ "	JOIN TBL_GAME_CATEGORY C "
					+ "	ON P.fk_c_code = C.c_code "
					+ "	JOIN tbl_game_spec S "
					+ "	ON P.fk_s_code = S.s_code "
					+ "	where S.s_name = ? "
					+ "	) V "
					+ "	WHERE RNO between ? and ? " ;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("s_name"));
			pstmt.setString(2, paraMap.get("start"));
			pstmt.setString(3, paraMap.get("end"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				GameVO gavo = new GameVO();
				
				gavo.setG_no(rs.getInt(1));              // 제품번호 
				gavo.setG_code(rs.getString(2));	     // 제품코드
				gavo.setG_name(rs.getString(3));	     // 제품명
				
				CategoryVO categvo = new CategoryVO();
				categvo.setC_name(rs.getString(4));      // 카테고리명
				gavo.setCategvo(categvo);
				
				gavo.setG_company(rs.getString(5));    // 제조회사명
				gavo.setG_img_1(rs.getString(6));     // 제품이미지1   이미지파일명
				gavo.setG_img_2(rs.getString(7));     // 제품이미지2   이미지파일명
				gavo.setG_qty(rs.getInt(8));           // 제품 재고량
	            gavo.setG_price(rs.getInt(9));          // 제품 정가
	            gavo.setG_sale_price(rs.getInt(10));      // 제품 판매가(할인해서 팔 것이므로)
	            
	       
	            
	            SpecVO spvo = new SpecVO();
	            spvo.setS_name(rs.getString(11));     // 스펙명
	            gavo.setSpvo(spvo);
	            
	            gavo.setG_content(rs.getString(12));   // 제품설명 
	            gavo.setG_coin(rs.getInt(13));         // 포인트 점수        
	            gavo.setG_inputdate(rs.getString(13)); // 제품입고일자  
	            
	            gameList.add(gavo);
			} // end of while() --------------------------------------------
			
		} finally {
			close();
		}
		
		return gameList;
	} // end of public List<ProductVO> selectBySpecName(Map<String, String> paraMap)

	// ===== Transaction 처리하기 ===== // 
    // 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기
    // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
    // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
    // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리)

    // 5. 장바구니 테이블에서 str_cartno_join 값에 해당하는 행들을 삭제(delete)하기(수동커밋처리)
    // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. <<

    // 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sum_totalPrice 만큼 감하고, point 를 sum_totalPoint 만큼
    // 더하기(update)(수동커밋처리)
    // 7. **** 모든처리가 성공되었을시 commit 하기(commit) ****
    // 8. **** SQL 장애 발생시 rollback 하기(rollback) ****   
	@Override
	public int orderAdd(Map<String, Object> paraMap) throws SQLException {
		int isSuccess = 0;
	    int n1=0, n2=0, n3=0, n4=0, n5=0;
	    
	    try {
	           conn = ds.getConnection();
	          
	           conn.setAutoCommit(false); // 수동커밋으로 전환
	          
	           // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
	           String sql = " insert into tbl_order(odrcode, fk_userid, odrtotalPrice, odrtotalPoint, odrdate) "
	                   		+ " values(?, ?, ?, ?, default) ";
	          
	           pstmt = conn.prepareStatement(sql);
	           
	           pstmt.setString(1, (String)paraMap.get("odrcode"));
	           pstmt.setString(2, (String)paraMap.get("user_id"));
	           pstmt.setInt(3, Integer.parseInt((String)paraMap.get("sum_totalPrice")));
	           pstmt.setInt(4, Integer.parseInt((String)paraMap.get("sum_totalPoint")));
	          
	           n1 = pstmt.executeUpdate();
	          
	           System.out.println("~~~~ 확인용 n1 : " + n1);
	           //   ~~~~ 확인용 n1 : 1 시발
	          
	           // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
	           if(n1 == 1) {
	           //   주문코드(명세서번호) --> (String)paraMap.get("odrcode");
	              String[] g_code_arr = (String[])paraMap.get("g_code_arr");             // 제품번호
	              String[] oqty_arr = (String[])paraMap.get("oqty_arr");             // 주문량
	              String[] totalPrice_arr = (String[])paraMap.get("totalPrice_arr"); // 주문가격
	             
	              int cnt = 0;
	              for(int i=0; i<g_code_arr.length; i++) {
	              
	                  sql = " insert into tbl_orderdetail(odrseqno , fk_odrcode , fk_g_code , oqty , odrprice , deliverStatus )"
	                		+ " values(seq_tbl_orderdetail.nextval, ?, to_number(?), to_number(?), to_number(?), default) ";
	                
	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setString(1, (String)paraMap.get("odrcode"));
	                  pstmt.setString(2, g_code_arr[i]);
	                  pstmt.setString(3, oqty_arr[i]);
	                  pstmt.setString(4, totalPrice_arr[i]);
	                
	                  pstmt.executeUpdate();
	                  
	                  cnt++;
	               }// end of for----------------------
	             
	               if(cnt == g_code_arr.length) {
	                   n2 = 1;
	               }
	               	   System.out.println("~~~~ 확인용 n2 : " + n2);
	               //   ~~~~ 확인용 n2 : 1
	             
	          }// end of if(n1 == 1)----------------
	          
	          // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리)
	          if(n2==1) {
	             
	              String[] g_code_arr = (String[])paraMap.get("g_code_arr"); // 제품번호
	              String[] oqty_arr = (String[])paraMap.get("oqty_arr"); // 주문량
	             
	              int cnt = 0;
	              for(int i=0; i<g_code_arr.length; i++) {
	                  
	            	  sql = " update tbl_game_product set g_qty = g_qty - ? "
	                		+ " where g_code = ? ";
	                
	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setInt(1, Integer.parseInt(oqty_arr[i]));
	                  pstmt.setString(2, g_code_arr[i]);
	                
	                  pstmt.executeUpdate();
	                  
	                  cnt++;
	             
	              }// end of for--------
	              
	              if(cnt == g_code_arr.length) {
	                  n3 = 1;
	              }
	              System.out.println("~~~~ 확인용 n3 : " + n3);
	              //   ~~~~ 확인용 n3 : 1
	             
	          }// end of if(n2==1)-------------------
	          

	          // 5. 장바구니 테이블에서 str_cartno_join 값에 해당하는 행들을 삭제(delete)하기(수동커밋처리)
	          // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. <<
	          if(n3==1 && paraMap.get("cartno_arr") != null) {
	          /*
	              sql = " delete from tbl_cart "
	                  + " where cartno in (?) ";
	          	  !!! 중요 in 절은 위와 같이 위치홀더 ? 를 사용하면 안됨. !!!
	          */   
	              String[] cartno_arr = (String [])paraMap.get("cartno_arr");
	              // cartno_arr 은 ["11","8","7"]
	             
	              String cartno_join = String.join("','",cartno_arr); // "11','10','7"
	             
	              cartno_join = "'"+cartno_join+"'"; // "'11','10','7'"
	             
	            //System.out.println("~~~ 확인용 cartno_join => " + cartno_join);
	            //  ~~~ 확인용 cartno_join => '11','10','7'
	             
	              System.out.println("이게 왜 에러" + cartno_join);
	              
	              sql = " delete from tbl_game_cart "
	                  + " where cartno in ("+ cartno_join +") ";
	              
	              // !!! 중요 in 절은 위와 같이 직접 변수로 처리해야 함. !!! //
	              // String.join(",", cartno_arr) 은 "11,10,7" 이러한 것이다.
	              // 조심할 것은 in 에 사용되어지는 cartno 컬럼의 타입이 number 타입이라면 괜찮은데
	              // 만약에 cartno 컬럼의 타입이 varchar2 타입이라면 "11,10,7" 와 같이 되어지면 오류가 발생한다.
	              // 그래서 cartno 컬럼의 타입이 varchar2 타입이라면 "11,10,7" 을 "'11','10','7'" 와 같이 변경해주어야 한다.
	             
	              pstmt = conn.prepareStatement(sql);
	              n4 = pstmt.executeUpdate();
	             
	              System.out.println("~~~~ 확인용 n4 : " + n4);
	              //   ~~~~ 확인용 n4 : 3
	              
	              if(n4 == cartno_arr.length) {
	                  n4 = 1;
	              }
	          }
	          
	          if(n3==1 && paraMap.get("cartno_arr") == null) {
	          // "제품 상세 정보" 페이지에서 "바로주문하기" 를 한 경우
	          // 장바구니 번호인 paraMap.get("cartno_arr") 이 없는 것이다.
	             n4 = 1;
	          }
	          
	          // 6. 회원 테이블에서 로그인한 사용자의 USER_PAYMENT 액을 sum_totalPrice 만큼 더하고, point 를 sum_totalPoint 만큼 더하기(update)(수동커밋처리)
	          if(n4 == 1) {
	              sql = " update tbl_user set USER_PAYMENT = USER_PAYMENT + ? , "				// g_coin = g_coin - ? , 이거 우짤거임 
	            		  + " user_coin = user_coin + ? "
	            		  + " where user_id = ? ";
	             
	              pstmt = conn.prepareStatement(sql);
	             
	              pstmt.setInt(1, Integer.parseInt((String)paraMap.get("sum_totalPrice")) );
	              pstmt.setInt(2, Integer.parseInt((String)paraMap.get("sum_totalPoint")) );
	              pstmt.setString(3, (String)paraMap.get("user_id"));
	             
	              n5 = pstmt.executeUpdate();
	             
	          
	          } // end of if -----
	          
	          System.out.println("확인용"+n5);
	          
	          
	          
	          
	       // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
	          if(n1*n2*n3*n4*n5 == 1) {
	              
	              conn.commit();
	              conn.setAutoCommit(true); // 자동커밋으로 전환
	             
	              // System.out.println("확인용 n1*n2*n3*n4*n5 : " + n1*n2*n3*n4*n5);
	              // 확인용 n1*n2*n3*n4*n5 : 1
	             
	              isSuccess = 1;
	          
	          } // end of if(
	          
	       } catch(SQLException e) {
	          // 8. **** SQL 장애 발생시 rollback 하기(rollback) ****
	             conn.rollback();
	             conn.setAutoCommit(true); // 자동커밋으로 전환
	             
	             isSuccess = 0;
	          
	       } finally {
	             
	    	     close();
	       
	       }
	       
	       return isSuccess;
	    
	    }// end of public int orderAdd(Map<String, Object> paraMap) throws SQLException--------

	 // 주문한 제품에 대해 email 보내기시 email 내용에 넣을 주문한 제품번호들에 대한 제품정보를 얻어오는 것
	@Override
	public List<GameVO> getJumungameList(String g_noes) throws SQLException {
		
		List<GameVO> jumunProductList = new ArrayList<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select g_no, g_code, g_name, fk_c_code, g_company, G_IMG_1, G_IMG_2, g_qty, g_price, g_sale_price, fk_s_code, g_content, g_coin "+
	                    "      , to_char(g_inputdate, 'yyyy-mm-dd') as g_inputdate "+
	                    " from tbl_game_product "+
	                    " where g_no in("+ g_noes +") ";
	         // prdmanual_systemFileName, prdmanual_orginFileName 할꺼면 추가하세요
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         rs = pstmt.executeQuery();
	                  
	         while(rs.next()) {
	                        
	             int g_no = rs.getInt("g_no");
	             String g_code = rs.getString("g_code");
	             String g_name = rs.getString("g_name");
	             String fk_c_code = rs.getString("fk_c_code");
	             String g_company = rs.getString("g_company");
	             String G_IMG_1 = rs.getString("G_IMG_1");
	             String G_IMG_2 = rs.getString("G_IMG_2");
	             int g_qty = rs.getInt("g_qty");
	             int g_price = rs.getInt("g_price");
	             int g_sale_price = rs.getInt("g_sale_price");
	             String fk_s_code = rs.getString("fk_s_code");
	             String g_content = rs.getString("g_content");
	             int g_coin = rs.getInt("g_coin");
	             String g_inputdate = rs.getString("g_inputdate");
	             
	             GameVO gamevo = new GameVO(g_no, g_code, g_name, fk_c_code, g_company, G_IMG_1, G_IMG_2, g_qty, g_price, g_sale_price, fk_s_code, g_content, g_coin, g_inputdate); 
	             
	             jumunProductList.add(gamevo);
	            
	         } // end of while----------------------------------
	                  
	      } finally {
	         close();
	      }
	      
	      return jumunProductList;
	}

	    
	    
	    

	
	
	
}



