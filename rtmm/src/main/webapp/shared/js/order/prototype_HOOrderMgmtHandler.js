/*4. HO overall Order Maintenance handler.*/
function HOOrderMgmtHandler(/*optional*/pOrderNoIn, /*optional, boolean*/readonly){
	this.CONST_EMPTY_ITEMNO = "n/a";
	this.orderNo = pOrderNoIn;
	this.viewonly = readonly;
	this.orderBasicInfo = {};//订单主档信息
	/*
	 * 存储所有的“one Item--〉Store List”的映射关系定义,为Key-Value结构。
	 * 其中Key的值为[itemNo], Value的值为Map类型，具有如下结构：
	 * 	{
	 * 	loaded: [true|false],
	 *  stores: [Array of ItemStoreVO];"根据某个itemNo拿到的门店列表"
	 * }
	 */
	this.itemStoresMapping = {};
	
	this.itemsList = [];
	
	this.itemsCanvas = new OrderItemsCanvas(this);
	this.itemStoresCanvas = new OrderItemStoresCanvas(this);	
	this.ifPlanRecptDateChange = false;//Changing the flag if the planRecptDate changes.
	//judge whether to have one store at least having ordQty or presQrdQty.
	this.ifHaveOrdOrPresIsNull;
}

HOOrderMgmtHandler.prototype.addNewItems = function(/*Array*/bulkItemsData, /*boolean*/selectLastNorFirst){
	var lastMaxRowIndex = this.itemsCanvas.getRowCount() - 1;
	var realNewItemAdded = false;
	//如果需要执行一些逻辑（比如逐行的检测），则需要对bulkItemsData做循环；否则直接调用批处理函数；
	for (var i=0;i<bulkItemsData.length;i++){
		var oneItemInfo = bulkItemsData[i];
		//1-1.检测当前传入的这笔商品是否已添加；
		if (this.isItemNoDuplicated(oneItemInfo.itemNo)){
			//alert("货号:\n" + oneItemInfo.itemNo + "-" +oneItemInfo.itemName+ "已加入");
			//top.jAlert('warning', "货号:\n" + oneItemInfo.itemNo + "-" +oneItemInfo.itemName+ "已加入",'提示消息');
			continue;
		}
		realNewItemAdded = true;
		//1-2.将传入的商品信息压入混合栈中；
		this.itemsList.push(oneItemInfo);
		//1-3.显示当前商品的关键参数；
		this.itemsCanvas.show([oneItemInfo]);
		this.itemsCanvas.setRowMemberReadonly(this.itemsCanvas.getRowCount() - 1, 0);
		//1-4.初始化当前传入商品的门店数据存储结构,以进行"是否重复输入货号"的检测;
		if (oneItemInfo.itemNo)
			this.itemStoresMapping[oneItemInfo.itemNo] = {};
	}
	//2.默认激活新增加的第一笔.
	var rowIndex2Select = realNewItemAdded?lastMaxRowIndex+1:lastMaxRowIndex;
	this.itemsCanvas.clickRowByIndex(rowIndex2Select);
	//3.get the buyer of first item.
	this.getFirstItemBuyer();
	
};
HOOrderMgmtHandler.prototype.replaceItemRowContent = function(/*Node*/anyRowMemberElemIn, /*Array*/itemArray){
	if (!itemArray || itemArray.length<=0) return;
	var rowNode = this.itemsCanvas.getRowNodeFromAnyElement(anyRowMemberElemIn);
	var rowIndex = this.itemsCanvas.getRowIndex(rowNode);
	var currItemRowData = itemArray[0];
	
	this.itemsList[rowIndex] = currItemRowData;
	this.itemsCanvas.renderRowFromData(rowNode, currItemRowData);	
	this.activateItemByAnyElement(rowNode, true);
	this.itemsCanvas.setRowMemberReadonly(rowIndex, 0);
};
HOOrderMgmtHandler.prototype.activateItemByAnyElement = function(/*Node*/anyElementIn, /*boolean,optional*/forced){
	var rowNode = this.itemsCanvas.getRowNodeFromAnyElement(anyElementIn);
	//fixup: 当anyElementIn处于“游离”状态时，rowNode可能为NULL；
	if (!rowNode) return;
	//1.设置“被选中”样式；
	this.itemsCanvas.tagSelectedByNode(rowNode);
	//2.取商品号;
	var itemNo = rowNode.children[0].value;//rowNode.children[0].children[0].value;

	var rowIndex = this.itemsCanvas.getRowIndex(rowNode);
	var realChanged = this.itemsCanvas.checkAndUpdateIfRowSelectionChanged(itemNo, rowIndex);
	if (!realChanged && !forced) return;
	//3.在切换“商品”时，清除“批量变更@订购数量”，“批量变更@赠品数量”2个栏位；并执行[若成本时点==2，则开放“变更买价”的编辑功能]逻辑
	this.cleanBatchElement();
	var batchChangeBuyPriceElem = document.getElementById("txtBatchChangeBuyPrice"); 
	//3-1.取@buyWhen;
	var buyWhen = this.itemsList[rowIndex].buyWhen;
	//3-2.根据“成本时点”，开放“批量变更买价”是否可被编辑；
	this.itemStoresCanvas.setElementEditable(batchChangeBuyPriceElem, buyWhen==2);
	//4.检查“货号”是否有输入.若还没有填写货号，则退出；
	if (!itemNo || itemNo==this.CONST_EMPTY_ITEMNO) {
		this.itemStoresCanvas.clear();
		return;
	}
	//5.执行“指定商品下的门店订购列表加载/显示”例程，并送进@buyWhen;
	this._activateItemByMixedItemInfo(itemNo, buyWhen);
	
};
HOOrderMgmtHandler.prototype.removeItemByNode = function(/*Node*/anyElementIn){
   /*delete this.itemsCanvas.rowSelectedTag;*/
	var rowNode = this.itemsCanvas.getRowNodeFromAnyElement(anyElementIn);
	//1.取商品号.注意:对于空白的可编辑行，itemNo为undefined或者'';
	var itemNo = rowNode.children[0].value;
	var rowIndex = this.itemsCanvas.getRowIndex(rowNode);
	//2.从界面中移除被选中ROW;
	this.itemsCanvas.removeOneRowByNode(rowNode);
	//3.清除相关数据
	delete this.itemStoresMapping[itemNo];
	this.itemsList.splice(rowIndex, 1);
	//清除门店列表区域的显示信息
	if(this.itemsCanvas.rowSelectedTag.pk==itemNo){
	this.itemStoresCanvas.clear();
	}
	//4.重新选择一个ROW
	this.itemsCanvas.clickRowByIndex(rowIndex);
	/*if the order item message is null,clear up
	  the rowSelectedTag.*/
	if(!this.getCurrentItemRowData()){
	    this.itemsCanvas.rowSelectedTag={};
	}
};

