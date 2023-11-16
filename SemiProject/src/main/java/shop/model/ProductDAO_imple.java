package shop.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import gameopt.domain.OptVO;
import member.domain.MemberVO;
import shop.domain.*;
import util.security.AES256;
import util.security.SecretMyKey;


public class ProductDAO_imple implements ProductDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.  
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private AES256 aes;

	
	private AES256 aes;

	
	private AES256 aes;

	
	// 생성자
	public ProductDAO_imple() {
		
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
		    aes = new AES256(SecretMyKey.KEY);
		    // SecretMyKey.KEY 은 우리가 만든 암호화/복호화 키이다.
		    
		} catch(NamingException e) {
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
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
					
					String sql = " insert into tbl_product_optinfo(optinfono, fk_g_code, imgfile, opt_name, opt_price, opt_sale_price, opt_content, opt_qty) "
							   + " values(tbl_product_optinfo_optinfono.nextval, ?, ?, ?, ?, ?, ?, ?) "; 
							   
					
					pstmt = conn.prepareStatement(sql);
					
			        pstmt.setInt(1, Integer.parseInt(paraMap.get("g_code")));
			        pstmt.setString(2, paraMap.get("attachimg"));
			        pstmt.setString(3, paraMap.get("attachName"));
			        pstmt.setInt(4, Integer.parseInt(paraMap.get("attachPrice")));
			        pstmt.setInt(5, Integer.parseInt(paraMap.get("attachSalePrice")));
			        pstmt.setString(6, paraMap.get("attachContent"));
			        pstmt.setInt(7, Integer.parseInt(paraMap.get("attachOpty")));
			        
					
			        result = pstmt.executeUpdate();
					
				} finally {
					close();
				}

<<<<<<< HEAD
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
				
				String sql = " insert into tbl_product_optinfo(optinfono, fk_g_code, imgfile, opt_name, opt_price, opt_sale_price, opt_content, opt_qty) "
						   + " values(tbl_product_optinfo_optinfono.nextval, ?, ?, ?, ?, ?, ?, ?) "; 
						   
				
				pstmt = conn.prepareStatement(sql);
				
		        pstmt.setInt(1, Integer.parseInt(paraMap.get("g_code")));
		        pstmt.setString(2, paraMap.get("attachimg"));
		        pstmt.setString(3, paraMap.get("attachName"));
		        pstmt.setInt(4, Integer.parseInt(paraMap.get("attachPrice")));
		        pstmt.setInt(5, Integer.parseInt(paraMap.get("attachSalePrice")));
		        pstmt.setString(6, paraMap.get("attachContent"));
		        pstmt.setInt(7, Integer.parseInt(paraMap.get("attachOpty")));
		        
				
		        result = pstmt.executeUpdate();
				
			} finally {
				close();
			}

			return result;
		}

