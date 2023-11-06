package gameopt.domain;

public class OptVO {
	
	private	int optinfono ;  
	private String fk_g_code ;    // 제품번호(foreign key)
	private String imgfile;       // 옵션이미지파일명
	private String opt_name;      // 옵션이미지파일명
	private	int opt_price ;       // 옵션이미지파일명
	private	int opt_sale_price;   // 옵션이미지파일명
	private String opt_content;      // 소개
	private int opt_qty;
	private int opt_coin; 
	private int opt_totalPrice;         // 판매당시의 제품판매가 * 주문량
	private int opt_totalPoint;         // 판매당시의 포인트점수 * 주문량 
	
	
	public int getOpt_coin() {
		return opt_coin;
	}
	public void setOpt_coin(int opt_coin) {
		this.opt_coin = opt_coin;
	}
	public int getOpt_qty() {
		return opt_qty;
	}
	public void setOpt_qty(int opt_qty) {
		this.opt_qty = opt_qty;
	}


	

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
	public String getOpt_content() {
		return opt_content;
	}
	public void setOpt_content(String opt_content) {
		this.opt_content = opt_content;
	}

	///////////////////////////////////////////////
	// *** 제품의 할인률 ***
	public int getDiscountPercent() {
		// 정가   :  판매가 = 100 : x
		
		// 5000 : 3800 = 100 : x
		// x = (3800*100)/5000 
		// x = 76
		// 100 - 76 ==> 24% 할인
		
		// 할인률 = 100 - (판매가 * 100) / 정가
		return 100 - (opt_sale_price * 100)/opt_price;
	}
	
	
	
	
	/////////////////////////////////////////////////
	// *** 제품의 총판매가(실제판매가 * 주문량) 구해오기 ***
	public void setTotalPriceTotalPoint(int oqty) {   
	// int oqty 이 주문량이다.
	
	opt_totalPrice = opt_sale_price * oqty; // 판매당시의 제품판매가 * 주문량
	opt_totalPoint = opt_coin * oqty;     // 판매당시의 포인트점수 * 주문량 
	}
	
	public int getOpt_totalPrice() {
	return opt_totalPrice;
	}
	
	public int getOpt_totalPoint() {
	return opt_totalPoint;
	}
		
	
	
	
	
	
	

}
