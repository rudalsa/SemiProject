package shop.domain;

import gameopt.domain.OptVO;

public class GameVO {

	private int 	g_no;       // 게임번호
	private String 	g_code;     // 게임코드
	private String 	g_name;     // 게임이름
	private String  fk_c_code;  // 카테고리코드(Foreign Key)의 시퀀스번호 참조
	private String  g_company;  // 게임회사명
	private String  g_img_1;    // 게임이미지1   이미지파일명
	private String  g_img_2;    // 게임이미지2   이미지파일명 
	private int 	g_qty;      // 게임 재고량
	private int 	g_price;      // 게임 정가
	private int 	g_sale_price;  // 게임 판매가(할인해서 팔 것이므로)
	private String 	fk_s_code;    // 'HIT', 'NEW', 'BEST' 에 대한 스펙번호인 시퀀스번호를 참조
	private String 	g_content;   // 게임설명 
	private int 	g_coin;      // 포인트 점수                                         
	private String 	g_inputdate; // 게임입고일자	
	private String 	g_info; // 게임정보
	

	
	private CategoryVO categvo; // 카테고리VO 
	private SpecVO spvo;        // 스펙VO 
	private OptVO optvo; // 카테고리VO 
	
	
	public OptVO getOptvo() {
		return optvo;
	}



	public void setOptvo(OptVO optvo) {
		this.optvo = optvo;
	}

	/*
	    제품판매가와 포인트점수 컬럼의 값은 관리자에 의해서 변경(update)될 수 있으므로
	    해당 제품의 판매총액과 포인트부여 총액은 판매당시의 제품판매가와 포인트 점수로 구해와야 한다.  
	*/
	private int g_totalPrice;         // 판매당시의 제품판매가 * 주문량
	private int g_totalPoint;         // 판매당시의 포인트점수 * 주문량 
		
	
	public GameVO() { }
	
	
	
	public GameVO(int g_no, String g_code, String g_name, String fk_c_code, 
			         String g_company, String g_img_1, String g_img_2,
			         int g_qty, int g_price, int g_sale_price, String fk_s_code, 
			         String g_content, int g_coin, String g_inputdate) {
	
		this.g_no = g_no;
		this.g_code = g_code;
		this.g_name = g_name;
		this.fk_c_code = fk_c_code;
		this.g_company = g_company;
		this.g_img_1 = g_img_1;
		this.g_img_2 = g_img_2;
		this.g_qty = g_qty;
		this.g_price = g_price;
		this.g_sale_price = g_sale_price;
		this.fk_s_code = fk_s_code;
		this.g_content = g_content;
		this.g_coin = g_coin;
		this.g_inputdate = g_inputdate;
	
	
	}

	
	public int getG_no() {
		return g_no;
	}

	public void setG_no(int g_no) {
		this.g_no = g_no;
	}

	public String getG_code() {
		return g_code;
	}

	public void setG_code(String g_code) {
		this.g_code = g_code;
	}

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String g_name) {
		this.g_name = g_name;
	}

	public String getFk_c_code() {
		return fk_c_code;
	}

	public void setFk_c_code(String fk_c_code) {
		this.fk_c_code = fk_c_code;
	}

	public String getG_company() {
		return g_company;
	}

	public void setG_company(String g_company) {
		this.g_company = g_company;
	}

	public String getG_img_1() {
		return g_img_1;
	}

	public void setG_img_1(String g_img_1) {
		this.g_img_1 = g_img_1;
	}

	public String getG_img_2() {
		return g_img_2;
	}

	public void setG_img_2(String g_img_2) {
		this.g_img_2 = g_img_2;
	}

	public int getG_qty() {
		return g_qty;
	}

	public void setG_qty(int g_qty) {
		this.g_qty = g_qty;
	}

	public int getG_price() {
		return g_price;
	}

	public void setG_price(int g_price) {
		this.g_price = g_price;
	}

	public int getG_sale_price() {
		return g_sale_price;
	}

	public void setG_sale_price(int g_sale_price) {
		this.g_sale_price = g_sale_price;
	}

	public String getFk_s_code() {
		return fk_s_code;
	}

	public void setFk_s_code(String fk_s_code) {
		this.fk_s_code = fk_s_code;
	}

	public String getG_content() {
		return g_content;
	}

	public void setG_content(String g_content) {
		this.g_content = g_content;
	}

	public int getG_coin() {
		return g_coin;
	}

	public void setG_coin(int g_coin) {
		this.g_coin = g_coin;
	}

	public String getG_inputdate() {
		return g_inputdate;
	}

	public void setG_inputdate(String g_inputdate) {
		this.g_inputdate = g_inputdate;
	}

	public CategoryVO getCategvo() {
		return categvo;
	}

	public void setCategvo(CategoryVO categvo) {
		this.categvo = categvo;
	}

	public SpecVO getSpvo() {
		return spvo;
	}

	public void setSpvo(SpecVO spvo) {
		this.spvo = spvo;
	}
	public String getG_info() {
		return g_info;
	}



	public void setG_info(String g_info) {
		this.g_info = g_info;
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
		return 100 - (g_sale_price * 100)/g_price;
	}
	
	
	/////////////////////////////////////////////////
	// *** 제품의 총판매가(실제판매가 * 주문량) 구해오기 ***
	public void setTotalPriceTotalPoint(int oqty) {   
		// int oqty 이 주문량이다.
	
		g_totalPrice = g_sale_price * oqty; // 판매당시의 제품판매가 * 주문량
		g_totalPoint = g_coin * oqty;     // 판매당시의 포인트점수 * 주문량 
	}
	
	public int getG_totalPrice() {
		return g_totalPrice;
	}
	
	public int getG_totalPoint() {
		return g_totalPoint;
	}
	
}