=======
				return result;
			}
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
	
	// 로그인한 사용자의 장바구니 목록을 조회하기
	@Override
	public List<CartVO> selectProductCart(String user_id) throws SQLException {
		
		List<CartVO> cartList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT C.cartno, C.fk_userid, C.fk_g_code, C.oqty, p.g_name, P.g_img_1, o.opt_name, o.opt_sale_price, p.g_coin, p.g_qty, C.fk_optno, o.IMGFILE, g_content, opt_price, opt_qty "
					+ " FROM ( "
					+ " SELECT cartno, fk_userid, fk_g_code, registerday, oqty, fk_optno "
					+ " FROM tbl_game_cart "
					+ " WHERE fk_userid = ? "
					+ " ) C "
					+ " JOIN TBL_PRODUCT_OPTINFO O ON C.fk_optno = O.OPTINFONO "
					+ " JOIN  tbl_game_product P ON O.fk_g_code = p.g_code " ;
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			
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
				int fk_optno = rs.getInt("fk_optno");	
				String imgfile = rs.getString("IMGFILE");
				String g_content = rs.getString("g_content");
				int opt_price = rs.getInt("opt_price");
				int opt_qty = rs.getInt("opt_qty");
				
				
				GameVO gvo = new GameVO();
				gvo.setG_code(fk_g_code);
				gvo.setG_name(g_name);
				gvo.setG_img_1(g_img_1);
				gvo.setG_coin(g_coin);
				gvo.setG_qty(g_qty);
				gvo.setG_content(g_content);
				
				// ***** !!!! 중요함 !!!! ***** //
				gvo.setTotalPriceTotalPoint(oqty);
				// ***** !!!! 중요함 !!!! ***** //
				
				// 우리는 옵션도 해야함 //
				
				OptVO ovo = new OptVO();
				ovo.setOpt_sale_price(opt_sale_price);
				ovo.setOpt_name(opt_name);
				ovo.setImgfile(imgfile);
				ovo.setOpt_price(opt_price);
				ovo.setOpt_qty(opt_qty);;
				
				// ***** !!!! 중요함 !!!! ***** //
				ovo.setTotalPriceTotalPoint(oqty);
				// ***** !!!! 중요함 !!!! ***** //
				// 나중에 더 추가 //
				
				CartVO cvo = new CartVO();
				cvo.setCartno(cartno);
				cvo.setFk_userid(fk_userid);
				cvo.setFk_g_code(fk_g_code);
				cvo.setOqty(oqty);
				cvo.setFk_optno(fk_optno);
				
				cvo.setGavo(gvo);
				cvo.setOpvo(ovo);
				
				cartList.add(cvo);
			}// end of while(rs.next())-------------------------------
			
			
		} finally {
			close();
		}
		
		return cartList;
		
		
	}
	
	
	   // 로그인한 사용자의 장바구니에 담긴 주문총액합계 및 총포인트합계 알아오기 
	   @Override
	   public Map<String, String> selectCartSumPricePoint(String userid) throws SQLException {
	      
	      Map<String, String> sumMap = new HashMap<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " SELECT NVL(SUM(C.oqty * O.opt_sale_price), 0) AS SUMTOTALPRICE, "
	         		+ "       NVL(SUM(C.oqty * P.g_coin), 0) AS SUMTOTALPOINT "
	         		+ " FROM ( "
	         		+ "    SELECT FK_OPTNO, oqty, fk_g_code "
	         		+ "    FROM tbl_game_cart "
	         		+ "    WHERE fk_userid = ? "
	         		+ " ) C "
	         		+ " JOIN TBL_PRODUCT_OPTINFO O ON C.FK_OPTNO = O.optinfono "
	         		+ " JOIN TBL_game_product P ON C.FK_g_code = P.g_code ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, userid);
	         
	         rs = pstmt.executeQuery();
	         rs.next();
	         
	         sumMap.put("SUMTOTALPRICE", rs.getString("SUMTOTALPRICE"));
	         sumMap.put("SUMTOTALPOINT", rs.getString("SUMTOTALPOINT"));
	         
	         
	      } finally {
	         close();
	      }
	      
	      
	      return sumMap;
	   }// end of public Map<String, String> selectCartSumPricePoint(String userid) throws SQLException-----------
	
	
	
	
	
	
	
	
	
	
	
	
	
	

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
	public int totalCateGoryCount(String c_code) throws SQLException {
		
	int CateGoryCount = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*)"
					   + " from tbl_game_product "
					   + " where fk_c_code = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c_code);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			CateGoryCount = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return CateGoryCount;
		
	}
	
	
	@Override
	public int CateGoryno(String c_code) throws SQLException {
	
		int CateGoryno = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select c_no "
					+ " from TBL_GAME_CATEGORY "
					+ " where C_CODE = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c_code);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			CateGoryno = rs.getInt(1);
			
		} finally {
			close();
		}
		
		
		
		
		
		
		
		
		
		return CateGoryno;
	
	
	}

	
	
	
	// 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라(start ~ end) 조회해오기
	@Override
	
	public List<GameVO> selectByno(Map<String, String> paraMap) throws SQLException {
		
		List<GameVO> gameList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT g_no, g_code, g_name, c_name, G_COMPANY, G_IMG_1, G_IMG_2, g_qty, g_price, g_sale_price, s_name, g_content, g_coin, G_INPUTDATE "
					+ " FROM "
					+ "	( "
					+ " select row_number() over(order by g_no desc) AS RNO "
					+ "	, g_no, g_code, g_name, C.c_name, G_COMPANY, G_IMG_1, G_IMG_2, g_qty, g_price, g_sale_price, S.s_name, g_content, g_coin "
					+ "	, to_char(G_INPUTDATE, 'yyyy-mm-dd') AS G_INPUTDATE "
					+ "	from tbl_game_product P "
					+ "	JOIN tbl_game_spec S "
					+ "    ON P.fk_s_code = S.s_code "
					+ "    JOIN TBL_GAME_CATEGORY C "
					+ "	ON P.fk_c_code = C.c_code "
					+ "    where C.c_no = ? "
					+ "	) V "
					+ "	WHERE RNO between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("c_no"));
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
	public int orderAdd(Map<String, Object> paraMap,Map<String, String> zipMap) throws SQLException {
		int isSuccess = 0;
	    int n1=0, n2=0, n3=0, n4=0, n5=0, n6=0;
	    
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
	              String[] optinfono_arr = (String[])paraMap.get("optinfono_arr");             // 제품번호
	              System.out.println(optinfono_arr.toString());
	              
	              String[] oqty_arr = (String[])paraMap.get("oqty_arr");             // 주문량
	              String[] totalPrice_arr = (String[])paraMap.get("totalPrice_arr"); // 주문가격
	             
	              int cnt = 0;
	              for(int i=0; i<optinfono_arr.length; i++) {
	              
	                  sql = " insert into tbl_orderdetail(odrseqno , fk_odrcode , FK_OPTINFONO , oqty , odrprice , deliverStatus )"
	                		+ " values(seq_tbl_orderdetail.nextval, ?, to_number(?), to_number(?), to_number(?), default) ";
	                
	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setString(1, (String)paraMap.get("odrcode"));
	                  pstmt.setString(2, optinfono_arr[i]);
	                  
	                  pstmt.setString(3, oqty_arr[i]);
	                  pstmt.setString(4, totalPrice_arr[i]);
	                
	                  pstmt.executeUpdate();
	                  
	                  cnt++;
	               }// end of for----------------------
	             
	               if(cnt == optinfono_arr.length) {
	                   n2 = 1;
	               }
	               	   System.out.println("~~~~ 확인용 n2 : " + n2);
	               //   ~~~~ 확인용 n2 : 1
	             
	          }// end of if(n1 == 1)----------------
	          
	          // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리)
	          if(n2==1) {
	             
	              String[] optinfono_arr = (String[])paraMap.get("optinfono_arr"); // 제품번호
	              String[] oqty_arr = (String[])paraMap.get("oqty_arr"); // 주문량
	             
	              int cnt = 0;
	              for(int i=0; i<optinfono_arr.length; i++) {
	                  
	            	  sql = "UPDATE tbl_game_product "
	            	  		+ "SET g_qty = g_qty- ? "
	            	  		+ "WHERE g_code IN ( "
	            	  		+ "    SELECT fk_g_code "
	            	  		+ "    FROM TBL_PRODUCT_OPTINFO"
	            	  		+ "    WHERE optinfono = ?"
	            	  		+ ")";
	            	  
	            	  
	                  pstmt = conn.prepareStatement(sql);
	                  pstmt.setInt(1, Integer.parseInt(oqty_arr[i]));
	                  pstmt.setString(2, optinfono_arr[i]);
	                
	                  pstmt.executeUpdate();
	                  
	                  
	                  String sql_1 = " UPDATE TBL_PRODUCT_OPTINFO SET opt_qty = opt_qty - ? "
		                		+ " WHERE optinfono = ? ";
		            	  
		            	  
		              pstmt = conn.prepareStatement(sql_1);
		              pstmt.setInt(1, Integer.parseInt(oqty_arr[i]));
		              pstmt.setString(2, optinfono_arr[i]);
		                
		              pstmt.executeUpdate();
	                  
	                  
	                  
	                  
	                  
	                  
	                  
	                  
	                  cnt++;
	             
	              }// end of for--------
	              
	              if(cnt == optinfono_arr.length) {
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
	            		  + " user_coin = ? "
	            		  + " where user_id = ? ";
	             
	              pstmt = conn.prepareStatement(sql);
	             
	              pstmt.setInt(1, Integer.parseInt((String)paraMap.get("sum_totalPrice")) );
	              pstmt.setInt(2, Integer.parseInt((String)paraMap.get("sum_totalPoint")) );
	              pstmt.setString(3, (String)paraMap.get("user_id"));
	             
	              n5 = pstmt.executeUpdate();
	             
	          
	          } // end of if -----
	          
	          System.out.println("확인용"+n5);
	          
	          
	          if(n5 == 1) {
	              
	        	  sql = " insert into tbl_order_info(oinfo_no, fk_odrcode, order_zipcode, order_address, order_detailaddress, order_extraaddress, order_name, order_phone, order_content)"
	                 + " values(seq_tbl_order_info.nextval, ?, ?, ?, ?, ?, ?, ?, ? )"; 
	              
	              pstmt = conn.prepareStatement(sql);
	              pstmt.setString(1, (String)paraMap.get("odrcode"));
	              pstmt.setString(2, zipMap.get("order_zipcode"));
	              pstmt.setString(3, zipMap.get("order_address"));
	              pstmt.setString(4, zipMap.get("order_detailaddress"));
	              pstmt.setString(5, zipMap.get("order_extraaddress"));
	              pstmt.setString(6, zipMap.get("order_name"));
	              pstmt.setString(7, zipMap.get("order_phone"));
	              pstmt.setString(8, zipMap.get("order_content"));
	              
	              n6 = pstmt.executeUpdate();
	              
	           }
	          
	          
	          
	          
	          
	          
	          
	          
	          
	          
	          
	          
	          
	          
	       // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
	          if(n1*n2*n3*n4*n5*n6 == 1) {
	              
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
	public List<GameVO> getJumungameList(String optnoes) throws SQLException {
		
		List<GameVO> jumunProductList = new ArrayList<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = "  SELECT "
	           		+ " G.g_no, G.g_code, G.g_name, G.fk_c_code, G.g_company, G.G_IMG_1, G.G_IMG_2, G.g_qty, G.g_price, G.g_sale_price, G.fk_s_code, G.g_content, G.g_coin, "
	          		+ " TO_CHAR(G.g_inputdate, 'yyyy-mm-dd') AS g_inputdate, "
	          		+ " IMGFILE,OPT_NAME,OPT_SALE_PRICE,OPT_CONTENT, optinfono "
	          		+ " FROM tbl_game_product G\r\n"
	          		+ " INNER JOIN TBL_PRODUCT_OPTINFO P ON G.g_code = P.fk_g_code "
	          		+ " where optinfono in ("+ optnoes +")  ";
	         

	         // prdmanual_systemFileName, prdmanual_orginFileName 할꺼면 추가하세요
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         rs = pstmt.executeQuery();
	                  
	         while(rs.next()) {
	                                   
	             GameVO gavo = new GameVO();
					
	             gavo.setG_no(rs.getInt(1));              // 제품번호 
	             gavo.setG_code(rs.getString(2));	     // 제품코드
				 gavo.setG_name(rs.getString(3));	     // 제품명
				 gavo.setFk_c_code(rs.getString(4));
				 gavo.setG_company(rs.getString(5));
				 gavo.setG_img_1(rs.getString(6));
				 gavo.setG_img_2(rs.getString(7));
				 gavo.setG_qty(rs.getInt(8));
				 gavo.setG_price(rs.getInt(9));
				 gavo.setG_sale_price(rs.getInt(10));
				 gavo.setFk_s_code(rs.getString(11));
				 gavo.setG_content(rs.getString(12));
				 gavo.setG_coin(rs.getInt(13));
				 gavo.setG_inputdate(rs.getString(14));
				 
				 OptVO optvo = new OptVO();
				 optvo.setImgfile(rs.getString(15));
				 optvo.setOpt_name(rs.getString(16));
				 optvo.setOpt_sale_price(rs.getInt(17));
				 optvo.setOpt_content(rs.getString(18));
				 optvo.setOptinfono(rs.getInt(19));
				 
				 gavo.setOptvo(optvo);
				 	             
	              
	             jumunProductList.add(gavo);
	            
	         } // end of while----------------------------------
	                  
	      } finally {
	         close();
	      }
	      
	      return jumunProductList;
	}
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======


<<<<<<< HEAD
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
	
	// ===== Transaction 처리하기 ===== // 
    // 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기
    // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
    // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
    // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리)
    // 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sum_totalPrice 만큼 감하고, point 를 sum_totalPoint 만큼
    // 더하기(update)(수동커밋처리)
    // 7. **** 모든처리가 성공되었을시 commit 하기(commit) ****
    // 8. **** SQL 장애 발생시 rollback 하기(rollback) **** 
	@Override
	public int oneOrderAdd(Map<String, String> paraMap) throws SQLException {
		
		int isSuccess = 0;
		int n1 = 0, n2 = 0, n3 = 0, n4 = 0, n5 = 0, n6 = 0, n7 = 0;

		try {
			conn = ds.getConnection();

			conn.setAutoCommit(false); // 수동커밋으로 전환

			// 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
			String sql = " insert into tbl_order(odrcode, fk_userid, odrtotalPrice, odrtotalPoint, odrdate) "
					   + " values(?, ?, ?, ?, default) ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, paraMap.get("odrcode"));
			pstmt.setString(2, paraMap.get("user_id"));
			pstmt.setString(3, paraMap.get("totalPrice"));
			pstmt.setString(4, paraMap.get("totalPoint"));
			
			n1 = pstmt.executeUpdate();
			
		//	System.out.println("~~~~ 확인용 n1 : " + n1);
			
			
		// 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
           if(n1 == 1) {
              
	          sql = " insert into tbl_orderdetail(odrseqno , fk_odrcode , FK_OPTINFONO , oqty , odrprice , deliverStatus )"
	        		+ " values(seq_tbl_orderdetail.nextval, ?, to_number(?), to_number(?), to_number(?), default) ";
	        
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, paraMap.get("odrcode"));
	          pstmt.setString(2, paraMap.get("optinfono"));
	          
	          pstmt.setString(3, paraMap.get("oqty"));
	          pstmt.setString(4, paraMap.get("totalPrice"));
	        
	          n2= pstmt.executeUpdate();
                  
                
        //   	   System.out.println("~~~~ 확인용 n2 : " + n2);
           //   ~~~~ 확인용 n2 : 1
             
          }// end of if(n1 == 1)----------------
			
			
			
			// 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리)
			if (n2 == 1) {
		
					sql = " UPDATE tbl_game_product SET g_qty = g_qty - ? " 
						+ " WHERE g_code IN ( "
						+ "    SELECT fk_g_code " 
						+ "    FROM TBL_PRODUCT_OPTINFO" 
						+ "    WHERE optinfono = ? "
						+ " ) ";

					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, Integer.parseInt(paraMap.get("oqty")));
					pstmt.setString(2, paraMap.get("optinfono"));

					n3 = pstmt.executeUpdate();
			//		System.out.println("~~~~ 확인용 n3 : " + n3);
					String sql_1 = " UPDATE TBL_PRODUCT_OPTINFO SET opt_qty = opt_qty - ? " 
							     + " WHERE optinfono = ? ";

					pstmt = conn.prepareStatement(sql_1);
					pstmt.setInt(1, Integer.parseInt(paraMap.get("oqty")));
					pstmt.setString(2, paraMap.get("optinfono"));

					n4 = pstmt.executeUpdate();
			//		System.out.println("~~~~ 확인용 n3 : " + n3);
					if(n3*n4 == 1) {
						n5 = 1;
					}
			//	System.out.println("~~~~ 확인용 n5 : " + n5);
				// ~~~~ 확인용 n2 : 1

			} // end of if(n1==1)-------------------

			
			// 6. 회원 테이블에서 로그인한 사용자의 USER_PAYMENT 액을 sum_totalPrice 만큼 더하고, point 를
			// sum_totalPoint 만큼 더하기(update)(수동커밋처리)
			if (n5 == 1) {
				sql = " update tbl_user set USER_PAYMENT = USER_PAYMENT + ? , " // g_coin = g_coin - ? , 이거 우짤거임
					+ " user_coin = ? " 
					+ " where user_id = ? ";

				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, Integer.parseInt(paraMap.get("totalPrice")));
				pstmt.setInt(2, Integer.parseInt(paraMap.get("totalPrice")));
				pstmt.setString(3, paraMap.get("user_id"));

				n6 = pstmt.executeUpdate();

			} // end of if -----

	//		System.out.println("확인용" + n6);
			
			if(n6 == 1) {
				sql = " insert into tbl_order_info(oinfo_no, fk_odrcode, order_zipcode, order_address, order_detailaddress, order_extraaddress, order_name, order_phone, order_content)"
					+ " values(seq_tbl_order_info.nextval, ?, ?, ?, ?, ?, ?, ?, ? )"; 
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, paraMap.get("odrcode"));
				pstmt.setString(2, paraMap.get("order_zipcode"));
				pstmt.setString(3, paraMap.get("order_address"));
				pstmt.setString(4, paraMap.get("order_detailaddress"));
				pstmt.setString(5, paraMap.get("order_extraaddress"));
				pstmt.setString(6, paraMap.get("order_name"));
				pstmt.setString(7, paraMap.get("order_phone"));
				pstmt.setString(8, paraMap.get("order_content"));
				
				n7 = pstmt.executeUpdate();
				
			}
	//		System.out.println("확인용" + n7);
			// 7. **** 모든처리가 성공되었을시 commit 하기(commit) ****
			if (n1 * n2 * n5 * n6 * n7 == 1) {

				conn.commit();
				conn.setAutoCommit(true); // 자동커밋으로 전환

				// System.out.println("확인용 n1*n2*n3*n4*n5 : " + n1*n2*n3*n4*n5);
				// 확인용 n1*n2*n3*n4*n5 : 1
				
				isSuccess = 1;

			} // end of if(

		} catch (SQLException e) {
			// 8. **** SQL 장애 발생시 rollback 하기(rollback) ****
			conn.rollback();
			conn.setAutoCommit(true); // 자동커밋으로 전환

			isSuccess = 0;

		} finally {

			close();

		}

		return isSuccess;
	}// end of public int oneOrderAdd(Map<String, String> paraMap) throws SQLException


