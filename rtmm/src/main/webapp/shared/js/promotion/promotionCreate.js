/**
 * 屏蔽backspace、F5,F4为刷新 
 */
document.onkeydown = function(e) {
	var e = e || window.event || arguments.callee.caller.arguments[0];
	var d = e.srcElement || e.target;
	if (e.keyCode && e.keyCode == 115) {
		e.keyCode=0;
		e.returnValue=false;
		$('#forwardForm').submit();
		return false;
	}
	if (e.keyCode && e.keyCode == 116) {
		e.keyCode=0;
		return false;
	}
	if (e && e.keyCode == 8) {
		if(d.tagName.toUpperCase() == 'INPUT' && d.readOnly == true){
			return false;
		}else if(d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA'){
			return true;	
		}else{
			return false;
		}
	}
};
$(".Tools1").die("click");
/*屏蔽页面选中复制*/
document.onselectstart = function(e) {
	var e = e || window.event || arguments.callee.caller.arguments[0];
	var d = e.srcElement || e.target;
	if (!((d.tagName == "INPUT" && d.type.toLowerCase() == "text") || d.tagName == "TEXTAREA")) {
		return false;
	}
	return true;
};
//验证主题，可别信息
function checkSubjName(){
	var prevName = $("#subjName").attr('prev');
	var subjName = $("#subjName").val();
 	$("#subjName").removeClass('errorInput');
    $("#subjName").attr("title",'');
 	if($.trim(subjName)==''){
 		$("#subjName").addClass('errorInput');
        $("#subjName").attr("title",'请输入主题!');
 	}else if(charLen($.trim(subjName))>30){
 		$("#subjName").addClass('errorInput');
 		$("#subjName").attr("title",'主题不能超过30个字节!');
 		$("#subjName").val(prevName);
	}
 	$("#subjName").attr('prev',$("#subjName").val());
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
//已存在的系列号
var v_prom_str = "";
var v_store_str = "";
var hasInputflag=false;
var isLoadData = false;
var promMap = new Object();
var existsItemNoStoreNoMap = new Object();    

$(".item").die('click');
$(".pro_store_items .item").die('click').live('click',function(){
	$(this).parent().find(".item_on").removeClass("item_on");
	$(this).addClass("item_on");
});
Array.prototype.remove = function(dx){
	if(isNaN(dx) || dx > this.length){
		return false;
	}
	for(var i=0,n=0; i<this.length; i++){
		if(this[i]!=this[dx]){
			this[n++] = this[i];
		}
	}
};
//促销代号信息
	var promCodeMess = new Array();
	//代号下商品信息
	var promItemMess = new Array();
	//商品下厂商信息
	var itemSupMess = new Array();
	//已删除厂商的信息
	var delSupMess = new Array();
	//已删除代号的信息
	var delCodeMess = new Array();
	//已删除商品的信息
	var delItemMess = new Array();
	//订单使用的门店号
	var storeInOrders = new Array();
	//过滤过的商品
	var filtrationItemNo = new Array();
	//订单日期
	var ordersDateMap = new Array();
	
function nullInputCheck() {
	$('.mustInput:visible').each(function() {
		$(this).blur(function() {
			if ($.trim($(this).val()) == '' && !($(this).hasClass())) {
				$(this).addClass('errorInput');
			}
		});
		$(this).focus(function() {
			$(this).removeClass('errorInput');
		});
	});
}

/** 输入整数值 */
function inputToInputIntNumber(obj) {
	if ($(obj).val()!=''&&!(/^\d{0,8}$/).test($(obj).val())) {
		if($(obj).val()==' '){
			$(obj).val('');
			return false;
		}
		if($(obj).val()!=''){
			$(obj).val($(obj).attr('preval'));
		}
		return true;
	}
	$(obj).attr('preval',$(obj).val());
}

/** form 校验 */
function chkItemInfo() {
	var inputOk = true;
	$('.mustInput:visible').each(function() {
		if ($.trim($(this).val()) == '') {
			if (!($(this).hasClass('errorInput'))) {
				$(this).addClass('errorInput');
			}
			inputOk = false;
		}
	});
	return inputOk;
}

//校验当前促销代号是否输入,输入信息就必须输入促销价格
function checkHasChangeItemValue(){
	if($('#promCodeMess_div .item_on').size==0) return false;
	hasInputflag=false;
	$('#promCodeMess_div .item').each(function(){
		if((($.trim($(this).find('select').val())!="0" ||
				$(this).find('input:last').val()!='') &&
				$(this).find('.promUnitNoClick').val()=='') ||
				($(this).find('.promUnitNoClick').val()=='' && $(this).find('.promBuyPrices').val()!='')||
				($(this).find('.promUnitNoClick').val()!='' && ($('#promItemStoreMess_div .errorInput').size()>0) )
					){
				hasInputflag=true;
				$('#promCodeMess_div .item_on').removeClass('item_on');
				if($(this).find('.promUnitNoClick').val()==''){
					$(this).find('.promUnitNoClick').addClass('errorInput');
				}
				if($(this).find('.promBuyPrices').val()=='' && $('#promItemStoreMess_div .errorInput').size()>0 && $(this).hasClass('item_on')){
					$(this).find('.promBuyPrices').addClass('errorInput');
				}
				$(this).addClass('item_on');
				return;
			}
	});
	return hasInputflag;
}
	
// 增加促销代号信息
function addPromCodeMess(obj) {
	if($.trim($("#catlgId").val())==''){
		top.jAlert('warning', '课别不能为空!', '提示消息');
		return false;
	}
	var subjName = $.trim($("#subjName").val());
	var buyBeginDate = $.trim($("#buyBeginDate").val());
	var buyEndDate = $.trim($("#buyEndDate").val());
	var isError=false;
	if (subjName == "") {
		$("#subjName").addClass("errorInput");
		isError=true;
	}
	if(charLen($.trim(subjName))>30){
 		$("#subjName").addClass('errorInput');
 		$("#subjName").attr("title",'主题不能超过30个字节!');
 		isError=true;
	}
	if ($.trim(buyBeginDate) == "") {
		$("#buyBeginDate").addClass('errorInput');
		isError=true;
	}
	if ($.trim(buyEndDate) == "") {
		$("#buyEndDate").addClass('errorInput');
		isError=true;
	}
	if(isError){
		return;
	}
	
	top.grid_layer_open();
	$.ajaxSetup({async : false});
	if ($(obj).attr("class").indexOf("_off") < 0) {
		var checkMess = $("#promCodeMess_div").find(".item").length;
		var flag = true;
		if(!checkPromItems() || checkHasChangeItemValue() || ($.trim($('#promCodeMess_div:visible .item_on .promUnitNoClick').val())!='' && !checkPromotion())){
			$.ajaxSetup({async : true});
			top.grid_layer_close();
			return false;
		}
		if (checkMess > 0) {
			var pro_store_items = $(".pro_store_items").find(".item").length;
			var promItemStoreMess_div = $("#promItemStoreMess_div").find(".ig");
			if (promItemStoreMess_div.length > 0) {
				$.each(promItemStoreMess_div, function(index, value){
					var promBuyPrice = $.trim($(this).find("input[name='promBuyPrice']").val());
					var normBuyPrice = $.trim($(this).find("input[name='normBuyPrice']").val());
					var buyWhen= $.trim($(this).find("input[name='buyWhen']").val());
					var buyPriceLimit =$.trim($(this).find("input[name='buyPriceLimit']").val());
					if (promBuyPrice != "" ) {
					    if (buyWhen == 2) {
					    		if(buyPriceLimit !="" && (Number(promBuyPrice)>Number(buyPriceLimit))){
									$(this).addClass("errorInput");
									$(this).val("");
									flag = false;
					  	    	}else{
					  	    		$(this).removeClass("errorInput");
					    		}
					   }else{	
						  if (Number(promBuyPrice) > Number(normBuyPrice)) {
							$(this).find("input[name='promBuyPrice']").addClass("errorInput");
							$(this).val("");
							flag = false;
						   }
					   }
					} else {
						$(this).find("input[name='promBuyPrice']").addClass("errorInput");
						flag = false;
					}
				});
			} else {
				flag = false;
			}
		} else {
			
		}
		$("#updatePriceAll").val('');
		$(".pro_store_item .item_on").removeClass("item_on");
		$("#promCodeMess_div").append($("#addPromCode_div").find(".addPromCode_div").clone());
		unSupClickAddItem();
		clearDiv();
	}
	$('#promCodeMess_div .item_on').removeClass('item_on');
	$('#promCodeMess_div .addPromCode_div:last').addClass('item_on');
	$("#promCodeMess_div .item_on")[0].scrollIntoView();
	$.ajaxSetup({async : true});
	top.grid_layer_close();
}

// 增加促销商品门店信息
function addPromItemStoreMess() {
	var promStoreSup_str = convertJsonStr("#promItemStoreMess_div","ig");
	if (promStoreSup_str != "") {
		itemSupMess.push(promStoreSup_str);
	}
}

function addSelectedItemReturn(itemNoArray,itemNameArray){
	var pbpValue = $.trim($("#promCodeMess_div .item_on .promBuyPrices").val());
	var unitNo = $.trim($("#promCodeMess_div .item_on").find(".promUnitNoClick").val());
	var unitType = $.trim($("#promCodeMess_div .item_on").find("select").val());
	var catlgId = $("#catlgId").val();
	if(itemNoArray.length>0)
	{
	supClickAddItem();
	}
	$.each(itemNoArray, function(index, itemNo) {
		$.each(delItemMess,function(ind, val){
			if (val.itemNo == itemNo && val.promUnitNo == unitNo && val.unitType == unitType) {
				delItemMess.remove(ind);
				return false;
			}
		});
		var objElement = setValueForItemInfo(unitType,unitNo,itemNo,itemNameArray[index]);
		$(".pro_store_items").append($(objElement).clone());
		checkOrdersFlag("");
		var storesListStr = storeSupplierMess_json(itemNo,unitNo,catlgId,unitType,itemNameArray[index],pbpValue,"");
		if(index==itemNoArray.length-1){
			$("#promItemStoreMess_div").children().remove();
			var jsonStrArray = storesListStr.split("--");
			$('.pro_store_items .item_on').removeClass('item_on');
			$('.pro_store_items .item:last').addClass('item_on');
			for(var i=0;i<jsonStrArray.length;i++){
				var json = JSON.parse(jsonStrArray[i]);
				setValueForItemStoreInfo(json,itemNameArray[index]);
				$("#promItemStoreMess_div").append($('#itemStoreInfoModel .ig').clone());				
				unShowStoreDom(json.checkOrders);
			}
		}
	});
	top.closePopupWin();
}
// 增加促销所选商品
function addSelectedItem(obj) {
	if ($(obj).attr("class").indexOf("_off") < 0) {
		var unitNo = $.trim($("#promCodeMess_div .item_on").find(".promUnitNoClick").val());
		var unitType = $.trim($("#promCodeMess_div .item_on").find("select").val());
		var catlgId = $("#catlgId").val();
		var itemsValue = "";
		$(".pro_store_items").find(".promItemStoreClick").each(function() {
			itemsValue += $(this).attr("itemNoValue") + ",";
		});
		/*系列添加单品的时候  查找页面代号是单品的商品*/
		$('#promCodeMess_div .addPromCode_div').each(function(){
			if($(this).find('select').val()==0 && $(this).find('.promUnitNoClick').val()!=""){
				itemsValue += $(this).find('.promUnitNoClick').val() + ",";
			}
		});
		var itemsValue = itemsValue.substring(0, itemsValue.length - 1);
		itemsValue = itemsValue + $.trim(filtrationItemNo[unitType+"-"+unitNo]);
		$.each(delItemMess,function(i, item){
			if (item.unitType == unitType && item.promUnitNo == unitNo) {
				$.each(itemSupMess,function(j,store){
					if (store.indexOf('"itemNo":"'+item.itemNo+'"') >= 0) {
						itemsValue = itemsValue + "," + item.itemNo;
						return false;
					}
				});
			}
		});
		top.openPopupWin(420,480,'/prom/nondm/art/showDeleteItemsList?catlgId=' + catlgId+'&unitNo='+unitNo+'&itemsValue='+itemsValue+'&unitType='+unitType);
	}
}

//校验当前促销代号商品信息
function checkPromItems(){
	var v_promBuyPrice_str='';
	var errorStatus = false;
	var unitType = '';
	var promUnitNo = '';
	var itemNo = '';
	var promBuyPrice = '';
	var itemName = '';
	var currUnitType=$('#promCodeMess_div .item_on .selectOnchang').val();
	var currPromUnit=$('#promCodeMess_div .item_on .promUnitNoClick').val();
	$.each(itemSupMess, function(index,value){
		if (value.indexOf('"unitType":"'+currUnitType+'"') >= 0 && value.indexOf('"promUnitNo":"'+currPromUnit+'"') >= 0) {
			var valus = value.split("--");
			$.each(valus, function(idx, json){
				var jsonData = JSON.parse(json); 
				if ($.trim(jsonData.promBuyPrice)=='') {
					unitType = jsonData.unitType;
					promUnitNo = jsonData.promUnitNo;
					itemNo = jsonData.itemNo;
					//promBuyPrice = jsonData.promBuyPrice;
					//itemName = jsonData.itemName;
					if (unitType == 0) {
						v_promBuyPrice_str ="请输入单品："+promUnitNo+"下的促销进价";
					} else {
						v_promBuyPrice_str ="请输入代号"+promUnitNo+"下商品："+itemNo+"的促销进价";
					}
					errorStatus = true;
					return false;
				}
			});
		}
		if (errorStatus) {
			return false;
		}
	});
	var obj=$('#promCodeMess_div .item_on');
	if(errorStatus){
		top.jAlert('warning', v_promBuyPrice_str, '提示消息');
		$('#promCodeMess_div .addPromCode_div').each(function(){
			if($(this).find('select').val()==unitType && $(this).find('.promUnitNoClick').val()==promUnitNo){
				obj = $(this);
				return;
			}
		});
		
		/*$.ajaxSetup({
			async : true
		});
		top.grid_layer_close();*/
		$('.pro_store_items .item_on').removeClass('item_on');
		$('.promItemStoreClick[itemNoValue="'+itemNo+'"]').click();
		$('.promItemStoreClick[itemNoValue="'+itemNo+'"]').parent().addClass('item_on');
		$('#promCodeMess_div .item_on').removeClass('item_on');
		$(obj).addClass('item_on');
		$(obj).find('.promUnitNoClick').focus();
		$('.pro_store_items .item_on')[0].scrollIntoView();
		if($('#promItemStoreMess_div .errorInput').size()>0){
			$('#promItemStoreMess_div').scrollTop(0);
		}
/*		$.ajaxSetup({
			async : false
		});*/
		return false;
	}
	return true;
}

//禁用保存按钮
function disabledTools2(){
	$("#Tools2").attr('class', "Icon-size1 Tools2_disable").unbind("click");
}
//启用保存按钮
function enabledTools2(){
	$("#Tools2").attr('class', "Icon-size1 Tools2").unbind("click").bind("click",saveCreateProm);
}
// 保存创建的促销信息
function saveCreateProm() {
	disabledTools2();
	var promType = $.trim($("#promType").val());
	// 促销期数
	var promNo = $("#promNo").val();
	var promType = $.trim($("#promType").val());
	// 采购期间
	var buyBeginDate = $.trim($("#buyBeginDate").val());
	var buyEndDate = $.trim($("#buyEndDate").val());
	// 主题
	var subjName = $.trim($("#subjName").val());
	// 主题Id
	var promSubjId = $("#promSubjId").val();
	// 课别
	var catlgId = $.trim($("#catlgId").val());
	var isError=false;
	if (subjName == "") {
		$("#subjName").addClass("errorInput");
		isError=true;
	}
	if(charLen($.trim(subjName))>30){
 		$("#subjName").addClass('errorInput');
 		$("#subjName").attr("title",'主题不能超过30个字节!');
 		isError=true;
	}
	if ($.trim(buyBeginDate) == "") {
		$("#buyBeginDate").addClass('errorInput');
		isError=true;
	}
	if ($.trim(buyEndDate) == "") {
		$("#buyEndDate").addClass('errorInput');
		isError=true;
	}
	if(isError){
		enabledTools2();
		return;
	}
	// 促销代号信息
	var promCodeMess = $.trim(convertJsonStr("#promCodeMess_div", "item"));
	if (promCodeMess == "") {
		top.jAlert('warning', '促销代号信息不能为空!', '提示消息');
		enabledTools2();
		return;
	}
	// 促销商品门店信息
	var itemSupMessStr = "";
	var itemSupMessArr=[];
	var items = new Array();
	var errorStatus = false;
	var v_promBuyPriceArr = new Array();
	var itemSup_check = false;
	if(!checkHasBatchItemValue()){
		enabledTools2();
		return;
	}
	if(!checkPromItems()||checkHasChangeItemValue()){
		enabledTools2();
		return false;
	}
	if (itemSupMess.length > 0) {
		$("#promCodeMess_div .addPromCode_div").each(function(index, value){
			var v_unitType = $(value).find("select").val();
			var v_promUnitNo = $(value).find(".promUnitNoClick").val();
			$.each(itemSupMess, function(j, json) {
				if (json.indexOf('"unitType":"'+v_unitType+'"') >= 0 && json.indexOf('"promUnitNo":"'+v_promUnitNo+'"') >= 0) {
					var storeStr = json.split("--");
					$.each(storeStr, function(i, json) {
						var store=json;
						store = store.replace(/"storeName":".*promSupNo":/g,'"promSupNo":');
						store = store.replace(/"comName":".*statusName":/g,'"statusName":');
						store = store.replace(/"statusName":".*normBuyPrice":/g,'"normBuyPrice":');
						store = store.replace(/,"normSellPrice":""/g,'');
						store = store.replace(/,"itemName":".*\}/g,'}');
						//itemSupMessStr = itemSupMessStr +store + '#';
						itemSupMessArr.push(JSON.parse(store));
					});
				}
				var store_Str = json.split("--");
				$.each(store_Str, function(i, json) {
					var jsonData=JSON.parse(json);
					var supJson = {'promUnitNo':jsonData.promUnitNo,'unitType':jsonData.unitType};
					//delCodeMess.push(supJson);
					promMap[jsonData.unitType+"-"+jsonData.promUnitNo] = supJson;
					return false;
				});

			});
		});
	}
	itemSupMessStr = itemSupMessStr.substring(0, itemSupMessStr.length - 1);
	if (itemSupMess.length > 0) {
		$.each(promMap,function(index,hoPrice){
			var promCod_div = $("#promCodeMess_div .addPromCode_div");
			$.each(promCod_div,function(ind, value){
				var v_unitType = $(value).find("select").val();
				var v_promUnitNo = $(value).find(".promUnitNoClick").val();
				if (v_promUnitNo == hoPrice.promUnitNo && v_unitType == hoPrice.unitType) {
					return false;
				}
				if (ind == promCod_div.length-1) {
					var supJson = {'promUnitNo':hoPrice.promUnitNo,'unitType':hoPrice.unitType};
					delCodeMess.push(supJson);
				}
			});
		});
	}
	var delCodeMessStr = strJson(delCodeMess);
	var delItemMessStr = strJson(delItemMess);
	var delSupMessStr = strJson(delSupMess);
	//check商品是否为空
	var checkItems = false;
	var v_stores = "";
	if (errorStatus) {
		top.jAlert('warning', v_promBuyPriceArr[0], '提示消息');
		enabledTools2();
		return;
	}
	if (!checkPromotion()) {
		enabledTools2();
		return;
	}
	var rawdata2post = {
		promNo : promNo,
		buyBeginDate : buyBeginDate,
		buyEndDate : buyEndDate,
		subjName : subjName,
		promSubjId : promSubjId,
		catlgId : catlgId,
		promCodeMess : promCodeMess,
		itemSupMessStr : itemSupMessArr,
		promType : promType==''?null:promType,
		delCodeMess : delCodeMessStr,
		delItemMess : delItemMessStr,
		delSupMess : delSupMessStr
	};
	var data2post = {};
	data2post.jsonStr = JSON.stringify(rawdata2post);
	$.ajax({
		type : 'post',
		url : ctx + '/prom/nondm/ho/savePromotionMessage',
		data : data2post, 
		success : function(data) {
			enabledTools2();
			if (data.status == 'success') {
				top.jAlert('success', data.message, '消息提示');
				//清空创建页面所有内容
				if (promType == "") {
					window.location.href = ctx + "/prom/nondm/ho/createPromotionPage";
				}
			} else if (data.status == 'error') {
				top.jAlert('error', data.message, '消息提示');
			} else if(data.status=='errorMess'){
				existsItemNoStoreNoMap=data.existsItemNoStoreNoMap;
				 /*定位到重复期间的第一个代号 begin*/
				  var firstItemNo='';
				  $.each(existsItemNoStoreNoMap, function(i) {
					  firstItemNo=i;
					  return false;
				  });
				  top.jAlert('warning', data.message, '消息提示');
				  if(!firstItemNo||firstItemNo==''){
					  return
				  }
				 
				  $.each(itemSupMess,function(itemIndex,itemValue){
					if(itemValue.indexOf('"itemNo":"'+firstItemNo+'"') >= 0){
						var promUnitNo=JSON.parse(itemValue.split("--")[0]).promUnitNo;
						var unitType=JSON.parse(itemValue.split("--")[0]).unitType;
						if(!promUnitNo||!unitType){
							return;
						}
							$("#promItemStoreMess_div").children().remove();
							$(".pro_store_items").children().remove();
							var promCodeMess_div = $("#promCodeMess_div").find(".addPromCode_div");
							$.each(promCodeMess_div, function(index, value){
								if($(value).find("select").val()==unitType&&$(value).find("input[name='promUnitNo']").val()==promUnitNo){
									acquirePromStoreMess(unitType, promUnitNo);
									$.each(promCodeMess_div, function(unitIndex, unitValue){
										$(this).removeClass('item_on');
									});
									$(this).addClass('item_on');
									$(this)[0].scrollIntoView();
									if (unitType == 0) {
										unAddItemClick();
										addSupClick();
									} else {
										addItemClick();
										addSupClick();
									}
									return false;
								}
							});
						}
				  });
				  /*定位到重复期间的第一个代号 end*/
			}else {
				top.jAlert('warning', data.message, '消息提示');
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			enabledTools2();
		}
	});
}
//标识促销期间重复门店信息
function  existsItemStore(itemNo,storeNo,value,promItemStoreMess_div_ig){
	promItemStoreMess_div_ig.removeClass("errorDiv");
	if(existsItemNoStoreNoMap!=undefined&&existsItemNoStoreNoMap[itemNo]!=undefined){
		var storeArr=existsItemNoStoreNoMap[itemNo].split(",");
		$.each(storeArr,function(index, value){
			if(storeNo==value){
			  promItemStoreMess_div_ig.addClass("errorDiv");
			  return true;
			}
			
		});
	}
}
//重置期间重复商品门店信息
function clearExistsItemStoreMap(promTime){
	$(promTime).blur();
	existsItemNoStoreNoMap=new Object();
	$("#promItemStoreMess_div .ig").each(function(index, value){
		var promItemStoreMess_div_ig=$(this);
		var itemNo = $(value).find("input[name='itemNo']").val();
		var storeNo = $(value).find("input[name='storeNo']").val();
		existsItemStore(itemNo,storeNo,value,promItemStoreMess_div_ig);
	});	
}
//清空创建页面所有内容
function clearCreateProm(){
	$("#promNo").val('');
	$("#subjName").val('');
	$("#buyBeginDate").val('');
	$("#buyEndDate").val('');
	$(".pro_store_items").children().remove();
	$("#promItemStoreMess_div").children().remove();
	$("#promCodeMess_div").children().remove();
	unAddItemClick();
	unSupClickAddItem();
}
// 选择某条数据是否为全选
$(".isChecksProm").live("click", function() {
	var checkAll = true;
	var promCheckBoxList = $("#promItemStoreMess_div")
			.find("input.isChecksProm");
	$.each(promCheckBoxList, function(index, prom) {
				if (this.checked == false) {
					checkAll = false;
					return false;
				};
			});
	if (!checkAll) {
		$(".isCheckAllsProm").attr("checked", false);
	} else {
		$(".isCheckAllsProm").attr("checked", true);
	}

});
// 全选事件
$(".isCheckAllsProm").live("click", function() {
	if (this.checked) {
		$(".isChecksProm:not(:disabled)").attr("checked", true);
	} else {
		$(".isChecksProm").attr("checked", false);
	}
	$("#itemStoreInfoModel .isChecksProm").attr("checked",false);

});

// 删除事件
$(".deleteCheckedsProm").die("click").live("click", function() {
	var delClass_str = $(this).attr("class");
	if (delClass_str.indexOf("deleteBar_off") < 0) {
		$("#promItemStoreMess_div input.isChecksProm:checked").parent().each(function(index, value){
			var itemNo = $(value).find("input[name='itemNo']").val();
			var storeNo = $(value).find("input[name='storeNo']").val();
			var promUnitNo = $(value).find("input[name='promUnitNo']").val();
			var unitType = $(value).find("input[name='unitType']").val();
			var supJson = {'itemNo':itemNo,'storeNo':storeNo,'promUnitNo':promUnitNo,'unitType':unitType};
			delSupMess.push(supJson);
		});
		
		$("#promItemStoreMess_div input.isChecksProm:checked").parent().parent().remove();
		$(".isCheckAllsProm").attr("checked", false);
		var unitNo = $(this).attr("checkPromNo");
		var itemNo = $(this).attr("checkItemNo");
		var unitType = $(this).attr("checkUnitType");
		$.each(itemSupMess, function(index, value){
			if (itemSupMess[index].indexOf('"promUnitNo":"'+unitNo+'"') >= 0 && itemSupMess[index].indexOf('"itemNo":"'+itemNo+'"') >= 0 && itemSupMess[index].indexOf('"unitType":"'+unitType+'"') >= 0) {
				itemSupMess.remove(index);
				return false;
			}
		});	
		addPromItemStoreMess();
	}
});

// 动态显示商品下的厂商列表
function showItemStoreSupList(itemNo,show) {
	var promSubjId = $("#promNoDetail").val();
	if ($.trim(itemNo) == "") {
		return false;
	}
	
	$.ajax({
		//async : false,
		type : 'post',
		url : ctx + '/prom/nondm/ho/detailItemStoreList?ti='+(new Date()).getTime() ,
		data : {
			itemNo : itemNo,
			promSubjId : promSubjId,
			checkUpdate:'true',
			show : show
		},
		success : function(data) {
			$("#promItemStoreMess_div").hide();
			$("#promItemStoreMess_div").html(data);
			$(".Black").removeClass("Black");
			$("#promItemStoreMess_div").show();
			$("#promItemStoreMess_div").scrollTop(0);
			//$("#promItemStoreMess_div .ig:first")[0].scrollIntoView();
		}
	});
}

/*// 课别弹出框
$(".showCatlgWin").live('click', function() {
	top.window.$.fn.zWindow({
		width : 602,
		height : 152,
		titleable : true,	
		title : '选择课别信息',
		moveable : true,
		windowBtn : ['close'],
		windowType : 'iframe',
		targetWindow : top,
		windowSrc : ctx + '/prom/nondm/art/showCatlgWin',
		resizeable : false,
		 关闭后执行的事件 
		afterClose : function(data) {
			if (data != undefined) {
				$("#catlgId").removeClass("errorInput");
				$("#catlgId").attr("title", "");
				$("#promCodeMess_div").children().remove();
				clearDiv();
				unSupClickAddItem();
				$("#catlgName").val(data.CatlgName);
				$("#catlgId").val(data.CatlgId);
			}
		},
		isMode : true
	});
});*/
//查询代号弹出框
$(".searchShowUnitWin").die("click").live('click',function(){
		searchShowUnitWin($(this));
});

function searchShowUnitWin(obj){
	var unitType =$("#unitType").val();

	 if(unitType=='')
		{
		 top.jAlert('warning', '请选择代号类别 !', '提示消息');
		 return;
		}
	 
 	top.openPopupWin(800,450,'/prom/nondm/store/showUnitWinQuery?unitType='+unitType);

}
function addStoreGrpTypeReturn(unitNo,unitName){
	if (unitNo!=undefined){
		$("#catlgId").removeClass("errorInput");
		$("#catlgId").attr("title", "");
		$("#unitNo").val(unitNo);
		$("#unitName").val(unitName);
	}
	top.closePopupWin();
}

// 代号弹出框
$(".showUnitWin").die('click').live('click', function() {
	var select = $("#promCodeMess_div .item_on").find("select");
	if ($("#buyBeginDate").hasClass("Black")) {
		top.jAlert('warning', '促销已经开始不能修改 !', '提示消息');
		return ;
	}
	if (select.children().size() > 1) {
		popUnitWin($(this));
	} else {
		top.jAlert('warning', '已被订单使用不能修改 !商品['+getOrderList()+']', '提示消息');
	}
});
function  popUnitWinReturn(unitNo,unitName){
	var catlgId = $.trim($("#catlgId").val());
	var unitType = $("#promCodeMess_div .item_on").find("select").val();
	var promUnitNo=$("#promCodeMess_div .item_on").find("input[name='promUnitNo']");
	var promUnitName=$("#promCodeMess_div .item_on").find(".promUnitName");
	var promBuyPriceHead=$("#promCodeMess_div .item_on").find(".promBuyPrices");
	var prom_str = "";
	var promCodeMess_div = $("#promCodeMess_div").find(".addPromCode_div");
	$.each(promCodeMess_div, function(index, value){
		prom_str = prom_str + $(value).find("select").val() + "," + $(value).find("input[name='promUnitNo']").val() + "-";
	});
	var promSubjId = $("#promSubjId").val();
	var checkUpdate = $("#checkUpdate").val();
	if (unitNo != null) {
		if (prom_str.indexOf(unitType + "," + unitNo + "-") < 0) {
			deletePromMess(unitType, $.trim(promUnitNo.val()));
			if($.trim(promUnitNo.val())!=""&&$.trim(unitType)!=""){
			var supJson = {'promUnitNo':$.trim(promUnitNo.val()),'unitType':unitType};
			delCodeMess.push(supJson);
			}
			promUnitNo.val(unitNo);
			promUnitName.val(unitName);
			$(".pro_store_items").children().remove();
			$("#promItemStoreMess_div").children().remove();
			$("#updatePriceAll").val('');
			promBuyPriceHead.val('');
			$.ajax({
				type : "post",
				url : ctx + '/prom/nondm/ho/showUnitDataAction',
				data : {
					unitType : unitType,
					itemNo : unitNo,
					catlgId : catlgId,
					pageNo : 1,
					pageSize : 1
				},
				success : function(result) {
					if (unitType == 0) {
						if (!checkNotRepetitionItem(unitNo)) {
							promUnitName.val("");
							promUnitNo.val("");
							top.jAlert('warning', '商品已存在!', '提示消息');
							clearDiv();
						} else {
							//添加数据
							if (result.storeList == null) {
								top.jAlert('warning', '该单品下没有厂商!', '提示消息');
								$("#promCodeMess_div .item_on").find(".promUnitNoClick").val('');
								$("#promCodeMess_div .item_on").find(".promUnitName").val('');
								return false;
							}
							addAllItemsStoreDate(unitType,unitNo,result.itemNoList,result.storeList,"");
							acquirePromStoreMess(unitType, unitNo);
							unAddItemClick();
							addSupClick();
						}
					} else {
						if (!addAllItemsStoreDate1(unitType,unitNo,result.itemNoList,result.storeList,"")){
							return false;
						}
						acquirePromStoreMess(unitType, unitNo);
						addItemClick();
						addSupClick();
					}
				}
			});
		} else {
			if (unitNo == "") {
				top.closePopupWin();
				return false;
			}
			if (unitType == 0) {
				top.jAlert('warning', '该促销下的单品已存在!', '提示消息');
			} else if (unitType == 1) {
				top.jAlert('warning', '该促销下的同品项系列已存在!', '提示消息');
			} else if (unitType == 2) {
				top.jAlert('warning', '该促销下的非同品项系列已存在!', '提示消息');
			}
			top.closePopupWin();
			return false;
		}
	}
	top.closePopupWin();

}
function popUnitWin(obj){
	var prom_str = "";
	var promCodeMess_div = $("#promCodeMess_div").find(".addPromCode_div");
	$.each(promCodeMess_div, function(index, value){
		prom_str = prom_str + $(value).find("select").val() + "," + $(value).find("input[name='promUnitNo']").val() + "-";
	});
	var unitType = $.trim($(obj).parent().parent().find("select").val());
	var catlgId = $.trim($("#catlgId").val());
	var promUnitNo = $(obj).parent().parent().find("input[name='promUnitNo']");
	var promUnitName = $(obj).parent().parent().find(".promUnitName");
	var promSubjId = $("#promSubjId").val();
	var checkUpdate = $("#checkUpdate").val();
	if (catlgId != "" && unitType != "") {
	 	top.openPopupWin(800,450, '/prom/nondm/ho/showUnitWin?unitType=' + unitType + '&catlgId=' + catlgId);
	} else {
		if (catlgId == "") {
			$("#catlgId").addClass("errorInput");
			$("#catlgId").attr("title", "请选择课别");
		}
		if (unitType == "") {
			$(obj).parent().parent().find("select").addClass("errorInput");
		}
	}

}

//检查当前促销编号和商品
function checkPromCodeAndItem(){
	return checkHasChangeItemValue() || !checkPromItems();
}

//切换系列数据
$(".addPromCode_div").die('mouseup').live('mouseup', function() {
	switchPromotionUnit($(this));
	});

function switchPromotionUnit(obj){
	if (!$(obj).hasClass('item_on')) {
		if((hasInputflag || ($.trim($('#promCodeMess_div:visible .item_on .promUnitNoClick').val())!='' && checkStoreDiv()) || !checkPromItems())){
			return false;
		}
		else{
			$('#promCodeMess_div .item_on').removeClass('item_on');
			$(obj).addClass('item_on');
		}
		var promUnitNo = $.trim($(obj).find("input[name='promUnitNo']").val());
		$("#updatePriceAll").val('');
		$(".isCheckAllsProm").attr("checked",false);
		if (promUnitNo != '') {
			var promBuyPrices = $.trim($(obj).find(".promBuyPrices").val());
			$("#updatePriceAll").val(promBuyPrices);
			var promUnitName = $.trim($(obj).find(".promUnitName").val());
			var unitType = $.trim($(obj).find("select").val());
			var promSubjId = $("#promSubjId").val();
			var checkUpdate = $("#checkUpdate").val();
			var catlgId = $.trim($("#catlgId").val());
			var v_unitType = $($($(".pro_store_items").find(".item_on")[0]).find("span")[0]).attr("unittypevalue");
			var v_promUnitNo = $($($(".pro_store_items").find(".item_on")[0]).find("span")[0]).attr("unitnovalue");
			if (!(v_unitType == unitType && v_promUnitNo == promUnitNo)) {
				if (itemSupMess.length > 0) {
					top.grid_layer_open();
					$("#promItemStoreMess_div").children().remove();
					$(".pro_store_items").children().remove();
					acquirePromStoreMess(unitType, promUnitNo);
					top.grid_layer_close();
				}
			}
			var checkUpdate = $("#checkUpdate").val();
			if (checkUpdate !="" ) {
				$("#updatePriceAll").attr("readOnly",true);
				$("#updatePriceAll").addClass("Black");
				$("input[name='promBuyPrice']").attr("readOnly",true);
				$("input[name='promBuyPrice']").addClass("Black");
				$(".isChecksProm").attr("disabled","disabled");
			} else {
				if (unitType == 0) {
					unAddItemClick();
					addSupClick();
				} else {
					addItemClick();
					addSupClick();
				}
			}
		} else {
			clearDiv();
			unSupClickAddItem();
			unAddItemClick();
		}
	}

}

$("#unitType").die("change").live("change", function() {
	var selectValue = $.trim($(this).val());
	if (selectValue != "") {
		$(this).removeClass("errorInput");
	}
});
//获取并显示系列的商品和门店信息
function getItemsStoresMess(promUnitNo, unitType) {
	var promSubjId = $("#promSubjId").val();
	var catlgId = $.trim($("#catlgId").val());
	var flags = true;
	var promNameDom = $("#promCodeMess_div .item_on .promUnitName");
	var promNoDom = $("#promCodeMess_div .item_on .promUnitNoClick");
	if (promUnitNo == "" || catlgId == "") {
		return;
	}
	$.ajax({
		//async : false,
		url : ctx + '/prom/nondm/ho/searchItemList?ti=' + (new Date()).getTime(),
		data : {
			'promUnitNo' : promUnitNo,
			'unitType' : unitType,
			'catalgId' : catlgId
		},
		type : 'POST',
		success : function(response) {
			var data = response['row'];
			$(".pro_store_items").children().remove();
			var temp=0;
			if (data != null) {
				$.each(data, function(index, value) {
					if (checkNotRepetitionItem(value.itemNo)) {
						if (temp++==0) {
							//showItemStoreSupMessage(value.itemNo,promSubjId,unitType,promUnitNo);
							addSearchItemStoreSup(value.itemNo,promUnitNo,catlgId,unitType,value.itemName);
							if (v_store_str != "isempty") {
								var objElement = setValueForItemInfo(unitType,promUnitNo,value.itemNo,value.itemName);
								$(".pro_store_items").html($(objElement).clone());
								$(".pro_store_items .item").addClass('item_on');
								checkOrdersFlag("");
							}
						} else {
							var objElement = setValueForItemInfo(unitType,promUnitNo,value.itemNo,value.itemName);
							$(".pro_store_items").append($(objElement).clone());
							checkOrdersFlag("");
							storeSupplierMess_json(value.itemNo,promUnitNo,catlgId,unitType,value.itemName,"","");
						}
					}
					if (temp == 0) {
						top.jAlert('warning', '该系列下的商品已存在!', '提示消息');
						$("#promCodeMess_div .item_on").find(".promUnitNoClick").val('');
						$("#promCodeMess_div .item_on").find(".promUnitName").val('');
					}
				});
			} else {
				grid_layer_close();
				top.jAlert('warning', '该系列不存在!', '提示消息');
				promNameDom.val("");
				promNoDom.val("");
				flags = false;
				return false;
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			top.jAlert('error', '网络超时!请稍后重试', '提示消息');
		}
	});
	return flags;
}

// 拼写Json格式
function convertJsonStr(obj, chdObj) {
	var dataList = $(obj+" form").map(
		function() {
			if($(this).serializeObject().promUnitNo!=null){
			return JSON.stringify($(this).serializeObject());
			}
	}).get().join("--");
	return dataList;
}

// 根据商品选择厂商信息
$(".promItemStoreClick").die("mousedown").live("mousedown",function(){
	if (checkStoreDiv()) {
		return false;
	}
});
$(".promItemStoreClick").die("click").live("click", function() {
	if (!checkPromotion) {
		return ;
	}
	var promItemClass = $(this).attr("class");
	if (promItemClass.indexOf("item_on") >= 0) {
		return ;
	}
	nullInputCheck();
	//取消选择框
	$(".isCheckAllsProm").attr("checked",false);
	var catlgId = $("#catlgId").val();
	var unitNo = $(this).attr("unitNoValue");
	var itemNo = $(this).attr("itemNoValue");
	var itemName = $(this).attr("itemNameValue");
	var unitType = $(this).attr("unitTypeValue");
	var checkOrders = $(this).parent().attr("checkorders"); 
	//属性值设置
	editMess(itemNo,unitNo,unitType);

	$("#updatePriceAll").val('');
	$.each(itemSupMess, function(index, value){
		if (value.indexOf('"promUnitNo":"'+unitNo+'"') >= 0 && value.indexOf('"unitType":"'+unitType+'"') >= 0 && value.indexOf('"itemNo":"'+itemNo+'"') >= 0 && value.indexOf('"storeNo":""') < 0) {
			var valus = value.split("--");
			$("#promItemStoreMess_div").children().remove();
			$.each(valus, function(idx, json){
				var jsonData = JSON.parse(json);
				//把模板里面的数据替换再复制过来
				setValueForItemStoreInfo(jsonData,itemName);
				$("#promItemStoreMess_div").append($('#itemStoreInfoModel .ig').clone());
				unShowStoreDom(jsonData.checkOrders);
				if ($.trim(jsonData.promBuyPrice) != "") {
					$("#promItemStoreMess_div .ig .errorInput").removeClass('errorInput');
				}
			});
			return false;
		}
	});
	$("#promItemStoreMess_div .ig").each(function(index, value){
		var obj=$(this);
		var itemNo = $(value).find("input[name='itemNo']").val();
		var storeNo = $(value).find("input[name='storeNo']").val();
		existsItemStore(itemNo,storeNo,value,obj);
	});	
	if (unitType == 0) {
		unAddItemClick();
	} else {
		supClickAddItem();
	}
	var checkUpdate = $("#checkUpdate").val();
	if (checkUpdate !="" ) {
		unSupClickAddItem();
		$(".isChecksProm").attr("disabled","disabled");
	}
	var firstVal=$('#promItemStoreMess_div .ig:first input[name="promBuyPrice"]').val();
	$('#promItemStoreMess_div .ig:first input[name="promBuyPrice"]').focus().val(firstVal);
});

function setValueForItemInfo(unitType,promUnitNo,itemNo,itemName){
	var objId = '#promItemInfoModel';
	if(unitType!=0){
		objId = '#promItemInfoModel2';
	}
	var objElement = objId+" span:first";
	$(objElement).attr('unitTypeValue',unitType);
	$(objElement).attr('unitNoValue',promUnitNo);
	$(objElement).attr('itemNoValue',itemNo);
	$(objElement).attr('itemNameValue',itemName);
	$(objElement).text(itemNo+'-'+itemName);
	return objId+" .item";
}

function setValueForItemStoreInfo(jsonData,itemName){
	var modelElement = $('#itemStoreInfoModel');
	modelElement.find('input[name="unitType"]').val(jsonData.unitType);
	modelElement.find('input[name="promUnitNo"]').val(jsonData.promUnitNo);
	modelElement.find('input[name="itemNo"]').val(jsonData.itemNo);
	modelElement.find('input[name="storeNo"]').val(jsonData.storeNo);
	modelElement.find('input[name="storeName"]').val(jsonData.storeName);
	modelElement.find('input[name="promSupNo"]').val(jsonData.promSupNo);
	modelElement.find('input[name="comName"]').val(jsonData.comName);
	modelElement.find('input[name="statusName"]').val(jsonData.statusName);
	modelElement.find('input[name="normBuyPrice"]').val(jsonData.normBuyPrice);
	modelElement.find('input[name="promBuyPrice"]').val(jsonData.promBuyPrice);
	modelElement.find('input[name="promBuyPrice"]').attr("buyPriceLimit",jsonData.buyPriceLimit);
	modelElement.find('input[name="promBuyPrice"]').attr("buyWhen",jsonData.buyWhen);
	modelElement.find('input[name="buyPriceLimit"]').val(jsonData.buyPriceLimit);
	modelElement.find('input[name="normSellPrice"]').val(jsonData.normSellPrice);
	modelElement.find('input[name="buyWhen"]').val(jsonData.buyWhen);
	modelElement.find('input[name="itemName"]').val(itemName);
	modelElement.find('input[name="checkOrders"]').val(jsonData.checkOrders);
	modelElement.find('input[name="batchPriceChngInd"]').val(jsonData.batchPriceChngInd);
}

function setValueForItemStoreInfoForElement(modelElement,jsonData,itemName){
	modelElement.find('input[name="unitType"]').val(jsonData.unitType);
	modelElement.find('input[name="promUnitNo"]').val(jsonData.promUnitNo);
	modelElement.find('input[name="itemNo"]').val(jsonData.itemNo);
	modelElement.find('input[name="storeNo"]').val(jsonData.storeNo);
	modelElement.find('input[name="storeName"]').val(jsonData.storeName);
	modelElement.find('input[name="promSupNo"]').val(jsonData.promSupNo);
	modelElement.find('input[name="comName"]').val(jsonData.comName);
	modelElement.find('input[name="statusName"]').val(jsonData.statusName);
	modelElement.find('input[name="normBuyPrice"]').val(jsonData.normBuyPrice);
	modelElement.find('input[name="promBuyPrice"]').val(jsonData.promBuyPrice);
	modelElement.find('input[name="promBuyPrice"]').attr("buyPriceLimit",jsonData.buyPriceLimit);
	modelElement.find('input[name="promBuyPrice"]').attr("buyWhen",jsonData.buyWhen);
	modelElement.find('input[name="buyPriceLimit"]').val(jsonData.buyPriceLimit);
	modelElement.find('input[name="normSellPrice"]').val(jsonData.normSellPrice);
	modelElement.find('input[name="buyWhen"]').val(jsonData.buyWhen);
	modelElement.find('input[name="itemName"]').val(itemName);
	modelElement.find('input[name="checkOrders"]').val(jsonData.checkOrders);
	modelElement.find('input[name="batchPriceChngInd"]').val(jsonData.batchPriceChngInd);
}

function includeContent(obj){
	var div_name = $(obj).find("." + val);
	var div_str = "";
	$.each(div_name, function(i, val) {
		var str = "";
		var div_name_ig = $(div_name[i]).find("input");
		$.each(div_name_ig, function(j, val) {
			if (val.name != "") {
				str = str + '"' + val.name + '":"' + val.value
						+ '",';
			}
		});
		str = str.substring(0, str.length - 1);
		div_str = div_str + bracket_left + str + bracket_right + comma;
	});
	div_str = div_str.substring(0, div_str.length - 2);
	return div_str;
}
//批量修改促销价格
$(".promBuyPrices").die("blur").live("blur", function(){
	var promPrice = $.trim($(this).val());
	if (promPrice == "") {
		return ;
	}
	$(".promItemStoreClick").attr("pbpvalue", promPrice);
	$("#updatePriceAll").val(promPrice);
	var promItemStoreMess_div = $("#promItemStoreMess_div").find(".ig");
	if (promItemStoreMess_div.length > 0) {
		$.each(promItemStoreMess_div, function(index, value){
			var normBuyPrice = $.trim($(value).find("input[name='normBuyPrice']").val());
			var pro_store_items = $.trim($(value).find("input[name='checkOrders']").val());
			if (pro_store_items == "") {
				//检查成本时点
				checkBuyWhen(value,promPrice,normBuyPrice);
			}
		});
		var unitNo = $("#promItemStore_div").attr("checkPromNo");
		var itemNo = $("#promItemStore_div").attr("checkItemNo");
		var unitType = $("#promItemStore_div").attr("checkUnitType");
		//批量修改，其他的价格
		if (promPrice != "") {
			$.each(itemSupMess, function(index, value){
				if (value.indexOf('"promUnitNo":"'+unitNo+'"') > 0 && value.indexOf('"unitType":"'+unitType+'"') > 0) {
					var valus = value.split("--");
					var itemMess = "";
					$.each(valus, function(idx, storeMess){
						var jsonData = JSON.parse(storeMess);
						var normBuyPrice = jsonData.normBuyPrice;
						var buyWhen = jsonData.buyWhen;
						var buyPriceLimit = $.trim(jsonData.buyPriceLimit);
						var checkOrders = $.trim(jsonData.checkOrders);
						var jsonStr = JSON.parse(storeMess);
						if (checkOrders == "") {
							if (buyWhen == 2) {
								if(buyPriceLimit !="" && (Number(promPrice)>Number(buyPriceLimit))){
									jsonStr.promBuyPrice="";
								}else{
									jsonStr.promBuyPrice=promPrice;
								}
							} else {
								if (Number(promPrice) >= Number(normBuyPrice)) {
									jsonStr.promBuyPrice="";
								} else {
									jsonStr.promBuyPrice=promPrice;
								}
							}
						}
						itemMess = itemMess + JSON.stringify(jsonStr)+"--";
					});
					itemSupMess[index] = itemMess.substring(0,itemMess.length-2);
				}
			});
		}

		$.each(itemSupMess, function(index, value){
			if (itemSupMess[index].indexOf('"promUnitNo":"'+unitNo+'"') >= 0 && itemSupMess[index].indexOf('"itemNo":"'+itemNo+'"') >= 0 && itemSupMess[index].indexOf('"unitType":"'+unitType+'"') >= 0) {
				itemSupMess.remove(index);
				return false;
			}
		});	
		addPromItemStoreMess();
	}
});
//批量修改促销价格
$("#updatePriceAll").die("blur").live("blur", function(){
	var promPrice = $.trim($(this).val());
	var unitNo = $.trim($($("#promCodeMess_div .item_on").find(".promUnitNoClick")[0]).val());
	var itemNo = $.trim($($(".pro_store_items .item_on").find("span")[0]).attr('itemnovalue'));
	var unitType = $.trim($($("#promCodeMess_div .item_on").find("select")[0]).val());
	if (promPrice == "") {
		return;
	}
		
	var promItemStoreMess_div = $("#promItemStoreMess_div").find(".ig");
	$.each(promItemStoreMess_div, function(index, value){
		var normBuyPrice = $.trim($(value).find("input[name='normBuyPrice']").val());
		var pro_store_items = $.trim($(value).find("input[name='checkOrders']").val());
		//检查成本时点
		if (pro_store_items == "") {
			//检查成本时点
			checkBuyWhen(value,promPrice,normBuyPrice);
		}
		var obj=$(value).find("input[name='promBuyPrice']");
		sameItemsSamePrices(unitType,unitNo,obj.val(),obj);
	});
	

	$.each(itemSupMess, function(index, value){
		if (itemSupMess[index].indexOf('"promUnitNo":"'+unitNo+'"') >= 0 && itemSupMess[index].indexOf('"itemNo":"'+itemNo+'"') >= 0 && itemSupMess[index].indexOf('"unitType":"'+unitType+'"') >= 0) {
			itemSupMess.remove(index);
			return false;
		}
	});	
	addPromItemStoreMess();
		
	
});

$(".delPromUnitNo").die("mousedown").live("mousedown",function(event){
	event.stopPropagation();
	var unitType = $.trim($(this).parent().find("select").val());
	var delPromUnitNo = $.trim($("#buyBeginDate").attr("class"));
	var select_idnex = $(this).parent().find("select").children().size();
	if (delPromUnitNo.indexOf("Black") >= 0) {
		top.jAlert('warning', '促销已经开始不能删除!', '提示消息');
		return false;
	}
	//检查系列是否使用订单
	if (select_idnex <= 1) {
		top.jAlert('warning', '该代号下的商品['+getOrderList()+']已有订单使用!', '提示消息');
		return false;
	}
});
//获取已使用的订单
function getOrderList(){
		var itemNos = $('.pro_store_items .item[checkorders="1"]').map(
		function() {
			return $(this).find('span:first').attr('itemnovalue');
		}).get().join(",");
	return itemNos;
}
//删除系列下所有的商品列表
$(".delPromUnitNo").die("mouseup").live("mouseup",function(event){
	event.stopPropagation();
	var promUnitNo = $.trim($(this).parent().find("input[name='promUnitNo']").val());
	var unitType = $(this).parent().find("select").val();
	var itemClass = $(this).parent().parent().attr("class");
	var this_prev = $(this).parent().parent().prev();
	var this_next = $(this).parent().parent().next();
	var isItemOn = false;
	$(this).parent().parent().remove();
	if (promUnitNo != "") {
		var supJson = {'promUnitNo':promUnitNo,'unitType':unitType};
		delCodeMess.push(supJson);	
	}
	var flags = false;
	if (itemClass.indexOf("item_on") >= 0) {
		flags = true;
	}
	if (v_prom_str.indexOf(unitType + "," + promUnitNo + "-") >= 0) {
		v_prom_str = v_prom_str.substring(0,v_prom_str.indexOf('-'+unitType+',')) + "-" + v_prom_str.substring(v_prom_str.indexOf('-'+unitType+',') + 2,v_prom_str.indexOf(','+promUnitNo+'-'));
	}
	if (flags) {
		//clearDiv();
		unSupClickAddItem();
		$("#updatePriceAll").val('');
		$(".pro_store_items").children().remove();
		$("#promItemStoreMess_div").children().remove();
		$("#updatePriceAll").val("");
		var currObj = this_prev.size()==0?this_next:this_prev;
		if($.trim(currObj)!=''){
			$(currObj).addClass("item_on");
			var v_unitType = $(currObj).find("select").val();
			if (v_unitType == 0) {
				addSupClick();
			} else {
				supClickAddItem();
			}
			var v_promUnittype = $.trim(currObj.find("input[name='promUnitNo']").val());
			if (v_promUnittype != "") {
				acquirePromStoreMess(v_unitType, v_promUnittype);
			} else {
				unSupClickAddItem();	
			}
		} else {
			clearDiv();
			unSupClickAddItem();
		}
		//$(".promItemStoreClick").click();
	}
	if (promUnitNo != "") {
		eachDelPromUnitNo(unitType,promUnitNo);
	}
});
function eachDelPromUnitNo(unitType,promUnitNo){
	$.each(itemSupMess, function(index, prom){
		var value = $.trim(prom);
		if (value != "") {
			if (value.indexOf('"promUnitNo":"'+promUnitNo+'"') >= 0 && value.indexOf('"unitType":"'+unitType+'"') >= 0) {
				itemSupMess.remove(index);
				delete itemSupMess.splice(index, 1);
				eachDelPromUnitNo(unitType,promUnitNo);
			}
		} else {
			return false;
		}
	});
}
//删除商品以及商品下的厂商列表
$(".delItemSupMess").die("mousedown").live("mousedown",function(event){
	var itemChildren = $(".pro_store_items").children().length;
	if (itemChildren === 1) {
		top.jAlert('warning', '促销商品门店信息至少保留一个!', '提示消息');
		return false;
	}
	var unitNo = $($(this).parent().find("span")[0]).attr("unitnovalue");
	var itemNo = $($(this).parent().find("span")[0]).attr("itemnovalue");
	var unitType = $($(this).parent().find("span")[0]).attr("unittypevalue");
	var itemClass = $(this).parent().attr("class");
	var checkOrders = $.trim($(this).parent().attr("checkorders"));
	var this_next = $(this).parent().next();
	var this_prev = $(this).parent().prev();
	var buyBeginDate = $("#buyBeginDate").attr("class");
	if (buyBeginDate.indexOf("Black") >= 0) {
		top.jAlert('warning', '采购期间已经开始!', '提示消息');
		return false;
	}
	//判断促销商品是否有订单
	if (checkItemOrderUse(checkOrders,itemNo)) {
		return false;
	}
	var flag = false;
	if (itemClass.indexOf("item_on") >= 0) {
		flag = true;
	}
	var supJson = {'itemNo':itemNo,'promUnitNo':unitNo,'unitType':unitType};
	delItemMess.push(supJson);
	$.each(itemSupMess, function(index, value){
		if (itemSupMess[index].indexOf('"promUnitNo":"'+unitNo+'"') >= 0 && itemSupMess[index].indexOf('"itemNo":"'+itemNo+'"') >= 0 && itemSupMess[index].indexOf('"unitType":"'+unitType+'"') >= 0) {
			itemSupMess.remove(index);
			if (flag) {
				$("#promItemStoreMess_div").children().remove();
			}
			return false;
		}
	});
	//unSupClickAddItem();
	if (flag) {
		if ($.trim(this_prev.attr("class")).indexOf("item") >= 0) {
			showStoreMess(this_prev);
		} else if ($.trim(this_next.attr("class")).indexOf("item") >= 0) {
			showStoreMess(this_next);
		} else {
			unAddSupClick();
		}
	}
});

function clearDiv(){
	$("#promItemStoreMess_div").children().remove();
	$(".pro_store_items").children().remove();
}

/**
 * 
 * @param itemNoArray
 * @param itemNameArray
 * @returns
 */
function addStoreSupMessReturn(storeIdArray){
	var storeNos = "";
	var itemName = $($($(".pro_store_items").find(".item_on")[0]).find("span")[0]).attr("itemnamevalue");
	var catlgId = $("#catlgId").val();
	var storeNos = "";
	$.each(storeIdArray,function(index, itemNo){
		storeNos += itemNo + ",";
	});
	storeNos = storeNos.substring(0, storeNos.length - 1);
	var unitNo = $("#promItemStore_div").attr("checkPromNo");
	var itemNo = $("#promItemStore_div").attr("checkItemNo");
	var unitType = $("#promItemStore_div").attr("checkUnitType");
	if(storeIdArray.length > 0){
		$.ajax({
			async : false,
			url: ctx + '/prom/nondm/art/showSupplerList1',
	        type: "post",
	        dataType:"json",
	        data : {
	        	storeNos : storeNos,
	        	unitType : unitType,
	        	itemNo : itemNo,
	        	unitNo : unitNo,
	        	catlgId : catlgId,
	        	promType : "promHO"
	        },
	        success: function(result) {
	        	if(result.storelist.length > 0){
	        		$.each(result.storelist, function(index, store){
						$.each(delSupMess,function(ind, val){
							if (val.itemNo == itemNo && val.promUnitNo == unitNo && val.unitType == unitType && val.storeNo == store.storeNo) {
								delSupMess.remove(ind);
								return false;
							}
						});
						$('#itemStoreInfoModel input[name="unitType"]').val(unitType);
						$('#itemStoreInfoModel input[name="promUnitNo"]').val(unitNo);
						$('#itemStoreInfoModel input[name="itemNo"]').val(itemNo);
						$('#itemStoreInfoModel input[name="storeNo"]').val(store.storeNo);
						$('#itemStoreInfoModel input[name="storeName"]').val(store.storeNo+'-'+store.storeName);
						$('#itemStoreInfoModel input[name="promSupNo"]').val(store.stMainSupNo);
						$('#itemStoreInfoModel input[name="comName"]').val(store.mainComName);
						$('#itemStoreInfoModel input[name="statusName"]').val(getDictValue('ITEM_BASIC_STATUS',store.status));
						$('#itemStoreInfoModel input[name="normBuyPrice"]').val(store.normBuyPrice);
						$('#itemStoreInfoModel input[name="promBuyPrice"]').val('');
						$('#itemStoreInfoModel input[name="promBuyPrice"]').attr("buyPriceLimit",store.buyPriceLimit);
						$('#itemStoreInfoModel input[name="promBuyPrice"]').attr("buywhen",store.buyWhen);
						$('#itemStoreInfoModel input[name="normSellPrice"]').val(store.normSellPrice);
						$('#itemStoreInfoModel input[name="itemName"]').val(itemName);
						$('#itemStoreInfoModel input[name="buyPriceLimit"]').val(store.buyPriceLimit);
						$('#itemStoreInfoModel input[name="buyWhen"]').val(store.buyWhen);
						$('#itemStoreInfoModel input[name="checkOrders"]').val('');
						$("#promItemStoreMess_div").append($('#itemStoreInfoModel .ig').clone());
						$("#promItemStoreMess_div .isChecksProm").attr("checked",null);
	        		});
	        	}
	        	$("#promItemStoreMess_div .ig").each(function(index, value){
	        		var obj=$(this);
	        		var itemNo = $(value).find("input[name='itemNo']").val();
	        		var storeNo = $(value).find("input[name='storeNo']").val();
	        		existsItemStore(itemNo,storeNo,value,obj);
	        	});	
	        }
		  });
	}
	$.each(itemSupMess, function(index, value){
		if (itemSupMess[index].indexOf('"promUnitNo":"'+unitNo+'"') >= 0 && itemSupMess[index].indexOf('"itemNo":"'+itemNo+'"') >= 0 && itemSupMess[index].indexOf('"unitType":"'+unitType+'"') >= 0) {
			itemSupMess.remove(index);
			return false;
		}
	});
	top.closePopupWin();
	addPromItemStoreMess();
}
//选择删除的厂商信息
function addStoreSupMess(obj){
	var unitNo = $(obj).attr("checkPromNo");
	var itemNo = $(obj).attr("checkItemNo");
	var unitType = $(obj).attr("checkUnitType");
	var catlgId = $("#catlgId").val();
	var storeNos = "";
	if ($.trim($("#promItemStoreMess_div").html()) != "") {
		$("#promItemStoreMess_div").find("input[name='storeNo']").each(function(){
			storeNos += $(this).val() + ",";
		});
		storeNos = storeNos.substring(0, storeNos.length - 1);
	}
	if ($(obj).attr("class").indexOf("_off") < 0) {
		top.openPopupWin(800,480, '/prom/nondm/ho/showDeleteSupplerList?storeNos='+storeNos+'&unitNo='+unitNo+'&catlgId='+catlgId+'&unitType='+unitType+'&itemNo='+itemNo+'&promType=promHO');
	}
}
//新增厂商按钮不可点击
function unSupClickAddItem(){
	$("#showDeleteItems").removeClass("createNewBar").addClass("createNewBar_off");
	$("#promItemStore_div").removeClass("createNewBar").addClass("createNewBar_off");
	$(".deleteCheckedsProm").removeClass("deleteBar").addClass("deleteBar_off");
	$(".isCheckAllsProm").attr("disabled","disabled");
}
//新增厂商按钮可点击
function supClickAddItem(){
	$("#showDeleteItems").removeClass("createNewBar_off").addClass("createNewBar");
	$("#promItemStore_div").removeClass("createNewBar_off").addClass("createNewBar");
	$(".deleteCheckedsProm").removeClass("deleteBar_off").addClass("deleteBar");
	$(".isCheckAllsProm").removeAttr("disabled");
}
//新增商品按钮不可点击
function unAddItemClick(){
	$("#showDeleteItems").removeClass("createNewBar").addClass("createNewBar_off");
}
//新增商品可点击
function addItemClick(){
	$("#showDeleteItems").removeClass("createNewBar_off").addClass("createNewBar");
}
//新增厂商按钮不可点击
function unAddSupClick(){
	$("#promItemStore_div").removeClass("createNewBar").addClass("createNewBar_off");
	$(".deleteCheckedsProm").removeClass("deleteBar").addClass("deleteBar_off");
	$(".isCheckAllsProm").attr("disabled","disabled");
}
//新增厂商可点击
function addSupClick(){
	$("#promItemStore_div").removeClass("createNewBar_off").addClass("createNewBar");
	$(".deleteCheckedsProm").removeClass("deleteBar_off").addClass("deleteBar");
	$(".isCheckAllsProm").removeAttr("disabled");
}
//选择下拉框清空系列信息
$(".selectOnchang").die("change").live("change", function(){
	$(this).parent().find("input").attr("value","");
	$(this).parent().find("input").removeClass("errorInput");
	clearDiv();
	unAddItemClick();
	unSupClickAddItem();
});

//修改促销信息
function updatePromPriceMess(promType,updatePromNo,updateUnitType,updatePromUnitNo){
	var sysDate=new Date($("#nowDate_hidden").val()).format("yyyy-MM-dd");
	var nowDate = new Date(sysDate.replaceAll('-','/') + " 00:00:00")//取服务器时间
	$("#promHOPrice").text("修改总部进价促销");
	$.ajax({
		type : 'post',
		url : ctx + '/prom/nondm/ho/updateHOPromPriceAction',
		data : {
			updatePromNo : updatePromNo,
			updateUnitType : updateUnitType,
			updatePromUnitNo : updatePromUnitNo
		},
		success : function(data) {
			getOrderDate(updatePromNo);
			if (data.length > 0) {
				$.each(data, function(index, value){
					var v_orderStr = "";
					storeInOrders.length = 0;
					var promPeriodVO = value.promPeriodVO;
					var pcmVOList = value.pcmVOList;
					if (index == 0) {
						$("#promNo").val(promPeriodVO.promNo);
						$("#subjName").val(promPeriodVO.subjName);
						$("#promSubjId").val(promPeriodVO.promNo);
						$("#buyBeginDate").val(new Date(promPeriodVO.buyBeginDate).format('yyyy-MM-dd'));
						$("#buyBeginDate").attr('preval',new Date(promPeriodVO.buyBeginDate).format('yyyy-MM-dd'));
						if (nowDate.getTime() >= promPeriodVO.buyBeginDate) {
							$("#buyBeginDate").addClass("Black");
							$("#buyBeginDate").attr("disabled","disabled");
							$("#checkUpdate").val("false");
							unSupClickAddItem();
							$("#addPromCodeMess_div").removeClass("createNewBar").addClass("createNewBar_off");
							$("#copyBar_div").removeClass("copyBar").addClass("copyBar_off");

						}
						$("#buyEndDate").val(new Date(promPeriodVO.buyEndDate).format('yyyy-MM-dd'));
						$("#buyEndDate").attr('preval',new Date(promPeriodVO.buyEndDate).format('yyyy-MM-dd'));
						$("#catlgId").val(promPeriodVO.catlgId);
						$("#catlgName").val(promPeriodVO.catlgName);
					}
					//给系列列表赋值
					$("#promCodeMess_div").append($("#addPromCode_div").find(".addPromCode_div").clone());
					var addProm = $("#promCodeMess_div");
					$(addProm.find("select")[index]).val(promPeriodVO.unitType);
					$(addProm.find("input[name='promUnitNo']")[index]).val(promPeriodVO.promUnitNo);
					$(addProm.find(".promUnitName")[index]).val(promPeriodVO.clstrName);
					//$(addProm.find("input[name='memo']")[index]).val(promPeriodVO.memo);
					
					if (index == 0) {
						if ($.trim(pcmVOList)=='') {
							return false;
						}
						//显示商品
						$(".pro_store_items").children().remove();
						$.each(pcmVOList, function(index2, pcmVO) {
							//check商品是否使用订单
							orderStr = "";
							storeInOrders.length = 0;
							if (index2 == 0) {
								if (!checkPromOrder(promPeriodVO.promNo,"","","",pcmVO.itemNo)) {
									orderStr = 1;
									v_orderStr = 1;
								}
								var objElement = setValueForItemInfo(promPeriodVO.unitType,promPeriodVO.promUnitNo,pcmVO.itemNo,pcmVO.itemName);
								$(".pro_store_items").append($(objElement).clone());
								checkOrdersFlag(orderStr);
								$(".pro_store_items .item").addClass('item_on');
								showItemStoreSupMessage(pcmVO.itemNo,promPeriodVO.promNo,promPeriodVO.unitType,promPeriodVO.promUnitNo, pcmVO.itemName,"");
								checkStoreOrders();
							} else {
								if (!checkPromOrder(promPeriodVO.promNo,"","","",pcmVO.itemNo)) {
									orderStr = 1;
									v_orderStr = 1;
								}
								var objElement = setValueForItemInfo(promPeriodVO.unitType,promPeriodVO.promUnitNo,pcmVO.itemNo,pcmVO.itemName);
								$(".pro_store_items").append($(objElement).clone());
								checkOrdersFlag(orderStr);
								searchStoreSupplierMess_json(pcmVO.itemNo,promPeriodVO.promNo,promPeriodVO.unitType,promPeriodVO.promUnitNo, pcmVO.itemName,orderStr);
							}
						});
					} else {
						$(addProm.find(".addPromCode_div")[index]).removeClass("item_on");
						if (pcmVOList != null) {
							$.each(pcmVOList, function(index, va) {
								orderStr = "";
								storeInOrders.length = 0;
								//check商品是否使用订单
								if (!checkPromOrder(promPeriodVO.promNo,"","","",va.itemNo)) {
									orderStr = 1;
									v_orderStr = 1;
								}
								searchStoreSupplierMess_json(va.itemNo,promPeriodVO.promNo,promPeriodVO.unitType,promPeriodVO.promUnitNo, va.itemName,orderStr);
							});
						}
					}
					if (v_orderStr == "1") {
						$("#promCodeMess_div .item:last").find("option:not(:selected)").remove();
						$("#promCodeMess_div .item:last").find(".promUnitNoClick").prop("readonly",true);
					}
				});
				addPromItemStoreMess();
				var checkUpdate = $.trim($("#checkUpdate").val());
				if (checkUpdate !="" ){
					$("#promCodeMess_div .item").find("option:not(:selected)").remove();
					$("#subjName").addClass("Black");
					$("#subjName").prop("readonly",true);
					$(".promUnitNoClick").addClass("Black");
					$(".promUnitNoClick").prop("readonly",true);
					$(".promBuyPrices").addClass("Black");
					$(".promBuyPrices").prop("readonly",true);
					$("#updatePriceAll").addClass("Black");
					$("#updatePriceAll").prop("readonly",true);
					
					//$("input[name='memo']").addClass("Black");
					//$("input[name='memo']").prop("readonly",true);
					
					$("input[name='promBuyPrice']").addClass("Black");
					$("input[name='promBuyPrice']").prop("readonly",true);
					$(".isChecksProm").prop("disabled",true);
					
					unAddItemClick();
				} else {
					var selectVal = $($("#promCodeMess_div .item_on").find("select")).val();
					if (selectVal == 0) {
						//unAddItemClick();
						addSupClick();
					} else {
						supClickAddItem();
					}
				}
				v_prom_str = "";
				var promCodeMess_div = $("#promCodeMess_div").find(".addPromCode_div");
				$.each(promCodeMess_div, function(index, value){
					v_prom_str = v_prom_str + $(value).find("select").val() + "," + $(value).find("input[name='promUnitNo']").val() + "-";
				});
			}
		}
	});	
}

//获取订单使用的时间
function getOrderDate(dmPromNo){
	$.ajax({
		type : 'post',
		url : ctx + '/prom/nondm/ho/getOrdersDate',
		data : {dmPromNo : dmPromNo},
		success : function(data){
			var orderDates = data.orderStoreList;
			if (orderDates !=null && orderDates.length > 0) {
				$.each(orderDates,function(i,order){
					var v_ordDateJson = {'ordDate':order.ordDate,'planRecptDate':order.planRecptDate};
					ordersDateMap.push(v_ordDateJson);
				});
			}
		}
	});
}

//**输入小数值 double_text*/验证保留3位小数
function inputToInputDoubleNumber(obj,evt){
	var promBuyPriceProp = $(obj).attr("class");
	if (promBuyPriceProp.indexOf("Black") >= 0) {
		return ;
	}
	if ($(obj).val().indexOf(".") < 0) {
		if ($(obj).val()!=''&&!(/^\d{0,6}$/).test($(obj).val())) {
			if($(obj).val()==' '){
				$(obj).val('');
				return false;
			}
			if($(obj).val()!=''){
				$(obj).val($(obj).attr('preval'));
			}
			return true;
		}
		$(obj).attr('preval',$(obj).val());
	} else {
		if ($(obj).val()!=''&&!(/^\d+[.]{0,1}\d{0,4}$/).test($(obj).val())) {
			if($(obj).val()==' '){
				$(obj).val('');
				return false;
			}
			if($(obj).val()!=''){
				$(obj).val($(obj).attr('preval'));
			}
			return true;
		}
		$(obj).attr('preval',$(obj).val());
	}
	if($(obj).val()!=''){
		$(obj).removeClass('errorInput');
		$(obj).attr("title",'');

	}
	var event=evt?evt:(window.event?window.event:null);//兼容IE和FF
	if (event.keyCode==13){
	    if($(obj).val()==''||obj.name=='promBuyPrice'){
	    	//促销进价为空及门店厂商列表输入框不触发
	    	return;
	    }
	    try{
	            obj.blur();//回车触发blur事件
	    }
	    catch(e){
	    	//nothing to do
	    };
	 }
}
///**输入正数值 double_text*/验证
function inputToInputNumber(obj){
        if ($(obj).val()!=''&&!(/^\d{0,8}$/).test($(obj).val())) {
            if($(obj).val()==' '){
                $(obj).val('');
                return false;
            }
            if($(obj).val()!=''){
                $(obj).val($(obj).attr('preval'));
            }
            return true;
        }
        $(obj).attr('preval',$(obj).val());

        if($(obj).val()!=''){
        	$(obj).removeClass('errorInput');
        }
}
///**输入正数值 double_text*/验证
function inputNumbers(obj){
    if ($(obj).val()!=''&&!(/^\d{0,12}$/).test($(obj).val())) {
        if($(obj).val()==' '){
            $(obj).val('');
            return false;
        }
        if($(obj).val()!=''){
            $(obj).val($(obj).attr('preval'));
        }
        return true;
    }
    $(obj).attr('preval',$(obj).val());

    if($(obj).val()!=''){
    	$(obj).removeClass('errorInput');
    }
}
//手动输入代号查询信息
$(".promUnitNoClick").die("focus").live("focus",function(){
	$(this).removeClass("errorInput");
	var unitType = $.trim($(this).parent().parent().find("select").val());
	var promNo = $(this).val();
	setCurrPromUnitNo(unitType,promNo);
});

function setCurrPromUnitNo(unitType,promNo){
	var prom_strs = "";
	var promCodeMess_div = $("#promCodeMess_div").find(".addPromCode_div");
	$.each(promCodeMess_div, function(index, value){
		prom_strs = prom_strs + $(value).find("select").val() + "," + $(value).find("input[name='promUnitNo']").val() + "-";
	});
	$("#prom_str_hidden").val(prom_strs);
	$("#promNo_str_hidden").val(promNo);
	$("#unitType_str_hidden").val(unitType);
}

/**
 * 同类型代号是否已存在 unitType或promNo为空放行,否则比较三个参数
 * 
 * @param unitType
 * @param promNo
 * @param index 序号,作用,检查是否是当前对象
 * @returns
 */
function checkPromNoExists(unitType,promNo,index){
	if($.trim(unitType)=='' || $.trim(promNo)==''){
		return false;
	}
	var existFlag = false;
	$('#promCodeMess_div .item').each(function(){
		var element = $(this);
		if(element.index()!=index && unitType==$(element).find('select[name="unitType"]').val() && promNo==$(element).find('input[name="promUnitNo"]').val()){
			existFlag = true;
			return;
		}
	});
	return existFlag;
}

$(".promUnitNoClick").die("blur").live("blur",function(){
	var promNo = $.trim($(this).val());
	if (!IsNum(promNo)) {
		$(this).val('');
		return false;
	}
	promotionUnitAdd($(this));
});
//验证字符串是否为数字
function IsNum(s)
{
    if(s!=null){
        var r,re;
        re = /\d*/i; //\d表示数字,*表示匹配多个数字
        r = s.match(re);
        return (r==s)?true:false;
    }
    return false;
}

$(".promUnitNoClick").die("keydown").live("keydown",function(ev){
	var e = ev || window.event || arguments.callee.caller.arguments[0];
	if (e.keyCode && e.keyCode == 13 && $(this).val()!='') {
		promotionUnitAdd($(this));
	}
});

function promotionUnitAdd(obj){
	var prom_str = $("#prom_str_hidden").val();
	var promNo_str = $("#promNo_str_hidden").val();
	var unitType_str_hidden = $("#unitType_str_hidden").val();
	var unitType = $.trim($(obj).parent().prev().val());
	var promNo = $.trim($(obj).val());
	var catlgId = $.trim($("#catlgId").val());
	var promUnitNo = $(obj).parent().parent().find("input[name='promUnitNo']");
	var promUnitName = $(obj).parent().parent().find(".promUnitName");
	var promBuyPriceHead=$(obj).parent().parent().find(".promBuyPrices");
	var flgs = false;
	var itemName = "";
	if (promNo_str != promNo) {
		setCurrPromUnitNo($(obj).parent().prev().val(),$(obj).val());
		if(promNo_str!=''){
			$(obj).parent().next().next().val('');
			$(".pro_store_items").children().remove();
			$("#promItemStoreMess_div").children().remove();
			$("#updatePriceAll").val('');
			var supJson = {'promUnitNo':promNo_str,'unitType':unitType_str_hidden};
			delCodeMess.push(supJson);
			deletePromMess(unitType_str_hidden, promNo_str);
		  }
		if (!checkPromNoExists(unitType,promNo,$(obj).parent().parent().parent().index())) {
			if (promNo != "") {
				if (itemSupMess.length > 0) {
					$.each(itemSupMess, function(index, value){
						if (value.indexOf('"promUnitNo":"'+promNo+'"') > 0 && value.indexOf('"unitType":"'+unitType+'"') > 0) {
							var valus = value.split("--");
							$.each(valus, function(idx, val){
								var v_val = val.substring(1,val.length-1);
								items = v_val.split(",");
								var v_itemName = items[10].split(":")[1];
								itemName = v_itemName.substring(1,v_itemName.length-1);
								return;
							});
							flgs = true;
							return;
						}
					});
				}
				if (flgs) {
					$("#promCodeMess_div .item_on .promUnitName").val(itemName);
					acquirePromStoreMess(unitType, promNo);
					$(obj).parent().next().next().focus();
				} else {
					isLoadData = true;
					$.ajax({
						type : "post",
						url : ctx + '/prom/nondm/ho/showUnitDataAction',
						data : {
							unitType : unitType,
							itemNo : promNo,
							catlgId : catlgId,
							pageNo : 1,
							pageSize : 1
						},
						success : function(result) {
							isLoadData = false;
							var unitName_v = result["unitName"];
							if (unitName_v != "") {
								if (prom_str.indexOf(unitType + "," + promNo + "-") < 0) {
									$.each(delCodeMess,function(ind, val){
										if (val.promUnitNo == promNo && val.unitType == unitType) {
											delCodeMess.remove(ind);
											return false;
										}
									});
									promUnitNo.val(promNo);
									promUnitName.val(unitName_v);
									$("#promItemStoreMess_div").children().remove();
									if (unitType == 0) {
										if (!checkNotRepetitionItem(promNo)) {
											//$("#showDeleteItems").attr("unitNoValue", "");
											promUnitName.val("");
											promUnitNo.val("");
											$("#updatePriceAll").val('');
											promBuyPriceHead.val('');
											top.jAlert('warning', '商品已存在!', '提示消息');
											clearDiv();
										} else {
											//添加数据
											if (result.storeList == null) {
												top.jAlert('warning', '该单品下没有厂商!', '提示消息');
												$("#promCodeMess_div .item_on").find(".promUnitNoClick").val('');
												$("#promCodeMess_div .item_on").find(".promUnitName").val('');
												return false;
											}
											addAllItemsStoreDate(unitType,promNo,result.itemNoList,result.storeList,"");
											acquirePromStoreMess(unitType, promNo);
											unAddItemClick();
											addSupClick();
										}
									} else {
										if (!addAllItemsStoreDate1(unitType,promNo,result.itemNoList,result.storeList,"")){
											return false;
										}
										acquirePromStoreMess(unitType, promNo);
										addItemClick();
										addSupClick();
									}
								}
								$(obj).parent().next().next().focus();
							} else {
								//$("#showDeleteItems").attr("unitNoValue", "");
								promUnitName.val("");
								promUnitNo.val("");
								$("#updatePriceAll").val('');
								promBuyPriceHead.val('');
								top.jAlert('warning', '该代号不存在，请重新输入！', '提示消息');
								clearDiv();
							}
						}
					});
				}
			} else {
				promUnitName.val("");
				promUnitNo.val("");
				$("#updatePriceAll").val('');
				promBuyPriceHead.val('');
				clearDiv();
			}
		} else {
			if (unitType == 0) {
				top.jAlert('warning', '该促销下的单品已存在!', '提示消息');
				$("#promCodeMess_div .item_on").find("input[name='promUnitNo']").val("");
				$("#promCodeMess_div .item_on").find(".promUnitName").val('');
			} else if (unitType == 1) {
				top.jAlert('warning', '该促销下的同品项系列已存在!', '提示消息');
				$("#promCodeMess_div .item_on").find("input[name='promUnitNo']").val("");
				$("#promCodeMess_div .item_on").find(".promUnitName").val('');
			} else if (unitType == 2) {
				top.jAlert('warning', '该促销下的非同品项系列已存在!', '提示消息');
				$("#promCodeMess_div .item_on").find("input[name='promUnitNo']").val("");
				$("#promCodeMess_div .item_on").find(".promUnitName").val('');
			}
			clearDiv();
			return false;
		}
	}
}

function deletePromMess(unitType, unitNo){
		$.each(itemSupMess, function(index, value){
			if(value){
			if (value.indexOf('"promUnitNo":"'+unitNo+'"') >= 0 && value.indexOf('"unitType":"'+unitType+'"') >= 0) {
				itemSupMess.remove(index);
				deletePromMess(unitType, unitNo);
			}
			if (itemSupMess.length > 0) {
				if (index == itemSupMess.length-1){
					return false;
				}
			} else {
				return false;
			}
			}
		});	
}

$("input[name='promBuyPrice']").die("keyup").live("keyup",function(evt){
	 var event=evt?evt:(window.event?window.event:null);//兼容IE和FF
	  if (event.keyCode==13){
		  var nextVal=$(this).parent().parent().next().find("input[name='promBuyPrice']").val();
		  if(nextVal!=undefined){
			 $(this).parent().parent().next().find("input[name='promBuyPrice']").focus().val(nextVal);
		  }
	  }
});

$("input[name='promBuyPrice']").die("blur").live("blur",function(){
	var readOnly = $.trim($(this).attr("readonly"));
	if (readOnly != "") {
		return false;
	}
	var unitNo = $("#promItemStore_div").attr("checkPromNo");
	var itemNo = $("#promItemStore_div").attr("checkItemNo");
	var unitType = $("#promItemStore_div").attr("checkUnitType");
	
	
	var promBuyPrice = $.trim($(this).val());
	var normBuyPrice = $.trim($(this).parent().find("input[name='normBuyPrice']").val());
	var buyWhen = $.trim($(this).attr("buyWhen"));
	if(promBuyPrice!=''){$('#promCodeMess_div .item_on .promBuyPrices').val('');$('#updatePriceAll').val('');}
	var buyPriceLimit = $.trim($(this).attr("buyPriceLimit"));
	if (promBuyPrice != "" ) {
		if (buyWhen == 2) {
    		if(buyPriceLimit !="" && (Number(promBuyPrice)>Number(buyPriceLimit))){
    			top.jAlert('warning', '促销进价必须等于小于买价限制：'+buyPriceLimit+'元!', '提示消息');
				$(this).addClass("errorInput");
				$(this).attr("title",'促销进价必须等于小于买价限制：'+buyPriceLimit+'元!');
				$(this).val("");
  	    	}else{
  	    		$(this).removeClass("errorInput");
    		}
		} else {
			if (Number(promBuyPrice) >= Number(normBuyPrice)) {
				top.jAlert('warning', '促销进价要小于正常进价!', '提示消息');
				$(this).addClass("errorInput");
				$(this).attr("title","促销进价要小于正常进价!");
				$(this).val("");
			} else {
				$(this).removeClass("errorInput");
				$(this).attr("title","");
			}
		}
	} else {
		$(this).addClass("errorInput");
		$(this).attr("title","促销进价不能为空");
	}
	$.each(itemSupMess, function(index, value){
		if (itemSupMess[index].indexOf('"promUnitNo":"'+unitNo+'"') >= 0 && itemSupMess[index].indexOf('"itemNo":"'+itemNo+'"') >= 0 && itemSupMess[index].indexOf('"unitType":"'+unitType+'"') >= 0) {
			itemSupMess.remove(index);
			return false;
		}
	});	
	addPromItemStoreMess();
	sameItemsSamePrices(unitType,unitNo,$(this).val(),$(this));
	
});
/*同品项同价*/
function sameItemsSamePrices(unitType,unitNo,promBuyPrice,obj){
	var batchPriceChngInd=$(obj).parent().find("input[name='batchPriceChngInd']").val();
	var storeNo = $.trim($(obj).parent().find("input[name='storeNo']").val());
	//同品项同价
	if(unitType!=1||batchPriceChngInd!=1){
		return;
	}
	$.each(itemSupMess, function(index, value){
		if (itemSupMess[index].indexOf('"promUnitNo":"'+unitNo+'"') >= 0 &&itemSupMess[index].indexOf('"unitType":"'+unitType+'"') >= 0) {
			var itemStoreArr=itemSupMess[index].split("--");
			if(!itemStoreArr){
				return true;
			}
			var v_str = "";
			var s_str="--";
			$.each(itemStoreArr, function(itemIndex, itemValue){
				if (itemValue.indexOf('"storeNo":"'+storeNo+'"') > 0 ){
					var itemStoreJson=JSON.parse(itemValue);
					itemStoreJson.promBuyPrice=promBuyPrice;
					var str = JSON.stringify(itemStoreJson)+s_str;
					v_str = v_str + str;
					//alert(itemValue);
				}else{
					var str = itemValue+s_str;
					v_str = v_str + str;
				}
			});
			v_str = v_str.substring(0,v_str.length - 2);
			//alert(v_str.length+"||"+itemSupMess[index].length);
			itemSupMess[index]=v_str;
			
		}
	});	
}
function showItemStoreSupMessage(itemNo,promSubjId,unitType,promUnitNo,itemName,orderStr){
	editMess(itemNo,promUnitNo,unitType);
	$.ajax({
		async : false,
		type : 'post',
		url : ctx + '/prom/nondm/ho/detailItemStoreList',
		data : {
			 itemNo : itemNo,
			 promSubjId : promSubjId,
			 unitNo :promUnitNo,
			 promUnitNo : promUnitNo,
			 unitType :unitType,
			 itemName :itemName,
			 checkUpdate :'',
			 orderStr : orderStr
		},
		success : function(data) {
			$("#promItemStoreMess_div").html(data);
		}
	});
}

function addSearchItemStoreSup(itemNo,unitNo,catlgId,unitType,itemName,normBuyPrice){
	editMess(itemNo,unitNo,unitType);	
	$.ajax({
		async : true,
		url : ctx + '/prom/nondm/ho/searchStoreMessageList',
		type : "post",
		dataType : "html",
		data : {
			itemNo : itemNo,
			promUnitNo : unitNo,
			catlgId : catlgId,
			clstrId : unitType,
			unitType : unitType,
			unitNo : unitNo,
			itemName : itemName,
			normBuyPrice : normBuyPrice,
			promBuyPrice : '0'
		},
		success : function(result) {
			v_store_str = "";
			if ($.trim(result)!= '') {
				$("#promItemStoreMess_div").html(result);
				v_store_str = "notempty";
				addPromItemStoreMess();
			} else {
				v_store_str =  "isempty";
			}
		}
	});
}

//促销代号信息赋值
function editMess(itemNo,promUnitNo,unitType){
	$(".deleteCheckedsProm").attr("checkItemNo",itemNo);
	$(".deleteCheckedsProm").attr("checkPromNo",promUnitNo);
	$(".deleteCheckedsProm").attr("checkUnitType",unitType);
	
	$("#promItemStore_div").attr("checkItemNo",itemNo);
	$("#promItemStore_div").attr("checkPromNo",promUnitNo);
	$("#promItemStore_div").attr("checkUnitType",unitType);
}

//手动查询课别
function pr_searchSectionMess(sectionNo){
	$.ajax( {
		type : 'post',
		url : ctx + '/catalog/searchSectionMessAction',
		data : {
			catlgId : sectionNo},
		success : function(data) {
			var sectionInfoVO = data.sectionInfoVO;
			if (sectionInfoVO != null) {
	 			$("input[name='catlgName']").val(sectionInfoVO.catlgName);
	 			$("input[name='catlgName']").attr("title",sectionInfoVO.catlgName);
			} else {
				top.jAlert("warning","没有该课别, 请重新输入", "提示信息");
				$("input[name='catlgName']").val('');
				$("#catlgId").val('');	
			}
		}
	});
}

//手动查询代号
function pr_searchPromUnitName(unitNo,unitType){
	$.ajax( {
		type : 'post',
		url : ctx + '/prom/nondm/ho/searchPromUnitNameAction',
		data : {
			itemNo : unitNo,
			unitType : unitType
		},
		success : function(data) {
			if (data.unitName != "") {
	 			$("#unitName").val(data.unitName);
	 			$("#unitName").attr("title",data.unitName);
			} else {
				top.jAlert("warning","没有找到对应信息, 请重新输入", "提示信息");
				$("#unitName").val('');
				$("#unitNo").val('');
			}
		}
	});
}

//所有厂商信息JSON
function storeSupplierMess_json(itemNo,unitNo,catlgId,unitType,itemName,pbpValue,checkOrders){
	var storesList = "";
	$.ajax({
		async : false,
		url : ctx + '/prom/nondm/ho/getPromItemSupListAction',
		type : "post",
		dataType : "json",
		data : {
			itemNo : itemNo,
			promUnitNo : unitNo,
			catlgId : catlgId,
			clstrId : unitType
		},
		success : function(result) {
			var v_str = "";
			if (result.storeList != null) {
				$.each(result.storeList, function(index, store) {
					var str = '{"unitType":"'+unitType+'","promUnitNo":"'+unitNo+'","itemNo":"'+itemNo+'","storeNo":"'+store.storeNo+'","storeName":"'+store.storeNo+'-'+$.trim(store.storeName)+'","promSupNo":"'+store.stMainSupNo+'","comName":"'+$.trim(store.mainComName)+'","statusName":"'+getDictValue('ITEM_BASIC_STATUS',store.status)+'","normBuyPrice":"'+store.normBuyPrice+'","promBuyPrice":"'+pbpValue+'",'+'"normSellPrice":"'+$.trim(store.normSellPrice) + '","itemName":"'+itemName+'",'+'"buyPriceLimit":"'+$.trim(store.buyPriceLimit) + '","buyWhen":"'+$.trim(store.buyWhen) +'","checkOrders":"'+checkOrders+'","batchPriceChngInd":"'+$.trim(store.batchPriceChngInd)+'"}--';
					v_str = v_str + str;
				});
				v_str = v_str.substring(0,v_str.length - 2);
				itemSupMess.push(v_str);
				storesList = v_str;
			}
		}
	});
	return storesList;
}

//查询修改促销信息下的厂商
function searchStoreSupplierMess_json(itemNo,promSubjId,unitType,promUnitNo,itemName,checkOrders){
	$.ajax({
		async : false,
		type : 'post',
		url : ctx + '/prom/nondm/ho/searchItemStoreList',
		data : {
			itemNo: itemNo,
			promSubjId: promSubjId,
			unitType:unitType,
			promUnitNo:promUnitNo
		},
		success : function(data) {
			var v_str = "";
			$.each(data, function(index, val) {
				checkOrders = "";
				if (storeInOrders.length > 0) {
					$.each(storeInOrders, function(index, storeNo){
						if (val.storeNo == storeNo) {
							checkOrders = "1";
							return false;
						}
					});
				}
				var str = '{"unitType":"'+unitType+'","promUnitNo":"'+promUnitNo+'","itemNo":"'+itemNo+'","storeNo":"'+val.storeNo+'","storeName":"'+val.storeNo+'-'+$.trim(val.storeName)+'","promSupNo":"'+val.supNo+'","comName":"'+$.trim(val.comName)+'","statusName":"'+getDictValue('ITEM_BASIC_STATUS',val.status)+'","normBuyPrice":"'+$.trim(val.normBuyPrice)+'","promBuyPrice":"'+parseFloat(val.promBuyPrice)+'","normSellPrice":"'+$.trim(val.normSellPrice) + '","itemName":"'+itemName+'",'+'"buyPriceLimit":"'+$.trim(val.buyPriceLimit) + '","buyWhen":"'+$.trim(val.buyWhen) +'","checkOrders":"'+checkOrders+'","batchPriceChngInd":"'+$.trim(val.batchPriceChngInd)+'"}--';
				v_str = v_str + str;
			});
			v_str = v_str.substring(0,v_str.length - 2);
			itemSupMess.push(v_str);
		}
	});
}

function acquirePromStoreMess(unitType, promUnitNo){
	var checkStore = true;
	$.each(itemSupMess, function(index, value){
		if (value.indexOf('"promUnitNo":"'+promUnitNo+'"') >= 0 && value.indexOf('"unitType":"'+unitType+'"') >= 0) {
			var valus = value.split("--");
			if (checkStore) {
				$.each(valus, function(idx, json){
					var v_str = "";
					var jsonData = JSON.parse(json);
					editMess(jsonData.itemNo,promUnitNo,unitType);
					setValueForItemStoreInfo(jsonData,jsonData.itemName);
					$("#promItemStoreMess_div").append($('#itemStoreInfoModel .ig').clone());
					unShowStoreDom(jsonData.checkOrders);
					if ($.trim(jsonData.promBuyPrice) == "") {
						$("#promItemStoreMess_div .ig:last .errorInput").val('');
					}else{
						$("#promItemStoreMess_div .ig:last .errorInput").removeClass('errorInput');
					}
					if (idx == 0) {
						editMess(jsonData.itemNo,promUnitNo,unitType);
					}
					//设置item属性模板并加到左边商品列表
					if(idx==0){
						var objElement = setValueForItemInfo(unitType,promUnitNo,jsonData.itemNo,jsonData.itemName);
						$(".pro_store_items").append($(objElement).clone());
						$(".pro_store_items .item").addClass('item_on');
					}
					if (jsonData.checkOrders == 1) {
						checkOrdersFlag(jsonData.checkOrders);
					}
				});
				checkStore = false;
			} else {
				$.each(valus, function(idx, val){
					var jsonData = JSON.parse(val);
					if (idx == 0) {
						var ordersStr = "";
						//设置item属性模板并加到左边商品列表
						var objElement = setValueForItemInfo(unitType,promUnitNo,jsonData.itemNo,jsonData.itemName);
						$(objElement).removeClass("item_on");
						$(".pro_store_items").append($(objElement).clone());
					}
					if (jsonData.checkOrders == 1) {
						checkOrdersFlag(jsonData.checkOrders);
					}
				});
			}
		}
	});	
	$("#promItemStoreMess_div").scrollTop(0);
	$("#promItemStoreMess_div .ig").each(function(index, value){
		var promItemStoreMess_div_ig=$(this);
		var itemNo = $(value).find("input[name='itemNo']").val();
		var storeNo = $(value).find("input[name='storeNo']").val();
		existsItemStore(itemNo,storeNo,value,promItemStoreMess_div_ig);
	});
	var promItemStoreMess_div = $("#promItemStoreMess_div").find(".ig");
	if (promItemStoreMess_div.length > 0) {
		$.each(promItemStoreMess_div, function(index, value){
			var normBuyPrice = $.trim($(value).find("input[name='normBuyPrice']").val());
			var pro_store_items = $.trim($(value).find("input[name='checkOrders']").val());
			var promBuyPrice = $.trim($(value).find("input[name='promBuyPrice']").val());

			//if (pro_store_items == "") {
				//检查成本时点
				checkBuyWhen(value,promBuyPrice,normBuyPrice);
			//}
		});
	}
}

//数组拼成Json
function strJson(jsonObjectList){
	var jsonStr = "";
	if (jsonObjectList.length == 0) {
		return "";
	}
	$.each(jsonObjectList,function(index, value){
		jsonStr = jsonStr + JSON.stringify(value) + "--";
	});
	return jsonStr.substring(0,jsonStr.length-2);
}

//验证是否有重复的商品
function checkNotRepetitionItem(itemNo){
	var flag = true;
	var v_promUnitNo = $.trim($("#promCodeMess_div .item_on").find(".promUnitNoClick").val());
	var v_unitType = $.trim($("#promCodeMess_div .item_on").find("select").val());
	var promCodeMess_div = $("#promCodeMess_div .item").not(".item_on");
	var itemNo_str = $.trim(filtrationItemNo[v_unitType+"-"+v_promUnitNo]);
	$.each(promCodeMess_div,function(ind, val){
		var unitType = $(val).find(".selectOnchang").val();
		var promUnitNo = $(val).find(".promUnitNoClick").val();
		$.each(itemSupMess, function(index, value){
			if (value.indexOf('"unitType":"'+unitType+'"') >= 0 && value.indexOf('"promUnitNo":"'+promUnitNo+'"') >= 0) {
				if (value.indexOf('"itemNo":"'+itemNo+'"') >= 0) {
					flag = false;
					itemNo_str = itemNo_str + "," + itemNo;
					return false;
				}
			}
		});
		if (!flag) {
			return false;
		}
	});
	filtrationItemNo[v_unitType+"-"+v_promUnitNo]=itemNo_str;
	return flag;
}

var update_ordDate = "";
var update_planRecptDate = "";
//check促销订单是否存在或已经使用
function checkPromOrder(promNo,falg,startDate,endDate,itemNo){
 	var returnType = false;
	$.ajax({
		async : false,
		url : ctx + '/prom/nondm/ho/checkPromIsInOrder',
		type : "post",
		dataType : "json",
		data : {
			promNo : promNo,
			falg : falg,
			startDate : startDate,
			endDate : endDate,
			itemNo : itemNo
		},
		success : function(result) {
	        if(result.inOrder == '0'){
	        	returnType = true;
	        } else {
	        	var orderStoreList = result.orderStoreList;
				$.each(orderStoreList,function(index, storeNo){
					storeInOrders.push(storeNo.storeNo);
				});
	        }
		}
	});
	return returnType;
}

//check促销订单是否存在或已经使用
function checkPromItem(promNo,startDate,endDate,itemNo){
	var sysDate=new Date($("#nowDate_hidden").val()).format("yyyy-MM-dd");//取服务器时间
	var nowDate = new Date(sysDate.replaceAll('-','/') + " 00:00:00")
	var returnType = false;
	if (nowDate.getTime() < startDate) {
		if (checkPromOrder(promNo,0,null,null,itemNo)){
			returnType = true;
		}
	}
	return returnType;
}

//验证系列商品是否被订单使用
function checkPromCodeOrder(unitType, promUnitNo){
	var checkStore = true;
	$.each(itemSupMess, function(index, value){
		if (value.indexOf('"promUnitNo":"'+promUnitNo+'"') >= 0 && value.indexOf('"unitType":"'+unitType+'"') >= 0) {
			var valus = value.split("--");
			$.each(valus, function(idx, val){
				checkPromItem(promNo,startDate,endDate,itemNo)
				var v_str = "";
				var jsonData = JSON.parse(val);
				var str = '<div class="ig">';
				str = str + '<input type="checkbox" class="fl_left ck isChecksProm" />';
				str = str + '<input name="unitType" type="hidden" value="'+jsonData.unitType+'" />';
				str = str + '<input name="promUnitNo" type="hidden" value="'+jsonData.promUnitNo+'" />';
				str = str + '<input name="itemNo" type="hidden" value="'+jsonData.itemNo+'" />';
				str = str + '<input name="storeNo" type="hidden" value="'+jsonData.storeNo+'" />';
				str = str + '<input name="storeName" type="text" readonly="readonly" class="inputText w15 fl_left Black" value="'+jsonData.storeName+'" />';
				str = str + '<div class="iconPut w12_5 fl_left" >';
				str = str + '<input name="promSupNo" class="w75" readonly="readonly" type="text" value="'+jsonData.promSupNo+'" />';
				str = str + '<div class="ListWin"></div>';
				str = str + '</div>';
				str = str + '<input name="comName" type="text" class="inputText w25 fl_left Black" readonly="readonly" value="'+jsonData.comName+'" ></input>';
				str = str + '<input name="statusName" type="text" class="inputText w12_5 fl_left Black" readonly="readonly" value="'+jsonData.statusName+'" />';
				str = str + '<input name="normBuyPrice" type="text" readonly="readonly" class="inputText w12_5 fl_left Black" value="'+jsonData.normBuyPrice+'" />';
				if ($.trim(jsonData.promBuyPrice) == "") {
					str = str + '<input name="promBuyPrice" type="text" class="inputText w12_5 fl_left errorInput" onkeyup="inputToInputDoubleNumber(this,event)" value="" />';
					str = str + '<input name="promBuyPrice" type="text" class="inputText w12_5 fl_left errorInput" buyPriceLimit="'+jsonData.buyPriceLimit+'" buyWhen="'+jsonData.buyWhen+'" onkeyup="inputToInputDoubleNumber(this,event)" value="" />';
				} else {
					str = str + '<input name="promBuyPrice" type="text" class="inputText w12_5 fl_left" buyPriceLimit="'+jsonData.buyPriceLimit+'" buyWhen="'+jsonData.buyWhen+'" onkeyup="inputToInputDoubleNumber(this,event)" value="'+jsonData.promBuyPrice+'" />';
				}
				str = str + '<input name="buyPriceLimit" type="hidden" value="'+$.trim(jsonData.buyPriceLimit)+'" ></input>';
				str = str + '<input name="buyWhen" type="hidden" value="'+$.trim(jsonData.buyWhen)+'" ></input>';
				str = str + '<input name="itemName" type="hidden" value="'+jsonData.itemName+'" />';
				str = str + '</div>';
				$("#promItemStoreMess_div").append(str);
				if (unitType == 0) {
					if (idx == 0) {
						v_str = '<div class="item item_on" ><span class="pstb_1 promItemStoreClick" pbpValue="" unitTypeValue="' + unitType + '" unitNoValue="' + promUnitNo + '" itemNoValue="' + jsonData.itemNo + '" itemNameValue="' + jsonData.itemName + '" >' + jsonData.itemNo + '-' + jsonData.itemName + '</span></div>';
						editMess(jsonData.itemNo,promUnitNo,unitType);
					}
				} else {
					if (idx == 0) {
						v_str = '<div class="item item_on" ><span class="pstb_1 promItemStoreClick" pbpValue="" unitTypeValue="' + unitType + '" unitNoValue="' + promUnitNo + '" itemNoValue="' + jsonData.itemNo + '" itemNameValue="' + jsonData.itemName + '" >' + jsonData.itemNo + '-' + jsonData.itemName + '</span><span class="pstb_del2 delItemSupMess"></span></div>';
						editMess(jsonData.itemNo,promUnitNo,unitType);
					}
				}
				$(".pro_store_items").append(v_str);
			});
		}
	});	
}

//查询促销类型信息
function showChildTr(obj){
	var prev = $(obj).parent();
	if(!$(prev).next().hasClass('trSpecial')){
		var promNo = $.trim(prev.children('td').eq(1).html());
		var unitNo = $.trim($("#unitNo").val());
		$.ajax({
			async : false,
			url : ctx + '/prom/nondm/ho/searchPromotionSeriesListMessage',
			type : "post",
			data : {
				promNo : promNo
			},
			success : function(data) {
				prev.after(data);
			}
		});
	}
	showBorther(obj);
	if (unitNo != "") {
		$(obj).parent().next().find("."+unitNo).addClass("red");
	}
}

function showBorther(obj) {
	if($(obj).hasClass('tr_close')){
		var $borther = $(obj).parent().next(".trSpecial");
		$(obj).addClass("tr_open");
		$(obj).removeClass("tr_close");
		$borther.removeClass("Bar_off");
	}
	else{
		hideBorther(obj);
	}
}
function hideBorther(obj) {
    var $borther = $(obj).parent().next(".trSpecial");
    $(obj).addClass("tr_close");
    $(obj).removeClass("tr_open");
    $borther.addClass("Bar_off");
}

//选择系列类型事件
function selectUnitTypeClick(obj){
	//$("#memo").val('');
	var unitType = $(obj).val();
	var promNo = $("#promNoDetail").val();
	getPromCodeMessList(promNo,unitType);
	//var select = $("#unitNoDetail");
	//(select.children().size());
	//if (select.children().size() > 1) {
		$.ajax({
			type : 'post',
			url : ctx + '/prom/nondm/ho/showPromItemStoreDetail?ti='+(new Date()).getTime(),
			data : {
				promSubjId : promNo,
				unitType : unitType
			},
			success : function(data) {
				$("#promItemStoreDiv").html(data);
			}
		});
	//} else {
	//	$(".pro_store_items").children().remove();
	//	$("#promItemStoreMess_div").children().remove();
	//}
}

//选择系列号事件
function selectUnitNoClick(obj){
	var promUnitNo = $(obj).val();
	var unitType = $.trim($("#unitTypeDetail").val());
	var promNo = $("#promNoDetail").val();
	$.ajax({
		//async : false,
		type : 'post',
		url : ctx + '/prom/nondm/ho/showPromItemStoreDetail?ti='+(new Date()).getTime(),
		data : {
			promUnitNo : promUnitNo,
			promSubjId : promNo,
			unitType : unitType
		},
		success : function(data) {
			$("#promItemStoreDiv").html(data);
		}
	});
}

//显示促销厂商信息
function showPromSupMess(){
	var promNo = $("#promNoDetail").val();
	$.ajax({
		type : 'post',
		url : ctx + '/prom/nondm/ho/showPromItemStoreDetail',
		data : {
			promSubjId : promNo
		},
		success : function(data) {
			$("#promItemStoreDiv").html(data);
		}
	});
}

//根据系列类型取系列
function getPromCodeMessList(promNo,unitType){
	$.ajax( {
		type : "post",
		url : ctx + '/prom/nondm/ho/searchHOPromPricesAction',
		data : {
			promNo : promNo,
			unitType : unitType
		},
		success : function(data) {
			var promPeriodVOList = data.promPeriodVOList;
			var select = $("#unitNoDetail");
			select.empty();
			select.append("<option value=''>全部</option>");
			if (promPeriodVOList.length > 0) {
				$.each(promPeriodVOList, function(index, value) {
					var option = "<option title=" +value.unitNo + "-" + value.clstrName + " value=" + value.unitNo + ">" +value.unitNo + "-" + value.clstrName + "</option>";
					select.append(option);
				});
			}
		}
	});
}

$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || null);
		} else {
			o[this.name] = this.value || null;
		}
	});
	return o;
};

