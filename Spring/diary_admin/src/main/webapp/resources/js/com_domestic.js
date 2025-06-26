$(document).ready(function(){
	
	//domestic
	domComList();
	delDomCom();
	
});


//domesticComment
function domComList(){

	$('#comment-tbody').empty();
	$('#pagination-comment').empty();
	
	
	var totalPages=0;
	var countInOnePage=10;
	
	$.ajax({
		url:'./comment/getDomComCount',
		type:'get',
		data:{},
		async:false,//비동기 여부
		success:function(count){
			
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(err){}
	});
	
	$('#pagination-comment').twbsPagination({
		totalPages:totalPages,
		visiblePages:5,
		first:'처음',
		prev:'<<',
		next:'>>',
		last:'마지막',
		onPageClick: function(event, page){
			
			$.ajax({
				url:'./comment/getDomComAll',
				type:'get',
				data:{
					start:(page-1)*countInOnePage,
					cnt:countInOnePage
				},
				success:function(list){
					$('#comment-tbody').empty();
					$.each(list,function(index,item){
						
						
						$('#comment-tbody').append(
								`<tr id="comment-tbody-content">
								      <td id="domestic-comment-idx" scope="row" style="text-align:center">${item.domestic_comment_idx}</td>
								      <td style="text-align:center">${item.nickname}</td>
								      <td>${item.domestic_comment}</td>
								      <td style="text-align:center" id="del-btn">삭제</td>
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


function delDomCom(){
	$(document).on('click','#del-btn',function(){
		
		var parent = $(this).parent();
		var domestic_comment_idx = parent.children().eq(0).text();
		
		$.ajax({
			url:'./comment/delDomCom',
			type:'post',
			data:{
				domestic_comment_idx:domestic_comment_idx
			},
			success:function(res){
				if(res=='ok'){
					alert('삭제되었습니다');
					location.replace('./com_domestic');
				}
			}
		});
	});
}
