$(document).ready(function(){
	
	var user_idx = $('#map-user-idx').val();
	var kakao_idx = $('#map-kakao-idx').val();
	

	if(user_idx==null || user_idx==''){
		user_idx = kakao_idx;
	}
	
	$('#newList').click(function(){
		location.href='./newTitle';
	});
	
	$('#allList').click(function(){
		location.href='./allList?user_idx='+user_idx;
	});
	
	$('#tripExpenses').click(function(){
		location.href='./tripExpenses?user_idx='+user_idx;
	});
	
});