//检查成本时点
function checkBuyWhen(obj,promPrice,normBuyPrice){
	var buyWhen  = $.trim($($(obj).find("input[name='buyWhen']")).val());
	var buyPriceLimit = $.trim($($(obj).find("input[name='buyPriceLimit']")).val());
	if (promPrice != "" ) {
		if (buyWhen == 2) {
    		if(buyPriceLimit !="" && (Number(promPrice)>Number(buyPriceLimit))){
				$(obj).find("input[name='promBuyPrice']").val("");
				$(obj).find("input[name='promBuyPrice']").addClass("errorInput");
				$(obj).find("input[name='promBuyPrice']").attr("title","促销进价要等于小于买价限制:"+buyPriceLimit+"元!");
  	    	}else{
  	    		$(obj).find("input[name='promBuyPrice']").val(promPrice);
				$(obj).find("input[name='promBuyPrice']").removeClass("errorInput");
				$(obj).find("input[name='promBuyPrice']").attr("title","");
    		}
		} else {
			if (Number(promPrice) >= Number(normBuyPrice)) {
				$(obj).find("input[name='promBuyPrice']").val("");
				$(obj).find("input[name='promBuyPrice']").addClass("errorInput");
				$(obj).find("input[name='promBuyPrice']").attr("title","促销进价要小于正常进价!");
			} else {
				$(obj).find("input[name='promBuyPrice']").val(promPrice);
				$(obj).find("input[name='promBuyPrice']").removeClass("errorInput");
				$(obj).find("input[name='promBuyPrice']").attr("title","");
			}
		}
	} else {
		$(obj).find("input[name='promBuyPrice']").val("");
		$(obj).find("input[name='promBuyPrice']").addClass("errorInput");
		$(obj).find("input[name='promBuyPrice']").attr("title","促销进价不能为空！");
	}
}

