<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Com_etc</title>
	
	<meta name="viewport" content="width=1190, user-scalable=yes">
	
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="./resources/js/com_etc.js"></script>
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/comment.css"/>

	<!-- //페이지네이션 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js" 
	integrity="sha512-frFP3ZxLshB4CErXkPVEXnd5ingvYYtYhE5qllGdZmcOlRKNEPbufyupfdSTNmoF5ICaQNO6SenXzOZvoGkiIA==" 
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
	
</head>
<body>



		<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<div class="comment-body">
		
		<%@ include file="/WEB-INF/views/include/left_menu.jsp" %>
		
		
		<div class="main-content">
			<div class="comment-name">Comment</div>
			
			<table class="table" style="table-layout:fixed; width:85%;margin-left:95px;">
			  <thead style="width:85%;margin-left:95px;">
			    <tr style="font-size:20px;text-align:center">
			      <th scope="col" class="com-table-idx">번호</th>
			      <th scope="col" class="com-user">닉네임</th>
			      <th scope="col" class="com-report-desc">댓글</th>
			      <th scope="col" class="com-btn">삭제</th>

			    </tr>
			  </thead>
			  <tbody id="comment-tbody">
			   			   
			  </tbody>
			  
			  
		</table>
		
		<ul id="pagination-comment" class="pagination-sm"></ul>
		
		</div>
	</div>

</body>
</html>