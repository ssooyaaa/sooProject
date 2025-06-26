$(document).ready(function(){
	
	//회원가입
	addAdmin();
	
	//로그아웃
	logoutAdmin();
	
	//로그인
	loginAdmin();
	
	//계정탈퇴
	$('#log-del-btn').click(function(){
		alert('관리자는 탈퇴불가능합니다.');
	})
});


//회원가입
function addAdmin(){
$('#addLogin-submit').click(function(){
		
		var id = $('#id').val();
		var pw = $('#pw').val();
		var pwCheck = $('#pwCheck').val();
		var nickname = $('#nickname').val();
		
		if(id.length>0 &&
			pw.length>0 &&
			pwCheck.length>0 &&
			nickname.length>0){
			
			if(pw.length>8 &&
				pw.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)){
				//pw 기입 확인
				
				if(pw == pwCheck){
					//최종 가입	
					$.ajax({
						url:'./admin/addAdmin',
						type:'get',
						data:{
							'id':id,
							'pw':pw,
							'nickname':nickname
						},
						success:function(res){
							if(res=='ok'){
								alert('회원가입이 완료되었습니다. 로그인 후 사용해주세요.');
								location.replace("./login");
							}else if(res=='dup'){
								alert('접근하실 수 없는 계정입니다.');
							}
							
							
						},
						error:function(){}
					});
					
				}else{
					alert('비밀번호 불일치합니다.');
				};
									
			}else{
				//pw 기입 부족
				alert('비밀번호는 영문(대소문자구분),숫자,특수문자(~!@#$%^&*()-_? 만 허용)를 혼용하여 8~16자를 입력해주세요.');
			};	
			
		}else{
			alert('모든 정보를 기입해주세요');
		}
	});
}


//로그아웃
function logoutAdmin(){
	$('#logout-btn').click(function(){
		
		var con = confirm('정말로 로그아웃하시겠습니까?');
		
		if(con==true){
			$.ajax({
				url:'./admin/logout',
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
}


//로그인
function loginAdmin(){
	$(document).ready(function(){
		
		$('#login-submit-btn').click(function(){
			
			var id = $('#loginId').val();
			var pw = $('#loginPw').val();
			var loginCheckbox = $('#loginCheckbox').is(':checked');
			
			$.ajax({
				url:'./admin/getAdminForLogin',
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
						alert('관리자가 아닙니다.');
					}
				},
				error:function(){}
			});
		});
	});
}
