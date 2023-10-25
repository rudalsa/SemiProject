package game.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import game.domain.GameOptionVO;

public class GameOptionDAO_imple implements GameOptionDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.  
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public GameOptionDAO_imple() {
		
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

	// 상품옵션페이지에 보여지는 상품이미지파일명을 상품과 동일하게 모두 조회(select)하는 메소드
	@Override
	public GameOptionVO selectOneGameOption(String imgsetno) throws SQLException {
		
		GameOptionVO gameOptionVO = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select gameno,imgslidefilename,imgslidefilename_2,imgslidefilename_3,imgslidefilename_4 ,gamegenre, gamename, "
					   + " gamelogo, gameopt_name, gameopt_name_2, gameopt_name_3, gameopt_discount, gameopt_discount_2, gameopt_discount_3, "
					   + " gameopt_price , gameopt_price_2 , gameopt_price_3  "
					   + " from tbl_game_option "
					   + " where gameno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, imgsetno);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				gameOptionVO = new GameOptionVO();
				
				gameOptionVO.setGameno(rs.getInt(1));
				gameOptionVO.setImgslidefilename(rs.getString(2));
				gameOptionVO.setImgslidefilename_2(rs.getString(3));
				gameOptionVO.setImgslidefilename_3(rs.getString(4));
				gameOptionVO.setImgslidefilename_4(rs.getString(5));
				gameOptionVO.setGamegenre(rs.getString(6));
				gameOptionVO.setGamename(rs.getString(7));
				gameOptionVO.setGamelogo(rs.getString(8));
				gameOptionVO.setGameopt_name(rs.getString(9));
				gameOptionVO.setGameopt_name_2(rs.getString(10));
				gameOptionVO.setGameopt_name_3(rs.getString(11));
				gameOptionVO.setGameopt_discount(rs.getInt(12));
				gameOptionVO.setGameopt_discount_2(rs.getInt(13));
				gameOptionVO.setGameopt_discount_3(rs.getInt(14));
				gameOptionVO.setGameopt_price(rs.getInt(15));
				gameOptionVO.setGameopt_price_2(rs.getInt(16));
				gameOptionVO.setGameopt_price_3(rs.getInt(17));
				
				
				
				
			} // end of if(rs.next())-------------------
		
		}finally {
			close();
		}
		
		return gameOptionVO;
	}


	@Override
	public boolean isExist_imgsetno(String imgsetno) throws SQLException {
		boolean isExist = false;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " select * "  
	                  + " from tbl_game_option "
	                  + " where gameno = ? "; 
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, imgsetno);
	               
	         rs = pstmt.executeQuery();
	         
	         isExist = rs.next();
	         
	      } finally {
	         close();
	      }      
	      
	      return isExist;
	}
}
