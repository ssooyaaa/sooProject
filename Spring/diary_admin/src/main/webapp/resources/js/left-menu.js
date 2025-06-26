$(document).ready(function(){
	
	$('.tips-subname').on('click',function(){
		
		var page = $(this).data('comment');
		
		if(page=='transport') {
			location.href='./com_transport';
		}else if(page=='accomodation'){
			location.href='./com_accomodation';
		}else if(page=='eat'){
			location.href='./com_eat';
		}else if(page=='etc'){
			location.href='./com_etc';
		}else if(page=='domestic'){
			location.href='./com_domestic';
		}else{
			location.href='./com_abroad';
		}
	});
	
});