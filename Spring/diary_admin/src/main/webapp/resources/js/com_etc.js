$(document).ready(function(){
	
	//etc
	etcComList();
	delEtcCom();
	
});


//etcComment
function etcComList(){

	$('#comment-tbody').empty();
	$('#pagination-comment').empty();
	
	
	var totalPages=0;
	var countInOnePage=10;
	
	$.ajax({
		url:'./comment/getEtcComCount',
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
				url:'./comment/getEtcComAll',
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
								      <td id="etc-comment-idx" scope="row" style="text-align:center">${item.etc_comment_idx}</td>
								      <td style="text-align:center">${item.nickname}</td>
								      <td>${item.etc_comment}</td>
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


function delEtcCom(){
	$(document).on('click','#del-btn',function(){
		
		var parent = $(this).parent();
		var etc_comment_idx = parent.children().eq(0).text();
		
		$.ajax({
			url:'./comment/delEtcCom',
			type:'post',
			data:{
				etc_comment_idx:etc_comment_idx
			},
			success:function(res){
				if(res=='ok'){
					alert('삭제되었습니다');
					location.replace('./com_etc');
				}
			}
		});
	});
}
