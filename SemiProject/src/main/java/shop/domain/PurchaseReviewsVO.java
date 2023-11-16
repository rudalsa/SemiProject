package shop.domain;

import member.domain.MemberVO;

public class PurchaseReviewsVO {

	private int review_seq; 
	private String fk_user_id;
	private String fk_g_code; 
	private String contents; 
	private String writeDate;
	
	private MemberVO mvo;
	private GameVO gvo;
	
	public PurchaseReviewsVO() { }

	public PurchaseReviewsVO(int review_seq, String fk_user_id, String fk_g_code, String contents, String writeDate,
			MemberVO mvo, GameVO gvo) {
		this.review_seq = review_seq;
		this.fk_user_id = fk_user_id;
		this.fk_g_code = fk_g_code;
		this.contents = contents;
		this.writeDate = writeDate;
		this.mvo = mvo;
		this.gvo = gvo;
	}

	public int getReview_seq() {
		return review_seq;
	}

	public void setReview_seq(int review_seq) {
		this.review_seq = review_seq;
	}

	public String getFk_user_id() {
		return fk_user_id;
	}

	public void setFk_user_id(String fk_user_id) {
		this.fk_user_id = fk_user_id;
	}

	public String getFk_g_code() {
		return fk_g_code;
	}

	public void setFk_g_code(String fk_g_code) {
		this.fk_g_code = fk_g_code;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	public MemberVO getMvo() {
		return mvo;
	}

	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}

	public GameVO getPvo() {
		return gvo;
	}

	public void setPvo(GameVO pvo) {
		this.gvo = pvo;
	}
		
}