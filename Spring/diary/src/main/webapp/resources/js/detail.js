$(document).ready(function(){
	
	
	//더보기 클릭 -> 해당 idx(./detail에 )model값 넣어주기 -> 해당 model값 받아오기
	//다이어리 더보기
	var mydiary_idx=$("#k-mydiary-idx").val();
		
	MoreMydiary(mydiary_idx);
	
	MorePhotos(mydiary_idx);
	
	MoreTransport(mydiary_idx);
	
	MoreAccomodation(mydiary_idx);
	
	MoreEat(mydiary_idx);
	
	MoreEtc(mydiary_idx);
	
	MoreAbroad(mydiary_idx);
	
	MoreDomestic(mydiary_idx);
	
	
	//다이어리 수정하기
	$(document).on('click','.detail-edit',function(){
		
		var mydiary_idx= $(this).closest('.detail-header').data('mydiary-idx');
		console.log(mydiary_idx);
		
		location.href='./update?mydiary_idx='+mydiary_idx;		
	});
	
	
	//다이어리 삭제
	delMydiary(mydiary_idx);
	
	
	
		
});

//다이어리 더보기-Mydiary
function MoreMydiary(mydiary_idx){
	$.ajax({
		url:'./mydiary/getMydiaryByIdx',
		type:'get',
		async:false,
		data:{'mydiary_idx':mydiary_idx},
		success:function(mydiary){
			
			var abroadChecked;
			var domesticChecked;
			if(mydiary.abroad=='y'){
				abroadChecked='checked';
				domesticChecked='';
			}else{
				domesticChecked='checked';
				abroadChecked='';
			}
			
			if(mydiary.main_img==undefined || mydiary.main_img==''){
			    mydiary.main_img='https://th.bing.com/th/id/OIP.WxXxdjuWlFaeUX8DbC6mZQHaHa?pid=ImgDet&w=512&h=512&rs=1'
			}else{
				mydiary.main_img;
			}
			
			$('#detail-body').prepend(
					`<div class="detail-header" data-mydiary-idx="${mydiary.mydiary_idx}">
						<div class="detail-header-content">
							<i class="fa-regular fa-calendar detail-calendar"></i>
							<span class="detail-date">${mydiary.date==null ? '' : mydiary.date}</span>
							<i class="fa-solid fa-cloud-sun detail-weather-icon"></i>
							<span class="detail-weather">${mydiary.weather}</span>
							<i class="fa-solid fa-location-dot detail-location-icon"></i>
							<span class="detail-location">${mydiary.nation}</span>
						</div>
						<div class="detail-edit-delete">
							<div class="detail-edit">수정하기
								<i class="fa-solid fa-pencil"></i>
							</div>
							<div class="detail-delete">삭제하기
								<i class="fa-solid fa-trash"></i>
							</div>
							
							
						</div>
						
					</div>
					
					<div class="detail-title">
						<span class="detail-title-name">TITLE</span>
						<span class="detail-title-content">${mydiary.title}</span>
					</div>
					
					
					<div class="detail-container">
						<img class="detail-main-img" src="${mydiary.main_img}"/>
						<div class="detail-body-sub">
							<div class="detail-sub-radiobox">
								<div class="radio">
									<input type="radio" id="domestic" name="nation" value="domestic" ${domesticChecked}>
										국내
									<input type="radio" id="abroad" name="nation" value="abroad" style="margin-left:20px;" ${abroadChecked}>
										해외
								</div>
								<span class="more-photo" onclick="openS()">
									<i class="fa-solid fa-square-caret-down"></i>
									사진더보기
									
								</span>
								
								<div id="mySide" class="side">
									<a href="javascript:void(0)" class="close" onclick="closeS()">&times;</a>
									<div class="side-wrapper-name">
										<i class="fa-solid fa-camera"></i>
									MORE PHOTOS</div>
									<div class="side-wrapper" id="side-wrapper">
										
									</div>
								</div>
								
								<script>
									function openS(){
										document.getElementById("mySide").style.width="380px";
										document.getElementById("body").style.marginLeft="380px";
									}
									
									function closeS(){
										document.getElementById("mySide").style.width="0";
										document.getElementById("body").style.marginLeft="0";
									}
								</script>
								
							</div>	
							
							<div class="detail-sub-location">
								<span class="detail-sub-location-name">WHERE?</span>
								<span class="detail-exact-location">${mydiary.location}</span>
							</div>
							
							<div class="detail-more">
								<div class="detail-diary-name">DIARY...
								</div>
								<a class="detail-diary">${mydiary.text}
								</a>
							</div>
						</div>		
					</div>
				`
			)
		},
		error:function(err){}
	});
}