=======
	// 페이징 처리를 위한 총 주문 수량 알아오기 //
	// 1. 일반 사용자로 로그인한 경우 자신이 주문한 내역만 조회
	// 2. 관리자(admin)으로 로그인한 경우 모든 사용자가 주문한 내역을 조회
	@Override
	public int getTotalCountOrder(String user_id) throws SQLException {
		int totalCountOrder =0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select count(*) AS CNT "
					+ " from tbl_order A Join tbl_orderdetail B "
					+ " on A.odrcode = B.fk_odrcode ";
			
			if("admin".equals(user_id)) {
				pstmt= conn.prepareStatement(sql);
			}
			else {
				sql += " where A.fk_userid = ? ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user_id);
				
			}
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git

			rs = pstmt.executeQuery();
			rs.next();
			
			totalCountOrder = rs.getInt("CNT");
					
					
		}finally {
			close();
		}
		
		
		return totalCountOrder;
	}// end of public int getTotalCountOrder(String userid) throws SQLException {


	// *** 관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 내역만 페이징 처리하여 조회를 해오고,
    //       관리자로 로그인을 했을 경우에는 모든 사용자들의 주문내역을 페이징 처리하여 조회해온다.
   @Override
   public List<Map<String, String>> getOrderList(Map<String, String> paraMap) throws SQLException {
      
      List<Map<String, String>> order_map_List = new ArrayList<>();
      
      try {
         conn = ds.getConnection();
         
        String sql = " SELECT odrcode, fk_userid, odrdate, odrseqno, FK_OPTINFONO, oqty, odrprice "
         		+ "                 , deliverstatus, FK_G_CODE, G_CONTENT, G_IMG_1, OPT_PRICE, OPT_SALE_PRICE ,OPT_NAME, OPT_QTY"
         		+ "                  FROM "
         		+ "                  ( "
         		+ "                  SELECT ROW_NUMBER() OVER(ORDER BY B.fk_odrcode desc, odrseqno asc) AS RNO "
         		+ "                    , A.odrcode, A.fk_userid, to_char(A.odrdate, 'yyyy-mm-dd hh24:mi:ss') AS odrdate "
         		+ "                     , B.ODRSEQNO, B.FK_OPTINFONO, B.oqty, B.odrprice  "
         		+ "                  , CASE B.deliverstatus  "
         		+ "                  WHEN 1 THEN '주문완료' "
         		+ "                  WHEN 2 THEN '배송중' "
         		+ "                  WHEN 1 THEN '배송완료' "
         		+ "                  END AS deliverstatus , FK_G_CODE, P.G_CONTENT, P.G_IMG_1, OPT_PRICE, OPT_SALE_PRICE, OPT_NAME, OPT_QTY "
         		+ "                  FROM tbl_order A JOIN tbl_orderdetail B "
         		+ "                  ON A.odrcode = B.fk_odrcode  "
         		+ "                  JOIN tbl_product_OPTINFO O "
         		+ "                  ON B.FK_OPTINFONO = O.OPTINFONO "
         		+ "                  JOIN tbl_game_product P "
         		+ "                  on O.FK_G_CODE = P.G_CODE ";
                  
         if (!"admin".equals(paraMap.get("userid"))) {
            // 관리자가 아닌 일반 사용자로 로그인한 경우
            sql += " WHERE A.fk_userid = ? ";
         }

         sql += " ) V " 
             +  " WHERE V.RNO BETWEEN ? AND ? ";
         
         pstmt = conn.prepareStatement(sql);
         
         // === 페이징처리의 공식 ===
           // where RNO between (조회하고자하는페이지번호 * 한페이지당보여줄행의개수) - (한페이지당보여줄행의개수 - 1) and (조회하고자하는페이지번호 * 한페이지당보여줄행의개수);

         int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
         int sizePerPage = 10; //  한 페이지당 화면상에 보여줄 주문내역의 개수는 10으로 한다.
         
         if (!"admin".equals(paraMap.get("userid"))) {
            // 관리자가 아닌 일반 사용자로 로그인한 경우
            pstmt.setString(1, paraMap.get("userid"));
            pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식이다.
            pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식이다.
            
            
         } else {
            // 관리자로 로그인한 경우
            pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식이다.
            pstmt.setInt(2, (currentShowPageNo * sizePerPage)); // 공식이다.
         }
         
         rs = pstmt.executeQuery();
         
         while(rs.next()) {

            String odrcode = rs.getString("odrcode");
            String fk_userid = rs.getString("fk_userid");
            String odrdate = rs.getString("odrdate");
            String odrseqno = rs.getString("odrseqno");
            String FK_OPTINFONO = rs.getString("FK_OPTINFONO");
            String oqty = rs.getString("oqty");
            String odrprice = rs.getString("odrprice");
            String deliverstatus = rs.getString("deliverstatus");
            String FK_G_CODE = rs.getString("FK_G_CODE");
            String G_CONTENT = rs.getString("G_CONTENT");
            String G_IMG_1 = rs.getString("G_IMG_1");
            String OPT_PRICE = rs.getString("OPT_PRICE");
            String OPT_SALE_PRICE = rs.getString("OPT_SALE_PRICE");
            String OPT_NAME = rs.getString("OPT_NAME");
            String OPT_QTY = rs.getString("OPT_QTY");
            
            
            Map<String, String> odrmap = new HashMap<>();
            odrmap.put("ODRCODE", odrcode);
            odrmap.put("FK_USERID", fk_userid);
            odrmap.put("ODRDATE", odrdate);
            odrmap.put("ODRSEQNO", odrseqno);
            odrmap.put("FK_OPTINFONO", FK_OPTINFONO);
            odrmap.put("OQTY", oqty);
            odrmap.put("ODRPRICE", odrprice);
            odrmap.put("DELIVERSTATUS", deliverstatus);
            odrmap.put("FK_G_CODE", FK_G_CODE);
            odrmap.put("G_CONTENT", G_CONTENT);
            odrmap.put("G_IMG_1", G_IMG_1);
            odrmap.put("OPT_PRICE", OPT_PRICE);
            odrmap.put("OPT_SALE_PRICE", OPT_SALE_PRICE);
            odrmap.put("OPT_NAME", OPT_NAME);
            odrmap.put("OPT_QTY", OPT_QTY);

            
            order_map_List.add(odrmap);
            
         }// end of while(rs.next())-------------
      } finally {
         close();
      }
      
      return order_map_List;
   }// end of public List<Map<String, String>> getOrderList(Map<String, String> paraMap) throws SQLException
	
	
	@Override
	public MemberVO odrcodeOwnerMemberInfo(String odrcode) throws SQLException {
		MemberVO mvo = null;
	    
	    try {
	       conn = ds.getConnection();
	       String sql = " select user_id, user_name, user_email, user_phone, user_zipcode, user_address, user_detail_address, user_extraaddress, user_gender "+
	    		   		" , user_birthday, user_coin, user_payment, to_char(user_registerday, 'yyyy-mm-dd') AS user_registerday "+
	    		   		"   from tbl_user "+
	                    " where user_id = (select fk_userid " + 
	                    "                 from tbl_order " + 
	                    "                 where odrcode = ? ) ";
	       
	       pstmt = conn.prepareStatement(sql);
	       pstmt.setString(1, odrcode);
	       
	       rs = pstmt.executeQuery();
	       
	       boolean isExists = rs.next();
	       
	       if(isExists) {
	          mvo = new MemberVO();
	          mvo.setUser_id(rs.getString(1));
	          mvo.setUser_name(rs.getString(2));
	          mvo.setUser_email(aes.decrypt(rs.getString(3)));  
	          mvo.setUser_phone(aes.decrypt(rs.getString(4))); 
	          mvo.setUser_zipcode(rs.getString(5));
	          mvo.setUser_address(rs.getString(6));
	          mvo.setUser_detail_address(rs.getString(7));
	          mvo.setUser_extraaddress(rs.getString(8));
	          mvo.setUser_gender(rs.getString(9));
	          mvo.setUser_birthday(rs.getString(10));
	          mvo.setUser_coin(rs.getInt(11));
	          mvo.setUser_payment(rs.getInt(12));
	          mvo.setUser_registerday(rs.getString(13));
	       }
	       
	    } catch (GeneralSecurityException | UnsupportedEncodingException e) {
	       e.printStackTrace();
	    } finally {
	       close();
	    }
	    
	    return mvo;  
	}
	
	// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 2(배송시작)로 변경하기
	@Override
	public int updateDeliverStart(String odrcodeoptno) throws SQLException {
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_orderdetail set deliverstatus = 2 "
	                  + " where fk_odrcode || '/' || FK_OPTINFONO in("+odrcodeoptno+") "; 
	         
	         pstmt = conn.prepareStatement(sql); 
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}// end of 	public int updateDeliverStart(String odrcodePnum) throws SQLException {
	
	
	// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 3(배송완료)로 변경하기
	@Override
	public int updateDeliverEnd(String odrcodeoptno) throws SQLException {
		int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_orderdetail set deliverstatus = 3, deliverDate = sysdate "
	                  + " where fk_odrcode || '/' || FK_OPTINFONO in("+odrcodeoptno+") "; 
	         
	         pstmt = conn.prepareStatement(sql); 
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	}//end of 	public int updateDeliverEnd(String odrcodePnum) throws SQLException {
	
	
		    
	    
	    

