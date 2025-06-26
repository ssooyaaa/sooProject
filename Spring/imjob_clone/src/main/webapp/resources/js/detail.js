$(document).ready(function(){
	
	//목록 버튼
	$('.go-to-projectlist').click(function(){
		
		location.href='./projectList';
	});
	
	
	var project_idx = $('#k-project-idx').val();
	//상세정보보기
	showMoreInfo(project_idx);
	
});




function showMoreInfo(project_idx){
	$.ajax({
		url:'./project/getProjectByIdx',
		type:'get',
		data:{'project_idx':project_idx},
		success:function(item){
			
			$('.detail-container').prepend(
				`<div class="detail-title">
					${item.title}
				</div>
				<div class="basic-info-box">
					<span>기본정보</span>
					<div class="basic-container">
						<div class="basic-oneline">
							<span class="basic-info">분야</span>
							<span>${item.field} > ${item.detail_field}</span>
						</div>
						<div class="basic-oneline">
							<span class="basic-info">지역</span>
							<span>${item.location}</span>
						</div>
						<div class="basic-oneline">
							<span class="basic-info">근무형태</span>
							<span>${item.type}</span>
						</div>
						<div class="basic-oneline">
							<span class="basic-info">작업기간</span>
							<span>${item.duration}</span>
						</div>
						<div class="basic-oneline" style="border:none;">
							<span class="basic-info">작업단가</span>
							<span>${item.price}</span>
						</div>
					</div>
				</div>
				`	
			);
			
			$('.detail-info').append(
				`${item.content}`
			);
		}
	});
}
