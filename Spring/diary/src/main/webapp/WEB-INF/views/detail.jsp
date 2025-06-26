<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Detail</title>
	<meta name="viewport" content="width=1190, user-scalable=yes">
	
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="./resources/js/header.js"></script>
	<script src="./resources/js/detail.js"></script>
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
	
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	<link rel="stylesheet" href="./resources/css/detail.css"/>
	
	
	
</head>
<body>

	
	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	
	<div class="detail-body" id="detail-body">
	
	<!-- 해당 리스트 idx가져오기 위해 -->
	<input type="hidden" id="k-mydiary-idx" value="${mydiary_idx}"/>
		
		
		<div class="detail-tips">
			<div class="detail-tips-title">
				<i class="fa-solid fa-lightbulb" style="margin-right:5px; font-size:30px;"></i>
				TIPS
			</div>
			
			<div class="detail-tips-sub">
				<span class="detail-tips-subname">
					<i class="fa-solid fa-square-check"></i>
				교통</span>
				<ul class="detail-tips-content" id="detail-tips-content-trans">
					
					
				</ul>
				
			</div>
			
			<div class="detail-tips-sub">
				<span class="detail-tips-subname">
					<i class="fa-solid fa-square-check"></i>
				숙소</span>
				<ul class="detail-tips-content" id="detail-tips-content-accom">
					
				</ul>
				
			</div>
			
			<div class="detail-tips-sub">
				<span class="detail-tips-subname">
					<i class="fa-solid fa-square-check"></i>
				식당/카페</span>
				<ul class="detail-tips-content" id="detail-tips-content-eat">
					
				</ul>
				
			</div>
			
			<div class="detail-tips-sub">
				<span class="detail-tips-subname">
					<i class="fa-solid fa-square-check"></i>
				숨은 명소</span>
				<div class="detail-tips-content" id="detail-tips-sight">
			
			
				</div>
				
				
				<script>
				
				function openMapPop(){
					document.getElementById("mappin-popup").style.visibility="visible";
				}
				
				function closeMapPop(){
					document.getElementById("mappin-popup").style.visibility="hidden";
				}
				</script>
				
				
			</div>
			
			<div class="detail-tips-sub" style="margin-bottom:50px;">
				<span class="detail-tips-subname">
					<i class="fa-solid fa-square-check"></i>
				기타</span>
				<ul class="detail-tips-content" id="detail-tips-content-etc">
					
				</ul>
				
			</div>
			
		</div>
	</div>
		

	

</body>
</html>
