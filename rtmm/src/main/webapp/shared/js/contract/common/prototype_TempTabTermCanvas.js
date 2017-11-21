/* 页签下的条款列表区域画布*/
function TempTabTermCanvas(){
	
};
TempTabTermCanvas.prototype = new RowBasedCanvas();
TempTabTermCanvas.prototype.getContainerNode = function(){
	return document.getElementById('templTabTermDiv');
};
TempTabTermCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('templateOneTabTerm');
	return templateNode.children[0].innerHTML;
};
/*
 * 根据传入的单笔【条款】数据，在画布区域上显示。
 */
TempTabTermCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn){
	//条款数据赋值
	var pseudoTermNo = this.getRowIndex(rowNodeIn)+1;
	this.setRowMemberNodeValue(rowNodeIn, pseudoTermNo, 1);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.termName || '', 2);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.termEnName || '', 3);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.payMethOpensStr || '', 4,0);
	rowNodeIn.children[4].children[0].setAttribute("title",rowDataIn.payMethOpensStr || '');
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.payMethdOptns || '', 4,1);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.fixDsplyInd || 0, 5);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.paperPageNo || 0, 6);
};
TempTabTermCanvas.prototype.getActivatedRowPK = function(/*None*/){
	return this.rowSelectedTag.pk;
};
TempTabTermCanvas.prototype.getActivatedRowIndex = function(/*None*/){
	return this.rowSelectedTag.position;
};

TempTabTermCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	$(newRowNodeIn).attr("class","item");
	$(newRowNodeIn).attr("onclick", "doOnTempTabTermSelected(this)");
};
TempTabTermCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "item_on";
};
/**
 * 获取条款的标识符，（格式：1-0）
 * @param {} tabIdIn
 * @param {} currTabTermsSnapshotData
 * @return {}
 */
TempTabTermCanvas.prototype.getIndexId = function(/*String*/tabIdIn, /*Array*/currTabTermsSnapshotData){
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
TempTabTermCanvas.prototype.setAttributeCheckBox = function(/*Boolean*/ flag){
	$(this.getContainerNode()).next().get(0).children[0].checked = flag;
};
//验证是否有条款存在
TempTabTermCanvas.prototype.checkChildrenIsNotNull = function(/*Null*/){
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
TempTabTermCanvas.prototype.getNextCursor = function(/*Node*/currentNode){
	var nextElem = $(currentNode).next().get(0);
	if (nextElem) {
		nextElem.focus();
	}
};
//新增和删除按钮置灰
TempTabTermCanvas.prototype.setButtonPutTheAsh = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	$(nextElem.children[0]).attr("disabled","disabled");
	$(nextElem.children[1]).attr("class", "Icon-size2 Tools10_disable sp_icon2");
	$(nextElem.children[3]).attr("class", "Icon-size2 Tools11_disable sp_icon4");
};
//新增和删除按钮置亮
TempTabTermCanvas.prototype.setButtonRearLight = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	$(nextElem.children[0]).removeAttr("disabled");
	$(nextElem.children[1]).attr("class", "Icon-size2 Tools10 sp_icon2");
	$(nextElem.children[3]).attr("class", "Icon-size2 Tools11 sp_icon4");
};
//判断删除按钮
TempTabTermCanvas.prototype.checkedDeleButton = function(/*Null*/){
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
TempTabTermCanvas.prototype.checkedAndButton = function(/*Null*/){
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
TempTabTermCanvas.prototype.toAssignValue = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var containerChildren = containerNode.children;
	for (var index = 0; index < containerChildren.length; index++) {
		var secondChildren = containerChildren[index].children[1];
		secondChildren.value = index + 1;
	}
};
//验证当前被选中的条款是否删除，如果不删除，不做任何操作。
TempTabTermCanvas.prototype.checkCurrentRowWhetherSelected = function(/*Null*/){
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
TempTabTermCanvas.prototype.errorElementFlag = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var containerChildren = containerNode.children;
	for (var index = 0; index < containerChildren.length; index++) {
		var termNameElem = containerChildren[index].children[2];
		var termPayMethdOptnsElem = containerChildren[index].children[4].children[0];
		if ($.trim(termNameElem.value) == "") {
			$(termNameElem).addClass("errorInput");
		}
		if ($.trim(termPayMethdOptnsElem.value) == "") {
			$(termPayMethdOptnsElem).addClass("errorInput");
		}
	}
};