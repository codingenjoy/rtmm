/*
 * 本文件定义了在本功能页面上所有的校验逻辑.
 */

//验证主题，可别信息
function checkSubjName(/*None*/){
	var prevName = $("#subjName").attr('prev');
	var subjName = $("#subjName").val();
 	$("#subjName").removeClass('errorInput');
    $("#subjName").attr("title",'');
 	if($.trim(subjName)==''){
 		$("#subjName").addClass('errorInput');
        $("#subjName").attr("title",'请输入主题!');
 	}else if(charLen($.trim(subjName))>30){
 		$("#subjName").attr("title",'主题不能超过30个字节!');
 		$("#subjName").val(prevName);
	}
 	$("#subjName").attr('prev',$("#subjName").val());
}
//计算字符串的字节数
function charLen(/*String*/s) {
    	var l = 0;
    	var a = s.split("");
    	for (var i=0;i<a.length;i++)
    	{
    		if (a[i].charCodeAt(0)<299) {
    			l++;
    			} 
    		else {
    			l+=2;
    			}
    	}
    	return l;
};
//检查促销时间
function checkTime(/*String*/isNeedAjax,/*Node*/obj){
	var promBeginDate=$("#promTimeStart").val();
	var promEndDate=$("#promTimeEnd").val();
	var buyBeginDate=$("#buyTimeStart").val();
	var buyEndDate=$("#buyTimeEnd").val();
	
	var obbd = $("#oBuyBeginDate").val();
	var obed = $("#oBuyEndDate").val();
	var osbd = $("#oSellBeginDate").val();
	var osed = $("#oSellEndDate").val();
	$("#promTimeEnd").removeClass("errorInput");
  	$("#promTimeStart").removeClass("errorInput");
  	$("#buyTimeEnd").removeClass("errorInput");
  	$("#buyTimeStart").removeClass("errorInput");
  	$("#buyTimeStart").attr("title","");
  	$("#buyTimeEnd").attr("title","");
  	$("#promTimeStart").attr("title","");
  	$("#promTimeEnd").attr("title","");
	if(promBeginDate==''&&promEndDate==''&&buyBeginDate==''&&buyEndDate==''){
		  $("#promTimeEnd").addClass("errorInput");
		  $("#promTimeStart").addClass("errorInput");
		  $("#buyTimeEnd").addClass("errorInput");
		  $("#buyTimeStart").addClass("errorInput");
		  $("#buyTimeStart").attr("title","采购期间促销期间至少一个不能为空！");
		  $("#buyTimeEnd").attr("title","采购期间促销期间至少一个不能为空！");
		  $("#promTimeStart").attr("title","采购期间促销期间至少一个不能为空！");
		  $("#promTimeEnd").attr("title","采购期间促销期间至少一个不能为空！");
		  return false;
	}else if(promBeginDate!=''&&promEndDate=='')
		 {
		  $("#promTimeEnd").addClass("errorInput");
		  $("#promTimeEnd").attr("title","请输入促销结束时间！");
		  return false;
	}else if(promBeginDate==''&&promEndDate!=''){
	      $("#promTimeStart").addClass("errorInput");
		  $("#promTimeStart").attr("title","请输入促销开始时间！");
	      return false;
	}else if(buyBeginDate!=''&&buyEndDate==''){
		      $("#buyTimeEnd").addClass("errorInput");
		  $("#buyTimeEnd").attr("title","请输入采购结束时间！");
		      return false;
		}else if(buyBeginDate==''&&buyEndDate!=''){
	      $("#buyTimeStart").addClass("errorInput");
		  $("#buyTimeStart").attr("title","请输入采购开始时间！");
	      return false;
	 }
	 
	 
	 
	if(isNeedAjax){
		 var flag=true;
		 var checkTimeUrl=ctx + '/prom/nondm/art/checkTime?buyDateStart='+buyBeginDate+'&buyDateEnd='+buyEndDate+'&promDateStart='+promBeginDate+'&promDateEnd='+promEndDate+'&ti='+(new Date()).getTime();
		 //如果是修改页面  
		 if(isUpdatePage()){
		 	var sType = $(obj).attr("sType");
		 	var type = $(obj).attr("ttype");
		 	var isbegin=$("#buyBegin").val(); 
		 	var promNo = $("#promNo").val();
		 	checkTimeUrl = checkTimeUrl + '&flag=update&isbegin='+isbegin+'&sType='+sType;
		 	if(type=="buy"){
		  		if(buyBeginDate != "" && buyEndDate !="" && buyEndDate !=null && buyBeginDate !=null){
		  			if(!checkPromIsInOrder(0,buyBeginDate,buyEndDate,0,0)){
		  				if(sType == "buystart"){
		  					top.jWarningAlert("已有订单使用该促销期数，且订货日期或者预定收货日期在修改后的时间范围内！");
		  					changeDateValue("buyTimeStart");
		  					flag = false;
		  					//checkPromIsInOrderFlag=false;
		  				}
		  				if(sType == "buyend"){
		  					
		  					top.jWarningAlert("已有订单使用该促销，且订货日期或者预定收货日期在修改后的时间范围内！");
		  					changeDateValue("buyTimeEnd");
		  					flag = false;
		  					//checkPromIsInOrderFlag= false;
		  				}
		  			}
			  	}
		  	}
		 }
		 $.ajax({
    		    async:false,
		    	url:checkTimeUrl,
				type: "post",
				dataType:"json",
				success: function(result) {
				    if(result.message!=null && result.message !="success"){
				    	if(result.key=='1' && !$("#buyTimeStart").hasClass("Black")){
				    		$("#buyTimeStart").addClass("errorInput");
							$("#buyTimeStart").attr("title",result.message);
							flag=false;
				    	}
				    	if(result.key=='2' && !$("#buyTimeEnd").hasClass("Black")){
				    		$("#buyTimeEnd").addClass("errorInput");
							$("#buyTimeEnd").attr("title",result.message);
							flag=false;
				    	}
				    	if(result.key=='3'  && !$("#promTimeStart").hasClass("Black")){
				    		$("#promTimeStart").addClass("errorInput");
							$("#promTimeStart").attr("title",result.message);
							flag=false;
				    	}
				    	if(result.key=='4'  && !$("#promTimeEnd").hasClass("Black")){
				    		$("#promTimeEnd").addClass("errorInput");
							$("#promTimeEnd").attr("title",result.message);
							flag=false;
				    	}
				    	
				    }   	
				}
		  });
	}
	  return flag;
}
//判断代号是不是都为空
function checkUnitListIsEmpty(/*None*/){
	var falg = true;
	$("input[name=unitNo]").each(function(){
		if($(this).val() !=""){
			falg = false;
			return;
		}
	});
	return falg;
}

