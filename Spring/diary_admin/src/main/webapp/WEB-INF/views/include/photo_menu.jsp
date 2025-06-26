<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
	<title>Photo-Domestic</title>
	
	<meta name="viewport" content="width=1190, user-scalable=yes">
	<script src="./resources/js/header.js"></script>
	<script src="./resources/js/photos.js"></script>
	
	
</head>
<body>

		<div class="photo-title">
			<nav class="photo-title-sub <c:if test="${photo_menu eq 'domestic'}">active</c:if>" data-photos="domestic">
				<i class="fa-solid fa-car-side"></i>
				<span style="padding-left:110px;">국내여행지</span>
				<span> (DOMESTIC)</span>
			</nav>
			<nav class="photo-title-sub <c:if test="${photo_menu eq 'abroad'}">active</c:if>" data-photos="abroad">
				<i class="fa-solid fa-plane"></i>
				<span style="padding-left:110px;">해외여행지</span>
				<span> (ABROAD)</span>
			</nav>
		</div>
		
</body>
</html>