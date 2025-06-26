<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="./resources/js/login.js"></script>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
		
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	<link rel="stylesheet" href="./resources/css/login.css"/>
	
</head>
<body>

	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<%@ include file="/WEB-INF/views/include/banner.jsp" %>
	
	<div class="login-container">
		<div class="login-title" style="display:flex;align-items:center;margin-bottom:20px;">
			<span style="background:#112579;width:20px;height:20px;margin-right:10px;"></span>
			<span style="font-size:23px;font-weight:700;">로그인</span>
		</div>
		
		<div class="login-box">
			<div class="login">
				<div style="font-weight:700;">로그인하세요</div>
				
				<div class="id-pw-box">
					<div class="id-pw-title">
						<span>아이디</span>
						<span>비밀번호</span>
					</div>
					<div class="input">
						<input type="text" id="input-id"/>
						<input type="password" id="input-pw"/>
					</div>
					<div class="login-box-btn">로그인</div>
				</div>
				
				<div style="font-size:13px;padding-top:20px;margin:auto;width:90%;display:flex;justify-content:center;">
					<span style="width:250px;">아직도 회원가입을 하지 않으셨나요?</span>
					<span class="go-membership">회원가입하기</span>
				</div>
				<div style="font-size:13px;padding-top:20px;margin:auto;width:90%;display:flex;justify-content:center;">
					<span style="width:250px;">아이디/비밀번호를 잊어버리셨나요?</span>
					<span class="search-id-pw">아이디/비밀번호 찾기</span>
				</div>
					
			</div>
			
			<div class="login-next-image">
				<img src="./resources/image/login-next.png" style="display:flex;object-fit:cover;"/>
			</div>
		</div>
		
	
	</div>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>