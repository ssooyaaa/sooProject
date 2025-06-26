<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Commission</title>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	
	<script type="text/javascript" src="./resources/dist/js/service/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
		
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	<link rel="stylesheet" href="./resources/css/membership.css"/>
	<link rel="stylesheet" href="./resources/css/newWork.css"/>
	
</head>
<body>

	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<%@ include file="/WEB-INF/views/include/banner.jsp" %>
	
	
	<div class="membership-container">
		<div class="membership-title" style="display:flex;align-items:center;margin-bottom:20px;">
			<span style="background:#112579;width:20px;height:20px;margin-right:10px;"></span>
			<span style="font-size:23px;font-weight:700;">정규직등록</span>
		</div>
		
		<div class="terms-container">
			<div class="terms-title" style="margin-bottom:10px;font-size:14px;font-weight:700;">
				<span>*</span>
				<span>개인정보수집 및 안내</span>
			</div>
			
			<div class="membership-info">
				<div class="membership-box">
					<div class="membership-contents">
						<div class="content">
							<div class="content-title">제 1 조 (목적)</div>
							<div class="content-detail">본 약관은 아임잡 (이하 "회사")가 운영하는 웹사이트(https://www.imjob.co.kr) 에서 제공하는 인터넷 관련 서비스를 이용함에 있어. 회사와 회원간의 권리와 의무, 책임사항 및 회원 의 서비스 이용조건및 절차, 기타 필요한 사항을 규정함을 목적으로 한다.</div>
						</div>
						
						<div class="content">
							<div class="content-title">제 2 조 (용어의 정의) </div>
							<div class="content-detail">
								이 약관에서 사용하는 용어의 정의는 아래와 같다.<br>

								1. "서비스"라 함은 회사가 운영하는 사이트를 통해 개인이 구직, 교육 등의 목적으로 등록하는 자료를 DB화하여 각각의 목적에 맞게 분류 가공, 집계하여 정보를 제공하는 서비스와 사이트 에서 제공하는 모든 부대 서비스를말한다.<br>
								
								2. "회원"이라 함은 서비스를 이용하기 위하여 동 약관에 동의하고 "회사"와 이용계약을 체결하여 이용자ID를 부여 받은 "개인회원"을 말한다.<br>
								
								3. "이용자ID" 또는 "회원ID"라 함은 회원의 식별과 회원의 서비스 이용을 위하여 회원이 선정하고 "회사"가 부여하는 문자와 숫자의 조합을 말한다.<br>
								
								4. "비밀번호"라 함은 "회사"의 서비스를 이용하려는 사람이 이용자ID를 부여 받은 자와 동일인임을 확인하고 회원의 권익을 보호하기 위하여 회원이 선정한 문자와 숫자의 조합을 말한다.<br>
							</div>
						</div>
						
						<div class="content">
							<div class="content-title">제 3 조 (약관의 명시와 개정)</div>
							<div class="content-detail">
								이 약관에서 사용하는 용어의 정의는 아래와 같다.<br>
								
								1. "회사"는 이 약관의 내용과 상호, 영업소 소재지, 대표자의 성명, 사업자등록번호, 연락처 등을 이용자가 알 수 있도록 초기 화면에 게시하거나 기타의 방법으로 이용자에게 공지해야 한다.<br>
								
								2. "회사"는 약관의규제등에관한법률, 전기통신기본법, 전기통신사업법, 정보통신망이용촉진등에관한법률 등 관련법을 위배하지 않는 범위에서 이 약관을 개정할 수 있다.<br>
								
								3. "회사"가 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 그 개정약관의 적용일자 7일 전부터 적용일자 전일까지 공지한다. 단 "회원"의 권리, 의무에 중대한 영향을 주는 변경의 경우에는 적용일자 30일 전부터 공지하도록 한다.<br>
								
								4. "회원"은 변경된 약관에 대해 거부할 권리가 있다. "회원"은 변경된 약관이 공지된 지 15일 이내에 거부의사를 표명할 수 있다. "회원"이 거부하는 경우 본 서비스 제공자인 "회사"는 15일의 기간을 정하여 "이용자"에게사전 통지 후 당해 "회원"과의 계약을 해지할 수 있다. 만약, "회원"이 거부의사를 표시하지 않거나, 전항에 따라 시행일 이후에 "서비스"를 이용하는 경우에는 동의한 것으로 간주한다.<br>
							</div>
						</div>
						
					</div>
				</div>
			</div>
			
			<div class="check">
				<input type="checkbox" class="newWork-check"/>
				<span>개인정보 수집 및 이용안내에 동의합니다.</span>
			</div>
			
		</div>
		
		
		<div class="newWork-form">
			<div style="padding-left:5px;">
				<span>*</span>
				<span style="font-weight:700;">작업의뢰</span>
			</div>
			<div style="padding-right:5px;">
				<span>(</span>
				<span style="color:#E67E22;font-weight:700;">V</span>
				<span>)</span>
				<span>표는 필수값</span>
			</div>
		</div>
		
		
		<div class="newWork-title" style="margin-bottom:50px;">
			<table>
				<tbody>
					<tr>
						<td class="gray-bg">
							<span>제목</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td>
							<input type="text" style="width:50%;"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		
		<div class="newWork-form">
			<div style="padding-left:5px;">
				<span>*</span>
				<span style="font-weight:700;">담당자 및 연락처</span>
			</div>
		</div>
		
		
		<div class="newWork-employer" style="margin-bottom:50px;">
			<table>
				<tbody>
					<tr>
						<td class="gray-bg">
							<span>업체명</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td style="width:25%;">
							<input type="text" style="width:110%;"/>
						</td>
					</tr>
					
					<tr>
						<td class="gray-bg">
							<span>담당자</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td style="width:100px;">
							<input type="text"/>
						</td>
						
						<td class="gray-bg" style="border-top: 1px solid #99A3A4;">
							<span>휴대전화</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td style="border-top: 1px solid #99A3A4;">
							<input type="text" style="width:50px;"/>  -
							<input type="text" style="width:50px;"/>  -
							<input type="text" style="width:50px;"/>
						</td>
					</tr>
					
					
					<tr>
						<td class="gray-bg">
							<span>전화번호</span>
						</td>
						<td style="width:25%;">
							<input type="text" style="width:50px;"/>  -
							<input type="text" style="width:50px;"/>  -
							<input type="text" style="width:50px;"/>
						</td>
						
						<td class="gray-bg" style="border-top: 1px solid #99A3A4;">
							<span>이메일</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td style="border-top: 1px solid #99A3A4;">
							<input type="text" style="width:70%;"/>
						</td>
					</tr>
					
					
				</tbody>
			</table>
		</div>
		
		
		<div class="newWork-form">
			<div style="padding-left:5px;">
				<span>*</span>
				<span style="font-weight:700;">작업의뢰내용</span>
			</div>
		</div>
		
		<div class="editor">
			<textarea rows="10" cols="50" id="sEditor" name="sEditor" style="width:100%;"></textarea>
		</div>
		
		     
		<div style="display:flex;justify-content:center;margin-bottom:80px;margin-top:30px;">
			<button class="newWork-submit">확인</button>		
		</div>

		
	</div>
	
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	
	
	<script type="text/javascript">
		var oEditors = [];
		$(function(){
		      nhn.husky.EZCreator.createInIFrame({
		          oAppRef: oEditors,
		          elPlaceHolder: "sEditor", //textarea에서 지정한 id와 일치해야 합니다. 
		          //SmartEditor2Skin.html 파일이 존재하는 경로
		          sSkinURI: "./resources/dist/SmartEditor2Skin.html",  
		          htParams : {
		              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		              bUseToolbar : true,             
		              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		              bUseVerticalResizer : true,     
		              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		              bUseModeChanger : true
		          }, 
		          
		      });
	
		});
		 
		 
		 
	</script>
				

</body>
</html>