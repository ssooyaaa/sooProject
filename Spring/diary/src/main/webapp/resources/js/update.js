
$(document).ready(function(){
	
	//firebase
	   if(!firebase.apps.length){
	      firebase.initializeApp(firebaseConfig);
	   }
	   storage = firebase.storage();
	   var selectedFile;
	   
	   $(document).on('click','#write-main-img',function(){
	      $('#main-img-file').trigger('click');
	   });
	   
	   //main이미지 - UI보여주기
	   $(document).on('change','#main-img-file',function(){
	      selectedFile = $(this)[0].files[0];
	      getBase64(selectedFile);
	   });
	
	//수정하기 클릭 -> idx가져오기(model) -> model값 받아오기
	var mydiary_idx=$("#up-mydiary-idx").val();
	console.log(mydiary_idx);
	
	
	
	//다이어리 수정하기
	updateMydiary(mydiary_idx);
	updatePhotos(mydiary_idx);
	updateTrans(mydiary_idx);
	updateAccom(mydiary_idx);
	updateEat(mydiary_idx);
	updateEtc(mydiary_idx);
	updateAbroad(mydiary_idx);
	updateDomestic(mydiary_idx);
	
	
	//more photos-추가/삭제버튼
	morePhotos(mydiary_idx);
	
	
	//tips-추가/삭제버튼
	moreTips();
	
	
	//다이어리 삭제/재저장
	delAndUpdate(mydiary_idx);
});


//firebase - 이미지 upload & 주소받기
function uploadFileAndGetUrl(path,file){
	
	 return new Promise((resolve, reject)=>{

	    var ref = storage.ref(path).child(getRandomInt(0,10000)+'_'+Date.now()+"img.png");
	    
	    if(file==null){//이미지 등록을 안했을 경우
	  	 resolve(""); 
	  	 
	    }else{
	  	  ref.put(file).then(function(snapshot){ //이미지 upload
	  	         ref.getDownloadURL().then(function(url){ //이미지 주소받기
	  	        	 resolve(url);
	  	         }).catch(function(err){console.log(err)});
	  	         
	  	      }).catch(function(err){console.log(err)});
	    }
	         
	 });
 
}



//More Photos 추가/삭제 버튼
function morePhotos(mydiary_idx){
	 //Photos-사진추가버튼
	 var countPhoto = 1;
	 
	 $.ajax({
		url:'./photos/getCountByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(count){
			console.log(count);
			countPhoto=count+1;
		},
		error:function(err){}
	 });
	 
	 $('.btn-more-photos').on('click',function(){
	    
	    if(countPhoto <= 10) {
	       $('#plus-more-photos').append(
	             `<div class="plus-del-photos"> 
	                <input type="file" class="more-photos" id="more-photos"/>
	                <i class="fa-solid fa-angles-right"></i>
	                <input type="text" class="explain-photos" placeholder="사진 추가 설명" id="explain-photos"/>
	                <input type="button" class="btn-delete-photos" style="margin-bottom:10px;" value="삭제"/>
	            
	              </div>`)
	       countPhoto++;
	    } else {
	       alert('최대 10장까지만 가능합니다.');
	    };
	    
	 });
	 
	 
	 //Photos-사진삭제버튼
	 $(document).on('click','.btn-delete-photos',function(){
		 this.parentElement.remove();
		 countPhoto--;
	 });
 
}


//해당 추가사항 삭제
function removeList(){
  this.parentElement.remove();
}


//tips 추가/삭제 버튼
function moreTips(){
	$('#button-add-transport').on('click',function(){
		
		var transport = $('#tips-add-transport').val();
		
		$('.tips-list-transport').append(
				`<div class="tips-list">
					<span class="transport-list">${transport}</span>
					<input type="button" class="tips-remove-button" value="삭제"/>
				 </div>`
		);
		
		$('.tips-remove-button').on('click',removeList);
		$('#tips-add-transport').val('');
	});
	
	$('#button-add-accomodation').on('click',function(){
		
		var accomodation = $('#tips-add-accomodation').val();
		
		$('.tips-list-accomodation').append(
				`<div class="tips-list">
					<span class="accomodation-list">${accomodation}</span>
					<input type="button" class="tips-remove-button" value="삭제"/>
				 </div>`
		);
		
		$('.tips-remove-button').on('click',removeList);
		$('#tips-add-accomodation').val('');
	});
	
	$('#button-add-eat').on('click',function(){
		
		var eat = $('#tips-add-eat').val();
		
		$('.tips-list-eat').append(
				`<div class="tips-list">
					<span class="eat-list">${eat}</span>
					<input type="button" class="tips-remove-button" value="삭제"/>
				 </div>`
		);
		
		$('.tips-remove-button').on('click',removeList);
		$('#tips-add-eat').val('');
	});

	$('#button-add-etc').on('click',function(){
	
		var etc = $('#tips-add-etc').val();
		
		$('.tips-list-etc').append(
				`<div class="tips-list">
					<span class="etc-list">${etc}</span>
					<input type="button" class="tips-remove-button" value="삭제"/>
				 </div>`
		);
		
		$('.tips-remove-button').on('click',removeList);
		$('#tips-add-etc').val('');
	});
}


