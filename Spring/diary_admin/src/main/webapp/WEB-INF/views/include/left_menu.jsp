<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Left_menu</title>
	
	<meta name="viewport" content="width=1190, user-scalable=yes">
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/comment.css"/>
	
	<script src="./resources/js/header.js"></script>
	<script src="./resources/js/comment.js"></script>
	<script src="./resources/js/left-menu.js"></script>
	
</head>

	
<body>


	<div class="left-menu">
			<div class="comment-subname">TIPS</div>
			<nav class="tips-subname <c:if test="${comment eq 'transport'}">active</c:if>" data-comment="transport">
				<span class="left-transport" >Transport</span>
			</nav>
			<nav class="tips-subname <c:if test="${comment eq 'accomodation'}">active</c:if>" data-comment="accomodation">
				<span class="left-accomodation">Accomodation</span>
			</nav>
			<nav class="tips-subname <c:if test="${comment eq 'eat'}">active</c:if>" data-comment="eat">
				<span class="left-eat">Eat</span>
			</nav>
			<nav class="tips-subname <c:if test="${comment eq 'etc'}">active</c:if>" data-comment="etc" style="border-bottom:2px solid var(--color-main);">
				<span class="left-etc">Etc</span>
			</nav>
			
			<div class="comment-subname" style="margin-top:60px;">PHOTOS</div>
			<nav class="tips-subname <c:if test="${comment eq 'domestic'}">active</c:if>" data-comment="domestic">
				<span class="left-domestic">Domestic</span>
			</nav>
			<nav class="tips-subname <c:if test="${comment eq 'abroad'}">active</c:if>" data-comment="abroad" style="border-bottom:2px solid var(--color-main);">
				<span class="left-abroad">Abroad</span>
			</nav>
		
	</div>
	

</body>
</html>