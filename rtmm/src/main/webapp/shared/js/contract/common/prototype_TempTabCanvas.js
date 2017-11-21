/* 促销代号画布*/
function TempTabCanvas(){
};
TempTabCanvas.prototype = new RowBasedCanvas();
TempTabCanvas.prototype.getContainerNode = function(){
	return document.getElementById('templTabCodeDiv');
};
TempTabCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('templateOneTab');
	return templateNode.children[0].innerHTML;
};
/**
 * 根据传入的单笔【页签】数据，在画布区域上显示。
 * @param {} rowNodeIn
 * @param {} rowDataIn
 */
TempTabCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn){
	//条款数据赋值
	var pseudoTabNo = this.getRowIndex(rowNodeIn)+1;
	this.setRowMemberNodeValue(rowNodeIn, pseudoTabNo, 1);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.tabName || '', 2);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.tabEnName || '', 3);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.tabType || '', 4);
};
TempTabCanvas.prototype.getActivatedRowPK = function(/*None*/){ 
	return this.rowSelectedTag.pk;
};
TempTabCanvas.prototype.getActivatedRowIndex = function(/*None*/){
	return this.rowSelectedTag.position;
};
TempTabCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	//0.根据模板文件中的定义，设置样式；
	$(newRowNodeIn).attr("onclick", "doOnPromUnitSelected(this)");
	$(newRowNodeIn).addClass("item");
	//1.设置“切换代号类别”的事件处理函数；
	//newRowNodeIn.children[0].setAttribute("onchange", "doOnUnitTypeChanged(this)");
	//2.设置焦点[代号输入框]
	this.setRowMemberFocusedByNode(newRowNodeIn, 1, 0);
	
};
TempTabCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "item_on";
};
//清除目标代号行上的所有文本框内容（注意：除[模版页签类型]）
TempTabCanvas.prototype.resetRowContentByNode = function(/*Node*/anyRowMemberNodeIn){
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
TempTabCanvas.prototype.getIndexId = function(){
	return this.getRowCount() + 1;
};
TempTabCanvas.prototype.setAttributeCheckBox = function(/*Boolean*/ flag){
	$(this.getContainerNode()).next().get(0).children[0].checked = flag;
};
//验证是否有页签存在
TempTabCanvas.prototype.checkChildrenIsNotNull = function(/*Null*/){
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
TempTabCanvas.prototype.getNextCursor = function(/*Node*/currentNode){
	var nextElem = $(currentNode).next().get(0);
	if (nextElem) {
		nextElem.focus();
	}
};
//序号重新赋值
TempTabCanvas.prototype.toAssignValue = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var containerChildren = containerNode.children;
	for (var index = 0; index < containerChildren.length; index++) {
		var secondChildren = containerChildren[index].children[1];
		secondChildren.value = index + 1;
	}
};
//验证当前被选中的页签是否删除，如果不删除，不做任何操作。
TempTabCanvas.prototype.checkCurrentRowWhetherSelected = function(/*Null*/){
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
TempTabCanvas.prototype.errorElementFlag = function(/*Node*/tabNameElem){
	var tabName = tabNameElem.value;
	if ($.trim(tabName) == "") {
		$(tabNameElem).addClass("errorInput");
	}
};