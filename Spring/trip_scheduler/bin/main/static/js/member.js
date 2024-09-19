$(document).ready(function(){
	
	//홈으로 이동
	$('.go-home').click(function(){
		location.href='./';
	});
	
	
	//친구 찾기
	findUser();
	
	//친구 찾기-요청
	requestFollow();
	
	//친구리스트-승인O
	getFollow();
	
	//친구삭제
	delFollow();
	
	//친구요청리스트-대기중
	requestedFollowList();
	
	//친구요청-수락
	acceptMember();
	
	//친구요청-거절
	rejectMember();
	
});

//친구 찾기
function findUser(){
	
	$('#search-member').click(function(){
		$('.request-item').empty();
		$('.request-item').hide();
		var id = $('#search-by-id').val();
		
		$.ajax({
			url:'./user/getUserById',
			type:'get',
			data:{'id':id},
			success:function(item){
				if(item==''){
					$('.request-member').append(
						`<div class="request-item">
							<span class="request-none">존재하는 회원이 없습니다.</span>
						</div>`
					);
					$('.request-item').show();
				}else{
					$('.request-member').append(
						`<div class="request-item">
							<span>${item.id}</span>
							<span id="request-idx" style="display:none">${item.user_idx}</span>
							<button class="request-btn">요청</button>
						</div>`
					);
					$('.request-item').show();
				}
			}
		});
		$('.request-item').show();
		
	});
	
}


//친구 찾기-요청
function requestFollow(){
	
	$(document).on('click','.request-btn',function(){
		
		var user_idx_2 = $('#request-idx').text();
		
		$.ajax({
			url:'./follow/requestedFollow',
			type:'get',
			data:{
				'user_idx':user_idx_2
			},
			success:function(user){
				if(user==null ||user==''){
					
					$.ajax({
						url:'./follow/requestFollow',
						type:'post',
						data:{'user_idx_2':user_idx_2},
						success:function(res){
							if(res=='ok'){
								alert('요청되었습니다.');
								location.replace('./memberList');
							}else{
								alert('요청에 실패했습니다.');
							}
						}
					});
					
				}else{
					alert('이미 친구리스트에 존재하거나, 승인 요청을 기다리는 중입니다.');
				}
			}
		});
		
		
		
	});
}


//친구리스트-승인O
function getFollow(){
	
	$.ajax({
		url:'./follow/getFollow',
		type:'get',
		data:{},
		success:function(list){
			
			if(list.length==0){
				$('.member-list').append(
					`<div class="member-item">
						<span style="text-align:center;margin-left:20px;">아직 등록된 친구가 없습니다.</span>
					</div>`
				);
			}else{
				$.each(list,function(index,item){
					
					$('.member-list').append(
						`<div class="member-item">
							<span>${item.id}</span>
							<span style="display:none;">${item.user_idx}</span>
							<button class="del-member">삭제</button>
						</div>`
					);
					
				});
			}
			
			
		}
	});
}


//친구삭제
function delFollow(){
	$(document).on('click','.del-member',function(){
		
		var children = $(this).parent().children();
		var user_idx = children.eq(1).text();
		var id = children.eq(0).text();
		
		
		var con = confirm(id+'를 정말로 삭제하시겠습니까?');
		
		if(con==true){
			$.ajax({
				url:'./follow/delFollow',
				type:'post',
				data:{'user_idx_1':user_idx},
				success:function(res){
					if(res=='ok'){
						location.replace('./memberList');
					}
				},
				error:function(err){}
			});
		}
		
		
	});
}


//친구요청리스트-대기중
function requestedFollowList(){
	$.ajax({
		url:'./follow/requestedFollowList',
		type:'get',
		data:{},
		success:function(list){
			
			$.each(list,function(index,item){
				$('.alarm-list').append(
					`<div class="alarm-item">
						<span id="alarm-id">${item.id}</span>
						<span id="alarm-user-idx" style="display:none;">${item.user_idx}</span>
						<button id="accept-member" style="background:#81CA6D;">수락</button>
						<button id="reject-member" style="background:#FA5945;">거절</button>
					</div>`
				);
			});
			
		},
		error:function(err){}
	});
}


//친구요청-수락
function acceptMember(){
	
	$(document).on('click','#accept-member',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		
		var user_idx = children.eq(1).text();
		
		$.ajax({
			url:'./follow/acceptFollow',
			type:'post',
			data:{'user_idx_1':user_idx},
			success:function(res){
				if(res=='ok'){
					location.replace('./memberAlarm');
				}
			},
			error:function(err){}
		});
	});
	
}

//친구요청-거절
function rejectMember(){
	
$(document).on('click','#reject-member',function(){
		
		var con = confirm('정말로 거절하시겠습니까?');
			
		var parent = $(this).parent();
		var children = parent.children();
		
		var user_idx = children.eq(1).text();
		
		
		if(con==true){
			$.ajax({
				url:'./follow/rejectFollow',
				type:'post',
				data:{'user_idx_1':user_idx},
				success:function(res){
					if(res=='ok'){
						location.replace('./memberAlarm');
					}
				}
			});
		}
		
		
		
	});
	
}