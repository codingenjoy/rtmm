/* 页签下的条款列表区域画布*/
function PlanItemStoreCanvas(){
	
};
PlanItemStoreCanvas.prototype = new RowBasedCanvas();
PlanItemStoreCanvas.prototype.getContainerNode = function(){
	return document.getElementById('itemStoreDivArea');
};
PlanItemStoreCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('itemStoreTemplate');
	return templateNode.children[0].innerHTML;
};
/*
 * 根据传入的单笔【门店】数据，在画布区域上显示。
 */
PlanItemStoreCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn){
	//门店数据赋值
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.storeNo + "-" + rowDataIn.storeName, 1);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.initQty || '', 2);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.stCnfrmQty || '', 3);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.finalQty || '', 4);
	this.setRowMemberNodeValue(rowNodeIn, new Date(rowDataIn.chngDate).format("yyyy-MM-dd") || '', 5);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.storeNo || '', 6);
};
PlanItemStoreCanvas.prototype.getActivatedRowPK = function(/*None*/){
	return this.rowSelectedTag.pk;
};
PlanItemStoreCanvas.prototype.getActivatedRowIndex = function(/*None*/){
	return this.rowSelectedTag.position;
};

PlanItemStoreCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	$(newRowNodeIn).attr("class","item");
	//$(newRowNodeIn).attr("onclick", "doOnTempTabTermSelected(this)");
};
PlanItemStoreCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "item_on";
};
/**
 * 获取条款的标识符，（格式：1-0）
 * @param {} tabIdIn
 * @param {} currTabTermsSnapshotData
 * @return {}
 */
PlanItemStoreCanvas.prototype.getIndexId = function(/*String*/tabIdIn, /*Array*/currTabTermsSnapshotData){
	var termIdOld = "";
	if (currTabTermsSnapshotData.length > 0) {
		termIdOld = currTabTermsSnapshotData[currTabTermsSnapshotData.length-1].termId;
		var termIdFirst = termIdOld.substring(0,termIdOld.lastIndexOf('-'));
		var termIdNew = termIdOld.substring(termIdOld.lastIndexOf('-')+1);
		return termIdFirst + "-" + (Number(termIdNew)+1);
	} else {
		return tabIdIn+"-"+0;
	}
};
PlanItemStoreCanvas.prototype.setAttributeCheckBox = function(/*Boolean*/ flag){
	$(this.getContainerNode()).next().get(0).children[0].checked = flag;
};
//验证是否有条款存在
PlanItemStoreCanvas.prototype.checkChildrenIsNotNull = function(/*Null*/){
	//获取条款总条数
	var termSum = this.getRowCount();
	//判断条款是否为空
	if (termSum <= 0) {
		return true;
	} else {
		return false;
	}
};
//获取下一个光标
PlanItemStoreCanvas.prototype.getNextCursor = function(/*Node*/currentNode){
	var nextElem = $(currentNode).next().get(0);
	if (nextElem) {
		nextElem.focus();
	}
};
//新增和删除按钮置灰
PlanItemStoreCanvas.prototype.setButtonPutTheAsh = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	$(nextElem.children[0]).attr("disabled","disabled");
	$(nextElem.children[1]).attr("class", "Icon-size2 Tools10_disable sp_icon2");
	$(nextElem.children[3]).attr("class", "Icon-size2 Tools11_disable sp_icon4");
};
//新增和删除按钮置亮
PlanItemStoreCanvas.prototype.setButtonRearLight = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	$(nextElem.children[0]).removeAttr("disabled");
	$(nextElem.children[1]).attr("class", "Icon-size2 Tools10 sp_icon2");
	$(nextElem.children[3]).attr("class", "Icon-size2 Tools11 sp_icon4");
};
//判断删除按钮
PlanItemStoreCanvas.prototype.checkedDeleButton = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	var deleElem = $(nextElem.children[1]);
	if (deleElem.hasClass("Tools10_disable")) {
		return true;
	} else {
		return false;
	}
};
//判断新增按钮
PlanItemStoreCanvas.prototype.checkedAndButton = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	var deleElem = $(nextElem.children[3]);
	if (deleElem.hasClass("Tools11_disable")) {
		return true;
	} else {
		return false;
	}
};
//序号重新赋值
PlanItemStoreCanvas.prototype.toAssignValue = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var containerChildren = containerNode.children;
	for (var index = 0; index < containerChildren.length; index++) {
		var secondChildren = containerChildren[index].children[1];
		secondChildren.value = index + 1;
	}
};
//验证当前被选中的条款是否删除，如果不删除，不做任何操作。
PlanItemStoreCanvas.prototype.checkCurrentRowWhetherSelected = function(/*Null*/){
	var flag = false;
	var containerNode = this.getContainerNode();
	var containerChildren = containerNode.children;
	for (var index = 0; index < containerChildren.length; index++) {
		var classStr = this.getRowSelectedClassStr();
		if ($(containerChildren).hasClass(classStr)) {
			var secondChildren = containerChildren[index].children[0];
			if (!secondChildren.checked) {
				flag = true;
				break ;
			}
		}
	}
	return flag;
};
//错误信息标红
PlanItemStoreCanvas.prototype.errorStoreElementFlag = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var containerChildren = containerNode.children;
	for (var index = 0; index < containerChildren.length; index++) {
		var initQtyElem = containerChildren[index].children[2];
		if ($.trim(initQtyElem.value) == "" || $.trim(initQtyElem.value) == "0") {
			$(initQtyElem).addClass("errorInput");
		}
	}
};
//批量修改
PlanItemStoreCanvas.prototype.batchUpdateInitQtys = function(/*Integer*/batchInitQty){
	var containerNode = this.getContainerNode();
	var containerChildren = containerNode.children;
	for (var index = 0; index < containerChildren.length; index++) {
		var childrenElement = containerChildren[index].children[2];
		childrenElement.value = batchInitQty;
	}
};
//批量错误标红
PlanItemStoreCanvas.prototype.batchErrorElement = function(/*String*/errorMessage){
	var containerNode = this.getContainerNode();
	var tableElement = $(containerNode).prev();
	var batchElement = tableElement[0].rows[1].cells[1].children[0];
	$(batchElement).addClass("errorInput");
	$(batchElement).attr("title",errorMessage);
};

