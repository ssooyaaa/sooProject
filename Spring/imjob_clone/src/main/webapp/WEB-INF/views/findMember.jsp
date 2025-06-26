<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find Member</title>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="./resources/js/findMember.js"></script>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
		
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	<link rel="stylesheet" href="./resources/css/findMember.css"/>
	
</head>
<body>

	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<%@ include file="/WEB-INF/views/include/banner.jsp" %>
	
	<div class="findMember-container">
		<div class="findMember-title" style="display:flex;align-items:center;margin-bottom:20px;">
			<span style="background:#112579;width:20px;height:20px;margin-right:10px;"></span>
			<span style="font-size:23px;font-weight:700;">아이디/비밀번호 찾기</span>
		</div>
		
		<div class="row" style="font-size:15px;margin-bottom:100px;">
			<div class="col-6">
				<div>
					<span style="font-weight:700">아이디찾기</span>
					<div class="name-email-box">
						<div class="name-email-title">
							<span style="padding-bottom:10px;">이름</span>
							<span>이메일주소</span>
						</div>
						<div class="name-email-input">
							<input type="text" id="id-name" style="margin-bottom:10px;"/>
							<input type="text" id="id-email"/>
						</div>
						<button class="name-email-btn" id="name-email-btn">확인</button>
					</div>
				</div>
			</div>
			
			<div class="col-6">
				<div>
					<span style="font-weight:700">비밀번호찾기</span>
					
					<div class="id-name-box">
						<div style="display:flex;justify-content:space-between;width:380px;">
							<div class="name-email-title">
								<span style="padding-bottom:10px;">아이디</span>
								<span>이름</span>
							</div>
							<div class="name-email-input">
								<input type="text" id="pw-id" style="margin-bottom:10px;"/>
								<input type="text" id="pw-name"/>
							</div>
							<button class="name-email-btn" id="id-name-btn">확인</button>
							
						</div>
						<div style="width:380px;margin-top:10px;display:flex;">
							<span style="width:120px;">이메일주소</span>
							<input type="text" id="pw-email" style="width:250px;"/>
						</div>
							
					</div>
					
					
					
					
				</div>
			</div>
		
		</div>
	</div>
	
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	
	
</body>
</html>