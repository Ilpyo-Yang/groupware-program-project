<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<jsp:include page="./approval_sidebar.jsp" />  

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<script type="text/javascript">
	$(document).ready(function(){
		
		$("input#datepicker").datepicker({
			 dateFormat: 'yy-mm-dd', 
		      changeMonth: true,
		      changeYear: true
		});
		
		$("input#datepicker2").datepicker({
			 dateFormat: 'yy-mm-dd', 
		      changeMonth: true,
		      changeYear: true
		});
		
		var html="";

		// 결재요청 내역 가져오기
		$.ajax({
			url:"<%=ctxPath%>/approvalSubmitList.opis",
			dataType:"json",
			data:{fk_mbr_seq:'${sessionScope.loginuser.mbr_seq}'},
			success: function(json){		
				if(json.length>0){
					$.each(json, function(index, item){
						var ap_manage_approver = item.ap_manage_approver;
						var ap_progress = "";
						if(item.ap_progress=='0'){
							ap_progress+="<span>진행중</span>";
						} else if(item.ap_progress=='1') {
							ap_progress+="<span style='color:#04AA6D;'>완료</span>";
						} else {
							ap_progress+="<span style='color:red;'>반려</span>";
						}
						
						html += "<tr>"+
						"<td><input type='checkbox' class='approvalList' value='"+item.ap_seq+"'/></td>"+
						"<td>"+item.apform_name+"</td>"+
						"<td>"+item.ap_title+"</td>"+
						"<td>"+item.ap_start_day+"</td>"+
						"<td>"+ap_manage_approver.substr(6)+"</td>"+
						"<td>"+item.ap_end_day+"</td>"+
						"<td>"+ap_progress+"</td>"+
					    "</tr>";
					});
				}
				else {
					html += "<tr><td></td><td>결재 요청한 문서가 없습니다.</td><td></td><td></td><td></td><td></td></tr>"
				}
					
				$("tbody#list").html(html);
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); 
		
	}); // end of $(document).ready(function(){})---------------------------------------
	
</script>
</head>
<body>

	<div id="approvalContainer">
		<span class="subtitle">결재요청한 문서</span>
		<hr> 	
		<div id="searchOption">
			<table>
				<tr>
					<td>진행상황</td>
					<td>
						<select name="listCnt" class="form-control searchInput" id="selectProcess">
							<option>전체</option>
							<option>진행중</option>
							<option>완료</option>
							<option>반려</option>
						</select>
					</td>
					<td>기안일</td>
					<td>
						<input type="text" class="form-control searchInput" id="datepicker"/>
						<span>-</span>
						<input type="text" class="form-control searchInput" id="datepicker2"/>
					</td>
				</tr>
				<tr>
					<td>문서제목</td>
					<td colspan="3">
						<input type="text" class="form-control searchInput"/>
						<button type="button" class="btn formBtn4" id="search">조회하기</button>
					</td>
				</tr>
			</table>
		</div>
		<div id="searchList">
			<select name="listCnt" class="selectCommon" id="listCnt">
				<option>10개</option>
				<option>8개</option>
				<option>4개</option>
			</select>
			
			<table class="table table-striped" >
				<thead>
					<tr>
						<th><input type="checkbox" id="alllList"/></th>
						<th>종류</th>
						<th>문서제목</th>
						<th>기안일자</th>
						<th>결재라인 현황</th>
						<th>승인/반려일자</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody id="list" ></tbody>
			</table> 					
		</div>
	</div>

</body>
</html>