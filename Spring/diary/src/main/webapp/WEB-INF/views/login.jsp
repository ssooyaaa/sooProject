<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Login</title>
	
	
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/login.css"/>



	
</head>
<body>


		<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<div class="login-body">
		<img src="./resources/image/login.jfif"/>
		<div class="login-container">
			<div class="form-box">
				<div class="button-box">
					<div id="login-register-btn"></div>
					<button type="button" class="toggle" onclick="login()" style="padding-left:40px;">로그인</button>
					<button type="button" class="toggle" onclick="register()">회원가입</button>
				</div>
				
				<div class="login-group" id="login">
					<input type="text" class="login-input" id="loginId" placeholder="ID를 입력하세요" required>
					<input type="password" class="login-input" id="loginPw" placeholder="PW를 입력하세요" required>
					<label class="login-check-box">
						<input type="checkbox" class="login-check-box"  id="loginCheckbox">
						<span class="icon"></span>
						<span class="checkbox-text">자동 로그인 할까요?</span>									
					</label>
					<button type="submit" id="login-submit-btn" class="login-submit">로그인하기</button>	
				</div>
				
				<div class="login-group" id="register">
					<input type="text" class="login-input" id="id" placeholder="ID를 입력하세요" required>
					<input type="password" class="login-input" id="pw" placeholder="PW를 입력하세요" required>
					<input type="password" class="login-input" id="pwCheck" placeholder="PW를 한번 더 입력하세요" required>
					<input type="text" class="login-input" id="nickname" placeholder="닉네임을 입력하세요" required>
					<label class="login-check-box">
						<input type="checkbox" id="addLoginCheckbox" class="login-check-box">
						<span class="icon"></span>
						<span class="checkbox-text">약관에 동의합니다.</span>									
					</label>
					<button class="login-submit" id="addLogin-submit">가입하기</button>	
				</div>
			</div>
			
			
		</div>
		
	</div>


	<script>
		var a = document.getElementById("login");
		var b = document.getElementById("register");
		var c = document.getElementById("login-register-btn");
	
		function register() {
			a.style.left="-400px";
			b.style.left="50px";
			c.style.left="120px";
		}
		
		function login() {
			a.style.left="50px";
			b.style.left="450px";
			c.style.left="0";
		}
		
	</script>
	


</body>
</html>
