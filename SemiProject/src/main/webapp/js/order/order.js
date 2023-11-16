

$(document).ready(function(){
   
   
   $("p.error").hide();
   
   
$("input#order_name").blur( (e) => {
      
      
      const regExp_name = /^[가-힣]{2,6}$/;
        
        const bool_name = regExp_name.test($(e.target).val());
       // frm.passwd.value 값이 regExp_passwd 패턴에 맞으면 true,
       // frm.passwd.value 값이 regExp_passwd 패턴에 틀리면 false
       
       if(!bool_name){
         // 입력하지 않거나 공백만 입력했을 경우 
         /*   
            >>>> .prop() 와 .attr() 의 차이 <<<<            
                  .prop() ==> form 태그내에 사용되어지는 엘리먼트의 disabled, selected, checked 의 속성값 확인 또는 변경하는 경우에 사용함. 
                  .attr() ==> 그 나머지 엘리먼트의 속성값 확인 또는 변경하는 경우에 사용함.
         */ 
         $("form#memberRegisterFrm :input").prop("disabled", true);  
         $(e.target).prop("disabled", false); 
         
         
              
         $(e.target).val("").focus(); 
         $(e.target).parent().parent().find("p.error").show();
         
      }
      else {
         // 공백이 아닌 글자를 입력했을 경우
         $("form#memberRegisterFrm :input").prop("disabled", false);
         
         $(e.target).parent().parent().find("p.error").hide();
          
         
      }
      
   });// 아이디가 name 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
   
   

      // === "우편번호찾기"를 클릭했을 때 이벤트 처리하기 === //
   $(".zipcodeSearch").click(function(){
      
      b_zipcodeSearch_click = true;
      // "우편번호찾기" 를 클릭했는지 클릭을 안했는지 여부를 알아오기 위한 용도  
      
      // 주소를 쓰기가능 으로 만들기
      $("input#order_address").removeAttr("readonly");
        
        // 참고항목을 쓰기가능 으로 만들기
        $("input#order_extraaddress").removeAttr("readonly");
        
        // 주소를 활성화 시키기
   //   $("input#address").removeAttr("disabled");
        
        // 참고항목을 활성화 시키기
    //  $("input#extraAddress").removeAttr("disabled");
      
      new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                let addr = ''; // 주소 변수
                let extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("order_extraaddress").value = extraAddr;
                
                } else {
                    document.getElementById("order_extraaddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('order_zipcode').value = data.zonecode;
                document.getElementById("order_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("order_detailaddress").focus();
            }
        }).open();
        
        // 주소를 읽기전용(readonly) 로 만들기
        $("input#order_address").attr("readonly", true);
        
        // 참고항목을 읽기전용(readonly) 로 만들기
        $("input#order_extraddress").attr("readonly", true);
        
        // 주소를 비활성화 로 만들기
    //  $("input#address").attr("disabled", true);
        
        // 참고항목을 비활성화 로 만들기
    //  $("input#extraAddress").attr("disabled", true);
        
   });// end of $("img#zipcodeSearch").click()------------
           
           
      $("input[id='order_zipcode']").bind("change", function(){
         $("input[id='order_detail_address']").val("");
      });
      
      
      $("input#order_phone").blur( (e) => {
         
         //   const regExp_hp3 = /^[0-9]{4}$/;  
         //  또는
         //   const regExp_hp3 = /^\d{4}$/;
             const regExp_user_phone = new RegExp(/^\d{11}$/);  
             // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성 
             
             const bool = regExp_user_phone.test($(e.target).val());      
            
            if(!bool) {
               // 마지막 전화번호 4자리가 정규표현식에 위배된 경우 
               
               $("form#memberRegisterFrm :input").prop("disabled", true);  
               $(e.target).prop("disabled", false); 
               
            //   $(e.target).next().show();
            //  또는
                $(e.target).parent().parent().find("p.error").show();
                
               $(e.target).val("").focus();
            }
            else {
               // 마지막 전화번호 4자리가 정규표현식에 맞는 경우 
               $("form#memberRegisterFrm :input").prop("disabled", false);
               
               //   $(e.target).next().hide();
                //  또는
                $(e.target).parent().parent().find("p.error").hide();
                
                
                
            }
            
         });// 아이디가 hp3 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
         
         
         
         $("input#order_email").blur( (e) => {
            
            //   const regExp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;  
            //  또는
                const regExp_email = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);  
                // 이메일 정규표현식 객체 생성 
                
                const bool = regExp_email.test($(e.target).val());   
               
               if(!bool) {
                  // 이메일이 정규표현식에 위배된 경우 
                  
                  $("form#memberRegisterFrm :input").prop("disabled", true);  
                  $(e.target).prop("disabled", false); 
                  
               //   $(e.target).next().show();
               //  또는
                   $(e.target).parent().parent().find("p.error").show();
                       
                  $(e.target).val("").focus(); 
               }
               else {
                  // 이메일이 정규표현식에 맞는 경우 
                  $("form#memberRegisterFrm :input").prop("disabled", false);
                  
                  //   $(e.target).next().hide();
                   //  또는
                   $(e.target).parent().parent().find("p.error").hide();
                   
               }
               
            });// 아이디가 email 인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
      
      
      
      
   
});


function inputClose(inputTag) {
    var tags = inputTag.split(','); // 입력 필드 ID 목록을 쉼표로 구분하여 배열로 변환
    for (var i = 0; i < tags.length; i++) {
        $("input#" + tags[i]).val("");
    }
}

function goCard() {

const requiredInfo_list = document.querySelectorAll("input.requiredInfo"); 
    for(let i=0; i<requiredInfo_list.length; i++){
      const val = requiredInfo_list[i].value.trim();
      if(val == "") {
         alert("주문자 정보/ 배송지를 전부 입력하세요");
          b_requiredInfo = true;
          break; 
      }
   }// end of for-----------------------------
   
   
   // *** 우편번호 및 주소에 값을 입력했는지 검사하기 시작 *** //
   const order_zipcode = $("input#order_zipcode").val().trim();
   const order_address = $("input#order_address").val().trim();
   const order_detail_address = $("input#order_detailaddress").val().trim();
   
   
   
   if(order_zipcode == "" || order_address == "" || order_detail_address == "") {
      alert("우편번호 및 주소를 입력하셔야 합니다.");
      return; // goRegister() 함수를 종료한다.
   }
   // *** 우편번호 및 주소에 값을 입력했는지 검사하기 끝 *** //
   
   
   
}