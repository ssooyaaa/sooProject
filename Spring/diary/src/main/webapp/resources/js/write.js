
$(document).ready(function(){
	
	//firebase 이미지
	if(!firebase.apps.length){
		firebase.initializeApp(firebaseConfig);
	}
	var storage = firebase.storage();
	var selectedFile;
	
	$('#write-main-img').on('click',function(){
		$('#main-img-file').trigger('click');
	});
	
	$('#main-img-file').on('change',function(){
		selectedFile = $(this)[0].files[0];
		//UI에서 보여주기
		getBase64(selectedFile);
	});
	
	$('#upload-btn').click(function(){
		var uploadFiles = $('#main-img-file')[0].files;
		
		for(var i = 0; i < uploadFiles.length; i++){
			var oneFile = uploadFiles[i];
			var ref = storage.ref('mydiary').child(getRandomInt(0,100)+'_'+Date.now()+"img.png");
			ref.put(oneFile).then(function(snapshot){
				//업로드 완료
				console.log('업로드 완료');
			}).catch(function(err){
				//업로드 실패
				console.log('업로드 실패');
			});
		}
	});

	//save버튼-다이어리 메인 저장
	$('#save-button').click(function(){
		var date = $('#write-date').val();
		var weather = $('#write-weather').val();
		var nation = $('#write-location').val();
		var title = $('#write-title-content').val();
		var abroad = $('input:radio[name="nation"]:checked').val();
		var location = $('#write-exact-location').val();
		var text = $('#write-diary-full').val();
		
		//1단계 storage에 이미지 업로드 & 주소받기
		var ref = storage.ref('mydiary').child(getRandomInt(0,10000)+'_'+Date.now()+"img.png");
		ref.put(selectedFile).then(function(snapshot){
			//업로드완료
			console.log('업로드 완료');
			
			ref.getDownloadURL().then(function(url){
				//다운로드주소url -> ajax로 DB에 INSERT

				$.ajax({
					url:'./mydiary/addMydiary',
					type:'post',
					data:{
						'date':date,
						'weather':weather,
						'nation':nation,
						'title':title,
						'abroad':abroad,
						'location':location,
						'text':text,
						'main_img':url
					},
					success:function(res){
						if(res != 0){
							var newDiaryIdx=res;
							
							var storage = firebase.storage();
							var addFiles = $('input.more-photos');
							var explain_text = $('#explain-photos').val();
									
							$.each(addFiles,function(index, selected){
								var onePhoto = $(selected)[0].files[0];
								console.log(onePhoto);
							
								var ref = storage.ref('photos').child(getRandomInt(0,10000)+'_'+Date.now()+"img.png");
								ref.put(onePhoto).then(function(snapshot){
									
									console.log('업로드 완료');
									
									ref.getDownloadURL().then(function(url){
										$.ajax({
											url:'./photos/addPhotos',
											type:'post',
											data:{
												'photo':url,
												'explain_text':explain_text,
												'diary_idx':newDiaryIdx
											},
											success:function(res){
												if(res=='ok'){
													alert('사진 등록 완료');
												}else{
													alert('사진 등록 실패');
												}
											},
											error:function(err){
												
											}
										});
									}).catch(function(err){
										console.log('업로드 실패');
									});
								}); 
							});
						}else{
							alert('모든 항목을 채워주세요.');
						}
					},
					error:function(err){}
				});
			}).catch(function(err){
				
			});
		}).catch(function(err){
			//업로드 실패
			console.log('업로드 실패');
		});	
	});
	
	
	// 이미지 관련 세팅 - more-photos
	morePhotos();
	
	
});
	

