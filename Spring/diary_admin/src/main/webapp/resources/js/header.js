$(document).ready(function(){
	
	$('.menu-item').on('click',function() {
		
		var page = $(this).data('menu');
		
		if(page=='home'){
			location.href='./';
		}else if(page=='tips'){
			location.href='./tips';
		}else if(page=='tips_report'){
			location.href='./tips_report'
		}else if(page=='photo'){
			location.href='./photo';
		}else if(page=='photo_report'){
			location.href='./photo_report'
		}else{
			location.href='./com_transport'
		};
	});
	
	$('.user-icon').on('click',function() {
		//로그인 창 이동
		location.href='./login';
		
	});
	
});