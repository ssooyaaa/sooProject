$(document).ready(function(){
	
	//로그인버튼
	$('.login-btn').click(function(){
		location.href='./login';
	});
	
	
	//회원가입버튼
	$('.membership-btn').click(function(){
		location.href='./membership';
	});
	
	
	//로그아웃
	logout();
	
	
	//홈로고
	$('.home-logo').click(function(){
		location.href='./';
	});
	
	
	//프로젝트 등록
	$('.add-project').click(function(){
		location.href='./newWork';
	});
	
	
	//프로젝트검색
	$('.search-project').click(function(){
		location.href='./projectList'
	});
	
	//프리랜서 등록
	$('.add-member').click(function(){
		var loginUserIdx = $('#map-user-idx').val();
		
		if(loginUserIdx==''){
			alert('죄송합니다. 프리랜서회원만 이용할 수 있는 서비스입니다.');
		}else{
			location.href='./registerFreelancer';
		}
		
	});
	
	//정규직 의뢰
	$('.commissioned').click(function(){
		location.href='./commission'
	});
});


//로그아웃
function logout(){
	$('.logout-btn').click(function(){
		
		var con = confirm('정말로 로그아웃하시겠습니까?');
		
		if(con==true){
			$.ajax({
				url:'./user/logout',
				type:'post',
				data:{},
				success:function(res){
					if(res=='ok'){
						alert('로그아웃 되었습니다.');
						location.replace('./');
					}
				},
				error:function(){}
			});
		}
	});
}