$(document).ready(function(){
	
	//전체 리스트
	domList();
	
	//검색 리스트
	schDom();
	
	//신고하기
	addPhreport();
	
	//댓글창
	Comment();
	
	//댓글등록
	addComment();
	
	//댓글삭제
	delComment();
	
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
										<img src="${item.sight_img}"/>
										<span class="photos-nation">[${item.nation}]</span>
										<p>${item.sight_desc}</p>
										<span style="display:none" class="photos-user-idx">${item.user_idx}</span>
										<span style="display:none" class="domestic-idx">${item.domestic_idx}</span>
										<span class="photos-comment"><i class="fa-regular fa-comment-dots"> 댓글 작성</i></span>
										<span class="photos-btn">신고</span>
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
				
		var nation = $('#search').val();
		var countInOnePage=6;
		var totalPages=0;
		
		$.ajax({
			url:'./photos/getDomCountAfterSch',
			type:'get',
			data:{nation:nation},
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
						nation:nation,
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
											<img src="${item.sight_img}"/>
											<span class="photos-nation">[${item.nation}]</span>
											<p>${item.sight_desc}</p>
											<span style="display:none" class="photos-user-idx">${item.user_idx}</span>
											<span style="display:none" class="domestic-idx">${item.domestic_idx}</span>
											<span class="photos-comment"><i class="fa-regular fa-comment-dots"> 댓글 작성</i></span>
											<span class="photos-btn">신고</span>
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


//신고하기
function addPhreport(){

	$(document).on('click','.photos-btn',function(){
		
		var report_desc = prompt("변경/신고 사유를 적어주세요.");
		
		var parent = $(this).parent();
		var children = parent.children();
		
		var user_idx = children.eq(3).text();
		var domestic_sight_img = children.eq(0).attr('src');
		var domestic_sight_desc = children.eq(2).text();
		var abroad_sight_img = '';
		var abroad_sight_desc = '';
		
		if(report_desc==null||report_desc==undefined){
			
			alert('접수 취소되었습니다.');
			location.href='./photo';
			
		}else{
			
			$.ajax({
				url:'./report/addPhreport',
				type:'post',
				data:{
					user_idx:user_idx,
					report_desc:report_desc,
					domestic_sight_img:domestic_sight_img,
					domestic_sight_desc:domestic_sight_desc,
					abroad_sight_img:abroad_sight_img,
					abroad_sight_desc:abroad_sight_desc
				},
				success:function(res){
					if(res=='ok'){
						alert('접수 완료되었습니다.');
						location.href='./photo';
					}else{
						location.href='./photo';
					}
				}
			});
		}
		
		
	});
	
}


//댓글창
function Comment(){
	$(document).on('click','.photos-comment',function(){
			
			var parent = $(this).parent();
			
			var children = parent.children();
			var domestic_idx = children.eq(4).text();
			
			$('#photo-section-row').empty();
			$('#pagination-domestic').empty();
			
			$.ajax({
				url:'./photos/getDomForCom',
				type:'get',
				async:false,
				data:{domestic_idx:domestic_idx},
				success:function(dom){
					$('#photo-section-row').append(
							`<div class="col-4">
								<div class="photo-card">
									<img src="${dom.sight_img}"/>
									<span class="photos-nation">[${dom.nation}]</span>
									<p>${dom.sight_desc}</p>
									<span style="display:none" class="photos-user-idx">${dom.user_idx}</span>
									<span style="display:none" class="domestic-idx">${dom.domestic_idx}</span>
									<span class="photos-comment"><i class="fa-regular fa-comment-dots"> 댓글 작성</i></span>
									<span class="photos-btn">신고</span>
								</div>
							</div>
							<div class="col-8 photos-comments">
								<span class="photos-comment-back"><i class="fa-solid fa-rotate-left">돌아가기</i></span>
							  	<div class="comment-write">
							  		<span style="display:none;">${dom.domestic_idx}</span>
							  		<i class="fa-regular fa-comment"></i>
						  			<input type="text" class="comment" placeholder=" 댓글 입력해주세요"/>
						  			<i class="fa-solid fa-paper-plane upload-comment"></i>
							  	</div>
							 </div>`
					)
				},
				error:function(err){}
			});
			
			var nickname = $('#login-nickname').val();
			
			$.ajax({
				url:'./photos/getDomCom',
				type:'get',
				data:{domestic_idx:domestic_idx},
				success:function(list){
					
					$.each(list,function(index,item){
						
						if(item.nickname==nickname){
							$('.photos-comments').append(
									`<div class="comments">
											<span class="comment-idx" style="display:none">${item.domestic_comment_idx}</span>
									  		<span class="comments-user">${item.nickname}</span>
									  		<span class="comments-desc">${item.domestic_comment}</span>
									  		<span class="comments-btn">삭제</span>
									  	</div>`
								)
						}else{
							$('.photos-comments').append(
									`<div class="comments">
									  		<span class="comments-user">${item.nickname}</span>
									  		<span class="comments-desc">${item.domestic_comment}</span>
									  	</div>`
								)
						}
						
						
						
					});
					
				},
				error:function(err){}
			});
			
			$(document).on('click','.photos-comment-back',function(){
				location.href="./photo";
			});
			
		})
		
}

//댓글등록
function addComment(){
	$(document).on('click','.upload-comment',function(){
			
			var parent = $(this).parent();
			var children = parent.children();
			var domestic_idx = children.eq(0).text();
	
			var domestic_comment = $('.comment').val();
			
			$.ajax({
				url:'./photos/addDomCom',
				type:'post',
				data:{
					domestic_idx:domestic_idx,
					domestic_comment:domestic_comment
				},
				success:function(res){
					if(res=="ok"){
						alert('댓글이 등록되었습니다.');
						location.replace('./photo');
					}else{
						alert('댓글 등록에 실패했습니다.');
					}
				},
				error:function(err){}
			});
		})
}

//댓글삭제
function delComment(){
	$(document).on('click','.comments-btn',function(){
		
		var parent = $(this).parent();
		var domestic_comment_idx = parent.children().eq(0).text();
		
		$.ajax({
			url:'./photos/delDomCom',
			type:'post',
			data:{
				domestic_comment_idx:domestic_comment_idx
			},
			success:function(res){
				if(res=='ok'){
					alert('삭제되었습니다.');
					location.replace('./photo');
				}else{
					alert('삭제 실패했습니다.');
				}
			},
			error:function(err){}
		});
		
	});
}