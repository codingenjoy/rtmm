/*
	以下是"总部订单创建/修改"的页面级脚本定义文件,
	包含HTML元素的事件处理入口。
 * */
//now, we define a PAGE-Level Order Creation Handler instance; 
var pHOOrderHandler  = new HOOrderMgmtHandler();

function removeItem(/* Node */anyRowMemberNode) {
	pHOOrderHandler.removeItemByNode(anyRowMemberNode);
	pHOOrderHandler.cleanBatchElement();
	pHOOrderHandler.cataPresQtyAmnt();
	pHOOrderHandler.cataQtyAmnt();
	checkStoreSelectAllStat();
	if(pHOOrderHandler.itemsList.length==0){
	pHOOrderHandler.removeFirstItemBuyer();
	}
}
// 选中商品
function itemSelected(clickedDivNode) {
	pHOOrderHandler.activateItemByAnyElement(clickedDivNode);
	if ( window.event && window.event.stopPropagation )
		//支持chorme的取消事件冒泡 
		window.event.stopPropagation(); 
		else
		//否则，我们需要使用IE的方式来取消事件冒泡 
		window.event.cancelBubble = true;
		return false;
};
function itemStoreSelected(clickedDivNode) {
	var rowNode = pHOOrderHandler.itemStoresCanvas.getRowNodeFromAnyElement(clickedDivNode);
	var selectedNodeStoreNo=$(rowNode).find("[name='storeNoCk']").val();
	var containerNode=pHOOrderHandler.itemStoresCanvas.getContainerNode();
	$.each(containerNode.childNodes,function(index,node){
		var currentNodeStoreNo=$(node).find("[name='storeNoCk']").val();
		if(selectedNodeStoreNo==currentNodeStoreNo){
			return true;
		}
		$(node).removeClass("store_on");
	});
	var hasSelectedOn = $(rowNode).hasClass("store_on");
	//设置简单的交换色效果；
	if (hasSelectedOn){
		$(rowNode).removeClass("store_on");
	}else {
		$(rowNode).addClass("store_on");
	}
};

function page_OnDelStoresBtnClicked(){
	var isSelected=pHOOrderHandler.delStoresFromActivatedItem();
	if(!isSelected){
		top.jAlert("warning","请选择需要删除的门店","提示信息");
		return false;
	}
	checkStoreSelectAllStat();
	pHOOrderHandler.cataPresQtyAmnt();
	pHOOrderHandler.cataQtyAmnt();
};
function page_OnAddMoreStoresBtnClicked(){

	var isValidate = validate(true);
	if (!isValidate) return false;
	openPopupWinTwo(624, 423, "/hoOrderCreateNew/hoOrderStoresShow");
};
// 添加单个商品
function addOrderItem() {
	var isValidate = validate(); // 是否通过验证
	if (!isValidate) return;
	pHOOrderHandler.addOneEmptyItem();
}

function setElementValue(obj, value) {
	$(obj).attr('value', value);
}

function getElementValue(obj, index, value) {
	return $($(obj)[index]).val();
}

function preSaveOrder() {
	pHOOrderHandler.ifHaveOrdOrPresIsNull = false;
	var isValidate = validate(); // 是否通过验证
	if (!isValidate) {
		return false;
	}
	if (pHOOrderHandler.itemsList.length == 0) {
		top.jAlert('warning', '请至少添加一个订单商品!', '消息提示');
		passValidate = false;
		return false;
	}
	if($('#action').val()=='create'&&pHOOrderHandler.ifHaveOrdOrPresIsNull){
		top.jConfirm("商品门店信息中有部分信息为空，是否忽略","消息提示",function(ret){
			if(ret){
				pHOOrderHandler.removeStoresIfNotPresAndOrdQty();
				saveOrder();	
			}
		});	
	}else{
		saveOrder();
	}
}

function saveOrder(){
	
	// 获取订单主档信息
	var orderBasicInfo = {};
	orderBasicInfo.action = $('#action').val(); // 订单号
	orderBasicInfo.ordNo = $('#ordNo').val(); // 订单号
	orderBasicInfo.catlgId = $('#catlgId').val(); // 课别
	orderBasicInfo.supNo = $('#supNo').val();// 厂编
	orderBasicInfo.supType = $('#supType').val();// 厂商类型
	orderBasicInfo.planRecptDate = $('#planRecptDate').val();// 预定收获日
	orderBasicInfo.supUnifmNo = $('#supUnifmNo').val();// 税号
	orderBasicInfo.supComNo = $('#supComNo').val();// 厂商公司编号
	orderBasicInfo.bpDisc = $('#bpDisc').val();// 进价折扣
	orderBasicInfo.invDisc = $('#invDisc').val();// 发票折扣
	orderBasicInfo.discMemo = $('#discMemo').val();// 财务备注
	orderBasicInfo.memo = $('#memo').val();// 订单备注
	orderBasicInfo.buyer = $('#buyer').val();// 采购
	orderBasicInfo.ifPlanRecptDateChange = pHOOrderHandler.ifPlanRecptDateChange;
	var data2Save = {};
	data2Save.orderBasicInfo = orderBasicInfo;
	data2Save.data = pHOOrderHandler.getData();
	// 提交表单
	$.ajax({
		type : "post",
		url : ctx + "/hoOrderCreateNew/saveHoOrder",
		dataType : "json",
		data : {
			'jsonStr' : JSON.stringify(data2Save)
		},
		success : function(data) {
			if (data.status == 'success') {
				top.jAlert('success', '订单保存成功', '提示消息');
				if(orderBasicInfo.action=='update'){
					showContent(ctx+'/order/hoOrder');					
				}else{
					showContent(ctx+'/hoOrderCreateNew/hoOrderCreatePage?action=create');
				}
			} else {
				top.jAlert('warning', data.message,'提示信息');
			}
		}
	});
	
}


