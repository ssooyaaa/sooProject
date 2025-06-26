
$(document).ready(function(){
    
    $('.home-more-button').on('click',function(){
    	
    	var page = $(this).data('more-button');
    	
    	if(page=='domestic'){
    		location.href='./photo';
    	}else{
    		location.href='./photo_abroad';
    	};
    });
   
    //국내여행지 슬라이드
    getDomesticPics();
    
    //해외여행지 슬라이드
    getAbroadPics();
    
    //슬라이드
	bxSlider();
   
});


//국내여행지 슬라이드
function getDomesticPics(){
	
	 $.ajax({
	    	url:'./photos/getDomesticPics',
	    	type:'get',
	    	async:false,
	    	data:{},
	    	success:function(list){
	    		console.log(list);
	    		$.each(list,function(index,item){
	    			$('#home-domestic-photo').append(
	    					`<span>
	    					<img style="width:260px; height:300px;" src="${item.sight_img}"/>
	    					</span>`
	    			)
	    			
	    		});
	    	}
	    });

};


//해외여행지 슬라이드
function getAbroadPics(){
	
	$.ajax({
		url:'./photos/getAbroadPics',
		type:'get',
		async:false,
		data:{},
		success:function(list){
			console.log(list);
			
			$.each(list, function(index,item){
				$('#home-abroad-photo').append(
    					`<span>
    					<img style="width:260px; height:300px;"src="${item.sight_img}"/>
    					</span>`
    			)
			});
		}
	});
	
}


//슬라이드
function bxSlider(){
    $('.my_bxslider').bxSlider({
    	mode:'horizontal',
    	auto:true,
    	autoHover:true,
    	controls:true,
    	speed:50,
    	infiniteLoop:true,
    	minSlides:4,
    	maxSlides:4,
    	moveSlides:1,
    	slideWidth:700,
    	pager:false,
    	slideMargin:5
    });
}

