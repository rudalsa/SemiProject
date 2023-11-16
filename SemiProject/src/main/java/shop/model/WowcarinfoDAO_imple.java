package shop.model;

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

import shop.domain.GameCarinfoVO;

public class WowcarinfoDAO_imple implements WowcarinfoDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.  
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public  WowcarinfoDAO_imple() {
		
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
	public List<GameCarinfoVO> wowCarinfoListSelectAll(String g_code) throws SQLException {
		
		
		List<GameCarinfoVO> wciList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select carinfo_no, fk_g_code, carinfo_bg_gif, carinfo_bg_img1, carinfo_bg_img2, carinfo_bg_img3, carinfo_bg_img4 "
					+ "    , carinfo_bg_img5, carinfo_bg_img6, carinfo_bg_img7, carinfo_bg_img8, carinfo_bg_img9, carinfo_fr_img1, carinfo_fr_img2 "
					+ "    , carinfo_card_img1, carinfo_card_img2, carinfo_card_img3, carinfo_card_img4 "
					+ " from tbl_carinfo_img "
					+ " where FK_G_CODE = ?"
					+ " order by carinfo_no asc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, g_code);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				GameCarinfoVO wcivo = new GameCarinfoVO();
				
				wcivo.setCarinfo_no(rs.getInt(1));
				wcivo.setFk_g_code(rs.getString(2));
				wcivo.setCarinfo_bg_gif(rs.getString(3));
				wcivo.setCarinfo_bg_img1(rs.getString(4));
				wcivo.setCarinfo_bg_img2(rs.getString(5));
				wcivo.setCarinfo_bg_img3(rs.getString(6));
				wcivo.setCarinfo_bg_img4(rs.getString(7));
				wcivo.setCarinfo_bg_img5(rs.getString(8));
				wcivo.setCarinfo_bg_img6(rs.getString(9));
				wcivo.setCarinfo_bg_img7(rs.getString(10));
				wcivo.setCarinfo_bg_img8(rs.getString(11));
				wcivo.setCarinfo_bg_img9(rs.getString(12));
				wcivo.setCarinfo_fr_img1(rs.getString(13));
				wcivo.setCarinfo_fr_img2(rs.getString(14));
				wcivo.setCarinfo_card_img1(rs.getString(15));
				wcivo.setCarinfo_card_img2(rs.getString(16));
				wcivo.setCarinfo_card_img3(rs.getString(17));
				wcivo.setCarinfo_card_img4(rs.getString(18));
				
				wciList.add(wcivo);

			}// end of if(rs.next())-----------------
			
		} finally {
			close();
		}
		return wciList;
	}
	
}
