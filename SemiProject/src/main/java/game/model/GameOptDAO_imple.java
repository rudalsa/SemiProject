package game.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
			
			String sql = " select g_no, g_code, g_name, fk_c_code, g_company, g_img_1, g_img_2, g_qty, g_price, g_sale_price, fk_s_code, g_content "
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
			
			String sql = " select optinfono , fk_g_code, imgfile, opt_name, opt_price, opt_sale_price "
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
				OptiList.add(optvo);
			}// end of while(rs.next())-----------------
			
		} finally {
			close();
		}
		
		return OptiList;
		
		
	}

}
