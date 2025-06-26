<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Header</title>
	
	<meta name="viewport" content="width=1190, user-scalable=yes">
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	
	<script src="./resources/js/header.js"></script>
	<script src="./resources/js/login.js"></script>
	
</head>

	
<body>
	
	
	<input type="hidden" id="map-user-idx" value="${loginUser.user_idx}"/>
	

	<header class="header">
		<div class="logo-menu">
				<i class="fa-solid fa-book-open-reader logo-icon"></i>
				<span class="main-name">Trip Diary</span>
				<span class="menu-item <c:if test="${header eq 'home'}"></c:if>" data-menu="home">Home</span>
				<span class="menu-item <c:if test="${header eq 'mydiary'}"></c:if>" data-menu="mydiary" id="mydiary">MyDiary</span>
				<span class="menu-item <c:if test="${header eq 'tips'}"></c:if>" data-menu="tips">Tips</span>
				<span class="menu-item <c:if test="${header eq 'photo'}"></c:if>" data-menu="photo">Photo</span>
		</div>
		
		<c:if test="${empty sessionScope.loginUser}">
			<div class="header-icon">
				<i class="fa-solid fa-right-to-bracket user-icon">
					<span>LOGIN</span>
				</i>
			</div>
		</c:if>
		
		<c:if test="${not empty sessionScope.loginUser}">
			<div class="header-icon">
				<i class="fa-solid fa-right-from-bracket logout" id="logout-btn">
					<span>LOGOUT</span>
				</i>
				<i class="fa-solid fa-ban log-del" id="log-del-btn">
					<span>계정탈퇴</span>
				</i>
			</div>
		</c:if>
		
	</header>


</body>

</html>
