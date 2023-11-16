package shop.model;

import java.sql.SQLException;
import java.util.List;

import shop.domain.GameCarinfoVO;

public interface WowcarinfoDAO {
	
	// 워크래프트 캐러셀인포 페이지에 이미지와 동영상을 모두 조회하는 메소드
	List<GameCarinfoVO> wowCarinfoListSelectAll(String g_code) throws SQLException;
	
	
	
	
}