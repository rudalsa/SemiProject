package shop.model;

import java.sql.SQLException;
import java.util.List;

import shop.domain.*;


public interface MainShopDAO  {
	
	// tbl_featured_game 테이블을 모두 조회(select)하는 메소드 
	List<GameVO> ShopListSelectAll() throws SQLException;

	
}

