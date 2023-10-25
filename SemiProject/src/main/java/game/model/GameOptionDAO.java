package game.model;

import java.sql.SQLException;

import game.domain.GameOptionVO;

public interface GameOptionDAO {

	GameOptionVO selectOneGameOption(String imgsetno) throws SQLException;
	
	//imgsetno이 테이블에 존재하는지 존재하지 않는지 알아오기
	boolean isExist_imgsetno(String imgsetno) throws SQLException;


}
