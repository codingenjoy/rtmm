/*
 *  本文定义了"所有 类似于[总部进价促销]以及[ART促销]的客户端主控类, 为抽象基类.
 *  [总部进价促销]以及[ART促销]必须扩展当前的主控类.
 *  */
function PlanHandler(/*optional*/pOrderNoIn, /*optional, boolean*/readonly){
	this.CONST_EMPTY_AnyNO = "";
	//0.存储所有的货号列表
	this._itemList = [];
	this._item2StoreMapping = {};
	/* 商品1列表显示区域*/
	this._itemsFristCanvas = new PlanItemFirstCanvas();
	/* 商品2列表显示区域*/
	this._itemSecondCanvas = new PlanItemSecondCanvas();
	/* 门店列表显示区域， 主体*/
	this._PlanItemStoreCanvas = new PlanItemStoreCanvas();
	//删除货号的存放
	this._delItermNo = [];
}
//取得[页签区域]的画布元素
PlanHandler.prototype.getTabsCanvas = function(/*None*/){
	return this._itemsFristCanvas;
};
//取得[某模版页签下的条款区域]的画布元素
PlanHandler.prototype.getTermsCanvas = function(/*None*/){
	return this._itemSecondCanvas;
};
//取得[某条款下的科目区域]的画布元素
PlanHandler.prototype.getAcctsCanvas = function(/*None*/){
	return this._PlanItemStoreCanvas;
};
//**增加一笔空白/待编辑的商品
PlanHandler.prototype.addOneEmptyIterm = function(/*none*/){
 	//TODO 校验
	//step2.伪造一笔itemNo为“N/A”的空数据，并执行 batch操作
	var newEmptyItemData = {};
	newEmptyItemData.itemNo = this.CONST_EMPTY_AnyNO;
	//调用“批量增加 页签Tab”的接口，将该笔 [空白页签]加入到内部结构中；
	this.addNewItems([newEmptyItemData]);
};
//**增加一批[货号]
PlanHandler.prototype.addNewItems = function(/*Array*/bulkItemData){
	var lastMaxRowIndex = this._itemsFristCanvas.getRowCount() - 1;
	var realNewTabAdded = false;
	//对传入的[货号id]列表进行循环,逐笔加入;
	for (var i=0;i<bulkItemData.length;i++){
		var oneTabInfo = bulkItemData[i];
		var bizPK = oneTabInfo.itemNo;
		realNewTabAdded = true;
		//1-2.将该笔[货号]数据压入混合栈中；
		this._itemList.push(oneTabInfo);
		//1-3.显示该笔[货号]的关键参数；
		this._itemsFristCanvas.show([oneTabInfo]);
		this._itemSecondCanvas.show([oneTabInfo]);
		//1-4.初始化当前传入[货号]的商品数据存储结构;
		if (bizPK && bizPK !=  this.CONST_EMPTY_AnyNO){
			this._item2StoreMapping[bizPK] = {};
			this._item2StoreMapping[bizPK].data = [];
			this._item2StoreMapping[bizPK].loaded = false;
		}
	}
	//2.默认激活新增加的第一笔.
	var rowIndex2Select = realNewTabAdded?lastMaxRowIndex+1:lastMaxRowIndex;
	this._itemsFristCanvas.clickRowByIndex(rowIndex2Select);
	//新增和删除置亮
	//this._itemSecondCanvas.setButtonRearLight();
};
/*
 * 激活目标[货号]元素
 * 处理逻辑：
 * 0.根据传入的[货号]成员节点，获取目标[货号]元素；
 * 1.比较目标[货号]元素与[最近一次被激活的货号]元素是否相同；
 * 	--〉
 */
