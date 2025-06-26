$(document).ready(function(){
	
	//tips-report-list
	getTipsAll();
	
	
	//수정 -> 완료
	updateCheck();
	
	
	//완료 -> 수정
	returnCheck();
	
});


//tips-report-list
function getTipsAll(){
	var totalPages=0;
	var countInOnePage=7;
	
	$.ajax({
		url:'./report/getTipsCount',
		type:'get',
		data:{},
		async:false,
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(err){}
	});
	
	$('#pagination-tips-report').twbsPagination({
		totalPages:totalPages,
		visiblePages:5,
		first:'처음',
		prev:'<<',
		next:'>>',
		last:'마지막',
		onPageClick: function(event, page){
			
			$.ajax({
				url:'./report/getTipsAll',
				type:'get',
				data:{
					start:(page-1)*countInOnePage,
					cnt:countInOnePage
				},
				success:function(list){
					console.log(list);	
					$('#tips-tbody').empty();
					$.each(list,function(index,item){
						
						if(item.tips_transport != "" && item.re_checked=="N"){
							$('#tips-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="report-idx" scope="row" style="text-align:center">${item.report_idx}</td>
									      <td style="text-align:center">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td id="tips-contents">[교통] ${item.tips_transport}</td>
										  <td style="text-align:center" id="user-del-btn">수정</td>
									    </tr>`
								
							)
							
						}else if(item.tips_transport != "" && item.re_checked=="Y"){
							$('#tips-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="report-idx" scope="row" style="text-align:center">${item.report_idx}</td>
									      <td style="text-align:center">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td id="tips-contents">[교통] ${item.tips_transport}</td>
										  <td style="text-align:center" id="user-complete-btn">완료</td>
									    </tr>`
								
							)
							
						}
						
						else if(item.tips_accomodation != "" && item.re_checked=="N"){
							$('#tips-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="report-idx"scope="row" style="text-align:center">${item.report_idx}</td>
									      <td style="text-align:center">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td>[숙소] ${item.tips_accomodation}</td>
									      <td style="text-align:center" id="user-del-btn">수정</td>
									    </tr>`
							)
						}else if(item.tips_accomodation != "" && item.re_checked=="Y"){
							$('#tips-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="report-idx"scope="row" style="text-align:center">${item.report_idx}</td>
									      <td style="text-align:center">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td>[숙소] ${item.tips_accomodation}</td>
									      <td style="text-align:center" id="user-complete-btn">완료</td>
									    </tr>`
							)
						}
						
						else if(item.tips_eat != "" && item.re_checked=="N"){
							$('#tips-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="report-idx"scope="row" style="text-align:center">${item.report_idx}</td>
									      <td style="text-align:center">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td>[식당] ${item.tips_eat}</td>
									      <td style="text-align:center" id="user-del-btn">수정</td>
									    </tr>`
							)
						}else if(item.tips_eat != "" && item.re_checked=="Y"){
							$('#tips-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="report-idx"scope="row" style="text-align:center">${item.report_idx}</td>
									      <td style="text-align:center">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td>[식당] ${item.tips_eat}</td>
									      <td style="text-align:center" id="user-complete-btn">완료</td>
									    </tr>`
							)
						}
						
						else if(item.tips_etc != "" && item.re_checked=="N"){
							$('#tips-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="report-idx" scope="row" style="text-align:center">${item.report_idx}</td>
									      <td style="text-align:center">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td>[기타] ${item.tips_etc}</td>
									      <td style="text-align:center" id="user-del-btn">수정</td>
									    </tr>`
							)
						}else if(item.tips_etc != "" && item.re_checked=="Y"){
							$('#tips-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="report-idx" scope="row" style="text-align:center">${item.report_idx}</td>
									      <td style="text-align:center">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td>[기타] ${item.tips_etc}</td>
									      <td style="text-align:center" id="user-complete-btn">완료</td>
									    </tr>`
							)
						}
						
						
						
						
					});
				},
				error:function(err){}
			});
		}
	});
}


//수정 -> 완료
function updateCheck(){
	$(document).on('click','#user-del-btn',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var report_idx = children.eq(0).text();
		
		$.ajax({
			url:'./report/updateCheck',
			type:'post',
			data:{report_idx:report_idx},
			success:function(res){
				if(res=="ok"){
					location.replace('./tips_report')
				}
			}
		});
	});
	
}


//완료 -> 수정
function returnCheck(){
	$(document).on('click','#user-complete-btn',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var report_idx = children.eq(0).text();
		
		$.ajax({
			url:'./report/returnCheck',
			type:'post',
			data:{report_idx:report_idx},
			success:function(res){
				if(res=="ok"){
					location.replace('./tips_report')
				}
			}
		});
	});
	
}