
$(document).ready(function(){
	
	$('.menu-item').on('click',function() {
		
		var page = $(this).data('menu');
		
		if(page=='home'){
			location.href='./';
		}else if(page=='mydiary'){
			location.href='./mydiary';
		}else if(page=='tips'){
			
			location.href='./tips';
		}else{
			location.href='./photo';
		};
	});
	
	$('.user-icon').on('click',function() {
		//로그인 창 이동
		location.href='./login';
		
	});
	
});

