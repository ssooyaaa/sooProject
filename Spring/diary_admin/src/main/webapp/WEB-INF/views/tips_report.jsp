<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Tips_report</title>
	
	<meta name="viewport" content="width=1190, user-scalable=yes">
	
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	
	<!-- //페이지네이션 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js" 
	integrity="sha512-frFP3ZxLshB4CErXkPVEXnd5ingvYYtYhE5qllGdZmcOlRKNEPbufyupfdSTNmoF5ICaQNO6SenXzOZvoGkiIA==" 
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
	
	<script src="./resources/js/tips_report.js"></script>
	
</head>
<body>


		<%@ include file="/WEB-INF/views/include/header.jsp" %>

	
	<div class="user-container">
		<div class="user-manager" style="margin-top:30px;margin-left:80px;margin-right:80px;font-size:40px;font-weight:700;border-bottom:2px solid #1e1e1e">
			<i class="fa-solid fa-users"></i>
		Tips-신고접수
		</div>
		<table class="table" style="table-layout:fixed;width:85%;margin-left:90px;">
			  <thead style="width:85%;margin-left:90px;">
			    <tr style="font-size:20px;text-align:center">
			      <th scope="col" class="table-idx">번호</th>
			      <th scope="col" class="user-idx">사용자번호</th>
			      <th scope="col" class="report-desc">보고내용</th>
			      <th scope="col" class="contents">tips-내용</th>
			      <th scope="col" class="up-btn">수정체크</th>

			    </tr>
			  </thead>
			  <tbody id="tips-tbody">
			   			   
			  </tbody>
		</table>
		
		<div style="border-bottom:2px solid #1e1e1e;margin-bottom:20px;">
		</div>
	
	</div>
	
	<ul id="pagination-tips-report" class="pagination-sm"></ul>
	
	
	
	

</body>
</html>