HOOrderMgmtHandler.prototype._activateItemByMixedItemInfo = function(/*Int*/itemNoIn, /*int*/buyWhenIn){
	//清除“门店列表”的界面；
	this.itemStoresCanvas.clear();
	//检查目标商品关联的门店数据是否已加载.若已加载，则直接显示在界面上；
	var thatItemStoresData = this.itemStoresMapping[itemNoIn];
	if (thatItemStoresData && thatItemStoresData.loaded){
		this.itemStoresCanvas.show(thatItemStoresData.data, buyWhenIn);
		return;
	}
	//否则，从服务器获取“目标商品关联的门店数据”，并设置“@loaded”标志为TRUE.
	
	var itemRowData = this.getCurrentItemRowData();
	if(!itemRowData)return;
	var queryCond = {};
	queryCond.itemNo = itemNoIn;
	queryCond.action = itemRowData.action||'create';
	queryCond.ordNo = $('#ordNo').val();
	queryCond.planRecptDate = $('#planRecptDate').val();
	queryCond.orderDate = $('#orderDate').val();
	queryCond.bpDisc = $('#bpDisc').val();
	queryCond.supNo = $('#supNo').val();
	queryCond.catlgId = $('#catlgId').val();
	queryCond.buyWhen = buyWhenIn;
	var selfRef = this;
	$.ajax({
			url : ctx + '/hoOrderCreateNew/getHoOrderItemStoreList?ti='
					+ (new Date()).getTime(),
			data : queryCond,
			type : 'POST',
			success : function(itemStoreVOList) {
				/*
				 * fixup: 对拿到的“商品门店信息列表”数据结构执行循环：拿到每笔“商品门店”的结构后，依次执行如下操作：
				 * <1>.添加名称为"@lastBuyPrice"的属性,* 以便于后期对“变价”的处理;
				 * <2>.添加名称为"@ordQty"的属性，对应由用户输入的“订购数量”；
				 * <3>.添加名称为"@presOrdQty"的属性，对应由用户输入的“赠品数量”；
				 */
				for (var stIndex=0;stIndex<itemStoreVOList.length;stIndex++){
					var thItemStoresData = itemStoreVOList[stIndex];
					thItemStoresData.lastBuyPrice = thItemStoresData.buyPrice;//最后一次的买价,初始值设为同buyPrice
					thItemStoresData.lastPromNo = thItemStoresData.promNo;//set the initial promotion NO.
				}
				//补齐“当前商品的门店列表”在整个数据结构中的完整性；
				var mandatoryItemStoresVO = selfRef.itemStoresMapping[itemNoIn] = {};
				mandatoryItemStoresVO.loaded = true;
				mandatoryItemStoresVO.data = itemStoreVOList;				
				selfRef.itemStoresCanvas.show(itemStoreVOList, buyWhenIn);
				//judge if the planRecptDate was updated.
			    if(pHOOrderHandler.ifPlanRecptDateChange&&itemRowData.action=='update'){
			    	  var itemNoList=[];
			          if(!itemRowData)return;
			          var curItemNo=itemRowData.itemNo;
			          itemNoList.push(curItemNo);
			          selfRef.reloadPromBuyPriceByPlanRecptDate(itemNoList);
				}
			}
		});
};

