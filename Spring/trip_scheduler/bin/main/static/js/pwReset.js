$(document).ready(function(){
	
	//확인버튼
	resetCheckPw();
	
});


//확인버튼
function resetCheckPw(){
	
	var inputId = '';
	var inputEmail = '';
	
	$('#pwReset-id').focusout(function(){
		
		var id = $('#pwReset-id').val();
		
		if(id.length==0){
			$('#none-id').show();
		}else{
			$('#none-id').hide();
			inputId = id;
		}
	});
	
	$('#pwReset-email').focusout(function(){
		
		var email = $('#pwReset-email').val();
		
		if(email.length==0){
			$('#not-correct-email').hide();
			$('#none-email').show();
		}else if(email.match(/^[-!#$%& amp;'*+./0-9=?A-Z^_a-z{|}~]+@[-!#$%&'*+/0-9=?A-Z^_a-z{|}~]+.[-!#$%& amp;'*+./0-9=?A-Z^_a-z{|}~]+$/)){
			$('#not-correct-email').hide();
			$('#none-email').hide();
			
			inputEmail = email;
			
		}else{
			$('#none-email').hide();
			$('#not-correct-email').show();
		}
		
	});
	
	
	$('.pwResetBtn').click(function(){
		
		if(inputId=='' || inputEmail==''){
			alert('아이디와 이메일을 올바르게 적어주세요.');
		}else{
			
			$.ajax({
				url:'./user/getUserByIdAndEmail',
				type:'get',
				data:{
					'id':inputId,
					'email':inputEmail
				},
				success:function(res){
					
					if(res==null || res==''){
						alert("존재하는 회원이 없습니다.");
					}else{
						
						$('#pwReset1').hide();
						$('#pwReset2').show();
						
						//비밀번호 재등록
						$('.pwResetNewBtn').click(function(){
							
							var pw = $('#newPw').val();
							var rePw = $('#newRePw').val();
							
							if(pw.length>=8 && pw.match(/([a-zA-Z].*[0-9])|([0-9].*[a-zA-Z])/)){
								
								if(pw==rePw){
									
									$.ajax({
										url:'./user/resetPw',
										type:'post',
										data:{
											'id':inputId,
											'email':inputEmail,
											'pw':pw
										},
										success:function(res){
											if(res=="ok"){
												alert("비밀번호가 변경되었습니다. 재로그인 후 사용해주세요.")
												location.replace('./login');
											}else{
												alert("비밀번호 변경에 실패하였습니다.");
											}
										},
										error:function(err){}
									});
									
								}else{
									alert("비밀번호가 일치하지 않습니다.");
								}
								
							}else{
								alert('비밀번호를 올바르게 입력해주세요.');
							}
						});
						
					}
				}
			});
			
			
		}
		
	});
	
}
