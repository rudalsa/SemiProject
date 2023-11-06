package shop.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import common.controller.AbstractController;
import game.model.*;
import shop.domain.GameVO;

public class LikeCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		  // AJAX 요청에서 전송한 데이터를 읽어온다.
	    String g_code_arr_json = request.getParameter("g_code_arr");
	    String[] values = g_code_arr_json.split(",");
	    
	    List<String> g_code_arr = new ArrayList<>();

        for (String value : values) {
            String str = value;
            g_code_arr.add(str);
        }

        // 리스트 출력
        for (String str : g_code_arr) {
            System.out.println(str);
        }
        	    
	    // 찜 목록을 이용하기 위해서는 로그인을 하면 안된다.
	    try {
	        if (g_code_arr_json != null) {


	            GameOptDAO gaoptdao = new GameOptDAO_imple();
	            
	            List<GameVO> likeList = gaoptdao.SelectAllLike(g_code_arr);

	            System.out.println("제발 ㅜㅜㅜ" + likeList);
	            request.setAttribute("likeList", likeList);
	            // System.out.println(likeList.get(1).getG_img_1());		
	            // super.setRedirect(false);
	            
	            super.setViewPage("/WEB-INF/shop/likecart.jsp");
	        	} 
	    } catch (SQLException e) {
	        	e.printStackTrace();
	    }   
    
	}
}
	
		

