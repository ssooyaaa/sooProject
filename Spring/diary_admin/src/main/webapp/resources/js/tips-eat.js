$(document).ready(function(){

	//전체 리스트
	eatList();
	
	//검색 리스트
	schEat();
	
	//삭제 리스트
	delEat();
	
	//수정
	updateEat();
	
});


//전체리스트
function eatList(){

	var totalPages=0;
	var countInOnePage=7;
	
	$.ajax({
		url:'./tips/getEatCount',
		type:'get',
		data:{},
		async:false,
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(err){}
	});
	
	$('#pagination-eat').twbsPagination({
		totalPages:totalPages,
		visiblePages:5,
		first:'처음',
		prev:'<<',
		next:'>>',
		last:'마지막',
		onPageClick:function(event,page){
			
			$.ajax({
				url:'./tips/getEatAll',
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
									<input type="hidden" id="eat-idx" value="${item.eat_idx}"/>
									<li class="tips-nation">[${item.nation}]</li>
									<span class="tips-contents-more">${item.tips_eat}</span>
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



//검색 리스트
function schEat(){
	$('#search-glass').on('click',function(){
		$('#pagination-eat').twbsPagination('destroy');
		$('#tips-content-more').empty();
				
		var user_idx = $('#search').val();
		var countInOnePage=7;
		var totalPages=0;
		
		$.ajax({
			url:'./tips/getEatCountAfterSch',
			type:'get',
			data:{user_idx:user_idx},
			async:false,//비동기 여부
			success:function(count){
				totalPages=Math.ceil(count/countInOnePage);
			},
			error:function(err){}
		});
		
		$('#pagination-eat').twbsPagination({
			totalPages:totalPages,
			visiblePages:5,
			first:'처음',
			prev:'<<',
			next:'>>',
			last:'마지막',
			onPageClick: function(event, page){
				
				$.ajax({
					url:'./tips/getEatChunkAfterSch',
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
										<input type="hidden" id="eat-idx" value="${item.eat_idx}"/>
										<li class="tips-nation">[${item.nation}]</li>
										<span class="tips-contents-more">${item.tips_eat}</span>
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
function delEat(){
	$(document).on('click','.tips-del-btn',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var eat_idx = children.eq(0).val();
		
		$.ajax({
			url:'./tips/delEat',
			type:'post',
			data:{eat_idx:eat_idx},
			success:function(res){
				if(res=='ok'){
					alert('삭제 성공');
					location.replace('./tips-eat');
				}else{
					alert('삭제 실패');
				}
			},
			error:function(err){}
		});
		
	});
}


//수정하기
function updateEat(){
$(document).on('click','.tips-up-btn',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var eat_idx = children.eq(0).val();
		
		$.ajax({
			url:'./tips/getEatForUp',
			type:'get',
			async:false,
			data:{eat_idx:eat_idx},
			success:function(eat){
				$('#tips-content-more').empty();
				$('#pagination-eat').empty();
				$('#tips-content-more').append(
						`<ul class="tips-contents">
							<input type="hidden" id="eat-idx" value="${eat.eat_idx}"/>
							<li class="tips-nation">[${eat.nation}]</li>
							<span class="tips-contents-more">${eat.tips_eat}
						  		<textarea style="height:300px;" type="text" id="tips-up-more" placeholder="  수정사항을 적어주세요"/>					
							</span>
							
							<span class="tips-update-btn">수정</span>
						  </ul>`
				)
			}
		});
		
		$(document).on('click','.tips-update-btn',function(){
			
			var tips_eat = $('#tips-up-more').val();
			
			$.ajax({
				url:'./tips/updateEat',
				type:'post',
				data:{
					eat_idx:eat_idx,
					tips_eat:tips_eat
				},
				success:function(res){
					if(res=='ok'){
						alert('수정 성공');
						location.replace('./tips-eat');
					}else{
						alert('수정 실패');
					}
				},
				error:function(err){}
			});
			
		});
	});
	
}