PlanHandler.prototype.activateItemByAnyElement = function(/*Node*/anyElementIn, /*Integer*/storeNo){
	var tabRowIndex = this._itemsFristCanvas.getRowIndex(anyElementIn);
	//0.从[页签列表]中按照索引值取待激活的模版页签
	var itemNo = this._itemList[tabRowIndex].itemNo;
	//1.检查[被激活的模版页签]是否有变化
	var realChanged = this._itemsFristCanvas.checkAndUpdateIfRowSelectionChanged(itemNo, tabRowIndex);
	if (!realChanged) return;
	//2.清空门店区域；
	this._PlanItemStoreCanvas.clear();
	//清空批量修改建议量
	this._PlanItemStoreCanvas.clearBatchInitQty();
	//3.为新的[被激活的模块页签]加载[条款列表]并显示；
	var stores = this._item2StoreMapping[itemNo];
	if (!stores || !stores.loaded) {
		//发送请求获取商品下的门店
		this.serarchItems(/*Integer*/itemNo, /*Integer*/storeNo);
		return ;
	}
	this._PlanItemStoreCanvas.show(stores.data);
	//this._itemsFristCanvas.clickRowByIndex(0);
	this._PlanItemStoreCanvas.setButtonRearLight();
};
//**删除当前传入的节点元素所在的[货号]数据行和下挂元素；不清除当前行.
PlanHandler.prototype.removeOneItemByNode = function(/*Node*/theCurrentNode){
	//判断页签是否为空
/*	var tabSum = this._itemsFristCanvas.checkChildrenIsNotNull();
	if (tabSum) {
		return ;
	}*/
	//取模版商品要删除的index
	var itemRowIndex = this._itemSecondCanvas.getRowIndex(theCurrentNode);
	//根据itemRowIndex删除商品1上的DOM行
	this._itemsFristCanvas.removeOneRowByIndex(itemRowIndex);
	this._itemSecondCanvas.removeOneRowByIndex(itemRowIndex);
	//获取商品对象
	var itemRowData = this._itemList[itemRowIndex];
	//获取商品货号
	var itemNo = itemRowData.itemNo;
	//如果商品为空，只删除_itemList[]
	if (!itemNo) {
		this._itemList.splice(itemRowIndex, 1);
		//判断是否是当前行
		if (this.getCurrentItem() !== itemNo) return ;
		//执行最后一行事件
		var itemLastRowIndex =  this._itemsFristCanvas.getRowCount()-1;
		var rowIndex2Select = itemLastRowIndex < 0?itemLastRowIndex+1:itemLastRowIndex;
		this._itemsFristCanvas.clickRowByIndex(rowIndex2Select);
		return ;
	}
	//清除“商品与门店”的映射关系
	delete this._item2StoreMapping[itemNo];
	//清除该笔“商品”数据
	this._itemList.splice(itemRowIndex, 1);
	//删除的货号存放
	this._delItermNo.push(itemNo);
	//判断是否是当前行
	if (this.getCurrentItem() !== itemNo) return ;
	//清除门店列表区域的显示信息
	this._PlanItemStoreCanvas.clear();
	//执行最后一行事件
	var itemLastRowIndex =  this._itemsFristCanvas.getRowCount()-1;
	var rowIndex2Select = itemLastRowIndex < 0?itemLastRowIndex+1:itemLastRowIndex;
	this._itemsFristCanvas.clickRowByIndex(rowIndex2Select);
	//判断是否还有商品
	if (this._itemList.length == 0) {
		this._PlanItemStoreCanvas.setButtonPutTheAsh();
	}
};
/*
 * **删除指定的商品门店
 */
PlanHandler.prototype.removeOneItemStoreAcctByNode = function(/*Node*/){
	//判断是否可点击
	var whetherClick = this._PlanItemStoreCanvas.checkedDeleButton();
	if (whetherClick) {
		return ;
	}
	//判断门店是否为空
	var acctSum = this._PlanItemStoreCanvas.checkChildrenIsNotNull();
	if (acctSum) {
		return ;
	}
	//获取科目原有的科目
	//var acctOldArray = this._PlanItemStoreCanvas.getGrpAcctNos(/*Boolean*/true);
	//删除原有的数据
	/*for(var i = 0; i < acctOldArray.length; i++){
		delete this._AcctsMapping[acctOldArray[i]];
	}*/
	//0.取商品itemNo
	var currItemNo = this.getCurrentItem();
	//1.取门店的下标位置storeRowIdnex[]
	var storeRowIdnex = this._PlanItemStoreCanvas.getRowsIndex();
	//2.取商品下的门店data
	var storeData = this._item2StoreMapping[currItemNo].data;
	//3.按照最大的index一次往前删除，则不会出现找不到指定的下标
	var len = storeRowIdnex.length-1;
	for (var i = len; i > -1; i--){
		//3.1删除“门店”数据
		storeData.splice(storeRowIdnex[i], 1);
	}
	//设置多选框为false;
	this._PlanItemStoreCanvas.setAttributeCheckBox(false);
	//4.删除界面元素
	this._PlanItemStoreCanvas.removeMultiRows(storeRowIdnex);
	//序号重新赋值
	//this._PlanItemStoreCanvas.toAssignValue();
};
//**取当前被选中的[货号]
PlanHandler.prototype.getCurrentItem = function(/*None*/){
	return this._itemsFristCanvas.getActivatedRowPK();
};
//**取当前被选中的[货号]下标
PlanHandler.prototype.getCurrentItemIndex = function(/*None*/){
	return this._itemsFristCanvas.getActivatedRowIndex();
};
//取当前被选中的[条款]
PlanHandler.prototype.getCurrentItemTermId = function(/*None*/){
	//TODO
	return this._itemSecondCanvas.getActivatedRowPK();
};
//取当前被选中的[条款]下标
PlanHandler.prototype.getCurrentItemTermIndex = function(/*None*/){
	//TODO
	return this._itemSecondCanvas.getActivatedRowIndex();
};
//取当前被选中的[科目]下标
PlanHandler.prototype.getCurrentItemTermAcctIndex = function(/*None*/){
	//TODO
	return this._PlanItemStoreCanvas.getActivatedRowIndex();
};
/*
 * 取当前客户端维护的数据，覆盖“模版页签；页签--〉条款的映射表；条款--〉科目的映射表”所有的关联关系。
 * 重要备注：默认返回全版本（包含各类型的编号，名称/描述等）的数据；
 * 开发者可以根据需要自行裁减（如只返回数据的编号和用户输入的数据等）。
*/
PlanHandler.prototype.getData = function(/*none*/){
	var dataSnapshot = {};
	dataSnapshot.items = this._itemList;
	dataSnapshot.item2store = this._item2StoreMapping;
	return dataSnapshot;
};