//验证建议量
PlanItemStoreCanvas.prototype.checkInitQty = function(/*String*/stMinOrdQty){
	var containerNode = this.getContainerNode();
	var batchInitQty = $(containerNode).prev().get(0);
	var batchElem = batchInitQty.rows[1].cells[1].children[0];
	//验证批量修改量
	if (batchElem.value) {
		if (batchElem.value < stMinOrdQty) {
			batchElem.value = "";
			//设置红色背景色
			this.errorElementFlag(/*Node*/batchElem);
			this.hintMessage(/*Node*/batchElem, /*String*/"建议量必须大于等于最小量");
		}
	}
	//验证门店是否有子元素
	if (containerNode.children != 0) {
		var childrenArray = containerNode.children;
		for (var ind = 0; ind < childrenArray.length; ind++) {
			var childrenElem = childrenArray[ind];
			var initQtyElem = childrenElem.children[2];
			//验证建议量
			if (initQtyElem.value) {
				if (initQtyElem.value < stMinOrdQty) {
					initQtyElem.value = "";
					//设置红色背景色
					this.errorElementFlag(/*Node*/initQtyElem);
					this.hintMessage(/*Node*/initQtyElem, /*String*/"建议量必须大于等于最小量");
				}
			}
		}
	}
};

//去除错误标红
PlanItemStoreCanvas.prototype.remvoeErrorMess = function(/*null*/){
	var containerNode = this.getContainerNode();
	$(containerNode).find(".errorInput").removeClass("errorInput");
};


//清空建议量
PlanItemStoreCanvas.prototype.clearInitQty = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var batchInitQty = $(containerNode).prev().get(0);
	var batchElem = batchInitQty.rows[1].cells[1].children[0];
	batchElem.value = "";
	if (containerNode.children != 0) {
		var childrenArray = containerNode.children;
		for (var ind = 0; ind < childrenArray.length; ind++) {
			var childrenElem = childrenArray[ind];
			var initQtyElem = childrenElem.children[2];
			initQtyElem.value = "";
		}
	}
};

//清空批量修改建议量
PlanItemStoreCanvas.prototype.clearBatchInitQty = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var batchInitQty = $(containerNode).prev().get(0);
	var batchElem = batchInitQty.rows[1].cells[1].children[0];
	batchElem.value = "";
};