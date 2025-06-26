<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MembershipForm</title>

	<!-- 우편번호 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
	<script src="./resources/js/membership.js"></script>
	
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" 
	rel="stylesheet" 
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" 
	crossorigin="anonymous">
		
	
	<link rel="stylesheet"  href="./resources/css/all.min.css"/>
	<link rel="stylesheet" href="./resources/css/app.css"/>
	<link rel="stylesheet" href="./resources/css/membership.css"/>
	
</head>
<body>

	<%@ include file="/WEB-INF/views/include/header.jsp" %>
	
	<%@ include file="/WEB-INF/views/include/banner.jsp" %>
	
	
	<div class="membership-container">
		<div class="membership-title" style="display:flex;align-items:center;margin-bottom:20px;">
			<span style="background:#112579;width:20px;height:20px;margin-right:10px;"></span>
			<span style="font-size:23px;font-weight:700;">프리랜서회원가입</span>
		</div>
		
		<div class="membership-form-title">
			<div style="padding-left:5px;">
				<span>*</span>
				<span style="font-weight:700;">회원정보</span>
			</div>
			<div style="padding-right:5px;">
				<span>(</span>
				<span style="color:#E67E22;font-weight:700;">V</span>
				<span>)</span>
				<span>표는 필수값</span>
			</div>
		</div>
		
		<div class="membership-form">
			<table>
				<tbody>
					<tr>
						<td class="gray-bg">
							<span>이름</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td>
							<input type="text" id="user-name"/>
							<span style="color:#112579;font-size:13px;">+최대 50자까지 입력가능</span>
						</td>
					</tr>
					
					<tr>
						<td class="gray-bg">
							<span>아이디</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td>
							<input type="text" id="user-id"/>
							<button class="double-check-id" style="font-size:13px;border-radius:5px;border:1px solid #99A3A4;">중복확인</button>
							<span id="id-info" style="color:#112579;font-size:13px;">+영문자로 시작하는 4~15자의 영문소문자,숫자조합</span>
							
							<span id="id-ok" style="display:none;color:green;font-size:13px;">사용 가능한 아이디입니다.</span>
							<span id="id-no" style="display:none;color:red;font-size:13px;">사용 불가능한 아이디입니다.</span>
						</td>
					</tr>
					
					<tr>
						<td class="gray-bg">
							<span>비밀번호</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td>
							<input type="password" id="user-pw"/>
							<span style="color:#112579;font-size:13px;">+4~15자의 영문자, 숫자조합</span>
						</td>
					</tr>
					
					<tr>
						<td class="gray-bg">
							<span>비밀번호확인</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td>
							<input type="password" id="user-pw-doubleCheck"/>
						</td>
					</tr>
					
					<tr>
						<td class="gray-bg">
							<span>이메일</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td>
							<input type="text" id="user-email" style="width:30%;"/>
						</td>
					</tr>
					
					<tr>
						<td class="gray-bg">
							<span>전화번호</span>
						</td>
						<td>
							<input type="text" id="user-phoneNum-first" style="width:70px;"/>  -
							<input type="text" id="user-phoneNum-second" style="width:70px;"/>  -
							<input type="text" id="user-phoneNum-last" style="width:70px;"/>
						</td>
					</tr>
					
					<tr>
						<td class="gray-bg">
							<span>주소</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td style="display:flex;flex-direction:column;padding:5px 0;">
							<div style="margin-bottom:3px;">
								<input type="text" id="user-zipcode" style="width:70px;"/>
								<button class="zipcode-btn" style="font-size:13px;border-radius:5px;border:1px solid #99A3A4;">우편번호찾기</button>
							</div>
							
							<input type="text" id="user-address" style="width:50%;margin-bottom:3px;"/>
							
							<div>
								<input type="text" id="user-address-more" style="width:50%;"/>
								<span style="color:#112579;font-size:13px;">+나머지 상세주소</span>
							</div>
							
						</td>
					</tr>
					
					<tr>
						<td class="gray-bg">
							<span>SMS수신설정</span>
							<span style="color:#E67E22;font-weight:700;padding-left:0;">V</span>
						</td>
						<td>
							<input type="radio" value="yes" id="mail-ok" name="mail" checked/>
							<label for="mail-ok">수신함</label>
							<input type="radio" value="no" id="mail-no" name="mail"/>
							<label for="mail-no">수신안함</label>
						</td>
					</tr>
					
					
					
				</tbody>
			</table>
		</div>
		
		
		<div style="display:flex;justify-content:center;margin-bottom:80px;margin-top:30px;">
			<button class="membership-submit">확인</button>		
		</div>
		
	</div>
	
	
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>