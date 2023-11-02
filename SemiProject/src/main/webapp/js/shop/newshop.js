
$(document).ready(function(){
	
/*	$("span#totalCount").hide();
	$("span#countSum").hide();*/
	
	let start = 1;
	let len = 8;
	// 상품 "스크롤"을 할 때 보여줄 상품의 개수(단위)크기
	
	// HIT상품 게시물을 더보기 위하여 "스크롤" 이벤트에 대한 초기값 호출하기 
    // 즉, 맨처음에는 "스크롤"을 하지 않더라도 "스크롤" 한 것 처럼 8개의 HIT상품을 게시해주어야 한다는 말이다. 
    display(start);
    
    // === 스크롤 이벤트 발생시키기 시작 === //
    $(window).scroll(function(){
     
        if( $(window).scrollTop() + 1 >= $(document).height() - $(window).height() ) {
			
			alert("ZD");
			
			if( $("span#totalCount").text() != $("span#countSum").text() ) { // 값이 같지 않을때만 새로운 창을 보여준다.
				start += len;
				display(start);	
			}
			
		}
		// 아래는 만약에 위의 값이 제대로 안나오는 경우 이벤트가 발생되는 숫자를 만들기 위해서 스크롤탑의 위치값에 +1 을 더해서 보정해준 것이다. 
        // console.log( "$(window).scrollTop() + 1  => " + ( $(window).scrollTop() + 1  ) );
        // console.log( "$(document).height() - $(window).height() => " + ( $(document).height() - $(window).height() ) );
        
        if($(window).scrollTop() == 0) {
			// 다시 처음부터 시작하도록 한다.
			$("div#display").empty();
			$("span#end").empty();
			$("span#countSum").text("0");
			
			start = 1;
			display(start);
			
		}
		
				
	}); // end of $(window).scroll(function(){}) ----------------------
    // === 스크롤 이벤트 발생시키기 끝 === //
	
}); // end of$(document).ready(function(){}); ----------------------- 

// Function Declaration


let len = 8; 
// HIT 상품 "더보기..." 버튼을 클릭할때 보여줄 상품의 개수(단위)크기 

// display 할 HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
function display(start) { // start가  1 이라면    1~8 까지 상품 8개를 보여준다.
                          	 // start가  9 이라면   9~16 까지 상품 8개를 보여준다.
                          	 // start가 17 이라면  17~24 까지 상품 8개를 보여준다.
                          	 // start가 25 이라면  25~32 까지 상품 8개를 보여준다.
                          	 // start가 33 이라면  33~36 까지 상품 4개를 보여준다.(마지막 상품)  
	$.ajax({
		url:"shopDisplayJSON.bz",
		type:"get", // 생략가능
		data:{"s_name":"pop",
			  "start":start, // "1"   "9"   "17"   "25"   "33"
			  "len":len}, //  8     8      8      8      8
		
		dataType:"json",
		success:function(json){
		
		/*
			console.log(json);
			console.log(typeof json); // object
			
			const str_json = JSON.stringify(json) // JSON 객체를 string 타입으로 변경시켜주는 것.
			console.log(typeof str_json); // string
			console.log(str_json);
			
			
			const obj_json = JSON.parse(str_json)// JSON 모양으로 되어진 string 을 실제 JSON 객체로 변경시켜주는 것.
			console.log(typeof obj_json); // object
			console.log(obj_json); 
				 
				어째 어째 확인함 
				 
				또는 
			
				json ==> []
		*/
			
			let v_html = "";
			
			if(start == "1" && json.length == 0) {
				// 처음부터 데이터가 존재하지 않는 경우
				/* !!!! 주의 !!!!
				   if(start == "1" && json == null) 이 아니다!!!!!!
				   if(start == "1" && json.length == 0) 로 해야함 !!
				*/
				v_html += `현재 상품 준비중 입니다.`;
				$("div#display").html(v_html);
			}
			else if(json.length > 0){
				// 데이터가 존재하는 경우
			/*
				// 자바스크립트 사용하는 경우
				json.forEach(function(item, index, array) {
						
				});
			*/
				// JQuery 를 사용하는 경우
			    $.each(json, function(index, item) {
	               v_html += `<div class='col-md-6 col-lg-3'>
	                             <div class="card mb-3"> 
	                                <img src='/SemiProject/img/tbl_game_product_image/${item.g_img_1}' class='card-img-top' style='width: 100%;' />
	                                <div class='card-body text-left' style='padding: 0; font-size: 11pt;'>
	                                   <ul class='list-unstyled mt-3 pl-3'>
	                                      <li><label class='prodInfo'>제품명</label>${item.g_name}</li>
	                                      <li><label class='prodInfo'>정가</label><span style='text-decoration: line-through; color:red;'>${item.g_price.toLocaleString('en')} 원</span></li>
	                                      <li><label class='prodInfo'>판매가</label><span style='font-weight: bold; color:blue;'>${item.g_sale_price.toLocaleString('en')} 원</li>
	                                      <li><label class='prodInfo'>할인율</label>[${item.discountPercent}%]할인</li>
	                                      <li><label class='prodInfo'>포인트</label>${item.g_coin.toLocaleString('en')}<span style='font-weight: bold; color:orange;'>포인트</span></li>
	                                      <li class='text-center'><a href='/MyMVC/shop/prodView.up?pnum=${item.pnum}' class='btn btn-sm btn-outline-dark stretched-link' role='button'>자세히보기</a></li>
	                                      ${''/* 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함).*/}
	                                   </ul>
	                                </div>
	                            </div>
	                        </div>`;
            }); // end of $.each(json, function(index, item) {});
				
				// HIT 상품 결과 출력하기
				$("div#display").append(v_html);
				
				// span#countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
				$("span#countSum").text( Number($("span#countSum").text()) + json.length );
				
				// 스크롤을 끝까지 내렸을때 countHIT 값과 totalHITCount 값이 일치하는 경우
				if($("span#countSum").text() == $("span#totalCount").text()) {
				   
				   // alert("끝");
				   $("span#end").html("더이상 조회할 상품이 없습니다.")
				}
					
			} // end of else if(json.length > 0){} ------------------------
			
		},
		error: function(request, status, error){
            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
        }
        
	});
	
	
	
} // end of function displayHIT(start) {}); ------------------------------------


function goTop() {
	$(window).scrollTop(1);
}