//다이어리 수정-다이어리
function updateMydiary(mydiary_idx){
	$.ajax({
		url:'./mydiary/getMydiaryByIdx',
		type:'get',
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
			
			console.log(mydiary)
			
			$('#write-header').append(
				`<div class="write-header-content">
					<i class="fa-regular fa-calendar write-calendar"></i>
					<input type="text" class="write-date" id="write-date" placeholder="년.월.일(ex.2022.08.19)" value="${mydiary.date}" />
					<i class="fa-solid fa-cloud-sun write-weather-icon"></i>
					<input type="text" class="write-weather" id="write-weather" placeholder="(ex.맑았지만 너무 추웠음)" value="${mydiary.weather}" />
					<i class="fa-solid fa-location-dot write-location-icon"></i>
					<input type="text" class="write-location" id="write-location" autocomplete="on" placeholder="국내-시,도/지역이름 or 해외-국가/도시" value="${mydiary.nation}"/>
				</div>`	
			);
			
			$('#write-title').append(
				`<span class="write-title-name">TITLE</span>
				<input type="text" class="write-title-content" id="write-title-content" value="${mydiary.title}" />`	
			);
			
			$('#write-container').append(
				`<div class="main-upload-img">
					<input style="display:none;" type="file" id="main-img-file"/>
					<input type="text" id="main-img-url" style="display:none;" value="${mydiary.main_img}"/>
					
					<img class="write-main-img" id="write-main-img" style="object-fit:cover;"
						 src="${mydiary.main_img}"/>
					
					<div class="write-upload">Change Main Image</div>
				</div>
			
				
				<div class="write-body-sub">
					<div class="write-sub-radiobox">
						<div class="radio">
							<input type="radio" id="domestic" name="nation" value="n" ${domesticChecked}>
								국내
							<input type="radio" id="abroad" name="nation" value="y" style="margin-left:20px;" ${abroadChecked}>
								해외
						</div>
					</div>	
					
					<div class="write-sub-location">
						<span class="write-sub-location-name">WHERE?</span>
						<input type="text" class="write-exact-location" id="write-exact-location" value="${mydiary.location}"/>
					</div>
					
					<div class="write-more">
						<div class="write-diary-name">DIARY...
						</div>
						<textarea id="write-diary-full" placeholder="오늘의 하루를 기록해보세요 :)">${mydiary.text}</textarea>
					</div>
					
					
				</div>`	
			);
			
		},
		error:function(err){}
	});
}


//다이어리 수정하기-tips-transport
function updateTrans(mydiary_idx){
	$.ajax({
		url:'./tips/getTransByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(list){
			console.log(list);
			$.each(list,function(index,item){
				$('#tips-list-transport').append(
						`<div class="tips-list" id="tips-list-transport">
							<span class="transport-list">${item.tips_transport}</span>
							<input type="button" class="tips-remove-button" value="삭제"/>
						 </div>`	
				);
				$('.tips-remove-button').on('click',function(){
					this.parentElement.remove();
				});
				
			});
			
		},
		error:function(err){}
	});
};


//다이어리 수정하기-tips-accomodation
function updateAccom(mydiary_idx){
	$.ajax({
		url:'./tips/getAccomByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(list){
			console.log(list);
			$.each(list,function(index,item){
				$('#tips-list-accomodation').append(
						`<div class="tips-list">
							<span class="accomodation-list">${item.tips_accomodation}</span>
							<input type="button" class="tips-remove-button" value="삭제"/>
						 </div>`	
				);
				$('.tips-remove-button').on('click',function(){
					this.parentElement.remove();
				});
				
			});
			
		},
		error:function(err){}
	});
};


//다이어리 수정하기-tips-eat
function updateEat(mydiary_idx){
	$.ajax({
		url:'./tips/getEatByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(list){
			console.log(list);
			$.each(list,function(index,item){
				$('#tips-list-eat').append(
						`<div class="tips-list">
							<span class="eat-list">${item.tips_eat}</span>
							<input type="button" class="tips-remove-button" value="삭제"/>
						 </div>`	
				);
				$('.tips-remove-button').on('click',function(){
					this.parentElement.remove();
				});
				
			});
			
		},
		error:function(err){}
	});
};


