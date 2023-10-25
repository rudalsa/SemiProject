package shop.domain;

public class ShopPopProductVO {
	
	private int product_no;
	private String product_name;
	private String product_event_name;
	private String img_file_name;
	private String gamegenre;
	private int product_price;
	private int product_sale_price;
	private int product_sale_percent;
	
	
	
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	
	public String getProduct_event_name() {
		return product_event_name;
	}
	public void setProduct_event_name(String product_event_name) {
		this.product_event_name = product_event_name;
	}
	
	public String getImg_file_name() {
		return img_file_name;
	}
	public void setImg_file_name(String img_file_name) {
		this.img_file_name = img_file_name;
	}
	
	public String getGamegenre() {
		return gamegenre;
	}
	public void setGamegenre(String gamegenre) {
		this.gamegenre = gamegenre;
	}
	
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	
	public int getProduct_sale_price() {
		return product_sale_price;
	}
	public void setProduct_sale_price(int product_sale_price) {
		this.product_sale_price = product_sale_price;
	}
	
	public int getProduct_sale_percent() {
		return product_sale_percent;
	}
	public void setProduct_sale_percent(int product_sale_percent) {
		this.product_sale_percent = product_sale_percent;
	}

}
