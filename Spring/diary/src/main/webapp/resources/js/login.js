$(document).ready(function(){
	//회원가입
	
	$('#addLogin-submit').click(function(){
		
		var id = $('#id').val();
		var pw = $('#pw').val();
		var pwCheck = $('#pwCheck').val();
		var nickname = $('#nickname').val();
		var addLoginCheck = $('#addLoginCheckbox').is(':checked');
		
		if(id.length>0 &&
			pw.length>0 &&
			pwCheck.length>0 &&
			nickname.length>0){
			
			if(pw.length>8 &&
				pw.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)){
				//pw 기입 확인
				
					if(addLoginCheck==true){
					//약관체크
						if(pw == pwCheck){
							//최종 가입	
							$.ajax({
								url:'./user/addUser',
								type:'get',
								data:{
									'id':id,
									'pw':pw,
									'nickname':nickname
								},
								success:function(res){
									console.log(addLoginCheck);
									if(res=='ok'){
										alert('회원가입이 완료되었습니다. 로그인 후 사용해주세요.');
										location.replace("./login");
									}else if(res=='noNick'){
										alert('기존에 존재하는 닉네임입니다.')
									}else if(res=='dup'){
										alert('기존에 존재하는 ID입니다.');
									}
									
									
								},
								error:function(){}
							});
							
						}else{
							alert('비밀번호 불일치합니다.');
						};
					}else{
						alert('약관에 동의해주세요.');
					}
				
									
			}else{
				//pw 기입 부족
				alert('비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.');
			};	
			
		}else{
			alert('모든 정보를 기입해주세요');
		}
	});
});


$(document).ready(function(){
	//로그인
	
	$('#login-submit-btn').click(function(){
		
		var id = $('#loginId').val();
		var pw = $('#loginPw').val();
		var loginCheckbox = $('#loginCheckbox').is(':checked');
		
		$.ajax({
			url:'./user/getUserForLogin',
			type:'post',
			data:{
				'id':id,
				'pw':pw,
				'loginCheckbox':loginCheckbox
			},
			success:function(user){
				console.log(loginCheckbox);
				if(user != ''){
					alert(user.nickname+'님 반갑습니다.');	
					location.replace('./');
				}else{
					alert('가입된 회원이 없습니다.');
				}
			},
			error:function(){}
		});
	});
});


$(document).ready(function(){
	//로그아웃
	
	$('#logout-btn').click(function(){
		
		var con = confirm('정말로 로그아웃하시겠습니까?');
		
		if(con==true){
			$.ajax({
				url:'./user/logout',
				type:'post',
				data:{},
				success:function(res){
					if(res=='ok'){
						alert('로그아웃 되었습니다.')
						location.replace('./');
					}
				},
				error:function(){}
			});
		}
		
	});
});


$(document).ready(function(){
	//회원탈퇴
	
	$('#log-del-btn').click(function(){
		
		var con = confirm('정말로 계정 삭제하시겠습니까?');
		
		if(con==true){
			$.ajax({
				url:'./user/deleteUser',
				type:'post',
				data:{},
				success:function(){
					alert('탈퇴되었습니다.');
					location.replace('./');
				},
				error:function(){}
			});
		}
		
	});
});