// 验证表单
function validate(/*optional*/validateIfAddStores) {
	if($('.Content').find('.errorInput').length>
	$('.Content .hoOrderCreateStore #orderItemStoreList').find('.errorInput').length
	||$("#action").val()!="create"){
		//未通过校验
		if($('.Content').find('.errorInput').length>0){
			top.jAlert("warning","请修正标红栏位","提示消息");
			return false;
		}
	}
	var catlgElem = $('#catlgId');
	if ($.trim($(catlgElem).val()) == "") {
		$(catlgElem).attr('title','请选择课别！');
		$(catlgElem).addClass('errorInput');
		top.jAlert('warning', '请选择课别！', '消息提示',function(ret){
			if(ret)	focusElement(catlgElem);
		});
		return false;
	}

	var supElem = $('#supNo');
	if ($.trim($(supElem).val()) == "") {
		$(supElem).attr('title','请选择厂商！');
		$(supElem).addClass('errorInput');
		top.jAlert('warning', '请选择厂商！', '消息提示',function(ret){
			if(ret)	focusElement(supElem);
		});
		return false;
	}

	var planRecptDateElem = $('#planRecptDate');
	if ($.trim($(planRecptDateElem).val()) == "") {
		$(planRecptDateElem).attr('title','请选择预订收货日期！');
		$(planRecptDateElem).addClass('errorInput');
		top.jAlert('warning', '请选择预订收货日期！', '消息提示',function(ret){
			if(ret)	focusElement(planRecptDateElem);
		});
		return false;
	}

	// 检查商品和门店信息
	var passValidate = true;
	//valid if there is a item before adding stores. 
	var itemsList = pHOOrderHandler.itemsList;	
	if(validateIfAddStores&&itemsList.length==0){
		top.jAlert("warning","请先添加商品","提示消息");
		passValidate=false;
		return passValidate;	
	}
	//validate the stores about current item in the order.
	for (var i=0;i<itemsList.length;i++){
		var itemNo = itemsList[i].itemNo;
		// 1)检查货号是否为空
		if(!itemNo || $.trim(itemNo)==''){
			var rowNum = parseInt(i,10)+1;
			var elem = pHOOrderHandler.itemsCanvas.getRowMemberNodeByIndex(i,0);
			tipElement(elem,"货号不能为空");
			top.jAlert("warning","第"+rowNum+"行,货号不能为空！", "消息提示",function(ret){
				if(ret)	focusElement(elem);
			});
			pHOOrderHandler.itemsCanvas.clickRowByIndex(i);
			passValidate = false;
			break;
		}
		//if the validation validates whether to add stores,it could break here.
		if(validateIfAddStores)break;
		// 2)检查货号下门店信息
		//2-1.检查当前商品下的门店数据是否已被加载;
		var currItemStoresMapping = pHOOrderHandler.itemStoresMapping[itemNo];
		var isMapBuilt = currItemStoresMapping && currItemStoresMapping.loaded;
		var itemStoresList = null;
		if (isMapBuilt)
			itemStoresList = currItemStoresMapping.data;
		//创建的时候，检查每个商品下门店信息
		if((!itemStoresList || itemStoresList.length==0) && itemsList[i].action!='update'){
			top.jAlert("warning", "货号"+itemNo+"下商品分店信息还没有填写！", "消息提示"); 
			pHOOrderHandler.itemsCanvas.clickRowByIndex(i);
			passValidate = false;
			break;
		}
		//修改的时候，检查已经load的每个商品下门店信息
		if((!itemStoresList || itemStoresList.length==0) && itemsList[i].action=='update' && currItemStoresMapping.loaded){
			top.jAlert("warning", "货号"+itemNo+"下商品分店信息还没有填写！", "消息提示"); 
			pHOOrderHandler.itemsCanvas.clickRowByIndex(i);
			passValidate = false;
			break;
		}
		if(!itemStoresList)continue;
		var ifAllStoreOrdOrPresIsNull = true;
		for (var j=0;j<itemStoresList.length;j++){
			var storeNo = itemStoresList[j].storeNo;
			var ordQty = itemStoresList[j].ordQty;
			var presOrdQty = itemStoresList[j].presOrdQty;
			var buyPrice = itemStoresList[j].buyPrice;
			var buyPriceLimit = itemStoresList[j].buyPriceLimit;
			//2.1.1)如果是创建，至少有一家店订购数量和订购赠品数量不能同时为空
			if($("#action").val()=="create"){
			if(($.trim(ordQty)==''||$.trim(ordQty)==0)&&($.trim(presOrdQty)==''||$.trim(presOrdQty)==0)){
			if(!pHOOrderHandler.ifHaveOrdOrPresIsNull){
				pHOOrderHandler.ifHaveOrdOrPresIsNull = true;	
			}
			continue;
			}
			ifAllStoreOrdOrPresIsNull = false;
			}
			else if($("#action").val()=="update"){
			//2.1.1)所有店的订购数量和订购赠品数量不能同时为空
			if($.trim(ordQty)==''&&$.trim(presOrdQty)==''){
				pHOOrderHandler.itemsCanvas.clickRowByIndex(i);
				var elem = pHOOrderHandler.itemStoresCanvas.getRowMemberNodeByIndex(j, 4);
				tipElement(elem,"订购数量和订购赠品数量请至少填写一个");
				top.jAlert("warning", "货号"+itemNo+"下,分店"+storeNo+"的订购数量和赠品数量请至少填写一个！","消息提示",function(ret){
					if(ret)	focusElement(elem);
				});
				passValidate = false;
				break;
			}
			}
			// 2.2)买价不能超过买价限制
			if(buyPriceLimit && buyPrice>buyPriceLimit){
				pHOOrderHandler.itemsCanvas.clickRowByIndex(i);
				var elem = pHOOrderHandler.itemStoresCanvas.getRowMemberNodeByIndex(j,6);
				tipElement(elem,"买价不能超过买价限制");
				top.jAlert("warning", "货号"+itemNo+"下,分店"+storeNo+"的买价不能超过买价限制！","消息提示",function(ret){
					if(ret)	focusElement(elem);
				});
				passValidate = false;
				break;
			}	
		}
		if(ifAllStoreOrdOrPresIsNull&&$("#action").val()=="create"){
			pHOOrderHandler.itemsCanvas.clickRowByIndex(i);
			top.jWarningAlert("货号"+itemNo+"下,请至少填写一个分店的订购数量或赠品数量！");
			var elem = pHOOrderHandler.itemStoresCanvas.getRowMemberNodeByIndex(0,4);
			tipElement(elem,"请至少填写一个分店的订购数量或赠品数量");
			passValidate = false;
			break;
	     }
		if(!passValidate){
			break;
		}
	}
	return passValidate;
}
//当用户变更“订购数量”后，同步更新到数据结构中；
function changeOrdQty(/*Node*/ordQtyElem) {
	var passValidate = true;
	//1.确认“订购数量和订购赠品数量不能同时为空”;
	var ordQty = $(ordQtyElem);
	var presOrdQty = $(ordQtyElem).next();
	var ordQtyVal = $.trim(ordQty.val());
	var presOrdQtyVal =$.trim(presOrdQty.val());
	var presOrdQtyElem = $(ordQtyElem).next().get(0);
	if ((ordQtyVal == '' || ordQtyVal ==0) &&  (presOrdQtyVal== '' || presOrdQtyVal ==0)) {
		if($("#action").val()!="create"){
		$(ordQty).addClass('errorInput');
		$(ordQty).attr('title', '订购数量和订购赠品数量请至少填写一个！');
		passValidate = false;
		}
	} else {
		$(ordQty).removeClass('errorInput');
		$(ordQty).attr('title', '');
		$(presOrdQty).removeClass('errorInput');
		$(presOrdQty).attr('title', '');
	}
	if (!passValidate) return;
	//2.尝试用当前用户输入的“@ordQty”更新我们维护的数据结构；
	pHOOrderHandler.doSyncOrdQtyByRow(ordQtyVal, ordQtyElem);
	pHOOrderHandler.doSyncPresOrdQtyByRow(presOrdQtyVal,presOrdQtyElem);
	pHOOrderHandler.cataQtyAmnt();
	pHOOrderHandler.cataPresQtyAmnt();
	
};
//批量更改“订单数量”
function doBatchChangeOrdQty(/*Node*/batchOrdQtyElem){
	var newBatchOrdQtyVal = $.trim(batchOrdQtyElem.value);
	if(newBatchOrdQtyVal !="" && !isNaN(newBatchOrdQtyVal)){
		newBatchOrdQtyVal = parseFloat(newBatchOrdQtyVal).toFixed(0);
		$(batchOrdQtyElem).val(newBatchOrdQtyVal);
	}
	if (!newBatchOrdQtyVal || newBatchOrdQtyVal ==0) return;
	pHOOrderHandler.doBatchSyncOrdQty(newBatchOrdQtyVal);
	pHOOrderHandler.cataQtyAmnt();
};
//当用户变更“赠品数量”后，同步更新到数据结构中；
function changePresOrdQty(/*Node*/presOrdQtyElem) {
	var passValidate = true;
	// 订购数量和订购赠品数量不能同时为空
	var ordQty = $(presOrdQtyElem).prev();
	var ordQtyVal = $.trim(ordQty.val());
	var rowData = pHOOrderHandler.getCurrentItemRowData();
	if(ordQtyVal !="" && !isNaN(ordQtyVal)){
		ordQtyVal = parseFloat(ordQtyVal).toFixed(0);
		$(ordQty).val(ordQtyVal);
	}
	var ordQtyElem = $(presOrdQtyElem).next().get(0);
	var presOrdQty = $(presOrdQtyElem);
	var presOrderQtyVal = $.trim(presOrdQty.val());
	if(presOrderQtyVal !="" && !isNaN(presOrderQtyVal) && rowData.itemType != 1){
		presOrderQtyVal  = parseFloat(presOrderQtyVal).toFixed(0);
		$(presOrdQtyElem).val(presOrderQtyVal);
	}else if(presOrderQtyVal !="" && !isNaN(presOrderQtyVal) && rowData.itemType == 1){
		presOrderQtyVal  = parseFloat(presOrderQtyVal).toFixed(3);
		$(presOrdQtyElem).val(presOrderQtyVal);
	}
	
	if(($.trim(ordQtyVal) == '' || ordQtyVal == 0) && (presOrderQtyVal == '' || presOrderQtyVal== 0)) {
		if($("#action").val()!="create"){
		$(ordQty).addClass('errorInput');
		$(ordQty).attr('title', '订购数量和订购赠品数量请至少填写一个！');
		passValidate = false;
		}
	}else if(rowData.itemType != 1 && presOrderQtyVal!="" &&  !isNumber(presOrderQtyVal,7)){
		$(presOrdQtyElem).addClass('errorInput');
		$(presOrdQtyElem).attr('title', '赠品数量最多输入7位整数！');
		passValidate = false;
	}else if(rowData.itemType == 1 && presOrderQtyVal!="" && !isFloat(presOrderQtyVal,6,3)){
		$(presOrdQtyElem).addClass('errorInput');
		$(presOrdQtyElem).attr('title', '赠品数量最多输入7位整数和3位小数！');
		passValidate = false;
	}else {
		$(ordQty).removeClass('errorInput');
		$(ordQty).attr('title', '');
		$(presOrdQty).removeClass('errorInput');
		$(presOrdQty).attr('title', '');
	}
	if (!passValidate) return;
	//对非称重商品(itemType==0 && itemType ==2)，赠品数量需要执行“四舍五入”的逻辑;
	if (rowData.itemType != 1) {
		presOrderQtyVal = Math.round(presOrderQtyVal);
	}else{
		presOrderQtyVal = Math.round(presOrderQtyVal*Math.pow(10,3))/Math.pow(10,3);
	}
	pHOOrderHandler.doSyncOrdQtyByRow(ordQtyVal, ordQtyElem);
	pHOOrderHandler.doSyncPresOrdQtyByRow(presOrderQtyVal, presOrdQtyElem);
	pHOOrderHandler.cataQtyAmnt();
	pHOOrderHandler.cataPresQtyAmnt();
}
//批量更改“赠品数量”
function doBatchChangePresOrdQty(/*Node*/batchPresOrdQtyElem){
	var newBatchPresOrdQtyVal = $.trim(batchPresOrdQtyElem.value);
	if (!newBatchPresOrdQtyVal || newBatchPresOrdQtyVal==0) return;
	//对非称重商品(itemType==0 && itemType ==2)，赠品数量需要执行“四舍五入”的逻辑;
	var rowData = pHOOrderHandler.getCurrentItemRowData();
	if(!rowData)return;
	if(newBatchPresOrdQtyVal !="" && !isNaN(newBatchPresOrdQtyVal) && rowData.itemType != 1){
		newBatchPresOrdQtyVal = parseFloat(newBatchPresOrdQtyVal).toFixed(0);
		$(batchPresOrdQtyElem).val(newBatchPresOrdQtyVal);
	}else if(newBatchPresOrdQtyVal!="" && !isNaN(newBatchPresOrdQtyVal) && rowData.itemType == 1){
		newBatchPresOrdQtyVal = parseFloat(newBatchPresOrdQtyVal).toFixed(3);
		$(batchPresOrdQtyElem).val(newBatchPresOrdQtyVal);
	}
	//验证 
	if(rowData.itemType != 1 && !isNumber(newBatchPresOrdQtyVal,7)){
		top.jAlert('warning', '赠品数量最多输入7位整数！', '提示消息',function(ret){
			if(ret)	focusElement(batchPresOrdQtyElem);
		});
		return;
	}else if(rowData.itemType == 1 && !isFloat(newBatchPresOrdQtyVal,6,3)){
		top.jAlert('warning', '赠品数量只能最多7位整数和3位小数！', '提示消息',function(ret){
			if(ret)	focusElement(batchPresOrdQtyElem);
		});
		return;
	}
	pHOOrderHandler.doBatchSyncPresOrdQty(newBatchPresOrdQtyVal);
	pHOOrderHandler.cataPresQtyAmnt();
};
//当用户变更“买价”后，同步更新到数据结构中；
function changeBuyPrice(/*Node*/buyPriceElem) {
	var passValidate = true;
	var buyPriceValOrig = $.trim($(buyPriceElem).val());
	if(buyPriceValOrig && !isNaN(buyPriceValOrig)){
		buyPriceValOrig = parseFloat(buyPriceValOrig).toFixed(4);
		$(buyPriceElem).val(buyPriceValOrig);
	}
	
	var bpDiscount = $("#bpDisc").val();
	var buyPriceVal = isNaN(bpDiscount)?buyPriceValOrig:buyPriceValOrig*(1-bpDiscount*0.01);
	if (!isNaN(buyPriceVal) && buyPriceVal != 0.0000)
		buyPriceVal = buyPriceVal.toFixed(4);
		//buyPriceVal=Math.round(buyPriceVal*Math.pow(10,4))/Math.pow(10,4);
	var buyPriceLimit = pHOOrderHandler.getBuyPriceLimitFromAnyItemStoreRow(buyPriceElem);
	if (buyPriceValOrig == '') {
		$(buyPriceElem).addClass('errorInput');
		$(buyPriceElem).attr('title', '买价不可为为空');
		passValidate = false;
	}else if(!isFloat(buyPriceValOrig,5,4)){
		$(buyPriceElem).addClass('errorInput');
		$(buyPriceElem).attr('title', '买价最多输入6位整数和4位小数！');
		passValidate = false;
	}else if (buyPriceVal > buyPriceLimit) {
		$(buyPriceElem).addClass('errorInput');
		$(buyPriceElem).attr('title', '超出买价限制' + buyPriceLimit);
		passValidate = false;
	} else {
		$(buyPriceElem).removeClass('errorInput');
		$(buyPriceElem).attr('title', '');
	}
	if (!passValidate) return;
	pHOOrderHandler.doSyncBuyPriceByRow(buyPriceValOrig, buyPriceVal, buyPriceElem);
}
//批量更改“买价”
function doBatchChangeBuyPrice(/*Node*/batchBuyPriceElem){
	var newBatchBuyPriceValOrig = $.trim(batchBuyPriceElem.value);
	if (!newBatchBuyPriceValOrig || newBatchBuyPriceValOrig ==0.0000){
		pHOOrderHandler.doResetBuyPrice();
		pHOOrderHandler.doResetPromNo();
		return;
	}
	if(newBatchBuyPriceValOrig!="" && !isNaN(newBatchBuyPriceValOrig)){
		newBatchBuyPriceValOrig = parseFloat(newBatchBuyPriceValOrig).toFixed(4);
		$(batchBuyPriceElem).val(newBatchBuyPriceValOrig);
	}
	if(newBatchBuyPriceValOrig!="" && !isFloat(newBatchBuyPriceValOrig,5,4)){
		top.jAlert('warning', '买价最多输入6位整数和4位小数！', '提示消息',function(ret){
			if(ret)	focusElement(batchBuyPriceElem);
		});
		return;
	}
	var bpDiscount = $("#bpDisc").val();
	var newBatchBuyPriceVal = (isNaN(bpDiscount) || newBatchBuyPriceValOrig==0.0000)?newBatchBuyPriceValOrig:newBatchBuyPriceValOrig*(1-bpDiscount*0.01);
	if (newBatchBuyPriceVal && !isNaN(newBatchBuyPriceVal) && newBatchBuyPriceVal != 0.0000)
		newBatchBuyPriceVal = newBatchBuyPriceVal.toFixed(4);
		//newBatchBuyPriceVal=Math.round(newBatchBuyPriceVal*Math.pow(10,4))/Math.pow(10,4);	
	pHOOrderHandler.doBatchSyncBuyPrice(newBatchBuyPriceValOrig, newBatchBuyPriceVal);
	
};

