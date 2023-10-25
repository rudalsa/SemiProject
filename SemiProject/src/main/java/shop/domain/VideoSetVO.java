package shop.domain;

public class VideoSetVO {

	private int    video_set_no;        // 비디오번호
	private String fk_g_code;           // 게임코드(Foreign Key)의 시퀀스번호 참조
	private String video_set_bg_img;    // 배경이미지
	private String video_set_logo_img;  // 로고이미지
	private String video_set_gif;       // 비디오
	
	public VideoSetVO() {}

	public VideoSetVO(int video_set_no, String fk_g_code, String video_set_bg_img, 
			          String video_set_logo_img, String video_set_gif) {

		this.video_set_no = video_set_no;
		this.fk_g_code = fk_g_code;
		this.video_set_bg_img = video_set_bg_img;
		this.video_set_logo_img = video_set_logo_img;
		this.video_set_gif = video_set_gif;
	}

	public int getVideo_set_no() {
		return video_set_no;
	}

	public void setVideo_set_no(int video_set_no) {
		this.video_set_no = video_set_no;
	}

	public String getFk_g_code() {
		return fk_g_code;
	}

	public void setFk_g_code(String fk_g_code) {
		this.fk_g_code = fk_g_code;
	}

	public String getVideo_set_bg_img() {
		return video_set_bg_img;
	}

	public void setVideo_set_bg_img(String video_set_bg_img) {
		this.video_set_bg_img = video_set_bg_img;
	}

	public String getVideo_set_logo_img() {
		return video_set_logo_img;
	}

	public void setVideo_set_logo_img(String video_set_logo_img) {
		this.video_set_logo_img = video_set_logo_img;
	}

	public String getVideo_set_gif() {
		return video_set_gif;
	}

	public void setVideo_set_gif(String video_set_gif) {
		this.video_set_gif = video_set_gif;
	}
	
	
}


