package gameopt.domain;

public class OptVO {
	
	private	int optinfono ;  
	private String fk_g_code ;    // 제품번호(foreign key)
	private String imgfile;       // 옵션이미지파일명
	private String opt_name;      // 옵션이미지파일명
	private	int opt_price ;       // 옵션이미지파일명
	private	int opt_sale_price;   //  옵션이미지파일명
	
	
	
	public int getOptinfono() {
		return optinfono;
	}
	public void setOptinfono(int optinfono) {
		this.optinfono = optinfono;
	}
	public String getFk_g_code() {
		return fk_g_code;
	}
	public void setFk_g_code(String fk_g_code) {
		this.fk_g_code = fk_g_code;
	}
	public String getImgfile() {
		return imgfile;
	}
	public void setImgfile(String imgfile) {
		this.imgfile = imgfile;
	}
	public String getOpt_name() {
		return opt_name;
	}
	public void setOpt_name(String opt_name) {
		this.opt_name = opt_name;
	}
	public int getOpt_price() {
		return opt_price;
	}
	public void setOpt_price(int opt_price) {
		this.opt_price = opt_price;
	}
	public int getOpt_sale_price() {
		return opt_sale_price;
	}
	public void setOpt_sale_price(int opt_sale_price) {
		this.opt_sale_price = opt_sale_price;
	}

	

}
