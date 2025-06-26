$(document).ready(function(){
	
	//전체 리스트
	accomList();
	
	//검색 리스트
	schAccom();
	
	//삭제리스트
	delAccom();
	
	//수정
	updateAccom();
});


//전체 리스트
function accomList(){
	var totalPages=0;
	var countInOnePage=7;
	
	$.ajax({
		url:'./tips/getAccomodationCount',
		type:'get',
		data:{},
		async:false,
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(err){}
	});
	
	$('#pagination-accomodation').twbsPagination({
		totalPages:totalPages,
		visiblePages:5,
		first:'처음',
		prev:'<<',
		next:'>>',
		last:'마지막',
		onPageClick:function(event,page){
			
			$.ajax({
				url:'./tips/getAccomodationAll',
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
									<input type="hidden" id="accomodation-idx" value="${item.accomodation_idx}"/>
									<li class="tips-nation">[${item.nation}]</li>
									<span class="tips-contents-more">${item.tips_accomodation}</span>
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
function schAccom(){
	$('#search-glass').on('click',function(){
		$('#pagination-accomodation').twbsPagination('destroy');
		$('#tips-content-more').empty();
				
		var user_idx = $('#search').val();
		var countInOnePage=7;
		var totalPages=0;
		
		$.ajax({
			url:'./tips/getAccomCountAfterSch',
			type:'get',
			data:{user_idx:user_idx},
			async:false,//비동기 여부
			success:function(count){
				totalPages=Math.ceil(count/countInOnePage);
			},
			error:function(err){}
		});
		
		$('#pagination-accomodation').twbsPagination({
			totalPages:totalPages,
			visiblePages:5,
			first:'처음',
			prev:'<<',
			next:'>>',
			last:'마지막',
			onPageClick: function(event, page){
				
				$.ajax({
					url:'./tips/getAccomChunkAfterSch',
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
										<input type="hidden" id="accomodation-idx" value="${item.accomodation_idx}"/>
										<li class="tips-nation">[${item.nation}]</li>
										<span class="tips-contents-more">${item.tips_accomodation}</span>
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
function delAccom(){
	$(document).on('click','.tips-del-btn',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var accomodation_idx = children.eq(0).val();
		
		$.ajax({
			url:'./tips/delAccom',
			type:'post',
			data:{accomodation_idx:accomodation_idx},
			success:function(res){
				if(res=='ok'){
					alert('삭제 성공');
					location.replace('./tips-accomodation')
				}else{
					alert('삭제 실패');
				}
			},
			error:function(err){}
		});
		
	});
}


//수정
function updateAccom(){
$(document).on('click','.tips-up-btn',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var accomodation_idx = children.eq(0).val();
		
		$.ajax({
			url:'./tips/getAccomForUp',
			type:'get',
			async:false,
			data:{accomodation_idx:accomodation_idx},
			success:function(accom){
				$('#tips-content-more').empty();
				$('#pagination-accomodation').empty();
				$('#tips-content-more').append(
						`<ul class="tips-contents">
							<input type="hidden" id="accomodation-idx" value="${accom.accomodation_idx}"/>
							<li class="tips-nation">[${accom.nation}]</li>
							<span class="tips-contents-more">${accom.tips_accomodation}
						  		<textarea style="height:300px;" type="text" id="tips-up-more" placeholder="  수정사항을 적어주세요"/>					
							</span>
							
							<span class="tips-update-btn">수정</span>
						  </ul>`
				)
			}
		});
		
		$(document).on('click','.tips-update-btn',function(){
			
			var tips_accomodation = $('#tips-up-more').val();
			
			$.ajax({
				url:'./tips/updateAccom',
				type:'post',
				data:{
					accomodation_idx:accomodation_idx,
					tips_accomodation:tips_accomodation
				},
				success:function(res){
					if(res=='ok'){
						alert('수정 성공');
						location.replace('./tips-accomodation');
					}else{
						alert('수정 실패');
					}
				},
				error:function(err){}
			});
			
		});
	});
	
}