>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
	
	
	
	
	
	
	
	
	
	
	// 특정 사용자가 특정 제품에 대해 상품후기를 입력하기(insert) 
	   @Override
	   public int addReview(PurchaseReviewsVO reviewsvo) throws SQLException {
	      
	      int n = 0;
	         
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_game_reviews(review_seq, fk_user_id, fk_g_code, contents, writeDate) "
	               + "values(seq_purchase_reviews.nextval, ?, ?, ?, default) ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, reviewsvo.getFk_user_id());
	         pstmt.setString(2, reviewsvo.getFk_g_code());
	         pstmt.setString(3, reviewsvo.getContents());
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	      
	   } // end of public int addReview(PurchaseReviewsVO reviewsvo) throws SQLException 

	   // 특정 제품의 사용후기를 조회(select)하기
	   @Override
	   public List<PurchaseReviewsVO> reviewList(String fk_g_code) throws SQLException {
	      
	      List<PurchaseReviewsVO> reviewList = new ArrayList<>();
	         
	         try {
	            conn = ds.getConnection();
	            
	            String sql = " select review_seq, fk_user_id, user_name, fk_g_code, contents, to_char(writeDate, 'yyyy-mm-dd hh24:mi:ss') AS writeDate "
	                     + " from tbl_game_reviews R join tbl_user U "
	                     + " on R.fk_user_id = U.user_id "
	                     + " where R.fk_g_code = ? "
	                     + " order by review_seq desc ";
	            
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, fk_g_code);
	            
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	               String contents = rs.getString("contents");
	               String user_name = rs.getString("user_name");
	               String writeDate = rs.getString("writeDate");
	               String fk_user_id = rs.getString("fk_user_id");
	               int review_seq = rs.getInt("review_seq"); // 후기 삭제, 변경을 위해서는 후기번호를 알아야 가능하기때문.
	                                       
	               PurchaseReviewsVO reviewvo = new PurchaseReviewsVO();
	               reviewvo.setContents(contents);
	               
	               MemberVO mvo = new MemberVO();
	               mvo.setUser_name(user_name);
	               
	               reviewvo.setMvo(mvo);
	               reviewvo.setWriteDate(writeDate);
	               reviewvo.setFk_user_id(fk_user_id);
	               reviewvo.setReview_seq(review_seq);
	               
	               reviewList.add(reviewvo);
	            }         
	            
	         } finally {
	            close();
	         }
	         
	         return reviewList;   
	      
	   } // end of public List<PurchaseReviewsVO> reviewList(String fk_pnum) throws SQLException

	   // 특정 제품의 사용후기를 삭제(delete)하기
	   @Override
	   public int reviewDel(String review_seq) throws SQLException {
	      
	      int n = 0;
	         
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_game_reviews "
	                  + " where review_seq = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, review_seq);
	         
	         n = pstmt.executeUpdate(); 
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	   } // end of public int reviewDel(String review_seq) throws SQLException 

	   // 특정 제품의 사용후기를 수정(update)하기
	   @Override
	   public int reviewUpdate(Map<String, String> paraMap) throws SQLException {

	      int n = 0;
	         
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_game_reviews set contents = ? "
	                  + "                           , writeDate = sysdate " 
	                  + " where review_seq = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, paraMap.get("contents"));
	         pstmt.setString(2, paraMap.get("review_seq"));
	         
	         n = pstmt.executeUpdate(); 
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	   } // end of public int reviewDel(String review_seq) throws SQLException 


	   
	   // tbl_game_product, tbl_game_category JOIN 문
	   @Override
	   public List<GameVO> CarouselList(String c_code) throws SQLException {
	      
	      List<GameVO> CarouselList = new ArrayList<>();
	         
	         try {
	            conn = ds.getConnection();
	            
	            String sql = " select g_code, g_name, c_name, fk_c_code, g_img_1, g_content "
	                     + " from tbl_game_product "
	                     + " join tbl_game_category "
	                     + " on fk_c_code = c_code "
	                     + " where c_code = ? ";
	            
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, c_code);
	            
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	               String g_code = rs.getString("g_code");      // 게임이름
	               String g_name = rs.getString("g_name");      // 게임이름
	               String c_name = rs.getString("c_name");      // 카테고리이름
	               String fk_c_code = rs.getString("fk_c_code"); // 카테고리번호
	               String g_img_1 = rs.getString("g_img_1");      // 이미지파일명
	               String g_content = rs.getString("g_content"); // 게임설명
	                                       
	               GameVO gvo = new GameVO();
	               CategoryVO cvo = new CategoryVO();
	               
	               gvo.setG_code(g_code);
	               gvo.setG_name(g_name);
	               
	               cvo.setC_name(c_name);
	               
	               gvo.setCategvo(cvo);
	               gvo.setFk_c_code(fk_c_code);
	               gvo.setG_img_1(g_img_1);
	               gvo.setG_content(g_content);
	               
	               CarouselList.add(gvo);
	               
	               // System.out.println(CarouselList);
	            }         
	            
	            
	         } finally {
	            close();
	         }
	         
	         return CarouselList;   
	   }
	   
	   
	   
	   
	   
	   
		// 페이징 처리를 위한 총 주문 수량 알아오기 //
		// 1. 일반 사용자로 로그인한 경우 자신이 주문한 내역만 조회
		// 2. 관리자(admin)으로 로그인한 경우 모든 사용자가 주문한 내역을 조회
		@Override
		public int getTotalCountOrder(String user_id) throws SQLException {
			int totalCountOrder =0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select count(*) AS CNT "
						+ " from tbl_order A Join tbl_orderdetail B "
						+ " on A.odrcode = B.fk_odrcode ";
				
				if("admin".equals(user_id)) {
					pstmt= conn.prepareStatement(sql);
				}
				else {
					sql += " where A.fk_userid = ? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, user_id);
					
				}

				rs = pstmt.executeQuery();
				rs.next();
				
				totalCountOrder = rs.getInt("CNT");
						
						
			}finally {
				close();
			}
			
			
			return totalCountOrder;
		}// end of public int getTotalCountOrder(String userid) throws SQLException {


		// *** 관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 내역만 페이징 처리하여 조회를 해오고,
	    //       관리자로 로그인을 했을 경우에는 모든 사용자들의 주문내역을 페이징 처리하여 조회해온다.
	   @Override
	   public List<Map<String, String>> getOrderList(Map<String, String> paraMap) throws SQLException {
	      
	      List<Map<String, String>> order_map_List = new ArrayList<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	        String sql = " SELECT odrcode, fk_userid, odrdate, odrseqno, FK_OPTINFONO, oqty, odrprice "
	         		+ "                 , deliverstatus, FK_G_CODE, G_CONTENT, G_IMG_1, OPT_PRICE, OPT_SALE_PRICE ,OPT_NAME, OPT_QTY"
	         		+ "                  FROM "
	         		+ "                  ( "
	         		+ "                  SELECT ROW_NUMBER() OVER(ORDER BY B.fk_odrcode desc, odrseqno asc) AS RNO "
	         		+ "                    , A.odrcode, A.fk_userid, to_char(A.odrdate, 'yyyy-mm-dd hh24:mi:ss') AS odrdate "
	         		+ "                     , B.ODRSEQNO, B.FK_OPTINFONO, B.oqty, B.odrprice  "
	         		+ "                  , CASE B.deliverstatus  "
	         		+ "                  WHEN 1 THEN '주문완료' "
	         		+ "                  WHEN 2 THEN '배송중' "
	         		+ "                  WHEN 1 THEN '배송완료' "
	         		+ "                  END AS deliverstatus , FK_G_CODE, P.G_CONTENT, P.G_IMG_1, OPT_PRICE, OPT_SALE_PRICE, OPT_NAME, OPT_QTY "
	         		+ "                  FROM tbl_order A JOIN tbl_orderdetail B "
	         		+ "                  ON A.odrcode = B.fk_odrcode  "
	         		+ "                  JOIN tbl_product_OPTINFO O "
	         		+ "                  ON B.FK_OPTINFONO = O.OPTINFONO "
	         		+ "                  JOIN tbl_game_product P "
	         		+ "                  on O.FK_G_CODE = P.G_CODE ";
	                  
	         if (!"admin".equals(paraMap.get("userid"))) {
	            // 관리자가 아닌 일반 사용자로 로그인한 경우
	            sql += " WHERE A.fk_userid = ? ";
	         }

	         sql += " ) V " 
	             +  " WHERE V.RNO BETWEEN ? AND ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         // === 페이징처리의 공식 ===
	           // where RNO between (조회하고자하는페이지번호 * 한페이지당보여줄행의개수) - (한페이지당보여줄행의개수 - 1) and (조회하고자하는페이지번호 * 한페이지당보여줄행의개수);

	         int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
	         int sizePerPage = 10; //  한 페이지당 화면상에 보여줄 주문내역의 개수는 10으로 한다.
	         
	         if (!"admin".equals(paraMap.get("userid"))) {
	            // 관리자가 아닌 일반 사용자로 로그인한 경우
	            pstmt.setString(1, paraMap.get("userid"));
	            pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식이다.
	            pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식이다.
	            
	            
	         } else {
	            // 관리자로 로그인한 경우
	            pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식이다.
	            pstmt.setInt(2, (currentShowPageNo * sizePerPage)); // 공식이다.
	         }
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {

	            String odrcode = rs.getString("odrcode");
	            String fk_userid = rs.getString("fk_userid");
	            String odrdate = rs.getString("odrdate");
	            String odrseqno = rs.getString("odrseqno");
	            String FK_OPTINFONO = rs.getString("FK_OPTINFONO");
	            String oqty = rs.getString("oqty");
	            String odrprice = rs.getString("odrprice");
	            String deliverstatus = rs.getString("deliverstatus");
	            String FK_G_CODE = rs.getString("FK_G_CODE");
	            String G_CONTENT = rs.getString("G_CONTENT");
	            String G_IMG_1 = rs.getString("G_IMG_1");
	            String OPT_PRICE = rs.getString("OPT_PRICE");
	            String OPT_SALE_PRICE = rs.getString("OPT_SALE_PRICE");
	            String OPT_NAME = rs.getString("OPT_NAME");
	            String OPT_QTY = rs.getString("OPT_QTY");
	            
	            
	            Map<String, String> odrmap = new HashMap<>();
	            odrmap.put("ODRCODE", odrcode);
	            odrmap.put("FK_USERID", fk_userid);
	            odrmap.put("ODRDATE", odrdate);
	            odrmap.put("ODRSEQNO", odrseqno);
	            odrmap.put("FK_OPTINFONO", FK_OPTINFONO);
	            odrmap.put("OQTY", oqty);
	            odrmap.put("ODRPRICE", odrprice);
	            odrmap.put("DELIVERSTATUS", deliverstatus);
	            odrmap.put("FK_G_CODE", FK_G_CODE);
	            odrmap.put("G_CONTENT", G_CONTENT);
	            odrmap.put("G_IMG_1", G_IMG_1);
	            odrmap.put("OPT_PRICE", OPT_PRICE);
	            odrmap.put("OPT_SALE_PRICE", OPT_SALE_PRICE);
	            odrmap.put("OPT_NAME", OPT_NAME);
	            odrmap.put("OPT_QTY", OPT_QTY);

	            
	            order_map_List.add(odrmap);
	            
	         }// end of while(rs.next())-------------
	      } finally {
	         close();
	      }
	      
	      return order_map_List;
	   }// end of public List<Map<String, String>> getOrderList(Map<String, String> paraMap) throws SQLException
		
		
		@Override
		public MemberVO odrcodeOwnerMemberInfo(String odrcode) throws SQLException {
			MemberVO mvo = null;
		    
		    try {
		       conn = ds.getConnection();
		       String sql = " select user_id, user_name, user_email, user_phone, user_zipcode, user_address, user_detail_address, user_extraaddress, user_gender "+
		    		   		" , user_birthday, user_coin, user_payment, to_char(user_registerday, 'yyyy-mm-dd') AS user_registerday "+
		    		   		"   from tbl_user "+
		                    " where user_id = (select fk_userid " + 
		                    "                 from tbl_order " + 
		                    "                 where odrcode = ? ) ";
		       
		       pstmt = conn.prepareStatement(sql);
		       pstmt.setString(1, odrcode);
		       
		       rs = pstmt.executeQuery();
		       
		       boolean isExists = rs.next();
		       
		       if(isExists) {
		          mvo = new MemberVO();
		          mvo.setUser_id(rs.getString(1));
		          mvo.setUser_name(rs.getString(2));
		          mvo.setUser_email(aes.decrypt(rs.getString(3)));  
		          mvo.setUser_phone(aes.decrypt(rs.getString(4))); 
		          mvo.setUser_zipcode(rs.getString(5));
		          mvo.setUser_address(rs.getString(6));
		          mvo.setUser_detail_address(rs.getString(7));
		          mvo.setUser_extraaddress(rs.getString(8));
		          mvo.setUser_gender(rs.getString(9));
		          mvo.setUser_birthday(rs.getString(10));
		          mvo.setUser_coin(rs.getInt(11));
		          mvo.setUser_payment(rs.getInt(12));
		          mvo.setUser_registerday(rs.getString(13));
		       }
		       
		    } catch (GeneralSecurityException | UnsupportedEncodingException e) {
		       e.printStackTrace();
		    } finally {
		       close();
		    }
		    
		    return mvo;  
		}
		
		// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 2(배송시작)로 변경하기
		@Override
		public int updateDeliverStart(String odrcodeoptno) throws SQLException {
			int n = 0;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " update tbl_orderdetail set deliverstatus = 2 "
		                  + " where fk_odrcode || '/' || FK_OPTINFONO in("+odrcodeoptno+") "; 
		         
		         pstmt = conn.prepareStatement(sql); 
		         
		         n = pstmt.executeUpdate();
		         
		      } finally {
		         close();
		      }
		      
		      return n;
		}// end of 	public int updateDeliverStart(String odrcodePnum) throws SQLException {
		
		
		// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 3(배송완료)로 변경하기
		@Override
		public int updateDeliverEnd(String odrcodeoptno) throws SQLException {
			int n = 0;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " update tbl_orderdetail set deliverstatus = 3, deliverDate = sysdate "
		                  + " where fk_odrcode || '/' || FK_OPTINFONO in("+odrcodeoptno+") "; 
		         
		         pstmt = conn.prepareStatement(sql); 
		         
		         n = pstmt.executeUpdate();
		         
		      } finally {
		         close();
		      }
		      
		      return n;
		}//end of 	public int updateDeliverEnd(String odrcodePnum) throws SQLException {
		
		
		@Override
		   public int oneOrderAdd(Map<String, String> paraMap) throws SQLException {
		      
		      int isSuccess = 0;
		      int n1 = 0, n2 = 0, n3 = 0, n4 = 0, n5 = 0, n6 = 0, n7 = 0;

		      try {
		         conn = ds.getConnection();

		         conn.setAutoCommit(false); // 수동커밋으로 전환

		         // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
		         String sql = " insert into tbl_order(odrcode, fk_userid, odrtotalPrice, odrtotalPoint, odrdate) "
		                  + " values(?, ?, ?, ?, default) ";

		         pstmt = conn.prepareStatement(sql);

		         pstmt.setString(1, paraMap.get("odrcode"));
		         pstmt.setString(2, paraMap.get("user_id"));
		         pstmt.setString(3, paraMap.get("totalPrice"));
		         pstmt.setString(4, paraMap.get("totalPoint"));
		         
		         n1 = pstmt.executeUpdate();
		         
		      //   System.out.println("~~~~ 확인용 n1 : " + n1);
		         
		         
		      // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
		           if(n1 == 1) {
		              
		             sql = " insert into tbl_orderdetail(odrseqno , fk_odrcode , FK_OPTINFONO , oqty , odrprice , deliverStatus )"
		                 + " values(seq_tbl_orderdetail.nextval, ?, to_number(?), to_number(?), to_number(?), default) ";
		           
		             pstmt = conn.prepareStatement(sql);
		             pstmt.setString(1, paraMap.get("odrcode"));
		             pstmt.setString(2, paraMap.get("optinfono"));
		             
		             pstmt.setString(3, paraMap.get("oqty"));
		             pstmt.setString(4, paraMap.get("totalPrice"));
		           
		             n2= pstmt.executeUpdate();
		                  
		                
		        //         System.out.println("~~~~ 확인용 n2 : " + n2);
		           //   ~~~~ 확인용 n2 : 1
		             
		          }// end of if(n1 == 1)----------------
		         
		         
		         
		         // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리)
		         if (n2 == 1) {
		      
		               sql = " UPDATE tbl_game_product SET g_qty = g_qty - ? " 
		                  + " WHERE g_code IN ( "
		                  + "    SELECT fk_g_code " 
		                  + "    FROM TBL_PRODUCT_OPTINFO" 
		                  + "    WHERE optinfono = ? "
		                  + " ) ";

		               pstmt = conn.prepareStatement(sql);
		               pstmt.setInt(1, Integer.parseInt(paraMap.get("oqty")));
		               pstmt.setString(2, paraMap.get("optinfono"));

		               n3 = pstmt.executeUpdate();
		         //      System.out.println("~~~~ 확인용 n3 : " + n3);
		               String sql_1 = " UPDATE TBL_PRODUCT_OPTINFO SET opt_qty = opt_qty - ? " 
		                          + " WHERE optinfono = ? ";

		               pstmt = conn.prepareStatement(sql_1);
		               pstmt.setInt(1, Integer.parseInt(paraMap.get("oqty")));
		               pstmt.setString(2, paraMap.get("optinfono"));

		               n4 = pstmt.executeUpdate();
		         //      System.out.println("~~~~ 확인용 n3 : " + n3);
		               if(n3*n4 == 1) {
		                  n5 = 1;
		               }
		         //   System.out.println("~~~~ 확인용 n5 : " + n5);
		            // ~~~~ 확인용 n2 : 1

		         } // end of if(n1==1)-------------------

		         
		         // 6. 회원 테이블에서 로그인한 사용자의 USER_PAYMENT 액을 sum_totalPrice 만큼 더하고, point 를
		         // sum_totalPoint 만큼 더하기(update)(수동커밋처리)
		         if (n5 == 1) {
		            sql = " update tbl_user set USER_PAYMENT = USER_PAYMENT + ? , " // g_coin = g_coin - ? , 이거 우짤거임
		               + " user_coin = ? " 
		               + " where user_id = ? ";

		            pstmt = conn.prepareStatement(sql);

		            pstmt.setInt(1, Integer.parseInt(paraMap.get("totalPrice")));
		            pstmt.setInt(2, Integer.parseInt(paraMap.get("totalPrice")));
		            pstmt.setString(3, paraMap.get("user_id"));

		            n6 = pstmt.executeUpdate();

		         } // end of if -----

		   //      System.out.println("확인용" + n6);
		         
		         if(n6 == 1) {
		            sql = " insert into tbl_order_info(oinfo_no, fk_odrcode, order_zipcode, order_address, order_detailaddress, order_extraaddress, order_name, order_phone, order_content)"
		               + " values(seq_tbl_order_info.nextval, ?, ?, ?, ?, ?, ?, ?, ? )"; 
		            
		            pstmt = conn.prepareStatement(sql);
		            pstmt.setString(1, paraMap.get("odrcode"));
		            pstmt.setString(2, paraMap.get("order_zipcode"));
		            pstmt.setString(3, paraMap.get("order_address"));
		            pstmt.setString(4, paraMap.get("order_detailaddress"));
		            pstmt.setString(5, paraMap.get("order_extraaddress"));
		            pstmt.setString(6, paraMap.get("order_name"));
		            pstmt.setString(7, paraMap.get("order_phone"));
		            pstmt.setString(8, paraMap.get("order_content"));
		            
		            n7 = pstmt.executeUpdate();
		            
		         }
		   //      System.out.println("확인용" + n7);
		         // 7. **** 모든처리가 성공되었을시 commit 하기(commit) ****
		         if (n1 * n2 * n5 * n6 * n7 == 1) {

		            conn.commit();
		            conn.setAutoCommit(true); // 자동커밋으로 전환

		            // System.out.println("확인용 n1*n2*n3*n4*n5 : " + n1*n2*n3*n4*n5);
		            // 확인용 n1*n2*n3*n4*n5 : 1
		            
		            isSuccess = 1;

		         } // end of if(

		      } catch (SQLException e) {
		         // 8. **** SQL 장애 발생시 rollback 하기(rollback) ****
		         conn.rollback();
		         conn.setAutoCommit(true); // 자동커밋으로 전환

		         isSuccess = 0;

		      } finally {

		         close();

		      }

		      return isSuccess;
		   }// end of public int oneOrderAdd(Map<String, String> paraMap) throws SQLException
		
	
	
	
	
	
	
	
	
	
	// 특정 사용자가 특정 제품에 대해 상품후기를 입력하기(insert) 
	   @Override
	   public int addReview(PurchaseReviewsVO reviewsvo) throws SQLException {
	      
	      int n = 0;
	         
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_game_reviews(review_seq, fk_user_id, fk_g_code, contents, writeDate) "
	               + "values(seq_purchase_reviews.nextval, ?, ?, ?, default) ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, reviewsvo.getFk_user_id());
	         pstmt.setString(2, reviewsvo.getFk_g_code());
	         pstmt.setString(3, reviewsvo.getContents());
	         
	         n = pstmt.executeUpdate();
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	      
	   } // end of public int addReview(PurchaseReviewsVO reviewsvo) throws SQLException 

	   // 특정 제품의 사용후기를 조회(select)하기
	   @Override
	   public List<PurchaseReviewsVO> reviewList(String fk_g_code) throws SQLException {
	      
	      List<PurchaseReviewsVO> reviewList = new ArrayList<>();
	         
	         try {
	            conn = ds.getConnection();
	            
	            String sql = " select review_seq, fk_user_id, user_name, fk_g_code, contents, to_char(writeDate, 'yyyy-mm-dd hh24:mi:ss') AS writeDate "
	                     + " from tbl_game_reviews R join tbl_user U "
	                     + " on R.fk_user_id = U.user_id "
	                     + " where R.fk_g_code = ? "
	                     + " order by review_seq desc ";
	            
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, fk_g_code);
	            
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	               String contents = rs.getString("contents");
	               String user_name = rs.getString("user_name");
	               String writeDate = rs.getString("writeDate");
	               String fk_user_id = rs.getString("fk_user_id");
	               int review_seq = rs.getInt("review_seq"); // 후기 삭제, 변경을 위해서는 후기번호를 알아야 가능하기때문.
	                                       
	               PurchaseReviewsVO reviewvo = new PurchaseReviewsVO();
	               reviewvo.setContents(contents);
	               
	               MemberVO mvo = new MemberVO();
	               mvo.setUser_name(user_name);
	               
	               reviewvo.setMvo(mvo);
	               reviewvo.setWriteDate(writeDate);
	               reviewvo.setFk_user_id(fk_user_id);
	               reviewvo.setReview_seq(review_seq);
	               
	               reviewList.add(reviewvo);
	            }         
	            
	         } finally {
	            close();
	         }
	         
	         return reviewList;   
	      
	   } // end of public List<PurchaseReviewsVO> reviewList(String fk_pnum) throws SQLException

	   // 특정 제품의 사용후기를 삭제(delete)하기
	   @Override
	   public int reviewDel(String review_seq) throws SQLException {
	      
	      int n = 0;
	         
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " delete from tbl_game_reviews "
	                  + " where review_seq = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, review_seq);
	         
	         n = pstmt.executeUpdate(); 
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	   } // end of public int reviewDel(String review_seq) throws SQLException 

	   // 특정 제품의 사용후기를 수정(update)하기
	   @Override
	   public int reviewUpdate(Map<String, String> paraMap) throws SQLException {

	      int n = 0;
	         
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_game_reviews set contents = ? "
	                  + "                           , writeDate = sysdate " 
	                  + " where review_seq = ? ";
	                  
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, paraMap.get("contents"));
	         pstmt.setString(2, paraMap.get("review_seq"));
	         
	         n = pstmt.executeUpdate(); 
	         
	      } finally {
	         close();
	      }
	      
	      return n;
	   } // end of public int reviewDel(String review_seq) throws SQLException 


	   
	   // tbl_game_product, tbl_game_category JOIN 문
	   @Override
	   public List<GameVO> CarouselList(String c_code) throws SQLException {
	      
	      List<GameVO> CarouselList = new ArrayList<>();
	         
	         try {
	            conn = ds.getConnection();
	            
	            String sql = " select g_code, g_name, c_name, fk_c_code, g_img_1, g_content "
	                     + " from tbl_game_product "
	                     + " join tbl_game_category "
	                     + " on fk_c_code = c_code "
	                     + " where c_code = ? ";
	            
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, c_code);
	            
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	               String g_code = rs.getString("g_code");      // 게임이름
	               String g_name = rs.getString("g_name");      // 게임이름
	               String c_name = rs.getString("c_name");      // 카테고리이름
	               String fk_c_code = rs.getString("fk_c_code"); // 카테고리번호
	               String g_img_1 = rs.getString("g_img_1");      // 이미지파일명
	               String g_content = rs.getString("g_content"); // 게임설명
	                                       
	               GameVO gvo = new GameVO();
	               CategoryVO cvo = new CategoryVO();
	               
	               gvo.setG_code(g_code);
	               gvo.setG_name(g_name);
	               
	               cvo.setC_name(c_name);
	               
	               gvo.setCategvo(cvo);
	               gvo.setFk_c_code(fk_c_code);
	               gvo.setG_img_1(g_img_1);
	               gvo.setG_content(g_content);
	               
	               CarouselList.add(gvo);
	               
	               // System.out.println(CarouselList);
	            }         
	            
	            
	         } finally {
	            close();
	         }
	         
	         return CarouselList;   
	   }
	   
	   
	   
	   
	   
	   
		// 페이징 처리를 위한 총 주문 수량 알아오기 //
		// 1. 일반 사용자로 로그인한 경우 자신이 주문한 내역만 조회
		// 2. 관리자(admin)으로 로그인한 경우 모든 사용자가 주문한 내역을 조회
		@Override
		public int getTotalCountOrder(String user_id) throws SQLException {
			int totalCountOrder =0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select count(*) AS CNT "
						+ " from tbl_order A Join tbl_orderdetail B "
						+ " on A.odrcode = B.fk_odrcode ";
				
				if("admin".equals(user_id)) {
					pstmt= conn.prepareStatement(sql);
				}
				else {
					sql += " where A.fk_userid = ? ";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, user_id);
					
				}

				rs = pstmt.executeQuery();
				rs.next();
				
				totalCountOrder = rs.getInt("CNT");
						
						
			}finally {
				close();
			}
			
			
			return totalCountOrder;
		}// end of public int getTotalCountOrder(String userid) throws SQLException {


		// *** 관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 내역만 페이징 처리하여 조회를 해오고,
	    //       관리자로 로그인을 했을 경우에는 모든 사용자들의 주문내역을 페이징 처리하여 조회해온다.
	   @Override
	   public List<Map<String, String>> getOrderList(Map<String, String> paraMap) throws SQLException {
	      
	      List<Map<String, String>> order_map_List = new ArrayList<>();
	      
	      try {
	         conn = ds.getConnection();
	         
	        String sql = " SELECT odrcode, fk_userid, odrdate, odrseqno, FK_OPTINFONO, oqty, odrprice "
	         		+ "                 , deliverstatus, FK_G_CODE, G_CONTENT, G_IMG_1, OPT_PRICE, OPT_SALE_PRICE ,OPT_NAME, OPT_QTY"
	         		+ "                  FROM "
	         		+ "                  ( "
	         		+ "                  SELECT ROW_NUMBER() OVER(ORDER BY B.fk_odrcode desc, odrseqno asc) AS RNO "
	         		+ "                    , A.odrcode, A.fk_userid, to_char(A.odrdate, 'yyyy-mm-dd hh24:mi:ss') AS odrdate "
	         		+ "                     , B.ODRSEQNO, B.FK_OPTINFONO, B.oqty, B.odrprice  "
	         		+ "                  , CASE B.deliverstatus  "
	         		+ "                  WHEN 1 THEN '주문완료' "
	         		+ "                  WHEN 2 THEN '배송중' "
	         		+ "                  WHEN 1 THEN '배송완료' "
	         		+ "                  END AS deliverstatus , FK_G_CODE, P.G_CONTENT, P.G_IMG_1, OPT_PRICE, OPT_SALE_PRICE, OPT_NAME, OPT_QTY "
	         		+ "                  FROM tbl_order A JOIN tbl_orderdetail B "
	         		+ "                  ON A.odrcode = B.fk_odrcode  "
	         		+ "                  JOIN tbl_product_OPTINFO O "
	         		+ "                  ON B.FK_OPTINFONO = O.OPTINFONO "
	         		+ "                  JOIN tbl_game_product P "
	         		+ "                  on O.FK_G_CODE = P.G_CODE ";
	                  
	         if (!"admin".equals(paraMap.get("userid"))) {
	            // 관리자가 아닌 일반 사용자로 로그인한 경우
	            sql += " WHERE A.fk_userid = ? ";
	         }

	         sql += " ) V " 
	             +  " WHERE V.RNO BETWEEN ? AND ? ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         // === 페이징처리의 공식 ===
	           // where RNO between (조회하고자하는페이지번호 * 한페이지당보여줄행의개수) - (한페이지당보여줄행의개수 - 1) and (조회하고자하는페이지번호 * 한페이지당보여줄행의개수);

	         int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
	         int sizePerPage = 10; //  한 페이지당 화면상에 보여줄 주문내역의 개수는 10으로 한다.
	         
	         if (!"admin".equals(paraMap.get("userid"))) {
	            // 관리자가 아닌 일반 사용자로 로그인한 경우
	            pstmt.setString(1, paraMap.get("userid"));
	            pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식이다.
	            pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식이다.
	            
	            
	         } else {
	            // 관리자로 로그인한 경우
	            pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1)); // 공식이다.
	            pstmt.setInt(2, (currentShowPageNo * sizePerPage)); // 공식이다.
	         }
	         
	         rs = pstmt.executeQuery();
	         
	         while(rs.next()) {

	            String odrcode = rs.getString("odrcode");
	            String fk_userid = rs.getString("fk_userid");
	            String odrdate = rs.getString("odrdate");
	            String odrseqno = rs.getString("odrseqno");
	            String FK_OPTINFONO = rs.getString("FK_OPTINFONO");
	            String oqty = rs.getString("oqty");
	            String odrprice = rs.getString("odrprice");
	            String deliverstatus = rs.getString("deliverstatus");
	            String FK_G_CODE = rs.getString("FK_G_CODE");
	            String G_CONTENT = rs.getString("G_CONTENT");
	            String G_IMG_1 = rs.getString("G_IMG_1");
	            String OPT_PRICE = rs.getString("OPT_PRICE");
	            String OPT_SALE_PRICE = rs.getString("OPT_SALE_PRICE");
	            String OPT_NAME = rs.getString("OPT_NAME");
	            String OPT_QTY = rs.getString("OPT_QTY");
	            
	            
	            Map<String, String> odrmap = new HashMap<>();
	            odrmap.put("ODRCODE", odrcode);
	            odrmap.put("FK_USERID", fk_userid);
	            odrmap.put("ODRDATE", odrdate);
	            odrmap.put("ODRSEQNO", odrseqno);
	            odrmap.put("FK_OPTINFONO", FK_OPTINFONO);
	            odrmap.put("OQTY", oqty);
	            odrmap.put("ODRPRICE", odrprice);
	            odrmap.put("DELIVERSTATUS", deliverstatus);
	            odrmap.put("FK_G_CODE", FK_G_CODE);
	            odrmap.put("G_CONTENT", G_CONTENT);
	            odrmap.put("G_IMG_1", G_IMG_1);
	            odrmap.put("OPT_PRICE", OPT_PRICE);
	            odrmap.put("OPT_SALE_PRICE", OPT_SALE_PRICE);
	            odrmap.put("OPT_NAME", OPT_NAME);
	            odrmap.put("OPT_QTY", OPT_QTY);

	            
	            order_map_List.add(odrmap);
	            
	         }// end of while(rs.next())-------------
	      } finally {
	         close();
	      }
	      
	      return order_map_List;
	   }// end of public List<Map<String, String>> getOrderList(Map<String, String> paraMap) throws SQLException
		
		
		@Override
		public MemberVO odrcodeOwnerMemberInfo(String odrcode) throws SQLException {
			MemberVO mvo = null;
		    
		    try {
		       conn = ds.getConnection();
		       String sql = " select user_id, user_name, user_email, user_phone, user_zipcode, user_address, user_detail_address, user_extraaddress, user_gender "+
		    		   		" , user_birthday, user_coin, user_payment, to_char(user_registerday, 'yyyy-mm-dd') AS user_registerday "+
		    		   		"   from tbl_user "+
		                    " where user_id = (select fk_userid " + 
		                    "                 from tbl_order " + 
		                    "                 where odrcode = ? ) ";
		       
		       pstmt = conn.prepareStatement(sql);
		       pstmt.setString(1, odrcode);
		       
		       rs = pstmt.executeQuery();
		       
		       boolean isExists = rs.next();
		       
		       if(isExists) {
		          mvo = new MemberVO();
		          mvo.setUser_id(rs.getString(1));
		          mvo.setUser_name(rs.getString(2));
		          mvo.setUser_email(aes.decrypt(rs.getString(3)));  
		          mvo.setUser_phone(aes.decrypt(rs.getString(4))); 
		          mvo.setUser_zipcode(rs.getString(5));
		          mvo.setUser_address(rs.getString(6));
		          mvo.setUser_detail_address(rs.getString(7));
		          mvo.setUser_extraaddress(rs.getString(8));
		          mvo.setUser_gender(rs.getString(9));
		          mvo.setUser_birthday(rs.getString(10));
		          mvo.setUser_coin(rs.getInt(11));
		          mvo.setUser_payment(rs.getInt(12));
		          mvo.setUser_registerday(rs.getString(13));
		       }
		       
		    } catch (GeneralSecurityException | UnsupportedEncodingException e) {
		       e.printStackTrace();
		    } finally {
		       close();
		    }
		    
		    return mvo;  
		}
		
		// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 2(배송시작)로 변경하기
		@Override
		public int updateDeliverStart(String odrcodeoptno) throws SQLException {
			int n = 0;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " update tbl_orderdetail set deliverstatus = 2 "
		                  + " where fk_odrcode || '/' || FK_OPTINFONO in("+odrcodeoptno+") "; 
		         
		         pstmt = conn.prepareStatement(sql); 
		         
		         n = pstmt.executeUpdate();
		         
		      } finally {
		         close();
		      }
		      
		      return n;
		}// end of 	public int updateDeliverStart(String odrcodePnum) throws SQLException {
		
		
		// tbl_orderdetail 테이블의 deliverstatus(배송상태) 컬럼의 값을 3(배송완료)로 변경하기
		@Override
		public int updateDeliverEnd(String odrcodeoptno) throws SQLException {
			int n = 0;
		      
		      try {
		         conn = ds.getConnection();
		         
		         String sql = " update tbl_orderdetail set deliverstatus = 3, deliverDate = sysdate "
		                  + " where fk_odrcode || '/' || FK_OPTINFONO in("+odrcodeoptno+") "; 
		         
		         pstmt = conn.prepareStatement(sql); 
		         
		         n = pstmt.executeUpdate();
		         
		      } finally {
		         close();
		      }
		      
		      return n;
		}//end of 	public int updateDeliverEnd(String odrcodePnum) throws SQLException {
		
		
		@Override
		   public int oneOrderAdd(Map<String, String> paraMap) throws SQLException {
		      
		      int isSuccess = 0;
		      int n1 = 0, n2 = 0, n3 = 0, n4 = 0, n5 = 0, n6 = 0, n7 = 0;

		      try {
		         conn = ds.getConnection();

		         conn.setAutoCommit(false); // 수동커밋으로 전환

		         // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
		         String sql = " insert into tbl_order(odrcode, fk_userid, odrtotalPrice, odrtotalPoint, odrdate) "
		                  + " values(?, ?, ?, ?, default) ";

		         pstmt = conn.prepareStatement(sql);

		         pstmt.setString(1, paraMap.get("odrcode"));
		         pstmt.setString(2, paraMap.get("user_id"));
		         pstmt.setString(3, paraMap.get("totalPrice"));
		         pstmt.setString(4, paraMap.get("totalPoint"));
		         
		         n1 = pstmt.executeUpdate();
		         
		      //   System.out.println("~~~~ 확인용 n1 : " + n1);
		         
		         
		      // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
		           if(n1 == 1) {
		              
		             sql = " insert into tbl_orderdetail(odrseqno , fk_odrcode , FK_OPTINFONO , oqty , odrprice , deliverStatus )"
		                 + " values(seq_tbl_orderdetail.nextval, ?, to_number(?), to_number(?), to_number(?), default) ";
		           
		             pstmt = conn.prepareStatement(sql);
		             pstmt.setString(1, paraMap.get("odrcode"));
		             pstmt.setString(2, paraMap.get("optinfono"));
		             
		             pstmt.setString(3, paraMap.get("oqty"));
		             pstmt.setString(4, paraMap.get("totalPrice"));
		           
		             n2= pstmt.executeUpdate();
		                  
		                
		        //         System.out.println("~~~~ 확인용 n2 : " + n2);
		           //   ~~~~ 확인용 n2 : 1
		             
		          }// end of if(n1 == 1)----------------
		         
		         
		         
		         // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리)
		         if (n2 == 1) {
		      
		               sql = " UPDATE tbl_game_product SET g_qty = g_qty - ? " 
		                  + " WHERE g_code IN ( "
		                  + "    SELECT fk_g_code " 
		                  + "    FROM TBL_PRODUCT_OPTINFO" 
		                  + "    WHERE optinfono = ? "
		                  + " ) ";

		               pstmt = conn.prepareStatement(sql);
		               pstmt.setInt(1, Integer.parseInt(paraMap.get("oqty")));
		               pstmt.setString(2, paraMap.get("optinfono"));

		               n3 = pstmt.executeUpdate();
		         //      System.out.println("~~~~ 확인용 n3 : " + n3);
		               String sql_1 = " UPDATE TBL_PRODUCT_OPTINFO SET opt_qty = opt_qty - ? " 
		                          + " WHERE optinfono = ? ";

		               pstmt = conn.prepareStatement(sql_1);
		               pstmt.setInt(1, Integer.parseInt(paraMap.get("oqty")));
		               pstmt.setString(2, paraMap.get("optinfono"));

		               n4 = pstmt.executeUpdate();
		         //      System.out.println("~~~~ 확인용 n3 : " + n3);
		               if(n3*n4 == 1) {
		                  n5 = 1;
		               }
		         //   System.out.println("~~~~ 확인용 n5 : " + n5);
		            // ~~~~ 확인용 n2 : 1

		         } // end of if(n1==1)-------------------

		         
		         // 6. 회원 테이블에서 로그인한 사용자의 USER_PAYMENT 액을 sum_totalPrice 만큼 더하고, point 를
		         // sum_totalPoint 만큼 더하기(update)(수동커밋처리)
		         if (n5 == 1) {
		            sql = " update tbl_user set USER_PAYMENT = USER_PAYMENT + ? , " // g_coin = g_coin - ? , 이거 우짤거임
		               + " user_coin = ? " 
		               + " where user_id = ? ";

		            pstmt = conn.prepareStatement(sql);

		            pstmt.setInt(1, Integer.parseInt(paraMap.get("totalPrice")));
		            pstmt.setInt(2, Integer.parseInt(paraMap.get("totalPrice")));
		            pstmt.setString(3, paraMap.get("user_id"));

		            n6 = pstmt.executeUpdate();

		         } // end of if -----

		   //      System.out.println("확인용" + n6);
		         
		         if(n6 == 1) {
		            sql = " insert into tbl_order_info(oinfo_no, fk_odrcode, order_zipcode, order_address, order_detailaddress, order_extraaddress, order_name, order_phone, order_content)"
		               + " values(seq_tbl_order_info.nextval, ?, ?, ?, ?, ?, ?, ?, ? )"; 
		            
		            pstmt = conn.prepareStatement(sql);
		            pstmt.setString(1, paraMap.get("odrcode"));
		            pstmt.setString(2, paraMap.get("order_zipcode"));
		            pstmt.setString(3, paraMap.get("order_address"));
		            pstmt.setString(4, paraMap.get("order_detailaddress"));
		            pstmt.setString(5, paraMap.get("order_extraaddress"));
		            pstmt.setString(6, paraMap.get("order_name"));
		            pstmt.setString(7, paraMap.get("order_phone"));
		            pstmt.setString(8, paraMap.get("order_content"));
		            
		            n7 = pstmt.executeUpdate();
		            
		         }
		   //      System.out.println("확인용" + n7);
		         // 7. **** 모든처리가 성공되었을시 commit 하기(commit) ****
		         if (n1 * n2 * n5 * n6 * n7 == 1) {

		            conn.commit();
		            conn.setAutoCommit(true); // 자동커밋으로 전환

		            // System.out.println("확인용 n1*n2*n3*n4*n5 : " + n1*n2*n3*n4*n5);
		            // 확인용 n1*n2*n3*n4*n5 : 1
		            
		            isSuccess = 1;

		         } // end of if(

		      } catch (SQLException e) {
		         // 8. **** SQL 장애 발생시 rollback 하기(rollback) ****
		         conn.rollback();
		         conn.setAutoCommit(true); // 자동커밋으로 전환

		         isSuccess = 0;

		      } finally {

		         close();

		      }

		      return isSuccess;
		   }// end of public int oneOrderAdd(Map<String, String> paraMap) throws SQLException
		
	
	
}



