<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<script type="text/javascript">

	$(document).ready(function(){
		

		  // ========== 주소록 등록 유효성 검사 시작 ========== //
	      $("span.error").hide();
	      
	      // ========== 이름 검사 ========== // 
	      $("input#name").blur(function(){
	         
	         var name = $(this).val().trim();
	         if(name == "") {
	            // 입력하지 않거나 공백만 입력했을 경우
	            $("table#tblAddr :input").prop("disabled",true);
	            $(this).prop("disabled",false);
	            $(this).parent().find(".error").show();
	            $(this).focus();
	         }
	         else {
	            // 공백이 아닌 글자를 입력했을 경우
	            $("table#tblAddr :input").prop("disabled",false);
	            $(this).parent().find(".error").hide();
	         }
	         
	      }); // end of $("input#name").blur(function(){}--------------------------
	      
	   	  // ========== 이메일 검사 ========== // 
	      $("input#email").blur(function(){
	           $("span#emailCheckResult").html("");
	            var regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i);
	         
	            var bool = regExp.test($(this).val());
	            
	            if(!bool) {
	               // 이메일이 정규표현식에 위배된 경우
	               $("table#tblAddr :input").prop("disabled",true);
	               $(this).prop("disabled",false);
	            
	               $(this).parent().find(".error").show();
	               $(this).focus();
	            }
	            else {
	               // 이메일이 정규표현식에 맞는 경우
	               $("table#tblAddr :input").prop("disabled",false);
	               $(this).parent().find(".error").hide();
	            }
	            
	         }); // end of $("input#email").blur(function(){}------------------------
	      
	      
	      // ========== 핸드폰번호 검사 ========== //  		 
	      $("input#hp2").blur(function(){
	         
	            var regExp = /^[1-9][0-9]{3}$/i; 
	            // 첫번째 숫자는 0을 제외하고 나머지 3개는 0을 포함한 숫자만 오도록 검사해주는 정규표현식 객체 생성  
	         
	            var bool = regExp.test($(this).val());
	            
	            if(!bool) {
	               // 국번이 정규표현식에 위배된 경우
	               $("table#tblAdder :input").prop("disabled",true);
	               $(this).prop("disabled",false);
	            
	               $(this).parent().find(".error").show();
	               $(this).focus();
	            }
	            else {
	               // 국번이 정규표현식에 맞는 경우
	               $("table#tblAdder :input").prop("disabled",false);
	               $(this).parent().find(".error").hide();
	            }
	            
	         }); // end of $("input#hp2").blur(function(){}-------------------------------------- 
	         
	         
	         $("input#hp3").blur(function(){
	            
	            var regExp = /^\d{4}$/i; 
	            // 숫자 4개만 오도록 검사해주는 정규표현식 객체 생성  
	         
	            var bool = regExp.test($(this).val());
	            
	            if(!bool) {
	               // 마지막 전화번호 4자리가 정규표현식에 위배된 경우
	               $("table#tblAddr :input").prop("disabled",true);
	               $(this).prop("disabled",false);
	            
	               $(this).parent().find(".error").show();
	               $(this).focus();
	            }
	            else {
	               // 마지막 전화번호 4자리가 정규표현식에 맞는 경우
	               $("table#tblAddr :input").prop("disabled",false);
	               $(this).parent().find(".error").hide();
	            }
	            
	         }); // end of $("input#hp3").blur(function(){}-------------------------------------- 
	      
	         
	          // ========== 우편번호 검사 ========== //		 
		      $("button#zipcodeSearch").click(function(){
		         new daum.Postcode({
		               oncomplete: function(data) {
		                   var addr = ''; // 주소 변수
		                   var extraAddr = ''; // 참고항목 변수
		                   if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                       addr = data.roadAddress;
		                   } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                       addr = data.jibunAddress;
		                   }
		                   // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합
		                   if(data.userSelectedType === 'R'){
		                       // 법정동명이 있을 경우 추가 (법정리는 제외)
		                       if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                           extraAddr += data.bname;
		                       }
		                       // 건물명이 있고, 공동주택일 경우 추가
		                       if(data.buildingName !== '' && data.apartment === 'Y'){
		                           extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                       }
		                       if(extraAddr !== ''){
		                           extraAddr = ' (' + extraAddr + ')';
		                       }
		                       document.getElementById("extraAddress").value = extraAddr;
		                   
		                   } else {
		                       document.getElementById("extraAddress").value = '';
		                   }
		                   document.getElementById('postcode').value = data.zonecode;
		                   document.getElementById("address").value = addr;
		                   document.getElementById("detailaddress").focus();
		               }
		           }).open();
		           
		        }); // end of $("button#zipcodeSearch").click(function(){}--------------------------------
		
		     // ========== 주소록 등록 유효성 검사 끝 ========== //
		

	}); // end of $(document).ready(function(){})---------------------------------------

	// 사원번호로 검색	
	function searchMbr(){
		
		var mbr_seq = $("input#mbrSeq").val();
		
		location.href="<%=ctxPath%>/searchMbr.opis?mbr_seq="+mbr_seq;
		
	}// end of function searchMbr()-----------------------------------------------------
	
	
    // 주소록 등록
    function goRegister(){
	    var frm = document.addFrm;
        frm.method = "POST";
        frm.action = "<%=ctxPath%>/addr_addEnd.opis";
        frm.submit();	   
    }// end of function goRegister(){}----------------------------------------------------------
   
