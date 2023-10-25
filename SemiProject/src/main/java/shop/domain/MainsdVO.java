package shop.domain;

public class MainsdVO {
	
	private int ms_img_no; 	   		// 카테고리 등록순서
	private String fk_g_code;  		// 메인슬라이드 이미지 해당 게임 코드
	private String ms_bg_file; 		// 메인슬라이드 이미지 파일 
	private String ms_logo_file;    //메인슬라이드 로고 이미지 파일
	
	
	public int getMs_img_no() {
		return ms_img_no;
	}
	public void setMs_img_no(int ms_img_no) {
		this.ms_img_no = ms_img_no;
	}
	
	public String getFk_g_code() {
		return fk_g_code;
	}
	public void setFk_g_code(String fk_g_code) {
		this.fk_g_code = fk_g_code;
	}
	
	public String getMs_bg_file() {
		return ms_bg_file;
	}
	public void setMs_bg_file(String ms_bg_file) {
		this.ms_bg_file = ms_bg_file;
	}
	
	public String getMs_logo_file() {
		return ms_logo_file;
	}
	public void setMs_logo_file(String ms_logo_file) {
		this.ms_logo_file = ms_logo_file;
	}
	

}