HOOrderMgmtHandler.prototype.delStoresFromActivatedItem = function(/*none*/){
	var isSelected=false;
	var toDelStoresTag = [];
	var attachedItemNo = this.itemsCanvas.getActivatedRowPK();
	var thItemStoresDataWrapper = this.itemStoresMapping[attachedItemNo];
	if (!thItemStoresDataWrapper) return;
	var thItemStoresData = thItemStoresDataWrapper.data;
	if (!thItemStoresData || thItemStoresData.length <=0) return;
	
	var storeContainerNode = this.itemStoresCanvas.getContainerNode();
	for (var rowIndex=0;rowIndex<storeContainerNode.children.length;rowIndex++){
		var oneStoreRowNode = storeContainerNode.children[rowIndex];
		var pseudoParentElem = oneStoreRowNode;
		var ckbElem = pseudoParentElem.children[0];
		if (!ckbElem.checked) continue;
		//confirm to have some stores were selected. 
		isSelected=true;
		var storeNo2del = pseudoParentElem.children[1].value; 
		toDelStoresTag.push(storeNo2del);
		//从当前商品的门店列表数据中，删除当前选中的这笔
		thItemStoresData.splice(rowIndex, 1);
		//从门店列表HTML区域中，删除当前选中的这笔;
		storeContainerNode.removeChild(oneStoreRowNode);
		rowIndex--;
	}
	return isSelected;
};

HOOrderMgmtHandler.prototype.getData = function(/*none*/){
	var dataSnapshot = {};
	dataSnapshot.items = this.itemsList;
	dataSnapshot.itemStores = this.itemStoresMapping;
	return dataSnapshot;
};
HOOrderMgmtHandler.prototype.clear = function(/*none*/){
	this.itemsList.splice(0, this.itemsList.length);
	for (var itemNoVal in this.itemStoresMapping){
		delete this.itemStoresMapping[itemNoVal];
	}
	this.itemsCanvas.clear();
	this.itemStoresCanvas.clear();
};

HOOrderMgmtHandler.prototype.addOneEmptyItem = function(/*none*/){
	//step1.检查是否有空白的ROW存在;
	if (this.hasEmptyItemExist()) return;
	//step2.伪造一笔itemNo为“N/A”的空数据，并执行 batch操作
	var newEmptyItemData = {};
	newEmptyItemData.itemNo = this.EMPTY_ITEMNO;
	this.addNewItems([newEmptyItemData], true);
	var newRowIndex = this.itemsCanvas.getRowCount()-1;
	//step3.设置当前行为可编辑状态；
	this.itemsCanvas.setRowMemberEditable(newRowIndex, 0);
};
HOOrderMgmtHandler.prototype.isItemNoDuplicated = function(/*int*/itemNoIn){
	/**option-1.基于内部维护的商品列表，检查传入的货号是否已定义；
		注意：这种线性的检查方式在“商品列表”数量小(数10个)时，效率可以接受.
	**/
	var duplFlag = false;
	for (var itemIndex=0;itemIndex < this.itemsList.length; itemIndex++){
		if (this.itemsList[itemIndex].itemNo==itemNoIn){
			duplFlag = true;
			break;
		}
	}
	return duplFlag;
	/*
	//option-2.根据“商品与门店”的映射关系，检查传入的货号是否已定义；
	//这种检查方式，在“商品列表”数量过100时，效率有显著提升；
	var itemStoresData = this.itemStoresMapping[itemNoIn];
	if (itemStoresData) return true;
	return false;
	*/
};
//更新“订购数量”
HOOrderMgmtHandler.prototype.doSyncOrdQtyByRow = function(/*String*/newOrdQtyVal, /*Node*/anyRowMemberIn){
	var currStoreQrdQtyCalcVal = this._getOrdQtyCalculated(anyRowMemberIn, newOrdQtyVal);
	var rowNode = this.itemStoresCanvas.getRowNodeFromAnyElement(anyRowMemberIn);
	var ordQtyElem = rowNode.children[4]; 
	ordQtyElem.value = currStoreQrdQtyCalcVal;
	this._doSyncNamedStoreProperty("ordQty", currStoreQrdQtyCalcVal, anyRowMemberIn);
};
//批量更新“订购数量”
HOOrderMgmtHandler.prototype.doBatchSyncOrdQty = function(/*String*/newBatchOrdQtyVal){
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var ordQtyElem = oneStoreRowNode.children[4]; 
		//注意：执行ROW级的判断逻辑，即根据每行元素的“@订购数量”和“@订购倍数”，获取整的订购数量。
		var currStoreQrdQtyCalcVal = this._getOrdQtyCalculated(ordQtyElem, newBatchOrdQtyVal);
		ordQtyElem.value = currStoreQrdQtyCalcVal;
		$(ordQtyElem).removeClass("errorInput");
		ordQtyElem.onchange();
		this._doSyncNamedStoreProperty("ordQty", currStoreQrdQtyCalcVal, ordQtyElem);	
	}
};
//更新赠品数量
HOOrderMgmtHandler.prototype.doSyncPresOrdQtyByRow = function(/*String*/newPresOrdQtyVal, /*Node*/anyRowMemberIn){
	var rowNode = this.itemStoresCanvas.getRowNodeFromAnyElement(anyRowMemberIn);
	var presOrdQtyElem = rowNode.children[5]; 
	presOrdQtyElem.value = newPresOrdQtyVal;

	this._doSyncNamedStoreProperty("presOrdQty", newPresOrdQtyVal, anyRowMemberIn);
};
//批量更新“赠品数量”
HOOrderMgmtHandler.prototype.doBatchSyncPresOrdQty = function(/*String*/newBatchPresOrdQtyVal){
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var presOrdQtyElem = oneStoreRowNode.children[5];//oneStoreRowNode.children[0].children[5]; 
		presOrdQtyElem.value = newBatchPresOrdQtyVal;
		presOrdQtyElem.onchange();
		this._doSyncNamedStoreProperty("presOrdQty", newBatchPresOrdQtyVal, presOrdQtyElem);
		
	}
};