</script>	
	
 
<!-- Modal Header -->
<div class="modal-header">
  <h4 class="modal-title">주소록 등록</h4>
  <button type="button" class="close" data-dismiss="modal">&times;</button>
</div>
 
<!-- Modal body -->
<div class="modal-body" align="center">
  <form name="addFrm" id="addFrm" enctype="multipart/form-data" > 

<table id="table tblAddr">
   <tr>
		<th>사원번호</th>
   		<td>
   			<input type="text" name="mbr_seq" id="mbrSeq" placeholder="사원번호" class="short"/>
   			&nbsp;&nbsp;<button type="button" id="searchMbr" onclick="searchMbr()">검색</button>
   		</td>		
   </tr>      
   <tr>
    	<th>이름</th>
       <td>
           <input type="text" name="mbr_name" placeholder="이름" class="short"/>
           <span class="error">이름은 필수입력 사항입니다.</span>
       </td>
    </tr>		
    <tr>
    	<th>전화번호</th>
       <td>
        <input type="text" id="hp1" name="hp1" size="6" maxlength="3" value="010" readonly />&nbsp;&nbsp;
        <input type="text" id="hp2" name="hp2" size="6" maxlength="4" />&nbsp;&nbsp;
        <input type="text" id="hp3" name="hp3" size="6" maxlength="4" />
        <span class="error">휴대폰 형식이 아닙니다.</span>  
       </td>
    </tr>	
    <tr>
    	<th>이메일</th>
       <td>
           <input type="text" name="mbr_email" id="email" class="short requiredInfo" placeholder="abcd@opis.com" />
           <span id="emailCheckResult"></span>
           <span class="error">이메일 형식에 맞지 않습니다.</span>
       </td>
    </tr>	         
    <tr>
    	<th>생일</th>
       <td>
           <input type="date" name="mbr_birthday" placeholder="yyyymmdd" class="short"/>       
       </td>
    </tr>	
    <tr>
    	<th>소속</th>
       <td>
           <input type="text" name="dept_name" placeholder="부서" class="short"/> 
           <input type="text" name="position_name" placeholder="직책" class="short"/>      
       </td>
    </tr>
    <tr>
    	<td style="width: 20%; font-weight: bold;">우편번호</td>
    	<td style="width: 80%; text-align: left;">
       <input type="text" id="postcode" name="postcode" size="6" maxlength="5" />&nbsp;&nbsp;
       <%-- 우편번호 찾기 --%>
       <button type="button" id="zipcodeSearch" style="vertical-align: middle;"> 우편번호 검색 </button>
       <span class="error">우편번호 형식이 아닙니다.</span>
    </tr>
    <tr>
    <td style="width: 20%; font-weight: bold;">주소</td>
    <td style="width: 80%; text-align: left;">
        <input type="text" id="address" name="address" size="40" placeholder="주소" /><br><br>
        <input type="text" id="detailaddress" name="detailaddress" size="36" placeholder="상세주소" />&nbsp;<input type="text" id="extraAddress" name="extraAddress" size="35" placeholder="참고항목" /> 
        <span class="error">주소를 입력하세요</span>
     </td>
  	</tr>
     <tr>
     	<th>메모</th>
        <td>
			<textarea rows="4" cols="100" style="width: 80%; height: 200px;" name="addrmemo" id="content" placeholder="메모를 입력해주세요"></textarea>                   
		</td>
      </tr>	 
   </table>
   
      <!-- Modal footer -->
    <div class="modal-footer">
      <button type="button" id="btnRegister" onclick="goRegister()">등록</button>
      <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
    </div>
</form>

</div>