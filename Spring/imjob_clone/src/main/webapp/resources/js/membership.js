$(document).ready(function(){
	
	//이용약관-다음버튼
	$('.membership-next-btn').click(function(){
		
		var termCheck = $('#term-check').is(':checked');
		var personalCheck = $('#personal-info-check').is(':checked');
		
		if(termCheck==true && personalCheck==true){
			location.href='./membershipForm';
		}else{
			alert('이용약관에 동의하셔야 합니다.');
		}
		
	});
	
	//주소찾기
	execDaumPostcode();
	
	//아이디 중복체크
	checkId();
	
	//로그인
	addUser();
	
});


//주소 찾기
function execDaumPostcode() {
	
	$('.zipcode-btn').click(function(){
		daum.postcode.load(function(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분
	              $("#user-zipcode").val(data.zonecode);
	              $("#user-address").val(data.roadAddress);
	            }
	        }).open();
	    });
	});
    
}


//아이디 중복체크
function checkId(){
	
	$('.double-check-id').click(function(){
		$('#id-ok').hide();
		$('#id-no').hide();
		
		var id = $('#user-id').val();
		
		if(id==''){
			
			alert('아이디를 입력해주세요.');
		}else{
			if(id.length>=4 && id.length<=15){
				
				$.ajax({
					url:'./user/idCheck',
					type:'get',
					data:{'id':id},
					success:function(res){
						if(res=='ok'){
							$('.double-check-id').hide();
							$('#id-info').hide();
							$('#id-ok').show();
						}else{
							$('#id-info').hide();
							$('#id-no').show();
						}
					},
					error:function(){}
				});
			}else{
				alert('아이디를 올바르게 입력해주세요.');
			}
			
		}
		
	});
	
};


//로그인
function addUser(){
	
	$('.membership-submit').click(function(){
		
		var name = $('#user-name').val();
		var id = $('#user-id').val();
		var pw = $('#user-pw').val();
		var checkPw = $('#user-pw-doubleCheck').val();
		var email = $('#user-email').val();
		var phone_number = $('#user-phoneNum-first').val()+$('#user-phoneNum-second').val()+$('#user-phoneNum-last').val();
		var zipcode = $('#user-zipcode').val();
		var address = $('#user-address').val();
		var address_more = $('#user-address-more').val();
		var sms = $('input:radio[name="mail"]:checked').val();
		
		//이름 체크
		if(name.length>0 && name.length<=50){
			//아이디체크
			if($('#id-ok').css('display')!='none'){
				//pw체크
				if(pw.length>=4 && pw.length<=15 &&
					pw.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-zA-Z0-9])/)){
					//pw 중복확인
					if(pw==checkPw){
						//email체크
						if(email.length>0){
							//주소체크
							if(zipcode.length>0 && address.length>0){
								//최종가입
								$.ajax({
									url:'./user/addUser',
									type:'post',
									data:{
										'name':name,
										'id':id,
										'pw':pw,
										'email':email,
										'phone_number':phone_number,
										'zipcode':zipcode,
										'address':address,
										'address_more':address_more,
										'sms':sms
									},
									success:function(res){
										if(res='ok'){
											alert('회원가입이 완료되었습니다. 로그인 후 사용해주세요.');
											location.replace('./login');
										}else{
											alert('다시 기입해주세요');
										}
									},
									error:function(){}
								});
							}else{
								alert('주소를 기입해주세요.');
								$('#user-zipcode').focus();
							}
						}else{
							alert('이메일을 기입해주세요.');
							$('#user-email').focus();
						}
						
					}else{
						alert('비밀번호가 불일치합니다.');
						$('#user-pw').focus();
					}
				}else{
					alert('비밀번호는 4~15자의 영문자, 숫자조합만 가능합니다.');
					$('#user-pw').focus();
				}
			}else{
				alert('id중복 확인해주세요.');
				$('#user-id').focus();
			}
		}else{
			alert('이름을 올바르게 기입해주세요');
			$('#user-name').focus();
		}
		
	});
	
	
}