PlanHandler.prototype.getEditData = function(/*none*/){
	var dataSnapshot = {};
	var itemList = [];
	var itemStoreMap = {};
	var itemLen = this._itemList.length;
	//删除无用的数据
	for (var ind = 0; ind < itemLen; ind++) {
		var itemObj = this._itemList[ind];
		if ("strType" in itemObj) {
			itemList.push(itemObj);
			//所有的货号存放
			this._delItermNo.push(itemObj.itemNo);
			//已有的门店数据存放
			var storeMap = itemStoreMap[itemObj.itemNo] = {};
			storeMap.data = this._item2StoreMapping[itemObj.itemNo].data;
		}
	}
	dataSnapshot.items = itemList;
	dataSnapshot.item2store = itemStoreMap;
	dataSnapshot.delItemNo = this._delItermNo;
	return dataSnapshot;
};

//检查是否已存在指定的[模版页签]
PlanHandler.prototype.isPromUnitNoDuplicated = function(/*int*/tabIdIn){
	/**option-1.基于内部维护的商品列表，检查传入的货号是否已定义；
		注意：这种线性的检查方式在“商品列表”数量小(数10个)时，效率可以接受.
	**/
	var duplFlag = false;
	for (var tabIndex=0;tabIndex < this._itemList.length; tabIndex++){
		if (this._itemList[tabIndex].tabId==tabIdIn){
			duplFlag = true;
			break;
		}
	}
	return duplFlag;
};
//<1-1>.更新在“指定页签，指定条款，指定科目”下的[科目组编号]
PlanHandler.prototype.doSyncGrpAcctIdAtStore = function(/*Number*/newGrpAcctIdVal, /*Node*/anyRowMemberIn){
	this._PlanItemStoreCanvas.setRowMemberNodeValue(anyRowMemberIn, newGrpAcctIdVal, 2, 1);
	this._doSyncTermAcctsNamedProperty("grpAcctId", newGrpAcctIdVal, anyRowMemberIn);
};

//<1-2>.批量更新在“某代号下所有商品下门店列表中的[促销进价]”
/*PlanHandler.prototype.doBatchSyncPromBuyPriceAtUnit = function(NumbernewBatchPromBuyPriceVal){
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var presOrdQtyElem = oneStoreRowNode.children[5];//oneStoreRowNode.children[0].children[5]; 
		presOrdQtyElem.value = newBatchPresOrdQtyVal;
		this._doSyncNamedStoreProperty("promBuyPrice", newBatchPresOrdQtyVal, presOrdQtyElem);	
	}
};*/
//<1-3>.批量更新在“某代号某商品下的门店列表中的[促销进价]”
/*PlanHandler.prototype.doBatchSyncPromBuyPriceAtItem = function(NumbernewBatchPromBuyPriceVal){
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var presOrdQtyElem = oneStoreRowNode.children[5];//oneStoreRowNode.children[0].children[5]; 
		presOrdQtyElem.value = newBatchPresOrdQtyVal;
		this._doSyncTermAcctsNamedProperty("grpAcctId", newBatchPresOrdQtyVal, presOrdQtyElem);	
	}
};*/
//<2-1>.更新在“指定代号，指定商品，指定门店”下的[促销售价]
/*PlanHandler.prototype.doSyncPromSellPriceAtStore = function(NumbernewPromSellPriceVal, NodeanyRowMemberIn){
	var currStoreQrdQtyCalcVal = this._getOrdQtyCalculated(anyRowMemberIn, newOrdQtyVal);
	var rowNode = this.itemStoresCanvas.getRowNodeFromAnyElement(anyRowMemberIn);
	var ordQtyElem = rowNode.children[4]; 
	ordQtyElem.value = currStoreQrdQtyCalcVal;
	this._doSyncNamedStoreProperty("promSellPrice", currStoreQrdQtyCalcVal, anyRowMemberIn);
};*/
//<2-2>.批量更新在“某代号下所有商品下门店列表中的[促销售价]”
/*PlanHandler.prototype.doBatchSyncPromSellPriceAtUnit = function(NumbernewBatchPromSellPriceVal){
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var presOrdQtyElem = oneStoreRowNode.children[5];//oneStoreRowNode.children[0].children[5]; 
		presOrdQtyElem.value = newBatchPresOrdQtyVal;
		this._doSyncNamedStoreProperty("promSellPrice", newBatchPresOrdQtyVal, presOrdQtyElem);	
	}
};*/
//<2-3>.批量更新在“某代号某商品下的门店列表中的[促销售价]”
/*PlanHandler.prototype.doBatchSyncPromSellPriceAtItem = function(NumbernewBatchPromSellPriceVal){
	var storesAreaLeft = this._storesLeftHeadCanvas.getContainerNode();
	var storesAreaRight = this._PlanItemStoreCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesAreaLeft.children.length;storeIndex++){
		var oneStoreRowNode = storesAreaRight.children[storeIndex];
		//设置界面上[促销售价]文本框的值;
		this._PlanItemStoreCanvas.setRowMemberNodeValue(oneStoreRowNode, newBatchPresOrdQtyVal, storeIndex, 4, 0);
		
		this._doSyncTermAcctsNamedProperty("promSellPrice", newBatchPresOrdQtyVal, presOrdQtyElem);	
	}
};*/

