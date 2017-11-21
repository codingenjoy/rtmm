var num =1;
var ItemsStoreArray=new Array();
var itemsStoreJson;
Array.prototype.del=function(n){
	if(n<0){
	return this;
	}else{
		//return this.slice(0,n).concat(this.slice(n+1,this.length));
		var a = this.slice(0,n);
		var b = this.slice(n+1,this.length);
		var c = a.concat(b);
		return c;
	}
};
Array.prototype.unique = function () {
    var temp = new Array();
      this.sort();
      for(i = 0; i < this.length; i++) {
          if( this[i] == this[i+1]) {
            continue;
        }
          temp[temp.length]=this[i];
      }
      return temp;
  
}
function enterUnitNoShow(evt,obj) {
	 var evt=evt?evt:(window.event?window.event:null);//兼容IE和FF
	 if (evt.keyCode==13){
		obj.change();
	 }
}
function isMoney4(param)
{
	var reg = /^([1-9][\d]{0,7}|0)(\.[\d]{1,4})?$/;
    if($.trim(param)=='')
    {
    	return true;
    }
    if(!reg.test(param)){  
       return false; 
     }
    else
    {
    	return true;
    }
}

function isMoney2(param)
{
	var reg = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
    if($.trim(param)=='')
    {
    	return true;
    }
    if(!reg.test(param)){  
       return false; 
     }
    else
    {
    	return true;
    }
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

//判断促销是否开始
function checkPromBegin(){
	var sellBegin = $("#sellBegin").val();
	var buyBegin = $("#buyBegin").val();
	if(buyBegin !=0 || sellBegin!=0){
		return false;
	}else{
		return true;
	}
}
//判断促销是否已经结束
function checkPromEnd(){
	var promEnd = $("#promEnd").val();
	if(promEnd !=0){
		return false;
	}else{
		return true;
	}
}

function enterShow(evt,obj){
	 var evt=evt?evt:(window.event?window.event:null);//兼容IE和FF
	 if (evt.keyCode==13){
	 	$(obj).change();
	 }
}
$(function() {
	    /*for (var layer = 0; layer < 10; layer++) {
			top.grid_layer_close();
		}*/
		$("#Tools2").removeClass("Tools2_disable").addClass("Tools2");
		$(".item").die('click');
		$("#showDeleteItems").removeClass("createNewBar_off").addClass("createNewBar")
        $("#showDeleteSuppler").removeClass("createNewBar_off").addClass("createNewBar");

		$(".tags_close").bind("click",function(){
			$(top.document).find("#contentIframe").attr("src",ctx + '/prom/nondm/art/ARTPromo');
			//prom/nondm/art/ARTPromo
		});
		
		 $(".isCheckAllsART").live("click",function(){
		    if(this.checked){
		        $(".isChecksART").attr("checked",true);    
		    }
		    else{
		        $(".isChecksART").attr("checked",false);    
		    }
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

	//点击代号行的样式处理
	
	//添加代号信息行
	function addARTPromoCode(){
		
		if(checkPromBegin()){
			var subjName=$("#subjName").val();
			var promBeginDate=$("#promTimeStart").val();
			var promEndDate=$("#promTimeEnd").val();
			var buyBeginDate=$("#buyTimeStart").val();
		    var buyEndDate=$("#buyTimeEnd").val();
		    var catlgId=$("#CatlgId").val();
		    var pricePromType=$("#promType").val();
		    var promNo = $("#promNo").val();
			
		    
		     var error = 0;
		    if($.trim(subjName)==''){
				   $("#subjName").removeClass('errorInput').addClass(
					'errorInput');
				   $("#subjName").attr("title",'请输入主题!');
			       error++;
			 }
	    	/*if($.trim(catlgId)==''){
	    		$("#CatlgId").removeClass("errorInput").addClass(
					'errorInput');
				$("#CatlgId").attr("title",'请选择课别!');
	    		error++;
	     	}*/
		    
	     	if(!checkTimeNoAjax()){
	    		error++;
		    }
		    if(error<1){
		    	if(checkUnitListIsEmpty()){
					$("#ArtPromoCodeDiv").append($("#addPromCode_div").html());
					$("#ArtPromoCodeDiv").find(".item_on").removeClass("item_on");
					$("#ArtPromoCodeDiv").find(".supplerItem:last").removeClass("item_on").addClass("item_on");
					$("input.promBuyPriceHead[child=1]").val("");
					$("input.promSellPriceHead[child=1]").val("");
					$(".pro_store_items").html("");
			    	$("#shopBodyTable").html("");
			    	$("#shopHeadTable").html("");
				}else{
					if(checkItemStoreDate()){
					$("#ArtPromoCodeDiv").append($("#addPromCode_div").html());
					$("#ArtPromoCodeDiv").find(".item_on").removeClass("item_on");
					$("#ArtPromoCodeDiv").find(".supplerItem:last").removeClass("item_on").addClass("item_on");
					$("input.promBuyPriceHead[child=1]").val("");
					$("input.promSellPriceHead[child=1]").val("");
					$(".pro_store_items").html("");
			    	$("#shopBodyTable").html("");
			    	$("#shopHeadTable").html("");
					}
				}
				$(".pro_store_tb_edit").scrollTop($(".pro_store_tb_edit").scrollTop()+30);
		    }
		}else{
			top.jAlert('warning', '促销已经开始，不能新增商品!', '提示消息');
		}
	}
	
	//根据代号，代号类型，课别查找商品信息
    $(".supplerItem").live("click", function () {
    		var cisdb = true;
    		var unitType= $(this).find("select[name='unitType']").val();
		    var unitNo = $(this).find("input[name='unitNo']").val();
		    var catlgId = $("#CatlgId").val();
		    var thisHasItemNoClass = $(this).hasClass("item_on");
		    if(!thisHasItemNoClass){
		    	cisdb = checkItemStoreDateBy();
		    }else{
		    	return;
		    }
    		if(cisdb){
    			//top.grid_layer_open();
    			$("#ArtPromoCodeDiv").find(".item_on").removeClass("item_on");
        	    $(this).addClass("item_on");
    			var promType = $("#promType").val();
		    	$(".pro_store_items").html("");
		    	$("#shopBodyTable").html("");
		    	$("#shopHeadTable").html("");
		    	$("input.promBuyPriceHead[child=1]").val("");
		    	$("input.promSellPriceHead[child=1]").val("");
		    	if(unitType == null || unitType =="" || unitNo==null || unitNo=="" || catlgId ==null || catlgId ==""){
		    		//top.grid_layer_close();
		    		return;
		    	}else{
		    		//查询商品信息
		    		var itemOnNo ="";
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
					 			var itemOn = "";
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
					 				}
					 				if(jsonUnitType=='0'){
					 					$(".pro_store_items").append("<div class='item addItems  "+itemOn+"' itemNoValue='"+jsonItemNo+"' unitNoValue='"+unitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+jsonItemNo+"-"+jsonItemName+"</span></div>");
					 				}else{
					 					$(".pro_store_items").append("<div class='item addItems  "+itemOn+"' itemNoValue='"+jsonItemNo+"' unitNoValue='"+unitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+jsonItemNo+"-"+jsonItemName+"</span><span class='pstb_del2'></span></div>");
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
		    	}
		    	//top.grid_layer_close();
    		}
    });
	
    //代号类型的选择事件
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
    
    
    //删除代号行的事件
	$(".pstb_del").live("click",function(){
		if(checkPromEnd()){
			 if(checkPromBegin()){
				 var $row = $(this).parent(".supplerItem");
				 var unitNo = $row.find("input[name='unitNo']").val();
				 var unitType=$row.find("select[name='unitType']").val();
				 var catlgId = $("#CatlgId").val();
				 var itemNoStr="";
				 if(unitNo == null || unitNo ==""){ $row.remove();$(".pro_store_tb_edit").scrollLeft(0);return;}
				  for (var i = 0; i < ItemsStoreArray.length; i++) {
				 	var itemsStoreJson = ItemsStoreArray[i];
				 	var jsonUnitNo = itemsStoreJson.unitNo;
				 	var jsonUnitType = itemsStoreJson.unitType;
				 	var jsonCatlgId = itemsStoreJson.catlgId;
				 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
				 		var storeArray = itemsStoreJson.storeArray;
				 		for (var j = 0; j < storeArray.length; j++) {
				 			var store = storeArray[j];
				 			itemNoStr += store.itemNo+",";
				 		}
				 	}
				  }
				  var itemNoArray = itemNoStr.substring(0,itemNoStr.length-1).split(",");
				  var itemNoArrayQuChong = itemNoArray.unique();
				  if(checkPromIsInOrder(1,0,0,itemNoArrayQuChong,0)){
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
					}
					 $row.remove();
					 $(".pro_store_tb_edit").scrollLeft(0);
				  
				  }else{
				  	top.jAlert('warning', '已经有没有作废的订单使用该促销期数!', '提示消息');
				  };
			 }else{
			 	top.jAlert('warning', '促销已经开始，不能删除商品!', '提示消息');
			 }
		}else{
			top.jAlert('warning', '促销已经结束，不能删除商品!', '提示消息');
		}
		
	});
	function addStoreGrpTypeReturn(data){
		//var unitType =$(this).parent().parent().find("select").val();
		var unitType=$("#ArtPromoCodeDiv .item_on").find("select[name='unitType']").val();
		var oldUnitNo = $("#ArtPromoCodeDiv .item_on").find("input[name='unitNo']").val();
		var catlgId = $("#CatlgId").val();
		var promType = $("#promType").val();
		if (data != undefined){
			var isHave = checkHasOne(unitType,data.promUnitNo,catlgId);
			if(isHave){
				var storeArray=new Array();
				if(data != null && data.list != null){
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
	 				 	$(".pro_store_items").append("<div class='item addItems item_on' itemNoValue='"+data.promUnitNo+"' unitNoValue='"+data.promUnitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+data.promUnitNo+"-"+data.promUnitName+"</span></div>");
	 				 }else{
	 				 	var fliterList = filterCheckItemNo(data.itemList,unitType);
	 				 	if(fliterList !=null ){
 		 				 	for (var j = 0; j < fliterList.length; j++) {
 		 				 		var itemVo  = fliterList[j];
 		 				 		var itemOn = "";
			 					if(j==0){
			 						itemOn = "item_on";
			 						onItemNo = itemVo.itemNo;
			 					}
			 					$(".pro_store_items").append("<div class='item addItems "+itemOn+"' itemNoValue='"+itemVo.itemNo+"' unitNoValue='"+data.promUnitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+itemVo.itemNo+"-"+itemVo.itemName+"</span><span class='pstb_del2'></span></div>");
				 				
 		 				 	}
	 				 	}else{
	 				 		top.grid_layer_close();
	 				 		$("#ArtPromoCodeDiv .item_on").find("input[name='unitNo']").val("");
	 				 		return;
	 				 	}
	 				 }
	 				//var shopHeadTable="";
				 	//var shopBodyTable ="";
					for (var i = 0; i < data.list.length; i++) {
	        			var store = data.list[i];
	        			//显示门店信息
	        			if(onItemNo == store.itemNo){
	        				var num = parseInt(Math.random()*100000);
	        				appendShopBodyTable(store,num,unitType,data.promUnitNo,catlgId);
    						appendShopHeadTable(store,num,unitType,data.promUnitNo,catlgId);
				 			/*shopHeadTable+="<tr><td style='width:30px;'><input type='checkbox' class='isChecksART' deleteId='"+(i+num)+"'  name='"+store.storeNo+"' unitTypeVal='"+unitType+"' unitNoVal='"+data.promUnitNo+"' itemNoVal='"+store.itemNo+"' colagNoVal='"+catlgId+"'/></td>";
		        			shopHeadTable+="<td><div style='width:110px;'><input type='text' class='inputText w85 Black' readonly='readonly' value='"+store.storeNo+"-"+store.storeName+"'/></div></td></tr>";
		        			
				 			//门店soteNo
		        			shopBodyTable+="<tr id='"+(i+num)+"'>";
		        			shopBodyTable+="<td><div style='width:100px;' > <input type='text' class='inputText w95 Black status' readonly='readonly'  name='"+store.basicStatus+"' value='"+store.status+"-"+store.itemStatusName+"'/></div></td>";
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
	        			
	        			var storeJson = {"promSupNo":store.stMainSupNo,"mainComName":store.mainComName,"status":store.status,"basicStatus":store.basicStatus,"statusName":store.itemStatusName,"storeNo":store.storeNo,"storeName":store.storeName,"itemNo":store.itemNo,"unitType":unitType,"unitNo":data.promUnitNo,"normBuyPrice":store.normBuyPrice,"normSellPrice":store.normSellPrice,"promBuyPrice":"","promSellPrice":"","netCost":store.netCost,"sellVat":store.vatVal,"itemName":store.itemName,"priceCut":"","netMaori":"","buyPriceLimit":store.buyPriceLimit,"buyWhen":store.buyWhen,"appendBuy":store.appendBuy,"appendProm":store.appendProm,"existPromNo":store.promNo};
        			    storeArray[storeArray.length] = storeJson;
	        		}
	        		//var itemsStoreJson ={"unitType":unitType,"unitNo":data.promUnitNo,"catlgId":catlgId,"promActvy":"0","pmGiftHint":"","memo":"","storeArray":storeArray};
	        		var itemsStoreJson ={"unitType":unitType,"unitNo":data.promUnitNo,"catlgId":catlgId,"storeArray":storeArray};
    			    ItemsStoreArray[ItemsStoreArray.length] = itemsStoreJson;
	        		//$("#shopHeadTable").append(shopHeadTable);
	        		//$("#shopBodyTable").append(shopBodyTable);
	        		$("m_cols_head").scrollLeft(0);
	        		$("#m_cols_body").scrollLeft(0);
	        		$("#m_cols_body").scrollTop(0);
    			    $(".item_on").find("input[name='unitNo']").val(data.promUnitNo);
    				$(".item_on").find("input[name='promUnitName']").val(data.promUnitName);
    				$(".item_on").find("input[name='oUnitNo']").val(data.promUnitNo);
    				//$(".item_on").find("select[name='promActvy']").val("0");
					$(".item_on").find(".promBuyPriceHead").val("");
				    $(".item_on").find(".promSellPriceHead").val("");
				    $(".promBuyPriceHead[child=1]").val("");
				    $(".promSellPriceHead[child=1]").val("");
					//$(".item_on").find("input.pmGiftHint").val("");
					//$(".item_on").find("input.memo").val("");
    				changeInputByPromPriceType(promType);
    				top.grid_layer_close();
				}
			}else{
				top.jAlert('warning', '该代号已经存在，请重新选择！', '提示消息');
			}
		}
		top.closePopupWin();
	}
	
	//代号弹出框
	$(".showUnitWin").live('click',function(){
		var isSelect = $(this).parents(".supplerItem").hasClass("item_on");
		if(!isSelect){
			return false;
		}
		
		if(!checkTimeNoAjax()){
			top.jAlert('warning', '请选择时间！', '提示消息');
			return;
		}
		var buyts = $("#buyTimeStart").val();
		var buyte = $("#buyTimeEnd").val();
		var promts= $("#promTimeStart").val();
		var promte= $("#promTimeEnd").val();
		var unitType =$(this).parent().parent().find("select").val();
		var unitNo =$(this).parent().parent().find("input[name='unitNo']").val();
		var catlgId = $("#CatlgId").val();
		var promType = $("#promType").val();
		var promNo = $("#promNo").val();
		if(unitType == "" || unitType == null ){
			top.jAlert('warning', '请选择代号类型！', '提示消息');
			return ;
		}
		
		if(unitNo !=null && unitNo !=""){
			var itemNoStr="";
			for (var i = 0; i < ItemsStoreArray.length; i++) {
			 	var itemsStoreJson = ItemsStoreArray[i];
			 	var jsonUnitNo = itemsStoreJson.unitNo;
			 	var jsonUnitType = itemsStoreJson.unitType;
			 	var jsonCatlgId = itemsStoreJson.catlgId;
			 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
			 		var storeArray = itemsStoreJson.storeArray;
			 		for (var j = 0; j < storeArray.length; j++) {
			 			var store = storeArray[j];
			 			itemNoStr += store.itemNo+",";
			 		}
			 	}
			  }
			  var itemNoArray = itemNoStr.substring(0,itemNoStr.length-1).split(",");
			  var itemNoArrayQuChong = itemNoArray.unique();
			  if(!checkPromIsInOrder(1,0,0,itemNoArrayQuChong,0)){
			  	top.jAlert('warning', '已经有没有作废的订单使用该促销期数!', '提示消息');
			  	return;
			  }
		}
		
		top.openPopupWin(800,450, '/prom/nondm/art/showUnitWin?unitType='+unitType+'&catlgId='+catlgId+'&promType='+promType+'&buyStartDate='+buyts+'&buyEndDate='+buyte+'&promStartDate='+promts+'&promEndDate='+promte+'&promNo='+promNo);
	});
	
	$(".unitNo").die("focus").live("focus",function(){
    	//验证时间
		if(!checkTimeNoAjax()){
			$(this).val("");
			return;
		}
		$(this).parents(".supplerItem").trigger('click');
    });
	
	//手动输入代号信息
	$(".unitNo").die("change").live("change",function(){
		if(checkPromEnd()){
			if(checkPromBegin()){
				top.grid_layer_open();
				var flag = false;
				var isHave = true;
				var unitType =$(this).parent().parent().find("select").val();
				var unitNo = $(this).val();
				var catlgId = $("#CatlgId").val();
				var promType = $("#promType").val();
				var oUnitNo =$(this).parent().parent().find("input[name='oUnitNo']").val();
				var buyts = $("#buyTimeStart").val();
				var buyte = $("#buyTimeEnd").val();
				var promts= $("#promTimeStart").val();
				var promte= $("#promTimeEnd").val();
				var promNo = $("#promNo").val();
				if(oUnitNo !=null && oUnitNo !=""){
					var itemNoStr="";
					for (var i = 0; i < ItemsStoreArray.length; i++) {
					 	var itemsStoreJson = ItemsStoreArray[i];
					 	var jsonUnitNo = itemsStoreJson.unitNo;
					 	var jsonUnitType = itemsStoreJson.unitType;
					 	var jsonCatlgId = itemsStoreJson.catlgId;
					 	if(jsonUnitNo == oUnitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
					 		var storeArray = itemsStoreJson.storeArray;
					 		for (var j = 0; j < storeArray.length; j++) {
					 			var store = storeArray[j];
					 			itemNoStr += store.itemNo+",";
					 		}
					 	}
					  }
					  var itemNoArray = itemNoStr.substring(0,itemNoStr.length-1).split(",");
					  var itemNoArrayQuChong = itemNoArray.unique();
					  if(!checkPromIsInOrder(1,0,0,itemNoArrayQuChong,0)){
					  	top.jAlert('warning', '已经有没有作废的订单使用该促销期数!', '提示消息');
					  	$(this).val(oUnitNo);
					  	top.grid_layer_close();
					  	return;
					  }
				}
				
				if(unitNo != oUnitNo && oUnitNo !=""){
					removeDateJson(oUnitNo,unitType,catlgId);
				}
				if(unitNo == oUnitNo){
					top.grid_layer_close();
					return;
				}
				if(unitNo==null || unitNo ==""){
					top.jAlert('warning', '请输入代号信息！', '提示消息');
					clearMainHtml();
					top.grid_layer_close();
					return;
				}
				
				if(!isNumber(unitNo)){
					top.jAlert('warning', '请输入数字！', '提示消息');
					clearMainHtml();
					top.grid_layer_close();
					return;
				}
				
				
				
				isHave = checkHasOne(unitType,unitNo,catlgId);
				if(isHave){
					//添加新的数据
					$.ajax({
					url: ctx + '/prom/nondm/art/newGetARTJsonData',
			        type: "post",
			        dataType:"json",
			        data:{unitType:unitType,unitNo:unitNo,catlgId:catlgId,promType:promType,buyStartDate:buyts,buyEndDate:buyte,promStartDate:promts,promEndDate:promte,promNo:promNo},
			        success: function(result) {
			        	if(result.list != null && result.list.length > 0){ 
				        	 var storeArray=new Array();
			        		 $("#shopBodyTable").html("");
		 		 		     $("#shopHeadTable").html("");
		 		 			 $(".pro_store_items").html("");
			        		 var onItemNo="";
			        		 if(unitType=='0'){
		 		 				 onItemNo = unitNo;
		 		 				 var fliterList = filterCheckItemNo(unitNo,unitType);
			        		 	  if(fliterList==null || fliterList.length <1){
			        		 	  	top.jAlert('warning', '该代号下没有符合的商品！', '提示消息');
			        		 	  	$("#ArtPromoCodeDiv .item_on").find("input[name='unitNo']").val()
			        		 	  	return;
			        		 	  }
		 		 				 var promNo = result.itemList[0].promNo;
		 		 				 var bgColor ="";
		 		 				 if(promNo){
		 		 				 	bgColor="bgColorRed";
		 		 				 }
		 		 				 $(".pro_store_items").append("<div class='item addItems item_on "+bgColor+"' itemNoValue='"+unitNo+"' unitNoValue='"+unitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+unitNo+"-"+result.unitName+"</span></div>");
		 		 			 }else{
		 		 			 	var fliterList = filterCheckItemNo(result.itemList,unitType);
		 		 			 	if(fliterList==null || fliterList.length <1){
		 		 			 		top.jAlert('warning', '该代号下没有符合的商品！', '提示消息');
		 		 			 		$("#ArtPromoCodeDiv .item_on").find("input[name='unitNo']").val()
		 		 			 		return;
		 		 			 	}else{
			 		 				 for (var j = 0; j < fliterList.length; j++) {
			 		 				 	var itemVo  = fliterList[j];
			 		 				 	var itemOn = "";
						 				if(j==0){
						 					itemOn = "item_on";
						 					onItemNo = itemVo.itemNo;
						 				}else{
						 					itemOn = "";
						 				}
						 				 var appendBuy = itemVo.appendBuy;
				 		 				 var appendProm = itemVo.appendProm;
				 		 				 var bgColor ="";
				 		 				 if(appendBuy==1 || appendProm==1 || appendProm==2){
				 		 				 	bgColor="bgColorRed";
				 		 				 }
						 				$(".pro_store_items").append("<div class='item addItems "+itemOn+"' itemNoValue='"+itemVo.itemNo+"' unitNoValue='"+unitNo+"' catlgIdValue='"+catlgId+"' unitType='"+unitType+"'><span class='pstb_1'>"+itemVo.itemNo+"-"+itemVo.itemName+"</span><span class='pstb_del2'></span></div>");
			 		 				 }
		 		 			 	}
		 		 			 }
			        		$(".item_on").find("input[name='promUnitName']").val(result.unitName);
			        		$(".item_on").find("input[name='oUnitNo']").val(unitNo);
			        		var shopHeadTable="";
						 	var shopBodyTable ="";
			        		for (var i = 0; i < result.list.length; i++) {
				    			var store = result.list[i];
				    			//显示门店信息
			        			if(onItemNo == store.itemNo){
			        				var num = parseInt(Math.random()*100000);
			        				appendShopBodyTable(store,num,unitType,unitNo,catlgId);
    								appendShopHeadTable(store,num,unitType,unitNo,catlgId);
						 			/*shopHeadTable+="<tr><td style='width:30px;'><input type='checkbox' class='isChecksART' deleteId='"+(i+num)+"'  name='"+store.storeNo+"' unitTypeVal='"+unitType+"' unitNoVal='"+unitNo+"' itemNoVal='"+store.itemNo+"' colagNoVal='"+catlgId+"'/></td>";
				        			shopHeadTable+="<td><div style='width:110px;'><input type='text' class='inputText w85 Black' readonly='readonly' value='"+store.storeNo+"-"+store.storeName+"'/></div></td></tr>";
						 			//门店soteNo
				        			shopBodyTable+="<tr id='"+(i+num)+"'>";
				        			shopBodyTable+="<td><div style='width:100px;' > <input type='text' class='inputText w95 Black status' readonly='readonly' name='"+store.basicStatus+"'  value='"+store.status+"-"+store.itemStatusName+"'/></div></td>";
				        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 Black' readonly='readonly' name='normBuyPrice'  value='"+store.normBuyPrice+"' /></div></td>";
				        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 promBuyPriceBody' value='' buyPriceLimit='"+store.buyPriceLimit+"' buyWhen='"+store.buyWhen+"'/></div></td>";
				        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 Black normSellPrice' readonly='readonly' name='normSellPrice'   value='"+store.normSellPrice+"'/></div></td>";
				        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 promSellPriceBody' value='' /></div></td>";
				        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 Black priceCut' readonly='readonly' value='' /></div></td>";
				        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 Black netMaori' readonly='readonly' value='' /></div></td>";
				        			shopBodyTable+="<td><div style='width:60px;'><input type='hidden' id='netCost' name='' value='"+store.netCost+"' /><input type='hidden' id='vat' name='' value='"+store.vatVal+"' /><input class='w95 Black inputText' type='text' value='"+store.stMainSupNo+"'></div></td>";
				        			shopBodyTable+="<td><div style='width:185px;'><input type='text' class='inputText w95 Black' readonly='readonly'  value='"+store.mainComName+"'/></div></td>";
				        			shopBodyTable+="</tr>";*/
			        			}
				    			var storeJson = {"promSupNo":store.stMainSupNo,"mainComName":store.mainComName,"status":store.status,"basicStatus":store.basicStatus,"statusName":store.itemStatusName,"storeNo":store.storeNo,"storeName":store.storeName,"itemNo":store.itemNo,"unitType":unitType,"unitNo":unitNo,"normBuyPrice":store.normBuyPrice,"normSellPrice":store.normSellPrice,"promBuyPrice":"","promSellPrice":"","netCost":store.netCost,"sellVat":store.vatVal,"itemName":store.itemName,"priceCut":"","netMaori":"","buyPriceLimit":store.buyPriceLimit,"buyWhen":store.buyWhen,"appendBuy":store.appendBuy,"appendProm":store.appendProm,"existPromNo":store.promNo};
							    storeArray[storeArray.length] = storeJson;
				    		}
			        		//var itemsStoreJson ={"unitType":unitType,"unitNo":unitNo,"catlgId":catlgId,"promActvy":"0","pmGiftHint":"","memo":"","storeArray":storeArray};
				    		var itemsStoreJson ={"unitType":unitType,"unitNo":unitNo,"catlgId":catlgId,"storeArray":storeArray};
				    		ItemsStoreArray[ItemsStoreArray.length] = itemsStoreJson;
				    		$("#shopHeadTable").append(shopHeadTable);
				    		$("#shopBodyTable").append(shopBodyTable);
				    		$("#m_cols_head").scrollLeft(0);
				    		$("#m_cols_body").scrollLeft(0);
				    		$("#m_cols_body").scrollTop(0);
				    		$(".promBuyPriceHead[child=1]").val("");
						    $(".promSellPriceHead[child=1]").val("");
						    //$("#ArtPromoCodeDiv").find("div.item_on").find("select[name='promActvy']").val("0");
							$("#ArtPromoCodeDiv").find("div.item_on").find("input.promBuyPriceHead").val("");
							$("#ArtPromoCodeDiv").find("div.item_on").find("input.promSellPriceHead").val("");
							//$("#ArtPromoCodeDiv").find("div.item_on").find("input.pmGiftHint").val("");
							//$("#ArtPromoCodeDiv").find("div.item_on").find("input.memo").val("");
						    
						    
				    		changeInputByPromPriceType(promType);
				         }else{
				        	var msg ="系列";
							if(unitType==0){
								msg="单品";
							}
							top.jAlert('warning', '该'+msg+'不存在！', '提示消息');
							//flag = true;
							clearMainHtml();
				         } 
				      }
					}); 
				}else{
					top.jAlert('warning', '该代号已经存在，请重新选择！', '提示消息');
					//flag = true;
					clearMainHtml();
				}
					top.grid_layer_close();
			}else{
				top.jAlert('warning', '促销已经开始，不能新增代号信息!', '提示消息');
			}
		}else{
			top.jAlert('warning', '促销已经结束，不能新增代号信息!', '提示消息');
		}
		
	});
     //点击商品，查询所有的门店信息
    $(".addItems").live("click",function(){
    	top.grid_layer_open();
    	var ItemNo = $(this).attr("itemNoValue");
    	var unitNo = $(this).attr("unitnovalue");
    	var catlgId = $(this).attr("catlgIdValue");
    	var unitType=$(this).attr("unitType");
    	var promType = $("#promType").val();
    	/*var isHave = checkHasOne(ItemNo,unitNo,catlgId);*/
    	$("#shopHeadTable").html("");
    	$("#shopBodyTable").html("");
    	$(".addItems").parent("div.pro_store_items").find(".item_on").removeClass("item_on");
    	$(this).addClass("item_on");
    	var shopHeadTable ="";
	    var shopBodyTable="";
    	//查询商品信息
		 for (var i = 0; i < ItemsStoreArray.length; i++) {
		 	var itemsStoreJson = ItemsStoreArray[i];
		 	var jsonUnitNo = itemsStoreJson.unitNo;
		 	var jsonUnitType = itemsStoreJson.unitType;
		 	var jsonCatlgId = itemsStoreJson.catlgId;
		 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
		 		var storeArray = itemsStoreJson.storeArray.sort(
			 		function(a,b){  //自定义函数排序  
					    var a1= parseInt(a.storeNo);  
					    var b1= parseInt(b.storeNo);  
					    if(a1<b1){return -1;}else if(a1>b1){return 1;}  
					    return 0;
			 		}
		 		);
		 		var storeArray = itemsStoreJson.storeArray;
		 		for (var j = 0; j < storeArray.length; j++) {
		 			var store = storeArray[j];
		 			var jsonItemNo = store.itemNo;
		 			if(jsonItemNo == ItemNo){
	        		    var num1 = parseInt(Math.random()*100000);
	        		    appendShopBodyTable(store,num1,unitType,unitNo,catlgId);
    					appendShopHeadTable(store,num1,unitType,unitNo,catlgId);
						//var store = result.storeList[i];
						/*shopHeadTable+="<tr><td style='width:30px;'><input type='checkbox' class='isChecksART' deleteId='"+(j+num1)+"'  name='"+store.storeNo+"' unitTypeVal='"+unitType+"' unitNoVal='"+unitNo+"' itemNoVal='"+ItemNo+"' colagNoVal='"+catlgId+"'/></td>";
	        			shopHeadTable+="<td><div style='width:110px;'><input type='text' class='inputText w85 Black' readonly='readonly' value='"+store.storeNo+"-"+store.storeName+"'/></div></td></tr>";
	        			//门店soteNo
	        			shopBodyTable+="<tr id='"+(j+num1)+"'>";
	        			shopBodyTable+="<td><div style='width:100px;' > <input type='text' class='inputText w95 Black status' readonly='readonly' name='"+store.basicStatus+"'  value='"+store.status+"-"+store.statusName+"'/></div></td>";
	        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 Black' readonly='readonly' name='normBuyPrice'  value='"+store.normBuyPrice+"' /></div></td>";
	        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 promBuyPriceBody' value='"+store.promBuyPrice+"' buyPriceLimit='"+store.buyPriceLimit+"' buyWhen='"+store.buyWhen+"'/></div></td>";
	        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 Black normSellPrice' readonly='readonly' name='normSellPrice'   value='"+store.normSellPrice+"'/></div></td>";
	        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 promSellPriceBody' value='"+store.promSellPrice+"' /></div></td>";
	        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 Black priceCut' readonly='readonly' value='"+store.priceCut+"' /></div></td>";
	        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 Black netMaori' readonly='readonly' value='"+store.netMaori+"' /></div></td>";
	        			shopBodyTable+="<td><div style='width:60px;'><input type='hidden' id='netCost' name='' value='"+store.netCost+"' /><input type='hidden' id='vat' name='' value='"+store.sellVat+"' /><input class='w95 Black inputText' type='text' value='"+store.promSupNo+"'></div></td>";
	        			shopBodyTable+="<td><div style='width:185px;'><input type='text' class='inputText w95 Black' readonly='readonly'  value='"+store.mainComName+"'/></div></td>";
	        			shopBodyTable+="</tr>";*/
		 			}
		 		}
		 	}
    	 }
    	 $("#shopHeadTable").append(shopHeadTable);
    	 $("#shopBodyTable").append(shopBodyTable);
    	 $("#m_cols_head").scrollLeft(0);
		 $("#m_cols_body").scrollLeft(0);
		 $("#m_cols_body").scrollTop(0);
    	 changeInputByPromPriceType(promType);
    	 top.grid_layer_close();
    });
    
	//删除商品信息行
	$(".pstb_del2").live("click",function(){
		
		 var itemLength = $(".addItems").length;
			 if(itemLength > 1){
			 var $row = $(this).parent(".item");
			 $("#showDeleteItems").removeClass("createNewBar_off").addClass("createNewBar");
			 var itemNo = $row.attr("itemNoValue");
			 var unitNo = $row.attr("unitNoValue");
			 var catlgId =$row.attr("catlgIdValue");
			 var unitType =$row.attr("unitType");
			 var promPriceType=$("#promType").val();
			 var flag = true;
			 if(checkPromEnd()){
				 if(checkPromBegin()){
				 	if(promPriceType!=3){
				 		//如果当前促销包含进价促销，需要检查当前是否有没有作废的订单订单已经使用该促销期数
				 		//如果没有，可以删除    如果有，不能删除
				 		if(!checkPromIsInOrder(1,0,0,itemNo,0)){
				 			top.jAlert('warning', '已经有没有作废的订单使用该促销期数!', '提示消息');
				 			flag = false;
				 		}
				 		
				 	}
				 }else{
					 top.jAlert('warning', '促销已经开始，不能删除商品!', '提示消息');
					 flag = false;
				}
			 }else{
			 	top.jAlert('warning', '促销已经结束，不能新增商品!', '提示消息');
			 	flag = false;
			 }
			 
			 if(flag){
			 	//移除商品数据的公用方法
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
				 			if(jsonItemNo == itemNo){
				 				storeArray = storeArray.del(j);
				 				j=-1;
				 			}
				 		}
				 		ItemsStoreArray[i].storeArray = storeArray;
				 	}
				 }
				$("#shopBodyTable").html("");
				$("#shopHeadTable").html("");
				$row.remove();
			 }
		 }else{
		 	top.jAlert('warning', '请确保该代号下至少有一个商品！', '提示消息');
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
						 	//alert(jsonUnitNo+"**"+jsonUnitType+"**"+jsonCatlgId);
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
		var itemsNos= new Array();
		var buyts = $("#buyTimeStart").val();
		var buyte = $("#buyTimeEnd").val();
		var promts= $("#promTimeStart").val();
		var promte= $("#promTimeEnd").val();
		var promType = $("#promType").val(); 
		var promNo =$("#promNo").val();
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
		if(unitType != 0){
			if(checkPromEnd()){
				if(checkPromBegin()){
					if(unitNo != null && catlgId !=null && unitType !=null&&catlgId!=""&&unitNo != ""&&unitType !=""){
						top.openPopupWin(420,480,'/prom/nondm/art/showARTDeleteItemsList?itemsValue='+itemsNos+'&unitNo='+unitNo+'&catlgId='+catlgId+'&unitType='+unitType+"&flag=ART&promType="+promType+'&buyStartDate='+buyts+'&buyEndDate='+buyte+'&promStartDate='+promts+'&promEndDate='+promte+'&promNo='+promNo);					}
				}else{
					top.jAlert('warning', '促销已经开始，不能新增商品!', '提示消息');
				}
			}else{
				top.jAlert('warning', '促销已经结束，不能新增商品!', '提示消息');
				
			}
		}else{
			top.jAlert('warning', '代号类别为单品时，只能有一个商品', '提示消息');
		}
	});
	
	//全部删除门店信息
	$("#deleteAllART").die("click").live("click",function(){
		if(checkPromEnd()){
			 if(checkPromBegin()){
			 	var allIdList = $("input.isChecksART");
				var deleteIdList =  $("input.isChecksART:checked");
				if(deleteIdList.length==allIdList.length){top.jAlert('warning', '至少需要保留一个门店!', '提示消息');return;}
				if(deleteIdList.length<1){top.jAlert('warning', '请选择需要删除的门店!', '提示消息');return;}
				var deleteStoreIdStr="";
				$("input.isChecksART:checked").each(function (){
					deleteStoreIdStr += $(this).attr("name")+",";
				});
				var unitNo = $("input.isChecksART:checked").attr("unitNoVal");
				var unitType = $("input.isChecksART:checked").attr("unitTypeVal");
				var ItemNo = $("input.isChecksART:checked").attr("itemNoVal");
				var catlgId = $("input.isChecksART:checked").attr("colagNoVal");
				if(checkPromIsInOrder(1,0,0,ItemNo,deleteStoreIdStr.substring(0,deleteStoreIdStr.length-1))){
					top.grid_layer_open();
					//移除商品数据的公用方法
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
					 			//checked="checked"
					 			if(jsonItemNo == ItemNo){
						 			for (var index = 0; index < deleteIdList.length; index++) {
						 				var storeNo = deleteIdList[index].name;
						 				if(jsonStoreNo==storeNo){
						 					storeArray = storeArray.del(j);
						 					j=-1;
						 				}
						 			}
					 			}
					 			ItemsStoreArray[i].storeArray = storeArray;
					 		}
					 	}
					 }
					
					$(".isChecksART:checked").each(function(){
					 	var deleteId = $(this).attr("deleteId");
					 	$("#"+deleteId).remove();
					 	$(this).parent().parent().remove();
					 });
					 
					 /*第二版开始*/
					var removeItemClas = false;  
					$(".isChecksART").each(function(){
						var isHasCheck = $(this).parents("tr").hasClass("trBgRed");
					 	if(isHasCheck){
					 		removeItemClas = true;
					 		return false;
					 	}
					});
					if(!removeItemClas){$(".pro_store_items").find("div[itemnovalue="+ItemNo+"]").removeClass("bgColorRed");}
				    $(".isCheckAllsART").attr("checked",false);
				    $("#showDeleteSuppler").removeClass("createNewBar_off").addClass("createNewBar");
				    top.grid_layer_close();
				}else{
					top.jAlert('warning', '已经有没有作废的订单使用该促销期数!', '提示消息');
				}
			   
			 }else{
				 top.jAlert('warning', '促销已经开始，不能删除门店!', '提示消息');
			 }
		 
		}else{
			top.jAlert('warning', '促销已经结束，不能删除门店!', '提示消息');
		}
		
	});
	
	function addStoreSupMessReturn(storeIdArray){
		var promType = $("#promType").val();
		var unitNo = $("#ArtPromoCodeDiv").find("div.item_on").find("input[id=unitNo]").val();
		var catlgId = $("#CatlgId").val();
		var unitType=$("#ArtPromoCodeDiv").find("div.item_on").find("select[id=unitType]").val();
		var itemNo = $(".addItems.item_on").attr("itemnovalue");
		if(storeIdArray !=null  && storeIdArray.length> 0){
			$.ajax({
				async : false,
				url: ctx + '/prom/nondm/art/showSupplerList?storeNos='+storeIdArray+'&unitType='+unitType+'&unitNo='+unitNo+"&catlgId="+catlgId+"&itemNo="+itemNo+"&promType="+promType,
		        type: "post",
		        dataType:"json",
		        success: function(result) {
		        	//alert(result.storelist.length);
		        	if(result.storelist.length > 0){
		        		//var shopBodyTable ="";
		        		//var shopHeadTable="";
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
				        			shopBodyTable+="<tr id='"+(j+num)+"'></td>";
				        			shopBodyTable+="<td><div style='width:100px;' > <input type='text' class='inputText w95 Black status' readonly='readonly' name='"+store.basicStatus+"'  value='"+store.status+"-"+store.itemStatusName+"'/></div></td>";
				        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 Black' readonly='readonly' name='normBuyPrice'  value='"+store.normBuyPrice+"' /></div></td>";
				        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 promBuyPriceBody' value='' buyPriceLimit='"+store.buyPriceLimit+"' buyWhen='"+store.buyWhen+"'/></div></td>";
				        			shopBodyTable+="<td><div style='width:110px;'><input type='text' class='inputText w95 Black normSellPrice' readonly='readonly' name='normSellPrice'   value='"+store.normSellPrice+"'/></div></td>";
				        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 promSellPriceBody' value='' /></div></td>";
				        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 Black priceCut' readonly='readonly' value='' /></div></td>";
				        			shopBodyTable+="<td><div style='width:100px;'><input type='text' class='inputText w95 Black netMaori' readonly='readonly' value='' /></div></td>";
				        			shopBodyTable+="<td><div style='width:60px;'><input type='hidden' id='netCost' name='' value='"+store.netCost+"' /><input type='hidden' id='vat' name='' value='"+store.vatVal+"' /><input class='w95 Black inputText' type='text' value='"+store.stMainSupNo+"'></div>";
				        			shopBodyTable+="<td><div style='width:185px;'><input type='text' class='inputText w95 Black' readonly='readonly'  value='"+store.mainComName+"'/></div></td>";
				        			shopBodyTable+="</tr>";*/
						 		}
						 		ItemsStoreArray[i].storeArray=storeArray;
						 	}
		        		}
		        		$("#m_cols_head").scrollLeft(0);
					    $("#m_cols_body").scrollLeft(0);
					    $("#m_cols_body").scrollTop(0);
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
	function ARTPromoItem(){
		if(checkPromEnd()){
			if(checkPromBegin()){
				var storeNos= new Array();
				var promType = $("#promType").val();
				var unitNo = $("#ArtPromoCodeDiv").find("div.item_on").find("input[id=unitNo]").val();
				var catlgId = $("#CatlgId").val();
				var unitType=$("#ArtPromoCodeDiv").find("div.item_on").find("select[id=unitType]").val();
				var itemNo = $(".addItems.item_on").attr("itemnovalue");
				var buyts = $("#buyTimeStart").val();
				var buyte = $("#buyTimeEnd").val();
				var promts= $("#promTimeStart").val();
				var promte= $("#promTimeEnd").val();
				var promNo = $("#promNo").val();
				$(".isChecksART").each(function(i){
					storeNos[i] = $(this).attr("name");
				});
				if(unitNo != null && catlgId !=null && unitType !=null&&catlgId!=""&&unitNo != ""&&unitType !=""&&itemNo!="" && itemNo!=null ){
					top.openPopupWin(800,480, '/prom/nondm/art/showARTDeleteSupplerList?storeNos='+storeNos+'&unitNo='+unitNo+'&catlgId='+catlgId+'&unitType='+unitType+'&itemNo='+itemNo+'&promType='+promType+'&buyStartDate='+buyts+'&buyEndDate='+buyte+'&promStartDate='+promts+'&promEndDate='+promte+'&promNo='+promNo);
				}
			
			}else{
				top.jAlert('warning', '促销已经开始，不能新增门店信息!', '提示消息');
			}
		}else{
			top.jAlert('warning', '促销已经结束，不能新增门店信息!', '提示消息');
		}
	}
	
	
	
	
	/**
	 * 促销进价，促销售价的关联变化
	 * promBuyPriceHead，promSellPriceHead
	 * promBuyPriceBody，promSellPriceBody
	 */
	$(".pstb_del").live("click",function(e){
		e.stopPropagation();
	});
	
	$(".promSellPriceBody,.promBuyPriceBody").die("focus").live("focus",function(){
			$(this).removeClass("errorInput");
			$("#oldpricevalue").val($(this).val());
	});
	//点击promBuyPriceHead，promSellPriceHead 改变promBuyPriceBody，promSellPriceBody,并计算降价幅度，和净毛利
	$(".promBuyPriceHead").die("change").live("change",function(){
		//top.grid_layer_open();
		var isOff=$(this).hasClass("Black")
		if(!isOff){
		var promType = $("#promType").val();
		var child = $(this).attr("child");
		var promBuyPriceHeadVal = $(this).val();
		if(promBuyPriceHeadVal==null || promBuyPriceHeadVal == "" || Number(promBuyPriceHeadVal) <= 0){$(this).val("");top.grid_layer_close();return;}
		if(promType==1 || promType==2){
		var buyBegin = $("#buyBegin").val();
		//var ItemNo = $(".pro_store_items").find(".item_on").attr("itemnovalue");
		if(checkPromEnd()){
				if(buyBegin == 0){
					 
					var divObject =$(".pro_store_items").find("div.item_on");
					var unitType = divObject.attr("unittype");
					var unitNo =divObject.attr("unitnovalue");
					var catlgId = $("#CatlgId").val();
					var itemNoStr ="";
					for (var w = 0; w < ItemsStoreArray.length; w++) {
					 	var itemsStoreJson = ItemsStoreArray[w];
					 	var jsonUnitNo = itemsStoreJson.unitNo;
					 	var jsonUnitType = itemsStoreJson.unitType;
					 	var jsonCatlgId = itemsStoreJson.catlgId;
					 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
					 		var storeArray = itemsStoreJson.storeArray;
					 		for (var g = 0; g < storeArray.length; g++) {
					 			var store = storeArray[g];
					 			itemNoStr += store.itemNo+",";
					 		}
					 	}
					  }
				   var itemNoArray = itemNoStr.substring(0,itemNoStr.length-1).split(",");
				   var itemNoArrayQuChong = itemNoArray.unique();
				  
					if(checkPromIsInOrder(1,0,0,itemNoArrayQuChong,0)){
						var isPass = true;
						var isPass2= true;
						var isRight1 = true;
						var isRight2 = true;                                                                                                                                                                                                                                                                                                                                                 
						var isPass3 = 0;
						if(!isMoney4(promBuyPriceHeadVal))
				  		{
							top.jAlert('warning', '促销进价必须是不能超过四位小数的数字!', '提示消息');
							$(this).val('');
							isPass =false;
							//top.grid_layer_close();
				  			return false;
				  	    }
						if($(this).attr("name")=="unit"){
							$("input.promBuyPriceHead[child=1]").val(promBuyPriceHeadVal);
						}else{
							var ut =$("#ArtPromoCodeDiv").find("div.item_on").find("select.unitTypeChange").val();
							if(ut == 0){
								$("#ArtPromoCodeDiv").find("div.item_on").find("input.promBuyPriceHead[name=unit]").val(promBuyPriceHeadVal);
							}
						}
						
						$(".promBuyPriceBody").each(function(){
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
										isPass=false;
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
			  	    					isPass2=false;
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
						 if(!isPass || isPass3 ==1 || !isRight1){
				  	    	top.jAlert('warning', '促销进价不能大于买价限制!', '提示消息');
				  	    }
				  	    
				  	     if(!isPass2 || isPass3 == 2 || !isRight2){
				  	    	top.jAlert('warning', '促销进价必须小于正常进价!', '提示消息');
				  	    }
				  	    
				  	    if(!isPass || !isPass2 || isPass3 != 0 || !isRight1 || !isRight2){
				  	      $("input.promBuyPriceHead[child=1]").val("");
				  	       $("#ArtPromoCodeDiv").find("div.item_on").find("input.promBuyPriceHead[name=unit]").val("");
					     /* $("input.promBuyPriceHead[name=unit]").val("");*/
				  	    }
					}else{
						$(this).val("");
						top.jAlert('warning', '已经有没有作废的订单使用该促销期数!', '提示消息');
					}
	  	    }else{
	  	    		$(this).val("");
					top.jAlert('warning', '进价促销已经开始，不能修改促销进价!', '提示消息');
				}
			}else{
				$(this).val("");
				top.jAlert('warning', '促销已经结束，不能修改促销进价!', '提示消息');
			
			}
		}else{
			$(this).val("");
		}
		
		}
		
		//top.grid_layer_close();
	});
	
	$(".promSellPriceHead").die("change").live("change",function(){
		//top.grid_layer_open();
		var isOff=$(this).hasClass("Black")
		if(!isOff){
			var promType = $("#promType").val();
			var child = $(this).attr("child");
			var promSellPriceHeadVal = $(this).val();
			if(promSellPriceHeadVal==null || promSellPriceHeadVal == "" || Number(promSellPriceHeadVal) <= 0){$(this).val("");top.grid_layer_close();return;}
			var selectItemOnDiv =   $(this).parents("div").hasClass("item_on");
			if(child == 1){
				selectItemOnDiv=true;
			}
			if(selectItemOnDiv){
				if(promType==1 || promType==3){
					var sellBegin = $("#sellBegin").val();
					if(checkPromEnd()){
						if(sellBegin==0){
							var isPass = true;
							var isRight = true;
							var isPass1 =true;
							if(!isMoney2(promSellPriceHeadVal))
					  		{
								top.jAlert('warning', '促销售价必须是不能超过两位小数的数字!', '提示消息');
								$(this).val('');
								isPass =false;
								top.grid_layer_close();
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
							var priceCut = "";
						    var netMaori = "";
						    var promsellPrice = $(this).val();
							var promSellPriceHeadVal1;
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
						
						if(!isRight || !isPass){
							$("input.promSellPriceHead[child=1]").val("");
							 $("#ArtPromoCodeDiv").find("div.item_on").find("input.promSellPriceHead[name=unit]").val("");
							//$("input.promSellPriceHead[name=unit]").val("");
						}
					}else{
						$(this).val($("#oldPromSellPrice").val());
						top.jAlert('warning', '售价促销已经开始，不能修改促销售价!', '提示消息');
					}
				}else{
					$(this).val($("#oldPromSellPrice").val());
					top.jAlert('warning', '促销已经结束，不能修改促销售价!', '提示消息');
					
				}
			}else{
				$(this).val($("#oldPromSellPrice").val());
			}
		}else{
			return false;
		}
	}
	//top.grid_layer_close();
});
	$(".promSellPriceBody").die("blur").live("blur",function(){
		var isOff=$(this).hasClass("Black")
		if(!isOff){
			var sellBegin = $("#sellBegin").val();
			if(checkPromEnd()){
				if(sellBegin == 0){
					var promSellPrice = $(this).val();
					var normSellPrice = $(this).parents("tr").find("input.normSellPrice").val();
					var netCost = $(this).parents("tr").find("input[id='netCost']").val();
					var vat = $(this).parents("tr").find("input[id='vat']").val();
					var isPass = true;
					if(promSellPrice==""){
						$(this).val("");
						promSellPrice ="";
						$(this).removeClass("errorInput").addClass("errorInput");
						isPass =false;
					}
					
					if(!isMoney2(promSellPrice))
			  		{
						top.jAlert('warning', '输入的数据不符合规则，促销售价最多保留两位小数!', '提示消息');
						$(this).removeClass("errorInput").addClass("errorInput");
						$(this).val('');
						isPass =false;
			  	    }else{
			  	    	
			  	    	if(promSellPrice > (normSellPrice*0.95)){
							top.jAlert('warning', '促销售价必须小于等于正常售价*0.95!', '提示消息');
							$(this).removeClass("errorInput").addClass("errorInput");
							$(this).val('');
							isPass =false;
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
					 				storeJson.sellVat = vat;
					 				storeJson.priceCut=priceCut;
					 				storeJson.netMaori = netMaori;
					 			}
					 			storeArray[j]=storeJson;
					 		}
					 		ItemsStoreArray[i].storeArray = storeArray;
					 	}
					 }
				}else{
					top.jAlert('warning', '售价促销已经开始，不能修改促销售价!', '提示消息');
				}
			}else{
				top.jAlert('warning', '促销已经结束，不能修改促销售价!', '提示消息');
			
			}
		}
	});
	
	//促销进价
	$(".promBuyPriceBody").die("blur").live("blur",function(){
		var isOff=$(this).hasClass("Black")
		if(!isOff){
		var buyBegin = $("#buyBegin").val();
		var promBuyPrice = $(this).val();
		var id = $(this).parents("tr").attr("id");
		var ItemNo = $("input[deleteid="+id+"]").attr("itemnoval");
		var storeNo = $("input[deleteid="+id+"]").attr("name");
		if(checkPromEnd()){
			if(buyBegin == 0){
				if(checkPromIsInOrder(1,0,0,ItemNo,storeNo)){
					//var isPass = true;
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
					if(promBuyPrice==""){
						$(this).val("");
						promBuyPrice ="";
						$(this).removeClass("errorInput").addClass("errorInput");
					}
					
					if(!isMoney4(promBuyPrice))
			  		{
						top.jAlert('warning', '促销进价必须是不能超过四位小数的数字!', '提示消息');
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
				}else{
					top.jAlert('warning', '已经有没有作废的订单使用该促销期数!', '提示消息');
					$(this).val($("#oldPromBuyPrice").val());
				}
			}else{
				top.jAlert('warning', '促销已经开始，不能修改促销进价!', '提示消息');
				$(this).val($("#oldPromBuyPrice").val());
			}
		}else{
			top.jAlert('warning', '促销已经结束，不能修改促销进价!', '提示消息');
			$(this).val($("#oldPromBuyPrice").val());
		
		}
		}
	});
	
	function setupEvent(){
	 	$.ajaxSetup({
			beforeSend:function(){
				if(this.dataType!='script'){
					log('beforeSend');
					log(this);
					try{
						top.grid_layer_open();
					}catch(e){
					}
				}
		}});
	}
	
	function ignoreSetupEvent(){
	 	$.ajaxSetup({beforeSend:""});
	}
	
	//检查当前是否有没有作废的订单订单已经使用该促销期数
	 function checkPromIsInOrder(flag,startDate,endDate,itemNoStr,storeNoStr){
	 	var promNo = $("#promNo").val();
	 	var returnType = false;
	 	$.ajax({
	 		 async : false,
	 		 beforeSend: function(){},
			 url: ctx + '/prom/nondm/art/checkPromIsInOrder?promNo='+promNo+'&flag='+flag+'&startDate='+startDate+'&endDate='+endDate+'&itemNo='+itemNoStr+'&storeNo='+storeNoStr+'&ti='+(new Date()).getTime(),
		     type: "post",
		     success: function(result) {
		        if(result.inOrder == '0'){
		        	returnType = true;
		        }
		     }
	    });
	    return returnType;
	 }
	 
	 //保存信息的方法
    $("#Tools2").live("click",function(){
    	top.grid_layer_open();
    	var subjName=$("#subjName").val();
		var promBeginDate=$("#promTimeStart").val();
		var promEndDate=$("#promTimeEnd").val();
		var buyBeginDate=$("#buyTimeStart").val();
	    var buyEndDate=$("#buyTimeEnd").val();
	    var catlgId=$("#CatlgId").val();
	    var pricePromType=$("#promType").val();
	    var promNo = $("#promNo").val();
	    var promSubjId =$("#promSubjNo").val();
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
	    /*if($.trim(subjName)==''){
			   $("#subjName").removeClass('errorInput').addClass(
				'errorInput');
			   $("#subjName").attr("title",'请输入主题!');
		       error++;
		 }
    	if($.trim(catlgId)==''){
    		$("#CatlgId").removeClass("errorInput").addClass(
				'errorInput');
			$("#CatlgId").attr("title",'请选择课别!');
    		error++;
     	}*/
	    
	    if(!checkTime(promBeginDate,promEndDate,buyBeginDate,buyEndDate,"")){
    		error++;
	    }
	    
	    if(buyBeginDate != "" && buyEndDate !="" && buyEndDate !=null && buyBeginDate !=null){
  			if(!checkPromIsInOrder(0,buyBeginDate,buyEndDate,0,0)){
  				top.jAlert('warning', "该促销期数已经有订单在使用，并且改订单的订货日期或者预定收货日期不在修改的范围内", '提示消息');
  				$("#buyTimeStart").removeClass("errorInput").addClass("errorInput");
	    		$("#buyTimeEnd").removeClass("errorInput").addClass("errorInput");
  				error++;
  			}
	  	}
	  	
	    if(ItemsStoreArray.length < 1){
	 		top.jAlert('warning', '请选择代号信息！', '提示消息');
	 		error++;
	 	}
	 	if(!checkItemStoreDate()){
	 		error++;
	 	}
	    //if(checkTime(promBeginDate,promEndDate,buyBeginDate,buyEndDate)&&checkSbjCatlg(subjName,catlgId)&&checkItemStoreDate()){
	    if(error>0)
		{
			top.grid_layer_close();
			return;
		}else{
	    	var comma = "--";
	    	var bracket_left = "{";
	    	var bracket_right = "}";
	
	    	var promSchedule= bracket_left+'"catlgId":\"' + catlgId + '\",'+'"buyBeginDate":\"'+buyBeginDate+'\",'+'"buyEndDate":\"'+buyEndDate+'\",'+
				 '"promBeginDate":\"'+promBeginDate+'\",'+ '"promEndDate":\"'+promEndDate+'\",'+'"pricePromType":\"'+pricePromType+'\",'+'"promNo":\"'+promNo+'\"'+bracket_right;
	    	var subject=bracket_left+'"subjName":"' + subjName + '","promSubjId":"'+promSubjId+'"'+bracket_right;
	    	var promUnitSt=[];
		    var promItem=[];
		    
	    	for (var i = 0; i < ItemsStoreArray.length; i++) {
	    		var json=ItemsStoreArray[i];
	    		//promUnitSt.push(bracket_left+'"unitType":"' + json.unitType + '",'+'"promUnitNo":"' + json.unitNo + '",'+'"catlgId":"' + catlgId + '",'+'"promActvy":"'+json.promActvy+'",'+'"promGiftHint":"'+json.pmGiftHint+'",'+'"memo":"'+json.memo+'","promSubjId":"'+promSubjId+'"'+bracket_right);
	    		promUnitSt.push(bracket_left+'"unitType":"' + json.unitType + '",'+'"promUnitNo":"' + json.unitNo + '",'+'"catlgId":"' + catlgId + '","promSubjId":"'+promSubjId+'"'+bracket_right);
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
					   '"normBuyPrice":"' + itemJson.normBuyPrice + '",'+'"normSellPrice":"' + itemJson.normSellPrice + '",'+'"promBuyPrice":"' + itemJson.promBuyPrice + '",'+'"promSellPrice":"' + itemJson.promSellPrice + '","promSubjId":"'+promSubjId+'"'+bracket_right;
					   promItem.push(itemStr);
		    			  
		    			  
	    		}
	    	}
	    	top.grid_layer_close();
	    	$.ajax({
	    		 /*async : false,*/
/*	    		beforeSend:function(){
					top.grid_layer_open();
					},
					complete:function(XMLHttpRequest,textStatus){
						top.grid_layer_close();
					},*/
				 url: ctx + '/prom/nondm/art/updateARTInfo?ti='+(new Date()).getTime(),
			     type: "post",
			     data : {'promSchedule':promSchedule,'subject':subject,'promUnitSt':promUnitSt.join(comma),'promItem':promItem.join(comma)},
			     success: function(result) {
			     	if(result.error != null && result.error=="1"){
			     			 top.jAlert('warning', result.message, '提示消息');
			     	}else{
				        top.jAlert('success', result.message, '提示消息'/*,function(){
			        		window.location.href=ctx + '/prom/nondm/art/ARTPromo';
			       		 }*/);
			     	}
			     }
	    	});
    	
    	}
    });
    
    
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
	  
	function checkChangeTime(){
		var sType = $(this).attr("sType");
		var ttype = $(this).attr("ttype");
		var promBeginDate=$("#promTimeStart").val();
	    var promEndDate=$("#promTimeEnd").val();
	    var buyBeginDate=$("#buyTimeStart").val();
	  	var buyEndDate=$("#buyTimeEnd").val();
	  	var oldBuyBegin = $("#oldBuyBegin").val();
	  	var oldBuyEnd = $("#oldBuyEnd").val();
    	var oldSellBegin = $("#oldSellBegin").val();
    	var oldSellEnd = $("#oldSellEnd").val();
	  	var flag = true;
	  	 if(!checkUnitListIsEmpty()){
		 	 flag = refreshArray(buyBeginDate,buyEndDate,promBeginDate,promEndDate);
		 }else{
		 	$("#oldBuyBegin").val(buyBeginDate);
		 	$("#oldBuyEnd").val(buyEndDate);
		 	$("#oldSellBegin").val(promBeginDate);
		 	$("#oldSellEnd").val(promEndDate);
		 }
		
		 if(flag){
	  		checkTime(promBeginDate,promEndDate,buyBeginDate,buyEndDate,sType);
		  	if(ttype=="buy"){
		  		if(buyBeginDate != "" && buyEndDate !="" && buyEndDate !=null && buyBeginDate !=null){
		  			if(!checkPromIsInOrder(0,buyBeginDate,buyEndDate,0,0)){
		  				if(sType == "buystart"){
		  					top.jAlert('warning', "已有订单使用该促销期数，且采购开始时间不能大于预定收货日期", '提示消息');
		  					$("#buyTimeStart").val(oldBuyBegin);
		  				}
		  				if(sType == "buyend"){
		  					top.jAlert('warning', "已有订单使用该促销，且采购结束日期不能小于预定收货日期", '提示消息');
		  					$("#buyTimeEnd").val(oldBuyEnd);
		  				}
		  			}
			  	}
		  	
		  	}
		  	
		  	
		 }
    }
    function checkTimeNoAjax(){
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
			  //$("#promEndDate").focus();
    		  return false;
    	}else if(promBeginDate==''&&promEndDate!=''){
		      //top.jAlert('warning', '请输入促销开始时间！', '提示消息');
		      $("#promTimeStart").addClass("errorInput");
			  $("#promTimeStart").attr("title","请输入促销开始时间！");
			  //$("#promBeginDate").focus();
		      return false;
		}else if(buyBeginDate!=''&&buyEndDate==''){
 		      $("#buyTimeEnd").addClass("errorInput");
			  $("#buyTimeEnd").attr("title","请输入采购结束时间！");
			  //$("#buyEndDate").focus();
 		      return false;
 		}else if(buyBeginDate==''&&buyEndDate!=''){
		      //top.jAlert('warning', '请输入采购开始时间！', '提示消息');
		      $("#buyTimeStart").addClass("errorInput");
			  $("#buyTimeStart").attr("title","请输入采购开始时间！");
			  //$("#buyBeginDate").focus();
		      return false;
		 }else{
		 	return true;
		 }
    }
    function checkTime(promBeginDate,promEndDate,buyBeginDate,buyEndDate,sType){
    	if(sType=="" || sType ==null){
    		sType=0;
    	}
    	var isbegin=$("#buyBegin").val(); 
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
			  //$("#promEndDate").focus();
    		  return false;
    	}else if(promBeginDate==''&&promEndDate!=''){
		      //top.jAlert('warning', '请输入促销开始时间！', '提示消息');
		      $("#promTimeStart").addClass("errorInput");
			  $("#promTimeStart").attr("title","请输入促销开始时间！");
			  //$("#promBeginDate").focus();
		      return false;
		}else if(buyBeginDate!=''&&buyEndDate==''){
 		      $("#buyTimeEnd").addClass("errorInput");
			  $("#buyTimeEnd").attr("title","请输入采购结束时间！");
			  //$("#buyEndDate").focus();
 		      return false;
 		}else if(buyBeginDate==''&&buyEndDate!=''){
		      //top.jAlert('warning', '请输入采购开始时间！', '提示消息');
		      $("#buyTimeStart").addClass("errorInput");
			  $("#buyTimeStart").attr("title","请输入采购开始时间！");
			  //$("#buyBeginDate").focus();
		      return false;
		 }
		
    	  var flag=true;
    	  $.ajax({
    		    async:false,
		    	url: ctx + '/prom/nondm/art/checkTime?flag=update&isbegin='+isbegin+'&sType='+sType+'&buyDateStart='+buyBeginDate+'&buyDateEnd='+buyEndDate+'&promDateStart='+promBeginDate+'&promDateEnd='+promEndDate+'&ti='+(new Date()).getTime(),
				type: "post",
				dataType:"json",
				success: function(result) {
				    if(result.message!=null && result.message !="success"){
				    	//top.jAlert('warning', result.message, '提示消息');
				    	if(result.key=='1'){
				    		$("#buyTimeStart").addClass("errorInput");
							$("#buyTimeStart").attr("title",result.message);
							//$("#buyBeginDate").focus();
				    	}
				    	if(result.key=='2'){
				    		$("#buyTimeEnd").addClass("errorInput");
							$("#buyTimeEnd").attr("title",result.message);
							//$("#buyEndDate").focus();
				    	}
				    	if(result.key=='3'){
				    		$("#promTimeStart").addClass("errorInput");
							$("#promTimeStart").attr("title",result.message);
							//$("#promBeginDate").focus();
				    	}if(result.key=='4'){
				    		$("#promTimeEnd").addClass("errorInput");
							$("#promTimeEnd").attr("title",result.message);
							//$("#promEndDate").focus();
				    	}
				    	
				    	flag=false;
				    }    	
				}
		    });
    	  return flag;
  	}
    /*
     * 检查传入的2笔“商品/门店”数据是否一致，匹配的逻辑为@unitNo + @itemNo + @storeNo这个组合相等。
     */
  	function checkIsTwoItemStoreEntryMatched(/*Map*/existItemStoreEntry, /*Map*/newItemStoreEntry){
  		if (existItemStoreEntry.unitNo != newItemStoreEntry.promUnitNo) return false;
  		if (existItemStoreEntry.itemNo != newItemStoreEntry.itemNo) return false;
  		if (existItemStoreEntry.storeNo != newItemStoreEntry.storeNo) return false;
  		return true;
  	}
  	//刷新状态
	 function refreshArray(buyts,buyte,promts,promte){
	 	var flag  = true;
	 	top.jConfirm("所有代号要进行重新验证，可能需要等待较长时间，确定要修改时间吗？", '提示消息',function(ret){
	 		if(ret){
		 		var unitItemStoreEntries2CheckOnRefresh = new Array();//表示"代号+商品+门店"的映射关系,用于在变更"采购日期"之后的待检查参数;
		 		var promPriceType = $("#promType").val();
		 		var promNo = $("#promNo").val();
		 		var selectedUnitNo = $("#ArtPromoCodeDiv").find(".item_on").find("input[id='unitNo']").val();
		 		var refreshType = $("#ArtPromoCodeDiv").find(".item_on").find("select[id='unitType']").val();
		 		var refreshCatlgId = $("#CatlgId").val();
			 	//移除之前的老数据
				 for (var i = 0; i < ItemsStoreArray.length; i++) {
				 	var itemsStoreJson = ItemsStoreArray[i];
				 	 storeArray = itemsStoreJson.storeArray;
				 	for (var j = 0; j < storeArray.length; j++) {
				 		var storeJson = storeArray[j];
				 		var itemNo = storeJson.itemNo;
				 		var storeNo = storeJson.storeNo;
				 		var unitNo = storeJson.unitNo;
				 		unitItemStoreEntries2CheckOnRefresh.push(unitNo+"@"+itemNo+"-"+storeNo);
				    }
				 }
			 	$.ajax({
				    async:false,
			    	url: ctx + '/prom/nondm/art/refreshArray?refreshArray='+unitItemStoreEntries2CheckOnRefresh+'&buyStartDate='+buyts+'&buyEndDate='+buyte+'&promStartDate='+promts+'&promEndDate='+promte+'&promNo='+promNo+'&ti='+(new Date()).getTime(),
					type: "post",
					dataType:"json",
					success: function(result) {
						return;
						if(!result || !result.itemStoreList || result.itemStoreList.length<=0) return;
						 $(".pro_store_items").html("");
						 $("#shopBodyTable").html("");
	 		 		     $("#shopHeadTable").html("");
	 		 		     var isred = 0;
	 			 		var refreshItemNoArray =new Array();
	 			 		var refrashStoreNoArray = new Array();
						var newUnitItemStoreEntryList = result.itemStoreList;//所有代号下的“商品列表 * 门店列表”的线性表。
						var specItemStoreList2show = [];
						     for (var promUnitRowIndex = 0; promUnitRowIndex < ItemsStoreArray.length; promUnitRowIndex++) {//第一个循环：对原有的“代号列表”数据进行遍历；
							 	//var itemsStoreJson = ItemsStoreArray[promUnitRowIndex];//当前在循环中的“代号”数据;
							 	var currPromUnitRowData = ItemsStoreArray[promUnitRowIndex];//当前在循环中的“代号”数据;
							 	var itemstoreArrays = new Array();
							 	//2.接下来，对下挂在当前代号下的“商品*门店的笛卡儿积”进行遍历；
							 	for (var itemStoreMixinRowIndex = 0; itemStoreMixinRowIndex < currPromUnitRowData.storeArray.length; itemStoreMixinRowIndex++) {
							 		var oneItemStoreEntry = currPromUnitRowData.storeArray[itemStoreMixinRowIndex];
							 		
				 					var jsonUnitType = oneItemStoreEntry.unitType;
				 					var jsonUnitNo = oneItemStoreEntry.unitNo;
				 					var promBuyPrice = oneItemStoreEntry.promBuyPrice;
				 					var promSellPrice = oneItemStoreEntry.promSellPrice;
				 					
				 					for (var g = 0; g < newUnitItemStoreEntryList.length; g++) {
								 		var oneNewItemStoreEntry = newUnitItemStoreEntryList[g];
								 		
								 		if (!checkIsTwoItemStoreEntryMatched(oneItemStoreEntry, oneNewItemStoreEntry))
								 			continue;
								 		var unitNo = oneNewItemStoreData.promUnitNo;
								 		//if(jsonUnitNo == unitNo){
								 			var storeJson = {};
								 			storeJson["promSupNo"] = oneNewItemStoreData.stMainSupNo;
								 			storeJson["mainComName"] = oneNewItemStoreData.mainComName;
								 			storeJson["status"] = oneNewItemStoreData.status;
								 			storeJson["basicStatus"] = oneNewItemStoreData.basicStatus;
								 			storeJson["statusName"] = oneNewItemStoreData.itemStatusName;
								 			storeJson["storeNo"] = oneNewItemStoreData.storeNo;
								 			storeJson["storeName"] = oneNewItemStoreData.storeName;
								 			storeJson["itemNo"] = oneNewItemStoreData.itemNo;
								 			storeJson["unitType"] = jsonUnitType;
								 			storeJson.unitNo = unitNo;
								 			storeJson.normBuyPrice = oneNewItemStoreData.normBuyPrice;
								 			storeJson.normSellPrice = oneNewItemStoreData.normSellPrice;
								 			storeJson.promBuyPrice = promBuyPrice;
								 			storeJson.promSellPrice = promSellPrice;
								 			storeJson.netCost = oneNewItemStoreData.netCost;
								 			storeJson.sellVat = oneNewItemStoreData.vatVal;
								 			storeJson.itemName = oneNewItemStoreData.itemName;
								 			storeJson.priceCut = '';
								 			storeJson.netMaori = '';
								 			storeJson.buyPriceLimit = oneNewItemStoreData.buyPriceLimit;
								 			storeJson.buyWhen = oneNewItemStoreData.buyWhen;
								 			storeJson.appendBuy = oneNewItemStoreData.appendBuy;
								 			storeJson.appendProm = oneNewItemStoreData.appendProm;
								 			storeJson.existPromNo = oneNewItemStoreData.promNo;
								 			
								 			itemstoreArrays.push(storeJson);
								 		//}
								 		
								 		if(selectedUnitNo == unitNo){
								 			if(oneNewItemStoreData.promNo !=null && oneNewItemStoreData.promNo != ""){
								 				isred = 1;
								 			}
								 			var refrashStoreJson = {};
								 			refrashStoreJson.promSupNo = oneNewItemStoreData.stMainSupNo;
								 			refrashStoreJson.mainComName = oneNewItemStoreData.mainComName;
								 			refrashStoreJson.status = oneNewItemStoreData.status;
								 			refrashStoreJson.basicStatus = oneNewItemStoreData.basicStatus;
								 			refrashStoreJson.statusName = oneNewItemStoreData.itemStatusName;
								 			refrashStoreJson.storeNo = oneNewItemStoreData.storeNo;
								 			refrashStoreJson.storeName = oneNewItemStoreData.storeName;
								 			refrashStoreJson.itemNo = oneNewItemStoreData.itemNo;
								 			refrashStoreJson.unitType = refreshType;
								 			refrashStoreJson.unitNo = unitNo;
								 			refrashStoreJson.normBuyPrice = oneNewItemStoreData.normBuyPrice;
								 			refrashStoreJson.normSellPrice = oneNewItemStoreData.normSellPrice;
								 			refrashStoreJson.promBuyPrice = promBuyPrice;
								 			refrashStoreJson.promSellPrice = promSellPrice;
								 			refrashStoreJson.netCost = oneNewItemStoreData.netCost;
								 			refrashStoreJson.sellVat = oneNewItemStoreData.vatVal;
								 			refrashStoreJson.itemName = oneNewItemStoreData.itemName;
								 			refrashStoreJson.priceCut = "";
								 			refrashStoreJson.netMaori = "";
								 			refrashStoreJson.buyPriceLimit = oneNewItemStoreData.buyPriceLimit;
								 			refrashStoreJson.buyWhen = oneNewItemStoreData.buyWhen;
								 			refrashStoreJson.appendBuy = oneNewItemStoreData.appendBuy;
								 			refrashStoreJson.appendProm = oneNewItemStoreData.appendProm;
								 			refrashStoreJson.existPromNo = oneNewItemStoreData.promNo;
								 			
								 			refreshItemNoArray.push(oneNewItemStoreData.itemNo+"@"+oneNewItemStoreData.itemName+"@"+refreshType);
								 			refrashStoreNoArray.push(refrashStoreJson);
								 		}
								 		
								 	}
							 	}
								 	
							 	if(itemstoreArrays.length > 0){//重新将对当前代号合并后的数据放回数据结构中。
							 		currPromUnitRowData.storeArray=itemstoreArrays;	
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
		 		 				
		 		 				
		 		 				var refrashStoreNoArraySort = refrashStoreNoArray.sort(
							 		function(a,b){  //自定义函数排序  
									    var a1= parseInt(a.storeNo);  
									    var b1= parseInt(b.storeNo);  
									    if(a1<b1){return -1;}else if(a1>b1){return 1;}  
									    return 0;
							 		}
						 		);
		 		 				for (var h = 0; h < refrashStoreNoArraySort.length; h++) {
		 		 					var store = refrashStoreNoArraySort[h];
					    			//显示门店信息
				        			if(firstItemNo == store.itemNo){
				        				var num = parseInt(Math.random()*100000);
				        				appendShopBodyTable(store,num,reUnitType,refreshUnitNo,refreshCatlgId);
					        			appendShopHeadTable(store,num,reUnitType,refreshUnitNo,refreshCatlgId);
				        			}
		 		 				}
			        		}
			        		
			        		changeInputByPromPriceType(promPriceType);
			        		
			        		
			        		
			        		/*//将警示颜色去掉
			        		$("tr.trBgRed").removeClass("trBgRed");
			        		$("div.bgColorRed").removeClass("bgColorRed");*/
			        		$("input.promBuyPriceHead").val("");
							$("input.promSellPriceHead").val("");
							
						}
		        		
					
			    });
			    flag = true;
	 		}else{
	 			var oldBuyBegin = $("#oldBuyBegin").val();
	  			var oldBuyEnd = $("#oldBuyEnd").val();
    			var oldSellBegin = $("#oldSellBegin").val();
    			var oldSellEnd = $("#oldSellEnd").val();
	 			$("#promTimeStart").val(oldSellBegin);
			    $("#promTimeEnd").val(oldSellEnd);
			    $("#buyTimeStart").val(oldBuyBegin);
			  	$("#buyTimeEnd").val(oldBuyEnd);
			  	$("#promTimeEnd").removeClass("errorInput");
			  	$("#promTimeStart").removeClass("errorInput");
			  	$("#buyTimeEnd").removeClass("errorInput");
			  	$("#buyTimeStart").removeClass("errorInput");
	 			flag = false;
	 		}
	 	});
	 	
		return flag;
	 }
  	//判断用户是否选择了代号并初始化了数据
  	//当unitno不为空的时候，检查的是当前unitno下的数据有没有未填写的项目
  	//当unitno为空的时候，检查的是整个json中的数据有没有未填写的项目
	 function checkItemStoreDateBy(){
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
						 			var itemNo = storeJson.itemNo;
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
						 			if(promType == 1 || promType==2){
						 				if(appendBuy == 1){
						 					//message = "代号"+jsonUnitNo+",商品货号"+itemNo+"-"+itemName+"商品，店号为"+storeNo+"-"+storeName+"的门店，已经参加了期数为"+promNo+"的促销活动，请核实信息！";
						 					//top.jAlert('warning', message, '提示消息');
						 					//checkHaveOtherStoreProm(itemNo,storeNo);
						 					top.jAlert('warning', "请确认门店信息无误，再进行下一步操作！", '提示消息');
						 					return false;
						 				}
						 				if(promType ==1){
						 					if(5<Number(basicStatus) && Number(basicStatus)<9){
						 						isBlack = false;
						 					}
						 				}
						 				
						 				if(isBlack)
								 			if(storeJson.promBuyPrice==null || storeJson.promBuyPrice ==""){
								 				var message = "代号"+jsonUnitNo+",商品货号"+itemNo+"，促销进价不能为空";
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
						 					//message = "代号"+jsonUnitNo+",商品货号"+itemNo+"-"+itemName+"商品，店号为"+storeNo+"-"+storeName+"的门店，已经参加了期数为"+promNo+"的促销活动，请核实信息！";
						 					//top.jAlert('warning', message, '提示消息');
						 					//checkHaveOtherStoreProm(itemNo,storeNo);
						 					top.jAlert('warning', "请确认门店信息无误，再进行下一步操作！", '提示消息');
						 					return false;
					 					}
							 			if(storeJson.promSellPrice==null || storeJson.promSellPrice ==""){
							 				var message ="代号"+jsonUnitNo+",商品货号"+itemNo+"，促销售价不能为空";
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
					 	}
					 }
			 	}
			}
			return true;
		}
	 
	  //判断用户是否选择了代号并初始化了数据
	 function checkItemStoreDate(){
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
			 			if(promType == 1 || promType==2){
			 				// 判断当前代号的商品是否在其他的促销期数中
			 				if(appendBuy == 1){
			 					//message = "代号"+jsonUnitNo+",商品货号"+itemNo+"-"+itemName+"商品，店号为"+storeNo+"-"+storeName+"的门店，已经参加了期数为"+promNo+"的促销活动，请核实信息！";
			 					//top.jAlert('warning', message, '提示消息');
			 					//checkHaveOtherStoreProm(itemNo,storeNo);
			 					top.jAlert('warning', "请确认门店信息无误，再进行下一步操作！", '提示消息');
			 					return false;
			 				}
			 				if(promType==1){
			 					if(5<Number(basicStatus) && Number(basicStatus)<9){
			 						isBlack = false;
			 					}
			 				}
			 				
			 				if(isBlack){
					 			if(storeJson.promBuyPrice==null || storeJson.promBuyPrice ==""){
					 				var itemNo = storeJson.itemNo;
					 				var message = "代号"+jsonUnitNo+",商品货号"+itemNo+"，促销进价不能为空";
					 				top.jAlert('warning', message+"!", '提示消息');
					 				$(".promBuyPriceBody").each(function(){
							 			if($(this).val()==""&& !$(this).hasClass("Black")){
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
				 				itemNo = storeJson.itemNo;
				 				var message ="代号"+jsonUnitNo+",商品货号"+itemNo+"，促销售价不能为空";
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
	/* function checkItemStoreDate(){
	 	if(ItemsStoreArray.length < 1){
	 		top.jAlert('warning', '请选择代号信息！', '提示消息');
	 		return false;
	 	}else{
	 		 var message = "";
	 		 for (var i = 0; i < ItemsStoreArray.length; i++) {
			 	var itemsStoreJson = ItemsStoreArray[i];
			 	var jsonUnitNo = itemsStoreJson.unitNo;
			 		var storeArray = itemsStoreJson.storeArray;
			 		for (var j = 0; j < storeArray.length; j++) {
			 			var storeJson = storeArray[j];
			 			if(storeJson.promBuyPrice==null || storeJson.promBuyPrice ==""){
			 				message+="代号"+jsonUnitNo+",商品"+storeJson.itemName+"的促销进价不能为空！";
			 				top.jAlert('warning', message, '提示消息');
			 				return false;
			 			}
			 			
			 			if(storeJson.promSellPrice==null || storeJson.promSellPrice ==""){
			 				message+="代号"+jsonUnitNo+",商品"+storeJson.itemName+"的促销售价不能为空！";
			 				top.jAlert('warning', message, '提示消息');
			 				return false;
			 			}
			 		}
			 }
			 	return true;
	 	}
	 }*/
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
	
	
	//促销类型的显示规则
	function getPromoType(){//buyTimeStart//promTimeStart
		
		var timeType = $(this).attr("ttype");
		var buyts = $("#buyTimeStart").val();
		var buyte = $("#buyTimeEnd").val();
		var promts= $("#promTimeStart").val();
		var promte= $("#promTimeEnd").val();
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
		}
		if((timeType =='buy' && (promts!="" || promte!="")) || (timeType =='prom' && (buyts!="" || buyte!=""))){
		    $("#promTypeValue").val("1-进-售价促销");
		    $("#promType").val("1");
		    $(".promSellPriceBody,.promBuyPriceBody,.promSellPriceHead,.promBuyPriceHead").each(function(){
				$(this).removeClass("Black");
				$(this).attr("readonly",false);
			});
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
				return false;
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
	
	 //过滤判断是否已经有该门店和商品了
	 function filterCheckItemNo(/*Array*/pStoreItemArrayIn,/*String*/unitType){
	 	//alert();
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
		 				if(pStoreItemArrayIn.length==1){
		 					return pStoreItemArrayIn;
		 				}else{
		 					for (var w = 0; w < pStoreItemArrayIn.length; w++) {
				 				var obj = pStoreItemArrayIn[w];
				 				var objitemNo = obj.itemNo;
				 				var objunitNo = obj.promUnitNo;
				 				var objunitType = obj.unitType;
				 				if(objitemNo != itemNoJson  && unitNoJson == objunitNo && unitType ==objunitType ){
				 					relist.push(obj);
					 				//relist[relist.length] = obj;
				 				}
			 				}
		 				}
		 				//list = relist;
		 				
		 			}
	 			}
			 }
	 	}else{
	 		return pStoreItemArrayIn;
	 	}
	 	if(relist==null || relist.length<1){
			return pStoreItemArrayIn;
		}else{
			return relist;
		}
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
						/*if(status ==1){
							if(jsonItemNo ==itemNo ){*/
								/*storeJson.promSellPrice=promSellPriceHeadVal1;
					 			storeJson.sellVat = vat;
					 			storeJson.priceCut=priceCut;
					 			storeJson.netMaori = netMaori;
							}
						}else{*/
							storeJson.promSellPrice=promSellPriceHeadVal1;
					 		storeJson.sellVat = vat;
					 		storeJson.priceCut=priceCut;
					 		storeJson.netMaori = netMaori;
						/*}*/
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
		 			var vat = storeJson.sellVat;
		 			//storeJson = {"promSupNo":store.stMainSupNo,"mainComName":store.mainComName,"status":store.status,"basicStatus":store.basicStatus,"statusName":store.itemStatusName,"storeNo":store.storeNo,"storeName":store.storeName,"itemNo":store.itemNo,"unitType":unitType,"unitNo":unitNo,"normBuyPrice":store.normBuyPrice,"normSellPrice":store.normSellPrice,"promBuyPrice":"","promSellPrice":"","netCost":store.netCost,"sellVat":store.vatVal,"itemName":store.itemName,"priceCut":"","netMaori":"","buyPriceLimit":store.buyPriceLimit,"buyWhen":store.buyWhen};
		 			var jsonNormBuyPrice =  storeJson.normBuyPrice;
		 			var jsonPrombuyValue = storeJson.promBuyPrice;
		 			var buyWhen = storeJson.buyWhen;
		 			var buyPriceLimit = storeJson.buyPriceLimit
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
						/*if(status ==1){
							if(jsonItemNo ==itemNo ){*/
								storeJson.promBuyPrice = promBuyPriceHeadVal1;
							/*}
						}else{
							storeJson.promBuyPrice = promBuyPriceHeadVal1;
						}*/
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
	
	
	function appendShopBodyTable(storeJson,num,unitType,unitNo,catlgId,flag){
		var shopBodyTable = $("#oneShopBodyTable");

  		var status;
  		var promSupNo;
  		var promBuyPrice = "";
		var promSellPrice = "";
		var priceCut="";
		var netMaori="";
  		if(storeJson.statusName !=undefined){
  			status = storeJson.statusName;
  			promBuyPrice = storeJson.promBuyPrice;
  			promSellPrice =  storeJson.promSellPrice;
  			promSupNo = storeJson.promSupNo;
  			//itemStore.normBuyPrice,"normSellPrice":itemStore.normSellPrice
  			if(promSellPrice !=null && promSellPrice !=""){
	  			priceCut = roundFun ((storeJson.normSellPrice-promSellPrice)/storeJson.normSellPrice*100,2);
				netMaori = roundFun((((Number(promSellPrice)/( 1 + Number(storeJson.sellVat/100)))-Number(storeJson.netCost))/( Number(promSellPrice)/( 1 + Number(storeJson.sellVat/100))))*100,2);
  			}
			//priceCut=storeJson.priceCut;
  			//netMaori=storeJson.netMaori;
  		}else{
  			status = storeJson.itemStatusName;
  			promSupNo = storeJson.stMainSupNo;
  		}
  		
  		shopBodyTable.find("input[id='status']").attr("value",storeJson.status+"-"+status);
  		shopBodyTable.find("input[id='promSupNo']").attr("value",promSupNo);
  		shopBodyTable.find("input[id='promSellPriceBody']").attr("value",promSellPrice);
  		shopBodyTable.find("input[id='promBuyPriceBody']").attr("value",promBuyPrice);
  		shopBodyTable.find("tr").attr("id",num);
  		shopBodyTable.find("input[id='status']").addClass("status").attr("name",storeJson.basicStatus);
  		shopBodyTable.find("input[id='normBuyPrice']").attr("value",storeJson.normBuyPrice);
  		shopBodyTable.find("input[id='oldPromBuyPrice']").attr("value",promBuyPrice);
  		shopBodyTable.find("input[id='oldPromSellPrice']").attr("value",promSellPrice);
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
  		shopBodyTable.find("input[id='oldPromBuyPrice']").attr("value","");
  		shopBodyTable.find("input[id='promBuyPriceBody']").removeClass("promBuyPriceBody").attr("buyPriceLimit","").attr("buyWhen","").attr("value","");
  		shopBodyTable.find("input[id='normSellPrice']").removeClass("normSellPrice").attr("value","");
  		shopBodyTable.find("input[id='oldPromSellPrice']").attr("value","");
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