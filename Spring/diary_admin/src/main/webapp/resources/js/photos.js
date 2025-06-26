$(document).ready(function(){
	
	$('.photo-title-sub').on('click',function() {
		
		var page = $(this).data('photos');
		
		if(page=='domestic'){
			location.href='./photo';
		} else{
			location.href='./photo_abroad';
		};
	});
	
});