//同时，对Store级别的多个成员属性设置新值；
/*PlanHandler.prototype._doSyncItemStoresNamedProperties = function(ArraypropNameValues,NodeanyRowMemberIn){
	if (!propNameValues || propNameValues.length <=0) return;
	//1.取当前“门店列表”挂接到的商品PK（包含商品编号）；
	var currTermId = this.itemsCanvas.getActivatedRowPK();
	//2.根据商品编号，取门店列表的数据结构体；
	var thItemstoresData = this.itemStoresMapping[currTermId];
	var storeInfoArray = thItemstoresData.data;
	var storeIndex = this.itemStoresCanvas.getRowIndex(anyRowMemberIn);
	//3.更新数据结构体中相应位置(@storeIndex)相应元素的值;
	var thItemStoreData = storeInfoArray[storeIndex];
	for (var propName in propNameValues){
		var propVal = propNameValues[propName];
		thItemStoreData[propName] = propVal;
	}
};*/
//取传入的某[页签]节点元素所在记录行的指定属性值
PlanHandler.prototype.getTabRowPropValFromNode = function(/*Node*/anyRowMemberNode, /*String*/tabId){
	var tabRowIndex = this._itemsFristCanvas.getRowIndex(anyRowMemberNode);
	var tabRowData = this._itemList[tabRowIndex];
	return tabRowData[tabId];
};
/*
 * 当[模版页签类型]发生变化时,清除原先代号下的所有数据以及界面元素内容
 */
PlanHandler.prototype.resetOneTabToBlank = function(/*Node*/anyRowMemberNodeIn){
	this.replaceOneTabNodeWithNewVal(anyRowMemberNodeIn, "");
	this._itemsFristCanvas.resetRowContentByNode(anyRowMemberNodeIn);
	//3.清除[商品列表]界面和[门店列表]界面
	//this._storesLeftHeadCanvas.clear();
	this._itemSecondCanvas.clear();
};
PlanHandler.prototype.hasMoreUnits = function(/*None*/){
	return this._itemList.length>0;
};
//获取条款的区域
PlanHandler.prototype.getTermContainerNode = function(/*None*/){
	return this._itemSecondCanvas.getContainerNode();
};