function validateIntOnly(/*Event*/evtObj, /*boolean, optional*/forceGreaterThanZero) {
	  var theEvent = evtObj || window.event;
	  var keyCode = theEvent.keyCode || theEvent.which;
	  var isNum = keyCode>=48 && keyCode <= 57;
	  theEvent.returnValue = isNum;
	  return isNum;
};
//只对传入的键盘可导航类事件感兴趣，如4个方向键 + 1个回车键
function trapNavigable(/*Event*/evtObj){
	  pHOOrderHandler.doAnyKeyTrap(evtObj);
}
// 课别调整
function changeCatlg(self) {
	$(self).attr('title','');
	$(self).removeClass('errorInput');	
	var flag=true;
	var catlgId = $(self).val();
	if ($.trim(catlgId) != ''&&isNumber($.trim(catlgId),10)) {
		readCatalogInfoBySecNo(catlgId, function(data) {
			if (data != "") {
				$("#catlgName").val(data[0].secName);
			} else {
				top.jAlert('warning', '没有找到相应课别信息！', '提示消息');
				$("#catlgId").val("");
				$("#catlgName").val("");
				flag=false;
			}
		});
	}else{
		$("#catlgId").val("");
		$("#catlgName").val("");
		flag=false;	
	}
	// 清空厂商的值，并触发change时间
	if(flag){
		$('#supNo').attr('value','').trigger('change');
	}
}


