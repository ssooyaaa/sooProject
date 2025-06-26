$(document).ready(function(){
	
	//아이디 찾기
	searchId();
	
	//비밀번호 찾기
	searchPw();
	
});


function searchId(){
	
	$('#name-email-btn').click(function(){
		
		var name = $('#id-name').val();
		var email = $('#id-email').val();
		
		$.ajax({
			url:'./user/searchId',
			type:'get',
			data:{
				'name':name,
				'email':email
			},
			success:function(id){
				if(id==''){
					alert('일치하는 회원정보가 존재하지 않습니다.');
				}else{
					alert('id는 '+id+'입니다.');
				}
			},
			error:function(){}
		});
	});
}


function searchPw(){
	
	$('#id-name-btn').click(function(){
		
		var id = $('#pw-id').val();
		var name = $('#pw-name').val();
		var email = $('#pw-email').val();
		
		$.ajax({
			url:'./user/searchPw',
			type:'get',
			data:{
				'id':id,
				'name':name,
				'email':email
			},
			success:function(pw){
				if(pw==''){
					alert('일치하는 회원정보가 존재하지 않습니다.');
				}else{
					var newPw = prompt('새비밀번호를 입력해주세요');
					updatePw(newPw);
				}
			},
			error:function(){}
		});
	});
}


function updatePw(newPw){
	
	var id = $('#pw-id').val();
	var name = $('#pw-name').val();
	var email = $('#pw-email').val();
	
	$.ajax({
		url:'./user/updatePw',
		type:'post',
		data:{
			'id':id,
			'name':name,
			'email':email,
			'pw':newPw
		},
		success:function(res){
			if(res=='ok'){
				alert('변경되었습니다.');
				location.replace('./login');
			}
		},
		error:function(){}
	});
	
}