//更新指定ROW上的"促销期数"
HOOrderMgmtHandler.prototype.doSyncPromNoByRow = function(/*String*/newPromVal, /*Node*/anyRowMemberIn){
	var storesNode = this.itemStoresCanvas.getContainerNode();
	var storeIndex = this.itemStoresCanvas.getRowIndex(anyRowMemberIn);
	var oneStoreRowNode = storesNode.children[storeIndex];
	var promNoElem = oneStoreRowNode.children[3];
	$(promNoElem).val(newPromVal);
	this._doSyncNamedStoreProperty("promNo", newPromVal, promNoElem);
};

//更新指定ROW上的"买价"
HOOrderMgmtHandler.prototype.doSyncBuyPriceByRow = function(/*Number*/inputBuyPriceVal, /*Number*/discBuyPriceVal, /*Node*/anyRowMemberIn){
	var rowIndex = this.itemStoresCanvas.getRowIndex(anyRowMemberIn);
	var buyPriceElem = this.itemStoresCanvas.getRowMemberNodeByIndex(rowIndex, 6);
	buyPriceElem.value = discBuyPriceVal;//设置界面上的“买价输入框”内容
	var nvPairs = {};
	nvPairs["buyPrice"] = discBuyPriceVal;
	nvPairs["inputBuyPrice"] = inputBuyPriceVal;
	this._doSyncNamedStoreProperties(nvPairs, anyRowMemberIn);
	//价格变化后促销期清空
	this.doSyncPromNoByRow(null, anyRowMemberIn);
};

//批量更新"买价"
HOOrderMgmtHandler.prototype.doBatchSyncBuyPrice = function(/*Number*/inputBuyPriceVal,/*Number*/discBatchBuyPriceVal){
	var nvPairs = {};
	nvPairs["buyPrice"] = discBatchBuyPriceVal;
	nvPairs["inputBuyPrice"] = inputBuyPriceVal;
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var buyPriceElem = oneStoreRowNode.children[6]; 
		//检查每门店的“买价限制”
		var buyPriceLimit = pHOOrderHandler.getBuyPriceLimitFromAnyItemStoreRow(buyPriceElem);
		//若“传入的批量更新值”大于每门店的“买价限制”，则跳过；
		if (discBatchBuyPriceVal > buyPriceLimit)
			continue;
		$(buyPriceElem).removeClass('errorInput');
		$(buyPriceElem).attr('title', '');
		buyPriceElem.value = discBatchBuyPriceVal;//设置界面上的“买价输入框”内容
		this._doSyncNamedStoreProperties(nvPairs, buyPriceElem);
		//价格变化后促销期清空
		this.doSyncPromNoByRow(null, buyPriceElem);
	}
};

//重置价格;
HOOrderMgmtHandler.prototype.doResetBuyPrice = function(){
	//1.取当前“门店列表”挂接到的商品PK(包含商品编号)
	var currItemNo = this.itemsCanvas.getActivatedRowPK();
	//2.根据商品编号，取门店列表的数据结构体；
	var thItemstoresData = this.itemStoresMapping[currItemNo];
	var storeInfoArray = thItemstoresData.data;
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var lastBuyPrice = storeInfoArray[storeIndex].lastBuyPrice;
		var buyPriceElem = oneStoreRowNode.children[6];
		//reset the buyPrice in the page.
		$(buyPriceElem).removeClass('errorInput');
		$(buyPriceElem).attr('title', '');
		buyPriceElem.value = lastBuyPrice;
		//reset the inputBuyPrice and the buyPrice.
		storeInfoArray[storeIndex].buyPrice=lastBuyPrice;
		delete storeInfoArray[storeIndex].inputBuyPrice;
	}
};

//reset the promNo.
HOOrderMgmtHandler.prototype.doResetPromNo= function(){
	//1.取当前“门店列表”挂接到的商品PK（包含商品编号）
	var currItemNo = this.itemsCanvas.getActivatedRowPK();
	//2.根据商品编号，取门店列表的数据结构体；
	var thItemstoresData = this.itemStoresMapping[currItemNo];
	var storeInfoArray = thItemstoresData.data;
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var lastPromNo = storeInfoArray[storeIndex].lastPromNo;
		var buyPriceElem = oneStoreRowNode.children[3];
		//reset the promNo in the page and the promNo in the array.
		buyPriceElem.value = lastPromNo==null?"":lastPromNo;		
		storeInfoArray[storeIndex].promNo=lastPromNo;
	}
};