//更新商品数据
PlanHandler.prototype._doUpdateOneItemRowContent = function(/*Node*/anyItemRowMemberNodeIn, /*Boolean*/flag){
	var flag = true;
	var oneItemRowIdx = this._itemsFristCanvas.getRowIndex(anyItemRowMemberNodeIn);
	var itemNoElem = this._itemsFristCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 0).children[0].children[0];	//货号
	var itemNameElem = this._itemsFristCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 1).children[0];	//品名
	var ordMultiParmElem = this._itemsFristCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 2).children[0];	//订购倍数
	var curBuyPriceElem = this._itemsFristCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 3).children[0];	//本次进价
	var normBuyPriceElem = this._itemsFristCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 4).children[0];	//正常进价
	var stMainSupNoElem = this._itemsFristCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 5).children[0].children[0];	//厂编
	var comName = this._itemsFristCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 6).children[0];	//公司名称
	var stMinOrdQtyElem = this._itemsFristCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 7).children[0];	//最小量
	var tabTypeElem = this._itemsFristCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 8).children[0];	//总配额
	var stMinOrdQty = stMinOrdQtyElem.value;
	var ordMultiParm = ordMultiParmElem.value;
	//获取元素位置
	var tdIndex = this._itemsFristCanvas.getChildrenIndex(/*Node*/anyItemRowMemberNodeIn);
	//验证订购倍数
	if (tdIndex == 2) {
		stMinOrdQtyElem.value = "";
		//清空该货号下所有门店的建议量（因订购倍数已更改）
		this._PlanItemStoreCanvas.clearInitQty();
		//清空门店的建议量
		this.clearStoreDataForInitQty(itemNoElem.value);
	}
	//验证最小量
	if (tdIndex == 7) {
		if (stMinOrdQty) {
			if (stMinOrdQty % ordMultiParm != 0) {
				stMinOrdQtyElem.value = "";
				//设置红色背景色
				this._itemsFristCanvas.errorElementFlag(/*Node*/stMinOrdQtyElem);
				this._itemsFristCanvas.hintMessage(/*Node*/stMinOrdQtyElem, /*String*/"最小量必须为订购倍数的倍数");
				flag = false;
			}
			//清空该货号下所有门店的建议量（因最小量已更改）
			this._PlanItemStoreCanvas.clearInitQty();
			//清空门店的建议量
			this.clearStoreDataForInitQty(itemNoElem.value);
		}
	}
	//验证本次进价
	if (tdIndex == 3) {
		var curBuyPrice = curBuyPriceElem.value;
		var normBuyPrice = normBuyPriceElem.value;
		if (normBuyPrice < curBuyPrice) {
			curBuyPriceElem.value = "";
			this._itemsFristCanvas.errorElementFlag(/*Node*/curBuyPriceElem);
			this._itemsFristCanvas.hintMessage(/*Node*/curBuyPriceElem, /*String*/"本次进价必须小于等于正常进价");
			flag = false;
		} else {
			this._itemsFristCanvas.errorElementFlag(/*Node*/curBuyPriceElem);
			this._itemsFristCanvas.hintMessage(/*Node*/curBuyPriceElem, /*String*/"本次进价不能为空");
			flag = false;
		}
	}
	
	if (flag) {
		var currentItemData = this._itemList[oneItemRowIdx];
		currentItemData.itemNo = itemNoElem.value;		//货号
		currentItemData.itemName = itemNameElem.value;	//品名
		currentItemData.ordMultiParm = ordMultiParmElem.value;		//订购倍数
		currentItemData.curBuyPrice = curBuyPriceElem.value;		//本次进价
		currentItemData.normBuyPrice = normBuyPriceElem.value;		//正常进价
		currentItemData.stMainSupNo = stMainSupNoElem.value;	//厂编
		currentItemData.comName = comName.value;		//公司名称
		currentItemData.stMinOrdQty = stMinOrdQtyElem.value;		//最小量
		//来区分是否是新增的商品
		currentItemData.strType = "new";
		//currentItemData.tabEnName = tabEnNameElem.value;	//总配额
		//获取下一个光标
		/*	if (flag) {
		this._itemsFristCanvas.getNextCursor(NodeanyItemRowMemberNodeIn);
	}*/
	}
};
//清空门店数据的建议量
PlanHandler.prototype.clearStoreDataForInitQty = function(/*String*/itemNo){
	var storeData = this._item2StoreMapping[itemNo];
	if (!storeData || storeData.data.length == 0) {
		return ;
	}
	for (var ind = 0; ind < storeData.data.length; ind++) {
		var storeObj = storeData.data[ind];
		storeObj.initQty = "";
	}
};

//**更新门店数据
PlanHandler.prototype._doUpdateOneItemStoreRowContent = function(/*Node*/anyStoreRowMemberNodeIn){
	//1.获取门店的index
	var oneItemRowIdx = this._PlanItemStoreCanvas.getRowIndex(anyStoreRowMemberNodeIn);
	var initQtyElem = this._PlanItemStoreCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 2);    //建议量
	var stCnfrmQtyElem = this._PlanItemStoreCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 3);	//门店确认量
	var finalQtyElem = this._PlanItemStoreCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 4);	//最终数量
	var flag = true;
	//获取商品索引
	var itemNodeIndex = this.getCurrentItemIndex();
	var itemVO = this._itemList[itemNodeIndex];
	var ordMultiParm = itemVO.ordMultiParm;
	var stMinOrdQty = itemVO.stMinOrdQty;
	var initQty = initQtyElem.value;
	if (initQty) {
		if (initQty % ordMultiParm != 0) {
			anyStoreRowMemberNodeIn.value = "";
			//设置红色背景色
			this._PlanItemStoreCanvas.errorElementFlag(/*Node*/anyStoreRowMemberNodeIn);
			this._PlanItemStoreCanvas.hintMessage(/*Node*/anyStoreRowMemberNodeIn, /*String*/"建议量必须为订购倍数的倍数");
			flag = false;
		}
	}
	if (initQty) {
		if (initQty < stMinOrdQty) {
			anyStoreRowMemberNodeIn.value = "";
			//设置红色背景色
			this._PlanItemStoreCanvas.errorElementFlag(/*Node*/anyStoreRowMemberNodeIn);
			this._PlanItemStoreCanvas.hintMessage(/*Node*/anyStoreRowMemberNodeIn, /*String*/"建议量必须大于等于最小量");
			flag = false;
		}
	}
	if (flag) {
		//2.获取商品的itemNo
		var itemNo = this.getCurrentItem();
		//3.获取商品下的门店data
		var itemStoreData = this._item2StoreMapping[itemNo].data[oneItemRowIdx];
		itemStoreData.initQty = initQtyElem.value;	//建议量
		itemStoreData.stCnfrmQty = stCnfrmQtyElem.value;	//门店确认量
		itemStoreData.finalQty = finalQtyElem.value;	//最终数量
		//获取下一个光标
//	this._PlanItemStoreCanvas.getNextCursor(/*Node*/anyTermRowMemberNodeIn);
	}
};
//错误的数标红显示
PlanHandler.prototype.showErrorElement = function(/*String*/itemIndex){
	this._itemsFristCanvas.clickRowByIndex(itemIndex);
	//货号标红
	var oneItemRowIdx = this.getCurrentItemIndex();
	var currentElem = this._itemsFristCanvas.getRowMemberNodeByIndex(oneItemRowIdx, 0);
	var itemNoElem =  this._itemsFristCanvas._getNestedRowMemberNodeByIndex(currentElem, 0);
	this._itemsFristCanvas.errorElementFlag(/*Node*/itemNoElem);
	//门店标红
	this._PlanItemStoreCanvas.errorStoreElementFlag();
	
};


