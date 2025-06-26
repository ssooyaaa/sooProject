$(document).ready(function(){
	
	//tips 버튼 클릭
	$('.tips-menu-submenu').on('click',function() {
		
		var page = $(this).data('tips');
		
		if(page=='transport'){
			location.href='./tips';
			
		}else if(page=='accomodation'){
			location.href='./tips-accomodation';
			
		}else if(page=='eat'){
			location.href='./tips-eat';
			
		}else{
			location.href='./tips-etc';
		};
	});
	
});