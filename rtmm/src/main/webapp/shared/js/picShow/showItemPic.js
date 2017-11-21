
var itemLookInfos= new Array();//当前图片的集合信息
var itemLookNumber=0;//当前图片顺序

//加载图片信息(页面调用事件)
function loadItemPicInfos(itemNo){
	$("#lookItem_p").css({ "top": 0, "left": 0, "display": "block", "width": screen.width, "height": "690px" });
    //清空信息
	itemLookNumber=0;
	itemLookInfos=new Array();
	$("#lookItem_pp2").empty();
	$("#lookItem_pp3").empty();

	//加载图片信息
	readItemPicInfos(itemNo);
}

//关闭事件
function closeShowPic(){
    $("#lookItem_p").css("display", "none");
}


//加载浏览图片信息
 	 $("#lookItem_prev_brower").live("mouseover", function () {
 		    $(this).addClass("prev_brower_bg");
 		});
 		$("#lookItem_prev_brower").live("mouseout", function () {
 		    $(this).removeClass("prev_brower_bg");
 		});
 		$("#lookItem_next_brower").live("mouseover", function () {
 		    $(this).addClass("next_brower_bg");
 		});
 		$("#lookItem_next_brower").live("mouseout", function () {
 		    $(this).removeClass("next_brower_bg");
 		});
 		$("#lookItem_next_brower").unbind("click").bind("click", function () {
   			$("#lookItem_pp3").empty();
   			if(typeof(itemLookInfos[itemLookNumber+1])!='undefined' || itemLookInfos[itemLookNumber+1]!=null){
   				itemLookNumber=itemLookNumber+1;
   				$("#lookItem_pp2").attr("src",itemLookInfos[itemLookNumber]);
   				//loadItemImgInfos(itemLookInfos.get(itemLookInfos.keySet()[itemLookNumber]));
   		    	}else{
                $("#lookItem_pp3").text("已经到最后一张了");
   	   		    	}       	
   	   		});
   		$("#lookItem_prev_brower").unbind("click").bind("click", function () {
   			$("#lookItem_pp3").empty();
   			if(typeof(itemLookInfos[itemLookNumber-1])!='undefined' || itemLookInfos[itemLookNumber-1]!=null){
   				itemLookNumber=itemLookNumber-1;
   				$("#lookItem_pp2").attr("src",itemLookInfos[itemLookNumber]);   				
   				//loadItemImgInfos(itemLookInfos.get(itemLookInfos.keySet()[itemLookNumber]));
   		    	}else{
   		    	 $("#lookItem_pp3").text("已经到第一张了");
   	   		    	}
   	
   		});
        
 	 

//加载图片到层中
  function loadItemImgInfos(key){
  	 /* $("#lookItem_pp2").empty(); */
      $("#lookItem_pp2").attr("src",key);
  }




  //需要执行的方法，读取图片信息
  function readItemPicInfos(itemNo){

 	 $.ajax({
				url :'${ctx}/uploadItemPicAction/readItemPic?tt='
						+ new Date().getTime(),
				data : {itemNo:itemNo},
				type : 'POST',
				dataType:'json',
				success : function(response) {
					if(response!=""){
					 					
				       //读取图片信息
					       $(response).each(function(index,item){
					    	   var link=ufs+item.itemPicFileId;
					    	   itemLookInfos.put(link);                      	
						       });
					       //加载第一张图片信息
					   		loadItemImgInfos(itemLookInfos[0]);
					   	//加载图片，弹出层
							$("#lookItem_p" ).dialog("open");						  				       	
					}else{
						alert("没有商品图片信息");
					}				
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert('error', '网络超时!请稍后重试', '提示消息');
				}
			});
      }
  
  