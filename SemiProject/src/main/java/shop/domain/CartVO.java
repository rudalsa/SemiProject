package shop.domain;

import gameopt.domain.OptVO;

public class CartVO {
	
	// (오라클로 말하면 제품테이블의 자식테이블)
	
		private int cartno;         // 장바구니 번호             
		private String fk_userid;   // 사용자ID            
		private String fk_g_code;        //  제품번호                
		private int oqty;           //  주문량
		private String registerday; // 장바구니 입력날짜
		private int fk_optno;
		
		public int getFk_optno() {
			return fk_optno;
		}

		public void setFk_optno(int fk_optno) {
			this.fk_optno = fk_optno;
		}

		private GameVO gavo;     // 제품정보객체 (오라클로 말하면 부모테이블)
		private OptVO  opvo;	// 제품욥션객체 (오라클로 말하면 부모테이블)
		

		public CartVO() {}
		
		public CartVO(int cartno, String fk_userid, String fk_g_code, int oqty, String registerday) {
			this.cartno = cartno;
			this.fk_userid = fk_userid;
			this.fk_g_code = fk_g_code;
			this.oqty = oqty;
			this.registerday = registerday;
		}

		public int getCartno() {
			return cartno;
		}
		
		public void setCartno(int cartno) {
			this.cartno = cartno;
		}
		
		public String getFk_userid() {
			return fk_userid;
		}
		
		public void setFk_userid(String fk_userid) {
			this.fk_userid = fk_userid;
		}
		
		public String getFk_g_code() {
			return fk_g_code;
		}

		public void setFk_g_code(String fk_g_code) {
			this.fk_g_code = fk_g_code;
		}

		public int getOqty() {
			return oqty;
		}
		
		public void setOqty(int oqty) {
			this.oqty = oqty;
		}
		
		public String getRegisterday() {
			return registerday;
		}
		
		public void setRegisterday(String registerday) {
			this.registerday = registerday;
		}
		

		
		public GameVO getGavo() {
			return gavo;
		}

		public void setGavo(GameVO gavo) {
			this.gavo = gavo;
		}

		public OptVO getOpvo() {
			return opvo;
		}

		public void setOpvo(OptVO opvo) {
			this.opvo = opvo;
		}


}
