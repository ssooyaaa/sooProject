$(document).ready(function(){
	
	var sm_idx = $('#map-sm-idx').val();
	
	//영수증 보이기
	getReceipt(sm_idx);
	
	
	//환율 저장 창보이기
	$('.add-rate-btn').click(function(){
		$('.add-r-content').show();
		
		$('.rate-add-price').val('');
	});
	
	
	//환율 저장
	$(document).on('click','.save-rate-btn',function(){
		var selectOption = $('#price-mode option:selected').val();
		
		var price = $('.rate-add-price').val();
		var formatter = new Intl.NumberFormat('ko-KR');//숫자형식화(,)
		var formatted = formatter.format(price);
		
		
		if(price==null || price==''){
			
			alert('금액을 입력해주세요.');
			
		}else{
			$.ajax({
				url:'./expense/addExchange',
				type:'post',
				data:{
					'sm_idx':sm_idx,
					'exchange_type':selectOption,
					'exchange_rate':price
				},
				success:function(idx){
					
					if(idx==-1){
						alert('이미 입력되어 있습니다. 삭제 후, 다시 입력해주세요.');
					}else if(idx!=null || idx!=''){
						$('.rate-list').append(
								`<div class="rate-items">
									<i class="fa-solid fa-circle-minus del-rate-btn"></i>
									<span class="rate-type">${selectOption}</span>
									<div class="change-won">
										<i class="fa-solid fa-won-sign"></i>
				 						<span>${formatted}</span>
									</div>
									<input style="display:none" value="${idx}"/>
								</div>`
						);
						location.href='./receipt?sm_idx='+sm_idx;
						$('.add-r-content').hide();
					}
					
				},
				error:function(err){}
			});
			
		}
		
	});
	
	//환율 취소
	$(document).on('click','.cancel-rate-btn',function(){
		$('.add-r-content').hide();
	});
	
	
	//환율 저장-삭제
	$(document).on('click','.del-rate-btn',function(){
		var parent = this.parentElement;
		var exIdx = $(parent).children().eq(3).val();
		
		$.ajax({
			url:'./expense/delExchange',
			type:'post',
			data:{'exchange_idx':exIdx},
			success:function(res){
				if(res=='ok'){
					$(parent).remove();
					location.reload();
				}else{
					alert('다시 한번 시도해주세요.');
				}
			},
			error:function(err){}
		});
		
	});
	
});


//영수증 보이기
function getReceipt(sm_idx){
	
	$.ajax({
		url:'./expense/getReceipt',
		type:'get',
		data:{'sm_idx':sm_idx},
		success:function(map){
			
			var totalPrice = 0;
			
			$('.title').append(
					`<span>${map.summary.name}</span>`	
			);
			
			
			$('.date').append(
					`<span>${map.summary.start_date} ~ ${map.summary.end_date}</span>`
			);
			
			var exList = [];
			$.each(map.exchange,function(index,item){
				var price = item.exchange_rate;
				var formatter = new Intl.NumberFormat('ko-KR');//숫자형식화(,)
				var formatted = formatter.format(price);
				
				$('.rate-list').append(
						`<div class="rate-items">
							<i class="fa-solid fa-circle-minus del-rate-btn"></i>
							<span class="rate-type">${item.exchange_type}</span>
							<div class="change-won">
								<i class="fa-solid fa-won-sign"></i>
		 						<span>${formatted}</span>
							</div>
							<input style="display:none" value="${item.exchange_idx}"/>
						</div>`
				);
				
				exList.push(item.exchange_type);
				exList.push(price);
			});
			
			
			$.each(map.advance,function(index,item){
				var price = item.price;
				var formatter = new Intl.NumberFormat('ko-KR');//숫자형식화(,)
				var formatted = formatter.format(price);
				
				$('.adv-list').append(
						`<div class="adv-items">
							<span>${item.item}</span>
							<div class="price">
								<i class="fa-solid fa-won-sign price-type"></i>
		 						<span>${formatted}</span>
							</div>
						</div>`
				);
				
				//금액표기 변경
				if(item.price_type==''){
					$('.price-type').replaceWith(function() {
						  return '<i class="fa-solid fa-won-sign"></i>';
					});
				}else if(item.price_type=='usd'){
					$('.price-type').replaceWith(function() {
						  return '<i class="fa-solid fa-dollar-sign"></i>';
					});
				}
				
				
				//총액 추가
				if(item.price_type==''){
					totalPrice += price;
				}else if(item.price_type=='usd'){
					
					for(var i=0;i<exList.length;i++){
						if(exList[i]=='USD'){
							totalPrice += price*exList[i+1];
							return;
						}
					}
					
					totalPrice += '변경';
				}
				
			});
			
			var days = map.summary.days;
			
			for(var i=1;i<=days;i++){
				$('.days').append(
						`<div class="day" id="day${i}">
							<div style="font-weight:800;font-size:22px;">DAY${i}</div>
							<div class="receipt-list" id="receipt-list${i}">
								
								
								
							</div>
						</div>`
				);
			}
			
			
			$.each(map.plan,function(index,item){
				var planDay = item.day;
				
				var price = item.price;
				var formatter = new Intl.NumberFormat('ko-KR');//숫자형식화(,)
				var formatted = formatter.format(price);
				
				var dayElement = $('#'+'receipt-list'+planDay);
				
				$(dayElement).append(
						`<div class="receipt-items">
	 						<span>${item.todo}</span>
	 						<div class="price">
	 							<i class="fa-solid fa-won-sign priceType"></i>
	 							<span>${formatted}</span>
	 						</div>
						</div>`
				);
				
				//금액표기 변경
				if(item.priceType==''){
					$('.priceType').replaceWith(function() {
						  return '<i class="fa-solid fa-won-sign"></i>';
					});
				}else if(item.priceType=='usd'){
					$('.priceType').replaceWith(function() {
						  return '<i class="fa-solid fa-dollar-sign"></i>';
					});
				}
				
				//총액 추가
				if(item.priceType==''){
					totalPrice += price;
				}else if(item.priceType=='usd'){
					
					for(var i=0;i<exList.length;i++){
						if(exList[i]=='USD'){
							totalPrice += price*exList[i+1];
							return;
						}
					}
					
					totalPrice += '변경';
				}
				
			});
			
			var formatter = new Intl.NumberFormat('ko-KR');//숫자형식화(,)
			var formatted = formatter.format(totalPrice);
			
			
			if($.isNumeric(totalPrice)){ //숫자만 있는지 확인
				$.ajax({
					url:'./expense/updateTotal',
					type:'post',
					data:{
						'sm_idx':sm_idx,
						'total':formatted
					},
					success:function(res){
						if(res=='ok'){
							$('.days').append(
									`<div class="total-price">
										<span>TOTAL</span>
										<div class="total">
											<i class="fa-solid fa-won-sign"></i>
						 					<span>${formatted}</span>
										</div>
									</div>`	
							);
							
						}
					},
					error:function(err){}
				});
				
			}else{
				$.ajax({
					url:'./expense/updateTotal',
					type:'post',
					data:{
						'sm_idx':sm_idx,
						'total':'환율 정보를 입력해주세요'
					},
					success:function(res){
						if(res=='ok'){
							$('.days').append(
									`<div class="total-price">
										<span>TOTAL</span>
										<div class="total">
											<i class="fa-solid fa-won-sign"></i>
						 					<span>환율 정보를 입력해주세요</span>
										</div>
									</div>`	
							);
						}
					},
					error:function(err){}
				});
				
				
			}
			
		},
		error:function(err){}
	});
}