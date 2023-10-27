package b_shop.domain;

public class CategoryVO {

	private int    c_no;     // 카테고리 대분류 번호
	private String c_code;   // 카테고리 코드
	private String c_name;   // 카테고리명
	
	public CategoryVO() { }
	
	public CategoryVO(int c_no, String c_code, String c_name) {
		this.c_no = c_no;
		this.c_code = c_code;
		this.c_name = c_name;
	}

	public int getC_no() {
		return c_no;
	}

	public void setC_no(int c_no) {
		this.c_no = c_no;
	}

	public String getC_code() {
		return c_code;
	}

	public void setC_code(String c_code) {
		this.c_code = c_code;
	}

	public String getC_name() {
		return c_name;
	}

	public void setC_name(String c_name) {
		this.c_name = c_name;
	}

	
	
}
