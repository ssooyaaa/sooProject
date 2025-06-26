<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Detail</title>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
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
	
	<%@ include file="/WEB-INF/views/include/banner.jsp" %>
	
	<!-- 해당 리스트 idx -->
	<input type="hidden" id="k-project-idx" value="${project_idx}"/>
	
	
	<div class="detail-container">
		
		
		
		<div class="detail-info-box">
			<span>상세설명</span>
			<div class="detail-info">
			
			
			</div>
		</div>
		
		<div class="btn-box">
			<button class="go-to-projectlist">목록</button>
		</div>
		
		<div class="note-box">
			<span>
				본 프로젝트는 당사와 제휴된 업체들의 책임하에 운영하는 프로젝트 공고입니다.<br>
				프로젝트 참여를 원하시는 분(회원)은 로그인 후 작업지원하기로 지원하시면 검토 후 담당자가 연락 드리겠습니다.<br>
				프로젝트 지원 전 반드시 이력서 및 포트폴리오 업데이트 후 지원해 주시길 바랍니다.
			</span>
		</div>
		
	</div>
	
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>