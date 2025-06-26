
$(document).ready(function(){
	
	//전체페이지 리스트
	TransList();
	
	//삭제리스트
	delTrans();
	
	//검색 리스트
	schTrans();
	
	//수정
	updateTrans();
	
	
});


//전체 페이지 리스트
function TransList(){
	var totalPages=0;
	var countInOnePage=7;
	
	$.ajax({
		url:'./tips/getTransportCount',
		type:'get',
		data:{},
		async:false,//비동기 여부
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(err){}
	});
	
	$('#pagination-transport').twbsPagination({
		totalPages:totalPages,
		visiblePages:5,
		first:'처음',
		prev:'<<',
		next:'>>',
		last:'마지막',
		onPageClick: function(event, page){
			
			$.ajax({
				url:'./tips/getTransportAll',
				type:'get',
				data:{
					start:(page-1)*countInOnePage,
					cnt:countInOnePage
				},
				success:function(list){
					console.log(list);
					
					$('#tips-content-more').empty();
					
					$.each(list,function(index,item){
						console.log(item.user_idx);
						
						$('#tips-content-more').append(
								`<ul class="tips-contents">
									<input type="hidden" id="transport-idx" value="${item.transport_idx}"/>
									<li class="tips-nation">[${item.nation}]</li>
									<span class="tips-contents-more">${item.tips_transport}</span>
									<span class="tips-up-btn">수정</span>
									<span class="tips-del-btn">삭제</span>
								  </ul>`
						)
					});
				},
				error:function(err){}
			});
		}
	});
}


//삭제 리스트
function delTrans(){
	$(document).on('click','.tips-del-btn',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var transport_idx = children.eq(0).val();
		
		$.ajax({
			url:'./tips/delTrans',
			type:'post',
			data:{transport_idx:transport_idx},
			success:function(res){
				if(res=='ok'){
					alert('삭제 성공');
					location.replace('./tips')
				}else{
					alert('삭제 실패');
				}
			},
			error:function(err){}
		});
		
	});
}


//검색-리스트
function schTrans(){
	$('#search-glass').on('click',function(){
		$('#pagination-transport').twbsPagination('destroy');
		$('#tips-content-more').empty();
				
		var user_idx = $('#search').val();
		var countInOnePage=7;
		var totalPages=0;
		
		$.ajax({
			url:'./tips/getTransCountAfterSch',
			type:'get',
			data:{user_idx:user_idx},
			async:false,//비동기 여부
			success:function(count){
				totalPages=Math.ceil(count/countInOnePage);
			},
			error:function(err){}
		});
		
		$('#pagination-transport').twbsPagination({
			totalPages:totalPages,
			visiblePages:5,
			first:'처음',
			prev:'<<',
			next:'>>',
			last:'마지막',
			onPageClick: function(event, page){
				
				$.ajax({
					url:'./tips/getTransChunkAfterSch',
					type:'get',
					data:{
						user_idx:user_idx,
						start:(page-1)*countInOnePage,
						cnt:countInOnePage
					},
					success:function(list){
						console.log(list);	
						
						$('#tips-content-more').empty();
						
						$.each(list,function(index,item){
							
							$('#tips-content-more').append(
									`<ul class="tips-contents">
										<input type="hidden" id="transport-idx" value="${item.transport_idx}"/>
										<li class="tips-nation">[${item.nation}]</li>
										<span class="tips-contents-more">${item.tips_transport}</span>
									  	<span class="tips-up-btn">수정</span>
									  	<span class="tips-del-btn">삭제</span>
									  </ul>`
							)
						});
					},
					error:function(err){}
				});
			}
		});
	});
}


//수정하기
function updateTrans(){
$(document).on('click','.tips-up-btn',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var transport_idx = children.eq(0).val();
		
		$.ajax({
			url:'./tips/getTransForUp',
			type:'get',
			async:false,
			data:{transport_idx:transport_idx},
			success:function(trans){
				$('#tips-content-more').empty();
				$('#pagination-transport').empty();				
				$('#tips-content-more').append(
						`<ul class="tips-contents">
							<input type="hidden" id="transport-idx" value="${trans.transport_idx}"/>
							<li class="tips-nation">[${trans.nation}]</li>
							<span class="tips-contents-more">${trans.tips_transport}
						  		<textarea style="height:300px;" type="text" id="tips-up-more" placeholder="  수정사항을 적어주세요"/>					
							</span>
							
							<span class="tips-update-btn">수정</span>
						  </ul>`
				)
			}
		});
		
		$(document).on('click','.tips-update-btn',function(){
			
			var tips_transport = $('#tips-up-more').val();
			
			$.ajax({
				url:'./tips/updateTrans',
				type:'post',
				data:{
					transport_idx:transport_idx,
					tips_transport:tips_transport
				},
				success:function(res){
					if(res=='ok'){
						alert('수정 성공');
						location.replace('./tips');
					}else{
						alert('수정 실패');
					}
				},
				error:function(err){}
			});
			
		});
	});
	
}

