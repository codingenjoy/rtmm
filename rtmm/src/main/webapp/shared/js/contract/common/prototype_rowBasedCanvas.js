/*1.base Canvas for Items and ItemStores html area.
 * define a Row-based Canvas, which contain all linear row-based Child DOM Elements and wrapped scripting functionality.
 * Only handle HTML-related tasks, donna persist any data.
 * */

function RowBasedCanvas(/*String,optional*/rowTagNameIn){
	this.isPickyRowCreation = false;
	this.rowSelectedTag = {};//保存最近一次被选中的ROW关键识别信息.
	this._rowTagNameOnCreate = rowTagNameIn?rowTagNameIn:"div";
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
	//var moreVariantArgs = this.getTruncatedArray(arguments, 1);
	var newRowTemplateHTMLStr = this.getRowTemplateHTMLStr();
	for (var dataIndex=0;dataIndex<pRowDataArrayIn.length;dataIndex++){
		var oneRowData = pRowDataArrayIn[dataIndex];
		/*
		 * 处理逻辑如下：
		 * 若子类有自己的createNewRowNode实现，则使用子类方法返回的Node；
		 * 否则，使用下面内容中的基类内建的“基于模板创建DOM节点”的做法
		 */
		var oneNewRowNode = null;
		//首先，检测当前类型是否有自己的创建新ROW的定义；
		if (this.isPickyRowCreation){
			oneNewRowNode = this.getPickyRowNodeOnCreation();
		}
		//若子类没有特别的定义，则使用FALLBACK机制;
		if (!oneNewRowNode){
			oneNewRowNode = document.createElement(this._rowTagNameOnCreate);
			containerNode.appendChild(oneNewRowNode);
			oneNewRowNode.innerHTML = newRowTemplateHTMLStr;
		}
		//回调 由子类实现的"执行自定义逻辑"函数;
		this.onAfterOneNewRowCreated(oneNewRowNode);
		this.renderRowFromData(oneNewRowNode, oneRowData);
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
		//currRowNode = currRowNode.previousSibling;
		currRowNode = $(currRowNode).prev().get(0);
		counter++;
	}
	return counter;
};
RowBasedCanvas.prototype.checkAndUpdateIfRowSelectionChanged = function(/*Object*/rowPK, /*Int*/rowIndex){
	if (this.rowSelectedTag.pk == rowPK){
		this.rowSelectedTag.position = rowIndex;
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

/*
 * 从当前画布区域删除[指定成员节点]所在的ROW元素
 */
RowBasedCanvas.prototype.removeOneRowByNode = function(/*Node*/rowNodeIn){
	var containerNode = this.getContainerNode();
	if (!containerNode) return;
	var rowNode = this.getRowNodeFromAnyElement(rowNodeIn);
	containerNode.removeChild(rowNode);
};
/*
 * 从当前画布区域删除指定位置的ROW元素
 */
RowBasedCanvas.prototype.removeOneRowByIndex = function(/*Int*/rowIndexIn){
	var containerNode = this.getContainerNode();
	var rowCount = this.getRowCount();
	if (rowIndexIn < 0 || rowIndexIn >= rowCount) return;
	var rowNode2del = containerNode.children[rowIndexIn];
	containerNode.removeChild(rowNode2del);
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
	while (tMemberNode.parentElement != containerNode)
		tMemberNode = tMemberNode.parentElement;
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
	if (editable){
		anyNodeIn.removeAttribute("readonly");
		$(anyNodeIn).removeClass("Black");
	} else {
		anyNodeIn.setAttribute("readonly", true);
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
};
//私有方法,捕获外部传入的事件
RowBasedCanvas.prototype._doAnyKeyTrap = function(/*Event*/evtObj){
	  var theEvent = evtObj || window.event;
	  var keyCode = theEvent.keyCode || theEvent.which;
	  //2.取得发生当前事件的DOM元素，并判断是否位于“门店列表区域”;
	  var evtElem = $(event.srcElement || event.target)[0];
	  var isRaisedInStoresArea = this.containsNode(evtElem);
	  if (!isRaisedInStoresArea) return;
	  //3.判断该DOM元素是对应“订购数量”，“赠品数量”，还是“买价”;
	  var memberIndex = this.getMemberIndexAtRow(evtElem);
	  var rowIndex = this.getRowIndex(evtElem);
	  
	  switch (keyCode){
		  case 13:
			  this.moveToNextSibling(rowIndex, memberIndex);
			  break;
		  case 37://move left
			  this.moveToPreviousSibling(rowIndex, memberIndex);
			  break;
		  case 38://move up
			  this.moveToPreviousRow(rowIndex, memberIndex);
			  break;
		  case 39://move right
			  this.moveToNextSibling(rowIndex, memberIndex);
			  break;
		  case 40://move down
			  this.moveToNextRow(rowIndex, memberIndex);
			  break;
	  }
		  
};
//移动上一行
RowBasedCanvas.prototype.moveToPreviousRow = function(/*int*/currRowIndexIn,/*int*/currMemberIndexIn){
	if (currRowIndexIn<=0) return;
	var currRowElem = this.getContainerNode().children[currRowIndexIn];
	$(currRowElem).removeClass("store_on");
  var prevRowElem = this.getContainerNode().children[currRowIndexIn-1];
  prevRowElem.children[currMemberIndexIn].focus();
  $(prevRowElem).addClass("store_on");
};
//移动到下一行
RowBasedCanvas.prototype.moveToNextRow = function(/*int*/currRowIndexIn,/*int*/currMemberIndexIn){
	if (currRowIndexIn>=this.getRowCount()-1) return;
	var currRowElem = this.getContainerNode().children[currRowIndexIn];
	$(currRowElem).removeClass("store_on");
	
	  var nextRowElem = this.getContainerNode().children[currRowIndexIn+1];
	  nextRowElem.children[currMemberIndexIn].focus();
	  $(nextRowElem).addClass("store_on");
};
//移动到上一个可编辑的兄弟节点；
RowBasedCanvas.prototype.moveToPreviousSibling = function(/*int*/currRowIndexIn,/*int*/currMemberIndexIn){
	var currRowElem = this.getContainerNode().children[currRowIndexIn];
	  if (currMemberIndexIn == 5 || currMemberIndexIn == 6)
		  currRowElem.children[currMemberIndexIn - 1].focus();
	  else if (currMemberIndexIn == 4)
		  this.moveToPreviousRow(currRowIndexIn, currMemberIndexIn);
};
//移动到下一个可编辑的兄弟节点；
RowBasedCanvas.prototype.moveToNextSibling = function(/*int*/currRowIndexIn,/*int*/currMemberIndexIn){
	var currRowElem = this.getContainerNode().children[currRowIndexIn];
  if (currMemberIndexIn == 4 || currMemberIndexIn == 5)
	  currRowElem.children[currMemberIndexIn + 1].focus();
  else if (currMemberIndexIn == 6)
	  this.moveToNextRow(currRowIndexIn, currMemberIndexIn);
};
/*
 * 给指定ROW上指定索引位置的元素设置新值.
 * 重要备注：支持“嵌套索引”。
 * 比如：客户端可以发起如下调用
 * 0.对指定ROW上的第2个子元素设置新值；
 * 	xxx::setRowMemberNodeValue(@anyRowMemberNode, @newValStr, 1);
 * 1.对指定ROW上的第2个子元素下的第1个元素设置新值；
 * xxx::setRowMemberNodeValue(@anyRowMemberNode, @newValStr, 1, 0);
 */
RowBasedCanvas.prototype.setRowMemberNodeValue = function(/*Node*/anyRowMemberNodeIn, /*String*/newNodeValIn,/*int*/rowMemberIndexIn/*,更多的可选参数int*/){
	var currRowElem = this.getRowNodeFromAnyElement(anyRowMemberNodeIn);
	var pseudoTargetElem = currRowElem.children[rowMemberIndexIn];
	var moreIndexs = this.getTruncatedArray(arguments, 3);
	if (moreIndexs){
		for (var argIdx=0;argIdx<moreIndexs.length;argIdx++){
			if (!pseudoTargetElem) break;
			var nestedIdx = moreIndexs[argIdx];
			pseudoTargetElem = pseudoTargetElem.children[nestedIdx];
		}
	}
	if (!pseudoTargetElem) return;
	pseudoTargetElem.value = newNodeValIn;
};
/*
 * 读取指定ROW上指定索引位置的元素值.
 * 重要备注：支持“嵌套索引”。
 * 比如：客户端可以发起如下调用
 * 0.读取指定ROW上的第2个子元素的值；
 * 	xxx::getRowMemberNodeValue(@anyRowMemberNode, @newValStr, 1);
 * 1.读取指定ROW上的第2个子元素下的第1个元素的值；
 * xxx::setRowMemberNodeValue(@anyRowMemberNode, @newValStr, 1, 0);
 */
RowBasedCanvas.prototype.getRowMemberNodeValue = function(/*Node*/anyRowMemberNodeIn,/*int*/rowMemberIndexIn/*,更多的可选参数int*/){
	var currRowElem = this.getRowNodeFromAnyElement(anyRowMemberNodeIn);
	var pseudoTargetElem = currRowElem.children[rowMemberIndexIn];
	var moreIndexs = this.getTruncatedArray(arguments, 3);
	if (moreIndexs){
		for (var argIdx=0;argIdx<moreIndexs.length;argIdx++){
			if (!pseudoTargetElem) break;
			var nestedIdx = moreIndexs[argIdx];
			pseudoTargetElem = pseudoTargetElem.children[nestedIdx];
		}
	}
	if (!pseudoTargetElem) return null;
	return pseudoTargetElem.value;
};
/*
 * 获取当前类型实例指定的新节点.
 */
RowBasedCanvas.prototype.getPickyRowNodeOnCreation = function(/*None*/){
	return null;
};
RowBasedCanvas.prototype.setRowMemberFocusedByIndex = function(/*int*/rowIndex){
	if (rowIndex<0 || rowIndex>=this.getRowCount()) return;
	var rowNode = this.getContainerNode().children[rowIndex];
	var moreArgsIndexes = this.getTruncatedArray(arguments, 1);
	
	var thMemberElem = this._getNestedRowMemberNodeByIndexArray(rowNode, moreArgsIndexes);
	if (!thMemberElem) return;
	
	thMemberElem.focus();
};
RowBasedCanvas.prototype.setRowMemberFocusedByNode = function(/*Node*/anyRowMemberNodeIn){
	var moreArgsIndexes = this.getTruncatedArray(arguments, 1);
	var rowNode = this.getRowNodeFromAnyElement(anyRowMemberNodeIn);
	var thMemberElem = this._getNestedRowMemberNodeByIndexArray(rowNode, moreArgsIndexes);
	if (!thMemberElem) return;

	thMemberElem.focus();
};
//取制定ROW元素上指定位置的子元素,支持嵌套
RowBasedCanvas.prototype._getNestedRowMemberNodeByIndex = function(/*Node*/rowNodeIn /*,more ints*/){
	var moreArgsIndexes = this.getTruncatedArray(arguments, 1);
	if (!moreArgsIndexes || moreArgsIndexes.length<=0) return;
	var pseudoTargetElem = rowNodeIn.children[moreArgsIndexes[0]];
	for (var argIdx=1;argIdx<moreArgsIndexes.length;argIdx++){
		if (!pseudoTargetElem) break;
		var nestedIdx = moreIndexs[argIdx];
		pseudoTargetElem = pseudoTargetElem.children[nestedIdx];
	}
	return pseudoTargetElem;
};
//取制定ROW元素上指定位置的子元素
RowBasedCanvas.prototype._getNestedRowMemberNodeByIndexArray = function(/*Node*/rowNodeIn, /*Array*/idxArrayIn){
	if (!idxArrayIn || idxArrayIn.length<=0) return;
	var pseudoTargetElem = rowNodeIn.children[idxArrayIn[0]];
	for (var argIdx=1;argIdx<idxArrayIn.length;argIdx++){
		if (!pseudoTargetElem) break;
		var nestedIdx = idxArrayIn[argIdx];
		pseudoTargetElem = pseudoTargetElem.children[nestedIdx];
	}
	return pseudoTargetElem;
};

//***************************************************************************************************************************************************
//以下是新增的界面模版

//取用户要删除的indexs
RowBasedCanvas.prototype.getRowsIndex = function(/*Node*/){
	var tabRowIndexs = [];
	var containerNodeChildren = this.getContainerNode().children;
	for(var i = 0; i < containerNodeChildren.length; i++){
		var checkElement = containerNodeChildren[i].children[0];
		if (checkElement.checked) {
			tabRowIndexs.push(i);
		}
	}
	return tabRowIndexs;
};

//删除用户指定的DOM行
RowBasedCanvas.prototype.removeMultiRows = function(/*Array*/tabRowIndexs){
	for(var delIdx=0;delIdx< tabRowIndexs.length; delIdx++){
		var realRowIdx2Del = tabRowIndexs[delIdx] - delIdx;
		this.removeOneRowByIndex(realRowIdx2Del);
	}
};
RowBasedCanvas.prototype.getIndexId = function(/*String*/tabIdIn, /*Array*/currTabTermsSnapshotData){};
RowBasedCanvas.prototype.checkAndUpdateIfAcctRowSelectionChanged = function(/*Object*/rowPK, /*Int*/rowIndex){
	this.rowSelectedTag.pk = rowPK;
	this.rowSelectedTag.position = rowIndex;
};