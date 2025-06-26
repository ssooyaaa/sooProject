$(document).ready(function(){
	
	//photos-report-list
	getPhotosAll();
	
	
	//수정 -> 완료
	updateCheck();
	
	
	//완료 -> 수정
	returnCheck();
});

//tips-report-list
function getPhotosAll(){
	var totalPages=0;
	var countInOnePage=7;
	
	$.ajax({
		url:'./phreport/getPhotosCount',
		type:'get',
		data:{},
		async:false,
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(err){}
	});
	
	$('#pagination-photo-report').twbsPagination({
		totalPages:totalPages,
		visiblePages:5,
		first:'처음',
		prev:'<<',
		next:'>>',
		last:'마지막',
		onPageClick: function(event, page){
			
			$.ajax({
				url:'./phreport/getPhotosAll',
				type:'get',
				data:{
					start:(page-1)*countInOnePage,
					cnt:countInOnePage
				},
				success:function(list){
					console.log(list);	
					$('#photos-tbody').empty();
					$.each(list,function(index,item){
						
						if(item.domestic_sight_desc != "" && item.ph_checked=="N"){
							$('#photos-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="phreport-idx" scope="row" style="text-align:center;">${item.phreport_idx}</td>
									      <td style="text-align:center;">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td><img class="report-img" src="${item.domestic_sight_img}"/></td>
									      <td>[국내]${item.domestic_sight_desc}</td>
										  <td style="text-align:center;" id="user-del-btn">수정</td>
									    </tr>`
							)
						}else if(item.domestic_sight_desc != "" && item.ph_checked=="Y"){
							$('#photos-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="phreport-idx" scope="row" style="text-align:center;">${item.phreport_idx}</td>
									      <td style="text-align:center;">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td><img class="report-img" src="${item.domestic_sight_img}"/></td>
									      <td>[국내]${item.domestic_sight_desc}</td>
										  <td style="text-align:center;" id="user-complete-btn">완료</td>
									    </tr>`
							)
						}
						
						else if(item.abroad_sight_desc != "" && item.ph_checked=="N"){
							$('#photos-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="phreport-idx" scope="row" style="text-align:center;">${item.phreport_idx}</td>
									      <td style="text-align:center;">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td><img class="report-img" src="${item.abroad_sight_img}"/></td>
									      <td>[해외]${item.abroad_sight_desc}</td>
										  <td style="text-align:center;" id="user-del-btn">수정</td>
									    </tr>`
							)
						}else if(item.abroad_sight_desc != "" && item.ph_checked=="Y"){
							$('#photos-tbody').append(
									` <tr id="user-tbody-content">
									      <td id="phreport-idx" scope="row" style="text-align:center;">${item.phreport_idx}</td>
									      <td style="text-align:center;">${item.user_idx}</td>
									      <td>${item.report_desc}</td>
									      <td><img class="report-img" src="${item.abroad_sight_img}"/></td>
									      <td>[해외]${item.abroad_sight_desc}</td>
										  <td style="text-align:center;" id="user-complete-btn">완료</td>
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
		var phreport_idx = children.eq(0).text();
		
		$.ajax({
			url:'./phreport/updateCheck',
			type:'post',
			data:{phreport_idx:phreport_idx},
			success:function(res){
				if(res=="ok"){
					location.replace('./photo_report')
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
		var phreport_idx = children.eq(0).text();
		
		$.ajax({
			url:'./phreport/returnCheck',
			type:'post',
			data:{phreport_idx:phreport_idx},
			success:function(res){
				if(res=="ok"){
					location.replace('./photo_report')
				}
			}
		});
	});
	
}