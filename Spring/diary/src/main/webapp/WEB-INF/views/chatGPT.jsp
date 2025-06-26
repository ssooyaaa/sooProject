<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>ChatGPT</title>
	<meta name="viewport" content="width=1190, user-scalable=yes">
	
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%@ page trimDirectiveWhitespaces="true" %>
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="./resources/js/chatGPT.js"></script>
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
	
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	<link rel="stylesheet" href="./resources/css/chatGPT.css"/>
	
	
	
	
</head>
<body>

	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
		<div class="chat-body">
		
			<div class="chat-main"><i class="fa-solid fa-robot" style="margin-right:10px">
				<span>여행에 관해 무엇이든 물어보세요!</span></i> 
				<span class="skip-btn">SKIP
				</span>
			</div>
			<div class="chat">
				<input type="text" class="chat-text" placeholder="무엇이 알고싶으신가요?"/>
				<span class="chat-summit"><i class="fa-solid fa-headset"></i></span>
				<div class="chat-wait">열심히 응답중입니다... 잠시만 기다려주세요!!</div>
				<div class="chat-reply">
				</div>
			</div>
			
			
		</div>
		
	

</body>
</html>
