	
$(document).ready(function(){
	
	var user_idx = $('#map-user-idx').val();
	
	//구글맵
	$.ajax({
		url:'./mydiary/getNation',
		type:'get',
		data:{user_idx:user_idx},
		dataType:'json',
		success:function(list){
			var addressArray = new Array; //주소지 배열
			var contentArray = new Array; //마커 내용 배열
			
			$.each(list, function(index,item){
				addressArray.push(item.nation);
				contentArray.push(item.nation);
			});
			
			var mapOptions = {
					center: { lat: 30.316487, lng: 155.199099 },
				    zoom: 2	
			}
			map = new google.maps.Map(document.getElementById("googleMap"),
					mapOptions);
			var marker = null;
			
			for(var i=0;i<addressArray.length;i++){
				addMarker(map,addressArray[i],contentArray[i]);
			}
		}
	})
	
	//다이어리 작성하기 버튼
	$('.mydiary-write').on('click',function() {
		location.href='./write';
	});
	

	//다이어리 더보기
	$(document).on('click','.mydiary-content-more',function(){
		
		var mydiary_idx= $(this).closest('.mydiary-content').data('mydiary-idx');
		console.log(mydiary_idx);
		
		location.href='./detail?mydiary_idx='+mydiary_idx;		
	});
	
	
	//페이지네이션
	pagination();
	
	
	//다이어리 검색
	searchDiary();
		
});



//구글맵 마커등록
function addMarker(map, address, content){
	var geocoder = new google.maps.Geocoder();
	geocodeAddress(geocoder,map);
	  
	  function geocodeAddress(geocoder, resultMap){
		  
		  geocoder.geocode({'address':address},function(result, status){
			 
			  if(status==google.maps.GeocoderStatus.OK){
				  resultMap.setCenter(result[0].geometry.location);
				  resultMap.setZoom(2);
				  
				 
				  var infowindow = new google.maps.InfoWindow({
					  content : content
				  });
				  
				  var marker = new google.maps.Marker({
					  map:resultMap,
					  position:result[0].geometry.location
				  });
				  
				  var marker
				  
				  google.maps.event.addListener(marker,'click',function(){
					  infowindow.open(map, marker);
				  });
				  
			  }else{
				  alert('나라/지역이름이 올바르지않아 지도에 불러오지 못했습니다.');
			  }
		  })
	  }
}


//다이어리 검색
function searchDiary(){
	$('#search-glass').on('click',function(){
		$('#forMap').hide();
		$('#pagination-demo').twbsPagination('destroy');
		
		var nation = $('#search').val();
		var countInOnePage=6;
		var totalPages=0;
		
		$('#mydiary-container').empty();
		
		$.ajax({
			url:'./mydiary/getCountAfterSearch',
			type:'get',
			async:false,
			data:{'nation':nation},
			success:function(count){
				totalPages = Math.ceil(count/countInOnePage);
			},
			error:function(err){}
		});
		
		
		$('#pagination-demo').twbsPagination({
			totalPages:totalPages,
			visiblePages:3,
			first:'처음',
			prev:'<<',
			next:'>>',
			last:'마지막',
			onPageClick: function(event, page){
				
				$.ajax({
					url:'./mydiary/getMydiaryChunkAfterSearch',
					type:'get',
					data:{
						'nation':nation,
						start:(page-1)*countInOnePage,
						cnt:countInOnePage
					},
					success:function(list){
						console.log(list);
				
						$.each(list,function(index,item){
							
							if(item.main_img==undefined || item.main_img==''){
							    item.main_img='https://th.bing.com/th/id/OIP.WxXxdjuWlFaeUX8DbC6mZQHaHa?pid=ImgDet&w=512&h=512&rs=1'
							}else{
								item.main_img;
							}
							
							$('#mydiary-container').append(
									`<div class="mydiary-content" data-mydiary-idx="${item.mydiary_idx}">
										<img class="mydiary-content-main-img" id="mydiary-content-main-img" src="${item.main_img}"/>
										<div class="mydiary-content-main-content">
											<div class="mydiary-content-main-text">${item.title}
											</div>
											<div class="mydiary-content-sub-text">${item.location}
											</div>
											<i class="fa-solid fa-location-dot mydiary-content-location">
												<span style="font-family:hip; font-weight:500;">${item.nation}</span>
											</i>
											<i class="fa-regular fa-calendar mydiary-content-calendar">
												<span style="font-family:hip;">${item.date}</span>
											</i>
											<i class="fa-solid fa-cloud-sun mydiary-content-weather">
												<span style="font-family:hip; font-weight:500;">${item.weather}</span>
											</i>
										</div>
										<div class="mydiary-content-more">다이어리 더보기
											<i class="fa-solid fa-circle-right more-button"></i>
										</div>
									</div>
									`								
							)
							
						})
					},
					error:function(err){}
					
				})
			}
			
		});
	});
	
};


//다이어리 본화면(페이지네이션)
function pagination(){
	
	var totalPages=0;
	var countInOnePage=6;
	
	$.ajax({
		url:'./mydiary/getCount',
		type:'get',
		data:{},
		async:false,//비동기 여부
		success:function(count){
			totalPages=Math.ceil(count/countInOnePage);
		},
		error:function(error){}
	});
	
	
	$('#pagination-demo').twbsPagination({
		totalPages:totalPages,
		visiblePages:3,
		first:'처음',
		prev:'<<',
		next:'>>',
		last:'마지막',
		onPageClick: function(event, page){
			
			$.ajax({
				url:'./mydiary/getMydiaryChunk',
				type:'get',
				data:{
					start:(page-1)*countInOnePage,
					cnt:countInOnePage
				},
				success:function(list){
					
					console.log(list);
					$('#mydiary-container').empty();
					
					$.each(list,function(index,item){
						
						if(item.main_img==undefined || item.main_img==''){
						    item.main_img='https://th.bing.com/th/id/OIP.WxXxdjuWlFaeUX8DbC6mZQHaHa?pid=ImgDet&w=512&h=512&rs=1'
						}else{
							item.main_img;
						}
						
						$('#mydiary-container').append(
								`<div class="mydiary-content" data-mydiary-idx="${item.mydiary_idx}">
									<img class="mydiary-content-main-img" id="mydiary-content-main-img" src="${item.main_img}"/>
									<div class="mydiary-content-main-content">
										<div class="mydiary-content-main-text">${item.title}
										</div>
										<div class="mydiary-content-sub-text">${item.location}
										</div>
										<i class="fa-solid fa-location-dot mydiary-content-location">
											<span style="font-family:hip; font-weight:500;">${item.nation}</span>
										</i>
										<i class="fa-regular fa-calendar mydiary-content-calendar">
											<span style="font-family:hip;">${item.date}</span>
										</i>
										<i class="fa-solid fa-cloud-sun mydiary-content-weather">
											<span style="font-family:hip; font-weight:500;">${item.weather}</span>
										</i>
									</div>
									<div class="mydiary-content-more">다이어리 더보기
										<i class="fa-solid fa-circle-right more-button"></i>
									</div>
								</div>
								`								
						)
						
					})
				},
				error:function(err){}
				
			})
		}
		
	});
};
