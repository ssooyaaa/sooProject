$(document).ready(function(){
	
	var loginUserIdx = $('#map-user-idx').val();
	var kakaoUserIdx = $('#map-kakao-idx').val();
	
	if(loginUserIdx==null || loginUserIdx==''){
		loginUserIdx = kakaoUserIdx;
	}
	
	console.log(loginUserIdx);
	
	//모든 리스트 가져오기
	getAllList('');
	
	
	//옵션 선택 리스트 가져오기
	$('.search-icon').click(function(){
		
		var selectOption = $('#date-mode option:selected').val();
		
		$('#pagination-demo').twbsPagination('destroy');
		$('.allList').empty();
		
		getAllList(selectOption);
	});
	
	
	
	//일정클릭-일정보기
	$(document).on('click','.allList-item',function(){
		var smIdx = $(this).children().eq(2).val();
		console.log(smIdx);
		
		location.href='./newList?sm_idx='+smIdx;
	});
	
	
	//새일정짜기
	$('.move-newTitle').click(function(){
		location.href='./newTitle';
	});
	
	
	//여행경비
	$('.move-expense').click(function(){
		location.href='./tripExpenses?user_idx='+loginUserIdx;
	});
	
});


//정렬하기
function sortResults(result, prop, asc) {
    SortedResult = result.sort(function(a, b) {
    	if (asc) { 
    		return (a[prop] > b[prop]) ? 1 : ((a[prop] < b[prop]) ? -1 : 0);
    	} else {
    		return (b[prop] > a[prop]) ? 1 : ((b[prop] < a[prop]) ? -1 : 0);
    	}
    });
    return SortedResult;
}



//모든리스트 가져오기
function getAllList(selectOption){
	
	var totalPages=0;
	var countInOnePage=5;
	var totalCount=0;
		
	$.ajax({
		url:'./allList/getCountAllList',
		type:'get',
		data:{},
		async:false,
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
			totalCount=count;
		},
		error:function(err){}
	})
	
	if(totalCount==0){
		$('.allList').append(
				`<div class="allList-title">존재하는 리스트가 없습니다.</div>`
		);
	}else{
		$('#pagination-demo').twbsPagination({
			totalPages:totalPages,
			visiblePages:3,
			first:'<<',
			prev:'<',
			next:'>',
			last:'>>',
			onPageClick:function(event, page){
				
				$.ajax({
					url:'./allList/getAllList',
					type:'get',
					data:{},
					success:function(map){
						
						$('.allList').empty();
						
						var userMap = map.userIdMap;
						
						var result = map.allList;
						
						if(selectOption==''){
							result = sortResults(result, "start_date");
						}else if(selectOption=='old'){
							result = sortResults(result, "start_date","asc");
						}
						
						var start = (page-1)*countInOnePage;
						
						var pageResult = $(result).slice(start, start+countInOnePage);
						
						//오늘 날짜 구하기
						var today = getToday();
						
						
						$.each(pageResult, function(index,item){
							var smIdx = item.sm_idx;
							var end_date = item.end_date;
							
							$('.allList').append(
									`<div class="allList-item">
										<div class="allList-title">
											<span class="item-title" style="width:90%;">${item.name}</span>
											
										</div>
										<div class="allList-date">
											<span style="font-family:home-name;width:13%;">DATE</span>
											<span>${item.start_date} ~ ${item.end_date}</span>
										</div>
										<input style="display:none" id="smIdx${item.sm_idx}" value=${item.sm_idx} />
										<div class="allList-friends">
											<div style="font-family:home-name;width:13%;">WITH</div>
											<div class="friends">
												
												
											</div>
										</div>
									</div>`
							);
							
							$.each(userMap, function (key, val) {
								if(key==smIdx){
									var smIdxElement = $('#'+'smIdx'+key).siblings('.allList-friends');
									var child = $(smIdxElement).children().eq(1);
									
									$.each(val, function(index,item){
										$(child).append(
												`<span style="margin-right:15px">${item}</span>`
										);
									});
									
								}
								
							});
							
							var statusElement = $('#'+'smIdx'+smIdx).siblings('.allList-title');
							
							if(end_date>=today){
								$(statusElement).append(
										`<span class="item-status">진행중</span>`
								);
							}else{
								$(statusElement).append(
										`<span style="background:#E74C3C" class="item-status">종료</span>`
								);
							}
							
							
						});
					},
					error:function(err){}
				})
				
				
			}
		});
	}
	
	
	
	
}


//오늘날짜구하기
function getToday(){     
	var now = new Date();     
	var year = now.getFullYear();     
	var month = now.getMonth() + 1;
	var date = now.getDate();     
	month = month >=10 ? month : "0" + month;  
	date = date >= 10 ? date : "0" + date;

	return ""+year+"-"+month+"-"+date; 
}
