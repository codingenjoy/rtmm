/* 保留计划商品1画布*/
function PlanItemFirstCanvas(){
	this.isPickyRowCreation = true;
};
PlanItemFirstCanvas.prototype = new RowBasedCanvas("tr");
PlanItemFirstCanvas.prototype.getContainerNode = function(){
	var tbodyElement = document.getElementById('itemListFirstDivArea');
	return tbodyElement.children[0] || tbodyElement;
};
PlanItemFirstCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('itemFirstTemplate');
	return templateNode.children[0].innerHTML;
};

//返回一行新创建的冻结表头元素，为<tr></tr>
PlanItemFirstCanvas.prototype.getPickyRowNodeOnCreation = function(/*None*/){
	var templateNode = document.getElementById('itemFirstTemplate');
	var oneNewTR = this.getContainerNode().insertRow();
	for (var cellIndex=0;cellIndex<=8;cellIndex++){
		var newCell = oneNewTR.insertCell();
		newCell.innerHTML = templateNode.children[0].children[cellIndex].innerHTML;
	}
	return oneNewTR;
};

/**
 * 根据传入的单笔【商品】数据，在画布区域上显示。
 * @param {} rowNodeIn
 * @param {} rowDataIn
 */
PlanItemFirstCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn){
	//商品赋值数据
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.itemNo || '', 0, 0, 0);	//货号
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.itemName || '', 1, 0);		//品名
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.ordMultiParm || '', 2, 0);		//订购倍数
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.curBuyPrice || '', 3, 0);		//本次进价
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.normBuyPrice || '', 4, 0);		//正常进价
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.stMainSupNo || '', 5, 0);	//厂编
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.comName || '', 6, 0);		//公司名称
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.stMinOrdQty || '', 7, 0);		//最小量
	this.setRowMemberNodeValue(rowNodeIn, '', 8, 0);		//总配额
};
PlanItemFirstCanvas.prototype.getActivatedRowPK = function(/*None*/){ 
	return this.rowSelectedTag.pk;
};
PlanItemFirstCanvas.prototype.getActivatedRowIndex = function(/*None*/){
	return this.rowSelectedTag.position;
};
PlanItemFirstCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	//0.根据模板文件中的定义，设置样式；
	$(newRowNodeIn).attr("onclick", "doOnItemSelected(this)");
	//$(newRowNodeIn).addClass("tr2");
	var randomx= this.getContainerNode().rows.length;
	$(newRowNodeIn).attr("_index", "tr"+randomx);
	$(newRowNodeIn).addClass("tr"+randomx);
	//1.设置“切换代号类别”的事件处理函数；
	//newRowNodeIn.children[0].setAttribute("onchange", "doOnUnitTypeChanged(this)");
	//2.设置焦点[代号输入框]
	//this.setRowMemberFocusedByNode(newRowNodeIn, 1, 0);
	
};
PlanItemFirstCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "tr_click_on";
};
//清除目标代号行上的所有文本框内容（注意：除[模版页签类型]）
PlanItemFirstCanvas.prototype.resetRowContentByNode = function(/*Node*/anyRowMemberNodeIn){
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
PlanItemFirstCanvas.prototype.getIndexId = function(){
	return this.getRowCount() + 1;
};
PlanItemFirstCanvas.prototype.setAttributeCheckBox = function(/*Boolean*/ flag){
	$(this.getContainerNode()).next().get(0).children[0].checked = flag;
};
//验证是否有页签存在
PlanItemFirstCanvas.prototype.checkChildrenIsNotNull = function(/*Null*/){
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
PlanItemFirstCanvas.prototype.getNextCursor = function(/*Node*/currentNode){
	var nextElem = $(currentNode).next().get(0);
	if (nextElem) {
		nextElem.focus();
	}
};
//序号重新赋值
PlanItemFirstCanvas.prototype.toAssignValue = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var containerChildren = containerNode.children;
	for (var index = 0; index < containerChildren.length; index++) {
		var secondChildren = containerChildren[index].children[1];
		secondChildren.value = index + 1;
	}
};
//验证当前被选中的页签是否删除，如果不删除，不做任何操作。
PlanItemFirstCanvas.prototype.checkCurrentRowWhetherSelected = function(/*Null*/){
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
//获取当前元素在row中的索引
PlanItemFirstCanvas.prototype.getChildrenIndex = function(/*Node*/currentNode){
	return $($(currentNode).parents('td')).index();
};
