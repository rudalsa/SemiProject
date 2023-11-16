package member.domain;

public class OrderViewVO {
	
	private String fk_odrcode;
	private int fk_optinfono;
	private int oqty;
	private int odrprice;
	private int deliverstatus;
	private String odrcode;
	private String odrdate;
	private String imgfile;
	private String opt_name;
	private int opt_sale_price;
	private String opt_content;
	
	
	public String getOpt_content() {
		return opt_content;
	}
	public void setOpt_content(String opt_content) {
		this.opt_content = opt_content;
	}
	public String getFk_odrcode() {
		return fk_odrcode;
	}
	public void setFk_odrcode(String fk_odrcode) {
		this.fk_odrcode = fk_odrcode;
	}
	public int getFk_optinfono() {
		return fk_optinfono;
	}
	public void setFk_optinfono(int fk_optinfono) {
		this.fk_optinfono = fk_optinfono;
	}
	public int getOqty() {
		return oqty;
	}
	public void setOqty(int oqty) {
		this.oqty = oqty;
	}
	public int getOdrprice() {
		return odrprice;
	}
	public void setOdrprice(int odrprice) {
		this.odrprice = odrprice;
	}
	
	public String getOdrcode() {
		return odrcode;
	}
	public void setOdrcode(String odrcode) {
		this.odrcode = odrcode;
	}
	
	public String getOdrdate() {
		return odrdate;
	}
	public void setOdrdate(String odrdate) {
		this.odrdate = odrdate;
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
	public int getDeliverstatus() {
		return deliverstatus;
	}
	public void setDeliverstatus(int deliverstatus) {
		this.deliverstatus = deliverstatus;
	}
	public int getOpt_sale_price() {
		return opt_sale_price;
	}
	public void setOpt_sale_price(int opt_sale_price) {
		this.opt_sale_price = opt_sale_price;
	}
	
	
	
	
	

}