// 厂商调整
function changeSup(self) {
	$(self).attr('title','');
	$(self).removeClass('errorInput');
	
	var catlgId = $('#catlgId').val();
	if ($.trim(catlgId) == '') {
		$('#catlgId').attr('title','请先选择课别');
		$('#catlgId').addClass('errorInput');
		top.jAlert('warning', '请先选择课别！', '提示消息',function(ret){
			if(ret)	focusElement($('#catlgId'));
		});
		return false;
	}
	cleanOrderInfo(); // 重置订单信息
	var supNo = $(self).val();
	if ($.trim(supNo) != ''&&isNumber($.trim(supNo),8)) {
		$.post(ctx + '/hoOrderCreate/readSupInfoBySupNo', {
			catlgId : catlgId,
			supNo : supNo
		}, function(data) {			
			if (data == null) {
				$('#supNo').attr('title','没有找到相应厂商信息');
				$('#supNo').addClass('errorInput');
				top.jAlert('warning', '没有找到相应厂商信息！', '提示消息',function(ret){
					if(ret)	focusElement($('#supNo'));
				});
				return false;
			}
			$('#supName').attr('value', data[0].comName);
			$('#supComNo').attr('value', data[0].comNo);
			$('#supUnifmNo').attr('value', data[0].unifmNo);
			$('#supType').attr('value', data[0].supType);
			$.post(ctx + '/hoOrderCreate/getSupDiscInfo', {
				'supNo' : supNo,
				'catlgId' : catlgId
			}, function(data) {
				var supplier = data["row"];
				if (supplier != null && supplier != "") {
					$("#bpDisc").val(supplier.bpdisc);
					$("#invDisc").val(supplier.invDisc);
					$("#discMemo").val(supplier.discMemo);
				}
			}, 'json');
		}, 'json');

	}
	else{
		$("#supNo").val("");
		$("#supName").val("");
	}
}

