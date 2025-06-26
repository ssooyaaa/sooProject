$(document).ready(function() {
	
	$('.skip-btn').on('click',function(){
		location.href='./tips-transport';
	});
	
	$('.chat-summit').on('click',function(){
		
		var text = $('.chat-text').val();
		
		alert('응답이 나올때까지 잠시만 기다려주세요!');
		$('.chat-wait').show();
		
		
		$.ajax({
		    url: "./chatGPT",
		    type:'get',
		    data:{text:text},
		    dataType:'text', // 응답 값의 데이터 타입을 text로 설정
		    success: function(response) {
		    	$('.chat-wait').hide();
		    	console.log(response);
		    	
		    	$('.chat-reply').append(
		    	    `<div>질문 : ${text}<div>
		    	    <div style="margin-bottom:80px">${response}</div>`	
		    	 );
		    	$('.chat-text').val('');
		    },
		    error: function(xhr, status, error) {
		        console.log(error);
		    }
		});
	});
	
	
});

          