package shop.model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.*;
import javax.sql.DataSource;

import shop.domain.*;

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
	public List<MainShopVO> ShopListSelectAll() throws SQLException {
		
		List<MainShopVO> imgProductList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select product_no, product_name, product_event_name, img_file_name, gamegenre, product_price, product_sale_percent  "
					   + " from tbl_featured_game "
					   + " order by product_no asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				MainShopVO msvo = new MainShopVO();
				msvo.setProduct_no(rs.getInt(1)); 						
				msvo.setProduct_name(rs.getString(2));
				msvo.setProduct_event_name(rs.getString(3));
				msvo.setImg_file_name(rs.getString(4));
				msvo.setGamegenre(rs.getString(5));
				msvo.setProduct_price(rs.getInt(6));
				msvo.setProduct_sale_percent(rs.getInt(7));
				imgProductList.add(msvo);
			}// end of while(rs.next())-----------------
			
		} finally {
			close();
		}
		return imgProductList;
	
	}// public List<MainShopVO> ShopListSelectAll() throws SQLException ------


	
	
	// tbl_popular_game 테이블을 모두 조회(select)하는 메소드 
	@Override
	public List<ShopPopProductVO> PopListSelectAll() throws SQLException {
		
		List<ShopPopProductVO> popProductList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select product_no, product_name, product_event_name, img_file_name, gamegenre, product_price, product_sale_price, product_sale_percent "
					   + " from tbl_popular_game "
					   + " order by product_no asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ShopPopProductVO popvo = new ShopPopProductVO();
				popvo.setProduct_no(rs.getInt(1)); 						
				popvo.setProduct_name(rs.getString(2));
				popvo.setProduct_event_name(rs.getString(3));
				popvo.setImg_file_name(rs.getString(4));
				popvo.setGamegenre(rs.getString(5));
				popvo.setProduct_price(rs.getInt(6));
				popvo.setProduct_sale_price(rs.getInt(7));
				popvo.setProduct_sale_percent(rs.getInt(8));
				popProductList.add(popvo);
			}
			
		} finally {
			close();
		}
		
		return popProductList;
	} // end of public List<ShopPopProductVO> PopListSelectAll() throws SQLException --------

	
	
	

}
