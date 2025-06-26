$(document).ready(function(){
	
	//회원가입하기-클릭
	$('.go-membership').click(function(){
		location.href='./membership';
	});
		
	//로그인
	login();
	
	//아이디/비밀번호 찾기
	$('.search-id-pw').click(function(){
		location.href='./findMember';
	});
	
});


//로그인
function login(){
	
	$('.login-box-btn').click(function(){
		
		var id = $('#input-id').val();
		var pw = $('#input-pw').val();
		
		$.ajax({
			url:'./user/login',
			type:'get',
			data:{
				'id':id,
				'pw':pw
			},
			success:function(user){
				if(user!=''){
					alert(user.name+'님 반갑습니다.');
					location.replace('./');
				}else{
					alert('죄송합니다. 입력하신 정보가 존재하지 않습니다.');
				}
			},
			error:function(){}
		});
	});
};


