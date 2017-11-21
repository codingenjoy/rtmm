/**
 * 屏蔽backspace、F5,F4为刷新 
 */
document.onkeydown = function(event) {
	var e = event || window.event || arguments.callee.caller.arguments[0];
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

$(".item").die('click');

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

//关闭创建进价促销
function closeCreateProm() {
	window.location.href = ctx + "/prom/nondm/ho/HOBuyPriPromo";
}

/**
 * 删除系列DIV
 */
$(".pstb_del").die("click").live("click", function () {
	event.stopPropagation();
	var $row = $(this).parents(".item");
	var v_index = $(this).parents(".item").index();
	var this_prev = $(this).parent().parent().prev();
	var this_next = $(this).parent().parent().next();
	$row.remove();
	if ($(this).parents(".item").attr("class").indexOf("item_on") >= 0) {
		if ($.trim(this_prev.html()) != "") {
			var v_prev_index = this_prev.index();
			this_prev.addClass("item_on");
			$(".itemStoreMess").eq(v_prev_index).show();
		} else if ($.trim(this_next.html()) != "") {
			var v_next_index = this_next.index();
			this_next.addClass("item_on");
			$(".itemStoreMess").eq(v_next_index).show();
		} else {
			$(".itemStoreMessNull").show();
		}
	}
	$(".itemStoreMess")[v_index].remove();
});

/** 验证输入整数值 */
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

//增加促销代号信息
function addPromCodeMess(obj) {
	$("#promCodeMess_div .item_on").removeClass("item_on");
	$("#promCodeMess_div").append($("#addPromCode_div").find(".addPromCode_div").clone());
	$("#promCodeMess_div .item").last().addClass("item_on");
	$("#promCodeMess_div .item").last()[0].scrollIntoView();
	$.ajax({
		type : 'post',
		url : ctx + '/prom/nondm/ho/addItemStoreMessAction',
		data : {},
		success : function(data) {
			$(".promContent .CM").last().hide();
			$(".promContent").append(data);
		}
	});
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

//切换系列
$(".addPromCode_div").die('click').live('click', function() {
	//验证是否是当前系列(如果是不做任何操作)
	if ($(this).hasClass("item_on")) {
		return false;
	}
	//验证门店是否填写完整
	if (checkItemStoreMess()) {
		return false;
	}
	switchPromotionUnit($(this));
});
function switchPromotionUnit(obj){
	var up_class = $("#promCodeMess_div .item_on").index();
	obj.parent().find('.item_on').removeClass('item_on');
	obj.addClass('item_on');
	$(".itemStoreMess").eq($(obj).index()).show();
	$(".itemStoreMess").eq(up_class).hide();
}

//代号弹出框
$(".showUnitWin").die('click').live('click', function() {
	popUnitWin($(this));
});
function  popUnitWinReturn(unitNo,unitName){
	var catlgId = $.trim($("#catlgId").val());
	var unitType = $("#promCodeMess_div .item_on").find("select").val();
	var promUnitNo=$("#promCodeMess_div .item_on").find("input[name='promUnitNo']");
	var promUnitName=$("#promCodeMess_div .item_on").find(".promUnitName");
	var pro_store_item = $(".itemStoreMess:visible");
	var prom_str = "";
	var promCodeMess_div = $("#promCodeMess_div").find(".addPromCode_div");
	$.each(promCodeMess_div, function(index, value){
		prom_str = prom_str + $(value).find("select").val() + "," + $(value).find("input[name='promUnitNo']").val() + "-";
	});
	var checkUpdate = $("#checkUpdate").val();
	if (unitNo != null) {
		$("#updatePriceAll").val('');
		$("#promCodeMess_div .item_on").find(".promBuyPrices").val('');
		if (prom_str.indexOf(unitType + "," + unitNo + "-") < 0) {
			promUnitNo.val(unitNo);
			promUnitName.val(unitName);
			showAllItemStoreMess(unitNo,catlgId,unitType,pro_store_item,"");
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
	var unitType = $.trim($(obj).parent().parent().find("select").val());
	var catlgId = $.trim($("#catlgId").val());
	if (catlgId != "" && unitType != "") {
	 	top.openPopupWin(700,450, '/prom/nondm/ho/showUnitWin?unitType=' + unitType + '&catlgId=' + catlgId);
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

//赋值商品信息
function setValueForItemInfo(itemNo,itemName){
	var objId = '#promItemInfoModel2';
	var objElement = objId+" span:first";
	$(objElement).attr('itemNoValue',itemNo);
	$(objElement).attr('itemNameValue',itemName);
	$(objElement).text(itemNo+'-'+itemName);
	return objId+" .item";
}

//切换商品之间的门店信息
function switchItemStoreMess(obj){
	//拿到门店区域的DOM对象pro_store_item2
	var pro_store_item2 = $(".itemStoreMess:visible .pro_store_item:visible .pro_store_item2");
	//验证是否是当前商品(如果是不做任何操作)
	if ($(obj).parent().hasClass('item_on')) {
		return ;
	}
	$(obj).parent().parent().find(".item_on").removeClass("item_on");
	//得到要切换的商品下标
	var item_index = $(obj).parent().index();
	//上个门店隐藏
	$(".itemStoreMess:visible .pro_store_item:visible .pro_store_item2").hide();
	$(obj).parent().addClass("item_on");
	//当前门店显示
	pro_store_item2.eq(item_index).show();
}

$(".pstb_del2").die("click");
//删除商品以及商品下所有的门店
function delItemSupMessMethods(obj){
	//商品的总条数
	var itemSize = $(".itemStoreMess:visible .pro_store_item1 .pro_store_items .item").size();
	if (itemSize == 1) {
		top.jAlert('warning', '商品至少存在一个！', '提示消息');
		return false;
	}
	//得到要删除商品的下标
	var del_itemIndex = $(obj).parents(".item").index();
	var this_prev = $(obj).parent().prev();
	var this_next = $(obj).parent().next();
	var v_prev_index = this_prev.index();
	var v_next_index = this_next.index();
	var pro_store_items2 = $(".itemStoreMess:visible  .pro_store_item:visible .pro_store_item2");
	//删除当前商品
	$(obj).parents(".item").remove();
	//删除当前商品的门店信息
	pro_store_items2.eq(del_itemIndex).remove();
	if ($(obj).parent().hasClass("item_on")) {
		if ($.trim(this_prev.html()) != "") {
			this_prev.addClass("item_on");
			pro_store_items2.eq(v_prev_index).show();
		} else if ($.trim(this_next.html())!= "") {
			this_next.addClass("item_on");
			pro_store_items2.eq(v_next_index).show();
		}
	}
	
}

//显示所有门店信息
function showAllItemStoreMess(promUnitNo,catlgId,unitType,pro_store_item,orderStr){
	$.ajax({
		async : false,
		url : ctx + '/prom/nondm/ho/allItemStoreMessAction',
		type : "post",
		dataType : "html",
		data : {
			promUnitNo : promUnitNo,
			catlgId : catlgId,
			unitType : unitType,
			unitNo : promUnitNo,
			orderStr : orderStr,
			promBuyPrice : ''
		},
		success : function(result) {
			pro_store_item.append(result);
			pro_store_item.find(".CM-div:first").hide();
			//添加所选商品的背景色
			$(".pro_store_items:visible .item:first").addClass("item_on");
			//显示所选商品的门店信息
			$(".itemStoreMess:visible .pro_store_item:visible .pro_store_item2:first").show();
		}
	});
}

//添加促销商品
function addSelectedItem(obj) {
	if ($(obj).attr("class").indexOf("_off") < 0) {
		var unitNo = $.trim($("#promCodeMess_div .item_on").find(".promUnitNoClick").val());
		var unitType = $.trim($("#promCodeMess_div .item_on").find("select").val());
		var catlgId = $("#catlgId").val();
		var v_itemsValue= "";
		$(".pro_store_item1:visible .pro_store_items .item").each(function() {
			v_itemsValue += $(this).find("span").eq(0).attr("itemNoValue") + ",";
		});
		var itemsValue = v_itemsValue.substring(0, v_itemsValue.length - 1);
		top.openPopupWin(420,480,'/prom/nondm/art/showDeleteItemsList?catlgId=' + catlgId+'&unitNo='+unitNo+'&itemsValue='+itemsValue+'&unitType='+unitType);
	}
}
//添加促销商品的回调函数
function addSelectedItemReturn(itemNoArray,itemNameArray){
	var promUnitNo = $.trim($("#promCodeMess_div .item_on").find(".promUnitNoClick").val());
	var unitType = $.trim($("#promCodeMess_div .item_on").find("select").val());
	var catlgId = $("#catlgId").val();
	$.each(itemNoArray, function(index, itemNo) {
		var objElement = setValueForItemInfo(itemNo,itemNameArray[index]);
		$(".pro_store_item1:visible .pro_store_items").append($(objElement).clone());
	});
	$.ajax({
		type : 'post',
		async : false,
		dataType : 'html',
		url : ctx + '/prom/nondm/ho/otherItemStoreMessAction',
		data : {
			promUnitNo : promUnitNo,
			catlgId : catlgId,
			unitType : unitType,
			itemNoArray : itemNoArray.toString(),
			orderStr : '',
			promBuyPrice : ''
		},
		success : function(data) {
			$(".itemStoreMess:visible .pro_store_item:visible").append(data);
		}
	});
	top.closePopupWin();
	var itemNoList = $(".itemStoreMess:visible .pro_store_items:visible .item");
	$.each(itemNoList,function(index, itemMess){
		var itemNo = $(itemMess).find("span").eq(0).attr("itemnovalue");
		if (itemNo == itemNoArray[0]) {
			var v_index = $(itemMess).index();
			$(".itemStoreMess:visible .pro_store_items:visible .item_on").removeClass("item_on");
			$(itemMess).addClass("item_on");
			$(".itemStoreMess:visible .pro_store_item:visible .pro_store_item2:visible").hide();
			$(".itemStoreMess:visible .pro_store_item:visible .pro_store_item2").eq(v_index).show();
		}
		
	});
}

//手动查询代号门店信息
$(".promUnitNoClick").die("blur").live("blur",function(){
	var promNo = $.trim($(this).val());
	if (!isNumber(promNo)) {
		$(this).val('');
		return false;
	}
	var thisElem = $(this);
	if(thisElem.val()==$.trim(thisElem.attr('preVal')) || $.trim(thisElem.val()) == ""){
		return false;
	}
	promotionUnitAdd(thisElem);
});
$(".promUnitNoClick").die("keydown").live("keydown",function(ev){
	var e = ev || window.event || arguments.callee.caller.arguments[0];
	if (e.keyCode && e.keyCode == 13 && $(this).val()!='') {
		promotionUnitAdd($(this));
	}
});
$(".promUnitNoClick").die("focus").live("focus",function(){
	$(this).removeClass("errorInput");
	var promNo = $(this).val();
	$("#promNo_str_hidden").val(promNo);
});
//验证是否是整数
function isNumber(param) {
	var reg = new RegExp("^[0-9]*$");
	if (!reg.test(param)) {
		return false;
	} else {
		return true;
	}
}
function promotionUnitAdd(obj){
	var unitType = $("#promCodeMess_div .item_on").find("select").val();
	var promUnitNo = $.trim(obj.val());
	var catlgId = $("#catlgId").val();
	var v_promNo = $("#promNo_str_hidden").val();
	var pro_store_item = $(".itemStoreMess:visible");
	obj.attr('preVal',promUnitNo);
	if (promUnitNo == v_promNo && promUnitNo != "") {
		return false;
	}
	//验证系列是否存在
	if (checkPromUnitNo(unitType,promUnitNo)) {
		if (unitType == 0) {
			top.jAlert('warning', '单品已存在!', '提示消息');
		} else {
			top.jAlert('warning', '系列已存在!', '提示消息');
		}
		return false;
	}
/*	var prom_str = $("#prom_str_hidden").val();
	var promNo_str = $("#promNo_str_hidden").val();
	var unitType_str_hidden = $("#unitType_str_hidden").val();*/
	$.ajax({
		type : "post",
		url : ctx + '/prom/nondm/ho/showUnitDataAction',
		data : {
			unitType : unitType,
			itemNo : promUnitNo,
			catlgId : catlgId,
			pageNo : 1,
			pageSize : 1
		},
		success : function(result) {
			var unitName_v = result["unitName"];
			if (unitName_v != "") {
				$("#promCodeMess_div .item_on").find(".promUnitName").val(unitName_v);
				showAllItemStoreMess(promUnitNo,catlgId,unitType,pro_store_item,"");
			} else {
				$("#promCodeMess_div .item_on").find(".promUnitNoClick").val('');
				top.jAlert('warning', '该代号不存在，请重新输入！', '提示消息');
				//clearDiv();
			}
			$("#updatePriceAll").val('');
			$("#promCodeMess_div .item_on").find(".promBuyPrices").val('');
		}
	});
	
}

//验证系列是否存在
function checkPromUnitNo(unitType, promUnitNo){
	var flag = false;
	var v_indx = 0;
	$("#promCodeMess_div .item").each(function(index, promUnitMess){
		var v_unitType = $(promUnitMess).find("select").val();
		var v_promUnitNo = $(promUnitMess).find(".promUnitNoClick").val();
		if (unitType == v_unitType && promUnitNo == v_promUnitNo) {
			if (v_indx ++ != 0) {
				flag = true;
				return false;
			}
		}
	});
	return flag;
}













































//所选商品区域新增按钮不可选
function unAddItemClick(){
	$(".pro_store_item1:visible .createNewBar").prop("class","createNewBar_off");
}
//所选商品区域新增按钮可选
function addItemClick(){
	$(".pro_store_item1:visible .createNewBar_off").prop("class","createNewBar");
}

//新增厂商按钮不可点击
function unAddSupClick(){
	$(".pro_store_itemMess:visible .createNewBar").prop("class","createNewBar_off fl_left");
	$(".pro_store_itemMess:visible .deleteBar").removeClass("deleteBar").addClass("deleteBar_off");
	$(".pro_store_itemMess:visible .isCheckAllsProm").attr("disabled","disabled");
}
//新增厂商可点击
function addSupClick(){
	$(".pro_store_itemMess:visible .createNewBar_off").prop("class","createNewBar fl_left");
	$(".pro_store_itemMess:visible .deleteBar_off").removeClass("deleteBar_off").addClass("deleteBar");
	$(".pro_store_itemMess:visible .isCheckAllsProm").removeAttr("disabled");
}

//新增商品和厂商按钮不可点击
function unSupClickAddItem(){
	$(".pro_store_item1:visible .createNewBar").prop("class","createNewBar_off");
	$("#promItemStore_div:visible").removeClass("createNewBar").addClass("createNewBar_off");
	$(".deleteCheckedsProm:visible").removeClass("deleteBar").addClass("deleteBar_off");
	$(".isCheckAllsProm:visible").attr("disabled","disabled");
}
//新增商品和厂商按钮可点击
function supClickAddItem(){
	$(".pro_store_item1:visible .createNewBar_off").prop("class","createNewBar");
	$("#promItemStore_div:visible").removeClass("createNewBar_off").addClass("createNewBar");
	$(".deleteCheckedsProm:visible").removeClass("deleteBar_off").addClass("deleteBar");
	$(".isCheckAllsProm:visible").removeAttr("disabled");
}

//选择某条数据是否为全选
$(".isChecksProm:visible").live("click", function() {
	var checkAll = true;
	var promCheckBoxList = $(".pro_store_tb:visible").find("input.isChecksProm");//$("#promItemStoreMess_div").find("input.isChecksProm");
	$.each(promCheckBoxList, function(index, prom) {
		if (this.checked == false) {
			checkAll = false;
			return false;
		};
	});
	if (!checkAll) {
		$(".isCheckAllsProm:visible").attr("checked", false);
	} else {
		$(".isCheckAllsProm:visible").attr("checked", true);
	}
});
// 全选事件
$(".isCheckAllsProm:visible").live("click", function() {
	if (this.checked) {
		$(".pro_store_tb:visible").find("input.isChecksProm").attr("checked", true);
	} else {
		$(".pro_store_tb:visible").find("input.isChecksProm").attr("checked", false);
	}

});

// 删除事件
$(".deleteCheckedsProm:visible").live("click", function() {
	$(".pro_store_tb:visible").find("input.isChecksProm:checked").parent().parent().remove();
	$(".isCheckAllsProm:visible").attr("checked", false);
});


///**输入小数值 double_text*/验证保留3位小数
function inputToInputDoubleNumber(obj){
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
	}
}

//批量修改促销价格
$(".promBuyPrices").die("blur").live("blur", function(){
	var itemStoreMess = $(".itemStoreMess:visible .pro_store_item:visible");
	var promPrice = $.trim($(this).val());
	if (!isNumber(promPrice)) {
		$(this).val('');
		return false;
	}
	if (promPrice == "") {
		return ;
	}
	//$(".promItemStoreClick").attr("pbpvalue", promPrice);
	$(itemStoreMess.find(".updatePriceAll")).val(promPrice);
	var promItemStoreMess_div = itemStoreMess.find(".ig");
	if (promItemStoreMess_div.length > 0) {
		$.each(promItemStoreMess_div, function(index, value){
			var normBuyPrice = $.trim($(value).find("input[name='normBuyPrice']").val());
			var pro_store_items = $.trim($(value).find("input[name='checkOrders']").val());
			if (pro_store_items == "") {
				//检查成本时点
				checkBuyWhen(value,promPrice,normBuyPrice);
			}
		});
	}
});
//检查成本时点
function checkBuyWhen(obj,promPrice,normBuyPrice){
	var buyWhen  = $.trim($($(obj).find("input[name='buyWhen']")).val());
	var buyPriceLimit = $.trim($($(obj).find("input[name='buyPriceLimit']")).val());
	if (promPrice != "" ) {
		if (buyWhen == 2) {
    		if(buyPriceLimit !="" && (Number(promPrice)>Number(buyPriceLimit))){
				$(obj).find("input[name='promBuyPrice']").val("");
				$(obj).find("input[name='promBuyPrice']").addClass("errorInput");
				$(obj).find("input[name='promBuyPrice']").attr("title","促销进价要小于买价限制!");
  	    	}else{
  	    		$(obj).find("input[name='promBuyPrice']").val(promPrice);
				$(obj).find("input[name='promBuyPrice']").removeClass("errorInput");
    		}
		} else {
			if (Number(promPrice) >= Number(normBuyPrice)) {
				$(obj).find("input[name='promBuyPrice']").val("");
				$(obj).find("input[name='promBuyPrice']").addClass("errorInput");
				$(obj).find("input[name='promBuyPrice']").attr("title","促销进价要小于正常进价!");
			} else {
				$(obj).find("input[name='promBuyPrice']").val(promPrice);
				$(obj).find("input[name='promBuyPrice']").removeClass("errorInput");
			}
		}
	} else {
		$(obj).find("input[name='promBuyPrice']").val("");
		$(obj).find("input[name='promBuyPrice']").addClass("errorInput");
		$(obj).find("input[name='promBuyPrice']").attr("title","促销进价不能为空！");
	}
}

//批量修改指定商品的促销价格
$(".updatePriceAll:visible").die("blur").live("blur", function(){
	var pro_store_item2 = $(".itemStoreMess:visible .pro_store_item:visible .pro_store_item2:visible");
	var promPrice = $.trim($(this).val());
	if (!isNumber(promPrice)) {
		$(this).val('');
		return false;
	}
	if (promPrice != "") {
		var promItemStoreMess_div = pro_store_item2.find(".ig");
		$.each(promItemStoreMess_div, function(index, value){
			var normBuyPrice = $.trim($(value).find("input[name='normBuyPrice']").val());
			var pro_store_items = $.trim($(value).find("input[name='checkOrders']").val());
			//检查成本时点
			if (pro_store_items == "") {
				//检查成本时点
				checkBuyWhen(value,promPrice,normBuyPrice);
			}
		});
	}
});

//验证商品以及门店
function checkItemStoreMess(){
	var flag = false;
	var errorMess = $(".itemStoreMess:visible .pro_store_item:visible").find(".errorInput");
	if (errorMess.size() > 0) {
		flag = true;
		var pro_store_item2 = $(errorMess[0]).parent().parent().parent().parent().parent();
		var v_index = pro_store_item2.index();
		$(".itemStoreMess:visible .pro_store_item:visible .pro_store_item2").eq(v_index).show();
	}
	return flag;
}
