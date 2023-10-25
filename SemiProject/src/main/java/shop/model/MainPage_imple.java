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

import shop.domain.*;

public class MainPage_imple implements MainpageDAO {
	
	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.  
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 생성자
	public MainPage_imple() {
		
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
	public List<MainsdVO> sdimageSelectAll() throws SQLException {
		
		List<MainsdVO> sdList = new ArrayList<>();
		 
		try {
			conn = ds.getConnection();
			
			String sql = " select ms_img_no , fk_g_code , ms_bg_file , ms_logo_file "
					+ " from tbl_main_slide "
					+ " order by ms_img_no asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				MainsdVO sdvo = new MainsdVO();
				sdvo.setMs_img_no(rs.getInt(1)); 						
				sdvo.setFk_g_code(rs.getString(2)); 
				sdvo.setMs_bg_file(rs.getString(3));
				sdvo.setMs_logo_file(rs.getString(4));
				
				sdList.add(sdvo);
			}// end of while(rs.next())-----------------
			
		} finally {
			close();
		}
		
		return sdList;
	}


	@Override
	public List<VideoSetVO> videoimageSelectAll() throws SQLException {
		  
		
	  List<VideoSetVO> videoimage = new ArrayList<>();
	      
	  try {
	     
		  conn = ds.getConnection();
	     
	     
		  String sql = " select video_set_no, fk_g_code, video_set_bg_img, video_set_logo_img, video_set_gif "
					  + " from tbl_video_set "
					  + " order by video_set_no asc ";
	 
	 
		  pstmt = conn.prepareStatement(sql);
	 
	 
		  rs = pstmt.executeQuery();
	 
	 
		  while(rs.next()) {
	    
	    
			  VideoSetVO videosetvo = new VideoSetVO();
	    
			  videosetvo.setVideo_set_no(rs.getInt(1));
	    
			  videosetvo.setFk_g_code(rs.getString(2));
	    
			  videosetvo.setVideo_set_bg_img(rs.getString(3));
	    
			  videosetvo.setVideo_set_logo_img(rs.getString(4));
	    
			  videosetvo.setVideo_set_gif(rs.getString(5));
	    
	    
			  videoimage.add(videosetvo);
	 
		  }// end of while(rs.next())-----------------
	     
	  
	  } finally {
	     
		  close();
	  
	  }
	  
	  return videoimage;
	
	}

}
