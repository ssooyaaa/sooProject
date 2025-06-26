
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
<html>

<head>
	
	<title>MyDiary</title>
	
	<meta name="viewport" content="width=1190, user-scalable=yes">
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="./resources/js/header.js"></script>
	<script src="./resources/js/mydiary.js"></script>
	
	
	
	<!-- //페이지네이션 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js" 
	integrity="sha512-frFP3ZxLshB4CErXkPVEXnd5ingvYYtYhE5qllGdZmcOlRKNEPbufyupfdSTNmoF5ICaQNO6SenXzOZvoGkiIA==" 
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
	<!-- firebase이미지 -->
	<script src="https://www.gstatic.com/firebasejs/3.2.0/firebase.js"></script>
	<script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-app.js"></script>
	<script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-storage.js"></script>	
	<script src="./resources/js/config.js"></script>
	
	<!--구글Map -->
	 <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBl4McvgZHCttbQLX2o3ypXNJv8BqyoSeY&callback=initMap&v=weekly"
      defer
    ></script>
	 
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
		
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	<link rel="stylesheet" href="./resources/css/mydiary.css"/>
	
	
	
</head>
<body>
	
		<%@ include file="/WEB-INF/views/include/header.jsp" %>
		
	<input type="hidden" id="map-user-idx" value="${loginUser.user_idx}"/>
	
	
	<div class="mydiary-body">
		<img class="mydiary-img" src="./resources/image/diary-body.jpg"/>
			<div class="mydiary-container">
				<div class="mydiary-name"> MY DIARY
				</div>
				<div class="mydiary-write"> 다이어리 작성하기
					<i class="fa-solid fa-pencil"></i>
				</div>
			</div>
		<div class="mydiary-search">
			<i class="fa-solid fa-location-dot"></i>
			<input class="search" id="search" type="search" placeholder="검색 (나라이름)"/>
			<i class="fa-solid fa-magnifying-glass glass" id="search-glass"></i>
		</div>
		
		<div id="forMap" style="width:100%;border-bottom:4px solid var(--color-main);">
			<div id="googleMap" style="width:90%;height:500px;
			margin-left:5%;margin-top:20px;margin-bottom:20px;"></div>
		</div>
		
		
		
	
	<div id="mydiary-container">
	</div>	
	
	<ul id="pagination-demo" class="pagination-sm"></ul>
	
	
	
	
	
	<footer>
		<%@ include file="/WEB-INF/views/footer.jsp" %>
	</footer>
	
	
	



</body>

</html>
