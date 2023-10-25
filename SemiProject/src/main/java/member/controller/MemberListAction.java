package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.domain.MemberVO;
import member.model.*;
import my.util.MyUtil;

public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null && "admin".equals(loginuser.getUser_id())) {
			
			MemberDAO mdao = new MemberDAO_imple();
			
			String searchType = request.getParameter("searchType");
			String searchWord = request.getParameter("searchWord");
			String sizePerPage = request.getParameter("sizePerPage");
			String currentShowPageNo = request.getParameter("currentShowPageNo");

			System.out.println("확인용 : searchType : " + searchType);
			System.out.println("확인용 : searchWord : " + searchWord);
			System.out.println("확인용 : sizePerPage : " + sizePerPage);
			System.out.println("확인용 : currentShowPageNo : " + currentShowPageNo);
			
			////////////////////////
				if(searchType==null || (!"user_name".equals(searchType) && !"user_id".equals(searchType) && !"user_email".equals(searchType))) {
					searchType="";
				}
				if(searchWord==null || (searchWord!=null && searchWord.trim().isEmpty())) {
					searchWord="";
				}
				if(sizePerPage == null ||
				           (!"10".equals(sizePerPage) &&
				            !"5".equals(sizePerPage) &&
				            !"3".equals(sizePerPage) ) ) { // null 이라면 기본 디폴트가 10
				            sizePerPage = "10";
				         }
				if(currentShowPageNo==null) {
					currentShowPageNo="1";
				}
				
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("searchType", searchType);
			paraMap.put("searchWord", searchWord);
			paraMap.put("sizePerPage", sizePerPage); // 한페이지당
			paraMap.put("currentShowPageNo", currentShowPageNo);
			
//			System.out.println("확인용 : searchType : " + searchType);
//			System.out.println("확인용 : searchWord : " + searchWord);


			// *** 페이징 처리를 안한 모든 회원 또는 검색한 모든 회원 목록 보여주기 *** //
			//List<MemberVO> memberList = mdao.select_Member_nopaging(paraMap);
			
			// *** 페이징 처리를 한 모든 회원 또는 검색한 모든 회원 목록 보여주기 *** //
			// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 회원에 대한 총 페이지수 알아오기
			int totalPage = mdao.getTotalPage(paraMap);
			System.out.println("확인용 : totalPage : " + totalPage);
			
			// GET 방식임을 이용하여 currentShowPageNo에 totalPage 보다 큰 값을넣어서 장난친 경우
			// GET 방식임을 이용하여 currentShowPageNo에 totalPage 보다 작은 0 또는 음수 값을넣어서 장난친 경우
			// GET 방식임을 이용하여 currentShowPageNo에 totalPage 문자열 값을넣어서 장난친 경우
			// 무조건 1페이지로 이동하게만든다.
			try {
			if(Integer.parseInt(currentShowPageNo) > totalPage || 
			   Integer.parseInt(currentShowPageNo) <= 0 ) {
				currentShowPageNo="1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
				}
			}catch (NumberFormatException e) {
				currentShowPageNo="1";
				paraMap.put("currentShowPageNo", currentShowPageNo);
			}
			
			/*
            1개 블럭당 10개씩 잘라서 페이지 만든다.
            1개 페이지당 3개행 또는 5개행 또는  10개행을 보여주는데
                만약에 1개 페이지당 5개행을 보여준다라면 
                총 몇개 블럭이 나와야 할까? 
                총 회원수가 207명 이고, 1개 페이지당 보여줄 회원수가 5 이라면
            207/5 = 41.4 ==> 42(totalPage)        
                
            1블럭               1 2 3 4 5 6 7 8 9 10 [다음]
            2블럭   [이전] 11 12 13 14 15 16 17 18 19 20 [다음]
            3블럭   [이전] 21 22 23 24 25 26 27 28 29 30 [다음]
            4블럭   [이전] 31 32 33 34 35 36 37 38 39 40 [다음]
            5블럭   [이전] 41 42 
         */
        
        // ==== !!! pageNo 구하는 공식 !!! ==== // 
     /*
         1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은  1 이다.
         11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.   
         21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
         
          currentShowPageNo        pageNo  ==> ( (currentShowPageNo - 1)/blockSize ) * blockSize + 1 
          // 자바에서는 나누기를 했을 때, 몫이 구해진다.
         ---------------------------------------------------------------------------------------------
                1                   1 = ( (1 - 1)/10 ) * 10 + 1 
                2                   1 = ( (2 - 1)/10 ) * 10 + 1 
                3                   1 = ( (3 - 1)/10 ) * 10 + 1 
                4                   1 = ( (4 - 1)/10 ) * 10 + 1  
                5                   1 = ( (5 - 1)/10 ) * 10 + 1 
                6                   1 = ( (6 - 1)/10 ) * 10 + 1 
                7                   1 = ( (7 - 1)/10 ) * 10 + 1 
                8                   1 = ( (8 - 1)/10 ) * 10 + 1 
                9                   1 = ( (9 - 1)/10 ) * 10 + 1 
               10                   1 = ( (10 - 1)/10 ) * 10 + 1 
                
               11                  11 = ( (11 - 1)/10 ) * 10 + 1 
               12                  11 = ( (12 - 1)/10 ) * 10 + 1
               13                  11 = ( (13 - 1)/10 ) * 10 + 1
               14                  11 = ( (14 - 1)/10 ) * 10 + 1
               15                  11 = ( (15 - 1)/10 ) * 10 + 1
               16                  11 = ( (16 - 1)/10 ) * 10 + 1
               17                  11 = ( (17 - 1)/10 ) * 10 + 1
               18                  11 = ( (18 - 1)/10 ) * 10 + 1 
               19                  11 = ( (19 - 1)/10 ) * 10 + 1
               20                  11 = ( (20 - 1)/10 ) * 10 + 1
                
               21                  21 = ( (21 - 1)/10 ) * 10 + 1 
               22                  21 = ( (22 - 1)/10 ) * 10 + 1
               23                  21 = ( (23 - 1)/10 ) * 10 + 1
               24                  21 = ( (24 - 1)/10 ) * 10 + 1
               25                  21 = ( (25 - 1)/10 ) * 10 + 1
               26                  21 = ( (26 - 1)/10 ) * 10 + 1
               27                  21 = ( (27 - 1)/10 ) * 10 + 1
               28                  21 = ( (28 - 1)/10 ) * 10 + 1 
               29                  21 = ( (29 - 1)/10 ) * 10 + 1
               30                  21 = ( (30 - 1)/10 ) * 10 + 1                    

      */
			String pageBar = "";
			int blockSize = 10;
			// blockSize는 블럭당 보여지는 페이지 번의 개수
			int loop=1;
			// loop는 1부터 증가하여 1개 블럭을 이루는 페이지 번호의 개수(지금은 10번 반복)
			
			// ==== !!! pageNo 구하는 공식 !!! ==== //
			int pageNo = ((Integer.parseInt(currentShowPageNo) - 1) / blockSize ) * blockSize + 1;
			// pageNo는 페이지바에서 보여지는 첫번째 번호이다.
			// pageNo => 11

			// *** [맨처음][이전] 만들기 *** //
	         
        	 pageBar += "<li class='page-item'><a class='page-link' href='memberList.bz?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo=1'>[맨처음]</a></li>";
	         if(pageNo != 1) {
	            pageBar += "<li class='page-item'><a class='page-link' href='memberList.bz?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
	         }
	         while( !(loop > blockSize || pageNo > totalPage) ) {
	            
	            if(pageNo == Integer.parseInt(currentShowPageNo) ) {
	               pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>";
	            }
	            else {
	               pageBar += "<li class='page-item'><a class='page-link' href='memberList.bz?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
	            }
	            
	            loop++;   // 1 2 3 4 5 6 7 8 9 10
	            
	            pageNo++; //  1  2  3  4  5  6  7  8  9 10   
	                    // 11 12 13 14 15 16 17 18 19 20
	                    // 21 22 23 24 25 26 27 28 29 30
	                    // 31 32 33 34 35 36 37 38 39 40
	                    // 41 42
	         } // end of while() ----------------------------
	         
	          // *** [다음][마지막] 만들기 *** //
	         // pageNo ==> 11
	         if(pageNo <= totalPage) {
	            pageBar += "<li class='page-item'><a class='page-link' href='memberList.bz?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
	         }
	         
	         pageBar += "<li class='page-item'><a class='page-link' href='memberList.bz?searchType="+searchType+"&searchWord="+searchWord+"&sizePerPage="+sizePerPage+"&currentShowPageNo="+totalPage+"'>[마지막]</a></li>";
	         
	        // *** 현재 페이지를 돌아갈 페이지 (goBackURL) 로 주소 지정하기 *** //
	        String currentURL = MyUtil.getCurrentURL(request);
	        // 회원 조회를 했을시 현재 그 페이지로 그대로 되돌아가길 위한 용도로 쓰임.
	        
	        System.out.println("currentURL : "+currentURL);
			// currentURL : http://localhost:9090/MyMVC/member/memberList.up
	        // currentURL : /member/memberList.up?searchType=name&searchWord=%EC%84%AD&sizePerPage=5&currentShowPageNo=7


			List<MemberVO> memberList = mdao.select_Member_paging(paraMap);
			
			request.setAttribute("memberList", memberList);
			request.setAttribute("searchType", searchType);
			request.setAttribute("searchWord", searchWord);
			request.setAttribute("sizePerPage", sizePerPage);
			request.setAttribute("pageBar", pageBar);
			request.setAttribute("currentURL", currentURL);

			super.setViewPage("/WEB-INF/member/admin/memberList.jsp");

		}
		
		else {
			// 로그인을 안했으면 
			String message = "관리자만 접근이 가능합니다!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