HOOrderMgmtHandler.prototype._doSyncNamedStoreProperty = function(/*String*/propName, /*String*/newPropVal, /*Node*/anyRowMemberIn){
	//1.取当前“门店列表”挂接到的商品PK（包含商品编号）；
	var currItemNo = this.itemsCanvas.getActivatedRowPK();
	//2.根据商品编号，取门店列表的数据结构体；
	var thItemstoresData = this.itemStoresMapping[currItemNo];
	var storeInfoArray = thItemstoresData.data;
	var storeIndex = this.itemStoresCanvas.getRowIndex(anyRowMemberIn);
	//3.更新数据结构体中相应位置(@storeIndex)相应元素的值;
	var thItemStoreData = storeInfoArray[storeIndex];
	thItemStoreData[propName] = newPropVal;
};
//同时，对Store级别的多个成员属性设置新值；
HOOrderMgmtHandler.prototype._doSyncNamedStoreProperties = function(/*Array*/propNameValues,/*Node*/anyRowMemberIn){
	if (!propNameValues || propNameValues.length <=0) return;
	//1.取当前“门店列表”挂接到的商品PK（包含商品编号）；
	var currItemNo = this.itemsCanvas.getActivatedRowPK();
	//2.根据商品编号，取门店列表的数据结构体；
	var thItemstoresData = this.itemStoresMapping[currItemNo];
	var storeInfoArray = thItemstoresData.data;
	var storeIndex = this.itemStoresCanvas.getRowIndex(anyRowMemberIn);
	//3.更新数据结构体中相应位置(@storeIndex)相应元素的值;
	var thItemStoreData = storeInfoArray[storeIndex];
	for (var propName in propNameValues){
		var propVal = propNameValues[propName];
		thItemStoreData[propName] = propVal;
	}
};
//检查是否存在空白的商品货号;
HOOrderMgmtHandler.prototype.hasEmptyItemExist = function(/*none*/){
	var naItemNo = undefined;
	if (this.isItemNoDuplicated(naItemNo)) return true;
	var blankItemNoStr = '';
	if (this.isItemNoDuplicated(blankItemNoStr)) return true;
	return false;
};
HOOrderMgmtHandler.prototype._getOrdQtyCalculated = function(/*Node*/anyRowMemberElemIn, /*Number*/origOrdQtyValIn){
	if (isNaN(origOrdQtyValIn)) return origOrdQtyValIn;

	var thStoreRowNode = this.itemStoresCanvas.getRowNodeFromAnyElement(anyRowMemberElemIn);
	//1.取到当前的订购倍数.
	var thStoreOrdMultiParmVal = thStoreRowNode.children[7].value;
	if (isNaN(thStoreOrdMultiParmVal)) return origOrdQtyValIn;
	//2.计算“订购倍数”与“订购数量”的乘积，并执行“有余数则加1”的原则;
	var mVal = Math.ceil(origOrdQtyValIn/thStoreOrdMultiParmVal)*thStoreOrdMultiParmVal;
	var mValRound = Math.round(mVal);
	return mValRound>=mVal?mValRound:mValRound+1;
};
//捕获外部传入的事件
HOOrderMgmtHandler.prototype.doAnyKeyTrap = function(/*Event*/evtObj){
	  var theEvent = evtObj || window.event;
	  var keyCode = theEvent.keyCode || theEvent.which;
	  //2.取得发生当前事件的DOM元素，并判断是否位于“门店列表区域”;
	  var evtElem = $(event.srcElement || event.target)[0];
	  var isRaisedInStoresArea = this.itemStoresCanvas.containsNode(evtElem);
	  if (!isRaisedInStoresArea) return;
	  //3.判断该DOM元素是对应“订购数量”，“赠品数量”，还是“买价”;
	  var memberIndex = this.itemStoresCanvas.getMemberIndexAtRow(evtElem);
	  var rowIndex = this.itemStoresCanvas.getRowIndex(evtElem);
	  
	  switch (keyCode){
		  case 13:
			  this.itemStoresCanvas.moveToNextSibling(rowIndex, memberIndex);
			  break;
		  case 37://move left
			  this.itemStoresCanvas.moveToPreviousSibling(rowIndex, memberIndex);
			  break;
		  case 38://move up
			  this.itemStoresCanvas.moveToPreviousRow(rowIndex, memberIndex);
			  break;
		  case 39://move right
			  this.itemStoresCanvas.moveToNextSibling(rowIndex, memberIndex);
			  break;
		  case 40://move down
			  this.itemStoresCanvas.moveToNextRow(rowIndex, memberIndex);
			  break;
	  }
		  
};
//取指定门店所在的买价限制
HOOrderMgmtHandler.prototype.getBuyPriceLimitFromAnyItemStoreRow = function(/*Node*/anyItemStoreRowMemberNode){
	var thItemStoresData = this._getCurrentItemStoresData();
	var storeRowIndex = this.itemStoresCanvas.getRowIndex(anyItemStoreRowMemberNode); 
	var buyPriceLimit = thItemStoresData[storeRowIndex].buyPriceLimit;
	return buyPriceLimit;
};
//取当前商品下已关联的门店号;
HOOrderMgmtHandler.prototype.getStoreNOsOfCurrentItem = function(/*None*/){
	var thItemStoresData = this._getCurrentItemStoresData();
	var storeNOs = [];
	for (var storeIndex=0;storeIndex<thItemStoresData.length;storeIndex++){
		storeNOs.push(thItemStoresData[storeIndex].storeNo);
	}
	return storeNOs;
};
//取当前被选中商品的[门店]数据结构体。注意：请小心操作
HOOrderMgmtHandler.prototype._getCurrentItemStoresData = function(/*None*/){
	var itemNo = this.itemsCanvas.getActivatedRowPK();
	var thItemStoresData = this.itemStoresMapping[itemNo].data;
	return thItemStoresData;
};
//取当前被选中商品的数据结构体。注意：请小心操作
HOOrderMgmtHandler.prototype.getCurrentItemRowData = function(/*None*/){
	var selctedItemNo = this.itemsCanvas.getActivatedRowPK();
	var selectedItemData = null;
	for (var rowIndex=0;rowIndex<this.itemsList.length;rowIndex++){
		selectedItemData = this.itemsList[rowIndex];
		if (selectedItemData.itemNo == selctedItemNo){
			break;
		}
		selectedItemData = null;//Important:重置
	}
	return selectedItemData;
};
//取当前被选中商品的索引
HOOrderMgmtHandler.prototype.getCurrentItemIndex = function(/*None*/){
	var selctedItemNo = this.itemsCanvas.getActivatedRowPK();
	var selectedItemIndex = -1;
	for (var rowIndex=0;rowIndex<this.itemsList.length;rowIndex++){
		selectedItemData = this.itemsList[rowIndex];
		selectedItemIndex = rowIndex;
		if (selectedItemData.itemNo == selctedItemNo){
			break;
		}
		selectedItemIndex = -1;//Important:重置
	}
	return selectedItemIndex;
};
//检查对当前的场景是否可以增加更多的门店
HOOrderMgmtHandler.prototype.checkCanAddMoreStores = function(/*None*/){
	var currItemNo = this.itemsCanvas.getActivatedRowPK();
	return currItemNo?true:false;
};
//为当前选中的商品增加更多的门店
HOOrderMgmtHandler.prototype.addNewStores = function(/*Array*/bulkStoresData){
	var currItemNo = this.itemsCanvas.getActivatedRowPK();
	var lastMaxRowIndex = this.itemStoresCanvas.getRowCount() - 1;
	var currItemBuyWhenVal = this.getCurrentItemRowData().buyWhen;
	var realNewStoreAdded = false;
	//如果需要执行一些逻辑（比如逐行的检测），则需要对bulkStoresData做循环；否则直接调用批处理函数；
	for (var i=0;i<bulkStoresData.length;i++){
		var newStoreInfo = bulkStoresData[i];
		var isStoreDuplicated =false;
		var currItemStoresSnapshotData = this.itemStoresMapping[currItemNo].data;
		//1-1.检测当前传入的这笔[分店]是否已添加；
		for (var storeIndex = 0;storeIndex<currItemStoresSnapshotData.length;storeIndex++){
			var existedStoreInfo = currItemStoresSnapshotData[storeIndex];
			if (existedStoreInfo.storeNo == newStoreInfo.storeNo){
				isStoreDuplicated = true;
				break;
			}
		}
		if (isStoreDuplicated) continue;
		realNewStoreAdded = true;
		//1-2.将传入的分店信息压入到线性结构中；
		currItemStoresSnapshotData.push(newStoreInfo);
		//1-3.在分店区域显示当前分店的数据；
		this.itemStoresCanvas.show([newStoreInfo], currItemBuyWhenVal);
	}
	//recount the ordQtyAmnt value and the presOrdQtyAmnt value.
	this.cataQtyAmnt();
	this.cataPresQtyAmnt();
	//2.默认激活新增加的第一笔.
	var rowIndex2Select = realNewStoreAdded?lastMaxRowIndex+1:lastMaxRowIndex;
	this.itemStoresCanvas.clickRowByIndex(rowIndex2Select);
};

