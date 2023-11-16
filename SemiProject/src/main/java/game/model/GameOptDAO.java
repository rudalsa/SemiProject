package game.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import gameopt.domain.OptVO;
import shop.domain.GameVO;

public interface GameOptDAO {
	
	// g_code 가 있는지 알아오는 메소드
	boolean isExist_g_code(String g_code) throws SQLException;
	
	// 1차적으로 게임 정보를 가져오는 메소드
	GameVO selectGameOpti(String g_code) throws SQLException;
	
	// 나머지 게임 옵션를 가져오는 메소드
	List<OptVO> SelectAllOpti(String g_code) throws SQLException;
	
	// 장바구니에 기존 제품이 없을경우 insert 하고, // 장바구니에 기존 제품이 있을경우 update 한다.
	int addCart(Map<String, String> paraMap) throws SQLException;
	
	// 찜 목록 불러오기
	List<GameVO> SelectAllLike(List<String> g_code_arr) throws SQLException;
	
	// 바로 주문하기 게임 select 하기
	GameVO selectOrder(String optno) throws SQLException;

	// 바로구매 총구매금액 select 하기
	Map<String, String> selectSumPricePoint(String oqty, String optno) throws SQLException;
	
	

	// 바로 주문하기 게임 select 하기
	GameVO selectOrder(String optno) throws SQLException;

	// 바로구매 총구매금액 select 하기
	Map<String, String> selectSumPricePoint(String oqty, String optno) throws SQLException;

}
