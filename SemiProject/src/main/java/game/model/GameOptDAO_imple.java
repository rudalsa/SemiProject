package game.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


import gameopt.domain.OptVO;
import shop.domain.GameVO;

public class GameOptDAO_imple implements GameOptDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.  
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public GameOptDAO_imple() {
		
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

	

	@Override
	public boolean isExist_g_code(String g_code) throws SQLException {
		
		boolean isExist = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select g_code "
					+ " from tbl_game_product "
					+ " where g_code = ? " ;
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, g_code);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				pstmt.setString(1, g_code);
				
				rs = pstmt.executeQuery();
				
				isExist = rs.next();
				
			} // end of if(rs.next())-------------------
		
		}finally {
			close();
		}
		
		return isExist;
	
	}


	@Override
	public GameVO selectGameOpti(String g_code) throws SQLException {
		
		GameVO gameVO = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select g_no, g_code, g_name, fk_c_code, g_company, g_img_1, g_img_2, g_qty, g_price, g_sale_price, fk_s_code, g_content, g_info "
					   + " from tbl_game_product "
					   + " where g_code = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, g_code);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				gameVO = new GameVO();
				
				gameVO.setG_no(rs.getInt(1));
				gameVO.setG_code(rs.getString(2));
				gameVO.setG_name(rs.getString(3));
				gameVO.setFk_c_code(rs.getString(4));
				gameVO.setG_company(rs.getString(5));
				gameVO.setG_img_1(rs.getString(6));
				gameVO.setG_img_2(rs.getString(7));
				gameVO.setG_qty(rs.getInt(8));
				gameVO.setG_price(rs.getInt(9));
				gameVO.setG_sale_price(rs.getInt(10));
				gameVO.setFk_s_code(rs.getString(11));
				gameVO.setG_content(rs.getString(12));
				gameVO.setG_info(rs.getString(13));
				
				
			} // end of if(rs.next())-------------------
		
		}finally {
			close();
		}
		
		return gameVO;
		
	}


	@Override
	public List<OptVO> SelectAllOpti(String g_code) throws SQLException {
		
		List<OptVO> OptiList = new ArrayList<>();
		 
		try {
			conn = ds.getConnection();
			
			String sql = " select optinfono , fk_g_code, imgfile, opt_name, opt_price, opt_sale_price, OPT_CONTENT "
					+ " from tbl_product_optinfo "
					+ " where fk_g_code = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, g_code);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				OptVO optvo = new OptVO();
				optvo.setOptinfono(rs.getInt(1)); 						
				optvo.setFk_g_code(rs.getString(2)); 
				optvo.setImgfile(rs.getString(3));
				optvo.setOpt_name(rs.getString(4));
				optvo.setOpt_price(rs.getInt(5));
				optvo.setOpt_sale_price(rs.getInt(6));
				optvo.setOpt_content(rs.getString(7));
				OptiList.add(optvo);
			}// end of while(rs.next())-----------------
			
		} finally {
			close();
		}
		
		return OptiList;
		
		
	}

	// 장바구니에 기존 제품이 없을경우 insert 하고 // 장바구니에 기존 제품이 있을경우 update 한다.
	@Override
	public int addCart(Map<String, String> paraMap) throws SQLException {
		
		
		  int n = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	      /*
	            먼저 장바구니 테이블(tbl_cart)에 어떤 회원이 새로운 제품을 넣는 것인지,
	            아니면 또 다시 제품을 추가로 더 구매하는 것인지를 알아야 한다.
	            이것을 알기 위해서 어떤 회원이 어떤 제품을 장바구니 테이블(tbl_cart) 넣을때
	            그 제품이 이미 존재하는지 select 를 통해서 알아와야 한다.
	            
	            -------------------------------------------
	            cartno   fk_userid     fk_pnum   oqty  
	            -------------------------------------------
	              1      kimkm          7         2     
	              2      seoyh          6         3     
	              3      leess          7         5     
	        */
	         
	         String sql = " select cartno "
	                  + " from tbl_game_cart "
	                  + " where fk_userid = ? and fk_optno = ? "; 
	                  
	         pstmt = conn.prepareStatement(sql);
	         pstmt.setString(1, paraMap.get("user_id"));
	         pstmt.setInt(2, Integer.parseInt(paraMap.get("optno")));
	         
	         System.out.println(paraMap.get("optno"));
	         
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	            // 어떤 제품을 추가로 장바구니에 넣고자 하는 경우
	            
	            sql = " update tbl_game_cart set oqty = oqty + ? "
	                + " where cartno = ? ";
	            
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, Integer.parseInt(paraMap.get("oqty")));
	            pstmt.setInt(2, rs.getInt("CARTNO"));
	            
	            n = pstmt.executeUpdate();
	            
	         }
	         
	         else {
	            // 장바구니에 존재하지 않는 새로운 제품을 넣고자 하는 경우
	            
	            sql = " insert into tbl_game_cart(cartno, fk_userid, fk_g_code, oqty, registerday, fk_optno)  "
	               + " values(seq_tbl_cart_cartno.nextval, ?, ?, ?, default, ?) ";
	               
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setString(1, paraMap.get("user_id"));
	               pstmt.setInt(2, Integer.parseInt(paraMap.get("g_code")));
	               pstmt.setInt(3, Integer.parseInt(paraMap.get("oqty")));
	               pstmt.setInt(4, Integer.parseInt(paraMap.get("optno")));
	               
	               n = pstmt.executeUpdate();
	            
	         }
	         
	      } finally {
	         close();
	      }

	      return n;
		
		
		
	}


	@Override
	public List<GameVO> SelectAllLike(List<String> g_code_arr) throws SQLException {
		
		List<GameVO> likeList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			for(int i = 0; i<g_code_arr.size(); i++) {
				
				String sql = " select g_no, g_code, g_name, fk_c_code, g_company, g_img_1, g_img_2, g_qty, g_price, g_sale_price, fk_s_code, g_content, g_info "
						   + " from tbl_game_product "
						   + " where g_code = ? ";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, g_code_arr.get(i));
				
				System.out.println("확인용"+g_code_arr.get(i));
				
				
				rs = pstmt.executeQuery();
			
				if(rs.next()) {
					
					GameVO gameVO = new GameVO();
					
					gameVO.setG_no(rs.getInt(1));
					gameVO.setG_code(rs.getString(2));
					gameVO.setG_name(rs.getString(3));
					gameVO.setFk_c_code(rs.getString(4));
					gameVO.setG_company(rs.getString(5));
					gameVO.setG_img_1(rs.getString(6));
					gameVO.setG_img_2(rs.getString(7));
					gameVO.setG_qty(rs.getInt(8));
					gameVO.setG_price(rs.getInt(9));
					gameVO.setG_sale_price(rs.getInt(10));
					gameVO.setFk_s_code(rs.getString(11));
					gameVO.setG_content(rs.getString(12));
					gameVO.setG_info(rs.getString(13));
					
					likeList.add(gameVO);
					
				} // end of if(rs.next())-------------------
			
			}
		
		} finally {
			
			close();
	
		}
		
		
		
		
		
		return likeList;
	}

}
