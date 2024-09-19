$(document).ready(function(){

	//다음버튼
	$('.join-next').click(function(){
		
		var must1 = $('#must1').is(':checked');
		var must2 = $('#must2').is(':checked');
		
		if(must1==true && must2==true){
			$('.join-container').hide();
			$('.next-join-container').show();
		}else{
			alert('이용약관을 확인해주세요.');
		}
		
	});
	
	
	//홈화면이동
	$('.home-name-next').click(function(){
		location.replace('./');
	});
	
	//가입전 체크
	checkMember();
	
});


//필수확인-다음버튼 색상 변경
function nextColor(){
	var must1 = $('#must1').is(':checked');
	var must2 = $('#must2').is(':checked');
	
	if(must1==true && must2==true){
		$('.join-next').css('background','var(--color-main)');
	}
}

//전체동의/해체
function allCheck(){
	var allCheck = $('#allCheck').is(':checked');
	
	if(allCheck==true){
		$('input:checkbox[name=join-check]').prop('checked',true);
		nextColor();
	}else{
		$('input:checkbox[name=join-check]').prop('checked',false);
		$('.join-next').css('background','#E0DDDD');
	}
}


//가입전체크
function checkMember(){
	
	var inputId = '';
	var inputPw = '';
	var inputEmail = '';
	var inputNick = '';
	
	//id체크
	$('#join-id').focusout(function(){
		var id = $('#join-id').val();
		
		if(id.length==0){
			$('#least-id').hide();
			$('#same-id').hide();
			$('#ok-id').hide();
			$('#none-id').show();
			
		}else if(id.length>0 && id.length<8){
			$('#none-id').hide();
			$('#same-id').hide();
			$('#ok-id').hide();
			$('#least-id').show();
		}else{
			
			$.ajax({
				url:'./user/getUserById',
				type:'get',
				data:{'id':id},
				success:function(user){
					if(user==null||user==''){
						$('#none-id').hide();
						$('#same-id').hide();
						$('#least-id').hide();
						$('#ok-id').show();
						
						inputId = $('#join-id').val();
					}else{
						$('#none-id').hide();
						$('#least-id').hide();
						$('#ok-id').hide();
						$('#same-id').show();
					}
				}
			});
			
		}
	});
	
	
	//pw체크
	$('#join-pw').focusout(function(){
		var pw = $('#join-pw').val();
				
		if(pw.length==0){
			$('#least-pw').hide();
			$('#comb-pw').hide();
			$('#ok-pw').hide();
			$('#none-pw').show();
		}else if(pw.length>0 && pw.length<8){
			$('#none-pw').hide();
			$('#comb-pw').hide();
			$('#ok-pw').hide();
			$('#least-pw').show();
		}else if(pw.length>=8 && pw.match(/([a-zA-Z].*[0-9])|([0-9].*[a-zA-Z])/)){
			$('#none-pw').hide();
			$('#least-pw').hide();
			$('#comb-pw').hide();
			$('#ok-pw').show();
			
			//pw더블체크
			$('#join-re-pw').focusout(function(){
				var rePw = $('#join-re-pw').val();
				
				if(pw!=rePw){
					$('#ok-re-pw').hide();
					$('#no-same-pw').show();
				}else{
					$('#no-same-pw').hide();
					$('#ok-re-pw').show();
					
					inputPw = $('#join-pw').val();
				}
			});
			
		}else{
			$('#none-pw').hide();
			$('#least-pw').hide();
			$('#ok-pw').hide();
			$('#comb-pw').show();
		}
	});
	
	
	//email체크
	$('#join-email').focusout(function(){
		var email = $('#join-email').val();
		
		if(email.length==0){
			$('#not-correct-email').hide();
			$('#ok-email').hide();
			$('#none-email').show();
		}else if(email.match(/^[-!#$%& amp;'*+./0-9=?A-Z^_a-z{|}~]+@[-!#$%&'*+/0-9=?A-Z^_a-z{|}~]+.[-!#$%& amp;'*+./0-9=?A-Z^_a-z{|}~]+$/)){
			$('#none-email').hide();
			$('#not-correct-email').hide();
			$('#ok-email').show();
			
			inputEmail = $('#join-email').val();
		}else{
			$('#none-email').hide();
			$('#ok-email').hide();
			$('#not-correct-email').show();
		}
	});
	
	
	//닉네임체크
	$('#join-nickname').focusout(function(){
		var nickname = $('#join-nickname').val();
		
		if(nickname.length==0){
			$('#same-nickname').hide();
			$('#ok-nickname').hide();
			$('#none-nickname').show();
		}else{
			
			$.ajax({
				url:'./user/getUserByNick',
				type:'get',
				data:{'nick':nickname},
				success:function(userNick){
					if(userNick==null||userNick==''){
						$('#none-nickname').hide();
						$('#same-nickname').hide();
						$('#ok-nickname').show();
						
						inputNick = $('#join-nickname').val();
					}else{
						$('#none-nickname').hide();
						$('#ok-nickname').hide();
						$('#same-nickname').show();
					}
				}
			});
			
					
		}
	});
	
	
	$('.join-btn').click(function(){
		
		if(inputId=='' || inputPw=='' || inputEmail=='' || inputNick==''){
			alert('모든 항목을 기입해주세요.');
		}else{
			
			$.ajax({
				url:'./user/addUser',
				type:'post',
				data:{
					'id':inputId,
					'pw':inputPw,
					'email':inputEmail,
					'nickname':inputNick
				},
				success:function(res){
					if(res=='ok'){
						alert('회원가입이 완료되었습니다. 로그인 후 사용해주세요.');
						location.replace('./login');
					}else{
						alert('회원가입에 실패했습니다.')
					}
				},
				error:function(){}
			});
			
		}
		
	});
	
	
	
}
