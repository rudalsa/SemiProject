package buy.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import common.controller.AbstractController;


public class EditorderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	    String method = request.getMethod(); // "GET" 또는 "POST"

	    if ("POST".equalsIgnoreCase(method)) {
	        // POST 요청 처리 
	    	super.setRedirect(false);
		    super.setViewPage("/WEB-INF/shop/orderinfo.jsp");

	       
	    } else {
	        
	    	// get 방식
	    	super.setRedirect(true);
	    	super.setViewPage(request.getContextPath()+"/error.up");
	    	
	    }
	
	}
	

}
    
