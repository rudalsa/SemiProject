package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import member.domain.MemberVO;
import member.domain.OrderViewVO;
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
						"     , user_birthday, user_coin, user_payment, user_registerday, pwdchangegap "+
						"     , nvl( user_lastlogingap , trunc( months_between(sysdate, to_date(user_registerday, 'yyyy-mm-dd'))) ) AS user_lastlogingap "+
						" 	  , user_idle " +
						" FROM "+
						"        (                        "+
						"        select user_id, user_name, user_email, user_phone, user_zipcode, user_address, user_detail_address, user_extraaddress, user_gender "+
						"             , user_birthday, user_coin, user_payment, to_char(user_registerday, 'yyyy-mm-dd') AS user_registerday "+
						"             , trunc( months_between(sysdate, user_lastpwddate) ) AS pwdchangegap , user_idle "+
						"        from tbl_user "+
						"        where user_status = 1 and user_id = ? and user_pwd = ? "+
						"        ) U "+
						"        CROSS JOIN "+
						"        ( "+
						"        select trunc( months_between(sysdate, max(login_date)) ) AS user_lastlogingap "+
						"        from tbl_loginhistory "+
						"        where user_id = ? "+
						"        ) H " ;

			
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
				member.setUser_payment(rs.getInt(12));
				member.setUser_registerday(rs.getString(13));
				member.setUser_idle(rs.getInt(16));

				if(rs.getInt(16) == 0 && rs.getInt(14) >= 3) {
					// 휴면이 아니면서 
					// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
					// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false 
					
					member.setRequirePwdChange(true); // 로그인시 암호를 변경해라는 alert 를 띄우도록 할때 사용한다. 
				}
				
				if(rs.getInt(16) == 0 && rs.getInt(15) >= 12) {
				    // 휴면이 아니면서
					// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 휴면으로 지정 
					member.setUser_idle(1);
					
					// === tbl_user 테이블의 user_idle 컬럼의 값을 1로 변경하기 === //
					sql = " update tbl_user set user_idle = 1 "
						+ " where user_id = ? "; 
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("user_id"));
					
					pstmt.executeUpdate();
				}
				
				// === 휴면이 아닌 회원만 tbl_loginhistory(로그인기록) 테이블에 insert 하기 === // 
				if(rs.getInt(16) == 0) {
					 
					sql = " insert into tbl_loginhistory(historyno, user_id, login_ip) "
						+ " values(seq_historyno.nextval, ?, ?) "; 
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, paraMap.get("user_id"));
					pstmt.setString(2, paraMap.get("login_ip"));
					
					pstmt.executeUpdate();
				}
				
			} // end of if(rs.next())-------------------
			
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
			
			String sql = " UPDATE tbl_user "
					+ " SET user_pwd = ? , user_lastpwddate = sysdate "
					+ " WHERE user_id = ? ";
			
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
			           + " where user_id != 'admin' and user_status = 1 ";
			
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
						+ "        where user_id != 'admin'  and user_status = 1 ";
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
							+ " where user_id != 'admin' and user_status = 1 ";
				
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
			
			String sql = " update tbl_user set USER_NAME = ? "
					   + "                     , USER_PWD = ? "
					   + "                     , USER_EMAIL = ? "
					   + "                     , USER_PHONE = ? "
					   + "                     , USER_ZIPCODE = ? " 
					   + "                     , USER_ADDRESS = ? "
					   + "                     , USER_DETAIL_ADDRESS = ? "
					   + "                     , USER_EXTRAADDRESS = ? "
					   + "                     , USER_LASTPWDDATE = sysdate "
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

	// 사용자의 포인트 및 결제 누적 금액을 업데이트 해준다.
	@Override
	public int BuyUpdateUser(Map<String, String> paraMap) throws SQLException {
int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " UPDATE tbl_user "
					+ " SET user_payment = user_payment + ? , user_coin = user_coin + ? "
					+ " WHERE user_id = ? ";
						
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(paraMap.get("coinmoney")));
			pstmt.setInt(2, (int) (Integer.parseInt(paraMap.get("coinmoney")) * 0.01) );  // 300000 * 0.01 ==> 3000.0  ==> (int)3000.0  ==> 3000  
			pstmt.setString(3, paraMap.get("user_id"));  
						
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		
		return result;
	}
	
	
	// 회원정보 수정시 email 중복검사 (tbl_member 테이블에서 다른 사용자가 email 이 존재하면 true 를 리턴해주고, email 이 존재하지 않으면 false 를 리턴한다) 
	@Override
	public boolean emailDuplicateCheck2(Map<String, String> paraMap) throws SQLException {

		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select user_email "
					   + " from tbl_user "
					   + " where user_id != ? and user_email = ? ";
			
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, paraMap.get("user_id"));
			pstmt.setString(2, aes.encrypt(paraMap.get("user_email")));
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next(); // 행이 있으면(중복된 email) true,
			                      // 행이 없으면(사용가능한 email) false
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return isExists;		
		
	}// end of public boolean emailDuplicateCheck2(Map<String, String> paraMap) throws SQLException-----

	
	// 비밀번호 변경시 현재 사용중인 비밀번호인지 아닌지 알아오기(현재 사용중인 비밀번호 이라면 true, 새로운 비밀번호이라면 false) 
	@Override
	public boolean duplicatePwdCheck(Map<String, String> paraMap) throws SQLException {

		boolean isExists = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select user_pwd "
					   + " from tbl_user "
					   + " where user_id = ? and user_pwd = ? ";
			
			pstmt = conn.prepareStatement(sql); 
			pstmt.setString(1, paraMap.get("user_id"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("new_pwd")));
			
			rs = pstmt.executeQuery();
			
			isExists = rs.next(); // 행이 있으면(현재 사용중인 비밀번호) true,
			                      // 행이 없으면(새로운 비밀번호) false
			
		} finally {
			close();
		}
		
		return isExists;				
		
	}// end of public boolean duplicatePwdCheck(Map<String, String> paraMap) throws SQLException----------
	
	@Override
	public int deleteUser(String user_id) throws SQLException {
	int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " UPDATE tbl_user "
					+ " SET user_status = 0, user_lastpwddate = sysdate "
					+ " WHERE user_id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			 
			pstmt.setString(1, user_id);
			
			result = pstmt.executeUpdate();
			
		} 
		 finally {
			close();
		}
		
		return result;	
	}


	// 로그인 1년 경과된 회원을 tbl_user 테이블에서 idle 값을 1로 변경해주기
	@Override
	public int updateIdle(Map<String, String> paraMap) throws SQLException {
		
		int idle = 0; 
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_user set user_idle = 1 "
					   + " where user_id = ? "; 
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("user_id"));
			
			pstmt.executeUpdate();
			
		} 
		 finally {
			close();
		}
		
		return idle;
	} // end of public int updateIdle(Map<String, String> paraMap) throws SQLException ----------
	
	// 계정 인증하고 휴면 풀어주는 메소드 
		@Override
		public boolean idleremove(Map<String, String> paraMap) throws SQLException {
			
			boolean idleremove = false;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select user_id "
				           + " from tbl_user "
				           + " where user_status = 1 and user_id = ? and user_email = ? ";

				
				pstmt = conn.prepareStatement(sql); 
				pstmt.setString(1, paraMap.get("user_id"));
				pstmt.setString(2, aes.encrypt(paraMap.get("user_email")));
				
				  rs = pstmt.executeQuery();

				  idleremove = rs.next();

		           if (idleremove) {
		               // 계정 확인 후 휴면 상태를 해제하는 UPDATE 쿼리를 실행하도록 코드를 추가
		               
		        	   String updateSql = " UPDATE tbl_user " 
		                               +  " SET USER_IDLE = 0 " 
		                               +  " WHERE user_status = 1 AND user_id = ? AND user_email = ? ";
		               pstmt = conn.prepareStatement(updateSql);
		               pstmt.setString(1, paraMap.get("user_id"));
		               pstmt.setString(2, aes.encrypt(paraMap.get("user_email")));
		               
		               pstmt.executeUpdate();
		           }

		       } catch (GeneralSecurityException | UnsupportedEncodingException e) {
		           e.printStackTrace();
		       } finally {
		           close();
		       }

		       return idleremove;
		       
		}// end of public boolean idleremove(Map<String, String> paraMap) throws SQLException
