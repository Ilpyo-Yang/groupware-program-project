<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/menu.css" />		
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
  
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/mainPage.css"/>
<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/js/mainPage.js"/>

<script>
	$(function(){
		
	});
</script>

<div id="personalInfoContainer">
	<span class="subtitle">개인정보설정</span><span class="subtitle">|</span><span class="subtitle">회사정보보기</span>
	<hr>
	<table>
		<tbody>
			<tr>
				<td>아이디</td>
				<td id="mbr_id"></td>
				<td rowspan="3">사진</td>
				<td id="mbr_photo" rowspan="3"><i class="fas fa-portrait fa-5x infoIcon"></i></td>
			</tr>
			<tr>
				<td>성명</td>
				<td id="mbr_name"></td>
			</tr>
			<tr>
				<td>소속</td>
				<td id="dept_power"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td id="mbr_pwd"><input type="password" /></td>
				<td>이메일</td>
				<td id="mbr_email"><input type="text" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td id="mbr_pwd_check"><input type="password" /></td>
				<td>회사번호</td>
				<td id="mbr_com_number"><input type="text" /></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td id="mbr_birthday"><input type="text" /></td>
				<td>핸드폰</td>
				<td id="mbr_phone_number"><input type="text" /></td>
			</tr>
		</tbody>
	</table>
</div>   



 