////**********************************************************************************************************************
//显示商品查询结果信息
PlanHandler.prototype.showItemMessage = function(/*Object*/itemVO, /*Node*/rowNodeIn){
	//获取当前商品的索引
	var theRowIndex = this._itemsFristCanvas.getRowIndex(rowNodeIn);
	//商品
	var rpItemList = itemVO.rpItemList;
	//门店
	var rpStoreList = itemVO.rpStoreList;
	//商品信息赋值
	var itemObj = this._itemList[theRowIndex];
	var rowDataIn = rpItemList[0];
	itemObj.itemNo = rowDataIn.itemNo;	//货号
	itemObj.itemName = rowDataIn.itemName;	//品名
	itemObj.ordMultiParm = rowDataIn.ordMultiParm;	//订购倍数
	itemObj.curBuyPrice = rowDataIn.curBuyPrice || rowDataIn.normBuyPrice;	//本次进价
	itemObj.normBuyPrice = rowDataIn.normBuyPrice;	//正常进价
	itemObj.stMainSupNo = rowDataIn.stMainSupNo;	//厂编
	itemObj.comName = rowDataIn.comName;	//公司名称
	itemObj.stMinOrdQty = rowDataIn.stMinOrdQty;	//最小量
	//来区分是否是新增的商品
	itemObj.strType = "new";
	//itemObj.td8 = rowDataIn.td8;	//总配额
	//检测删除数组是否包含此货号，如果存在则删除
	var delLen = this._delItermNo.length - 1;
	if (delLen > 0) {
		for (var ind = delLen; ind > -1; ind--) {
			if (rowDataIn.itemNo === this._delItermNo[ind]) {
				this._delItermNo.splice(ind, 1);
				break;
			}
		}
	}
	//显示商品信息到画布上
	this._itemsFristCanvas.renderRowFromData(rowNodeIn, itemObj);
	//赋值商品下的门店信息
	this._item2StoreMapping[rowDataIn.itemNo] = {};
	this._item2StoreMapping[rowDataIn.itemNo].data = rpStoreList;
	this._item2StoreMapping[rowDataIn.itemNo].loaded = true;
	//模拟点击商品
	this._itemsFristCanvas.clickRowByIndex(theRowIndex);
};

//显示商品下的门店
PlanHandler.prototype.serarchItems = function(/*Integer*/itemNo, /*Integer*/dcStoreNo){
	if (!itemNo) {
		this._PlanItemStoreCanvas.setButtonPutTheAsh();
		return ;
	}
	$.ajax({
		type : 'post',
		url : ctx + '/rp/plan/serarchItemStores',
		data : {itemNo : itemNo, dcStoreNo : dcStoreNo},
		success : function(data){
			if (data.length > 0) {
				//赋值商品下的门店信息
				planHandler._item2StoreMapping[itemNo] = {};
				planHandler._item2StoreMapping[itemNo].data = data;
				planHandler._item2StoreMapping[itemNo].loaded = true;
				planHandler._PlanItemStoreCanvas.show(data);
			}
		}
	});
	this._PlanItemStoreCanvas.setButtonRearLight();
};