//다이어리 수정하기-tips-etc
function updateEtc(mydiary_idx){
	$.ajax({
		url:'./tips/getEtcByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(list){
			console.log(list);
			$.each(list,function(index,item){
				$('#tips-list-etc').append(
						`<div class="tips-list">
							<span class="etc-list">${item.tips_etc}</span>
							<input type="button" class="tips-remove-button" value="삭제"/>
						 </div>`	
				);
				
			});
			$('.tips-remove-button').on('click',function(){
				this.parentElement.remove();
			});
			
		},
		error:function(err){}
	});
};


//다이어리 수정하기-sight-abroad
function updateAbroad(mydiary_idx){
	$.ajax({
		url:'./photos/getAbroadByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(item){
			console.log(item);
			if(item==null || item=="" || item=="undefined"){
				console.log('abroad-nothing');
				$('#write-tips-sight').empty();
				$('#location-filebox').empty();
				$('#write-tips-sight').append(
						`<span class="write-tips-subname">
							<i class="fa-solid fa-square-check"></i>
						숨은 명소</span>
						<input type="text" class="tips-location" id="tips-location" placeholder="(딱 1군데만!) 추천하고싶은 곳의 정확한 위치를 적어주세요 (ex.OO에서 나와서 OO쪽으로 가는길에...)"/>`
					);
					$('#location-filebox').append(
						`<label for="location-img">이미지 첨부</label>
						<input type="file" id="location-img" accept="image/*"/>`
					);
				
			}else{
				$('#write-tips-sight').empty();
				$('#location-filebox').empty();
				$('#write-tips-sight').append(
					`<span class="write-tips-subname">
						<i class="fa-solid fa-square-check"></i>
					숨은 명소</span>
					<input type="text" class="tips-location" id="tips-location" value="${item.sight_desc}"/>`
				);
				$('#location-filebox').append(
					`<label for="location-img">이미지 첨부</label>
					<input type="text" id="sight-img-url" value="${item.sight_img}"/>
					<input type="file" id="location-img" style="display:none;" accept="image/*"/>
					<label for="location-img" style="border:1px solid #1e1e1e; border-radius:3px; padding:3px 5px; background:#EEEDEC; font-weight:500">사진 변경</label>`
				);
			}
			
		},
		error:function(err){}
	});
}


//다이어리 수정하기-sight-domestic
function updateDomestic(mydiary_idx){
	$.ajax({
		url:'./photos/getDomesticByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(item){
			console.log(item);
			if(item==null || item=="" || item=="undefined"){
				console.log('domestic-nothing');
				$('#write-tips-sight').empty();
				$('#location-filebox').empty();
				$('#write-tips-sight').append(
						`<span class="write-tips-subname">
							<i class="fa-solid fa-square-check"></i>
						숨은 명소</span>
						<input type="text" class="tips-location" id="tips-location" placeholder="(딱 1군데만!) 추천하고싶은 곳의 정확한 위치를 적어주세요 (ex.OO에서 나와서 OO쪽으로 가는길에...)"/>`
					);
					$('#location-filebox').append(
						`<label for="location-img">이미지 첨부</label>
						<input type="file" id="location-img" accept="image/*"/>`
					);
			}else{
				$('#write-tips-sight').empty();
				$('#location-filebox').empty();
				$('#write-tips-sight').append(
					`<span class="write-tips-subname">
						<i class="fa-solid fa-square-check"></i>
					숨은 명소</span>
					<input type="text" class="tips-location" id="tips-location" value="${item.sight_desc}"/>`
				);
				$('#location-filebox').append(
					`<label for="location-img">이미지 첨부</label>
					<input type="text" id="sight-img-url" value="${item.sight_img}"/>
					<input type="file" id="location-img" style="display:none;" accept="image/*" value="${item.sight_img}"/>
					<label for="location-img" style="border:1px solid #1e1e1e; border-radius:3px; padding:3px 5px; background:#EEEDEC; font-weight:500">사진 변경</label>`
				);
			}
			
		},
		error:function(err){}
	});
}


