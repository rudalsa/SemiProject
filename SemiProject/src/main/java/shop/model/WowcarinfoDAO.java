package shop.model;

import java.sql.SQLException;
import java.util.List;

import shop.domain.WowcarinfoVO;

public interface WowcarinfoDAO {
	
	// 캐러셀인포 페이지에 이미지와 동영상을 모두 조회하는 메소드
	List<WowcarinfoVO> wowCarinfoListSelectAll() throws SQLException;
	
	
	
	
}