//批量显示商品查询结果信息
PlanHandler.prototype.batchShowItemMessage = function(/*Object*/itemVO){
	//重复商品集合
	var repeatItemGather = [];
	//商品
	var rpItemList = itemVO.rpItemList;
	//门店
	var rpStoreList = itemVO.rpStoreList;
	for (var itemInd = 0; itemInd < rpItemList.length; itemInd++) {
		var rowDataIn = rpItemList[itemInd];
		//验证是否有重复商品
		var repeatItem = this.checkRepeatItem(rowDataIn.itemNo);
		if (repeatItem != "") {
			repeatItemGather.push(repeatItem);
			continue;
		}
		var itemObj = {};
		itemObj.itemNo = rowDataIn.itemNo;	//货号
		itemObj.itemName = rowDataIn.itemName;	//品名
		itemObj.ordMultiParm = rowDataIn.ordMultiParm;	//订购倍数
		itemObj.curBuyPrice = rowDataIn.curBuyPrice || rowDataIn.normBuyPrice;	//本次进价
		itemObj.normBuyPrice = rowDataIn.normBuyPrice;	//正常进价
		itemObj.stMainSupNo = rowDataIn.stMainSupNo;	//厂编
		itemObj.comName = rowDataIn.comName;	//公司名称
		itemObj.stMinOrdQty = rowDataIn.stMinOrdQty;	//最小量
		this._itemList.push(itemObj);
		//itemObj.td8 = rowDataIn.td8;	//总配额
		//显示商品信息到画布上
		this._itemsFristCanvas.show([itemObj]);
		this._itemSecondCanvas.show([itemObj]);
		if (itemInd == 0) {
			//赋值商品下的门店信息
			this._item2StoreMapping[rowDataIn.itemNo] = {};
			this._item2StoreMapping[rowDataIn.itemNo].data = rpStoreList;
			if (rpStoreList.length > 0) {
				this._item2StoreMapping[rowDataIn.itemNo].loaded = true;
			} else {
				this._item2StoreMapping[rowDataIn.itemNo].loaded = false;
			}
		}
	}
	//模拟点击商品
	this._itemsFristCanvas.clickRowByIndex(0);
};


//单选商品查询结果信息
PlanHandler.prototype.radioShowItemMessage = function(/*Object*/itemVO){
	//获取索引
	var rowIndex = this.getCurrentItemIndex();
	//获取当前对象
	var rowNodeIn = this._itemsFristCanvas.getRowMemberNodeByIndex(rowIndex,0);
	//重复商品集合
	var repeatItemGather = [];
	//商品
	var rpItemList = itemVO.rpItemList;
	//商品对象
	var itemObj = this._itemList[rowIndex];
	//门店
	var rpStoreList = itemVO.rpStoreList;
	for (var itemInd = 0; itemInd < rpItemList.length; itemInd++) {
		var rowDataIn = rpItemList[itemInd];
		//验证是否有重复商品
		var repeatItem = this.checkRepeatItem(rowDataIn.itemNo);
		if (repeatItem != "") {
			repeatItemGather.push(repeatItem);
			continue;
		}
		itemObj.itemNo = rowDataIn.itemNo;	//货号
		itemObj.itemName = rowDataIn.itemName;	//品名
		itemObj.ordMultiParm = rowDataIn.ordMultiParm;	//订购倍数
		itemObj.curBuyPrice = rowDataIn.curBuyPrice || rowDataIn.normBuyPrice;	//本次进价
		itemObj.normBuyPrice = rowDataIn.normBuyPrice;	//正常进价
		itemObj.stMainSupNo = rowDataIn.stMainSupNo;	//厂编
		itemObj.comName = rowDataIn.comName;	//公司名称
		itemObj.stMinOrdQty = rowDataIn.stMinOrdQty;	//最小量
		//itemObj.td8 = rowDataIn.td8;	//总配额
		//显示商品信息到画布上
		this._itemsFristCanvas.renderRowFromData(rowNodeIn, itemObj);
		if (itemInd == 0) {
			//赋值商品下的门店信息
			this._item2StoreMapping[rowDataIn.itemNo] = {};
			this._item2StoreMapping[rowDataIn.itemNo].data = rpStoreList;
			this._item2StoreMapping[rowDataIn.itemNo].loaded = true;
		}
	}
	//模拟点击商品
	this._itemsFristCanvas.clickRowByIndex(0);
};
//验证是否有重复商品
PlanHandler.prototype.checkRepeatItem = function(/*String*/itemNo){
	var repeatItem = '';
	for (var ind = 0; ind < this._itemList.length-1; ind++) {
		var itemObj = this._itemList[ind];
		if (itemObj.itemNo == itemNo) {
			repeatItem = itemNo;
			break;
		}
	}
	return repeatItem;
};

//批量修改建议量
PlanHandler.prototype._doUpdateInitQty = function(/*Node*/theCurrentElement, /*Integer*/batchinitQty){
	var flag = true;
	//获取商品索引
	var itemNodeIndex = this.getCurrentItemIndex();
	var itemVO = this._itemList[itemNodeIndex];
	var ordMultiParm = itemVO.ordMultiParm;
	var stMinOrdQty = itemVO.stMinOrdQty;
	if (batchinitQty) {
		if (batchinitQty % ordMultiParm != 0) {
			theCurrentElement.value = "";
			//设置红色背景色
			this._PlanItemStoreCanvas.batchErrorElement(/*String*/"建议量必须为订购倍数的倍数");
			flag = false;
		}
	} else {
		flag = false;
	}
	if (stMinOrdQty) {
		if (batchinitQty < stMinOrdQty) {
			theCurrentElement.value = "";
			//设置红色背景色
			this._PlanItemStoreCanvas.batchErrorElement(/*String*/"建议量必须大于等于最小量");
			flag = false;
		}
	}
	//验证商品下是否有门店
	var storeData = this._item2StoreMapping[itemVO.itemNo].data;
	if (!storeData || storeData.length == 0) return ;
	if (flag) {
		//门店区域赋值
		this._PlanItemStoreCanvas.batchUpdateInitQtys(batchinitQty);
		//门店数据赋值
		for (var ind = 0; ind < storeData.length; ind++) {
			var storeObj = storeData[ind];
			storeObj.initQty = batchinitQty;
		}
		//去除门店红色错误
		this._PlanItemStoreCanvas.remvoeErrorMess();
	}
};

