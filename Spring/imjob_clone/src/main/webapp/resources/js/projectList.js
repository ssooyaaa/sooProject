$(document).ready(function(){
	
	//전체 프로젝트 리스트
	projectList();
	
	//상세정보
	moreInfo();
	
	
	//검색-체크박스
	getCheckbox();
	
	var field = $('#map-field').val();
	//홈화면-프로젝트종류별 검색
	getChecked(field);
});


//전체 프로젝트 리스트
function projectList(){
	var totalPages=0;
	var countInOnePage=8;
	
	$.ajax({
		url:'./project/getCount',
		type:'get',
		data:{},
		async:false,
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(err){}
	});
	
	
	$('#pagination-project').twbsPagination({
		totalPages:totalPages,
		visiblePages:10,
		first:'<<',
		prev:'<',
		next:'>',
		last:'>>',
		onPageClick:function(event, page){
			
			$.ajax({
				url:'./project/getProjectAll',
				type:'get',
				data:{
					start:(page-1)*countInOnePage,
					cnt:countInOnePage
				},
				success:function(list){
					
					$('#projectList').empty();
					
					$.each(list, function(index,item){
						
						$('#projectList').append(
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
				}
			})
		}
	});
}


//상세정보
function moreInfo(){
	$(document).on('click','.recent-project',function(){
		
		var parent = $(this).parent();
		var children = parent.children();
		var project_idx = children.eq(0).text();
		
		location.href='./detail?project_idx='+project_idx;
	});
	
	
}


//체크박스
function getCheckbox(){
	
	$('.search-btn').click(function(){
		
		var data={
			'checkArray':[],
			'selectOption':'',
			'keyword':'',
			'start':0,
			'cnt':8
		}
		
		$('input:checkbox[name=sh_check]:checked').each(function() { // 체크된 체크박스의 value 값
            data['checkArray'].push(this.value);
        });
		
		
		if($('#keyword-mode option:selected').val()==""){
			data['selectOption'] = '';
		}else if($('#keyword-mode option:selected').val()=='title'){
			data['selectOption'] = 'title';
		}else if($('#keyword-mode option:selected').val()=='content'){
			data['selectOption'] = 'content';
		}
		
		data['keyword'] = $('#keyword').val();
		
		
		
		$('#pagination-project').twbsPagination('destroy');
		$('#projectList').empty();
		
		var totalPages=0;
		var countInOnePage=8;
		
		
		$.ajax({
			url:'./project/searchProjectCount',
			type:'post',
			contentType:'application/json;charset=UTF-8',
			data:JSON.stringify(data),
			async:false,
			success:function(count){
				totalPages=Math.ceil(count/countInOnePage);
			},
			error:function(){}
		});
		
		
		$('#pagination-project').twbsPagination({
			totalPages:totalPages,
			visiblePages:10,
			first:'<<',
			prev:'<',
			next:'>',
			last:'>>',
			onPageClick:function(event, page){
				
				data['start'] = (page-1)*data['cnt'];
				
				$.ajax({
					url:'./project/searchProjectList',
					type:'post',
					contentType:'application/json;charset=UTF-8',
					data:JSON.stringify(data),
					success:function(list){
						
						$.each(list, function(index,item){
							
							$('#projectList').append(
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
					}
				})
			}
		});
		
	});
}


//홈화면-프로젝트 검색
function getChecked(field){
	
	if($('#sh_check1').val()==field){
		$('#sh_check1').prop('checked',true);
	} else if($('#sh_check2').val()==field){
		$('#sh_check2').prop('checked',true);
	} else if($('#sh_check3').val()==field){
		$('#sh_check3').prop('checked',true);
	} else if($('#sh_check4').val()==field){
		$('#sh_check4').prop('checked',true);
	}
	
	var totalPages=0;
	var countInOnePage=8;
	
	$.ajax({
		url:'./project/getCheckedCount',
		type:'get',
		data:{
			'field':field
		},
		async:false,
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(err){}
	});
	
	$('#pagination-project').twbsPagination('destroy');
	
	$('#pagination-project').twbsPagination({
		totalPages:totalPages,
		visiblePages:10,
		first:'<<',
		prev:'<',
		next:'>',
		last:'>>',
		onPageClick:function(event, page){
			
			$.ajax({
				url:'./project/getCheckedAll',
				type:'get',
				data:{
					field:field,
					start:(page-1)*countInOnePage,
					cnt:countInOnePage
				},
				success:function(list){
					
					$('#projectList').empty();
					
					$.each(list, function(index,item){
						
						$('#projectList').append(
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
				}
			})
		}
	});
}