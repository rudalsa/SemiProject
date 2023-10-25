package member.domain;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MemberVO {
	private String user_id;				//USER_ID 			VARCHAR2(20 BYTE)
	private String user_pwd;			//USER_PWD 			VARCHAR2(200 BYTE)
	private String user_name;			//USER_NAME 		VARCHAR2(30 BYTE)
	private String user_phone;			//USER_PHONE 		VARCHAR2(200 BYTE)
	private String user_email;			//USER_EMAIL 		VARCHAR2(200 BYTE)
	private String user_zipcode;		//USER_ZIPCODE 		VARCHAR2(5 BYTE)
	private String user_address;		//USER_ADDRESS 		VARCHAR2(200 BYTE)
	private String user_detail_address;	//USER_DETAIL_ADDRESS VARCHAR2(200 BYTE)
	private String user_extraaddress; 	//USER_EXTRAADDRESS VARCHAR2(200 BYTE)
	private String user_birthday;	 	//USER_BIRTHDAY 	VARCHAR2(14 BYTE)
	private String user_gender;		 	//USER_GENDER 		VARCHAR2(1 BYTE)
	private String user_registerday;	//USER_REGISTERDAY 	DATE
	private int user_coin;		 	//USER_MILEAGE 		NUMBER
	private int user_idle;			 	//USER_IDLE 		NUMBER(1,0)
	private int user_status;			//USER_STATUS 		NUMBER(1,0)
	private String user_lastpwddate;	//USER_LASTPWDDATE  DATE
	
	private boolean requirePwdChange = false;
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
	
	// 기본생성자
	public MemberVO() {}
	
	// 회원가입시 생성자
	public MemberVO(String user_id, String user_pwd, String user_name, String user_phone, String user_email,
			String user_zipcode, String user_address, String user_detail_address, String user_extraaddress,
			String user_birthday, String user_gender) {
		this.user_id = user_id;
		this.user_pwd = user_pwd;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_phone = user_phone;
		this.user_zipcode = user_zipcode;
		this.user_address = user_address;
		this.user_detail_address = user_detail_address;
		this.user_extraaddress = user_extraaddress;
		this.user_birthday = user_birthday;
		this.user_gender = user_gender;
	}
	
	// 회원수정시 생성자
		public MemberVO(String user_id, String user_pwd, String user_name, String user_email, String user_phone, String user_zipcode,
			            String user_address, String user_detail_address, String user_extraaddress) { 
			this.user_id = user_id;
			this.user_pwd = user_pwd;
			this.user_name = user_name;
			this.user_email = user_email;
			this.user_phone = user_phone;
			this.user_zipcode = user_zipcode;
			this.user_address = user_address;
			this.user_detail_address = user_detail_address;
			this.user_extraaddress = user_extraaddress;
		}

	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_zipcode() {
		return user_zipcode;
	}
	public void setUser_zipcode(String user_zipcode) {
		this.user_zipcode = user_zipcode;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}
	public String getUser_detail_address() {
		return user_detail_address;
	}
	public void setUser_detail_address(String user_detail_address) {
		this.user_detail_address = user_detail_address;
	}
	public String getUser_extraaddress() {
		return user_extraaddress;
	}
	public void setUser_extraaddress(String user_extraaddress) {
		this.user_extraaddress = user_extraaddress;
	}
	public String getUser_birthday() {
		return user_birthday;
	}
	public void setUser_birthday(String user_birthday) {
		this.user_birthday = user_birthday;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_registerday() {
		return user_registerday;
	}
	public void setUser_registerday(String user_registerday) {
		this.user_registerday = user_registerday;
	}
	
	public int getUser_idle() {
		return user_idle;
	}
	public void setUser_idle(int user_idle) {
		this.user_idle = user_idle;
	}
	public int getUser_status() {
		return user_status;
	}
	public void setUser_status(int user_status) {
		this.user_status = user_status;
	}
	public String getUser_lastpwddate() {
		return user_lastpwddate;
	}
	public void setUser_lastpwddate(String user_lastpwddate) {
		this.user_lastpwddate = user_lastpwddate;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}


	public int getUser_age() {
	      int user_age = 0;
	      
	      // 회원의 올해생일이 현재날짜 보다 이전이라면 
	      // 만나이 = 현재년도 - 회원의 태어난년도 
	            
	      // 회원의 올해생일이 현재날짜 보다 이후이라면
	      // 만나이 = 현재년도 - 회원의 태어난년도 - 1
	            
	      Date now = new Date(); // 현재시각
	      SimpleDateFormat sdfmt = new SimpleDateFormat("yyyyMMdd");
	      String str_now = sdfmt.format(now); // "20231017"
	            
	      // 회원의 올해생일(문자열 타입)
	      String str_now_birthday = str_now.substring(0, 4) + user_birthday.substring(5,7) + user_birthday.substring(8);
	      
	      // 회원의 태어난년도
	      int birth_year = Integer.parseInt(user_birthday.substring(0, 4));
	            
	      // 현재년도
	      int now_year = Integer.parseInt(str_now.substring(0, 4)); 
	            
	      try {
	         Date now_birthday = sdfmt.parse(str_now_birthday); // 회원의 올해생일(연월일) 날짜 타입
	         now = sdfmt.parse(str_now); // 오늘날짜(연월일) 날짜타입
	         
	         if(now_birthday.before(now)) {
	            // 회원의 올해생일이 현재날짜 보다 이전이라면
	            
	        	 user_age = now_year - birth_year; 
	            // 나이 = 현재년도 - 회원의 태어난년도
	         }
	         else {
	            // 회원의 올해생일이 현재날짜 보다 이후이라면
	            
	        	 user_age = now_year - birth_year - 1;
	            // 나이 = 현재년도 - 회원의 태어난년도 - 1
	         }
	         
	      } catch (ParseException e) {
	         
	      }
	      
	      return user_age;
	      
	   /*
	      >> 한국나이 << 
	      
	      Calendar currentDate = Calendar.getInstance(); 
	      // 현재날짜와 시간을 얻어온다.
	      
	      int currentYear = currentDate.get(Calendar.YEAR);
	      
	      age =  currentYear - Integer.parseInt( birthday.substring(0, 4) ) + 1;
	      
	      return age;
	   */	}

	public int getUser_coin() {
		return user_coin;
	}

	public void setUser_coin(int user_coin) {
		this.user_coin = user_coin;
	}
	

}
