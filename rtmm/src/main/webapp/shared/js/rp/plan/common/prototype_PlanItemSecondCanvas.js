/* 促销代号画布*/
function PlanItemSecondCanvas(){
	this.isPickyRowCreation = true;
};
PlanItemSecondCanvas.prototype = new RowBasedCanvas("tr");
PlanItemSecondCanvas.prototype.getContainerNode = function(){
	var tbodyElement = document.getElementById('itemListSecondDivArea');
	return tbodyElement.children[0] || tbodyElement;
};
PlanItemSecondCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('itemSecondTemplate');
	return templateNode.children[0].innerHTML;
};
//返回一行新创建的冻结表头元素，为<tr></tr>
PlanItemSecondCanvas.prototype.getPickyRowNodeOnCreation = function(/*None*/){
	var templateNode = document.getElementById('itemSecondTemplate');
	var oneNewTR = this.getContainerNode().insertRow();
	var newCell = oneNewTR.insertCell();
	newCell.innerHTML = templateNode.children[0].innerHTML;
	return oneNewTR;
};

/**
 * 根据传入的单笔【页签】数据，在画布区域上显示。
 * @param {} rowNodeIn
 * @param {} rowDataIn
 */
PlanItemSecondCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn){
	//条款数据赋值
};
PlanItemSecondCanvas.prototype.getActivatedRowPK = function(/*None*/){ 
	return this.rowSelectedTag.pk;
};
PlanItemSecondCanvas.prototype.getActivatedRowIndex = function(/*None*/){
	return this.rowSelectedTag.position;
};
PlanItemSecondCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	//0.根据模板文件中的定义，设置样式；
	$(newRowNodeIn).attr("onclick", "doOnItemSelected(this)");
	//$(newRowNodeIn).addClass("tr0");
	var randomx= this.getContainerNode().rows.length;
	$(newRowNodeIn).attr("_index", "tr"+randomx);
	$(newRowNodeIn).addClass("tr"+randomx);
	//1.设置“切换代号类别”的事件处理函数；
	//newRowNodeIn.children[0].setAttribute("onchange", "doOnUnitTypeChanged(this)");
	//2.设置焦点[代号输入框]
	//this.setRowMemberFocusedByNode(newRowNodeIn, 1, 0);
	
};
PlanItemSecondCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "tr_click_on";
};
//清除目标代号行上的所有文本框内容（注意：除[模版页签类型]）
PlanItemSecondCanvas.prototype.resetRowContentByNode = function(/*Node*/anyRowMemberNodeIn){
	this.setRowMemberNodeValue(anyRowMemberNodeIn, "", 1, 0);
	this.setRowMemberNodeValue(anyRowMemberNodeIn, "", 2);
	this.setRowMemberNodeValue(anyRowMemberNodeIn, "", 3);
	this.setRowMemberNodeValue(anyRowMemberNodeIn, "", 4);
};

//****************************************************************************************************************************************************
//一下是添加的
/**
 * 获取页签的标识符，（格式：1）
 */
PlanItemSecondCanvas.prototype.getIndexId = function(){
	return this.getRowCount() + 1;
};
PlanItemSecondCanvas.prototype.setAttributeCheckBox = function(/*Boolean*/ flag){
	$(this.getContainerNode()).next().get(0).children[0].checked = flag;
};
//验证是否有页签存在
PlanItemSecondCanvas.prototype.checkChildrenIsNotNull = function(/*Null*/){
	//获取页签总条数
	var acctSum = this.getRowCount();
	//判断页签是否为空
	if (acctSum <= 0) {
		return true;
	} else {
		return false;
	}
};
//获取下一个光标
PlanItemSecondCanvas.prototype.getNextCursor = function(/*Node*/currentNode){
	var nextElem = $(currentNode).next().get(0);
	if (nextElem) {
		nextElem.focus();
	}
};
//序号重新赋值
PlanItemSecondCanvas.prototype.toAssignValue = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var containerChildren = containerNode.children;
	for (var index = 0; index < containerChildren.length; index++) {
		var secondChildren = containerChildren[index].children[1];
		secondChildren.value = index + 1;
	}
};
//验证当前被选中的页签是否删除，如果不删除，不做任何操作。
PlanItemSecondCanvas.prototype.checkCurrentRowWhetherSelected = function(/*Null*/){
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
