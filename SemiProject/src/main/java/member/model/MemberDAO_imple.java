package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
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

import member.domain.MemberVO;
import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO_imple implements MemberDAO {

	private DataSource ds; // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.  
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;	

	private AES256 aes;
	
	// 생성자
	public MemberDAO_imple() {
		
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
	
	
	// 회원가입을 해주는 메소드 (tbl_member 테이블에 insert)
	@Override
	public int registerMember(MemberVO member) throws SQLException {
		
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " insert into tbl_user (user_id, user_pwd, user_name, user_phone, user_email, user_zipcode, user_address, user_detail_address, user_extraaddress, user_birthday, user_gender) " 
	                  + " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1, member.getUser_id());
	         pstmt.setString(2, Sha256.encrypt(member.getUser_pwd()) ); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. 
	         pstmt.setString(3, member.getUser_name());
	         pstmt.setString(4, aes.encrypt(member.getUser_phone()) ); // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다. 
	         pstmt.setString(5, aes.encrypt(member.getUser_email()) );  // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다. 
	         pstmt.setString(6, member.getUser_zipcode());
	         pstmt.setString(7, member.getUser_address());
	         pstmt.setString(8, member.getUser_detail_address());
	         pstmt.setString(9, member.getUser_extraaddress());
	         pstmt.setString(10, member.getUser_birthday());
	         pstmt.setString(11, member.getUser_gender());

	         
	         result = pstmt.executeUpdate();
	         
	      }catch(GeneralSecurityException | UnsupportedEncodingException e) {
	         e.printStackTrace();
	      }
	       finally {
	         close();
	      }
	      
	      return result;
	      	
	}// end of public int registerMember(MemberVO member) throws SQLException-------
	
	


	// 입력받은 paraMap 을 가지고 한명의 회원정보를 리턴시켜주는 메소드(로그인 처리)  
	@Override
	public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException {
		
		MemberVO member = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT user_id, user_name, user_email, user_phone, user_zipcode, user_address, user_detail_address, user_extraaddress, user_gender "+
						 "     , user_birthday, user_coin, user_registerday "+
						 " FROM "+
						 " ( "+
						 " select user_id, user_name, user_email, user_phone, user_zipcode, user_address, user_detail_address, user_extraaddress, user_gender "+
						 "     ,  user_birthday, user_coin, to_char(user_registerday, 'yyyy-mm-dd') AS user_registerday "+
						 "     , trunc( months_between(sysdate, user_lastpwddate) ) AS pwdchangegap "+
						 " from tbl_user "+
						 " where user_status = 1 and user_id = ? and user_pwd = ? "+
						 " ) M "+
						 " CROSS JOIN "+
						 " ( "+
						 " select trunc( months_between(sysdate, max(login_date)) ) AS lastlogingap "+
						 " from tbl_loginhistory " +
						 " where user_id = ? "+
						 " )H ";

			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("user_id"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("user_pwd")));
			pstmt.setString(3, paraMap.get("user_id"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberVO();
				member.setUser_id(rs.getString(1));
				member.setUser_name(rs.getString(2));
				member.setUser_email(aes.decrypt(rs.getString(3)));  
				member.setUser_phone(aes.decrypt(rs.getString(4))); 
				member.setUser_zipcode(rs.getString(5));
				member.setUser_address(rs.getString(6));
				member.setUser_detail_address(rs.getString(7));
				member.setUser_extraaddress(rs.getString(8));
				member.setUser_gender(rs.getString(9));
				member.setUser_birthday(rs.getString(10));
				member.setUser_coin(rs.getInt(11));
				member.setUser_registerday(rs.getString(12)); 
			}
			
		}catch(GeneralSecurityException | UnsupportedEncodingException e) {
		         e.printStackTrace();
		} finally {
			close();

		}
		
		return member;
	}// end of public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException------


	@Override
	public int pwdUpdate(Map<String, String> paraMap) throws SQLException {
	int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_user set user_pwd = ? "+" lastpwddate = sysdate " + " where user_id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, Sha256.encrypt(paraMap.get("new_pwd"))); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다. 
			pstmt.setString(2, paraMap.get("user_id"));

			
			result = pstmt.executeUpdate();
			
		} 
		 finally {
			close();
		}
		
		return result;	
	}
	
	
	// 아이디 찾기(성명, 이메일을 입력받아서 해당 사용자의 아이디를 알려준다)
	@Override
	public String findUserid(Map<String, String> paraMap) throws SQLException {
		 
		String user_id = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select user_id "
			           + " from tbl_user "
			           + " where user_status = 1 and user_name = ? and user_email = ? ";
			
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, paraMap.get("user_name"));
			pstmt.setString(2, aes.encrypt(paraMap.get("user_email"))) ;
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user_id = rs.getString(1);
			}
			
		}catch(GeneralSecurityException | UnsupportedEncodingException e) {
	         e.printStackTrace();
		} finally {
			close();
		}
		
		return user_id;
	}// end of public String findUserid(Map<String, String> paraMap) throws SQLException-----


	// 비밀번호 찾기(아이디, 이메일을 입력받아서 해당 사용자의 존재유무를 알려준다)
	@Override
	public boolean isUserExist(Map<String, String> paraMap) throws SQLException {
		 
		boolean isUserExist = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select user_id "
			           + " from tbl_user "
			           + " where user_status = 1 and user_id = ? and user_email = ? ";
			
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, paraMap.get("user_id"));
			pstmt.setString(2, aes.encrypt(paraMap.get("user_email")));
			
			rs = pstmt.executeQuery();
			
			isUserExist = rs.next();
			
		}catch(GeneralSecurityException | UnsupportedEncodingException e) {
	         e.printStackTrace();
		} finally {
			close();
		}
		
		return isUserExist;
	} // end of public boolean isUserExist(Map<String, String> paraMap) throws SQLException {


	
	

	// *** 페이징 처리를 안한 모든 회원 또는 검색한 모든 회원 목록 보여주기 *** //
	@Override
	public List<MemberVO> select_Member_nopaging(Map<String, String> paraMap) throws SQLException{

		List<MemberVO> memberList = new ArrayList<>();
		
		
		try {
			conn = ds.getConnection();
			
			String sql = " select user_id, user_name, user_email, user_gender "
			           + " from tbl_user "
			           + " where user_id != 'admin' ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord"); // 검색대상이 암호화 되어있다면 암호화도 시켜야한다."lee.yo.sub94@gmail.com" ==> ""
			
			if("email".equals(colname)) {
				searchWord = aes.encrypt(searchWord);
			}
			
			if( (colname != null && !colname.trim().isEmpty()) && (searchWord!=null && !searchWord.trim().isEmpty())) {
				// sql+= " and ? like '%' || ? || '%' ";
				// 컬럼명과 테이블명은 위치홀더(?) 로 사용하면 안된다.
				// 위치홀더(?)로 들어오는 것은 컬럼명과 테이블 명이 아닌 오직 데이터값만 들어온다.
				sql+= " and " + colname+ " like '%' || ? || '%' ";
			}
			
			sql += " order by user_registerday desc ";
			
			pstmt = conn.prepareStatement(sql); 
			
			if( (colname != null && !colname.trim().isEmpty()) && (searchWord!=null && !searchWord.trim().isEmpty())) {
				pstmt.setString(1, searchWord);
			}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
			
				MemberVO mvo = new MemberVO();
				mvo.setUser_id(rs.getString(1));
				mvo.setUser_name(rs.getString(2));
				mvo.setUser_email(aes.decrypt(rs.getString(3)));
				mvo.setUser_gender(rs.getString(4));
				
				memberList.add(mvo);
			}
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return memberList;		
	}//end of 	public List<MemberVO> select_Member_nopaging(Map<String, String> paraMap) throws SQLException{

	
	// *** 페이징 처리를 한 모든 회원 또는 검색한 모든 회원 목록 보여주기 *** //
	@Override
	public List<MemberVO> select_Member_paging(Map<String, String> paraMap) throws SQLException {

		List<MemberVO> memberList = new ArrayList<>();
		
		
		try {
			conn = ds.getConnection();
			
			String sql =  " select user_id, user_name, user_email, user_gender "
						+ " from( "
						+ "    select rownum as RNO, user_id, user_name, user_email, user_gender "
						+ "    from( "
						+ "        select user_id, user_name, user_email, user_gender "
						+ "        from tbl_user "
						+ "        where user_id != 'admin' ";
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord"); // 검색대상이 암호화 되어있다면 암호화도 시켜야한다."lee.yo.sub94@gmail.com" ==> ""
			
			if("email".equals(colname)) {
				searchWord = aes.encrypt(searchWord);
			}
			
			if( (colname != null && !colname.trim().isEmpty()) && (searchWord!=null && !searchWord.trim().isEmpty())) {
				// sql+= " and ? like '%' || ? || '%' ";
				// 컬럼명과 테이블명은 위치홀더(?) 로 사용하면 안된다.
				// 위치홀더(?)로 들어오는 것은 컬럼명과 테이블 명이 아닌 오직 데이터값만 들어온다.
				sql+= " and " + colname + " like '%' || ? || '%' ";
			}
			
				sql+= "        order by user_registerday desc "
					+ "        )V "
					+ "        )T "
					+ " WHERE T.RNO between ? and ? ";
			    // === 페이징처리의 공식 ===
	    	    // where RNO between (조회하고자하는페이지번호 * 한페이지당보여줄행의개수) - (한페이지당보여줄행의개수 - 1) and (조회하고자하는페이지번호 * 한페이지당보여줄행의개수);
	    	
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
		    
			pstmt = conn.prepareStatement(sql); 
			
			if( (colname != null && !colname.trim().isEmpty()) && (searchWord!=null && !searchWord.trim().isEmpty())) {
				// 검색이 있다면
				pstmt.setString(1, searchWord);
				pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage)); // 공식
			}
			else {
				// 검색이 없는 경우
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage)); // 공식

			}
			rs = pstmt.executeQuery();
			
			while(rs.next()){
			
				MemberVO mvo = new MemberVO();
				mvo.setUser_id(rs.getString(1));
				mvo.setUser_name(rs.getString(2));
				mvo.setUser_email(aes.decrypt(rs.getString(3)));
				mvo.setUser_gender(rs.getString(4));
				
				memberList.add(mvo);
			}
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return memberList;		
	}// end of	public List<MemberVO> select_Member_paging(Map<String, String> paraMap) throws SQLException {

	// 페이징 처리를 위한 인원에 따른 페이지수 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {

		int totalPage=0;
			
			
			try {
				conn = ds.getConnection();
				
				String sql =  " select ceil(count(*)/?) "
							+ " from tbl_user "
							+ " where user_id != 'admin' ";
				
				String colname = paraMap.get("searchType");
				String searchWord = paraMap.get("searchWord"); // 검색대상이 암호화 되어있다면 암호화도 시켜야한다."lee.yo.sub94@gmail.com" ==> ""
				
				if("email".equals(colname)) {
					searchWord = aes.encrypt(searchWord);
				}
				
				if( (colname != null && !colname.trim().isEmpty()) && (searchWord!=null && !searchWord.trim().isEmpty())) {
					// sql+= " and ? like '%' || ? || '%' ";
					// 컬럼명과 테이블명은 위치홀더(?) 로 사용하면 안된다.
					// 위치홀더(?)로 들어오는 것은 컬럼명과 테이블 명이 아닌 오직 데이터값만 들어온다.
					sql+= " and " + colname + " like '%' || ? || '%' ";
				}
				pstmt = conn.prepareStatement(sql);
				// pstmt.setString(1, paraMap.get("sizePerPage")); // 오라클에서 자동 형변환 시켜준다
				pstmt.setInt(1, Integer.parseInt(paraMap.get("sizePerPage")));
				
				if( (colname != null && !colname.trim().isEmpty()) && (searchWord!=null && !searchWord.trim().isEmpty())) {
					pstmt.setString(2, searchWord);
				}
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				totalPage = rs.getInt(1);
				
			
			} catch(GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();
			} finally {
				close();
			}
			
			return totalPage;		
	}//end of 	public int getTotalPage(Map<String, String> paraMap) throws SQLException {

	
	// 입력받은 userid를 가지고 한명의 회원정보를 리턴시켜주는 메소드 
	@Override
	public MemberVO selectOneMember(String user_id) throws SQLException {
		
		MemberVO member = null;
		
		try {
			conn = ds.getConnection();
			
			String sql =" select user_id, user_name, user_email, user_phone, user_zipcode, user_address, user_detail_address, user_extraaddress, user_gender "
					+ "      , user_birthday, user_coin, to_char(user_registerday, 'yyyy-mm-dd') AS user_registerday "
					+ " from tbl_user "
					+ " where user_status = 1 and user_id = ? "; 
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user_id);
						
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberVO();
				
				member.setUser_id(rs.getString(1));
				member.setUser_name(rs.getString(2));
				member.setUser_email( aes.decrypt(rs.getString(3)) );  // 복호화
				member.setUser_phone( aes.decrypt(rs.getString(4)) ); // 복호화
				member.setUser_zipcode(rs.getString(5));
				member.setUser_address(rs.getString(6));
				member.setUser_detail_address(rs.getString(7));
				member.setUser_extraaddress(rs.getString(8));
				member.setUser_gender(rs.getString(9));
				member.setUser_birthday(rs.getString(10));
				member.setUser_coin(rs.getInt(11));
				member.setUser_registerday(rs.getString(12));
			
			} //end of if(rs.next()) {

		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return member;
	}// end of 	public MemberVO selectOneMember(String userid) throws SQLException {

	// 회원의 개인 정보 변경하기 
	@Override
	public int updateMember(MemberVO member) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_user set user_name = ? "
					   + "                     , user_pwd = ? "
					   + "                     , user_email = ? "
					   + "                     , user_phone = ? "
					   + "                     , user_zipcode = ? " 
					   + "                     , user_address = ? "
					   + "                     , user_detail_address = ? "
					   + "                     , user_extraaddress = ? "
					   + "                     , user_lastpwdchangedate = sysdate "
					   + " where user_id = ? ";
						
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getUser_name());
			pstmt.setString(2, Sha256.encrypt(member.getUser_pwd()) ); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
			pstmt.setString(3, aes.encrypt(member.getUser_email()) );  // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다. 
			pstmt.setString(4, aes.encrypt(member.getUser_phone()) ); // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다. 
			pstmt.setString(5, member.getUser_zipcode());
			pstmt.setString(6, member.getUser_address());
			pstmt.setString(7, member.getUser_detail_address());
			pstmt.setString(8, member.getUser_extraaddress());
			pstmt.setString(9, member.getUser_id());
						
			result = pstmt.executeUpdate();
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		 finally {
			close();
		}
		
		return result;		
		
	}// end of public int updateMember(MemberVO member) throws SQLException--------- 


	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true 를 리턴해주고, userid 가 존재하지 않으면 false 를 리턴한다) 
	@Override
	public boolean idDuplicateCheck(String user_id) throws SQLException {
		
		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select user_id "
					   + " from tbl_user "
					   + " where user_id = ? ";
			
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, user_id);
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next(); // 행이 있으면(중복된 userid) true,
			                      // 행이 없으면(사용가능한 userid) false
			
		} finally {
			close();
		}
		
		return isExists;
	}// end of public boolean idDuplicateCheck(String user_id) throws SQLException---------------


	// email 중복검사 (tbl_member 테이블에서 email 이 존재하면 true 를 리턴해주고, email 이 존재하지 않으면 false 를 리턴한다) 
	@Override
	public boolean emailDuplicateCheck(String user_email) throws SQLException {

		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select user_email "
					   + " from tbl_user "
					   + " where user_email = ? ";
			
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, aes.encrypt(user_email));
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next(); // 행이 있으면(중복된 email) true,
			                      // 행이 없으면(사용가능한 email) false
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return isExists;
	}// end of public boolean emailDuplicateCheck(String user_email) throws SQLException------
	
	
	
	
	
	
	
	
	
	
}