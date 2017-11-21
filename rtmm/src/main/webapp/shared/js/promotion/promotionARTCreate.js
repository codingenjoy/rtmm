var num =1;
var ItemsStoreArray=new Array();
var itemsStoreJson;

//function enterUnitNoShow(/*Event Object*/evtObj,obj) {
//	 var evt=evtObj?evtObj:(window.event?window.event:null);//兼容IE和FF
//	 if (evt.keyCode==13){
//		obj.blur();
//	 }
//};
function sortNumber(a,b){
	return a - b;
}
$(function() {
		$("#Tools2").removeClass("Tools2_disable").addClass("Tools2");
		 $(".isCheckAllsART").live("click",function(){
		    if(this.checked){
		        $(".isChecksART").attr("checked",true);    
		    }
		    else{
		        $(".isChecksART").attr("checked",false);    
		    }
		});
		
		
		$(".tags_close").bind("click",function(){
			$(top.document).find("#contentIframe").attr("src",ctx + '/prom/nondm/art/ARTPromo');
		});
		
		 $(".subjName,.catlgId").bind("focus",function (){
    		$(this).removeClass("errorInput");
    	});
    	
    	$(".isChecksART").live("click",function(){
			var falg = true;
			$(".isChecksART").each(function(){
				if($(this).attr("checked") ==null){
					falg = false;
					return;
				}
			});
			if(falg){
				$(".isCheckAllsART").attr("checked",true);   
			}else{
				$(".isCheckAllsART").attr("checked",false); 
			}
		});
		
	});
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
	//添加代号信息行
	function addARTPromoCode(){
		var subjName=$("#subjName").val();
	    var errorInd = 0;
	    if($.trim(subjName)==''){
			   $("#subjName").removeClass('errorInput').addClass(
				'errorInput');
			   $("#subjName").attr("title",'请输入主题!');
			   errorInd++;
		 }
    	/*if($.trim(catlgId)==''){
    		$("#CatlgId").removeClass("errorInput").addClass(
				'errorInput');
			$("#CatlgId").attr("title",'请选择课别!');
			errorInd++;
     	}*/
	    
     	if(!checkAreAllInputDateValid()){
     		errorInd++;
	    }
	    
	    if(errorInd>=1) return;
	    //调用，增加新代号；
	    addOneNewPromUnitUnit();
		$(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+30);
	}
	//全部删除门店信息
