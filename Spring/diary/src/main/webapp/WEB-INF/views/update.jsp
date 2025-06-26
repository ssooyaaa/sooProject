<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
	<title>Update</title>
	
	<meta name="viewport" content="width=1190, user-scalable=yes">
	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
	
	<!-- firebase이미지 -->
	<script src="https://www.gstatic.com/firebasejs/3.2.0/firebase.js"></script>
	<script src="https://www.gstatic.com/firebasejs/7.3.0/firebase-app.js"></script>
	<script src="https://www.gstatic.com/firebasejs/6.2.0/firebase-storage.js"></script>	
	<script src="./resources/js/config.js"></script>
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>	
	<script src="./resources/js/header.js"></script>
	<script src="./resources/js/update.js"></script>
	
		
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/write.css"/>

	
</head>
<body>

	<div class=loading id="loading" style="width:100%;margin-top:422px;margin-bottom:422px;display:none">
		<div class="spinner"></div>
		<span>저장중입니다...</span>
	</div>	


		<%@ include file="/WEB-INF/views/include/header.jsp" %>
		
	
	<div class="write-body">
	
	<!-- 해당 리스트 idx가져오기 위해 -->
	<input type="hidden" id="up-mydiary-idx" value="${mydiary_idx}"/>
	
		<div class="write-header" id="write-header">
	
	
		</div>
		
		
		<div class="write-title" id="write-title">
			
		</div>
		
		
		
		
		<div class="write-container" id="write-container">
					
		</div>
		
		
		
		<div class="write-more-photos">
			<div class="write-more-photos-title">
				<i class="fa-solid fa-photo-film" style="margin-right:5px;"></i>
				MORE PHOTOS
				<span style="font-size:15px;">(최대 10장까지)</span>
			</div>
			
			<div class="more-photos-container">
				<button class="btn-more-photos" style="margin-bottom:20px;">
					<i class="fa-solid fa-camera">
					<span>사진 추가</span>
					</i>
				</button>
				
				
				<div id="plus-more-photos">
					
				</div>
			</div>
			
		</div>
		
		
		<div class="write-tips">
			<div class="write-tips-title">
				<i class="fa-solid fa-lightbulb" style="margin-right:5px;"></i>
				TIPS
				<span style="font-size:15px;">작성 전, 꼭 읽어보세요!</span>
				<i class="fa-solid fa-circle-exclamation exclamation">
					<div class="tips-exclamation">
						1. 다른 사용자에게도 공유되기 때문에 욕설 사용시 삭제조치합니다.<br/><br/>
						2. 작성 후, "추가"버튼을 누르셔야 저장됩니다.<br/><br/>
						3. tips작성 시, "나라이름"은 꼭 작성해주세요.<br/><br/>
						4. "나라이름/사진/설명" 모두 적혀있어야 저장되고, 상단의 'Photo'메뉴에서 확인가능합니다.
						
					</div>
				</i>
			</div>
			
			<div class="write-tips-sub">
				<span class="write-tips-subname">
					<i class="fa-solid fa-square-check"></i>
				교통</span>
				
				
				<input type="button" class="tips-add-button" id="button-add-transport" value="추가"/>
				<input type="text" class="tips-content-add" id="tips-add-transport"/>
		
				
			</div>
			<div class="tips-list-transport" id="tips-list-transport"></div>
			
			
			
			
			<div class="write-tips-sub">
				<span class="write-tips-subname">
					<i class="fa-solid fa-square-check"></i>
				숙소</span>
				
				<input type="button" class="tips-add-button" id="button-add-accomodation" value="추가"/>
				<input type="text" class="tips-content-add" id="tips-add-accomodation" placeholder="  숙소명 or 위치를 함께 적어주세요"/>
								
				
			</div>
			<div class="tips-list-accomodation" id="tips-list-accomodation"></div>
			
			
			
			<div class="write-tips-sub">
				<span class="write-tips-subname">
					<i class="fa-solid fa-square-check"></i>
				식당/카페</span>
				
				<input type="button" class="tips-add-button" id="button-add-eat" value="추가"/>
				<input type="text" class="tips-content-add" id="tips-add-eat" placeholder="  가게명 or 위치를 함께 적어주세요"/>
				
				
			</div>
			<div class="tips-list-eat" id="tips-list-eat"></div>
			
			
			
			<div class="write-tips-sub" id="write-tips-sight">
				
			</div>
			<div class="location-filebox" id="location-filebox">
				
			</div>
				
			
			<div class="write-tips-sub" style="margin-bottom:50px;">
				<span class="write-tips-subname">
					<i class="fa-solid fa-square-check"></i>
				기타</span>
				
				<input type="button" class="tips-add-button" id="button-add-etc" value="추가"/>
				<input type="text" class="tips-content-add" id="tips-add-etc"/>
				
			</div>
			<div class="tips-list-etc" id="tips-list-etc"></div>
			
			
		</div>
		
		<div class="save">
			<div style="font-size:15px; font-weight:700; margin-bottom:10px;">!!! 잊지 말고 수정하기 버튼 눌러주세요 !!!</div>
			<div style="font-size:18px; font-weight:700; margin-bottom:15px;">
				<i class="fa-solid fa-down-long"></i>
				<i class="fa-solid fa-down-long"></i>
				<i class="fa-solid fa-down-long"></i>
			</div>
			<button type="button" class="save-button" id="modify-button">수정하기
			</button>
		</div>
		
	</div>
		



</body>
</html>
