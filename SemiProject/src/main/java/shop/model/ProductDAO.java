package shop.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import shop.domain.*;
public interface ProductDAO {

	
	// 카테고리 목록을 조회해오기
	List<CategoryVO> selectCategoryList() throws SQLException;

	// SPEC 목록을 조회해오기
	List<SpecVO> selectSpecList() throws SQLException;

	// 게임코드 채번 해오기
	int getG_codeOfProduct() throws SQLException;

	// tbl_product 테이블에 제품정보 insert 하기
	int productInsert(GameVO gamevo) throws SQLException;

	// tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 하기
	int tbl_product_optinfo_insert(Map<String, String> paraMap) throws SQLException;
	
	// 로그인한 사용자의 장바구니 목록을 조회하기
	List<CartVO> selectProductCart(String user_id, String paymoney) throws SQLException;
	
	// 장바구니 테이블에서 특정제품을 장바구니에서 비우기
	int delCart(String cartno) throws SQLException;
	
	// 장바구니 테이블에서 특정제품 수량을 수정하기
	int updateCart(Map<String, String> paraMap) throws SQLException;
	
	// 주문 번호 (시퀀스 seq_tbl_order 값) 을 채번해오는 것
	int get_seq_tbl_order() throws SQLException;
	
	// 하나의 스펙에 몇개의 게임이있는지 알아오는 것 
	int totalSpecCount(String fk_s_code) throws SQLException;
	
	// 더보기 방식(페이징처리)으로 상품정보를 8개씩 잘라(start ~ end) 조회해오기 기준은 일단 스펙 나중에 바꾸자
	List<GameVO> selectBySpecName(Map<String, String> paraMap) throws SQLException;
	


	

}