//检查当前界面上的输入日期是否有效.
function checkAreAllInputDateValid(/*None*/){
	var promBeginDate=$("#promTimeStart").val();
	var promEndDate=$("#promTimeEnd").val();
	var buyBeginDate=$("#buyTimeStart").val();
	var buyEndDate=$("#buyTimeEnd").val();
	
	$("#promTimeEnd").removeClass("errorInput");
  	$("#promTimeStart").removeClass("errorInput");
  	$("#buyTimeEnd").removeClass("errorInput");
  	$("#buyTimeStart").removeClass("errorInput");
  	$("#buyTimeStart").attr("title","");
  	$("#buyTimeEnd").attr("title","");
  	$("#promTimeStart").attr("title","");
  	$("#promTimeEnd").attr("title","");
	if(!promBeginDate && !promEndDate && !buyBeginDate && !buyEndDate){
	  $("#promTimeEnd").addClass("errorInput");
	  $("#promTimeStart").addClass("errorInput");
	  $("#buyTimeEnd").addClass("errorInput");
	  $("#buyTimeStart").addClass("errorInput");
	  $("#buyTimeStart").attr("title","采购期间促销期间至少一个不能为空！");
	  $("#buyTimeEnd").attr("title","采购期间促销期间至少一个不能为空！");
	  $("#promTimeStart").attr("title","采购期间促销期间至少一个不能为空！");
	  $("#promTimeEnd").attr("title","采购期间促销期间至少一个不能为空！");
	  return false;
	}else if(promBeginDate!=''&&promEndDate=='') {
	  $("#promTimeEnd").addClass("errorInput");
	  $("#promTimeEnd").attr("title","请输入促销结束时间！");
	  return false;
	}else if(promBeginDate==''&&promEndDate!=''){
      $("#promTimeStart").addClass("errorInput");
	  $("#promTimeStart").attr("title","请输入促销开始时间！");
      return false;
	}else if(buyBeginDate!=''&&buyEndDate==''){
	  $("#buyTimeEnd").addClass("errorInput");
	  $("#buyTimeEnd").attr("title","请输入采购结束时间！");
	  return false;
	}else if(buyBeginDate==''&&buyEndDate!=''){
      $("#buyTimeStart").addClass("errorInput");
	  $("#buyTimeStart").attr("title","请输入采购开始时间！");
      return false;
	}
	return true;
};

