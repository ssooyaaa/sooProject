var storage;

$(document).ready(function(){
   
   //firebase
   if(!firebase.apps.length){
      firebase.initializeApp(firebaseConfig);
   }
   storage = firebase.storage();
   var selectedFile;
   
   $('#write-main-img').on('click',function(){
      $('#main-img-file').trigger('click');
   });
   
   //main이미지 - UI보여주기
   $('#main-img-file').on('change',function(){
      selectedFile = $(this)[0].files[0];
      getBase64(selectedFile);
   });
   
 
   // More Photos - 추가/삭제
   morePhotos();
   
   
   // tips - 추가/삭제
   moreTips();
   
   
   // 작성페이지 데이터 세팅
   initPost();
   
   
});



//firebase - 이미지 upload & 주소받기
function uploadFileAndGetUrl(path,file){
   
   return new Promise((resolve, reject)=>{
      var ref = storage.ref(path).child(getRandomInt(0,10000)+'_'+Date.now()+"img.png");
      
      if(file==null){//이미지 등록을 안했을 경우
    	 resolve(""); 
      }else{
    	  console.log(file);
    	  ref.put(file).then(function(snapShot){ //이미지 upload
    	         ref.getDownloadURL().then(function(url){ //이미지 주소받기
    	            resolve(url);
    	         });
    	      }).catch(function(err){console.log(err)});
      }
           
   });
   
}

//데이터 셋팅 및 DB저장
function initPost(){

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
   
   
   $('#save-button').click(function(){
      
	   $('.write-body').hide();
	   $('.header').hide();
	   $('.loading').show();
	   
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
         uploadFileAndGetUrl('mydiary',$('#main-img-file')[0].files[0])
         .then(function(url){
            data['main_img_file']=url;
            resolve();
         });
      });
      
      promiseArr.push(p1);
      
      
      //3. more photos - 이미지
      $.each($('.more-photos'), function(index,item){
    	  
         var p2 = new Promise(function(resolve, reject){
            var file = $(item)[0].files[0];
            uploadFileAndGetUrl('photos',file)
            .then(function(url){
               data['more_photos'].push(url);
               
               resolve();
               data['sequence'].push(index);

               

            });
            
         });
         
         promiseArr.push(p2);
         
      });
      
      
      //4. more photos - 내용
      $.each($('.explain-photos'), function(index,item){
    	  
    	 var p3 = new Promise(function(resolve, reject){
             var value = $(item).val();
             
             data['more_photos_desc'].push(value);
             
             resolve();
             data['sequence_desc'].push(index);
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
    	  
    	  uploadFileAndGetUrl('sight',$('#location-img')[0].files[0])
          .then(function(url){
        	 data['sight_img']=url;
        	 resolve();
          });
    	  
      });
      
      promiseArr.push(p8);
      
      
      Promise.all(promiseArr).then((values) => {
    	 
    	  
    	 console.log('===data===');
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
       		  if(res=='fail'){
       			  alert('저장에 실패했습니다.');
       		  }else{
       			  alert('저장 완료되었습니다.');
       			  location.href="./mydiary"       			  
       		  }
       	  },
       	  complete:function(){
       		  $('.loading').hide();
       	  },
       	  error:function(err){
       		  console.log('-----err-----');
       		  console.log(err);
       	  }
         });
      });
      
      
     
      
      
   });
   
}



//More Photots 추가/삭제 버튼
function morePhotos(){
   //Photos-사진추가버튼
   var countPhoto = 1;
   $('.btn-more-photos').on('click',function(){
      
      if(countPhoto <= 10) {
         $('#plus-more-photos').append(
               `<div class="plus-del-photos">
                  <input type="file" class="more-photos" id="more-photos"/>
                  <i class="fa-solid fa-angles-right">
                  <input type="text" class="explain-photos" placeholder="사진 추가 설명" id="explain-photos"/>
                  </i>
                </div>`
        		 
         );
                
         countPhoto++;
      } else {
         alert('최대 10장까지만 가능합니다.');
      };
      
   });
   
   //Photos-사진삭제버튼
   $('#btn-del-photos').on('click',function(){
      $('.plus-del-photos').last().remove();
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
		var etc = $('#tips-add-etc').val('');
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
   }