//清空批量修改的文本框的值
HOOrderMgmtHandler.prototype.cleanBatchElement = function(){
	document.getElementById("txtBatchChangeOrdQty").value = '';
	document.getElementById("txtBatchChangePresOrdQty").value = '';
	document.getElementById("txtBatchChangeBuyPrice").value='';
};
//重新计算总订购数量
HOOrderMgmtHandler.prototype.cataQtyAmnt = function(){
	var currItemNo = this.itemsCanvas.getActivatedRowPK();
	var qtyAmnt = 0;
	if(this.itemStoresMapping[currItemNo] && this.itemStoresMapping[currItemNo].data){
		var currItemStoresSnapshotData = this.itemStoresMapping[currItemNo].data;
		for (var storeIndex = 0;storeIndex<currItemStoresSnapshotData.length;storeIndex++){
			var storeInfo = currItemStoresSnapshotData[storeIndex];
			if(!storeInfo.ordQty){
				continue;
			}
			qtyAmnt = qtyAmnt + parseInt(storeInfo.ordQty);
		}
		var currentItemIndex = this.getCurrentItemIndex();
		var currentItem = this.itemsList[currentItemIndex];
		currentItem.qtyAmnt = qtyAmnt;
		var qtyAmntElem = this.itemsCanvas.getRowMemberNodeByIndex(currentItemIndex, 5);
		$(qtyAmntElem).val(qtyAmnt);
	}
};
//重新计算赠品数量
HOOrderMgmtHandler.prototype.cataPresQtyAmnt = function(){
	var currItemNo = this.itemsCanvas.getActivatedRowPK();
	var presQtyAmnt = 0;
	if(this.itemStoresMapping[currItemNo] && this.itemStoresMapping[currItemNo].data){
		var currItemStoresSnapshotData = this.itemStoresMapping[currItemNo].data;
		for (var storeIndex = 0;storeIndex<currItemStoresSnapshotData.length;storeIndex++){
			var storeInfo = currItemStoresSnapshotData[storeIndex];
			if(!storeInfo.presOrdQty){
				continue;
			}
			presQtyAmnt = presQtyAmnt + parseFloat(storeInfo.presOrdQty);
			presQtyAmnt=parseFloat(presQtyAmnt.toFixed(3));
		}
		var currentItemIndex = this.getCurrentItemIndex();
		var currentItem = this.itemsList[currentItemIndex];
		currentItem.presQtyAmnt = presQtyAmnt;
		var presQtyAmntElem = this.itemsCanvas.getRowMemberNodeByIndex(currentItemIndex, 6);
		$(presQtyAmntElem).val(presQtyAmnt);
	}
};

