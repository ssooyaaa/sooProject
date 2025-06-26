$(document).ready(function(){
	
	//전체 리스트
	domList();
	
	//검색 리스트
	schDom();
	
	//삭제
	delDom();
	
	//수정
	updateDom();
	
});

//전체리스트
function domList(){

	var totalPages=0;
	var countInOnePage=6;
	
	$.ajax({
		url:'./photos/getDomesticCount',
		type:'get',
		data:{},
		async:false,
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
			console.log(count);
		},
		error:function(err){}
	});
	
	$('#pagination-domestic').twbsPagination({
		totalPages:totalPages,
		visiblePages:5,
		first:'처음',
		prev:'<<',
		next:'>>',
		last:'마지막',
		onPageClick:function(event,page){
			
			$.ajax({
				url:'./photos/getDomesticAll',
				type:'get',
				data:{
					start:(page-1)*countInOnePage,
					cnt:countInOnePage
				},
				success:function(list){
					console.log(list);
					$('#photo-section-row').empty();
					$.each(list,function(index,item){
						
						$('#photo-section-row').append(
								`<div class="col-4">
									<div class="photo-card">
										<input type="hidden" id="domestic-idx" value="${item.domestic_idx}"/>
										<input type="button" id="photo-up" value="수정"/>
										<input type="button" id="photo-del" value="삭제"/>
										<img src="${item.sight_img}"/>
										<span>[${item.nation}]</span>
										<p>${item.sight_desc}</p>
									</div>
								</div>`
								)
					});
				},
				error:function(err){}
			});
		}
	});
	
}


//검색 리스트
function schDom(){
	$('#search-glass').on('click',function(){
		$('#pagination-domestic').twbsPagination('destroy');
		$('#photo-section-row').empty();
				
		var user_idx = $('#search').val();
		var countInOnePage=6;
		var totalPages=0;
		
		$.ajax({
			url:'./photos/getDomCountAfterSch',
			type:'get',
			data:{user_idx:user_idx},
			async:false,//비동기 여부
			success:function(count){
				totalPages=Math.ceil(count/countInOnePage);
			},
			error:function(err){}
		});
		
		$('#pagination-domestic').twbsPagination({
			totalPages:totalPages,
			visiblePages:5,
			first:'처음',
			prev:'<<',
			next:'>>',
			last:'마지막',
			onPageClick: function(event, page){
				
				$.ajax({
					url:'./photos/getDomChunkAfterSch',
					type:'get',
					data:{
						user_idx:user_idx,
						start:(page-1)*countInOnePage,
						cnt:countInOnePage
					},
					success:function(list){
						console.log(list);		
						$('#photo-section-row').empty();
						$.each(list,function(index,item){
							
							$('#photo-section-row').append(
									`<div class="col-4">
										<div class="photo-card">
											<input type="hidden" id="domestic-idx" value="${item.domestic_idx}"/>
											<input type="button" id="photo-up" value="수정"/>
											<input type="button" id="photo-del" value="삭제"/>
											<img src="${item.sight_img}"/>
											<span>[${item.nation}]</span>
											<p>${item.sight_desc}</p>
										</div>
									</div>`
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
function delDom(){
	$(document).on('click','#photo-del',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var domestic_idx = children.eq(0).val();
		
		$.ajax({
			url:'./photos/delDom',
			type:'post',
			data:{domestic_idx:domestic_idx},
			success:function(res){
				if(res=='ok'){
					alert('삭제 성공');
					location.replace('./photo')
				}else{
					alert('삭제 실패');
				}
			},
			error:function(err){}
		});
		
	});
}


//수정
function updateDom(){
	$(document).on('click','#photo-up',function(){
			
			var parent = $(this).parent();
			var children = parent.children();
			var domestic_idx = children.eq(0).val();
			
			$.ajax({
				url:'./photos/getDomForUp',
				type:'get',
				async:false,
				data:{domestic_idx:domestic_idx},
				success:function(dom){
					$('#photo-section-row').empty();
					$('#pagination-domestic').empty();
					$('#photo-section-row').append(
							`<div class="col-4">
								<div class="photo-card">
									<input type="hidden" id="domestic-idx" value="${dom.domestic_idx}"/>
									
									<img src="${dom.sight_img}"/>
									<span>[${dom.nation}]</span>
									<p>${dom.sight_desc}</p>
								</div>
							</div>
							<div class="col-4" style="margin-top:40px;">
								<input type="button" id="photo-update" value="수정"/>
								<textarea type="text" style="width:400px;height:500px;overflow:auto;margin-top:10px;" id="up-sight-desc" placeholder="  수정사항을 적어주세요"/>
							</div>`
					)
				}
			});
			
			$(document).on('click','#photo-update',function(){
				
				var sight_desc = $('#up-sight-desc').val();
				
				$.ajax({
					url:'./photos/updateDom',
					type:'post',
					data:{
						domestic_idx:domestic_idx,
						sight_desc:sight_desc
					},
					success:function(res){
						if(res=='ok'){
							alert('수정 성공');
							location.replace('./photo');
						}else{
							alert('수정 실패');
						}
					},
					error:function(err){}
				});
				
			});
		});
	
}