// 厂商编号，清空订单信息
function cleanOrderInfo() {
	$('#supName').attr('value', '');
	$('#supComNo').attr('value', '');
	$('#supUnifmNo').attr('value', '');
	$('#supType').attr('value', '');
	$("#bpDisc").attr('value', '');
	$("#invDisc").attr('value', '');
	$("#discMemo").attr('value', '');
	$("#buyer").attr('value', '');
	$("#buyerName").attr('value', '');
	pHOOrderHandler.clear();
}

// 课别添加弹出层事件
function selectCatlg() {
	// 打开弹出层
	openPopupWin(600, 500, '/commons/window/chooseSection');
}

// 课别回调信息
function confirmChooseSection(id, name) {
	$('#catlgId').attr('value', id);
	$('#catlgName').attr('value', name);
	// 关闭弹出层
	closePopupWin();
}

// 厂商信息弹出层
function selectSup() {
	var catlgId = $('#catlgId').val();
	if (catlgId == "") {
		top.jAlert('warning', '请选择课别！', '消息提示');
		return;
	}
	// 打开弹出层
	openPopupWin(680, 548,'/hoOrderCreate/orderSupplierSelectWindowAction?catlgId=' + catlgId);
}

// 厂商信息回调
function confirmChooseSupNo(supNo, comName) {
	$('#supNo').attr('value', supNo);
	$('#supName').attr('value', comName);
	$('#supName').attr('title', comName);
	// 关闭弹出层
	closePopupWin();
}

function saveManufacturerNo(supNo) {
	$('#supNo').attr('value', supNo);
	$('#supNo').trigger('change');
}

function newOrderItemHandler(/* Node */itemNoElement) {
	$(itemNoElement).attr('title','');
	$(itemNoElement).removeClass('errorInput');
	
	var curItemNo = $.trim($(itemNoElement).val());	
	if (curItemNo == "") {
		top.jAlert("warning", "请输入商品号", "提示消息",function(ret){
			if(ret)focusElement(itemNoElement);
		});
		return false;
	}

	if (!isNumber(curItemNo)) {
		top.jAlert("warning", "请输入数字", "提示消息",function(ret){
			if(ret)focusElement(itemNoElement);
		});
		return false;
	}

	var catlgId = $('#catlgId').val();
	var supNo = $('#supNo').val();
	// step1.根据货号，检查商品是否已经在列表中；
	var exits = pHOOrderHandler.isItemNoDuplicated(curItemNo);
	if (exits) {
		top.jAlert("warning", "商品" + curItemNo + "已经添加过了,无需重复添加", "提示消息",function(ret){
			if(ret)focusElement(itemNoElement);
		});
		return false;
	}
	getHoOrderItemList(curItemNo, supNo, catlgId,newOrderItemHandlerCallBack,itemNoElement);
}

