package shop.domain;

public class SpecVO {

	private int s_no;       // 스펙번호       
	private String s_code;  // 스펙코드
	private String s_name;  // 스펙이름
	
	public SpecVO() {}
	
	public SpecVO(int s_no, String s_code, String s_name) {
	
		this.s_no = s_no;
		this.s_code = s_code;
		this.s_name = s_name;
	}

	public int getS_no() {
		return s_no;
	}

	public void setS_no(int s_no) {
		this.s_no = s_no;
	}

	public String getS_code() {
		return s_code;
	}

	public void setS_code(String s_code) {
		this.s_code = s_code;
	}

	public String getS_name() {
		return s_name;
	}

	public void setS_name(String s_name) {
		this.s_name = s_name;
	}

	
	
}