//	$("#deleteAllART").die("click").live("click",function(){
//		top.grid_layer_open();
//		var allIdList = $("input.isChecksART");
//		var deleteIdList =  $("input.isChecksART:checked");
//		var unitNo = $("input.isChecksART:checked").attr("unitNoVal");
//		var unitType = $("input.isChecksART:checked").attr("unitTypeVal");
//		var ItemNo = $("input.isChecksART:checked").attr("itemNoVal");
//		var catlgId = $("input.isChecksART:checked").attr("colagNoVal");
//		if(deleteIdList.length==allIdList.length){top.jAlert('warning', '至少需要保留一个门店!', '提示消息');top.grid_layer_close();return;}
//		if(deleteIdList.length<1){top.jAlert('warning', '请选择需要删除的门店!', '提示消息');top.grid_layer_close();return;}
//		//移除商品数据的公用方法
//		 for (var i = 0; i < ItemsStoreArray.length; i++) {
//		 	var itemsStoreJson = ItemsStoreArray[i];
//		 	var jsonUnitNo = itemsStoreJson.unitNo;
//		 	var jsonUnitType = itemsStoreJson.unitType;
//		 	var jsonCatlgId = itemsStoreJson.catlgId;
//		 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
//		 		var storeArray = itemsStoreJson.storeArray;
//		 		for (var j = 0; j < storeArray.length; j++) {
//		 			var storeJson = storeArray[j];
//		 			var jsonItemNo = storeJson.itemNo;
//		 			var jsonStoreNo = storeJson.storeNo;
//		 			var promNo = storeJson.existPromNo;
//		 			if(jsonItemNo == ItemNo){
//			 			for (var index = 0; index < deleteIdList.length; index++) {
//			 				var storeNo = deleteIdList[index].name;
//			 				if(jsonStoreNo==storeNo){
//			 					storeArray = storeArray.del(j);
//			 					j=-1;
//			 				}
//			 			}
//		 			}
//		 			ItemsStoreArray[i].storeArray = storeArray;
//		 		}
//		 	}
//		 	 $("#showDeleteSuppler").removeClass("createNewBar_off").addClass("createNewBar");
//		 }
//		 
//		
//		$(".isChecksART:checked").each(function(){
//		 	var deleteId = $(this).attr("deleteId");
//		 	$("#"+deleteId).remove();
//		 	$(this).parent().parent().remove();
//		 });
//		 /*第二版开始*/
//		var removeItemClas = false;  
//		$(".isChecksART").each(function(){
//			var isHasCheck = $(this).parents("tr").hasClass("trBgRed");
//		 	if(isHasCheck){
//		 		removeItemClas = true;
//		 		return false;
//		 	}
//		});
//		if(!removeItemClas){$("#pro_item_store_info").find("div[itemnovalue="+ItemNo+"]").removeClass("bgColorRed");}
//		/*第二版结束*/
//		
//	    $(".isCheckAllsART").attr("checked",false);
//	   top.grid_layer_close();
//	});
    
    //根据代号，代号类型，课别查找商品信息
	/*
   $(".supplerItem").die("click").live("click", function () {
    	if(!checkUnitListIsEmpty()){
      		var cisd = true;
      	 	var thisHasItemNoClass = $(this).hasClass("item_on");
      	 	if(thisHasItemNoClass)
      	 		return;
		    if(!thisHasItemNoClass){
		    	var unitlength = $("#ArtPromoCodeDiv").find("input[id='unitNo']").length;
		    	if(unitlength == 1){
		    		cisd = checkItemStoreDate();
		    	}
		    	
		    }
    		if(cisd){
    			$("#ArtPromoCodeDiv").find(".item_on").removeClass("item_on");
      	 		$(this).addClass("item_on");
		    	$(".pro_store_items").html("");
		    	$("#shopBodyTable").html("");
		    	$("#shopHeadTable").html("");
		    	
		    	var promType = $("#promType").val(); 
		    	var unitType= $(this).find("select[name='unitType']").val();
		    	var unitNo = $(this).find("input[name='unitNo']").val();
		    	var catlgId = $("#CatlgId").val();
		    	var buyprice = $(this).find("input.promBuyPriceHead[name=unit]").val();
		    	var sellprice = $(this).find("input.promSellPriceHead[name=unit]").val();
		    	$("input.promBuyPriceHead[child=1]").val(buyprice);
		    	$("input.promSellPriceHead[child=1]").val(sellprice);
		    	if(unitType == null || unitType =="" || unitNo==null || unitNo=="" || catlgId ==null || catlgId ==""){
		    		return;
		    	}else{
		    		top.grid_layer_open();
		    		//查询商品信息
		    		 var itemOnNo ="";
		    		 var itemOn = "";
					 for (var i = 0; i < ItemsStoreArray.length; i++) {
					 	var itemsStoreJson = ItemsStoreArray[i];
					 	var jsonUnitNo = itemsStoreJson.unitNo;
					 	var jsonUnitType = itemsStoreJson.unitType;
					 	var jsonCatlgId = itemsStoreJson.catlgId;
					 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
					 		var storeArray = itemsStoreJson.storeArray.sort(
						 		function(a,b){  //自定义函数排序  
								    var a1= parseInt(a.itemNo);  
								    var b1= parseInt(b.itemNo);  
								    if(a1<b1){return -1;}else if(a1>b1){return 1;}  
								    return 0;
						 		}
					 		);
					 		for (var j = 0; j < storeArray.length; j++) {
					 			var storeJson = storeArray[j];
					 			var jsonItemNo = storeJson.itemNo;
					 			var jsonItemName = storeJson.itemName;
					 			var isHadAdd=true;
					 			$("div.addItems").each(
					 				function(){
					 					var itemNo = $(this).attr("itemNoValue");
					 					if(itemNo == jsonItemNo){
					 						isHadAdd= false;
					 					}
					 				}
					 			);
					 			if(isHadAdd){
					 				if(j == 0){
					 					itemOnNo = jsonItemNo;
					 					itemOn = "item_on" ;
					 				}else{
					 					itemOn ="";
					 				}
					 				if(jsonUnitType=='0'){
					 					$(".pro_store_items").append("<div class='item addItems "+itemOn+"' itemNoValue='"+jsonItemNo+"' unitNoValue='"+unitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+jsonItemNo+"-"+jsonItemName+"</span></div>");
					 				}else{
					 					$(".pro_store_items").append("<div class='item addItems "+itemOn+"' itemNoValue='"+jsonItemNo+"' unitNoValue='"+unitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+jsonItemNo+"-"+jsonItemName+"</span><span class='pstb_del2'></span></div>");
					 				}
					 			}
					 			
				 				//显示门店信息
			        			if(itemOnNo == jsonItemNo){
			        				var num = parseInt(Math.random()*100000);
			        				appendShopBodyTable(storeJson,num,unitType,unitNo,catlgId);
			        				appendShopHeadTable(storeJson,num,unitType,unitNo,catlgId);
			        			}
					 		}
					 	}
					 }
					 $("#m_cols_head").scrollLeft(0);
					 $("#m_cols_body").scrollLeft(0);
					 $("#m_cols_body").scrollTop(0);
					 changeInputByPromPriceType(promType);
					 top.grid_layer_close();
		    	}
    		}
    	}else{
    		$("#ArtPromoCodeDiv").find(".item_on").removeClass("item_on");
      	 	$(this).addClass("item_on");
    	}
    	
    });
	*/
	function addStoreGrpTypeReturn(data){
	    var unitType=$("#ArtPromoCodeDiv .item_on").find("select[name='unitType']").val();
	    var oldUnitNo = $("#ArtPromoCodeDiv .item_on").find("input[name='unitNo']").val();
		var catlgId = $("#CatlgId").val();
		var promType = $("#promType").val(); 
		if (data != undefined){
			var isHave = checkHasOne(unitType,data.promUnitNo,catlgId);
			if(isHave){
				top.grid_layer_open();
				//如果之前有数据，则将之前的老数据删除
				if(oldUnitNo!=null && oldUnitNo!=""){
					//移除代号的方法(临时json)
					 for (var j = 0; j < ItemsStoreArray.length; j++) {
					 	var itemsStoreJson = ItemsStoreArray[j];
					 	var jsonUnitNo = itemsStoreJson.unitNo;
					 	if(jsonUnitNo == oldUnitNo ){
					 		ItemsStoreArray = ItemsStoreArray.del(j);
					 		j=-1;
					 	}
					 }
				}
				
				var storeArray=new Array();
				if(data != null && data.list != null){
					$("#shopBodyTable").html("");
 		 			$("#shopHeadTable").html("");
 		 			$(".pro_store_items").html("");
	 				 var onItemNo="";
	 				 if(unitType=='0'){
	 				 	onItemNo = data.promUnitNo;
	 				 	var fliterList = filterCheckItemNo(onItemNo,unitType);
	 				 	if(fliterList ==null || fliterList.length <1){
	 				 		top.grid_layer_close();
	 				 		top.jAlert('warning', '该代号下没有符合的商品！', '提示消息');
	 				 		$("#ArtPromoCodeDiv .item_on").find("input[name='unitNo']").val("");
	 				 		return;
	 				 	}
	 				 	 var promNo = data.itemList[0].promNo;
 		 				 var bgColor ="";
 		 				 if(promNo){
 		 				 	bgColor="bgColorRed";
 		 				 }
	 				 	
	 				 	
	 				 	$(".pro_store_items").append("<div class='item addItems item_on "+bgColor+"' itemNoValue='"+data.promUnitNo+"' unitNoValue='"+data.promUnitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+data.promUnitNo+"-"+data.promUnitName+"</span></div>");
	 				 }else{
	 				 	var fliterList = filterCheckItemNo(data.itemList,unitType);
	 				 	if(fliterList !=null ){
 		 				 	for (var j = 0; j < fliterList.length; j++) {
 		 				 		var itemVo  = fliterList[j];
 		 				 		var isSelected = (j==0);
 		 				 		var itemOn = "";
			 					if(isSelected){
			 						itemOn = "item_on";
			 						onItemNo = itemVo.itemNo;
			 					}
			 					//$(".pro_store_items").append("<div class='item addItems "+itemOn+"' itemNoValue='"+itemVo.itemNo+"' unitNoValue='"+data.promUnitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+itemVo.itemNo+"-"+itemVo.itemName+"</span><span class='pstb_del2'></span></div>");
			 					addOneNewItem2SpecPromUnit(itemVo.itemNo, data.promUnitNo, catlgId, unitType, isSelected);
				 				
 		 				 	}
	 				 	}else{
	 				 		top.grid_layer_close();
	 				 		$("#ArtPromoCodeDiv .item_on").find("input[name='unitNo']").val("");
	 				 		return;
	 				 	}
	 				 }
					for (var i = 0; i < data.list.length; i++) {
	        			var store = data.list[i];
	        			//显示门店信息
	        			if(onItemNo == store.itemNo){
	        				var num = parseInt(Math.random()*100000);
	        				appendShopBodyTable(store,num,unitType,data.promUnitNo,catlgId);
			        		appendShopHeadTable(store,num,unitType,data.promUnitNo,catlgId);
	        			}
	        			var storeJson = {"promSupNo":store.stMainSupNo,"mainComName":store.mainComName,"status":store.status,"basicStatus":store.basicStatus,"statusName":store.itemStatusName,"storeNo":store.storeNo,"storeName":store.storeName,"itemNo":store.itemNo,"unitType":unitType,"unitNo":data.promUnitNo,"normBuyPrice":store.normBuyPrice,"normSellPrice":store.normSellPrice,"promBuyPrice":"","promSellPrice":"","netCost":store.netCost,"sellVat":store.vatVal,"itemName":store.itemName,"priceCut":"","netMaori":"","buyPriceLimit":store.buyPriceLimit,"buyWhen":store.buyWhen,"appendBuy":store.appendBuy,"appendProm":store.appendProm,"existPromNo":store.promNo};
        			    storeArray[storeArray.length] = storeJson;
        			    $("#m_cols_head").scrollLeft(0);
        			    $("#m_cols_body").scrollLeft(0);
        			    $("#m_cols_body").scrollTop(0);
	        		}
	        		//var itemsStoreJson ={"unitType":unitType,"unitNo":data.promUnitNo,"catlgId":catlgId,"promActvy":"0","pmGiftHint":"","memo":"","storeArray":storeArray};
	        		var itemsStoreJson ={"unitType":unitType,"unitNo":data.promUnitNo,"catlgId":catlgId,"storeArray":storeArray};
    			    ItemsStoreArray[ItemsStoreArray.length] = itemsStoreJson;
    			    $(".item_on").find("input[name='unitNo']").val(data.promUnitNo);
    				$(".item_on").find("input[name='promUnitName']").val(data.promUnitName);
    				$(".item_on").find("input[name='oUnitNo']").val(data.promUnitNo);
    				//$(".item_on").find("select[name='promActvy']").val("0");
					$(".item_on").find(".promBuyPriceHead").val("");
				    $(".item_on").find(".promSellPriceHead").val("");
					//$(".item_on").find("input.pmGiftHint").val("");
					//$(".item_on").find("input.memo").val("");
    				$(".promBuyPriceHead[child=1]").val("");
				    $(".promSellPriceHead[child=1]").val("");
    				
    				changeInputByPromPriceType(promType);
				}
        		
			}else{
				top.jAlert('warning', '该代号已经存在，请重新选择！', '提示消息');
			}
				top.grid_layer_close();	
			}
			top.closePopupWin();
				
	}

	 //代号类型的选择事件
	/*
    $(".unitTypeChange").live("change",function (){
    	var $supplerItem = $(this).parents(".supplerItem");
    	var unitNo = $supplerItem.find("input[name='unitNo']").val();
    	 //移除代号的方法(临时json)
		 for (var i = 0; i < ItemsStoreArray.length; i++) {
		 	var itemsStoreJson = ItemsStoreArray[i];
		 	var jsonUnitNo = itemsStoreJson.unitNo;
		 	if(jsonUnitNo == unitNo ){
		 		ItemsStoreArray = ItemsStoreArray.del(i);
		 		i=-1;
		 	}
		 }
		$supplerItem.find("input[name='oUnitNo']").val("");
		$supplerItem.find("input[name='unitNo']").val("");
		$supplerItem.find("input[name='promUnitName']").val("");
		//$supplerItem.find("select[name='promActvy']").val("0");
		$supplerItem.find("input.promBuyPriceHead").val("");
		$supplerItem.find("input.promSellPriceHead").val("");
		//$supplerItem.find("input.pmGiftHint").val("");
		//$supplerItem.find("input.memo").val("");
		
		 $("#shopBodyTable").html("");
		 $("#shopHeadTable").html("");
		 $(".pro_store_items").html("");
		
    });
    */
	
    $(".unitNo").die("focus").live("focus",function(){
    	//验证时间
		if(!checkAreAllInputDateValid()){
			$(this).val("");
			return;
		}
		$(this).parents(".supplerItem").trigger('click');
    });
    

	
	/*
	//删除代号行的事件
	$(".pstb_del").live("click",function(){
		 
		 var $row = $(this).parent(".supplerItem");
		 var unitNo = $row.find("input[name='unitNo']").val();
		 var unitType=$row.find("select[name='unitType']").val();
		 var catlgId = $("#CatlgId").val();
		 
		  //移除代号的方法(临时json)
		 for (var i = 0; i < ItemsStoreArray.length; i++) {
		 	var itemsStoreJson = ItemsStoreArray[i];
		 	var jsonUnitNo = itemsStoreJson.unitNo;
		 	var jsonUnitType = itemsStoreJson.unitType;
		 	var jsonCatlgId = itemsStoreJson.catlgId;
		 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
		 		ItemsStoreArray = ItemsStoreArray.del(i);
		 		i=-1;
		 	}
		 	
		 }
		 
		if($row.hasClass("item_on")){//判断是否删除选中的代号，如果是清除商品，和门店
		 	 $("#shopBodyTable").html("");
		 	 $("#shopHeadTable").html("");
		 	 $(".pro_store_items").html("");
		 	 $("input.promBuyPriceHead[child=1]").val("");
		     $("input.promSellPriceHead[child=1]").val("");
		     $("#ArtPromoCodeDiv div:first-child").click();
		}
		 $(".pro_store_tb_edit").scrollLeft(0);
		 $row.remove();
	});
	*/
	
	function addStoreSupMessReturn(storeIdArray){
		var promType = $("#promType").val();
		var unitNo = $("#ArtPromoCodeDiv").find("div.item_on").find("input[id=unitNo]").val();
		var catlgId = $("#CatlgId").val();
		var unitType=$("#ArtPromoCodeDiv").find("div.item_on").find("select[id=unitType]").val();
		var itemNo = $(".addItems.item_on").attr("itemnovalue");
		if(storeIdArray.length > 0 && storeIdArray.length> 0 ){
			$.ajax({
				async : false,
				url: ctx + '/prom/nondm/art/showSupplerList?storeNos='+storeIdArray+'&unitType='+unitType+'&unitNo='+unitNo+"&catlgId="+catlgId+"&itemNo="+itemNo+'&promType='+promType,
		        type: "post",
		        dataType:"json",
		        success: function(result) {
		        	if(result.storelist.length > 0){
		        		//var shopHeadTable="";
		        		//var shopBodyTable ="";
		        		for (var i = 0; i < ItemsStoreArray.length; i++) {
						 	var itemsStoreJson = ItemsStoreArray[i];
						 	var jsonUnitNo = itemsStoreJson.unitNo;
						 	var jsonUnitType = itemsStoreJson.unitType;
						 	var jsonCatlgId = itemsStoreJson.catlgId;
						 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
						 		var storeArray = itemsStoreJson.storeArray;
						 		for (var j = 0; j < result.storelist.length; j++) {
						 			var store = result.storelist[j];
						 			var storeJson = {"promSupNo":store.stMainSupNo,"mainComName":store.mainComName,"status":store.status,"basicStatus":store.basicStatus,"statusName":store.itemStatusName,"storeNo":store.storeNo,"storeName":store.storeName,"itemNo":store.itemNo,"unitType":unitType,"unitNo":unitNo,"normBuyPrice":store.normBuyPrice,"normSellPrice":store.normSellPrice,"promBuyPrice":"","promSellPrice":"","netCost":store.netCost,"sellVat":store.vatVal,"itemName":store.itemName,"priceCut":"","netMaori":"","buyPriceLimit":store.buyPriceLimit,"buyWhen":store.buyWhen,"appendBuy":store.appendBuy,"appendProm":store.appendProm,"existPromNo":store.promNo};
						 			storeArray[storeArray.length] = storeJson;
						 			var num = parseInt(Math.random()*100000);
						 			appendShopBodyTable(store,num,unitType,unitNo,catlgId);
			        			    appendShopHeadTable(store,num,unitType,unitNo,catlgId);
						 			/*shopHeadTable+="<tr><td style='width:30px;'><input type='checkbox' class='isChecksART' deleteId='"+(j+num)+"'  name='"+store.storeNo+"' unitTypeVal='"+unitType+"' unitNoVal='"+unitNo+"' itemNoVal='"+itemNo+"' colagNoVal='"+catlgId+"'/></td>";
				        			shopHeadTable+="<td><div style='width:110px;'><input type='text' class='inputText w85 Black' readonly='readonly' value='"+store.storeNo+"-"+store.storeName+"'/></div></td></tr>";
				        			
						 			//门店soteNo
				        			shopBodyTable+="<tr id='"+(j+num)+"'>";
				        			shopBodyTable+="<td><div style='width:100px;' > <input type='text' class='inputText w95 Black status' readonly='readonly' name='"+store.basicStatus+"'  value='"+store.status+"-"+store.itemStatusName+"'/></div></td>";
				        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 Black' readonly='readonly' name='normBuyPrice'  value='"+store.normBuyPrice+"' /></div></td>";
				        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 promBuyPriceBody' buyPriceLimit='"+store.buyPriceLimit+"' buyWhen='"+store.buyWhen+"' value=''/></div></td>";
				        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 Black normSellPrice' readonly='readonly' name='normSellPrice'   value='"+store.normSellPrice+"'/></div></td>";
				        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 promSellPriceBody' value='' /></div></td>";
				        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 Black priceCut' readonly='readonly' value='' /></div></td>";
				        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 Black netMaori' readonly='readonly' value='' /></div></td>";
				        			shopBodyTable+="<td><div style='width:60px;'><input type='hidden' id='netCost' name='' value='"+store.netCost+"' /><input type='hidden' id='vat' name='' value='"+store.vatVal+"' /><input class='w95 Black inputText' type='text' value='"+store.stMainSupNo+"'></div></td>";
				        			shopBodyTable+="<td><div style='width:185px;'><input type='text' class='inputText w95 Black' readonly='readonly'  value='"+store.mainComName+"'/></div></td>";
				        			shopBodyTable+="</tr>";*/
						 		}
						 	   ItemsStoreArray[i].storeArray=storeArray;
						 	   $("#m_cols_head").scrollLeft(0);
						 	   $("#m_cols_body").scrollLeft(0);
						 	   $("#m_cols_body").scrollTop(0);
						 	}
		        		}
		        		//$("#shopHeadTable").append(shopHeadTable);
		        		//$("#shopBodyTable").append(shopBodyTable);
		        		changeInputByPromPriceType(promType);
		        	}
		        }
			 });
		}
		top.closePopupWin();
	}
	
	//选择删除的门店信息
	$("#showDeleteSuppler").die("click").live("click",function(){
		var buyts = $("#buyTimeStart").val();
		var buyte = $("#buyTimeEnd").val();
		var promts= $("#promTimeStart").val();
		var promte= $("#promTimeEnd").val();
		var promType = $("#promType").val();
		var storeNos= new Array();
		var unitNo = $("#ArtPromoCodeDiv").find("div.item_on").find("input[id=unitNo]").val();
		var catlgId = $("#CatlgId").val();
		var unitType=$("#ArtPromoCodeDiv").find("div.item_on").find("select[id=unitType]").val();
		var itemNo = $(".addItems.item_on").attr("itemnovalue");
		var isOff = $(this).hasClass("createNewBar_off");
		$(".isChecksART").each(function(i){
			storeNos[i] = $(this).attr("name");
		});
		if(unitNo != null && catlgId !=null && unitType !=null&&catlgId!=""&&unitNo != ""&&unitType !=""&&itemNo!="" && itemNo !=null&&!isOff){
			top.openPopupWin(800,480, '/prom/nondm/art/showARTDeleteSupplerList?storeNos='+storeNos+'&unitNo='+unitNo+'&catlgId='+catlgId+'&itemNo='+itemNo+'&promType='+promType+'&buyStartDate='+buyts+'&buyEndDate='+buyte+'&promStartDate='+promts+'&promEndDate='+promte);
		}
	});
		
	function addSelectedItemReturn(itemNoArray,itemNameArray){
		var promType = $("#promType").val(); 
		var unitNo;
		var catlgId;
		var unitType;
		$(".addItems").each(function(i){
			if(i<1){
				unitNo = $(this).attr("unitNoValue");
				catlgId = $(this).attr("catlgIdValue");
				unitType = $(this).attr("unitType");
			}
		});
		if(itemNoArray.length > 0 && itemNameArray.length> 0){
			for (var i = 0; i < itemNoArray.length; i++) {
				$(".pro_store_items").append("<div class='item addItems' itemNoValue='"+itemNoArray[i]+"' unitNoValue='"+unitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+itemNoArray[i]+"-"+itemNameArray[i]+"</span><span class='pstb_del2'></span></div>");
			}
			$.ajax({
				async : false,
				url: ctx + '/prom/nondm/art/ItemsStoreInfoBy?unitType='+unitType+'&unitNo='+unitNo+"&catlgId="+catlgId+"&itemsNoArray="+itemNoArray+"&promType="+promType,
		        type: "post",
		        dataType:"json",
		        success: function(result) {
		        	if(result.storeList.length > 0){
		        		for (var i = 0; i < ItemsStoreArray.length; i++) {
						 	var itemsStoreJson = ItemsStoreArray[i];
						 	var jsonUnitNo = itemsStoreJson.unitNo;
						 	var jsonUnitType = itemsStoreJson.unitType;
						 	var jsonCatlgId = itemsStoreJson.catlgId;
						 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
						 		var storeArray = itemsStoreJson.storeArray;
						 		for (var j = 0; j < result.storeList.length; j++) {
						 			var store = result.storeList[j];
						 			var storeJson = {"promSupNo":store.stMainSupNo,"mainComName":store.mainComName,"status":store.status,"basicStatus":store.basicStatus,"statusName":store.itemStatusName,"storeNo":store.storeNo,"storeName":store.storeName,"itemNo":store.itemNo,"unitType":unitType,"unitNo":unitNo,"normBuyPrice":store.normBuyPrice,"normSellPrice":store.normSellPrice,"promBuyPrice":"","promSellPrice":"","netCost":store.netCost,"sellVat":store.vatVal,"itemName":store.itemName,"priceCut":"","netMaori":"","buyPriceLimit":store.buyPriceLimit,"buyWhen":store.buyWhen,"appendBuy":store.appendBuy,"appendProm":store.appendProm,"existPromNo":store.promNo};
						 			storeArray[storeArray.length] = storeJson;
						 		}
						 		ItemsStoreArray[i].storeArray=storeArray;
						 	}
						 	
		        		}
		        	}
		        }
			  });
		}
		top.closePopupWin();
	}
	
	//显示删除的商品信息弹出框
	$("#showDeleteItems").live("click",function(){
		var buyts = $("#buyTimeStart").val();
		var buyte = $("#buyTimeEnd").val();
		var promts= $("#promTimeStart").val();
		var promte= $("#promTimeEnd").val();
		var isOff = $(this).hasClass("createNewBar_off");
		var promType = $("#promType").val(); 
		if(isOff){
			return;
		}
		var itemsNos= new Array();
		var unitNo;
		var catlgId;
		var unitType;
		$(".addItems").each(function(i){
			itemsNos[i] = $(this).attr("itemNoValue");
			if(i<1){
				unitNo = $(this).attr("unitNoValue");
				catlgId = $(this).attr("catlgIdValue");
				unitType = $(this).attr("unitType");
			}
		});
		if(itemsNos.length == 0){
			top.jAlert('warning', '请确保该代号下至少有一个商品！', '提示消息');
		}else{
			if(unitType != 0){
				top.openPopupWin(420,480,'/prom/nondm/art/showARTDeleteItemsList?itemsValue='+itemsNos+'&unitNo='+unitNo+'&catlgId='+catlgId+'&unitType='+unitType+'&flag=ART&promType='+promType+'&buyStartDate='+buyts+'&buyEndDate='+buyte+'&promStartDate='+promts+'&promEndDate='+promte);
			}
		}
	});
    //点击商品，查询所有的门店信息
    $(".addItems").live("click",function(){
    	top.grid_layer_open();
    	$("input.promBuyPriceHead[child=1]").val("");
		$("input.promSellPriceHead[child=1]").val("");
    	var promType = $("#promType").val();
    	var ItemNo = $(this).attr("itemNoValue");
    	var unitNo = $(this).attr("unitnovalue");
    	var catlgId = $(this).attr("catlgIdValue");
    	var unitType=$(this).attr("unitType");
    	/*var isHave = checkHasOne(ItemNo,unitNo,catlgId);*/
    	$("#shopHeadTable").html("");
    	$("#shopBodyTable").html("");
    	$(".addItems").parent("div.pro_store_items").find(".item_on").removeClass("item_on");
    	$(this).addClass("item_on");
    	//查询商品信息
		 for (var i = 0; i < ItemsStoreArray.length; i++) {
		 	var itemsStoreJson = ItemsStoreArray[i];
		 	var jsonUnitNo = itemsStoreJson.unitNo;
		 	var jsonUnitType = itemsStoreJson.unitType;
		 	var jsonCatlgId = itemsStoreJson.catlgId;
		 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
		 		var storeArray = itemsStoreJson.storeArray;
		 		
		 		for (var j = 0; j < storeArray.length; j++) {
		 			var store = storeArray[j];
		 			var jsonItemNo = store.itemNo;
		 			if(jsonItemNo == ItemNo){
	        		    var num1 = parseInt(Math.random()*100000);
	        		    appendShopBodyTable(store,num1,unitType,unitNo,catlgId);
			        	appendShopHeadTable(store,num1,unitType,unitNo,catlgId);
		 			}
		 		}
		 	}
    	 }
    	 $("#m_cols_head").scrollLeft(0);
		 $("#m_cols_body").scrollLeft(0);
		 $("#m_cols_body").scrollTop(0);
		 changeInputByPromPriceType(promType);
		 top.grid_layer_close();
    });
    //选择课别信息
    /*$(".showCatlgWin").live('click',function(){
		top.window.$.fn.zWindow({
			width : 602,
			height : 152,
			titleable : true,
			title : '选择课别信息',
			moveable : true,
			windowBtn : [ 'close' ],
			windowType : 'iframe',
			targetWindow : top,
			windowSrc : ctx+'/prom/nondm/art/showCatlgWin',
			resizeable : false,
			 关闭后执行的事件 
			afterClose : function(data) {
				if (data != undefined){
					if(num > 1){
						 $("#ArtPromoCodeDiv").html("");
			 	 		 $("#shopBodyTable").html("");
						 $("#shopHeadTable").html("");
						 $(".pro_store_items").html("");
						 $(".promSellPriceHead").val("");
				 	 	 $(".promBuyPriceHead").val("");
					}
					num++;
					$("#CatlgId").val(data.CatlgId);
					$("#CatlgName").val(data.CatlgName);
					$("#CatlgId").removeClass('errorInput');
					
					 for (var i = 0; i < ItemsStoreArray.length; i++) {
					 	var itemsStoreJson = ItemsStoreArray[i];
					 	var jsonCatlgId = itemsStoreJson.catlgId;
					 	if(jsonCatlgId == data.CatlgId  ){
					 		ItemsStoreArray = ItemsStoreArray.del(i);
					 		i=-1;
					 	}
					 }
				}
			}, 
			isMode : true
		});
	});*/
	$(".pstb_del").live("click",function(e){
		e.stopPropagation();
	});
	/**
	 * 促销进价，促销售价的关联变化
	 * promBuyPriceHead，promSellPriceHead
	 * promBuyPriceBody，promSellPriceBody
	 */
	$(".promSellPriceBody,.promBuyPriceBody,.promSellPriceHead,.promBuyPriceHead").die("focus").live("focus",function(){
			$(this).removeClass("errorInput");
	});
	//点击promBuyPriceHead，promSellPriceHead 改变promBuyPriceBody，promSellPriceBody,并计算降价幅度，和净毛利
	$(".promBuyPriceHead").die("change").live("change",function(){
		var isOff=$(this).hasClass("Black");
		if(!isOff){
			var promType = $("#promType").val();
			var child = $(this).attr("child");
			var selectItemOnDiv =   $(this).parents("div").hasClass("item_on");
			if(child==1){
				selectItemOnDiv = true;
			}
			if(selectItemOnDiv){
				if(promType==1 || promType==2){
					var promBuyPriceHeadVal = $(this).val();
					var isPass = true;
					var isPass2= true;
					var isRight1 = true;
					var isRight2 = true;
					var isPass3 = 0;
					if(promBuyPriceHeadVal == null || promBuyPriceHeadVal =="" || Number(promBuyPriceHeadVal) <= 0){
						$(this).val("");
						return false;
					}
					if(!isMoney4(promBuyPriceHeadVal))
			  		{
						top.jAlert('warning', '促销进价必须是不能超过四位小数的数字!', '提示消息');
						$(this).val('');
						isPass =false;
			  			return false;
			  	    }else{
						if($(this).attr("name")=="unit"){
							$("input.promBuyPriceHead[child=1]").val(promBuyPriceHeadVal);
						}else{
							var ut =$("#ArtPromoCodeDiv").find("div.item_on").find("select.unitTypeChange").val();
							if(ut == 0){
							$("#ArtPromoCodeDiv").find("div.item_on").find("input.promBuyPriceHead[name=unit]").val(promBuyPriceHeadVal);
							}
						}
						/*//top.grid_layer_open();*/
						$(".promBuyPriceBody").each(function(){
							var $tr = $(this).parents("tr");
							var checkTrId = $tr.attr("id");
							var checkTr = $("input:checkbox[deleteid='"+checkTrId+"']");
							var catlgId = checkTr.attr("colagnoval");
							var itemNo = checkTr.attr("itemnoval");
							var unitNo = checkTr.attr("unitnoval");
							var unitType = checkTr.attr("unittypeval");
							var normBuyPrice = $(this).parents("tr").find("input[name='normBuyPrice']").val();
							var buyWhen = $(this).attr("buyWhen");
							var buyPriceLimit = $(this).attr("buyPriceLimit");
							var promBuyPrice = $(this).val();
							var promBuyPriceHeadVal1="";
							if(!$(this).hasClass("Black")){
								if(buyWhen == "2"){
									if(buyPriceLimit !="null" && (Number(promBuyPriceHeadVal)>Number(buyPriceLimit))&& buyPriceLimit !=null){
										isRight1 = false;
				  	    				if(promBuyPrice !=null && promBuyPrice !=""){
											promBuyPriceHeadVal1 = promBuyPrice;
											if(buyPriceLimit !="null" && (Number(promBuyPriceHeadVal1)>Number(buyPriceLimit))&& buyPriceLimit !=null){
												isPass =false;
												promBuyPriceHeadVal1="";
												$(this).removeClass("errorInput").addClass("errorInput");
											}else{
												$(this).removeClass("errorInput");
											}
										}else{
											isPass =false;
											promBuyPriceHeadVal1 = "";
											$(this).removeClass("errorInput").addClass("errorInput");
										}
					  	    		}else{
					  	    			$(this).removeClass("errorInput");
					  	    			promBuyPriceHeadVal1 = promBuyPriceHeadVal;
					  	    		}
				  	    		}else{
				  	    			if(Number(promBuyPriceHeadVal) >= Number(normBuyPrice)){
				  	    				isRight2 = false;
				  	    				if(promBuyPrice !=null && promBuyPrice !=""){
				  	    					promBuyPriceHeadVal1= promBuyPrice;
				  	    					if(Number(promBuyPriceHeadVal1) >= Number(normBuyPrice)){
												$(this).removeClass("errorInput").addClass("errorInput");
												promBuyPriceHeadVal1="";
												isPass2 =false;
											}else{
												$(this).removeClass("errorInput");
											}
				  	    				}else{
				  	    					isPass2 =false;
											promBuyPriceHeadVal1 = "";
											$(this).removeClass("errorInput").addClass("errorInput");
				  	    				}
				  	    			}else{
				  	    				$(this).removeClass("errorInput");
					  	    			promBuyPriceHeadVal1 = promBuyPriceHeadVal;
				  	    			}
				  	    		}
							}
							$(this).val(promBuyPriceHeadVal1);
						});
						isPass3 = saveBuyPromValue(promBuyPriceHeadVal,child)
						//top.grid_layer_close();
			  	    }
			  	    if(!isPass || isPass3 ==1 || !isRight1){
			  	    	top.jAlert('warning', '促销进价不能大于买价限制!', '提示消息');
			  	    }
			  	    if(!isPass2 || isPass3 == 2 || !isRight2){
			  	    	top.jAlert('warning', '促销进价必须小于正常进价!', '提示消息');
			  	    }
			  	    if(!isPass || !isPass2 || isPass3 != 0 || !isRight1 || !isRight2){
			  	      $("input.promBuyPriceHead[child=1]").val("");
			  	      $("#ArtPromoCodeDiv").find("div.item_on").find("input.promBuyPriceHead[name=unit]").val("");
			  	    }
				}else{
					$(this).val("")
					top.jAlert('warning', '请选择时间！', '提示消息');
				}
			}else{
				return false;
			}
		}
	});
	
	$(".promSellPriceHead").die("change").live("change",function(){
		var isOff=$(this).hasClass("Black")
		if(!isOff){
		var selectItemOnDiv =   $(this).parents("div").hasClass("item_on");
		var child = $(this).attr("child");
		if(child == 1){
			selectItemOnDiv=true;
		}
		if(selectItemOnDiv){
		var promType = $("#promType").val();
		
		if(promType==1 || promType==3){
			var promSellPriceHeadVal = $(this).val();
			if(promSellPriceHeadVal==null || promSellPriceHeadVal == "" || Number(promSellPriceHeadVal) <= 0){/*$(this).removeClass("errorInput").addClass("errorInput");*/$(this).val("");return false;}
			var isPass = true;
			var isRight = true;
			var isPass1 =true;
			if(!isMoney2(promSellPriceHeadVal))
	  		{
				top.jAlert('warning', '促销售价必须是不能超过两位小数的数字!', '提示消息');
				$(this).val('');
				isPass =false;
	  			return false;
	  	    }
    		if($(this).attr("name")=="unit"){
				$("input.promSellPriceHead[child=1]").val(promSellPriceHeadVal);
			}else{
				var ut =$("#ArtPromoCodeDiv").find("div.item_on").find("select.unitTypeChange").val();
				if(ut == 0){
					$("#ArtPromoCodeDiv").find("div.item_on").find("input.promSellPriceHead[name=unit]").val(promSellPriceHeadVal);
				}
				
			}
			//top.grid_layer_open();
			$(".promSellPriceBody").each(function (i){
				var $tr = $(this).parents("tr");
				var checkTrId = $tr.attr("id");
				var checkTr = $("input:checkbox[deleteid='"+checkTrId+"']");
				var catlgId = checkTr.attr("colagnoval");
				var itemNo = checkTr.attr("itemnoval");
				var unitNo = checkTr.attr("unitnoval");
				var unitType = checkTr.attr("unittypeval");
				var netCost = $tr.find("input[id='netCost']").val();
				var vat = $tr.find("input[id='vat']").val();
				var promBuyPrice = $tr.find("input[name='normBuyPrice']").val();
				var normSellPrice = $tr.find("input.normSellPrice").val();
				var promsellPrice = $(this).val();
				var promSellPriceHeadVal1;
				var priceCut = "";
			    var netMaori = "";
			    if(promSellPriceHeadVal > (normSellPrice*0.95)){
			    	isRight= false;
			    	if(promsellPrice !=null && promsellPrice !=""){
						promSellPriceHeadVal1 = promsellPrice;
						 if(promSellPriceHeadVal1 > (normSellPrice*0.95)){
						 	promSellPriceHeadVal1 = "";
							$(this).removeClass("errorInput").addClass("errorInput");
							isPass=false;
						 }else{
						 	 $(this).removeClass("errorInput");
							promSellPriceHeadVal1 = promsellPrice;
						 }
					}else{
						isPass=false;
						promSellPriceHeadVal1 = "";
						$(this).removeClass("errorInput").addClass("errorInput");
					}
			    }else{
			    	$(this).removeClass("errorInput");
			    	promSellPriceHeadVal1 = promSellPriceHeadVal;
			    }
				if(promSellPriceHeadVal1 !=null && promSellPriceHeadVal1 !=""){
					priceCut = roundFun ((normSellPrice-promSellPriceHeadVal1)/normSellPrice*100,2);
					netMaori = roundFun((((Number(promSellPriceHeadVal1)/( 1 + Number(vat/100)))-Number(netCost))/( Number(promSellPriceHeadVal1)/( 1 + Number(vat/100))))*100,2);
					$tr.find("input.priceCut").val(priceCut);
					$tr.find(".netMaori").val(netMaori);
				}
				$(this).val(promSellPriceHeadVal1);
			});
			isPass1 = saveSallPromValue(promSellPriceHeadVal,child);
			
			if(!isPass || !isPass1){
				top.jAlert('warning', '促销售价必须小于等于正常售价*0.95!', '提示消息');
			}
			if(!isRight || !isPass || !isPass1){
				$("input.promSellPriceHead[child=1]").val("");
				 $("#ArtPromoCodeDiv").find("div.item_on").find("input.promSellPriceHead[name=unit]").val("");
		    }
				
		}else{
			top.jAlert('warning', '请选择时间！', '提示消息');
			$(this).val("");
		}
	}else{
		return false;
	}
	}
});
	
	
	$(".promSellPriceBody").die("blur").live("blur",function(){
		var isOff=$(this).hasClass("Black")
		if(!isOff){
			var promSellPrice = $(this).val();
			var normSellPrice = $(this).parents("tr").find("input.normSellPrice").val();
			var netCost = $(this).parents("tr").find("input[id='netCost']").val();
			var vat = $(this).parents("tr").find("input[id='vat']").val();
			$("input.promSellPriceHead[child=1]").val("");
		    $("#ArtPromoCodeDiv").find("div.item_on").find("input.promSellPriceHead[name=unit]").val("");
			var isPass = true;
			if(promSellPrice =="" || promSellPrice == 0){
				$(this).val("");
				promSellPrice="";
				$(this).removeClass("errorInput").addClass("errorInput");
				isPass = false;
			}
			
			if(!isMoney2(promSellPrice))
	  		{
				top.jAlert('warning', '输入的数据不符合规则，促销售价最多保留两位小数!', '提示消息');
				$(this).val('');
				$(this).removeClass("errorInput").addClass("errorInput");
				isPass = false;
	  	    }else{
	  	    	
	  	    	if(promSellPrice > (normSellPrice*0.95)){
					top.jAlert('warning', '促销售价必须小于等于正常售价*0.95!', '提示消息');
					$(this).removeClass("errorInput").addClass("errorInput");
					$(this).val('');
					isPass = false;
				}
	  	    
	  	    }
	  	    
	  	    var priceCut="";
	  	    var netMaori="";
			if(promSellPrice !=null && promSellPrice !="" && promSellPrice > 0 && isPass){
				priceCut = roundFun ((normSellPrice-promSellPrice)/normSellPrice*100,2);
				netMaori = roundFun((((Number(promSellPrice)/( 1 + Number(vat/100)))-Number(netCost))/( Number(promSellPrice)/( 1 + Number(vat/100))))*100,2);
			}
			$(this).parents("tr").find("input.priceCut").val(priceCut);
			$(this).parents("tr").find("input.netMaori").val(netMaori);
			
			var $tr = $(this).parents("tr");
			var checkTrId = $tr.attr("id");
			var checkTr = $("input:checkbox[deleteid='"+checkTrId+"']");
			var catlgId = checkTr.attr("colagnoval");
			var itemNo = checkTr.attr("itemnoval");
			var unitNo = checkTr.attr("unitnoval");
			var unitType = checkTr.attr("unittypeval");
			var storeNo = checkTr.attr("name");
			
			for (var i = 0; i < ItemsStoreArray.length; i++) {

			 	var itemsStoreJson = ItemsStoreArray[i];
			 	var jsonUnitNo = itemsStoreJson.unitNo;
			 	var jsonUnitType = itemsStoreJson.unitType;
			 	var jsonCatlgId = itemsStoreJson.catlgId;
			 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
			 		var storeArray = itemsStoreJson.storeArray;
			 		for (var j = 0; j < storeArray.length; j++) {
			 			var storeJson = storeArray[j];
			 			var jsonItemNo = storeJson.itemNo;
			 			var jsonStoreNo = storeJson.storeNo;
			 			if(jsonItemNo == itemNo && jsonStoreNo == storeNo){
			 				storeJson.promSellPrice=promSellPrice;
			 				//storeJson.promBuyPrice = normSellPrice;
			 				storeJson.sellVat = vat;
			 				storeJson.priceCut=priceCut;
			 				storeJson.netMaori = netMaori;
			 			}
			 			storeArray[j]=storeJson;
			 		}
			 		ItemsStoreArray[i].storeArray = storeArray;
			  }
		}
	}
	});
	
	//促销进价
	$(".promBuyPriceBody").die("blur").live("blur",function(){
		var isOff=$(this).hasClass("Black")
		if(!isOff){
			var isPass = true;
			var promBuyPrice = $(this).val();
			var buyWhen = $(this).attr("buyWhen");
			var buyPriceLimit = $(this).attr("buyPriceLimit");
			var normBuyPrice = $(this).parents("tr").find("input[name='normBuyPrice']").val();
			var $tr = $(this).parents("tr");
			var checkTrId = $tr.attr("id");
			var checkTr = $("input:checkbox[deleteid='"+checkTrId+"']");
			var catlgId = checkTr.attr("colagnoval");
			var itemNo = checkTr.attr("itemnoval");
			var unitNo = checkTr.attr("unitnoval");
			var unitType = checkTr.attr("unittypeval");
			var storeNo = checkTr.attr("name");
			$("input.promBuyPriceHead[child=1]").val("");
			$("#ArtPromoCodeDiv").find("div.item_on").find("input.promBuyPriceHead[name=unit]").val("");
			if(promBuyPrice =="" || promBuyPrice == 0){
				$(this).val("");
				promBuyPrice=="";
				$(this).removeClass("errorInput").addClass("errorInput");
			}
			if(!isMoney4(promBuyPrice)){
				top.jAlert('warning', '促销进价必须是不能超过四位小数的数字!', '提示消息');
				$(this).val('');
				$(this).removeClass("errorInput").addClass("errorInput");
	  	    }else{
	  	    	if(buyWhen == "2"){
	  	    		if(buyPriceLimit !="null" && (Number(promBuyPrice)>Number(buyPriceLimit))){
	  	    			top.jAlert('warning', '促销进价不能大于买价限制!', '提示消息');
	  	    			$(this).removeClass("errorInput").addClass("errorInput");
						$(this).val('');
	  	    		}
	  	    	}else{
		  	    	if(Number(promBuyPrice) >= Number(normBuyPrice)){
						top.jAlert('warning', '促销进价必须小于正常进价!', '提示消息');
						$(this).removeClass("errorInput").addClass("errorInput");
						$(this).val('');
					}
	  	    	}
	  	    }
			
	  	    for (var i = 0; i < ItemsStoreArray.length; i++) {
				 var itemsStoreJson = ItemsStoreArray[i];
				 var jsonUnitNo = itemsStoreJson.unitNo;
				 var jsonUnitType = itemsStoreJson.unitType;
				 var jsonCatlgId = itemsStoreJson.catlgId;
				 if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
				 	var storeArray = itemsStoreJson.storeArray;
				 	for (var j = 0; j < storeArray.length; j++) {
				 		var storeJson = storeArray[j];
				 		var jsonItemNo = storeJson.itemNo;
				 		var jsonStoreNo = storeJson.storeNo;
				 		if(jsonItemNo == itemNo && jsonStoreNo == storeNo){
				 			storeJson.promBuyPrice = promBuyPrice;
				 		}
				 		storeArray[j]=storeJson;
				 	}
				 	ItemsStoreArray[i].storeArray = storeArray;
				 }
	  	    }
		}
	});
	 
	//促销提示
	/*$(".promActvy").live("change",function(){
		var promActvy = $(this).val();
		var $parentDiv = $(this).parents(".supplerItem");
		var catlgId = $("#CatlgId").val();
		var unitNo = $parentDiv.find("input[id='unitNo']").val();
		var unitType = $parentDiv.find("select[id='unitType']").val();
		//将促销进价和促销手机放入到保存数据中
			 for (var i = 0; i < ItemsStoreArray.length; i++) {
			 	
			 	var itemsStoreJson = ItemsStoreArray[i];
			 	var jsonUnitNo = itemsStoreJson.unitNo;
			 	var jsonUnitType = itemsStoreJson.unitType;
			 	var jsonCatlgId = itemsStoreJson.catlgId;
			 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
			 		itemsStoreJson.promActvy=promActvy;
			 		ItemsStoreArray[i] = itemsStoreJson;
			 	}
			 }
	});*/
	//促销提示备注
	/*$(".pmGiftHint").live("change",function(){
		
		var pmGiftHint = $(this).val();
		var $parentDiv = $(this).parents(".supplerItem");
		var catlgId = $("#CatlgId").val();
		var unitNo = $parentDiv.find("input[id='unitNo']").val();
		var unitType = $parentDiv.find("select[id='unitType']").val();
		//将促销进价和促销手机放入到保存数据中
			 for (var i = 0; i < ItemsStoreArray.length; i++) {

			 	var itemsStoreJson = ItemsStoreArray[i];
			 	var jsonUnitNo = itemsStoreJson.unitNo;
			 	var jsonUnitType = itemsStoreJson.unitType;
			 	var jsonCatlgId = itemsStoreJson.catlgId;
			 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
			 		itemsStoreJson.pmGiftHint=pmGiftHint;
			 		ItemsStoreArray[i] = itemsStoreJson;
			 	}
			 }
		
	});*/
	//代号备注
	/*$(".memo").live("change",function(){
		
		var memo = $(this).val();
		var $parentDiv = $(this).parents(".supplerItem");
		var catlgId = $("#CatlgId").val();
		var unitNo = $parentDiv.find("input[id='unitNo']").val();
		var unitType = $parentDiv.find("select[id='unitType']").val();
		//将促销进价和促销手机放入到保存数据中
		 for (var i = 0; i < ItemsStoreArray.length; i++) {
		 	var itemsStoreJson = ItemsStoreArray[i];
		 	var jsonUnitNo = itemsStoreJson.unitNo;
		 	var jsonUnitType = itemsStoreJson.unitType;
		 	var jsonCatlgId = itemsStoreJson.catlgId;
		 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
		 		itemsStoreJson.memo=memo;
		 		ItemsStoreArray[i] = itemsStoreJson;
		 	}
		 }
	});*/
	
	 //保存信息的方法
    $("#Tools2").live("click",function(){
    	savePromARTDate();
    	/*top.grid_layer_open();
    	var subjName=$("#subjName").val();
		var promBeginDate=$("#promTimeStart").val();
		var promEndDate=$("#promTimeEnd").val();
		var buyBeginDate=$("#buyTimeStart").val();
	    var buyEndDate=$("#buyTimeEnd").val();
	    var catlgId=$("#CatlgId").val();
	    var pricePromType=$("#promType").val();
	    var error = 0;
	    if($.trim(subjName)==''){
			$("#subjName").removeClass('errorInput').addClass('errorInput');
			$("#subjName").attr("title",'请输入主题!');
		    error++;
		 }else if (charLen($.trim(subjName))>30){
		 	$("#subjName").addClass('errorInput');
		 	$("#subjName").attr("title",'主题不能超过30个字节!');
		 	error++;
		 }
	    
     	if(!checkTime()){
    		error++;
	    }
	    
	    if(ItemsStoreArray.length < 1){
	 		top.jAlert('warning', '请选择代号信息！', '提示消息');
	 		error++;
	 	}
	 	
	 	if(!checkItemStoreDate()){
	 		error++;
	 	}
	 	
	    if(error>0)
		{
			top.grid_layer_close();
			return;
		}else{
			
	    	var comma = "--";
	    	var bracket_left = "{";
	    	var bracket_right = "}";
	
	    	var promSchedule= bracket_left+'"catlgId":\"' + catlgId + '\",'+'"buyBeginDate":\"'+buyBeginDate+'\",'+'"buyEndDate":\"'+buyEndDate+'\",'+
				 '"promBeginDate":\"'+promBeginDate+'\",'+ '"promEndDate":\"'+promEndDate+'\",'+'"pricePromType":\"'+pricePromType+'\"'+bracket_right;
	    	var subject=bracket_left+'"subjName":"' + subjName + '"'+bracket_right;
	    	var promUnitSt=[];
		    var promItem=[];
	    	for (var i = 0; i < ItemsStoreArray.length; i++) {
	    		var json=ItemsStoreArray[i];
	    		//promUnitSt.push(bracket_left+'"unitType":"' + json.unitType + '",'+'"promUnitNo":"' + json.unitNo + '",'+'"catlgId":"' + catlgId + '",'+'"promActvy":"'+json.promActvy+'",'+'"promGiftHint":"'+json.pmGiftHint+'",'+'"memo":"'+json.memo+'"'+bracket_right);
	    		promUnitSt.push(bracket_left+'"unitType":"' + json.unitType + '",'+'"promUnitNo":"' + json.unitNo + '",'+'"catlgId":"' + catlgId + '"'+bracket_right);
	    		for (var j = 0; j < json.storeArray.length; j++) {
	    			  var itemJson=json.storeArray[j];
	    			   if(itemJson.promBuyPrice=='')
		    			  {
		    			   itemJson.promBuyPrice='0';
		    			  }
		    		   if(itemJson.promSellPrice=='')
		    			  {
		    			   itemJson.promSellPrice='0';
		    			  }
		    		 var itemStr=bracket_left+'"promSupNo":"' + itemJson.promSupNo + '",'+'"storeNo":"' + itemJson.storeNo + '",'+'"itemNo":"' + itemJson.itemNo + '",'+'"unitType":"' + itemJson.unitType + '",'+'"promUnitNo":"' + itemJson.unitNo + '",'+
					   '"normBuyPrice":"' + itemJson.normBuyPrice + '",'+'"normSellPrice":"' + itemJson.normSellPrice + '",'+'"promBuyPrice":"' + itemJson.promBuyPrice + '",'+'"promSellPrice":"' + itemJson.promSellPrice + '"'+bracket_right;
					   promItem.push(itemStr);
		    			  
		    			  
	    		}
	    	}
	    	top.grid_layer_close();
	    	$.ajax({
	    		 async : false,
				 url: ctx + '/prom/nondm/art/saveARTInfo?ti='+(new Date()).getTime(),
			     type: "post",
			     data : {'promSchedule':promSchedule,'subject':subject,'promUnitSt':promUnitSt.join(comma),'promItem':promItem.join(comma)},
			     success: function(result) {
			     	grid_layer_close();
			     	if(result.error != null && result.error=="1"){
			     			 top.jAlert('warning', result.message, '提示消息');
			     	}else{
				        top.jAlert('success', result.message, '提示消息',function(){
								window.location.href=ctx + '/prom/nondm/art/createARTPromo';        	
				        });
			     	}
			     }
	    	});
    	
    	}*/
    });
    
  
	
	//---------------------------------验证以及一些公用的js------------------------------------------------
   
    
    //验证主题，可别信息
	function checkSubjName(){
		var subjName = $("#subjName").val();
	 	$("#subjName").removeClass('errorInput');
	    $("#subjName").attr("title",'');
	 	if($.trim(subjName)==''){
	 		$("#subjName").addClass('errorInput');
	        $("#subjName").attr("title",'请输入主题!');
	 	}else if(charLen($.trim(subjName))>30){
	 		$("#subjName").addClass('errorInput');
	 		$("#subjName").attr("title",'主题不能超过30个字节!');
 		}
	 }
    
	 //刷新状态
	 function refreshArray(buyts,buyte,promts,promte){
	 	top.jConfirm("所有代号要进行重新验证，可能需要等待较长时间，确定要修改时间吗？", '提示消息',function(ret){	
	 		if(ret){
		 		var refreshItemStoreArray = new Array();
		 		var promPriceType = $("#promType").val();
		 		var refreshUnitNo = $("#ArtPromoCodeDiv").find(".item_on").find("input[id='unitNo']").val();
		 		var refreshCatlgId = $("#CatlgId").val();
		 		var refreshItemNoArray =new Array();
		 		var refrashStoreNoArray = new Array();
			 	//移除之前的老数据
				 for (var i = 0; i < ItemsStoreArray.length; i++) {
				 	var itemsStoreJson = ItemsStoreArray[i];
				 	 storeArray = itemsStoreJson.storeArray;
				 	for (var j = 0; j < storeArray.length; j++) {
				 		var storeJson = storeArray[j];
				 		var itemNo = storeJson.itemNo;
				 		var storeNo = storeJson.storeNo;
				 		var unitNo = storeJson.unitNo;
				 		refreshItemStoreArray[refreshItemStoreArray.length] = unitNo+"@"+itemNo+"-"+storeNo;
				    }
				 }
			 	$.ajax({
				    async:false,
			    	url: ctx + '/prom/nondm/art/refreshArray?refreshArray='+refreshItemStoreArray+'&buyStartDate='+buyts+'&buyEndDate='+buyte+'&promStartDate='+promts+'&promEndDate='+promte+'&ti='+(new Date()).getTime(),
					type: "post",
					dataType:"json",
					success: function(result) {
						if(result.itemStoreList != null && result.itemStoreList.length>0){
							 $(".pro_store_items").html("");
							 $("#shopBodyTable").html("");
		 		 		     $("#shopHeadTable").html("");
		 		 		     var isred = 0;
						     for (var w = 0; w < ItemsStoreArray.length; w++) {
							 	var itemsStoreJson = ItemsStoreArray[w];
							 	var jsonUnitNo = itemsStoreJson.unitNo;
							 	var jsonUnitType = itemsStoreJson.unitType;
							 	var itemstoreArrays = new Array();
							 	
							 	for (var g = 0; g < result.itemStoreList.length; g++) {
							 		var itemStore = result.itemStoreList[g];
							 		var unitNo = itemStore.promUnitNo;
							 		if(jsonUnitNo == unitNo){
							 			var storeJson = {"promSupNo":itemStore.stMainSupNo,"mainComName":itemStore.mainComName,"status":itemStore.status,"basicStatus":itemStore.basicStatus,"statusName":itemStore.itemStatusName,"storeNo":itemStore.storeNo,"storeName":itemStore.storeName,"itemNo":itemStore.itemNo,"unitType":jsonUnitType,"unitNo":unitNo,"normBuyPrice":itemStore.normBuyPrice,"normSellPrice":itemStore.normSellPrice,"promBuyPrice":"","promSellPrice":"","netCost":itemStore.netCost,"sellVat":itemStore.vatVal,"itemName":itemStore.itemName,"priceCut":"","netMaori":"","buyPriceLimit":itemStore.buyPriceLimit,"buyWhen":itemStore.buyWhen,"appendBuy":itemStore.appendBuy,"appendProm":itemStore.appendProm,"existPromNo":itemStore.promNo};
							 			itemstoreArrays[itemstoreArrays.length] = storeJson;
							 		}
							 		if(refreshUnitNo == unitNo){
							 			if(itemStore.promNo){
							 				isred = 1;
							 			}
							 			var refrashStoreJson = {"promSupNo":itemStore.stMainSupNo,"mainComName":itemStore.mainComName,"status":itemStore.status,"basicStatus":itemStore.basicStatus,"statusName":itemStore.itemStatusName,"storeNo":itemStore.storeNo,"storeName":itemStore.storeName,"itemNo":itemStore.itemNo,"unitType":jsonUnitType,"unitNo":unitNo,"normBuyPrice":itemStore.normBuyPrice,"normSellPrice":itemStore.normSellPrice,"promBuyPrice":"","promSellPrice":"","netCost":itemStore.netCost,"sellVat":itemStore.vatVal,"itemName":itemStore.itemName,"priceCut":"","netMaori":"","buyPriceLimit":itemStore.buyPriceLimit,"buyWhen":itemStore.buyWhen,"appendBuy":itemStore.appendBuy,"appendProm":itemStore.appendProm,"existPromNo":itemStore.promNo};
							 			if(unitNo==refreshUnitNo){
								 			refreshItemNoArray[refreshItemNoArray.length] = itemStore.itemNo+"@"+itemStore.itemName+"@"+jsonUnitType;
								 			refrashStoreNoArray[refrashStoreNoArray.length] = refrashStoreJson;
							 			}
							 		}
							 	}
							 	
							 	if(itemstoreArrays.length > 0){
							 		ItemsStoreArray[w].storeArray=itemstoreArrays;	
							 	}
			        		}
			        		
			        		var refreshItemNos = refreshItemNoArray.unique();
			        		var firstItemNo ;
			        		for (var f = 0; f < refreshItemNos.length; f++) {
			        			var refreshItemNoStr = refreshItemNos[f].split("@");
			        			var reItemNo = refreshItemNoStr[0];
			        			var reItemName = refreshItemNoStr[1];
			        			var reUnitType = refreshItemNoStr[2];
			        			var bgColor ="";
		 		 				if(isred !=""){
		 		 				 	bgColor="bgColorRed";
		 		 				}
		 		 				if(f==0){
		 		 					firstItemNo = reItemNo;
		 		 					$(".pro_store_items").append("<div class='item addItems item_on "+bgColor+"' itemNoValue='"+reItemNo+"' unitNoValue='"+refreshUnitNo+"' catlgIdValue='"+refreshCatlgId+"' unitType='"+reUnitType+"'><span class='pstb_1'>"+reItemNo+"-"+reItemName+"</span></div>");
		 		 				}else{
		 		 					$(".pro_store_items").append("<div class='item addItems "+bgColor+"' itemNoValue='"+reItemNo+"' unitNoValue='"+refreshUnitNo+"' catlgIdValue='"+refreshCatlgId+"' unitType='"+reUnitType+"'><span class='pstb_1'>"+reItemNo+"-"+reItemName+"</span></div>");
		 		 				}
		 		 				for (var h = 0; h < refrashStoreNoArray.length; h++) {
		 		 					var store = refrashStoreNoArray[h];
					    			//显示门店信息
				        			if(firstItemNo == store.itemNo){
				        				var num = parseInt(Math.random()*100000);
				        				appendShopBodyTable(store,num,reUnitType,refreshUnitNo,refreshCatlgId);
					        			appendShopHeadTable(store,num,reUnitType,refreshUnitNo,refreshCatlgId);
				        			}
		 		 				}
			        		}
			        		
			        		changeInputByPromPriceType(promPriceType);
			        		//将促销进价恢复到原始状态
			        		if(promPriceType==1 || promPriceType==2){
			        			$(".promBuyPriceBody").each(function(){
			        				$(this).val("");
			        			});
			        		}
			        		//将促销售价恢复到原始状态
			        		if(promPriceType==1 || promPriceType==3){
			        			$(".promSellPriceBody").each(function (i){
			        				$(this).val("");
			        			});
			        		}
			        		
			        		//将警示颜色去掉
			        		/*$("tr.trBgRed").removeClass("trBgRed");
			        		$("div.bgColorRed").removeClass("bgColorRed");*/
			        		$("input.promBuyPriceHead").val("");
							$("input.promSellPriceHead").val("");
						}
		        		
					}
			    });
			    
	 		}else{
		    	$("#buyTimeStart").val($("#oBuyBeginDate").val());
		    	$("#buyTimeEnd").val($("#oBuyEndDate").val());
		    	$("#promTimeStart").val($("#oSellBeginDate").val());
		    	$("#promTimeEnd").val($("#oSellEndDate").val());
	 		}
	 	});
	 	
	 }
	 
    //促销类型的显示规则
	function getPromoType(){//buyTimeStart//promTimeStart//promSellPriceBody,promBuyPriceBody
		var isUnitListIsEmpty =checkUnitListIsEmpty()
    	var obbd = $("#oBuyBeginDate").val();
    	var obed = $("#oBuyEndDate").val();
    	var osbd = $("#oSellBeginDate").val();
    	var osed = $("#oSellEndDate").val();
    	var timeType = $(this).attr("ttype");
		var buyts = $("#buyTimeStart").val();
		var buyte = $("#buyTimeEnd").val();
		var promts= $("#promTimeStart").val();
		var promte= $("#promTimeEnd").val();
		var promType = $("#promType").val();
    	if(obbd =="" || isUnitListIsEmpty){
    		$("#oBuyBeginDate").val(buyts);
    	}
    	if(obed=="" || isUnitListIsEmpty){
    		$("#oBuyEndDate").val(buyte);
    	}
    	if(osbd=="" || isUnitListIsEmpty){
    		$("#oSellBeginDate").val(promts);
    	}
    	if(osed=="" || isUnitListIsEmpty){
    		$("#oSellEndDate").val(promte);
    	}
		var obj=this;
		if(timeType =='buy'&&(promts =="" && promte=="")){
	 		$("#promTypeValue").val("2-仅进价促销");
			$("#promType").val("2");
			 $(".promBuyPriceBody,.promBuyPriceHead").each(function(){
				$(this).removeClass("Black");
				$(this).attr("readonly",false);
				
			});
			$(".promSellPriceBody,.promSellPriceHead").each(function(){
				$(this).removeClass("Black").addClass("Black");
				$(this).attr("readonly",true);
				
			});  
			checkTime();
			
			if(buyts != "" && buyte !="" && !checkUnitListIsEmpty()){
				refreshArray(buyts,buyte,promts,promte);
			}
		}
		if((timeType =='buy' && (promts!="" || promte!="")) || (timeType =='prom' && (buyts!="" || buyte!=""))){
			if(checkUnitListIsEmpty()){
				$("#promTypeValue").val("1-进-售价促销");
			    $("#promType").val("1");
				$(".promSellPriceBody,.promBuyPriceBody,.promSellPriceHead,.promBuyPriceHead").each(function(){
					$(this).removeClass("Black");
					$(this).attr("readonly",false);
				});
				checkTime();
			}else{
				if(promType !="" && promType !="1"){
					top.jConfirm("促销类型已改变，商品信息将被清空！", '提示消息',function(ret){
					 	if(ret){
						    $("#promTypeValue").val("1-进-售价促销");
						    $("#promType").val("1");
							$(".promSellPriceBody,.promBuyPriceBody,.promSellPriceHead,.promBuyPriceHead").each(function(){
								$(this).removeClass("Black");
								$(this).attr("readonly",false);
							});
					 		
					 		$("#ArtPromoCodeDiv").html("")
					 		$("#shopBodyTable").html("");
						 	$("#shopHeadTable").html("");
						 	$(".pro_store_items").html("");
						 	$("input.promBuyPriceHead[child=1]").val("");
						 	$("input.promSellPriceHead[child=1]").val("");
						 	ItemsStoreArray=[];
						 	checkTime();
					 	}else{
					 		obj.value="";
					 	}
							    	
					});
			   }else{
			   		checkTime();
			   		if(buyts!="" && buyte!="" && promte !="" && promts !="" && !checkUnitListIsEmpty()){
			   			refreshArray(buyts,buyte,promts,promte);
			   		}
			   }
			}
		}
		if(timeType =='prom' && (buyts=="" && buyte=="")){
			$("#promTypeValue").val("3-仅售价促销");
			$("#promType").val("3");
			$(".promSellPriceBody,.promSellPriceHead").each(function(){
				$(this).removeClass("Black");
				$(this).attr("readonly",false);
			});
			$(".promBuyPriceBody,.promBuyPriceHead").each(function(){
				$(this).removeClass("Black").addClass("Black");
				$(this).attr("readonly",true);
				
			});
			checkTime();
			if(promts !="" && promte !="" && !checkUnitListIsEmpty()){
				refreshArray(buyts,buyte,promts,promte);
			}
		}
		
		
    	
		
	}
    
    
	function checkTime(isNeedAjax){
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
		 var flag=true;
		 if(isNeedAjax ==null || isNeedAjax == ""){
	    	  $.ajax({
	    		    async:false,
			    	url: ctx + '/prom/nondm/art/checkTime?buyDateStart='+buyBeginDate+'&buyDateEnd='+buyEndDate+'&promDateStart='+promBeginDate+'&promDateEnd='+promEndDate+'&ti='+(new Date()).getTime(),
					type: "post",
					dataType:"json",
					success: function(result) {
					    if(result.message!=null && result.message !="success"){
					    	if(result.key=='1'){
					    		$("#buyTimeStart").addClass("errorInput");
								$("#buyTimeStart").attr("title",result.message);
					    	}
					    	if(result.key=='2'){
					    		$("#buyTimeEnd").addClass("errorInput");
								$("#buyTimeEnd").attr("title",result.message);
					    	}
					    	if(result.key=='3'){
					    		$("#promTimeStart").addClass("errorInput");
								$("#promTimeStart").attr("title",result.message);
					    	}if(result.key=='4'){
					    		$("#promTimeEnd").addClass("errorInput");
								$("#promTimeEnd").attr("title",result.message);
					    	}
					    	
					    	flag=false;
					    }   	
					}
			    });
		   }
    	  return flag;
  	}
	
	
	
	
	function checkHasOne(unitType,unitNo,catlgId){
		var flag = true;
		
    	if(ItemsStoreArray.length > 0){
	    	for (var i = 0; i < ItemsStoreArray.length; i++) {
	    		var json = ItemsStoreArray[i];
	    		var jUnitType=json.unitType;
	    		var jUnitNo = json.unitNo;
	    		var jCatlgId = json.catlgId;
	    		if(unitType==jUnitType && unitNo == jUnitNo && catlgId == jCatlgId){
	    			flag = false;
	    		}
	    	}
    	}
    	
    	return flag;
    }
	
	
	function   roundFun(numberRound,roundDigit)  {    //四舍五入，保留位数为roundDigit
		if   (numberRound>=0){
			var   tempNumber   =   parseInt((numberRound   *   Math.pow(10,roundDigit)+0.5))/Math.pow(10,roundDigit);
			return   tempNumber;
		} else{
			numberRound1=-numberRound;
			var   tempNumber   =   parseInt((numberRound1   *   Math.pow(10,roundDigit)+0.5))/Math.pow(10,roundDigit);
			return   -tempNumber;
		}
	}
	
	function checkHaveOtherStoreProm(itemNo,storeNo){
		$("#pro_item_store_info").find("div.bgColorRed").removeClass("bgColorRed");
		$("#pro_item_store_info").find("div[itemnovalue="+itemNo+"]").addClass("bgColorRed");
		
		var changeTrDeleteId = $("#shopHeadTable").find("input[name="+storeNo+"]").attr("deleteid");
		$("#shopHeadTable").find("tr.trBgRed").removeClass("trBgRed");
		$("#shopBodyTable").find("tr.trBgRed").removeClass("trBgRed");
		$("#shopHeadTable").find("input[name="+storeNo+"]").parents("tr").addClass("trBgRed");
		$("#"+changeTrDeleteId).addClass("trBgRed");
		//$("#shopHeadTable").find("input[name="+storeNo+"]").removeClass("trBgRed");
	}
	 //判断用户是否选择了代号并初始化了数据
	 function checkItemStoreDate(){
	 	var message="";
	 	var promType =$("#promType").val();
	 	if(ItemsStoreArray.length > 0){
	 		 for (var i = 0; i < ItemsStoreArray.length; i++) {
			 	 var  itemsStoreJson = ItemsStoreArray[i];
			 	 var jsonUnitNo = itemsStoreJson.unitNo;
			 	 storeArray = itemsStoreJson.storeArray;
		 		for (var j = 0; j < storeArray.length; j++) {
		 			var storeJson = storeArray[j];
		 			var status = storeJson.status;
		 			var basicStatus = storeJson.basicStatus;
		 			var appendProm = storeJson.appendProm;
		 			var appendBuy = storeJson.appendBuy;
		 			var itemNo = storeJson.itemNo;
		 			var itemName = storeJson.itemName;
		 			var promNo = storeJson.existPromNo;
		 			var storeNo = storeJson.storeNo;
		 			var storeName = storeJson.storeName;
		 			var isBlack = true;
		 			if(promType == 1 || promType==2){//店号为"+promStoreItemVO.getStoreNo()+"的门店
		 				// 判断当前代号的商品是否在其他的促销期数中
		 				if(appendBuy == 1){
		 					//message = "代号"+jsonUnitNo+",商品货号"+itemNo+"-"+itemName+"商品，店号为"+storeNo+"-"+storeName+"的门店，已经参加了期数为"+promNo+"的促销活动，请核实信息！";
		 					//top.jAlert('warning', message, '提示消息');
		 					//checkHaveOtherStoreProm(itemNo,storeNo);
		 					top.jAlert('warning', "请确认门店信息无误，再进行下一步操作！", '提示消息');
		 					return false;
		 				}
		 				
		 				//判断商品的价格是否为空
		 				if(promType==1){
		 					if(5<Number(basicStatus) && Number(basicStatus)<9){
		 						isBlack = false;
		 					}
		 				}
		 				
		 				if(isBlack){
				 			if(storeJson.promBuyPrice==null || storeJson.promBuyPrice ==""){
				 				message = "代号"+jsonUnitNo+",商品货号"+itemNo+"，促销进价不能为空";
				 				top.jAlert('warning', message+"!", '提示消息');
				 				$(".promBuyPriceBody").each(function(){
						 			if($(this).val()=="" && !$(this).hasClass("Black")){
						 				$(this).removeClass("errorInput").addClass("errorInput");
						 			}
						 		});
				 				return false;
				 			}
		 				}
		 			}
		 			
		 			if(promType==1 || promType==3){
		 				if(appendProm == 1 || appendProm == 2){
		 					/*message = "代号"+jsonUnitNo+",商品货号"+itemNo+"-"+itemName+"商品，店号为"+storeNo+"-"+storeName+"的门店，已经参加了期数为"+promNo+"的促销活动，请核实信息！";
		 					top.jAlert('warning', message, '提示消息');
		 					checkHaveOtherStoreProm(itemNo,storeNo);*/
		 					top.jAlert('warning', "请确认门店信息无误，再进行下一步操作！", '提示消息');
		 					return false;
		 				}
			 			if(storeJson.promSellPrice==null || storeJson.promSellPrice ==""){
			 				message ="代号"+jsonUnitNo+",商品货号"+itemNo+"，促销售价不能为空";
			 				top.jAlert('warning', message+"!", '提示消息');
			 				$(".promSellPriceBody").each(function(){
					 			if($(this).val()==""){
					 				$(this).removeClass("errorInput").addClass("errorInput");
					 			}
					 		});
			 				return false;
			 			}
		 			}
		 			
           		 }
			 }
			return true;
	 	}
	 }
	 //判断是不是金钱
	function isMoney4(param){
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
	function isMoney2(param){
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
	function isNumber(param){  
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
	
	//判断代号是不是都为空
	function checkUnitListIsEmpty(){
		var falg = true;
		$("input[name=unitNo]").each(function(){
			if($(this).val() !=""){
				falg = false;
				return;
			}
		});
		return falg;
	}
	
	//促销类型的显示规则
	function changeInputByPromPriceType(ptype){//buyTimeStart//promTimeStart
			if(ptype == 2){
				 $(".promBuyPriceBody,.promBuyPriceHead").each(function(){
					$(this).removeClass("Black");
					$(this).attr("readonly",false);
				
				});
				$(".promSellPriceBody,.promSellPriceHead").each(function(){
					$(this).removeClass("Black").addClass("Black");
					$(this).attr("readonly",true);
					$(this).val("");
				});
			}
			if(ptype ==1){
			    $(".promSellPriceBody,.promBuyPriceBody,.promSellPriceHead,.promBuyPriceHead").each(function(){
			    	var status = $(this).parents("tr").find("input.status").attr("name");
			    	var thisClass = $(this).hasClass("promBuyPriceBody");
			    	if(thisClass){
			    		if(5<Number(status) && Number(status)<9){
			    			$(this).removeClass("Black").addClass("Black");
			    			$(this).attr("readonly",true);
			    			$(this).val("");
			    		}
			    	}else{
						$(this).removeClass("Black");
						$(this).attr("readonly",false);
			    	}
				});
			}
			if(ptype == 3){
				$(".promSellPriceBody,.promSellPriceHead").each(function(){
					$(this).removeClass("Black");
					$(this).attr("readonly",false);
				});
				$(".promBuyPriceBody,.promBuyPriceHead").each(function(){
					$(this).removeClass("Black").addClass("Black");
					$(this).attr("readonly",true);
					$(this).val("");
					
				});
			}
	}
	
	
	
	//判断用户是否选择了代号并初始化了数据
  	//当unitno不为空的时候，检查的是当前unitno下的数据有没有未填写的项目
  	//当unitno为空的时候，检查的是整个json中的数据有没有未填写的项目
	 function checkItemStoreDateBy(){
	 	var flag = true;
	 	var itemUnit = $("#ArtPromoCodeDiv").find(".item_on");
		if(itemUnit !=null){
			var unitType = itemUnit.find("select[id=unitType]").val();
			var unitNo = itemUnit.find("input[id=unitNo]").val();
			if(unitType != null && unitType !="" && unitNo !=null && unitNo !=""){
				var promType =$("#promType").val();
			 	var sell = 0;
			 	var buy = 0;
			 	var itemsStoreJson ;
			 	var jsonUnitNo;
			 	 var message = "";
			 	if(ItemsStoreArray.length > 0){
			 		 for (var i = 0; i < ItemsStoreArray.length; i++) {
					 	 itemsStoreJson = ItemsStoreArray[i];
					 	 jsonUnitNo = itemsStoreJson.unitNo;
					 	 storeArray = itemsStoreJson.storeArray;
					 	 jsonUnitType = itemsStoreJson.unitType;
					 	 if(unitNo !=null && unitType !=null){
					 	 	if(jsonUnitNo == unitNo && jsonUnitType == unitType){
					 	 		for (var j = 0; j < storeArray.length; j++) {
						 			var storeJson = storeArray[j];
						 			var status = storeJson.status;
						 			var basicStatus = storeJson.basicStatus;
						 			var isBlack = true;
						 			if(promType == 1 || promType==2){
						 				if(promType ==1){
						 					if(5<Number(basicStatus) && Number(basicStatus)<9){
						 						isBlack = false;
						 					}
						 				}
						 				if(isBlack){
								 			if(storeJson.promBuyPrice==null || storeJson.promBuyPrice ==""){
								 				buy =1;
								 				flag = false;
								 			}
						 				}
						 			}
						 			if(promType==1 || promType==3){
							 			if(storeJson.promSellPrice==null || storeJson.promSellPrice ==""){
							 				sell= 1;
							 				flag = false;
							 			}
						 			}
					 			}
					 	 	}
					 	}
					 }
					 if(!flag){
					 	message +="代号"+unitNo;
					 	if(buy==1){
					 		$(".promBuyPriceBody").each(function(){
					 			if($(this).val()=="" && !$(this).hasClass("Black")){
					 				$(this).removeClass("errorInput").addClass("errorInput");
					 			}
					 		});
					 		message +="，促销进价不能为空";
					 	}
					 	if(sell==1){
					 		$(".promSellPriceBody").each(function(){
					 			if($(this).val()==""){
					 				$(this).removeClass("errorInput").addClass("errorInput");
					 			}
					 		});
					 		message +="，促销售价不能为空";
					 	}
					 	top.jAlert('warning', message, '提示消息');
					 }
					
			 	}
			
			}
		}
	 	return flag;
	 }
	 
	 //过滤判断是否已经有该门店和商品了
	 function filterCheckItemNo(/*Array*/pStoreItemArrayIn, /*int*/unitType){

	 	var relist = new Array();
	 	if(ItemsStoreArray.length > 0){
	 		 for (var i = 0; i < ItemsStoreArray.length; i++) {
			 	 var itemsStoreJson = ItemsStoreArray[i];
			 	  var storeArray = itemsStoreJson.storeArray;
	 	 		 for (var j = 0; j < storeArray.length; j++) {
		 			var storeJson = storeArray[j];
		 			var itemNoJson = storeJson.itemNo;
		 			var unitNoJson = storeJson.unitNo;
		 			
		 			if(unitType =="0"){
		 				if(pStoreItemArrayIn == itemNoJson){
		 					top.jAlert('warning', "该商品已经在代号为"+unitNoJson+"中存在！", '提示消息');
		 					return null;
		 				}else{
		 					relist.push(pStoreItemArrayIn);
		 				}
		 			}else{
		 				/*for (var w = 0; w < list.length; w++) {
			 				var obj = list[w];
			 				var itemNo = obj.itemNo;
			 				if(itemNo == itemNoJson){
			 					list.splice(w,1);
				 				w=-1;
			 				}
		 				}*/
		 				if(pStoreItemArrayIn.length == 1){
		 					return pStoreItemArrayIn;
		 				}else{
			 				for (var w = 0; w < pStoreItemArrayIn.length; w++) {
				 				var obj = pStoreItemArrayIn[w];
				 				var objitemNo = obj.itemNo;
				 				var objunitNo = obj.promUnitNo;
				 				var objunitType = obj.unitType;
				 				if(objitemNo != itemNoJson && unitNoJson == objunitNo && unitType ==objunitType ){
				 					relist.push(obj);
					 				//relist[relist.length] = obj;
				 				}
			 				}
			 				
		 				}
		 			}
	 			}
			 }
	 	}else{
	 		return pStoreItemArrayIn
	 	}
	 	
		if(relist==null || relist.length<1){
			return pStoreItemArrayIn;
		}else{
			return relist;
		}
	 	
	 }
	 
	 function clearMainHtml(flag){
		$(".item_on").find("input[name='promUnitName']").val("");
		$(".item_on").find("input[name='oUnitNo']").val("");
		$(".item_on").find("input[name='unitNo']").val("");
		$("#shopBodyTable").html("");
 		$("#shopHeadTable").html("");
 		$(".pro_store_items").html("");
		//$(".item_on").find("select[name='promActvy']").val("0");
		$(".item_on").find("input.promBuyPriceHead").val("");
		$(".item_on").find("input.promSellPriceHead").val("");
		//$(".item_on").find("input.pmGiftHint").val("");
		//$(".item_on").find("input.memo").val("");
	 }
	 
	 
	 function charLen(s)
    {
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
     }
	 
     function removeDateJson(unitNo,unitType,catlgId){
     	//移除之前的老数据
		 for (var w = 0; w < ItemsStoreArray.length; w++) {
		 	var itemsStoreJson = ItemsStoreArray[w];
		 	var jsonUnitNo = itemsStoreJson.unitNo;
		 	var jsonUnitType = itemsStoreJson.unitType;
		 	var jsonCatlgId = itemsStoreJson.catlgId;
		 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
		 		ItemsStoreArray = ItemsStoreArray.del(w);
		 		w=-1;
		 	}
		 	
		 }
     }
     
     function checkhasStore(){
     	var hashtml = true;
     	var sotreHmtl = $("#shopHeadTable").html();
     	if(sotreHmtl ==null){
     		hashtml = false;
     	}
     	return hashtml;
     }
     
     
 function saveSallPromValue(promSellValue,status){//promSellValue输入的促销售价，stauts 表示是代号框输入的还是门店框输入的，1为门店的文本框
     	var flag = true;
     	var isPass = true;
     	var isRight = true;
     	var isChild = false;
     	var itemOnObj = $(".pro_store_items").find("div.item_on");
     	var unitType = itemOnObj.attr("unittype");
     	var unitNo = itemOnObj.attr("unitnovalue");
     	var catlgId = itemOnObj.attr("catlgidvalue");
     	var itemNo = itemOnObj.attr("itemnovalue");
 		//将促销进价和促销手机放入到保存数据中
		 for (var i = 0; i < ItemsStoreArray.length; i++) {
		 	var itemsStoreJson = ItemsStoreArray[i];
		 	var jsonUnitNo = itemsStoreJson.unitNo;
		 	var jsonUnitType = itemsStoreJson.unitType;
		 	var jsonCatlgId = itemsStoreJson.catlgId;
		 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
		 		var storeArray = itemsStoreJson.storeArray;
		 		for (var j = 0; j < storeArray.length; j++) {
		 			var storeJson = storeArray[j];
		 			var jsonItemNo = storeJson.itemNo;
		 			var vat = storeJson.sellVat;
		 			var normSellPrice =  storeJson.normSellPrice;
		 			var promsellPrice = storeJson.promSellPrice;
		 			var netCost = storeJson.netCost;
		 			var promSellPriceHeadVal1 =0;
		 			if(status ==1){
		 				if(jsonItemNo ==itemNo){
		 					isChild = true;
		 				}else{
		 					isChild = false;
		 				}
		 			}else{
		 				isChild = true;
		 			}
		 			if(isChild){
			 			if(promSellValue > (normSellPrice*0.95)){
			 				isRight= false;
					    	if(promsellPrice !=null && promsellPrice !=""){
								promSellPriceHeadVal1 = promsellPrice;
								 if(promSellPriceHeadVal1 > (normSellPrice*0.95)){
								 	isPass = false;
								 	promSellPriceHeadVal1 = "";
								 }else{
									promSellPriceHeadVal1 = promsellPrice;
								 }
							}else{
								isPass = false;
								promSellPriceHeadVal1 = "";
							}
					    }else{
					    	promSellPriceHeadVal1 = promSellValue;
					    }
			 			var priceCut ="";
			 			var netMaori ="";
			 			if(promSellPriceHeadVal1 !=null && promSellPriceHeadVal1 !=""){
							priceCut = roundFun ((normSellPrice-promSellPriceHeadVal1)/normSellPrice*100,3);
							netMaori = roundFun((((Number(promSellPriceHeadVal1)/( 1 + Number(vat/100)))-Number(netCost))/( Number(promSellPriceHeadVal1)/( 1 + Number(vat/100))))*100,3);
						}
						storeJson.promSellPrice=promSellPriceHeadVal1;
				 		storeJson.sellVat = vat;
				 		storeJson.priceCut=priceCut;
				 		storeJson.netMaori = netMaori;
			 			storeArray[j]=storeJson;
		 			}
		 		}
		 		ItemsStoreArray[i].storeArray = storeArray;
		 	}
		 }
 	if(!isPass || !isRight){
 		flag = false;
 	}
 	return flag ;
 }
 
  function saveBuyPromValue(promBuyValue,status){//promBuyValue输入的促销售价，stauts 表示是代号框输入的还是门店框输入的，1为门店的文本框
  		var flag = 0;//0代表验证通过
     	var isPass = true;
     	var isPass2 = true;
     	var isRight1 = true;
     	var isRight2 = true;
     	var isChild = false;
     	var itemOnObj = $(".pro_store_items").find("div.item_on");
     	var unitType = itemOnObj.attr("unittype");
     	var unitNo = itemOnObj.attr("unitnovalue");
     	var catlgId = itemOnObj.attr("catlgidvalue");
     	var itemNo = itemOnObj.attr("itemnovalue");
  		//将促销进价和促销手机放入到保存数据中
		 for (var i = 0; i < ItemsStoreArray.length; i++) {
		 	var itemsStoreJson = ItemsStoreArray[i];
		 	var jsonUnitNo = itemsStoreJson.unitNo;
		 	var jsonUnitType = itemsStoreJson.unitType;
		 	var jsonCatlgId = itemsStoreJson.catlgId;
		 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
		 		var storeArray = itemsStoreJson.storeArray;
		 		for (var j = 0; j < storeArray.length; j++) {
		 			var storeJson = storeArray[j];
		 			var jsonItemNo = storeJson.itemNo;
		 			//var vat = storeJson.sellVat;
		 			//storeJson = {"promSupNo":store.stMainSupNo,"mainComName":store.mainComName,"status":store.status,"basicStatus":store.basicStatus,"statusName":store.itemStatusName,"storeNo":store.storeNo,"storeName":store.storeName,"itemNo":store.itemNo,"unitType":unitType,"unitNo":unitNo,"normBuyPrice":store.normBuyPrice,"normSellPrice":store.normSellPrice,"promBuyPrice":"","promSellPrice":"","netCost":store.netCost,"sellVat":store.vatVal,"itemName":store.itemName,"priceCut":"","netMaori":"","buyPriceLimit":store.buyPriceLimit,"buyWhen":store.buyWhen};
		 			var jsonNormBuyPrice =  storeJson.normBuyPrice;
		 			var jsonPrombuyValue = storeJson.promBuyPrice;
		 			var buyWhen = storeJson.buyWhen;
		 			var buyPriceLimit = storeJson.buyPriceLimit;
		 			//var netCost = storeJson.netCost;
		 			//var promSellPriceHeadVal1 =0;
		 			if(status ==1){
		 				if(jsonItemNo ==itemNo){
		 					isChild = true;
		 				}else{
		 					isChild = false;
		 				}
		 			}else{
		 				isChild = true;
		 			}
		 			if(isChild){
			 			if(buyWhen == "2"){
							if(buyPriceLimit !="null" && (Number(promBuyValue)>Number(buyPriceLimit))&& buyPriceLimit !=null){
								isRight1 =false;
		  	    				if(jsonPrombuyValue !=null && jsonPrombuyValue !=""){
									promBuyPriceHeadVal1 = jsonPrombuyValue;
									if(buyPriceLimit !="null" && (Number(promBuyPriceHeadVal1)>Number(buyPriceLimit)) && buyPriceLimit !=null){
										isPass =false;
										promBuyPriceHeadVal1="";
									}
								}else{
									isPass =false;
									promBuyPriceHeadVal1 = "";
								}
			  	    		}else{
			  	    			promBuyPriceHeadVal1 = promBuyValue;
			  	    		}
		  	    		}else{
		  	    			if(Number(promBuyValue) >= Number(jsonNormBuyPrice)){
		  	    				isRight2 =false;
		  	    				if(jsonPrombuyValue !=null && jsonPrombuyValue !=""){
		  	    					promBuyPriceHeadVal1= jsonPrombuyValue;
		  	    					if(Number(promBuyPriceHeadVal1) >= Number(jsonNormBuyPrice)){
										promBuyPriceHeadVal1="";
										isPass2 =false;
									}
		  	    				}else{
		  	    					isPass2=false;
									promBuyPriceHeadVal1 = "";
		  	    				}
		  	    				
		  	    			}else{
			  	    			promBuyPriceHeadVal1 = promBuyValue;
		  	    			}
		  	    		}
		  	    		storeJson.promBuyPrice = promBuyPriceHeadVal1;
			 			storeArray[j]=storeJson;
			 		}
		 		}
		 		ItemsStoreArray[i].storeArray = storeArray;
		 	}
		 }
	  	if(!isPass2 || !isRight2){//2表示大于促销进价
	  		flag = 2;
	  	}else if(!isPass || !isRight1){//1表示大于进价限制
	  		flag = 1;
	  	}
  		return flag;
  }
  
  
  function appendShopBodyTable(storeJson,num,unitType,unitNo,catlgId,flag){
		var shopBodyTable = $("#oneShopBodyTable");
  		var promBuyPrice;
  		var promSellPrice;
  		var status;
  		var promSupNo;
  		var priceCut;
  		var netMaori;
  		if(storeJson.statusName !=undefined){
  			status = storeJson.statusName;
  			promBuyPrice = storeJson.promBuyPrice;
  			promSellPrice =  storeJson.promSellPrice;
  			promSupNo = storeJson.promSupNo;
  			priceCut = storeJson.priceCut;
  			netMaori =storeJson.netMaori;
  		}else{
  			status = storeJson.itemStatusName;
  			promBuyPrice = "";
  			promSellPrice = "";
  			priceCut = "";
  			netMaori ="";
  			promSupNo = storeJson.stMainSupNo;
  		}
  		
  		shopBodyTable.find("input[id='status']").attr("value",storeJson.status+"-"+status);
  		shopBodyTable.find("input[id='promSupNo']").attr("value",promSupNo);
  		shopBodyTable.find("input[id='promSellPriceBody']").attr("value",promSellPrice);
  		shopBodyTable.find("input[id='promBuyPriceBody']").attr("value",promBuyPrice);
  		shopBodyTable.find("tr").attr("id",num);
  		shopBodyTable.find("input[id='status']").addClass("status").attr("name",storeJson.basicStatus);
  		shopBodyTable.find("input[id='normBuyPrice']").attr("value",storeJson.normBuyPrice);
  		shopBodyTable.find("input[id='promBuyPriceBody']").addClass("promBuyPriceBody").attr("buyPriceLimit",storeJson.buyPriceLimit).attr("buyWhen",storeJson.buyWhen);
  		shopBodyTable.find("input[id='normSellPrice']").addClass("normSellPrice").attr("value",storeJson.normSellPrice);
  		shopBodyTable.find("input[id='promSellPriceBody']").addClass("promSellPriceBody");
  		shopBodyTable.find("input[id='priceCut']").addClass("priceCut").attr("value",priceCut);
  		shopBodyTable.find("input[id='netMaori']").addClass("netMaori").attr("value",netMaori);
  		shopBodyTable.find("input[id='netCost']").attr("value",storeJson.netCost);
  		shopBodyTable.find("input[id='vat']").attr("value",storeJson.sellVat);
  		shopBodyTable.find("input[id='mainComName']").attr("value",storeJson.mainComName);
		$("#shopBodyTable").append(shopBodyTable.html());
		 clearShopBodyTalbe();
		
	}
  	function appendShopHeadTable(storeJson,num,unitType,unitNo,catlgId){
  		var shopHeadTable = $("#oneShopHeadTable");
  		shopHeadTable.find("input[id='checkbox']").addClass("isChecksART").attr("deleteId",num).attr("name",storeJson.storeNo).attr("unitTypeVal",unitType).attr("unitNoVal",unitNo).attr("itemNoVal",storeJson.itemNo).attr("colagNoVal",catlgId);
  		shopHeadTable.find("input[id='storeInfo']").attr("value",storeJson.storeNo+"-"+storeJson.storeName);
  		$("#shopHeadTable").append(shopHeadTable.html());
  		if(storeJson.appendBuy==1 || storeJson.appendProm==1 || storeJson.appendProm==2){
  			checkHaveOtherStorePromForAll(storeJson.itemNo,storeJson.storeNo);
  		}
  		
  		clearShopHeadTable();
  	}
  	
  	function checkHaveOtherStorePromForAll(itemNo,storeNo){
  		//$("#pro_item_store_info").find("div[itemnovalue="+itemNo+"]").addClass("bgColorRed");
		var changeTrDeleteId = $("#shopHeadTable").find("input[name="+storeNo+"]").attr("deleteid");
		$("#shopHeadTable").find("input[name="+storeNo+"]").parents("tr").addClass("trBgRed");
		$("#"+changeTrDeleteId).addClass("trBgRed");
		//$("#shopHeadTable").find("input[name="+storeNo+"]").removeClass("trBgRed");
	}

    function clearShopBodyTalbe(){
    	var shopBodyTable = $("#oneShopBodyTable");
    	shopBodyTable.find("tr").attr("id","");
  		shopBodyTable.find("input[id='status']").removeClass("status").attr("name","").attr("value","");
  		shopBodyTable.find("input[id='normBuyPrice']").attr("value","");
  		shopBodyTable.find("input[id='promBuyPriceBody']").removeClass("promBuyPriceBody").attr("buyPriceLimit","").attr("buyWhen","").attr("value","");
  		shopBodyTable.find("input[id='normSellPrice']").removeClass("normSellPrice").attr("value","");
  		shopBodyTable.find("input[id='promSellPriceBody']").removeClass("promSellPriceBody").attr("value","");
  		shopBodyTable.find("input[id='priceCut']").removeClass("priceCut");
  		shopBodyTable.find("input[id='netMaori']").removeClass("netMaori");
  		shopBodyTable.find("input[id='netCost']").attr("value","");
  		shopBodyTable.find("input[id='vat']").attr("value","");
  		shopBodyTable.find("input[id='promSupNo']").attr("value","");
  		shopBodyTable.find("input[id='mainComName']").attr("value","");
    }
    
    function clearShopHeadTable(){
    	var shopHeadTable = $("#oneShopHeadTable");
  		shopHeadTable.find("input[id='checkbox']").removeClass("isChecksART").attr("deleteId","").attr("name","").attr("unitTypeVal","").attr("unitNoVal","").attr("itemNoVal","").attr("colagNoVal","");
  		shopHeadTable.find("input[id='storeInfo']").attr("value","");
    }
    
    
   /* function changeBuyBeginOldTime(){
    	$("#oBuyBeginDate").val($("#buyTimeStart").val());
    }
    
    function changeBuyEndOldTime(){
    	$("#oBuyEndDate").val($("#buyTimeEnd").val());
    }
    
    function changeSellBeginOldTime(){
    	$("#oSellBeginDate").val($("#promTimeStart").val());
    }
    
    function changeSellEndOldTime(){
    	$("#oSellEndDate").val($("#promTimeEnd").val());
    }*/
    