//check促销商品是否有订单使用
function checkItemOrderUse(checkOrders,itemNo){
	var flag = false;
	if (checkOrders == "1") {
		top.jAlert('warning', '商品('+itemNo+')已有订单使用，不能删除!', '提示消息');
		flag = true;
	}
	if (flag) {
		return flag;
	}
}

//检查门店是否为空
function checkStoreDiv(){
	var promItemStoreMess_div = $.trim($("#promItemStoreMess_div").html());
	var storeFlag = false; 
	if (promItemStoreMess_div == "") {
		storeFlag = true;
		top.jAlert('warning', '商品门店信息不能为空！', '提示消息');
	}
	return storeFlag;
}
//检查商品是否为空
function checkItemDiv(){
	var pro_store_items = $.trim($(".pro_store_item .pro_store_items").html());
	var itemFlag = false; 
	if (promItemStoreMess_div == "") {
		itemFlag = true;
		top.jAlert('warning', '当前系列商品不能为空！', '提示消息');
	}
	return itemFlag;
}

function checkPromotion(){
	if(checkItemDiv() || checkStoreDiv()){
		return false;
	}
	return true;
}

//检查开始日期是否有订单使用
function checkPromBuyStartDate(obj){
	var retVal = false;
	var buyBeginDateElem = $("#buyBeginDate");
	var buyBeginDate = $.trim(buyBeginDateElem.val());
	var buyEndDateElm = $("#buyEndDate");
	var buyEndDate = $.trim(buyEndDateElm.val());
	if (!(buyBeginDate == "" || buyEndDate == "")) {
		if(buyBeginDate<buyBeginDateElem.attr('preval')){
			$(obj).attr("title","");
			return retVal; 
		}
		retVal = checkPromotionDateWithOrderDate(obj,buyBeginDate,buyEndDate);
	}
	if(retVal){
		$(obj).prop("title","已有订单使用该促销期数，且采购开始日期不能大于预订收货日期!");
		top.jAlert('warning', '已有订单使用该促销期数，且采购开始日期不能大于预订收货日期!', '提示消息');
	}
	return retVal;
}