<<<<<<< HEAD
		
		
		
	      // 회원 구매내역 조회
	      @Override
	      public List<OrderViewVO> Buyremember(String user_id) throws SQLException {
	         
	         List<OrderViewVO> rememberList = new ArrayList<>();
	         
	         try {
	            conn = ds.getConnection();
	            
	            String sql = "  select D.fk_odrcode, fk_optinfono, oqty, odrprice, CASE deliverstatus WHEN 1 THEN '주문완료' WHEN 2 THEN '배송중' WHEN 3 THEN '배송완료'END AS deliverstatus, "
	                  + " odrdate, imgfile, opt_name, opt_sale_price, opt_content, D.ODRSEQNO, order_zipcode, order_address, order_detailaddress, order_extraaddress, order_name,  order_phone, "
	                  + " nvl(order_content, '배송요청사항이 없습니다') AS order_content "
	                  + " from tbl_orderdetail D "
	                  + " join tbl_order O "
	                  + " on O.odrcode = D.fk_odrcode "
	                  + " join TBL_PRODUCT_OPTINFO T "
	                  + " on T.optinfono = D.fk_optinfono "
	                  + " join tbl_order_info I "
	                  + " on I.FK_ODRCODE = D.fk_odrcode "
	                  + " where O.fk_userid = ? "
	                  + " order by D.ODRSEQNO desc  "
	                  + " ";
	            
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, user_id);
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	               
	               OrderViewVO viewvo = new OrderViewVO();
	               
	               viewvo.setFk_odrcode(rs.getString(1));
	               viewvo.setFk_optinfono(rs.getInt(2));
	               viewvo.setOqty(rs.getInt(3));
	               viewvo.setOdrprice(rs.getInt(4));
	               viewvo.setDeliverstatus(rs.getString(5));
	               viewvo.setOdrdate(rs.getString(6));
	               viewvo.setImgfile(rs.getString(7));
	               viewvo.setOpt_name(rs.getString(8));
	               viewvo.setOpt_sale_price(rs.getInt(9));
	               viewvo.setOpt_content(rs.getString(10));
	               viewvo.setOrder_zipcode(rs.getString(12));
	               viewvo.setOrder_address(rs.getString(13));
	               viewvo.setOrder_detailaddress(rs.getString(14));
	               viewvo.setOrder_extraaddress(rs.getString(15));
	               viewvo.setOrder_name(rs.getString(16));
	               viewvo.setOrder_phone(rs.getString(17));
	               viewvo.setOrder_content(rs.getString(18));
	               
	               
	               rememberList.add(viewvo);
	            }// end of while(rs.next())-----------------
	            
	         } finally {
	            close();
	         }
	            return rememberList;
	      }
