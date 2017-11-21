/*1.base Canvas for Items and ItemStores html area.
 * define a Row-based Canvas, which contain all linear row-based Child DOM Elements and wrapped scripting functionality.
 * Only handle HTML-related tasks, donna persist any data.
 * */

function RowBasedCanvas(){
	this.rowSelectedTag = {};//保存最近一次被选中的ROW关键识别信息.	
}
//清除画布上所有的元素
RowBasedCanvas.prototype.clear = function(){
	var containerNode = this.getContainerNode();
	if (!containerNode) return;
	this.rowSelectedTag = {};
	//gracefully detach & remove these child elements( mainly <div/>) from Container.
	while (containerNode.firstChild){
		containerNode.removeChild(containerNode.firstChild);
	}
	//An ugly implementation is : containerNode.innerHTML = ''; 
};
RowBasedCanvas.prototype.show = function(/*Array*/pRowDataArrayIn/*and more variants*/){
	var containerNode = this.getContainerNode();
	var moreVariantArgs = this.getTruncatedArray(arguments, 1);
	var newRowTemplateHTMLStr = this.getRowTemplateHTMLStr();
	for (var dataIndex=0;dataIndex<pRowDataArrayIn.length;dataIndex++){
		var oneRowData = pRowDataArrayIn[dataIndex];
		
		var oneNewRowNode = document.createElement("div");
		containerNode.appendChild(oneNewRowNode);
		oneNewRowNode.innerHTML = newRowTemplateHTMLStr;

		//回调 由子类实现的"执行自定义逻辑"函数;
		this.onAfterOneNewRowCreated(oneNewRowNode);
		this.renderRowFromData(oneNewRowNode, oneRowData, moreVariantArgs);
	}
};
//在创建一笔ROW后，子类可以实现此方法，以执行自定义的逻辑.
RowBasedCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	throw e;
};
RowBasedCanvas.prototype.getRowIndex = function(/*Node*/anyRowMemberNodeIn){
	var counter = -1;
	var currRowNode = this.getRowNodeFromAnyElement(anyRowMemberNodeIn);
	while (currRowNode != null){
		currRowNode = currRowNode.previousSibling;
		counter++;
	}
	return counter;
};
RowBasedCanvas.prototype.checkAndUpdateIfRowSelectionChanged = function(/*Object*/rowPK, /*Int*/rowIndex){
	if (this.rowSelectedTag.pk == rowPK){
		this.rowSelectedTag.position = rowIndex;
		return false;
	}
	//检查当前itemStoreCanvas是否存在错误，如果错误，则返回操作。
	var currItemStoresCanvas = pHOOrderHandler.itemStoresCanvas.getContainerNode();
	if (currItemStoresCanvas.innerHTML && $("#action").val()=="update" 
		&& $(currItemStoresCanvas).find(".errorInput").length>0){
		top.jWarningAlert("请修正标红项后再进行切换");
		return false;
	}
	//先将"最近一次被选中的ROW"设为取消状态;
	if (!isNaN(this.rowSelectedTag.position))
		this.tagUnSelectedByIndex(this.rowSelectedTag.position);
	this.rowSelectedTag.pk = rowPK;
	this.rowSelectedTag.position = rowIndex;
	//然后，将"传入的ROW"设为选中状态;
	this.tagSelectedByIndex(rowIndex);
	return true;
};
RowBasedCanvas.prototype.getRowSelectedClassStr = function(/*None*/){
	throw e;
};
RowBasedCanvas.prototype.tagSelectedByNode = function(/*Node*/rowNode){
	$(rowNode).addClass(this.getRowSelectedClassStr());
};
RowBasedCanvas.prototype.tagSelectedByIndex = function(/*Int*/rowIndex){
	var containerNode = this.getContainerNode();
	var rowNode = containerNode.children[rowIndex]; 
	$(rowNode).addClass(this.getRowSelectedClassStr());
	
};
RowBasedCanvas.prototype.tagUnSelectedByNode = function(/*Node*/rowNode){
	$(rowNode).removeClass(this.getRowSelectedClassStr());
};
RowBasedCanvas.prototype.tagUnSelectedByIndex = function(/*Int*/rowIndex){
	var containerNode = this.getContainerNode();
	var rowNode = containerNode.children[rowIndex]; 
	$(rowNode).removeClass(this.getRowSelectedClassStr());
	
};
RowBasedCanvas.prototype.removeOneRowByNode = function(/*Node*/rowNodeIn){
	var containerNode = this.getContainerNode();
	if (!containerNode) return;
	var rowNode = this.getRowNodeFromAnyElement(rowNodeIn);
	containerNode.removeChild(rowNode);
};