function morePhotos(){
	//Photos-사진추가버튼
	var countPhoto = 1;
	$('.btn-more-photos').on('click',function(){
		
		if(countPhoto <= 10) {
			$('#plus-more-photos').append(
					`<div class="plus-del-photos">
						<input type="file" class="more-photos" id="more-photos"/>
						<i class="fa-solid fa-angles-right">
						<input type="text" placeholder="사진 추가 설명" id="explain-photos"/>
						</i>
					 </div>`)
			countPhoto++;
		} else {
			alert('최대 10장까지만 가능합니다.');
		};
		
	});
	
	//Photos-사진삭제버튼
	$('.btn-delete-photos').on('click',function(){
		$('.plus-del-photos').last().remove();
	});
	
	
	//save버튼-more photos저장
	$('#save-button').click(function(){
		
		var storage = firebase.storage();
		var addFiles = $('input.more-photos');
		var explain_text = $('#explain-photos').val();
				
		$.each(addFiles,function(index, selected){
			var onePhoto = $(selected)[0].files[0];
			console.log(onePhoto);
		
			var ref = storage.ref('photos').child(getRandomInt(0,10000)+'_'+Date.now()+"img.png");
			ref.put(onePhoto).then(function(snapshot){
				
				console.log('업로드 완료');
				
				ref.getDownloadURL().then(function(url){
					$.ajax({
						url:'./photos/addPhotos',
						type:'post',
						data:{
							'photo':url,
							'explain_text':explain_text
						},
						success:function(res){
							if(res=='ok'){
								alert('사진 등록 완료');
							}else{
								alert('사진 등록 실패');
							}
						},
						error:function(err){
							
						}
					});
				}).catch(function(err){
					console.log('업로드 실패');
				});
			}); 
		});
		
	});
	
	
	$('#button-add-transport').on('click', function() {
		//tips 추가
		var removeBtn = document.createElement('input');
		removeBtn.type='button';
		removeBtn.className='tips-remove-button';
		removeBtn.value="삭제";
		
		
		var flex = document.createElement('li');
		flex.className='transport-list';
		
		var transport = $('#tips-add-transport').val();
		var transport_list = $('#transport-tips-list');
	
		transport_list.append(flex);
		flex.append(transport);
		flex.append(removeBtn);
	
		//tips 삭제
		removeBtn.addEventListener('click' , removeList);
	});
	
	function removeList(){
		this.parentElement.remove();
	}
	
	$('#button-add-accomodation').on('click', function() {
		var removeBtn = document.createElement('input');
		removeBtn.type='button';
		removeBtn.className='tips-remove-button';
		removeBtn.value="삭제";
		
		var flex = document.createElement('li');
		flex.className='accomodation-list';
		
		var accomodation = $('#tips-add-accomodation').val();
		var accomodation_list = $('#accomodation-tips-list');
	
		accomodation_list.append(flex);
		flex.append(accomodation);
		flex.append(removeBtn);
	
		removeBtn.addEventListener('click' , removeList);
	});
	
	
	$('#button-add-eat').on('click', function() {
		var removeBtn = document.createElement('input');
		removeBtn.type='button';
		removeBtn.className='tips-remove-button';
		removeBtn.value="삭제";
		
		var flex = document.createElement('li');
		flex.className='eat-list';
		
		var eat = $('#tips-add-eat').val();
		var eat_list = $('#eat-tips-list');
	
		eat_list.append(flex);
		flex.append(eat);
		flex.append(removeBtn);
	
		removeBtn.addEventListener('click' , removeList);
	});

	$('#button-add-location').on('click', function() {
		var removeBtn = document.createElement('input');
		removeBtn.type='button';
		removeBtn.className='tips-remove-button';
		removeBtn.value="삭제";
		
		var flex = document.createElement('li');
		flex.className='location-list';
		
		var location = $('#tips-add-location').val();
		var location_list = $('#location-tips-list');
	
		location_list.append(flex);
		flex.append(location);
		flex.append(removeBtn);
	
		removeBtn.addEventListener('click' , removeList);
	});


	$('#button-add-etc').on('click', function() {
		var removeBtn = document.createElement('input');
		removeBtn.type='button';
		removeBtn.className='tips-remove-button';
		removeBtn.value="삭제";
		
		var flex = document.createElement('li');
		flex.className='etc-list';
		
		var etc = $('#tips-add-etc').val();
		var etc_list = $('#etc-tips-list');
	
		etc_list.append(flex);
		flex.append(location);
		flex.append(removeBtn);
	
		removeBtn.addEventListener('click' , removeList);
	});
}



function getRandomInt(min, max) {
	  min = Math.ceil(min);
	  max = Math.floor(max);
	  return Math.floor(Math.random() * (max - min)) + min; //최댓값은 제외, 최솟값은 포함
};

function getBase64(file) {
	   var reader = new FileReader();
	   reader.readAsDataURL(file);
	   
	   reader.onload = function () {   
		 $('#write-main-img').attr('src',reader.result);
	   };
	   
	   reader.onerror = function (error) {
	     console.log('Error: ', error);
	   };
	}
