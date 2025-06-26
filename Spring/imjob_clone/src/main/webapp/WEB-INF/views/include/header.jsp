<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Header</title>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="./resources/js/header.js"></script>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
		
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	
	<!-- //페이지네이션 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js" 
	integrity="sha512-frFP3ZxLshB4CErXkPVEXnd5ingvYYtYhE5qllGdZmcOlRKNEPbufyupfdSTNmoF5ICaQNO6SenXzOZvoGkiIA==" 
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
</head>
<body>

	<input type="hidden" id="map-user-idx" value="${loginUser.user_idx}"/>
	
		
	<header class="header-container">
		<div class="menu-container">
			<div class="menu">
				<img class="home-logo" src="./resources/image/imjob-logo.png"/>
				<div class="main-menus">
					<span class="add-project">프로젝트등록</span>
					<span class="search-project">프로젝트검색</span>
					<span class="add-member">프리랜서등록</span>
					<span class="commissioned">정규직의뢰</span>
				</div>
				
				<c:if test="${empty sessionScope.loginUser}">
					<div class="membership">
						<span class="login-btn" style="padding-right:5px">로그인</span>
						<span style="color:#D5D9D9;"> | </span>
						<span class="membership-btn" style="padding-left:5px">회원가입</span>
					</div>
				</c:if>
				
				
				<c:if test="${not empty sessionScope.loginUser}">
					<div class="logout">
						<span class="logout-btn" id="logout-btn">로그아웃</span>
					</div>
				</c:if>
				
				
			</div>
		</div>
	</header>

</body>
</html>