function newOrderItemHandlerCallBack(orderItem,itemNos,itemNoElement){
	var curItemNo = $.trim($(itemNoElement).val());	
	if (!orderItem || orderItem.status != 'success') {
		top.jAlert("warning", curItemNo + orderItem.message/*(Remark: 
		if the backstage is error, so that the variable <code>orderItem</code> is null
		and the <code>orderItem.message</code> will have error messages.*/, "提示消息",function(ret){
			if(ret)focusElement(itemNoElement);
		});
		return false;
	}	
	pHOOrderHandler.replaceItemRowContent(itemNoElement, orderItem.row);
	pHOOrderHandler.getFirstItemBuyer();
}

//使Element获取焦点
function focusElement(self){
	$(self).attr('value', '');
	$(self).focus();
}
//设置Element提示消息
function tipElement(self,tipMsg){
	$(self).attr('title', tipMsg);
	$(self).addClass('errorInput');
}

function getHoOrderItemList(itemNos, supNo, catlgId,callback,itemNoElement/*当前选中的item*/,errOrderArr) {
	$.ajax({
		url : ctx + '/hoOrderCreateNew/getHoOrderItemList?ti='
				+ (new Date()).getTime(),
		data : {
			itemNos : itemNos,
			supNo : supNo,
			catlgId : catlgId
		},
		type : 'POST',
		success : function(data) {
			callback(data,itemNos,itemNoElement,errOrderArr);
		}
	});
}

// 批量复制添加订单商品
function addOrderPasteItem() {
	var isValidate = validate(); // 是否通过验证
	if (isValidate) {
		// 打开弹出层
		openPopupWin(650, 450, '/hoOrderCreateNew/addOrderPasteItem','120px');
	}
}

// 订单PopWin弹出层事件
function addOrderPopWin() {
	var isValidate = validate(); // 是否通过验证
	if (isValidate) {
		// 打开弹出层
		openPopupWin(680, 550, '/hoOrderCreateNew/addOrderItem?catlgId='
				+ $("#catlgId").val() + '&catlgName=' + encodeURI(encodeURI($('#catlgName').val()))
				+ '&supNo=' + $("#supNo").val(),'100px');
	}
}

// 厂商信息弹出层
function selectSup() {
	var catlgId = $('#catlgId').val();
	if (catlgId == "") {
		top.jAlert('warning', '请选择课别！', '消息提示');
		return;
	}
	openPopupWin(680, 548,'/hoOrderCreate/orderSupplierSelectWindowAction?catlgId=' + catlgId);
}

// 弹出订单中商品下传的门店
/*function showOrderItemStore(){
	var itemNo = $('.pro_store_tb_edit .item_on').find("input[name='itemNo'").val();
	if(itemNo=""||itemNo==undefined)
		{
		 top.jAlert('warning', '请选择订单商品', '提示消息');
    	 return false;
		}
	openPopupWinTwo(624, 423, "/hoOrderCreateNew/hoOrderStoresShow?itemNumModStr="
								+ itemNo);
}*/
		
// 课别回调信息
function confirmChooseSection(id, name) {
	$('#catlgId').attr('value', id);
	$('#catlgName').attr('value', name);
	$('#catlgId').trigger('change');
	// 关闭弹出层
	closePopupWin();
}
// 批量修改订购数量
function batchUpdateOrdQty(self) {
	var curValue = $(self).val();
	$(self).parent().parent().next().find('input[name=ordQty]').attr('value',curValue);
	$(self).parent().parent().next().find('input[name=ordQty]').trigger('change');
}
// 批量修改赠品数量
function batchUpdatePresOrdQty(self) {
	var curValue = $(self).val();
	$(self).parent().parent().next().find('input[name=presOrdQty]').attr('value', curValue);
	$(self).parent().parent().next().find('input[name=presOrdQty]').trigger('change');
}
// 批量修改买价
function batchUpdateBuyPrice(self) {
	var curValue = $(self).val();
	$(self).parent().parent().next().find('input[name=buyPrice]').attr('value',curValue);
	$(self).parent().parent().next().find('input[name=buyPrice]').trigger('change');
}
/*reset the data of the order items and the order items' stores*/
function dateChangeConfirm(dp){
	$('#planRecptDate').attr('title','');
	$('#planRecptDate').removeClass('errorInput');
	var planRecptDate = dp.cal.getNewDateStr();
	var orderDate = $("#orderDate").val();
	if ($.trim(planRecptDate) == '') {
		$('#planRecptDate').attr('title','请选择预定收货日');
		$('#planRecptDate').addClass('errorInput');
		return false;
	}
	var days=getSubDays(orderDate,planRecptDate);
    if(days<0||days>180){
		$('#planRecptDate').attr('title','预定收货日须大于订单日且不能超过订单日6个月');
		$('#planRecptDate').addClass('errorInput');
		return false;
    }
	if (pHOOrderHandler.itemsList.length>0 && (dp.cal.getDateStr() != dp.cal.getNewDateStr())){
		var old_date = dp.cal.getDateStr();
		top.jConfirm('修改预定收货日，将根据商品是否存在进价促销刷新买价', '提示消息', function(ret) {
			if (ret) {
				//update the flag that if the planRecptDate changes.
				pHOOrderHandler.ifPlanRecptDateChange=true;
				//update the promNo and buyPrice with the stores of the loaded items.
				var hoOrderItemList=pHOOrderHandler.itemsList;
				var loadedItemNoList=[];
				for(var itemIndex=0;itemIndex<hoOrderItemList.length;itemIndex++){
					var itemNo=hoOrderItemList[itemIndex].itemNo;
					if(!itemNo||!pHOOrderHandler.itemStoresMapping[itemNo].loaded){
						continue;
					}
					loadedItemNoList.push(itemNo);
				}
				pHOOrderHandler.reloadPromBuyPriceByPlanRecptDate(loadedItemNoList);
			} else {
				$("#planRecptDate").val(old_date);
				return;
			}
		});
	}
}

/*
 * validtate the paste itemNos when saving the paste itemNos.
 */
