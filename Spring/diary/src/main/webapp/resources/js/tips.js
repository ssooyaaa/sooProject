
$(document).ready(function(){
	
	//tips 버튼 클릭
	$('.tips-menu-submenu').on('click',function() {
		
		var page = $(this).data('tips');
		
		if(page=='transport'){
			
			location.href='./tips-transport?nation='
			
		}else if(page=='accomodation'){
			location.href='./tips-accomodation?nation='+$('#search').val();
			
		}else if(page=='eat'){
			location.href='./tips-eat?nation='+$('#search').val();
			
		}else{
			location.href='./tips-etc?nation='+$('#search').val();
		};
	});
	
});
