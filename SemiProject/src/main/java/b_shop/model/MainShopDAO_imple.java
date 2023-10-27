package b_shop.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.sql.DataSource;

import b_shop.domain.*;

public class MainShopDAO_imple implements MainShopDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.  
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public MainShopDAO_imple() {
		
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/semi_oracle");
		    
		} catch(NamingException e) {
			e.printStackTrace();
		}
		
	} // end of public MainShopDAO_imple() ------------------------
	
	
	// 사용한 자원을 반납하는 close() 메소드 생성하기 
	private void close() {
		try {
			if(rs != null)    {rs.close();    rs=null;}
			if(pstmt != null) {pstmt.close(); pstmt=null;}
			if(conn != null)  {conn.close();  conn=null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	} // end of private void close() ---------------------------
	
	
	// tbl_featured_game 테이블을 모두 조회(select)하는 메소드 
	@Override
	public List<GameVO> ShopListSelectAll() throws SQLException {
		
		List<GameVO> imgProductList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select g_no, g_code, g_name, fk_c_code, g_company, g_img_1, g_img_2, g_qty, g_price, g_sale_price, fk_s_code, g_content "
					   + " from tbl_game_product "
					   + " order by g_code asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				GameVO gvo = new GameVO();
				gvo.setG_no(rs.getInt(1));
				gvo.setG_code(rs.getString(2));
				gvo.setG_name(rs.getString(3));
				gvo.setFk_c_code(rs.getString(4));
				gvo.setG_company(rs.getString(5));
				gvo.setG_img_1(rs.getString(6));
				gvo.setG_img_2(rs.getString(7));
				gvo.setG_qty(rs.getInt(8));
				gvo.setG_price(rs.getInt(9));
				gvo.setG_sale_price(rs.getInt(10));
				gvo.setFk_s_code(rs.getString(11));
				gvo.setG_content(rs.getString(12));
				
				imgProductList.add(gvo);
			}// end of while(rs.next())-----------------
			
		} finally {
			close();
		}
		return imgProductList;
	
	}// public List<MainShopVO> ShopListSelectAll() throws SQLException ------

}