//禁止重复查询
PlanHandler.prototype.forbidRepetitionSearch = function(/*String*/itemNo){
	var flag = false;
	if (this.getCurrentItem() == itemNo) {
		flag = true;
	}
	return flag;
};
//是否有已存在的货号
PlanHandler.prototype.wheterExistItemNo = function(/*String*/itemNo){
	var flag = false;
	//获取当前索引
	var indexOf = this.getCurrentItemIndex();
	var itemArray = this._itemList;
	for (var ind = 0; ind < itemArray.length; ind++) {
		//排除当前货号
		if (ind == indexOf) {
			continue ;
		}
		var itemObj = itemArray[ind];
		if (itemObj.itemNo == itemNo) {
			flag = true;
			break;
		}
	}
	return flag;
};

//修改保留计划信息初始化
PlanHandler.prototype.editPlanMessage = function(/*Object*/itemMap){
	//商品
	for (var key in itemMap) {
		var rowDataIn = itemMap[key];
		var itemObj = {};
		itemObj.itemNo = rowDataIn.itemNo;	//货号
		itemObj.itemName = rowDataIn.itemName;	//品名
		itemObj.ordMultiParm = rowDataIn.ordMultiParm;	//订购倍数
		itemObj.curBuyPrice = rowDataIn.buyPrice;	//本次进价
		itemObj.normBuyPrice = rowDataIn.normBuyPrice;	//正常进价
		itemObj.stMainSupNo = rowDataIn.dcSupNo;	//厂编
		itemObj.comName = rowDataIn.comName;	//公司名称
		itemObj.stMinOrdQty = rowDataIn.stMinOrdQty;	//最小量
		//itemObj.td8 = rowDataIn.td8;	//总配额
		//显示商品信息到画布上
		this._itemsFristCanvas.show([itemObj]);
		this._itemSecondCanvas.show([itemObj]);
		//赋值商品下的门店信息
		this._item2StoreMapping[rowDataIn.itemNo] = {};
		this._item2StoreMapping[rowDataIn.itemNo].data = rowDataIn.storeArray;
		if (rowDataIn.storeArray.length > 0) {
			this._item2StoreMapping[rowDataIn.itemNo].loaded = true;
			//来区分是否是新增的商品
			itemObj.strType = "new";
		} else {
			this._item2StoreMapping[rowDataIn.itemNo].loaded = false;
		}
		this._itemList.push(itemObj);
	}
	//模拟点击商品
	this._itemsFristCanvas.clickRowByIndex(0);
};

//批量新增门店
PlanHandler.prototype.batchAddStore = function(/*Array*/storeVO){
	//获取当前的货号
	var itemNo = this.getCurrentItem();
	//获取货号下的门店data
	var storeData = this._item2StoreMapping[itemNo].data;
	//以下是新增的门店显示在门店区域上
	var storeArray = storeVO.storeArr;
	var len = storeArray.length;
	for (var ind = 0; ind < len; ind++) {
		var flag = false;
		var storeObj = storeArray[ind];
		//忽略重复的门店
		for (var inde = 0; inde < storeData.length; inde++) {
			var checkStoreObj = storeData[inde];
			if (checkStoreObj.storeNo == storeObj.storeNo) {
				flag = true;
				break;
			}
		}
		if (flag) {
			continue ;
		}
		var store = {};
		store.storeNo = storeObj.storeNo;
		store.storeName = storeObj.storeName;
		store.chngDate = storeVO.dateStr;
		//显示到门店区域上
		this._PlanItemStoreCanvas.show([store]);
		storeData.push(store);
	}
};

//清空商品信息和门店信息
PlanHandler.prototype.clearItemAndStore = function(/*Null*/){
	//清空商品信息
	this._itemsFristCanvas.clear();
	this._itemSecondCanvas.clear();
	//清空门店信息
	this._PlanItemStoreCanvas.clear();
	//清空批量修改的建议量
	this._PlanItemStoreCanvas.clearBatchInitQty(/*Null*/);
	//清空货号数据
	this._itemList = [];
	//清空门店数据
	this._item2StoreMapping = {};
	this._PlanItemStoreCanvas.setButtonPutTheAsh(/*Null*/);
};