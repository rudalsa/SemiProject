package shop.model;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.DataSource;

import gameopt.domain.OptVO;
import shop.domain.CartVO;
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
			
			String sql = " SELECT C.cartno, C.fk_userid, C.fk_g_code, C.oqty, p.g_name, P.g_img_1, o.opt_name, o.opt_sale_price, p.g_coin "
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
				
				GameVO gvo = new GameVO();
				gvo.setG_code(fk_g_code);
				gvo.setG_name(g_name);
				gvo.setG_img_1(g_img_1);
				gvo.setG_coin(g_coin);
				
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
	
	
}