//다이어리 더보기-tips-transport
function MoreTransport(mydiary_idx){
	$.ajax({
		url:'./tips/getTransByIdx',
		type:'get',
		data:{'mydiary_idx':mydiary_idx},
		success:function(list){
			console.log(list);
			$.each(list,function(index,item){
				$('#detail-tips-content-trans').append(
					`<li>${item.tips_transport}</li>`	
				);
			});
			
		},
		error:function(err){}
	});
	
}


//다이어리 더보기-tips-accomodation
function MoreAccomodation(mydiary_idx){
	$.ajax({
		url:'./tips/getAccomByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(list){
			console.log(list);
			$.each(list,function(index,item){
				$('#detail-tips-content-accom').append(
					`<li>${item.tips_accomodation}</li>`	
				);
			});
			
		},
		error:function(err){}
	});
	
}


//다이어리 더보기-tips-eat
function MoreEat(mydiary_idx){
	$.ajax({
		url:'./tips/getEatByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(list){
			console.log(list);
			$.each(list,function(index,item){
				$('#detail-tips-content-eat').append(
					`<li>${item.tips_eat}</li>`	
				);
			});
			
		},
		error:function(err){}
	});
	
}


//다이어리 더보기-tips-etc
function MoreEtc(mydiary_idx){
	$.ajax({
		url:'./tips/getEtcByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(list){
			console.log(list);
			$.each(list,function(index,item){
				$('#detail-tips-content-etc').append(
					`<li>${item.tips_etc}</li>`	
				);
			});
			
		},
		error:function(err){}
	});
	
}


//다이어리 더보기-tips-숨은명소-abroad
function MoreAbroad(mydiary_idx){
	$.ajax({
		url:'./photos/getAbroadByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(item){
			console.log(item);
			if(item==null || item=="" || item=="undefined"){
				console.log("abroadX");
			}else{
				$('#detail-tips-sight').append(
						`<div class="detail-sight-desc">${item.sight_desc}</div>
						<div class="detail-tips-map-pin" id="mappin-icon" onclick="openMapPop()">
						<i class="fa-solid fa-location-dot"></i>
						사진보기
						</div>
						<div class="popup" id="mappin-popup">
						<button type="button" onclick="closeMapPop()">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<img src="${item.sight_img}"/>
						</div>`
				);
			}
			
		},
		error:function(err){}
	});
}


//다이어리 더보기-tips-숨은명소-domestic
function MoreDomestic(mydiary_idx){
	$.ajax({
		url:'./photos/getDomesticByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(item){
			console.log(item);
			
			if(item==null || item=="" || item=="undefined"){
				console.log("domX");
				
			}else{
				$('#detail-tips-sight').append(
						`<div class="detail-sight-desc">${item.sight_desc}</div>
						<div class="detail-tips-map-pin" id="mappin-icon" onclick="openMapPop()">
						<i class="fa-solid fa-location-dot"></i>
						사진보기
						</div>
						<div class="popup" id="mappin-popup">
						<button type="button" onclick="closeMapPop()">
							<i class="fa-solid fa-xmark"></i>
						</button>
						<img src="${item.sight_img}"/>
						</div>`
				);
			}
			
		},
		error:function(err){}
	});
}


//다이어리 더보기-more photos
function MorePhotos(mydiary_idx){
	$.ajax({
		url:'./photos/getPhotosByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(list){
			
			var sortingField = 'sequence';
			
			list.sort(function(a,b){
				return a[sortingField] - b[sortingField];
			});
			
			console.log(list);
			
			$.each(list,function(index,item){
				$('#side-wrapper').append(
						`<img class="side-img" src="${item.photos}"/>
						<div class="side-img-desc">${item.explain_text}</div>`
				);
			});
			
		},
		error:function(err){}
	});
};


//삭제하기
function delMydiary(mydiary_idx){
	$('.detail-delete').on('click',function(){
		
		var con = confirm('정말로 삭제하시겠습니까?');
		
		if(con==true){
			$.ajax({
				url:'./update/del',
				type:'post',
				data:{mydiary_idx:mydiary_idx},
				success:function(res){
					if(res=='ok'){
						alert('삭제되었습니다.');
						location.replace('./mydiary');
					}else{
						alert('삭제 실패되었습니다.');
					}
				},
				error:function(err){}
			});
		}
	});

}
