$(document).ready(function(){
	
	//smarteditor설정
	var oEditors = [];
	$(function(){
	      nhn.husky.EZCreator.createInIFrame({
	          oAppRef: oEditors,
	          elPlaceHolder: "sEditor", //textarea에서 지정한 id와 일치해야 합니다. 
	          //SmartEditor2Skin.html 파일이 존재하는 경로
	          sSkinURI: "./resources/dist/SmartEditor2Skin.html",  
	          htParams : {
	              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseToolbar : true,             
	              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseVerticalResizer : true,     
	              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	              bUseModeChanger : true
	          }, 
	          
	      });

	});
	
	
	//확인버튼-저장
	$('.newWork-submit').click(function(){
		oEditors.getById["sEditor"].exec("UPDATE_CONTENTS_FIELD", []);
		let content = document.getElementById("sEditor").value;
	    let contentReplace = document.getElementById("sEditor").value.replace(/[<][^>]*[>]/gi, "");
	    
	    var title = $('#newWork-title').val();
	    var company = $('#newWork-company').val();
	    var head = $('#newWork-head').val();
	    var phone_number = $('#newWork-phone1').val() + $('#newWork-phone2').val() + $('#newWork-phone3').val();
	    var number = $('#newWork-num1').val() + $('#newWork-num2').val() + $('#newWork-num3').val();
	    var email = $('#newWork-email').val();
	    
	    if(contentReplace == '') {
	        alert("내용을 입력해주세요.");
	        oEditors.getById["sEditor"].exec("FOCUS");
	        return
	    } else {
	    	//개인정보수집 동의
	    	if($('.newWork-check').is(':checked')==true){
	    		//제목
	    		if(title!=''){
	    			//업체명
	    			if(company!=''){
	    				//담당자
	    				if(head!=''){
	    					//휴대전화
	    					if(phone_number!=''){
	    						//이메일
	    						if(email!=''){
	    							
	    							$.ajax({
	    								url:'./newWork/addNewWork',
	    								type:'post',
	    								data:{
	    									'title':title,
	    									'company':company,
	    									'head':head,
	    									'phone_number':phone_number,
	    									'number':number,
	    									'email':email,
	    									'content':content
	    								},
	    								success:function(res){
	    									if(res=='ok'){
	    										alert('저장이 완료되었습니다.');
	    										location.replace('./newWork');
	    									}else{
	    										alert('저장 실패되었습니다.');
	    									}
	    								},
	    								error:function(){}
	    							});
	    							
	    							
	    						}else{
	    							alert('이메일을 입력해주세요');
	    		    				$('#newWork-email').focus();
	    						}
	    					}else{
	    						alert('휴대전화를 입력해주세요');
	    	    				$('#newWork-phone1').focus();
	    					}
	    				}else{
	    					alert('담당자을 입력해주세요');
		    				$('#newWork-head').focus();
	    				}
	    			}else{
	    				alert('업체명을 입력해주세요');
	    				$('#newWork-company').focus();
	    			}
	    		}else{
	    			alert('제목을 입력해주세요.');
	    			$('#newWork-title').focus();
	    		}
	    	}else{
	    		alert('개인정보수집안내에 동의해주세요.');
	    	}
	    }
	});
	
});