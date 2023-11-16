package gameopt.controller;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import game.model.GameOptDAO;
import game.model.GameOptDAO_imple;
import gameopt.domain.OptVO;
import shop.domain.GameVO;

public class GameoptAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String g_code = request.getParameter("g_code");
		
		try {
			  
		    int n_g_code = Integer.parseInt(g_code);
		  
		    if(n_g_code<300) {
				
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/index.bz");
				return;
				
		    }
		  
		    GameOptDAO gameoptidao = new GameOptDAO_imple();
		  
			if(!gameoptidao.isExist_g_code(g_code)) {
				
				// 입력받은 g_code 이 DB에 존재하지 않는 경우는 사용자가 장난친 경우다.
				super.setRedirect(true);
				super.setViewPage(request.getContextPath()+"/index.bz");
			}
			
			else {
				 
				GameVO gameVO = gameoptidao.selectGameOpti(g_code);
				request.setAttribute("gameVO", gameVO);
				
				List<OptVO> OptiList = gameoptidao.SelectAllOpti(g_code);
				
			//	System.out.println("같으면 안된다."+ OptiList);
				
				request.setAttribute("OptiList", OptiList);
				
				System.out.println(OptiList);
				
				super.setRedirect(false);
	    	  	super.setViewPage("/WEB-INF/shop/cargameopti.jsp");
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