//다이어리 수정하기-more photos
function updatePhotos(mydiary_idx){
	$.ajax({
		url:'./photos/getPhotosByIdx',
		type:'get',
		data:{mydiary_idx:mydiary_idx},
		success:function(list){
			console.log(list);
			
			var sortingField = 'sequence';
			
			list.sort(function(a,b){
				return a[sortingField] - b[sortingField];
			});
			
			$.each(list,function(index,item){
				$('#plus-more-photos').append(
						`<div class="plus-del-photos">
							  <input type="file" class="more-photos" id="more-photos" style="display:none"/>
			                  <input type="hidden" style="width:245px; margin-left:30px;" id="more-photos-url" class="more-photos-url" value="${item.photos}"/>
			                  <img src="${item.photos}" style="margin-left:70px;margin-bottom:10px;width:150px;height:150px;"/>
			                  <i class="fa-solid fa-angles-right"></i>
				              <input type="text" class="explain-photos" value="${item.explain_text}" id="explain-photos" placeholder="사진 추가 설명"/>
				              <input type="button" class="btn-delete-photos" style="margin-bottom:10px;" value="삭제"/>

			            </div>`
				);
			});
			
		},
		error:function(err){}
	});
};


//다이어리 삭제/재저장
function delAndUpdate(mydiary_idx){
	
	$('#modify-button').on('click',function(){
		
		$('.write-body').hide();
		$('.header').hide();
		$('.loading').show();
		
		   
		$.ajax({
			url:'./update/del',
			type:'post',
			data:{mydiary_idx:mydiary_idx},
			success:function(res){
				if(res=='ok'){
					modify().then(function(){
						alert('수정이 완료되었습니다.');
						location.replace('./mydiary');
					})
					
				}else{
					alert('수정 실패했습니다.');
				}
			},
			complete:function(){
				$('.loading').hide();
			},
			error:function(err){}
		});
	});
}





