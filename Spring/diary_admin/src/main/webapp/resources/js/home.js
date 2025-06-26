$(document).ready(function(){
	
	//user-list
	getUserAll();
	
	
	//user계정 삭제
	delUser();
	
	//user 다이어리/댓글 수
	getTotalWrite();
	
	$(document).on('click','.return-btn',function(){
		$('.more-user').hide();
	});
	
	
});


//user-list
function getUserAll(){
	var totalPages=0;
	var countInOnePage=12;
	
	$.ajax({
		url:'./getUserCount',
		type:'get',
		data:{},
		async:false,
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(err){}
	});
	
	$('#pagination-user').twbsPagination({
		totalPages:totalPages,
		visiblePages:5,
		first:'처음',
		prev:'<<',
		next:'>>',
		last:'마지막',
		onPageClick: function(event, page){
			
			$.ajax({
				url:'./getUserAll',
				type:'get',
				data:{
					start:(page-1)*countInOnePage,
					cnt:countInOnePage
				},
				success:function(list){
					console.log(list);	
					$('#user-tbody').empty();
					$.each(list,function(index,item){
						
						$('#user-tbody').prepend(
								` <tr id="user-tbody-content" style="text-align:center">
								      <td id="home-user-idx" style="width:200px;text-align:center scope="row">${item.user_idx}</td>
								      <td style="width:230px;text-align:center">${item.id}</td>
								      <td style="width:230px;text-align:center">${item.nickname}</td>
								      <td style="width:260px;text-align:center">${item.created_date}</td>
								      <td style="width:230px;text-align:center">${item.account}</td>
								      <td id="user-del-btn" style="width:230px;text-align:center;">계정삭제</td>
								    </tr>
								    `
						)
						
					});
				},
				error:function(err){}
			});
		}
	});
}


//user계정 삭제
function delUser(){
	$(document).on('click','#user-del-btn',function(){
		
		//해당 user-idx가져오기
		var tr = $(this).parent();
		var td = tr.children();
		var user_idx = td.eq(0).text();
		
		
		$.ajax({
			url:'./delUser',
			type:'get',
			data:{'user_idx':user_idx},
			success:function(res){
				if(res=='ok'){
					alert('삭제 완료');
					location.replace('./');
				}else{
					alert('삭제 실패');
				}
			},
			error:function(err){}
		});
	});

}


//user 다이어리/댓글 수
function getTotalWrite(){
	
	$(document).on('click','#home-user-idx',function(){
			
			$('.more-user').show();
			$('#more-user-tbody').empty();
			
			var parent = $(this).parent();
			var user_idx = parent.children().eq(0).text();
			
			$.ajax({
				url:'./mydiary/getDiaryCount',
				type:'get',
				async:false,
				data:{user_idx:user_idx},
				success:function(count){
					diaryCount = count;
				},
				error:function(err){}
			});
			
			$.ajax({
				url:'./comment/getTotalComment',
				type:'get',
				data:{user_idx:user_idx},
				success:function(total){
					$('#more-user-tbody').append(
							`<tr id="more-tbody-content" style="font-size:20px;">
								<td style="width:50%;text-align:center">${diaryCount}</td>
								<td style="width:50%;text-align:center">${total}</td>
							</tr>`
					)
				}
			});
			
		})
		
		
}