RowBasedCanvas.prototype.getContainerNode = function(){};
RowBasedCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	throw e;
};
RowBasedCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn){
	throw e;
};
RowBasedCanvas.prototype.getRowNodeFromAnyElement = function(/*Node*/anyElemIn){
	var containerNode = this.getContainerNode();
	var tMemberNode = anyElemIn;
	//fixup: tMemberNode或许是游离的节点
	if (!tMemberNode.parentElement) return null;
	while (tMemberNode && tMemberNode.parentElement != containerNode){
		tMemberNode = tMemberNode.parentElement;
	}
	return tMemberNode;
};
RowBasedCanvas.prototype.getRowCount = function(/*none*/){
	var containerNode = this.getContainerNode();
	return containerNode.children.length;
};
/*
 * 设置指定ROW(zero-based index)上指定位置元素为“可编辑”状态或者“只读”状态;
 * 父类缺省为NULL实现，具体的逻辑由子类完成.
 */
RowBasedCanvas.prototype.setRowMemberEditable = function(/*int*/rowIndex, /*int*/rowMemberIndex){
	if (rowIndex<0 || rowIndex>=this.getRowCount()) return;
	//带内部缺省<div>的ROW元素
	var rowNode = this.getContainerNode().children[rowIndex];
	//var thMemberElem = rowNode.children[0].children[rowMemberIndex];
	var thMemberElem = rowNode.children[rowMemberIndex];
	this.setElementEditable(thMemberElem, true);
	this.onAfterAnyMemberEnterEditable(thMemberElem);
};
RowBasedCanvas.prototype.setRowMemberReadonly = function(/*int*/rowIndex, /*int*/rowMemberIndex){
	if (rowIndex<0 || rowIndex>=this.getRowCount()) return;
	var rowNode = this.getContainerNode().children[rowIndex];
	//var thMemberElem = rowNode.children[0].children[rowMemberIndex];
	var thMemberElem = rowNode.children[rowMemberIndex];
	this.setElementEditable(thMemberElem, false);
	this.onAfterAnyMemberEnterReadonly(thMemberElem);
};
//当某ROW上某位置的元素进入可编辑态时，提供给子类的扩展逻辑回调函数。子类可以选择性实现或者忽略.
RowBasedCanvas.prototype.onAfterAnyMemberEnterEditable = function(/*Node*/anyNodeIn){
};
//当某ROW上某位置的元素进入READONLY态以后，提供给子类的扩展逻辑回调函数。子类可以选择性实现或者忽略.
RowBasedCanvas.prototype.onAfterAnyMemberEnterReadonly = function(/*Node*/anyNodeIn){
};
//当某ROW上某位置的元素进入可编辑态时，提供给子类的回调函数。必须由子类实现
RowBasedCanvas.prototype.setElementEditable = function(/*Node*/anyNodeIn,/*boolean*/editable){
	//if (!anyNodeIn) return;
	if (editable){
		anyNodeIn.removeAttribute("readonly");
		anyNodeIn.removeAttribute("readOnly");
		$(anyNodeIn).removeClass("Black");
	} else {
		anyNodeIn.setAttribute("readonly", "readonly");
		anyNodeIn.setAttribute("readOnly", "readonly");
		$(anyNodeIn).addClass("Black");
	}
};
//取得指定ROW中指定位置的一级子元素.
RowBasedCanvas.prototype.getRowMemberNodeByIndex = function(/*int*/rowIndexIn, /*int*/memberIndexIn){
	var containerNode = this.getContainerNode();
	if (rowIndexIn<0 || rowIndexIn>=containerNode.children.length) return null;
	var rowNode = containerNode.children[rowIndexIn];
	if (memberIndexIn<0 || memberIndexIn>=rowNode.children.length) return null;
	return rowNode.children[memberIndexIn];
};
RowBasedCanvas.prototype.getTruncatedArray = function(/*Variant*/varIn, /*int*/startIndexIn){
	var args = Array.prototype.slice.call(varIn);
	var moreVariantArgs = args.splice(startIndexIn, args.length - startIndexIn);
	return moreVariantArgs;
};
RowBasedCanvas.prototype.containsNode = function(/*Node*/anyRowMemberIn){
	var rowNode = this.getRowNodeFromAnyElement(anyRowMemberIn);
	var contains = rowNode!=null && rowNode.parentElement == this.getContainerNode();
	return contains;
};
//获取当前传入的元素在ROW中的索引位置.
RowBasedCanvas.prototype.getMemberIndexAtRow = function(/*Node*/anyRowMemberIn){
	var counter = 0;
	var tmpNode = anyRowMemberIn;
	while (tmpNode != null){
		tmpNode = tmpNode.previousSibling;
		if (tmpNode && tmpNode.nodeType == 1)
			counter++;
	}
	return counter;
};
RowBasedCanvas.prototype.clickRowByIndex = function(/*int*/rowIndexIn){
	var containerNode = this.getContainerNode();
	var maxRowIndex = containerNode.children.length - 1;
	var rowIndex = rowIndexIn<=maxRowIndex?rowIndexIn:maxRowIndex;
	//根据模板结构，模拟对目标ROW进行点击操作;
	if (rowIndex <0) return;
	containerNode.children[rowIndex].click();
	containerNode.children[rowIndex].scrollIntoView(containerNode.window);  
};