//检查结束日期是否有订单使用
function checkPromBuyEndDate(obj){
	var retVal = false;
	var buyBeginDateElem = $("#buyBeginDate");
	var buyBeginDate = $.trim(buyBeginDateElem.val());
	var buyEndDateElm = $("#buyEndDate");
	var buyEndDate = $.trim(buyEndDateElm.val());
	if (!(buyBeginDate == "" || buyEndDate == "")) {
		if(buyEndDate>buyEndDateElm.attr('preval')){
			$(obj).attr("title","");
			return retVal; 
		}
		retVal = checkPromotionDateWithOrderDate(obj,buyBeginDate,buyEndDate);
	}
	if(retVal){
		$(obj).prop("title","已有订单使用该促销期数，且采购结束日期不能小于预订收货日期!");
		top.jAlert('warning', '已有订单使用该促销期数，且采购结束日期不能小于预订收货日期!', '提示消息');
	}
	return retVal; 
}

function checkPromotionDateWithOrderDate(obj,buyBeginDate,buyEndDate){
	var retVal = false;
	if (ordersDateMap.length >= 0) {
		buyEndDate=new Date(buyEndDate.replaceAll('-','/') + " 00:00:00").getTime();
		buyBeginDate = new Date(buyBeginDate.replaceAll('-','/') + " 00:00:00").getTime();
		$.each(ordersDateMap,function(i, order){
			if ((buyEndDate < order.planRecptDate || buyBeginDate > order.planRecptDate)
			&& (buyEndDate < order.ordDate || buyBeginDate > order.ordDate)){
				$(obj).addClass("errorInput");
				$(obj).val('');
				retVal = true;
				return false;
			}
		});
	}
	return retVal;
}

