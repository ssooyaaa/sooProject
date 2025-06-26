<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Photo-Abroad</title>
	
	<meta name="viewport" content="width=1190, user-scalable=yes">
	
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
	
	
	<link rel="stylesheet" href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	<link rel="stylesheet" href="./resources/css/photo.css"/>
	
	<script src="https://code.jquery.com/jquery-3.6.1.min.js" 
	integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" 
	crossorigin="anonymous"></script>
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="./resources/js/photo-abroad.js"></script>
	
	<!-- //페이지네이션 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js" 
	integrity="sha512-frFP3ZxLshB4CErXkPVEXnd5ingvYYtYhE5qllGdZmcOlRKNEPbufyupfdSTNmoF5ICaQNO6SenXzOZvoGkiIA==" 
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
</head>
<body>


		<%@ include file="/WEB-INF/views/include/header.jsp" %>
		
		
	<div class="photo-body">
		
		
		<%@ include file="/WEB-INF/views/include/photo_menu.jsp" %>
		
		
		
		<div class="photo-content">
			<div class="photo-search">
				<i class="fa-solid fa-location-dot"></i>
				<input style="width:150px;" class="search" id="search" type="search" placeholder="검색(사용자번호)"/>
				<i class="fa-solid fa-magnifying-glass glass" id="search-glass"></i>
			</div>
			
			<div class="photo-section">
				<div class="row" id="photo-section-row">
					
				</div>
			</div>
			
						
			<ul id="pagination-abroad" class="pagination-sm"></ul>
			
		</div>
	</div>

	
</body>
</html>