=======
<<<<<<< HEAD
		
		
		
	      // 회원 구매내역 조회
	      @Override
	      public List<OrderViewVO> Buyremember(String user_id) throws SQLException {
	         
	         List<OrderViewVO> rememberList = new ArrayList<>();
	         
	         try {
	            conn = ds.getConnection();
	            
	            String sql = "  select D.fk_odrcode, fk_optinfono, oqty, odrprice, CASE deliverstatus WHEN 1 THEN '주문완료' WHEN 2 THEN '배송중' WHEN 3 THEN '배송완료'END AS deliverstatus, "
	                  + " odrdate, imgfile, opt_name, opt_sale_price, opt_content, D.ODRSEQNO, order_zipcode, order_address, order_detailaddress, order_extraaddress, order_name,  order_phone, "
	                  + " nvl(order_content, '배송요청사항이 없습니다') AS order_content "
	                  + " from tbl_orderdetail D "
	                  + " join tbl_order O "
	                  + " on O.odrcode = D.fk_odrcode "
	                  + " join TBL_PRODUCT_OPTINFO T "
	                  + " on T.optinfono = D.fk_optinfono "
	                  + " join tbl_order_info I "
	                  + " on I.FK_ODRCODE = D.fk_odrcode "
	                  + " where O.fk_userid = ? "
	                  + " order by D.ODRSEQNO desc  "
	                  + " ";
	            
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, user_id);
	            rs = pstmt.executeQuery();
	            
	            while(rs.next()) {
	               
	               OrderViewVO viewvo = new OrderViewVO();
	               
	               viewvo.setFk_odrcode(rs.getString(1));
	               viewvo.setFk_optinfono(rs.getInt(2));
	               viewvo.setOqty(rs.getInt(3));
	               viewvo.setOdrprice(rs.getInt(4));
	               viewvo.setDeliverstatus(rs.getString(5));
	               viewvo.setOdrdate(rs.getString(6));
	               viewvo.setImgfile(rs.getString(7));
	               viewvo.setOpt_name(rs.getString(8));
	               viewvo.setOpt_sale_price(rs.getInt(9));
	               viewvo.setOpt_content(rs.getString(10));
	               viewvo.setOrder_zipcode(rs.getString(12));
	               viewvo.setOrder_address(rs.getString(13));
	               viewvo.setOrder_detailaddress(rs.getString(14));
	               viewvo.setOrder_extraaddress(rs.getString(15));
	               viewvo.setOrder_name(rs.getString(16));
	               viewvo.setOrder_phone(rs.getString(17));
	               viewvo.setOrder_content(rs.getString(18));
	               
	               
	               rememberList.add(viewvo);
	            }// end of while(rs.next())-----------------
	            
	         } finally {
	            close();
	         }
	            return rememberList;
	      }
=======
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
>>>>>>> branch 'main' of https://github.com/k971230/SemiProject.git
	
	
}