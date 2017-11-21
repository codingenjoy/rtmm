
var itemLookInfos= new Array();//当前图片的集合信息
var itemLookNumber=0;//当前图片顺序

//加载图片信息(页面调用事件)
function loadComPicInfos(licnceId){
    //清空信息
	itemLookNumber=0;
	itemLookInfos=new Array();
	$("#look_Item_pp2").empty();
	$("#look_Item_pp3").empty();
	//加载图片信息
	readLookItemPicInfos(licnceId);
}

//关闭事件(查看图片窗口)
$("#close_LookPic").live("click", function () {
    $("#look_Item_p").css("display", "none");
});

//加载浏览图片信息
 	 $("#look_Item_prev_brower").live("mouseover", function () {
 		    $(this).addClass("prev_brower_bg");
 		});
 		$("#look_Item_prev_brower").live("mouseout", function () {
 		    $(this).removeClass("prev_brower_bg");
 		});
 		$("#look_Item_next_brower").live("mouseover", function () {
 		    $(this).addClass("next_brower_bg");
 		});
 		$("#look_Item_next_brower").live("mouseout", function () {
 		    $(this).removeClass("next_brower_bg");
 		});
 		$("#look_Item_next_brower").unbind("click").bind("click", function () {
   			$("#look_Item_pp3").empty();
   			if(typeof(itemLookInfos[itemLookNumber+1])!='undefined' || itemLookInfos[itemLookNumber+1]!=null){
   				itemLookNumber=itemLookNumber+1;
   				$("#look_Item_pp2").attr("src",itemLookInfos[itemLookNumber]);
   				$("#look_Item_pp3").text(
						"当前第" + (itemLookNumber + 1) + "张，共"
								+ itemsUploadPhotos.length + "张");
   		    	}else{
                $("#look_Item_pp3").text("已经到最后一张了");
   	   		    	}       	
   	   		});
   		$("#look_Item_prev_brower").unbind("click").bind("click", function () {
   			$("#look_Item_pp3").empty();
   			if(typeof(itemLookInfos[itemLookNumber-1])!='undefined' || itemLookInfos[itemLookNumber-1]!=null){
   				$("#look_Item_pp3").text(
						"当前第" + itemLookNumber + "张，共"
								+ itemLookInfos.length + "张");
   				itemLookNumber=itemLookNumber-1;
   				$("#look_Item_pp2").attr("src",itemLookInfos[itemLookNumber]);   				
   		    	}else{
   		    	 $("#look_Item_pp3").text("已经到第一张了");
   	   		    	}
   	
   		});
        
 	 

//加载图片到层中
  function loadItemImgInfos(key){
  	   $("#look_Item_pp2").empty(); 
	  $("#look_Item_pp3").empty();
	  
      $("#look_Item_pp2").attr("src",key);
  }




  //需要执行的方法，读取图片信息
  function readLookItemPicInfos(licenceId){
       
 	 $.ajax({
				url :"supplierLicenceAction/readComGroupLicenceByLicenceId?tt=" 
						+ new Date().getTime(),
				data : {licnceId:licenceId},
				type : 'POST',
				dataType:'json',
				success : function(response) {
					if(response!=""){					 					
				       //读取图片信息
					       $(response).each(function(index,item){
					    	   var link=ufs+item.licncePicFileId;
					    	   itemLookInfos.push(link);                      	
						       });
						   	$("#look_Item_p").css({ "top": 0, "left": 0, "display": "block", "width": screen.width, "height": "690px" });
					       //加载第一张图片信息
						   	
					   		loadItemImgInfos(itemLookInfos[0]);
									  				       	
					}else{
						top.jAlert('warning', '没有照片信息', '消息提示');

					}				
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					alert('error', '网络超时!请稍后重试', '提示消息');
				}
			});
      }