//reload the store data according by the seleced item index
HOOrderMgmtHandler.prototype.reloadOrderItemStoreData = function(){
	var orderItemObjArr = this.itemsList || [];
	if(orderItemObjArr.length>0){
		//clear the all item stores mapping data.
		for(var i=0;i<orderItemObjArr.length;i++){
	    	     if(this.itemStoresMapping[orderItemObjArr[i].itemNo].loaded){
	    		   delete this.itemStoresMapping[orderItemObjArr[i].itemNo];
	    	   }
	    		orderItemObjArr[i].qtyAmnt=0;
	    		var qtyAmntElem = this.itemsCanvas.getRowMemberNodeByIndex(i, 5);
	    	    $(qtyAmntElem).val(0);
	    		orderItemObjArr[i].presOrdQtyAmnt=0;
	    		var presQtyAmntElem =this.itemsCanvas.getRowMemberNodeByIndex(i, 6);
	    		$(presQtyAmntElem).val(0);
		}
		//clear the elements of the stores in the canvas.
        this.itemStoresCanvas.clear();
        //force reload the stores of the current item.(it is deprecated)
     	var containerNode = this.itemsCanvas.getContainerNode();
     	var currentIndex=this.getCurrentItemIndex();
	    var rowNode = containerNode.children[currentIndex];
	    this.getCurrentItemRowData().action="reload";
     	this.activateItemByAnyElement(rowNode, true);
	}
	else{
		return false;
	}
};

//get the buyer of the first item in the order.
HOOrderMgmtHandler.prototype.getFirstItemBuyer = function(){
	if(this.itemsList && this.itemsList[0].itemNo>0 && $('#buyer').val()==''){
		var itemNo = this.itemsList[0].itemNo;
		$.post(ctx+'/hoOrderCreateNew/getHoOrderBuyer',{itemNo:itemNo},function(data){
			if(data){
				$('#buyer').val(data.buyer);
				$('#buyerName').val(data.buyerName);
				return false;
			}
			$('#buyer').val('');
			$('#buyerName').val('sysAdmin');
		},'json');
	}
};

//get the buyer of the first item in the order.
HOOrderMgmtHandler.prototype.removeFirstItemBuyer = function(){
		$('#buyer').val('');
		$('#buyerName').val('');
};

