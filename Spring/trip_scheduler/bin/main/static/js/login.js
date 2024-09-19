$(document).ready(function(){
	
	//홈화면이동
	$('.home-name').click(function(){
		location.href='./';
	});
	
	//비밀번호 재설정 버튼
	$('#update-pw-btn').click(function(){
		location.href='./pwReset';
	});
	
	//회원가입버튼
	$('#membership-btn').click(function(){
		location.href='./join';
	});
	
	
	//로그인하기
	login();
	
	
});


//로그인하기
function login(){
	
	$('.login-btn').click(function(){
		
		var id = $('.login-id').val();
		var pw = $('.login-pw').val();
				
		$.ajax({
			url:'./user/login',
			type:'get',
			data:{'id':id,
				'pw':pw},
			success:function(user){
				if(user==''){
					alert('가입된 회원이 없습니다.');
				}else{
					alert(user.nickname+'님 반갑습니다.');
					location.href='./';
				}
			},
			error:function(){}
		});
	});
};

