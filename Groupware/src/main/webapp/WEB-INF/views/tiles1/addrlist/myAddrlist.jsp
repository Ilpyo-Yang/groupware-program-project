<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<% String addrgroup_seq = request.getParameter("addrgroup_seq"); %>

  <jsp:include page="./addr_sidebar.jsp" />

	<script type="text/javascript">

	$(document).ready(function(){

		$("input#searchWord").bind("keydown", function(event){
			if(event.keyCode == 13){// 엔터를 했을 경우
				goSearch();
			}
		});
		
		// 검색리스트 숨기기
		$("div#displayList").hide();
		
		$("input#searchWord").keyup(function(){
			
			var wordLength = $(this).val().trim().length;
			
			if(wordLength == 0){
				$("div#displayList").hide();
			}
			else{
				$.ajax({
					url:"<%= ctxPath%>/mywordSearchShow.opis",
					type:"get",
					data:{"searchType":$("select#searchType").val()
						 ,"searchWord":$("input#searchWord").val()
						 ,"addrgroup_seq":<%=addrgroup_seq%>},
					dataType:"json",
					success:function(json){
						   if(json.length > 0){
							   // 검색된 데이터가 있는 경우
							   var html = "";
							   
							   $.each(json, function(index, item){
								   var word = item.word;
								   var index = word.toLowerCase().indexOf($("input#searchWord").val().toLowerCase());
								   var len = $("input#searchWord").val().length;
								   
								   word = word.substr(0,index) + "<span style='color:blue;'>"+word.substr(index,len)+"</span>"+word.substr(index+len);
								   
								   html += "<span style='cursor:pointer;' class='word'>"+word+"</span><br>";
							   });
							   
							   $("div#displayList").html(html);
							   $("div#displayList").show();
						   }
	
					},
					error: function(request, status, error){
		                  	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		              }
				
				});
			}
		}); // end of $("input#searchWord").keyup(function(){})------------------------
		
		$(document).on("click","span.word",function(){
			$("input#searchWord").val($(this).text());// 텍스트박스에 검색된 결과의 문자열을 입력
			$("div#displayList").hide();
			goSearch();
		});
		
		// 검색시 검색조건 및 검색어값 유지
		if(${not empty requestScope.paraMap}){
			$("select#searchType").val("${requestScope.paraMap.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.searchWord}");
		}
		
	}); // end of $(document).ready(function(){})---------------------------------------

	function goView(addr_seq){
		
		location.href="<%=ctxPath%>/addr_view.opis?addr_seq="+addr_seq;
		
	} // end of function goView(addr_seq)---------------------------------------------------- 
	
	function goSearch(){
		
		var frm = document.searchFrm;
		frm.method = "get";
		frm.action = "<%=ctxPath%>/myAddrlist.opis";
		frm.submit();
		
	} // end of goSearch(){}------------------------------------------------------------
	
</script>

<div style="width: 1460px"> 
	
	<!-- 게시판제목 -->
	<div style="padding: 15px; font-size: 25px; font-weight: 600; height: 60px; width: 100%; background-color: #f2f2f2; color: #555;">
	&nbsp;&nbsp;개인 주소록
	</div>
	
	<div class="container" style="float: right; width: 80%; margin-top: 50px;">        

  		<!-- 검색 -->
		<form name="searchFrm" style="margin-top: 20px;">
	      <select name="searchType" id="searchType" style="height: 26px;">
	         <option value="dept_name">부서</option>
	         <option value="mbr_name">이름</option>
	      </select>
	      <input type="text" name="searchWord" id="searchWord" size="30" autocomplete="off" /> 
	      <input type="hidden" name="addrgroup_seq" id="addrgroup_seq" value="<%=addrgroup_seq%>" />
	      <button type="submit" onclick="goSearch()">검색</button>
	   	</form>
	   
	    <div id="displayList" style="border:solid 1px gray; width:170px; height: 100px; border-top: 0px; margin-left: 49px; overflow: auto; padding-top: 2px;"> 	
	    </div>

		<!-- 본문(게시판) -->
		<table class="table table-striped" style="font-size: 14px;">
		  <thead>
		    <tr>
		      <th style="width: 7%;  text-align: center;">이름</th>
		      <th style="width: 13%; text-align: center;">전화번호</th>
		      <th style="width: 13%;  text-align: center;">이메일</th>
		      <th style="width: 7%; text-align: center;">부서</th>
		      <th style="width: 7%;  text-align: center;">직책</th>
		    </tr>
		  </thead>
		  <tbody>
		  	<c:if test="${not empty requestScope.myAddrlist}">	    	
		     		<c:forEach var="addrvo" items="${requestScope.myAddrlist}" varStatus="status">
		      	<tr>
					<td align="center">
						<span class="name" onclick="goView('${addrvo.addr_seq}')">${addrvo.mbr_name}</span>
					</td>
					<td align="left">${addrvo.mbr_phone_number}</td>
					<td align="center">${addrvo.mbr_email}</td>
					<td align="center">${addrvo.dept_name}</td>
					<td align="center">${addrvo.position_name}</td>
		      	</tr>		      
		     	</c:forEach>
		     </c:if>
		    <c:if test="${empty requestScope.myAddrlist}">
		     	<tr>
				<td align="center" colspan="5">
					주소록에 등록된 사람이 없습니다.
				</td>
		     	</tr>
		    	</c:if>
		  </tbody>
		</table>

		<!-- 페이지바 -->  
		<c:if test="${not empty requestScope.myAddrlist}">
			<div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto;">
		   		${requestScope.pageBar}
		    </div>
		</c:if>
	
	</div>	  	
	
</div>
