<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ProjectList</title>

	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="./resources/js/projectList.js"></script>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">	
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	<link rel="stylesheet" href="./resources/css/membership.css"/>
	<link rel="stylesheet" href="./resources/css/projectList.css"/>
	

	<!-- //페이지네이션 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js" 
	integrity="sha512-frFP3ZxLshB4CErXkPVEXnd5ingvYYtYhE5qllGdZmcOlRKNEPbufyupfdSTNmoF5ICaQNO6SenXzOZvoGkiIA==" 
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
	
</head>
<body>

	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<%@ include file="/WEB-INF/views/include/banner.jsp" %>
	
	<input type="hidden" id="map-field" value="${field}"/>

	<div class="projectList-container">
		<div class="membership-title" style="display:flex;align-items:center;margin-bottom:20px;">
			<span style="background:#112579;width:20px;height:20px;margin-right:10px;"></span>
			<span style="font-size:23px;font-weight:700;">프로젝트 검색</span>
		</div>
		
		
		<div class="project-search-condition">
			<div class="search-type">
				<input type="checkbox" name="sh_check" id="sh_check1" value="기획"/>
				<span>기획</span>
				<input type="checkbox" name="sh_check" id="sh_check2" value="디자인"/>
				<span>디자인</span>
				<input type="checkbox" name="sh_check" id="sh_check3" value="퍼블리셔"/>
				<span>퍼블리셔</span>
				<input type="checkbox" name="sh_check" id="sh_check4" value="개발"/>
				<span>개발</span>
			</div>
			<div class="keyword-box">
				<select name="keyword-mode" id="keyword-mode">
					<option value="">선택</option>
					<option value="title">프로젝트 제목</option>
					<option value="content">프로젝트 내용</option>
				</select>
				<input type="text" id="keyword"/>
				<button class="search-btn">검색</button>
			</div>
		</div>
		
		<div class="projects" style="margin-top:30px;display:flex;justify-content:space-between">
			<div class="row" id="projectList">
			
				
				
				
			
			</div>
	
		</div>
		
		
		
		
	</div>
	
	<ul id="pagination-project" class="pagination-sm"></ul>
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	

</body>
</html>