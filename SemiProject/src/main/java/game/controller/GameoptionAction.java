package game.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import game.domain.*;
import game.model.*;


public class GameoptionAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	String imgsetno = request.getParameter("imgsetno");
	
	try {
	  
	    int n_imgsetno = Integer.parseInt(imgsetno);
	  
	    if(n_imgsetno<1) {
			
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/index.bz");
			return;
			
	    }
	  
	    GameOptionDAO gameoptdao = new GameOptionDAO_imple();
	  
		if(!gameoptdao.isExist_imgsetno(imgsetno)) {
			
			// 입력받은 cnum 이 DB에 존재하지 않는 경우는 사용자가 장난친 경우다.
			super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/index.bz");
		}
		
		else {
			 
			GameOptionVO gameOptionVO = gameoptdao.selectOneGameOption(imgsetno);
			request.setAttribute("gameOptionVO", gameOptionVO);
			super.setRedirect(false);
    	  	super.setViewPage("/WEB-INF/shop/gameoption.jsp");
		}
			 
	    }catch(SQLException e) {
	         e.printStackTrace();
	         super.setRedirect(true);
	         super.setViewPage(request.getContextPath()+"/error.bz");
	  
	    }catch(NumberFormatException e) {
	    	e.printStackTrace();
		  	super.setRedirect(true);
			super.setViewPage(request.getContextPath()+"/index.bz");
			return;
	    }
	      
	      
	}
	
}
	
	    	  
	    	  
	    	  
	  

	    	
	         