//显示门店信息
function showStoreMess(obj){
	var unitNo = $($(obj).find("span")[0]).attr("unitNoValue");
	var itemNo = $($(obj).find("span")[0]).attr("itemNoValue");
	var itemName = $($(obj).find("span")[0]).attr("itemNameValue");
	var unitType = $($(obj).find("span")[0]).attr("unitTypeValue");
	var checkOrders = $(obj).attr("checkorders"); 
	$(obj).addClass("item_on");
	//属性值设置
	editMess(itemNo,unitNo,unitType);
	 
	$.each(itemSupMess, function(index, value){
		if (value.indexOf('"promUnitNo":"'+unitNo+'"') >= 0 && value.indexOf('"unitType":"'+unitType+'"') >= 0 && value.indexOf('"itemNo":"'+itemNo+'"') >= 0) {
			var valus = value.split("--");
			$("#promItemStoreMess_div").children().remove();
			$.each(valus, function(idx, json){
				var jsonData = JSON.parse(json);
				//把模板里面的数据替换再复制过来
				setValueForItemStoreInfo(jsonData,itemName);
				$("#promItemStoreMess_div").append($('#itemStoreInfoModel .ig').clone());
				unShowStoreDom(jsonData.checkOrders);
				//$("#promItemStoreMess_div .ig .errorInput").removeClass('errorInput');
				if ($.trim(jsonData.promBuyPrice) == "") {
					$("#promItemStoreMess_div .ig:last .errorInput").val('');
				}else{
					$("#promItemStoreMess_div .ig:last .errorInput").removeClass('errorInput');
				}
			});
		}
	});
	$('#promItemStoreMess_div .ig:first input[name="promBuyPrice"]').focus();

}