//다이어리 저장
//데이터 셋팅 및 DB저장
function modify(){
	
	return new Promise(function(resolve,reject){
		
		var data={
			      'write_date':'',
			      'write_weather':'',
			      'write_location':'',
			      'write_title_content':'',
			      'abroad':'', //국내,해외
			      'write_exact_location':'',
			      'write_diary_full':'',
			      
			      'main_img_file':'',//이미지 url
			    
			      'more_photos':[], //['url','url',...]
			      'more_photos_desc':[],
			        
			      'transport':[],
			      'accomodation':[],
			      'eat':[],
			      'etc':[],
			      
			      'sight_img':'', //이미지 url
			      'sight_desc':'',
			      
			      'sequence':[],
			      'sequence_desc':[]
			      
			   }
			   
			  var promiseArr = [];
			  
			  //data 작성
			  
			  //1. 기본 데이터 작성
			  data['write_date']=$('#write-date').val();
			  data['write_weather']=$('#write-weather').val();
			  data['write_location']=$('#write-location').val();
			  data['write_title_content']=$('#write-title-content').val();
			  data['abroad']= $('input[name="nation"]:checked').val();
			  data['write_exact_location']=$('#write-exact-location').val();
			  data['write_diary_full']=$('#write-diary-full').val();
			  
			  data['sight_desc']=$('#tips-location').val(); //숨은명소 위치 설명
			  
			  
			  //2. 메인이미지 파베 업로드
			  var p1 = new Promise(function(resolve, reject){
				  
				  if($('#main-img-file')[0].files[0]!=null){
					  
					  uploadFileAndGetUrl('mydiary/update',$('#main-img-file')[0].files[0])
					  .then(function(url){
					        data['main_img_file']=url;
					        console.log(url);
					        resolve();
					     });
				  }else{
					data['main_img_file']=$('#main-img-url').val();
					resolve();
				  }; 
			    
			  });
			  
			  promiseArr.push(p1);
			  
			  
			  //3. more photos - 이미지
			  var p2 = new Promise(function(resolve,reject){
				 
				  if($('#more-photos').length>0){
					  console.log('있음');
					   
					  if($('.more-photos')[0].files[0]!=null || $('.more-photos')[0].files[0]!=undefined){
						  
						  var newPlusArr=[];
						  
						  $.each($('.more-photos'),function(index,item){
							  	
								var file = $(item)[0].files[0];
								
								var newPlusUrl = new Promise(function(rrr,jjj){
									uploadFileAndGetUrl('photos',file)
									.then(function(url){
										data['more_photos'].push(url);
										console.log(url);
										data['sequence'].push(index);
										rrr();
									})
								});
								
								newPlusArr.push(newPlusUrl);
								
							}); 
						  
						  Promise.all(newPlusArr).then((values) => {
							  resolve(); //p2 에 대응하는 resolve();
						  });
						  
					  }else{
						 
						  $.each($('.more-photos-url'),function(index,item){
							    
							  console.log('789456');
								var savedUrl = $(item).val();
								
								console.log(savedUrl);
								
								data['more_photos'].push(savedUrl);
								data['sequence'].push(index);
								
							});
						  var plusUrlArr=[];
						  
						  $.each($('.more-photos'),function(index,item){
							 
							  console.log('마지막 추가');
							  var file = $(item)[0].files[0];
							  
							  if(file==null || file ==undefined){
								  console.log('추가파일없음');
							  } else{
								  console.log('추가파일있음');
								  console.log(file);
								  
								  var plusUrl = new Promise(function(rrr,jjj){
									  uploadFileAndGetUrl('photos',file)
							            .then(function(url){
							            	
							               data['more_photos'].push(url);
							               data['sequence'].push(index);
							               console.log('파일추가');
							               rrr(); 
							               
							            });  
								  });
								  
								  
								  plusUrlArr.push(plusUrl);
								  
								 
							  }
				               
							 
						  });
						  
						  Promise.all(plusUrlArr).then((values) => {
							  resolve(); //p2 에 대응하는 resolve();
						  });
						  
					  }
				  }  
				  else{
					  console.log('없음');
					  resolve("");
				  }
				   
			  }); 
			 
			  $.when(p2).then(function (){
				  promiseArr.push(p2);
				});
			  
			  
			  //4. more photos - 내용
			  $.each($('.explain-photos'), function(index,item){
				  
				 var p3 = new Promise(function(resolve, reject){
			         var value = $(item).val();
			         data['more_photos_desc'].push(value);
			         data['sequence_desc'].push(index);
			         
			         resolve();
			         
			         
			         
				 });
				 
				 promiseArr.push(p3);
				 
			  });
			 
			  
			  //5. tips
			  $.each($('.transport-list'), function(index,item){
				  
				  var p4 = new Promise(function(resolve, reject){
					  var value = $(item).text();
			    	  data['transport'].push(value);
			    	  resolve();
				  });
				  
				  promiseArr.push(p4);

			  });
			 
			  
			  $.each($('.accomodation-list'), function(index,item){
				  
				  var p5 = new Promise(function(resolve, reject){
					  var value = $(item).text();
			    	  data['accomodation'].push(value);
			    	  resolve();
				  });
				  
				  promiseArr.push(p5);

			  });

			  
			  
			  $.each($('.eat-list'), function(index,item){
				  var p6 = new Promise(function(resolve, reject){
					  var value = $(item).text();
			  	  data['eat'].push(value);
			  	  resolve();
				  });
				  
				  promiseArr.push(p6);
			  
			  });

			  $.each($('.etc-list'), function(index,item){
				  
				  var p7 = new Promise(function(resolve, reject){
					  var value = $(item).text();
			  	  data['etc'].push(value);
			  	  resolve();
				  });
				  
				  promiseArr.push(p7);

			  });
			  
			  
			  //6. 숨은 명소 - 이미지
			  var p8 = new Promise(function(resolve, reject){
				  
				  if($('#location-img')[0].files[0]!=null){
					  uploadFileAndGetUrl('sight',$('#location-img')[0].files[0])
				      .then(function(url){
				    	 data['sight_img']=url;
				    	 resolve();
				      }); 
				  }else{
					 data['sight_img']= $('#sight-img-url').val();
					 resolve();
				  }
				  
			  });
			  
			  promiseArr.push(p8);
			  
			  
			  Promise.all(promiseArr).then((values) => {
				 console.log('=================data=============');
			     console.log(data);
			     
			     
			     //ajax 저장
			     $.ajax({
			   	  url:'./write/add',
			   	  type:'post',
			   	  contentType: 'application/json;charset=UTF-8',
			   	  data : JSON.stringify(data),//string으로 받음(즉,"ok"로 return 받아짐)
			   	  //dataType:json(json)으로 받음
			   	  //contentType:보내는 타입
			   	  //dataType:받는 타입
			   	  
			   	  success:function(res){
			   		  console.log('------ok-------');
			   		  console.log(res);
			   		  resolve();
			   		  
			   	  },
			   	  error:function(err){
			   		  console.log('-----err-----');
			   		  console.log(err);
			   	  }
			     });
			  });
	});
	
   
}



//이미지 파일 저장시, 랜덤변수 지정
function getRandomInt(min, max) {
     min = Math.ceil(min);
     max = Math.floor(max);
     return Math.floor(Math.random() * (max - min)) + min; //최댓값은 제외, 최솟값은 포함
};


//firebase-UI 보여주기
function getBase64(file) {
      var reader = new FileReader();
      reader.readAsDataURL(file);
      
      reader.onload = function () {  
       $('#write-main-img').attr('src',reader.result);
      };
      
      reader.onerror = function (error) {
        console.log('Error: ', error);
      };
};