//reload the buyPrice when the planRecptDate changes.
HOOrderMgmtHandler.prototype.reloadPromBuyPriceByPlanRecptDate=function(/*Array*/itemNoList){
	var queryCond = {};
	queryCond.ordDate = $('#orderDate').val();
	queryCond.planRecptDate = $('#planRecptDate').val();
	queryCond.itemNoList = itemNoList;	
	var selfRef = this;
	var bpDisc=$('#bpDisc').val();
	$.ajax({
		type : 'post',
		url : ctx + '/hoOrderCreateNew/getHoOrderStorePromBuyPrice',
		data :{
			'jsonStr' : JSON.stringify(queryCond)
		},
		success : function(itemStoreVOList) {
			/*delete the promNo and buyPrice in the data structure and 
			  clean up the promNo and buyPrice in the page. */
	         for(var itemIndex=0;itemIndex<itemNoList.length;itemIndex++){
				var currItemNo=itemNoList[itemIndex];
				var currItemStoreVOList=selfRef.itemStoresMapping[currItemNo].data;
				for(var stIndex=0;stIndex<currItemStoreVOList.length;stIndex++){
					delete currItemStoreVOList[stIndex].promNo;
					delete currItemStoreVOList[stIndex].lastPromNo;
					selfRef.itemStoresCanvas.getRowMemberNodeByIndex(stIndex, 3);
					var promNoElem=selfRef.itemStoresCanvas.getRowMemberNodeByIndex(stIndex, 3);
					if(promNoElem){
					   promNoElem.value="";
					}
					delete currItemStoreVOList[stIndex].buyPrice;
					delete currItemStoreVOList[stIndex].lastBuyPrice;
					delete currItemStoreVOList[stIndex].inputBuyPrice;
					var buyPriceElem=selfRef.itemStoresCanvas.getRowMemberNodeByIndex(stIndex, 6);
					if(buyPriceElem){
						buyPriceElem.value="";
					}
				}
	          }
			 if(itemStoreVOList.length==0){
				 return;
			 }
			/*reload the promNo and buyPrice in the data structure and 
			  reload the promNo and buyPrice in the page. */
			for (var itemIndex = 0;itemIndex<itemNoList.length;itemIndex++){
				var oldItemNo = itemNoList[itemIndex];
				var oldItemStoreVOList = selfRef.itemStoresMapping[oldItemNo].data;	
	            for(var ostIndex = 0;ostIndex<oldItemStoreVOList.length;ostIndex++){
	            	oldStoreNo=oldItemStoreVOList[ostIndex].storeNo;	            	
	            	for(var newstIndex = 0;newstIndex<itemStoreVOList.length;newstIndex++){
	            		var newItemNo = itemStoreVOList[newstIndex].itemNo;
	            		var newStoreNo = itemStoreVOList[newstIndex].storeNo;
	            		var newPromNo = itemStoreVOList[newstIndex].promNo;
	            		var newBuyPrice = itemStoreVOList[newstIndex].buyPrice;
	            		if(oldItemNo!=newItemNo||oldStoreNo!=newStoreNo)continue;
	    				//update the promNo and the lastPromNo if the newPromNo is not same as the oldPromNo.
	    				oldItemStoreVOList[ostIndex].promNo=newPromNo;
	    				oldItemStoreVOList[ostIndex].lastPromNo=newPromNo;
	    				var promNoElem = selfRef.itemStoresCanvas.getRowMemberNodeByIndex(ostIndex, 3);
	    				if(promNoElem){
	    				   promNoElem.value=newPromNo==null?"":newPromNo;
	    				}
	    				//if the order has buyPrice discount,the buyPrice needs to multiply bpDisc.
	    				if(bpDisc){
	    					newBuyPrice=Math.floor((1 - bpDisc / 100) * newBuyPrice * 10000) / 10000;
	    				}
	    				//update the buyPrice and the lastBuyPrice if the newPromNo is not same as the oldPromNo.
	    				oldItemStoreVOList[ostIndex].buyPrice=newBuyPrice;
	    				oldItemStoreVOList[ostIndex].lastBuyPrice=newBuyPrice;
	    				//delete the inputBuyPrice if the buyPrice changes.
	    				delete oldItemStoreVOList.inputBuyPrice;
	    				var buyPriceElem = selfRef.itemStoresCanvas.getRowMemberNodeByIndex(ostIndex, 6);
	    				if(buyPriceElem){
	    				   buyPriceElem.value=newBuyPrice==null?"":newBuyPrice;
	    				}
	    				//clean up the value of the batchChangeBuyPrice textbox.
	    				document.getElementById("txtBatchChangeBuyPrice").value='';  
	            	}            	
	            }
			}
		}
	});
};

//remove the stores of the item that don't have presOrdQty and ordQty in the order.
HOOrderMgmtHandler.prototype.removeStoresIfNotPresAndOrdQty = function(){
	var itemsList = pHOOrderHandler.itemsList;
	for (var i=0;i<itemsList.length;i++){
		//2-1.检查当前商品下的门店数据是否已被加载;
		var itemNo = itemsList[i].itemNo;
		var currItemStoresMapping = pHOOrderHandler.itemStoresMapping[itemNo];
		var isMapBuilt = currItemStoresMapping && currItemStoresMapping.loaded;
		var itemStoresList = null;
		if (isMapBuilt){
			itemStoresList = currItemStoresMapping.data;
		}
		if(!itemStoresList)continue;
		for (var j=0;j<itemStoresList.length;j++){
			var ordQty = itemStoresList[j].ordQty;
			var presOrdQty = itemStoresList[j].presOrdQty;
			if(!(ordQty||presOrdQty)){
				itemStoresList.splice(j,1);
				j--;
		    }
		}
	}
};