//验证主题，返回布尔类型
function checkSubjNameBoolean(/*None*/){
	var subjName = $("#subjName").val();
	if($.trim(subjName)==''){
		$("#subjName").removeClass('errorInput').addClass('errorInput');
		$("#subjName").attr("title",'请输入主题!');
	   return false;
	}else if (charLen($.trim(subjName))>30){
	 	$("#subjName").addClass('errorInput');
	 	$("#subjName").attr("title",'主题不能超过30个字节!');
	   return false;
	}
	return true;
}



/*
 * 验证数据是否符合要求（lizhong 2015-01-08）
 * 1.验证代号下是否已经有门店在当前促销期间内参加了其他的促销
 * 2.验证代号下所有促销进价，促销售价是否为空
 */
function checkItemStoresValid(/*Array*/ itemStores,/*Array*/ unitItems,/*Array*/units){
	 	var message="";
	 	var promType =$("#promType").val();
	 	//确保有代号存在
	 	if(units.length < 1){
 			top.jWarningAlert('请选择代号信息！');
 			return;
 		}
	 	//循环数组，去除比较的参数
	 	for (var unitsIndex = 0; unitsIndex < units.length; unitsIndex++) {
			var unitNo = units[unitsIndex].unitNo;//代号
			var ItemNoJson = unitItems[unitNo].data;//指定代号的商品的数组
			for (var itemIndex = 0; itemIndex < ItemNoJson.length; itemIndex++) {
				var itemNo = ItemNoJson[itemIndex].itemNo;//商品编号
				var storeJson = itemStores[itemNo].data;//指定商品的门店数组
				for (var storeIndex = 0; storeIndex < storeJson.length; storeIndex++) {
					var basicStatus = storeJson[storeIndex].basicStatus;//主状态
		 			var appendProm = storeJson[storeIndex].appendProm;//（售价促销）标示符，标示此门店是在当前时间段是否参加了其他的促销
		 			var appendBuy = storeJson[storeIndex].appendBuy;//（进价促销）标示符，标示此门店是在当前时间段是否参加了其他的促销
		 			var promBuyPrice = storeJson[storeIndex].promBuyPrice;//促销进价
		 			var promSellPrice = storeJson[storeIndex].promSellPrice;//促销售价
		 			var normBuyPrice = storeJson[storeIndex].normBuyPrice;//正常进价
		 			var normSellPrice = storeJson[storeIndex].normSellPrice;//正常进价
		 			var buyWhen  = storeJson[storeIndex].buyWhen;//时点
		 			var buyPriceLimit = storeJson[storeIndex].buyPriceLimit;//限制
		 			var isBlack = true;
		 			//仅售价促销，进价促销
					if(promType == 1 || promType==2){
		 				// 判断当前代号的商品是否在其他的促销期数中
		 				if(appendBuy == 1){
		 					top.jWarningAlert("请确认门店信息无误，再进行下一步操作！");
		 					//todo.将当前check失败的“代号/商品/门店”主动定位到
		 					pArtPromHandler.getUnitsCanvas().clickRowByIndex(unitsIndex);
		 					pArtPromHandler.getItemsCanvas().clickRowByIndex(itemIndex);
		 					$(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+(unitsIndex*25))
		 					$(".pro_store_items").scrollTop($("#m_cols_body").scrollTop()+(itemIndex*35));
		 					$("#m_cols_body").scrollTop($("#m_cols_body").scrollTop()+(storeIndex*30));
		 					return false;
		 				}
		 				
		 				//当促销类型为仅售价促销时，当 5<主状态<9 不进行促销进价
		 				if(promType==1){
		 					if(5<Number(basicStatus) && Number(basicStatus)<9){
		 						isBlack = false;
		 					}
		 				}
		 				
		 				if(isBlack){
				 			if(promBuyPrice==null || promBuyPrice ==""){
				 				message = "代号"+unitNo+",商品货号"+itemNo+"，促销进价不能为空";
				 				top.jWarningAlert( message+"!");
				 				pArtPromHandler.getUnitsCanvas().clickRowByIndex(unitsIndex);
		 					    pArtPromHandler.getItemsCanvas().clickRowByIndex(itemIndex);
		 					    $(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+(unitsIndex*25))
		 					     $(".pro_store_items").scrollTop($("#m_cols_body").scrollTop()+(itemIndex*35));
								$("#m_cols_body").scrollTop($("#m_cols_body").scrollTop()+(storeIndex*30));
				 				return false;
				 			}else{
				 				if(!isMoney4(promBuyPrice)){
				 					message = "代号"+unitNo+",商品货号"+itemNo+"，促销进价必须是不能超过四位小数的数字";
									top.jWarningAlert(message+"!");
					 				pArtPromHandler.getUnitsCanvas().clickRowByIndex(unitsIndex);
			 					    pArtPromHandler.getItemsCanvas().clickRowByIndex(itemIndex);
			 					    $(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+(unitsIndex*25))
			 					    $(".pro_store_items").scrollTop($("#m_cols_body").scrollTop()+(itemIndex*35));
			 					    $("#m_cols_body").scrollTop($("#m_cols_body").scrollTop()+(storeIndex*30));
							    	return false;
								}else{
					 				//4.当成本时点等于2时
									if(buyWhen == "2"){
										//4-1判断促销进价是不是小于买家限制价格
							    		if(buyPriceLimit && (Number(promBuyPrice)>Number(buyPriceLimit))){
							    			message = "代号"+unitNo+",商品货号"+itemNo+"，促销进价不能大于买价限制("+buyPriceLimit+"元)";
					 						top.jWarningAlert(message+"!");
					 						pArtPromHandler.getUnitsCanvas().clickRowByIndex(unitsIndex);
			 					    		pArtPromHandler.getItemsCanvas().clickRowByIndex(itemIndex);
			 					    		$(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+(unitsIndex*25))
			 					    		 $(".pro_store_items").scrollTop($("#m_cols_body").scrollTop()+(itemIndex*35));
			 					    		$("#m_cols_body").scrollTop($("#m_cols_body").scrollTop()+(storeIndex*30));
							    			return false;
							    		}
							    	}else{//5.当成本时点不等于2时，判断促销进价是不是小于正常进价
							  	    	if(Number(promBuyPrice) >= Number(normBuyPrice)){
							  	    		message = "代号"+unitNo+",商品货号"+itemNo+"，促销进价必须小于正常进价";
											top.jWarningAlert( message+"!");
					 						pArtPromHandler.getUnitsCanvas().clickRowByIndex(unitsIndex);
			 					    		pArtPromHandler.getItemsCanvas().clickRowByIndex(itemIndex);
			 					    		$(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+(unitsIndex*25))
			 					    		 $(".pro_store_items").scrollTop($("#m_cols_body").scrollTop()+(itemIndex*35));
			 					    		$("#m_cols_body").scrollTop($("#m_cols_body").scrollTop()+(storeIndex*30));
							    			return false;
										}
							    	}
								}
				 			}
		 				}
		 			}
		 			
		 			//仅售价促销，售价促销
		 			if(promType==1 || promType==3){
		 				if(appendProm == 1 || appendProm == 2){
		 					top.jWarningAlert("请确认门店信息无误，再进行下一步操作！");
		 					pArtPromHandler.getUnitsCanvas().clickRowByIndex(unitsIndex);
		 					pArtPromHandler.getItemsCanvas().clickRowByIndex(itemIndex);
		 					$(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+(unitsIndex*25))
		 					 $(".pro_store_items").scrollTop($("#m_cols_body").scrollTop()+(itemIndex*35));
		 					$("#m_cols_body").scrollTop($("#m_cols_body").scrollTop()+(storeIndex*30));
		 					return false;
		 				}
			 			if(promSellPrice==null || promSellPrice ==""){
			 				message ="代号"+unitNo+",商品货号"+itemNo+"，促销售价不能为空";
			 				top.jWarningAlert(message+"!");
			 				pArtPromHandler.getUnitsCanvas().clickRowByIndex(unitsIndex);
		 					pArtPromHandler.getItemsCanvas().clickRowByIndex(itemIndex);
		 					$(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+(unitsIndex*25))
		 					 $(".pro_store_items").scrollTop($("#m_cols_body").scrollTop()+(itemIndex*35));
		 					$("#m_cols_body").scrollTop($("#m_cols_body").scrollTop()+(storeIndex*30));
			 				return false;
			 			}else{
			 				if(!isMoney2(promSellPrice)){
			 					message ="代号"+unitNo+",商品货号"+itemNo+"，促销售价必须是不能超过二位小数的数字";
								top.jWarningAlert('warning', message+"!", '提示消息');
				 				pArtPromHandler.getUnitsCanvas().clickRowByIndex(unitsIndex);
			 					pArtPromHandler.getItemsCanvas().clickRowByIndex(itemIndex);
			 					$(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+(unitsIndex*25))
			 					 $(".pro_store_items").scrollTop($("#m_cols_body").scrollTop()+(itemIndex*35));
			 					$("#m_cols_body").scrollTop($("#m_cols_body").scrollTop()+(storeIndex*30));
				 				return false;
							}else{
				 				if(Number(promSellPrice) > Number(normSellPrice) * 0.95){
									message ="代号"+unitNo+",商品货号"+itemNo+"，促销售价必须小于等于正常售价*0.95";
				 					top.jWarningAlert( message+"!");
				 					pArtPromHandler.getUnitsCanvas().clickRowByIndex(unitsIndex);
			 						pArtPromHandler.getItemsCanvas().clickRowByIndex(itemIndex);
			 						$(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+(unitsIndex*25))
			 						 $(".pro_store_items").scrollTop($("#m_cols_body").scrollTop()+(itemIndex*35));
			 						$("#m_cols_body").scrollTop($("#m_cols_body").scrollTop()+(storeIndex*30));
				 					return false;
								}
							}
			 			}
		 			}
				}
			}
		}
	 	return true;
	 }
	 
 /*
  * 判断当前促销是否已经开始
  */
 function promIsBegin(/*None*/){
 	var promIsBeginFlag = false;
 	var promType = $("#promType").val();
 	var buybegin = $("#buyBegin").val();
 	var sellBegin = $("#sellBegin").val();
 	if(promType ==1 || promType==2){
		 if(buybegin==1){
		 	promIsBeginFlag = true;
		 }
	}
	if(promType ==3){
		if(sellBegin==1){
			promIsBeginFlag = true;
		}
	}
   return promIsBeginFlag;
 }
  /*
  * 判断当前促销是否已经结束
  */
 function promIsEnd(/*None*/){
 	var promIsEndFlag = false;
 	var promType = $("#promType").val();
 	var buyEnd = $("#buyEnd").val();
 	var sellEnd = $("#sellEnd").val();
 	if(promType ==1 || promType==3){
		 if(sellEnd==1){
		 	promIsEndFlag = true;
		 }
	}
	if(promType ==2){
		if(buyEnd==1){
			promIsEndFlag = true;
		}
	}
   return promIsEndFlag;
 
 }
 
 ///检查当前是否有没有作废的订单订单已经使用该促销期数
 function checkPromIsInOrder(/*String*/changeTime,/*Date*/buyBeginDate,/*Date*/buyEndDate,/*Array*/itemNoArray,/*Array*/storeNoArray){
 	var promNo = $("#promNo").val();
 	var returnType = false;
 	var url = ctx + '/prom/nondm/art/checkPromIsInOrder?promNo='+promNo+'&flag='+changeTime;
 	if(buyBeginDate!=0 || buyEndDate !=0){
 		url = url +"&startDate="+buyBeginDate+'&endDate='+buyEndDate;
 	}
 	if(itemNoArray != 0){
 		url = url +'&itemNoArray='+itemNoArray;
 	}
 	if(storeNoArray != 0){
 		url = url +'&storeNoArray='+storeNoArray;
 	}
 	url = url +'&ti='+(new Date()).getTime();
 	
 	$.ajax({
 		 async : false,
 		 beforeSend: function(){},
		 url: url,
	     type: "post",
	     success: function(result) {
	        if(result.inOrder == '0'){
	        	returnType = true;
	        }
	     }
    });
    return returnType;
 }
 //判断促销期数是否为空
 function isUpdatePage(/*None*/){
 	var isUpdatePage = false;
 	var promNo = $("#promNo").val();
 	if(promNo){
 		isUpdatePage = true; 
 	}
 	return isUpdatePage;
 }
	 
	 
	 
	 //判断是不是金钱
	function isMoney4(/*String*/param){
		var reg = /^([1-9][\d]{0,7}|0)(\.[\d]{1,4})?$/;
	    if($.trim(param)==''){
	    	return true;
	    }
	    if(!reg.test(param)){  
	       return false; 
	     }else{
	    	return true;
	    }
	}
	//判断是不是金钱
	function isMoney2(/*String*/param){
		var reg = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
	    if($.trim(param)==''){
	    	return true;
	    }
	    if(!reg.test(param)){  
	       return false; 
	     }else{
	    	return true;
	    }
	}
	//判断是不是数字
	function isNumber(/*String*/param){  
   		 var reg = new RegExp("^[0-9]*$"); 
   		 if($.trim(param)==''){
    		return true;
   		 }
    	if(!reg.test(param)){  
      		 return false; 
     	}else{
    		return true;
    	}
	} 
	 //四舍五入，保留位数为roundDigit
	function   roundFun(numberRound,roundDigit)  {   
		if   (numberRound>=0){
			var   tempNumber   =   parseInt((numberRound   *   Math.pow(10,roundDigit)+0.5))/Math.pow(10,roundDigit);
			return   tempNumber;
		} else{
			numberRound1=-numberRound;
			var   tempNumber   =   parseInt((numberRound1   *   Math.pow(10,roundDigit)+0.5))/Math.pow(10,roundDigit);
			return   -tempNumber;
		}
	}
	