package game.domain;

public class GameOptionVO {

	private int gameno;
	private String imgslidefilename;
	private String imgslidefilename_2;
	private String imgslidefilename_3;
	private String imgslidefilename_4;
	
	
	
	private String gamegenre;
	private String gamename;
	private String gamelogo;
	private String gameopt_name;
	private String gameopt_name_2;
	private String gameopt_name_3;
	private int gameopt_discount;
	private int gameopt_discount_2;
	private int gameopt_discount_3;
	private int gameopt_price;
	private int gameopt_price_2;
	private int gameopt_price_3;
	
	
	
	
	/*
	 * public GameOptionVO() {} //////// 
	 * public GameOptionVO(String imgsetno) {
	 * this.imgsetno = imgsetno; 
	 * }
	 */
	
	
	
	
	///////////////////////////////////////////
	public int getGameno() {
		return gameno;
	}
	public String getGamegenre() {
		return gamegenre;
	}
	
	public void setGamegenre(String gamegenre) {
		this.gamegenre = gamegenre;
	}
	
	public String getGamename() {
		return gamename;
	}
	public void setGamename(String gamename) {
		this.gamename = gamename;
	}
	public String getGamelogo() {
		return gamelogo;
	}
	public void setGamelogo(String gamelogo) {
		this.gamelogo = gamelogo;
	}
	public String getGameopt_name() {
		return gameopt_name;
	}
	public void setGameopt_name(String gameopt_name) {
		this.gameopt_name = gameopt_name;
	}
	public String getGameopt_name_2() {
		return gameopt_name_2;
	}
	public void setGameopt_name_2(String gameopt_name_2) {
		this.gameopt_name_2 = gameopt_name_2;
	}
	public String getGameopt_name_3() {
		return gameopt_name_3;
	}
	public void setGameopt_name_3(String gameopt_name_3) {
		this.gameopt_name_3 = gameopt_name_3;
	}
	public void setGameno(int gameno) {
		this.gameno = gameno;
	}
	
	public String getImgslidefilename_2() {
		return imgslidefilename_2;
	}
	public void setImgslidefilename_2(String imgslidefilename_2) {
		this.imgslidefilename_2 = imgslidefilename_2;
	}
	public String getImgslidefilename_3() {
		return imgslidefilename_3;
	}
	public void setImgslidefilename_3(String imgslidefilename_3) {
		this.imgslidefilename_3 = imgslidefilename_3;
	}
	public String getImgslidefilename_4() {
		return imgslidefilename_4;
	}
	public void setImgslidefilename_4(String imgslidefilename_4) {
		this.imgslidefilename_4 = imgslidefilename_4;
	}
	public String getImgslidefilename() {
		return imgslidefilename;
	}
	public int getGameopt_discount() {
		return gameopt_discount;
	}
	public void setGameopt_discount(int gameopt_discount) {
		this.gameopt_discount = gameopt_discount;
	}
	public int getGameopt_discount_2() {
		return gameopt_discount_2;
	}
	public void setGameopt_discount_2(int gameopt_discount_2) {
		this.gameopt_discount_2 = gameopt_discount_2;
	}
	public int getGameopt_discount_3() {
		return gameopt_discount_3;
	}
	public void setGameopt_discount_3(int gameopt_discount_3) {
		this.gameopt_discount_3 = gameopt_discount_3;
	}
	public int getGameopt_price() {
		return gameopt_price;
	}
	public void setGameopt_price(int gameopt_price) {
		this.gameopt_price = gameopt_price;
	}
	public int getGameopt_price_2() {
		return gameopt_price_2;
	}
	public void setGameopt_price_2(int gameopt_price_2) {
		this.gameopt_price_2 = gameopt_price_2;
	}
	public int getGameopt_price_3() {
		return gameopt_price_3;
	}
	public void setGameopt_price_3(int gameopt_price_3) {
		this.gameopt_price_3 = gameopt_price_3;
	}
	public void setImgslidefilename(String imgslidefilename) {
		this.imgslidefilename = imgslidefilename;
	}


	///////
	
	
	// *** 제품의 할인률 ***
	   public int getpanmaeprice() {
	
	      return (1-gameopt_discount)*gameopt_price;
	      // 판매가
	   }
	   
	   public int getpanmaeprice_2() {
			
		      return (1-gameopt_discount_2)*gameopt_price_2;
		      // 판매가
	   }
	   
	   public int getpanmaeprice_3() {
			
		      return (1-gameopt_discount_3)*gameopt_price_3;
		      // 판매가
	   }	

}
