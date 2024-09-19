$(document).ready(function(){
	
	var user_idx = $('#map-user-idx').val();
	var kakao_idx = $('#map-kakao-idx').val();
	
	if(user_idx==null || user_idx==''){
		user_idx = kakao_idx;
	}
	
	//메인 이름 -> 홈화면으로 이동
	$('.main-name').click(function(){
		location.href='./';
	});
	
	
	//홈
	$('.home-btn').click(function(){
		location.href='./';
	});
	
	
	//로그인X-친구관리-로그인 후 사용가능 알림
	$('#plus-member-btn').click(function(){
		alert('로그인 후 사용가능합니다.');
		location.href='./login';
	});

	
	//친구관리-메뉴 보이기
	$('#member-down').click(function(){
		$('.member-menu').show();
		$('#member-down').hide();
		$('#member-up').show();
	});
	
	
	//친구관리-메뉴접기
	$('#member-up').click(function(){
		$('.member-menu').hide();
		$('#member-up').hide();
		$('#member-down').show();
	});
	
	
	//친구리스트
	$('.member-list').click(function(){
		location.href='./memberList';
	});
	
	
	
	//친구알림
	$('.member-accept').click(function(){
		location.href='./memberAlarm';
	});
	
	
	
	//로그인X-일정리스트
	$('#schedule-list-btn').click(function(){
		alert('로그인 후 사용가능합니다.');
		location.href='./login';
	});
	
	//로그인O-일정리스트
	$('#go-schedule-list-btn').click(function(){
		location.href="./allList?user_idx="+user_idx;
	});
	
	
	
	//로그인X-여행경비
	$('#expense-list-btn').click(function(){
		alert('로그인 후 사용가능합니다.');
		location.href='./login';
	});
	
	//로그인O-여행경비
	$('#go-expense-list-btn').click(function(){
		location.href="./tripExpenses?user_idx="+user_idx;
	});
	
	
	
	
	//로그인
	$('.side-login-btn').click(function(){
		location.href='./login';
	});
	
	
	//로그아웃
	$('#logout-btn').click(function(){
		
		$.ajax({
			url:'./user/logout',
			type:'post',
			data:{},
			success:function(res){
				if(res=='ok'){
					location.replace('./');
				}
			},
			error:function(){}
		});
	});
	
});


//사이드메뉴-보이기
function showSide(){
	$('.login-side').css("visibility","visible");
	
	//친구알림 카운트
	$.ajax({
		url:'./follow/getCountAlarm',
		type:'get',
		data:{},
		success:function(count){
			if(count!=0){
				$('.member-accept').append(
					`<span class="alarm-count">${count}</span>`
				);
			}
		}
	});
	
}


//사이드메뉴-사라지기
function hideSide(){
	$('.login-side').css("visibility","hidden");
}