function savePasteOrderItemList(){
	top.grid_layer_open();
	var orderStr=$.trim($("#orderList").val()) == "请输入正确的商品号" ? "" : $.trim($("#orderList").val()).replace(/;$/,"");
	var catlgId = $('#catlgId').val();
	var supNo = $('#supNo').val();
	var reg = /[\n;]/;
	var pattern  = /^[1-9]{1}[0-9]{0,7}$/;
	var errOrderArr=[];// 保存错误的货号
	var styleValidOrderItemNos=[];
	$("#errorMsg").html("");
	var orderArr=[];
	if(orderStr!="")
	{
	   orderArr=orderStr.split(reg);
	   for(var i=0;i<orderArr.length;i++)
		  {
		    orderArr[i] = $.trim(orderArr[i]);
		    if(!pattern.test(orderArr[i])){
		    	errOrderArr.push(orderArr[i]);
		    }
		    else{
		    	styleValidOrderItemNos.push(orderArr[i]);
		    }
		  }
	}
	if(styleValidOrderItemNos.length==0){
	    // clear the valid textarea.
		$("#orderList").val("");
		//display the invalid itemNos in the textarea.
		$("#errorOrderList").val("");
		$("#errorOrderList").val(errOrderArr.join(";"));
		top.jAlert("warning","商品号不能为空","提示信息");
		top.grid_layer_close();
		return false;
	}
	if(styleValidOrderItemNos.length>1000){
		top.jAlert("warning","商品号最多输入1000个","提示信息");
		top.grid_layer_close();
		return false;
	}
	var itemNos=styleValidOrderItemNos.join(",");
	addHoOrderItemList(errOrderArr,itemNos,supNo,catlgId);
	top.grid_layer_close();
};

/*
 * this is a callback function that getting HO order item list according by the
 * itemNo、supNo、catlgId.
 */
function addHoOrderItemList(errOrderArr,itemNos,supNo,catlgId){
	getHoOrderItemList(itemNos,supNo,catlgId,addHoOrderItemListCallBack,null,errOrderArr);
};

function addHoOrderItemListCallBack(orderItem,itemNos,itemElement,errOrderArr){
	var itemNosArray = itemNos.split(",");
	var validItemNos=[];
	var inValidItemNos=[];
	if(orderItem.row){
		$.each(orderItem.row,function(index,obj){
			validItemNos.push(obj.itemNo);
		});
		inValidItemNos=compareToErrorItems(itemNosArray,validItemNos);	
	}else{
		inValidItemNos=itemNosArray;
	}
	//push the invalid itemNos into the errorOrderArr.
	if(inValidItemNos.length>0){
		errOrderArr=errOrderArr.concat(inValidItemNos);	 
	}
	if(validItemNos.length==0){
	    // clear the valid textarea.
		$("#orderList").val("");
		//display the invalid itemNos in the textarea.
		$("#errorOrderList").val("");
		$("#errorOrderList").val(errOrderArr.join(";"));
		top.jAlert("warning","商品号不能为空","提示信息");
		return false;
	}
	//if the error itemNos have,displaying the error itemNos in the textarea.
	if(errOrderArr.length>0)
	{
	    // display the valid itemNos in the textarea.
		$("#orderList").val("");
		$("#orderList").val(validItemNos.join(";"));
		//display the invalid itemNos in the textarea.
		$("#errorOrderList").val("");
		$("#errorOrderList").val(errOrderArr.join(";"));
	}
	if($.trim($("#errorOrderList").val())){
		top.jConfirm('你确定忽视错误的货号继续添加吗','提示消息',function(ret){		
			if(ret){
				closePopupWin();
				pHOOrderHandler.addNewItems(orderItem.row);
			}
		});
		return false;
	}
	closePopupWin();
    pHOOrderHandler.addNewItems(orderItem.row);
}

function checkAllStore(self){
	var check=$(self).attr("checked");
		if(check=='checked'){	
			$('input[name="storeNoCk"]').each(function(){
    	      $(this).attr("checked",true);
			  });
		  }
		else{
		  $('input[name="storeNoCk"]').each(function(){
			 $(this).attr("checked",false);
		  });
		}
};

function deleteCheckedStore(self) {
    var storeCkNoArr=$('input[name="storeNoCk"]:checked'); 
	if (storeCkNoArr.length == 0) {
		top.jAlert('warning', '请选择要删除的订单商品分店信息！', '提示消息');
		return false;
	}
	$(storeCkNoArr).each(function() {
		$(this).parent().remove();
	});
};

function addOrderItemStores(storeArr){
	if(!storeArr || storeArr.length==0){
		 top.jAlert('warning', '请选择要添加的门店信息', '提示消息');
		 return false;
	}
	closePopupWinTwo();
	var currentItem = pHOOrderHandler.getCurrentItemRowData();
	var planRecptDate = $('#planRecptDate').val();
	var orderDate = $('#orderDate').val();
	var bpdisc = $('#bpDisc').val();
	var supNo=$('#supNo').val();
	var catlgId=$('#catlgId').val();	
	var ordNo = $('#ordNo').val();
	var txtBatchChangeOrdQty = $('#txtBatchChangeOrdQty').val();
	var txtBatchChangePresOrdQty = $('#txtBatchChangePresOrdQty').val();
	var txtBatchChangeBuyPrice = $('#txtBatchChangeBuyPrice').val();
	$.ajax({
		url : ctx + '/hoOrderCreateNew/getHoOrderItemStoreList?ti='+ (new Date()).getTime(),
		data : {
			itemNo : currentItem.itemNo,
			planRecptDate : planRecptDate,
			orderDate : orderDate,
			bpDisc : bpdisc,
			supNo : supNo,
			catlgId : catlgId,
			buyWhen : currentItem.buyWhen,
			ordNo : ordNo,
			storeStr:storeArr.join(',')
		},
		type : 'POST',
		success : function(data) {
			$.each(data,function(index,obj){
				if(txtBatchChangeOrdQty){
					obj.ordQty = txtBatchChangeOrdQty;
				}
				if(txtBatchChangePresOrdQty){
					obj.presOrdQty = txtBatchChangePresOrdQty;
				}
				obj.lastBuyPrice = obj.buyPrice;
				if(txtBatchChangeBuyPrice && bpdisc && !isNaN(bpdisc)){
					obj.buyPrice = txtBatchChangeBuyPrice*(1-parseInt(bpdisc)*0.01);;
				}
			});
			pHOOrderHandler.addNewStores(data, currentItem.buyWhen);
		}
	});
}
/*
 * get valid itemArray according by comparing the all items with the valid Items
 */
