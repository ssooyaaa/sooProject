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
	
	<!-- //페이지네이션 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js" 
	integrity="sha512-frFP3ZxLshB4CErXkPVEXnd5ingvYYtYhE5qllGdZmcOlRKNEPbufyupfdSTNmoF5ICaQNO6SenXzOZvoGkiIA==" 
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	
	
	<script src="./resources/js/home.js"></script>
	
</head>
<body>


		<%@ include file="/WEB-INF/views/include/header.jsp" %>

	
	<div class="user-container">
		<div class="user-manager" style="margin-top:30px;margin-left:80px;margin-right:80px;font-size:40px;font-weight:700;border-bottom:2px solid #1e1e1e">
			<i class="fa-solid fa-users"></i>
		회원관리
		</div>
		<table class="table" style="width:85%;margin-left:90px;position:relative">
			  <thead>
			    <tr style="font-size:20px;">
			      <th scope="col" style="width:200px;text-align:center">번호</th>
			      <th scope="col" style="width:200px;text-align:center">아이디</th>
			      <th scope="col" style="width:200px;text-align:center">닉네임</th>
			      <th scope="col" style="width:260px;text-align:center">가입날짜</th>
			      <th scope="col" style="width:170px;text-align:center">계정존재여부</th>
			      <th scope="col" style="width:170px;text-align:center">관리</th>
			    </tr>
			  </thead>
			  <tbody id="user-tbody">
			   		   
			  </tbody>
			  
			  	
		</table>
		
		<div class="more-user" style="width:50%;height:150px;background:white;border:2px solid #1e1e1e;
										display:none;border-radius:10px;position:absolute;top:25%;left:25%;">
			<div class="return-btn" style="font-size:20px;text-align:end;margin-right:20px;margin-top:10px;margin-bottom:10px"><i class="fa-solid fa-arrow-rotate-left"></i></div>
			<table class="table">
				<thead>
					<tr style="font-size:18px;width:50%;background:#EEEDEC;">
						<th scope="col" style="width:50%;text-align:center">다이어리 수</th>
						<th scope="col" style="width:50%;text-align:center">댓글 수</th>
					</tr>
				</thead>
				
				<tbody id="more-user-tbody">
					
				</tbody>
			</table>
			
		</div>
		
		<div style="border-bottom:2px solid #1e1e1e;margin-bottom:20px;">
		</div>
	
	</div>
	
	<ul id="pagination-user" class="pagination-sm"></ul>
	
	
	


</body>
</html>
