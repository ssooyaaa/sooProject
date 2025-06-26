$(document).ready(function(){
	
	//IT프로젝트 등록
	$('.banner-btn').click(function(){
		location.href='./newWork';
	});
	
	
	// 프리랜서가입
	$('.membership-add-btn').click(function(){
		location.href='./membership';
	});
	
	
	//프로젝트-프로그래밍(개발)
	$('#search-programming').click(function(){
		
		var children = $('#search-programming').children();
		var field = children.eq(1).val();
		
		location.href='./checkedList?field='+field;
	});
	
	//프로젝트-웹기획
	$('#search-planning').click(function(){
		
		var children = $('#search-planning').children();
		var field = children.eq(1).val();
		
		location.href='./checkedList?field='+field;
	});
	
	//프로젝트-퍼블리싱
	$('#search-publishing').click(function(){
		
		var children = $('#search-publishing').children();
		var field = children.eq(1).val();
		
		location.href='./checkedList?field='+field;
	});
	
	//프로젝트-디자인
	$('#search-design').click(function(){
		
		var children = $('#search-design').children();
		var field = children.eq(1).val();
		
		location.href='./checkedList?field='+field;
	});
	
	//더보기버튼
	var listIndex=0;
	var listCount=8;
	
	$('#more-projects-btn').click(function(){
		listIndex = listIndex+listCount;
		loadProjectList(listIndex, listCount);
	});
	
	loadProjectList(listIndex, listCount);
	
});


function loadProjectList(a, b){
	$.ajax({
		url:'./project/getProjectAll',
		type:'get',
		data:{
			start:a,
			cnt:b
		},
		success:function(list){
			$.each(list, function(index,item){
				$('#projects').append(
					`<div class="col-6" style="display:flex;">
						<span class="project-idx" style="display:none">${item.project_idx}</span>
						<div class="recent-project">
							<div class="project-type">
								<span class="type">${item.field}</span>
								<span class="type">${item.detail_field}</span>
							</div>
							<div class="project-name">
								${item.title}
							</div>
							<div class="project-deadline">
								<span style="margin-right:5px;">기간</span>
								<span>${item.duration}</span>
							</div>
							<div class="project-info">
								<div class="info">
									<span class="info-type">근무형태</span>
									<span class="info-more">${item.type}</span>
									<span style="margin-right:3px;">|</span>
								</div>
								<div class="info">
									<span class="info-type">근무지</span>
									<span class="info-more">${item.location}</span>
									<span style="margin-right:3px;">|</span>
								</div>
								<div class="info">
									<span class="info-type">단가</span>
									<span class="info-more">${item.price}</span>
								</div>
							</div>
						</div>
						
					</div>`	
				);
			});
		}, error:function(){}
	});
}