function compareToErrorItems(itemsArray,vaildItemsArray){
	var errorItemNos=[];
	if(vaildItemsArray.length>0&&itemsArray.length>0){
		$.each(itemsArray,function(index,value){
			var item=value;
			var flag=false;
			$.each(vaildItemsArray,function(index,value){
				if(item==value){
					flag=true;
					return false;
				}
			});
			if(!flag){	
				errorItemNos.push(item);
			}	
		});
	}
	return errorItemNos;
};

// 根据订单号码加载商品
function loadItemByOrdNo(ordNo) {
	$.ajax({
		type : "post",
		url : ctx + '/hoOrderCreateNew/geHotOrderItemsInfo',
		data : {
			ordNo : ordNo
		},
		success : function(data){
			$.each(data,function(index,obj){
				obj.action = 'update';
			});
			pHOOrderHandler.addNewItems(data);	
		}
	});
};

/**
 * 批量輸入訂購數量視窗 
 */
function pasteOrdQty(){
	if ($(".hoOrderCreateStore:visible .store_tb2 .ig_padding").length == 0) {
		top.jAlert('warning', '请选择要编辑订购数量的商品', '提示消息');
		return;
	}
	openPopupWin(650, 500, '/hoOrderCreate/pasteOrdQty');
}

/**
 * 批量貼上訂購數量後, 分開店號和數量, 檢查完後放到頁面上  
 */
function parseOrdQty(){
	var result = [];
	var count = 0;
	var errorMsg = "";
	var lines = $('#ordQtyArea').val().split('\n');
	var inputArray = [];
	// 分析輸入的內容, 將店號與數量分開, 放入 result array
	$.each(lines, function(index, value){
		if ($.trim(value)){
			var temp = $.trim(value).split(/(\s+)/);
			if (isNumber($.trim(temp[0]).substr(0,3)) && isNumber($.trim(temp[temp.length-1]))){
				inputArray = [];
				inputArray.push($.trim(temp[0].substr(0,3)));
				inputArray.push($.trim(temp[(temp.length-1)]));
				result[count] = inputArray;
				count ++;
			}else{
				errorMsg += "第" + (index+1) + "行有誤; ";
			}
		}
	});
	if (errorMsg){
		$('.msg').text(errorMsg);
		return false;
	}
	$.each(result, function(index, value){
		$('#ordQty-'+ $.trim(value[0]) +':visible').val($.trim(value[1]));
	});
	return true;
}

/**
 * 批量輸入的訂購數量後, trigger change 的檢查 
 */
function submitOrdQty(){
	top.grid_layer_open(); 
	if (parseOrdQty()){
		closePopupWin();
		var storesNode = pHOOrderHandler.itemStoresCanvas.getContainerNode();
		for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
			var oneStoreRowNode = storesNode.children[storeIndex];
			var ordQtyElem = oneStoreRowNode.children[4]; 
			$(ordQtyElem).trigger('change');	
		}
	}
	top.grid_layer_close(); 
}

/**
 * 檢查全選框是否要勾選
 * @param obj
 */
function checkSelectAll(obj){
	var name = $(obj).attr("name");
	if ($(".hoOrderCreateStore:visible #orderItemStoreList input[name=" + name + "]").length == $(".hoOrderCreateStore:visible #orderItemStoreList input[name=" + name + "]:checked").length){
		$(".hoOrderCreateStore .top5 .checkAll").attr("checked", "checked");
	}
	else{
		$(".hoOrderCreateStore .top5 .checkAll").removeAttr("checked");
	}
}

/**取消選取下方分店訊息的全選框
 * 
 */
function clearCheckAll(){
	$('input[name="storeNoCk"]').removeAttr("checked");	
}

/**
 * 選取全選框時, 將所有多選框打勾
 * 
 * (备注:rachel,这个我暂时注释掉,如果对你有影响,你要在绑定前面加一个范围限定他只能在
 * 某一个范围起作用 --王海).
 */
/*$(".checkAll").on("click",function(){
	var check=$(this).attr("checked");
	$('input[name="storeNoCk"]').each(function() {
		if(check=='checked'&&!$(this).attr("disabled"))
			{
    	      $(this).attr("checked",true);
			}
		else
			{
			 $(this).attr("checked",false);
			}
  });	
});*/

/*check the order_item_stores selects' state according by the selectAll states. */
function chkAllStoreNo(self){
	var check=$(self).attr("checked");
	$('#orderItemStoreList input[name="storeNoCk"]').each(function() {
		if(check=='checked'&&!($(self).attr("disabled")))
			{
    	      $(this).attr("checked",true);
			}
		else{
			 $(this).attr("checked",false);
			}
  });
}
/*check the order_item_stores selectAll state according by the selects' states.*/
function checkStoreSelectAllStat(){
	if($(".hoOrderCreateStore #orderItemStoreList input[name='storeNoCk']").length==0){
		$(".hoOrderCreateStore .top5 .checkAll").removeAttr("checked");
		return;
	}
	if ($(".hoOrderCreateStore #orderItemStoreList input[name='storeNoCk']").length == $(".hoOrderCreateStore #orderItemStoreList input[name='storeNoCk']:checked").length){
		$(".hoOrderCreateStore .top5 .checkAll").attr("checked", "checked");
	}
	else{
		$(".hoOrderCreateStore .top5 .checkAll").removeAttr("checked");
	}
}