//判断订单是否使用门店
function checkStoreOrders(){
	$.each(storeInOrders,function(index, storeNoOrder){
		$("#promItemStoreMess_div input[name='storeNo']").each(function(index, storeNoDom){
			var storeNo = $(storeNoDom).val();
			if (storeNoOrder == storeNo) {
				$($(storeNoDom).parent().find("input[name='checkOrders']")).val("1");
				$($(storeNoDom).parent().find("input[name='promBuyPrice']")).prop("readonly","readonly");
				$($(storeNoDom).parent().find("input[name='promBuyPrice']")).addClass("Black");
				$($(storeNoDom).parent().find(".isChecksProm")).prop("disabled",true);
				return false;
			}
		});
	});
}

//禁用门店订单修改，
function unShowStoreDom(checkOrders){
	if (checkOrders == "1") {
		var divElement = $('#promItemStoreMess_div .ig:last');
		var promBuyPriceElement = divElement.find('input[name="promBuyPrice"]');
		promBuyPriceElement.prop("readonly",true);
		promBuyPriceElement.addClass("Black");
		divElement.find('.isChecksProm').prop("disabled",true);
	} else {
		$('#promItemStoreMess_div .ig:last input[name="promBuyPrice"]').prop("readonly",false);
	}
}

//赋值商品订单标识符
function checkOrdersFlag(checkOrders){
	$(".pro_store_items .item:last").attr("checkorders",checkOrders);
}

