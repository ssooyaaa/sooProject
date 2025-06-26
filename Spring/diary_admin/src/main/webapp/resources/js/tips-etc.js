$(document).ready(function(){
	
	//전체 리스트
	etcList();
	
	//검색 리스트
	schEtc();
	
	//삭제 리스트
	delEtc();
	
	//수정하기
	updateEtc();
	
});


//전체 리스트
function etcList(){

	var totalPages=0;
	var countInOnePage=7;
	
	$.ajax({
		url:'./tips/getEtcCount',
		type:'get',
		data:{},
		async:false,
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(err){}
	});
	
	$('#pagination-etc').twbsPagination({
		totalPages:totalPages,
		visiblePages:5,
		first:'처음',
		prev:'<<',
		next:'>>',
		last:'마지막',
		onPageClick:function(event,page){
			
			$.ajax({
				url:'./tips/getEtcAll',
				type:'get',
				data:{
					start:(page-1)*countInOnePage,
					cnt:countInOnePage
				},
				success:function(list){
					console.log(list);
					
					$('#tips-content-more').empty();
					
					$.each(list,function(index,item){
						$('#tips-content-more').append(
								`<ul class="tips-contents">
									<input type="hidden" id="etc-idx" value="${item.etc_idx}"/>
									<li class="tips-nation">[${item.nation}]</li>
									<span class="tips-contents-more">${item.tips_etc}</span>
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


//검색리스트
function schEtc(){
	$('#search-glass').on('click',function(){
		$('#pagination-etc').twbsPagination('destroy');
		$('#tips-content-more').empty();
				
		var user_idx = $('#search').val();
		var countInOnePage=7;
		var totalPages=0;
		
		$.ajax({
			url:'./tips/getEtcCountAfterSch',
			type:'get',
			data:{user_idx:user_idx},
			async:false,//비동기 여부
			success:function(count){
				totalPages=Math.ceil(count/countInOnePage);
			},
			error:function(err){}
		});
		
		$('#pagination-etc').twbsPagination({
			totalPages:totalPages,
			visiblePages:5,
			first:'처음',
			prev:'<<',
			next:'>>',
			last:'마지막',
			onPageClick: function(event, page){
				
				$.ajax({
					url:'./tips/getEtcChunkAfterSch',
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
										<input type="hidden" id="etc-idx" value="${item.etc_idx}"/>
										<li class="tips-nation">[${item.nation}]</li>
										<span class="tips-contents-more">${item.tips_etc}</span>
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

//삭제 리스트
function delEtc(){
	$(document).on('click','.tips-del-btn',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var etc_idx = children.eq(0).val();
		
		$.ajax({
			url:'./tips/delEtc',
			type:'post',
			data:{etc_idx:etc_idx},
			success:function(res){
				if(res=='ok'){
					alert('삭제 성공');
					location.replace('./tips-etc')
				}else{
					alert('삭제 실패');
				}
			},
			error:function(err){}
		});
		
	});
}


//수정하기
function updateEtc(){
$(document).on('click','.tips-up-btn',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var etc_idx = children.eq(0).val();
		
		$.ajax({
			url:'./tips/getEtcForUp',
			type:'get',
			async:false,
			data:{etc_idx:etc_idx},
			success:function(etc){
				$('#tips-content-more').empty();
				$('#pagination-etc').empty();
				$('#tips-content-more').append(
						`<ul class="tips-contents">
							<input type="hidden" id="etc-idx" value="${etc.etc_idx}"/>
							<li class="tips-nation">[${etc.nation}]</li>
							<span class="tips-contents-more">${etc.tips_etc}
						  		<textarea style="height:300px;" type="text" id="tips-up-more" placeholder="  수정사항을 적어주세요"/>					
							</span>
							
							<span class="tips-update-btn">수정</span>
						  </ul>`
				)
			}
		});
		
		$(document).on('click','.tips-update-btn',function(){
			
			var tips_etc = $('#tips-up-more').val();
			
			$.ajax({
				url:'./tips/updateEtc',
				type:'post',
				data:{
					etc_idx:etc_idx,
					tips_etc:tips_etc
				},
				success:function(res){
					if(res=='ok'){
						alert('수정 성공');
						location.replace('./tips-etc');
					}else{
						alert('수정 실패');
					}
				},
				error:function(err){}
			});
			
		});
	});
	
}