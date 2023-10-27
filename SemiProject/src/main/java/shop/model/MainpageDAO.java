package shop.model;

import java.sql.SQLException;
import java.util.List;

import shop.domain.*;

public interface MainpageDAO {
	
	// 메인페이지에 보여지는 슬라이드 이미지를 모두 조회(select)하는 메소드
	List<MainsdVO> sdimageSelectAll() throws SQLException;

	List<VideoSetVO> videoimageSelectAll() throws SQLException;

}
