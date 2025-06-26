<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Home</title>
	
	<meta name="viewport" content="width=1190, user-scalable=yes">
	
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	
	<!--슬라이드 ${pageContext.request.contextPath}-->
	<link rel="stylesheet" href="./resources/css/jquery.bxslider.css"/>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bxslider/4.2.15/jquery.bxslider.min.js"></script>
	
	<script src="./resources/js/home.js"></script>
	
</head>
<body>


		<%@ include file="/WEB-INF/views/include/header.jsp" %>

	
	
	
	<div class="home-body">
		<img class="home-img" src="./resources/image/main-body.jpg"/>
		<div class="home-container">
			<span class="typed-out">
				추억을 공유하다
			</span>
		</div>
	</div>
	
	
	<div class="home-domestic">
		<div class="home-domestic-name">
			<span>국내여행지</span>			
		</div>
		<div class="film-top">
			<img src="./resources/image/film1.png"/>
		</div>
		<div class="home-domestic-photo" style="height:300px;">
			<div class="my_bxslider" id="home-domestic-photo">
			
			
			</div>
		</div>
		<div class="film-bottom">
			<img src="./resources/image/film1.png"/>
		</div>
		
	</div>
	<input type="button" class="btn btn-primary home-more-button" value="MORE" data-more-button="domestic"/>
	
	
	
	<div class="home-abroad">
		<div class="home-abroad-name">
			<span>해외여행지</span>
		</div>
		<div class="film-top">
			<img src="./resources/image/film1.png"/>
		</div>
		<div class="home-abroad-photo" style="height:300px;">
			<div class="my_bxslider" id="home-abroad-photo">
			
			
			</div>
		</div>
		<div class="film-bottom">
			<img src="./resources/image/film1.png"/>
		</div>
		<nav type="button" class="btn btn-primary home-more-button" data-more-button="abroad">MORE</nav>
	</div>
	
	
	
	<div style="width:100%;height:250px;"></div>
	
	
	<footer>
		<%@ include file="/WEB-INF/views/footer.jsp" %>
	</footer>

</body>
</html>