//删除促销期数信息
function deletePromotionMessage(dmPromNo){
	//验证促销是否被订单使用（如果有不能删除）
	if (getOrderPromtions(dmPromNo)) {
		top.jAlert('warning', '促销被订单使用不能删除!', '提示消息');
		return false;
	}
	top.jConfirm("您确定要删除该条数据吗?", '提示消息',function(ret){
		if(ret){
			//删除数据的方法
			$.ajax({
				async : false,
				type : 'post',
				url : ctx + '/prom/nondm/ho/deletePromotionMessage',
				data : {dmPromNo:dmPromNo},
				success : function(data){
					if (data.status == 'success') {
						top.jAlert('success', data.message, '消息提示');
						pageQuery();
						$("#Tools10").attr('class', "Tools10_disable");
					} else {
						top.jAlert('error', data.message, '消息提示');
					}
				}
			});
		}
	});
}

//获取订单促销列表
function getOrderPromtions(dmPromNo){
	var flag = false;
	$.ajax({
		async : false,
		type : 'post',
		url : ctx + '/prom/nondm/ho/getOrdersPromtions',
		data : {dmPromNo:dmPromNo},
		success : function(data){
			if (data.status == 'success') {
				flag = true;
			} else {
				flag = false;
			}
		}
	});
	return flag;
}

 /** 日期比较 **/
function compareDate(strDate1,strDate2)
{
    var date1 = new Date(strDate1.replace(/-/g, "/"));
    var date2 = new Date(strDate2.replace(/-/g, "/"));
    return date1-date2;
}

//字符串字符替换
String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {
	if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
		return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")),
				replaceWith);
	} else {
		return this.replace(reallyDo, replaceWith);
	}
};

//添加所有单品的门店数据到itemSupMess数组
function addAllItemsStoreDate(unitType,promUnitNo,itemNoList,storeList,checkOrders){
	var flag = false;
	var promFlag = false;
	var str = "";
	$.each(itemNoList, function(index, itemVO) {
		$.each(storeList, function(index, storeVO){
			if (itemVO.itemNo == storeVO.itemNo) {
				var buyWhen = $.trim(storeVO.buyWhen);
				var promBuyPrice=$.trim(storeVO.promBuyPrice);
				var normBuyPrice=$.trim(storeVO.normBuyPrice);
				var buyPriceLimit = $.trim(storeVO.buyPriceLimit);
				if (promBuyPrice != "" ) {
					if (buyWhen == 2) {
			    		if(buyPriceLimit !="" && (Number(promBuyPrice)>Number(buyPriceLimit))){
			    			promBuyPrice="";
			  	    	}
					} else {
						if (Number(promBuyPrice) >= Number(normBuyPrice)) {
							promBuyPrice="";
						} 
					}
				} 
				str = str + '{"unitType":"'+unitType+'","promUnitNo":"'+promUnitNo+'","itemNo":"'+storeVO.itemNo+'","storeNo":"'+storeVO.storeNo+'","storeName":"'+storeVO.storeNo+'-'+$.trim(storeVO.storeName)+'","promSupNo":"'+storeVO.stMainSupNo+'","comName":"'+$.trim(storeVO.mainComName)+'","statusName":"'+getDictValue('ITEM_BASIC_STATUS',storeVO.status)+'","normBuyPrice":"'+$.trim(storeVO.normBuyPrice)+'","promBuyPrice":"'+promBuyPrice+'","normSellPrice":"'+$.trim(storeVO.normSellPrice) + '","itemName":"'+itemVO.itemName+'",'+'"buyPriceLimit":"'+$.trim(storeVO.buyPriceLimit) + '","buyWhen":"'+$.trim(storeVO.buyWhen) +'","checkOrders":"'+checkOrders+'","batchPriceChngInd":"'+$.trim(storeVO.batchPriceChngInd)+'"}--';
			}
		});
	});
	if (str) {
		str = str.substring(0,str.length - 2);
		itemSupMess.push(str);	
	}
}

//添加所有系列门店数据到itemSupMess数组
function addAllItemsStoreDate1(unitType,promUnitNo,itemNoList,storeList,checkOrders){
	var flag = false;
	var promFlag = false;
	var str = "";
	$.each(itemNoList, function(index, itemVO) {
		if (checkNotRepetitionItem(itemVO.itemNo)) {
			flag = true;
			str = "";
			if (storeList != null) {
				$.each(storeList, function(index, storeVO){
					if (itemVO.itemNo == storeVO.itemNo) {
						str = str + '{"unitType":"'+unitType+'","promUnitNo":"'+promUnitNo+'","itemNo":"'+storeVO.itemNo+'","storeNo":"'+storeVO.storeNo+'","storeName":"'+storeVO.storeNo+'-'+$.trim(storeVO.storeName)+'","promSupNo":"'+storeVO.stMainSupNo+'","comName":"'+$.trim(storeVO.mainComName)+'","statusName":"'+getDictValue('ITEM_BASIC_STATUS',storeVO.status)+'","normBuyPrice":"'+$.trim(storeVO.normBuyPrice)+'","promBuyPrice":"","normSellPrice":"'+$.trim(storeVO.normSellPrice) + '","itemName":"'+itemVO.itemName+'",'+'"buyPriceLimit":"'+$.trim(storeVO.buyPriceLimit) + '","buyWhen":"'+$.trim(storeVO.buyWhen) +'","checkOrders":"'+checkOrders+'","batchPriceChngInd":"'+$.trim(storeVO.batchPriceChngInd)+'"}--';
					}
				});
				if (str) {
					str = str.substring(0,str.length - 2);
					itemSupMess.push(str);	
				}
			} else {
				promFlag = true;
			}
		}
	});
	if (!flag) {
		flag = true;
		top.jAlert('warning', '该系列下的商品已存在!', '提示消息');
		$("#promCodeMess_div .item_on").find(".promUnitNoClick").val('');
		$("#promCodeMess_div .item_on").find(".promUnitName").val('');
	}
	if (promFlag) {
		flag = false;
		top.jAlert('warning', '该系列下没有厂商!', '提示消息');
		$("#promCodeMess_div .item_on").find(".promUnitNoClick").val('');
		$("#promCodeMess_div .item_on").find(".promUnitName").val('');
	}
	return flag;
}
function showPasteWin(obj){
	if($.trim($("#catlgId").val())==''){
		top.jAlert('warning', '课别不能为空!', '提示消息');
		return false;
	}
	
	var subjName = $.trim($("#subjName").val());
	var buyBeginDate = $.trim($("#buyBeginDate").val());
	var buyEndDate = $.trim($("#buyEndDate").val());
	var isError=false;
	if (subjName == "") {
		$("#subjName").addClass("errorInput");
		isError=true;
	}
	if(charLen($.trim(subjName))>30){
 		$("#subjName").addClass('errorInput');
 		$("#subjName").attr("title",'主题不能超过30个字节!');
 		isError=true;
	}
	if ($.trim(buyBeginDate) == "") {
		$("#buyBeginDate").addClass('errorInput');
		isError=true;
	}
	if ($.trim(buyEndDate) == "") {
		$("#buyEndDate").addClass('errorInput');
		isError=true;
	}
	if(isError){
		return;
	}
	if ($(obj).attr("class").indexOf("_off") >= 0) return;
	top.grid_layer_open();
	$.ajaxSetup({async : false});
	if(!checkPromItems() || checkHasChangeItemValue() || ($.trim($('#promCodeMess_div:visible .item_on .promUnitNoClick').val())!='' && !checkPromotion())){
		$.ajaxSetup({async : true});
		top.grid_layer_close();
		return false;
	}
	var checkMess = $("#promCodeMess_div").find(".item").length;
	var flag = true;
		if (checkMess > 0) {
			var pro_store_items = $(".pro_store_items").find(".item").length;
			var promItemStoreMess_div = $("#promItemStoreMess_div").find(".ig");
			if (promItemStoreMess_div.length > 0) {
				$.each(promItemStoreMess_div, function(index, value){
					var promBuyPrice = $.trim($(this).find("input[name='promBuyPrice']").val());
					var normBuyPrice = $.trim($(this).find("input[name='normBuyPrice']").val());
					var buyWhen= $.trim($(this).find("input[name='buyWhen']").val());
					var buyPriceLimit =$.trim($(this).find("input[name='buyPriceLimit']").val());
					if (promBuyPrice != "" ) {
					    if (buyWhen == 2) {
					    		if(buyPriceLimit !="" && (Number(promBuyPrice)>Number(buyPriceLimit))){
									$(this).addClass("errorInput");
									$(this).val("");
									flag = false;
					  	    	}else{
					  	    		$(this).removeClass("errorInput");
					    		}
					   }else{	
						  if (Number(promBuyPrice) > Number(normBuyPrice)) {
							$(this).find("input[name='promBuyPrice']").addClass("errorInput");
							$(this).val("");
							flag = false;
						   }
					   }
					} else {
						$(this).find("input[name='promBuyPrice']").addClass("errorInput");
						flag = false;
					}
				});
			} 
		}
		if (!flag){
			$.ajaxSetup({async : true});
			top.grid_layer_close();
			return false;
			
		}
		$.ajaxSetup({async : true});
		top.grid_layer_close();
		top.openPopupWin(600,450,'/prom/nondm/ho/pastePromUnitNoAndBuyPrice');

	
	
}
var repeateItemArr=new Array();
var notExistsItemNosArr = [];
var unitMap=new Object();
function batchPasteItemNoData(data){
	var itemNoArr=new Array();
	if(data==null){
		return;
	}
	repeateItemArr=new Array();
	notExistsItemNosArr = [];//reset;
	unitMap=new Object();
	$.each(data,function(itemIndex,itemValue){
		if(!unitMap[itemValue.unitNo]){
			unitMap[itemValue.unitNo]=itemValue.unitNo;
		    if (!checkNotRepetitionBatchItem(itemValue.unitNo)) {
	 	    	  return true;
		     }
		     unitMap[itemValue.unitNo]=itemValue.unitNo;
		     itemNoArr.push(itemValue.unitNo+"--"+itemValue.promBuyPrice);
		}
	});
	
	
	var catlgId = $.trim($("#catlgId").val());
	var GRP_SIZE = 5;
	var grpCount=Math.ceil(itemNoArr.length / GRP_SIZE);
	//准备分组发送的数据；
	var allGrpData = [];
	for(var c=0;c<grpCount;c++){
		 var grpData=new Array();
		 for(var d=c*GRP_SIZE;d<c*GRP_SIZE+GRP_SIZE;d++){
			if(itemNoArr[d]&&itemNoArr[d]!=""){
				grpData.push(itemNoArr[d]);
			}
		 }
		 allGrpData.push(grpData);
	}
	var sendCounter = 0;
	if(allGrpData&&allGrpData.length>0){
	   doSendOneGrp(catlgId, allGrpData, sendCounter, grpCount);
	}else{
	   top.jAlert('warning', '重复的单品:['+repeateItemArr.join(",")+']已过滤！', '提示消息');

	}
}

function doSendOneGrp(/*int*/pCatlgIdIn, /*array*/allGroupDataIn, /*int*/sendIdxIn, /*int, readonly*/totalGrpCountIn){
	var groupData = allGroupDataIn[sendIdxIn];
	var qryUrl = ctx + '/prom/nondm/ho/batchUnitDataAction?ti='+(new Date()).getTime();
	var qryParams = {
			'itemNoArray': groupData.join(","),
			catlgId : pCatlgIdIn,
			pageNo : 1,
			pageSize : 1
		};
	
	$.post(qryUrl,qryParams,function(result){
	    var listMess = result["listMess"];
		var notExistsItemNos = result["notExistsItemNos"];
		
		if (notExistsItemNos){
			$.each(notExistsItemNos, function(index, value){
				notExistsItemNosArr.push(value);
			});
		}
		if (!listMess || listMess.length <= 0) {
			listMess = [];
		}
	    $.each(listMess, function(index, value){
	    	    var unitMess="unitMess"+index;
	    	    var storeMess="storeMess"+value[unitMess].clstrId;
	    	    var itemMess="itemMess"+value[unitMess].clstrId;
	    	    var unitNo=value[unitMess].clstrId;
	    	    var unitType=value.unitType;
	    	    var promBuyPrice=value[unitNo];
	    	    if (!checkNotRepetitionBatchItem(value[itemMess][0].itemNo)) {
	    	    	return true;
				}
	    	    
				//移除删除商品信息
				$.each(delCodeMess,function(ind, val){
					if (val.promUnitNo == unitNo && val.unitType == unitType) {
						delCodeMess.remove(ind);
						return false;
					}
				});
				var divNum=$('#promCodeMess_div').children('.addPromCode_div').length;
				var count=divNum;
				//给系列列表赋值
				$("#promCodeMess_div").append($("#addPromCode_div").find(".addPromCode_div").clone());
				var addProm = $("#promCodeMess_div");
				$(addProm.find("select")[count]).val(unitType);
				$(addProm.find("input[name='promUnitNo']")[count]).val(unitNo);
				$(addProm.find(".promUnitName")[count]).val(value[unitMess].clstrName);
				$(addProm.find(".promBuyPrices")[count]).val(promBuyPrice);
				//if (count == 0&&c==0) {
				if (count == 0) {
					if ($.trim(value[itemMess])=='') {
						return false;
					}
					
						addAllItemsStoreDate(unitType,unitNo,value[itemMess],value[storeMess],"");
						acquirePromStoreMess(unitType, unitNo);
						$("#updatePriceAll").val(promBuyPrice);
						if(unitType==0){
						unAddItemClick();
						addSupClick();
						}else{
						  addItemClick();
						  addSupClick();
						}
				}else{
					addAllItemsStoreDate(unitType,unitNo,value[itemMess],value[storeMess],"");
					$(addProm.find(".addPromCode_div")[count]).removeClass("item_on");	
				}
		});
	    sendIdxIn++;
	    if (sendIdxIn < totalGrpCountIn)
	    	doSendOneGrp(pCatlgIdIn, allGroupDataIn, sendIdxIn, totalGrpCountIn);
	    else {
	    	if(repeateItemArr.length>0&&notExistsItemNosArr.length>0){
	    		top.jAlert('warning', '重复的单品:['+repeateItemArr.join(",")+']已过滤！<br>以下单品:['+notExistsItemNosArr.join(",")+']不符合条件！', '提示消息');
	    	}else if(repeateItemArr.length>0){
	    		top.jAlert('warning', '重复的单品:['+repeateItemArr.join(",")+']已过滤！', '提示消息');
	    	}else if(notExistsItemNosArr.length>0){
	    		top.jAlert('warning', '以下单品:['+notExistsItemNosArr.join(",")+']不符合条件！', '提示消息');
	    	}
	    }
	},'json');
};


//验证是否有重复的商品
function checkNotRepetitionBatchItem(itemNo){
	var flag = true;
	var promCodeMess_div = $("#promCodeMess_div .item");
	
	$.each(promCodeMess_div,function(ind, val){
		var unitType = $(val).find(".selectOnchang").val();
		var promUnitNo = $(val).find(".promUnitNoClick").val();
		$.each(itemSupMess, function(index, value){
			if (value.indexOf('"unitType":"'+unitType+'"') >= 0 && value.indexOf('"promUnitNo":"'+promUnitNo+'"') >= 0) {
				if (value.indexOf('"itemNo":"'+itemNo+'"') >= 0) {
					flag = false;
					repeateItemArr.push(itemNo);
					return false;
				}
			}
		});
		if(!flag){
			return false;
		}
	});
	return flag;
}
//校验促销促销价格
function checkHasBatchItemValue(){
	hasInputflag=true;
	var v_promBuyPrice_str="";
	var itemNo="";
	$('#promCodeMess_div .item').each(function(){
		var unitType=$.trim($(this).find('select').val());
		var unitNo=$(this).find('.promUnitNoClick').val();
		$.each(itemSupMess, function(index, value){
			if (value.indexOf('"unitType":"'+unitType+'"') >= 0 && value.indexOf('"promUnitNo":"'+unitNo+'"') >= 0) {
				if (value.indexOf('"promBuyPrice":""') >= 0 ||value.indexOf('"promBuyPrice":null') >= 0) {
					hasInputflag=false;
					return false;
				}
			}
		});
		if(!hasInputflag){
			/*$('#promCodeMess_div .item_on').removeClass('item_on');
			$(this).addClass('item_on');
			$(this)[0].scrollIntoView();
			$("#updatePriceAll").val($(this).find(".promBuyPrices").val());
			$("#promItemStoreMess_div").children().remove();
			$(".pro_store_items").children().remove();
			acquirePromStoreMess(unitType, unitNo);
			if(unitType==0){
				unAddItemClick();
				addSupClick();
			}else{
				addItemClick();
				addSupClick();
			}*/
			
			$(this).mouseup();
			
			var errorStatus=false;
			$.each(itemSupMess, function(index,value){
				if (value.indexOf('"unitType":"'+unitType+'"') >= 0 && value.indexOf('"promUnitNo":"'+unitNo+'"') >= 0) {
					var valus = value.split("--");
					$.each(valus, function(idx, json){
						var jsonData = JSON.parse(json); 
						if ($.trim(jsonData.promBuyPrice)=='') {
							itemNo = jsonData.itemNo;
							if (unitType == 0) {
								v_promBuyPrice_str ="请输入单品："+unitNo+"下的促销进价";
							} else {
								v_promBuyPrice_str ="请输入代号"+unitNo+"下商品："+itemNo+"的促销进价";
							}
							errorStatus = true;
							return false;
						}
					});
				}
				if (errorStatus) {
					return false;
				}
			});
			return false;
		}
		
	});
	if(!hasInputflag){
	   top.jAlert('warning', v_promBuyPrice_str, '提示消息');
	   if($('.pro_store_items .item_on')[0]){
		$('.pro_store_items .item_on').removeClass('item_on');
		$('.promItemStoreClick[itemNoValue="'+itemNo+'"]').click();
		$('.promItemStoreClick[itemNoValue="'+itemNo+'"]').parent().addClass('item_on');
		$('.pro_store_items .item_on')[0].scrollIntoView();
		if($('#promItemStoreMess_div .errorInput').size()>0){
			$('#promItemStoreMess_div').scrollTop(0);
		}
	   }
	}
	return hasInputflag;
}
