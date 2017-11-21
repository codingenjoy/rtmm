/*
 *  本文定义了"所有 类似于[总部进价促销]以及[ART促销]的客户端主控类, 为抽象基类.
 *  [总部进价促销]以及[ART促销]必须扩展当前的主控类.
 *  */
function PromMgmtHandler(/*optional*/pOrderNoIn, /*optional, boolean*/readonly){
	this.CONST_EMPTY_AnyNO = "";
	//0.存储所有的代号列表
	this._unitList = [];
	/*
	 * 存储所有的“one PromUnit--〉Item List”的映射关系定义,为Key-Value结构。
	 * 其中Key的值为[promUnitNo], Value的值为Map类型，具有如下结构：
	 * 	{
	 * 	loaded: [true|false],
	 *  items: [Array of PromItemVO];"根据某个促销代号(@promUnitNo)拿到的商品(items)列表"
	 * }
	 */
	this._unit2ItemsMapping = {};
	
	/*
	 * 存储所有的“one PromUnit.Item--〉Stores List”的映射关系定义,为Key-Value结构。
	 * 其中Key的值为[itemNo], Value的值为Map类型，具有如下结构：
	 * 	{
	 * 	loaded: [true|false],
	 *  stores: [Array of PromItemStoreVO];"根据某个货号(@itemNo)拿到的门店(Stores)列表"
	 * }
	 */
	this._item2StroresMapping = {};
	/* [促销代号]列表显示区域*/
	this._unitsCanvas = new PromUnitCanvas();
	/* [某促销代号下的商品]列表显示区域*/
	this._itemsCanvas = new PromUnitItemsCanvas();
	/* [某促销代号/商品下的门店]列表显示区域， 冻结表头*/
	this._storesLeftHeadCanvas = new PromUnitItemStoresFirstCanvas();
	/* [某促销代号/商品下的门店]列表显示区域， 主体*/
	this._storesRightBodyCanvas = new PromUnitItemStoresSecondCanvas();

	this.promType = 0;
	this.buyPriceEditableFlag = false;
	this.sellPriceEditableFlag = false;
}
//取得[促销代号区域]的画布元素
PromMgmtHandler.prototype.getUnitsCanvas = function(/*None*/){
	return this._unitsCanvas;
};
//取得[某促销代号下的商品区域]的画布元素
PromMgmtHandler.prototype.getItemsCanvas = function(/*None*/){
	return this._itemsCanvas;
};
//取得[某商品下下的门店区域]的画布元素
PromMgmtHandler.prototype.getStoresCanvas = function(/*None*/){
	return this._storesCanvas;
};
//取得[某商品下下的门店区域]的左边表头画布元素
PromMgmtHandler.prototype.getStoresHeadCanvas = function(/*None*/){
	return this._storesLeftHeadCanvas;
};

//取得[某商品下下的门店区域]的右边表身画布元素
PromMgmtHandler.prototype.getStoresBobyCanvas = function(/*None*/){
	return this._storesRightBodyCanvas;
};
//增加一笔空白/待编辑的促销代号
PromMgmtHandler.prototype.addOneEmptyPromUnit = function(/*none*/){
	//step1.检查是否已有空白的[促销代号]存在;
	if (this.hasEmptyUnitExist()) {
		var lastRowIndex = this._unitsCanvas.getRowCount() - 1; 
		this._unitsCanvas.setRowMemberFocusedByIndex(lastRowIndex, 1, 0);
		return;
	}
	//step2.伪造一笔unitNo为“N/A”的空数据，并执行 batch操作
	var newEmptyUnitData = {};
	newEmptyUnitData.unitNo = this.CONST_EMPTY_AnyNO;
	newEmptyUnitData.unitType = 0;
	//调用“批量增加 促销代号”的接口，将该笔 [空白代号]加入到内部结构中；
	this.addNewPromUnits([newEmptyUnitData]);
};
/*	增加一批[促销代号]
 * 0.@bulkPromUnitsData:促销代号列表;
 * 1.@addDataOnlyIn:只加数据，不模拟点击；
 */
PromMgmtHandler.prototype.addNewPromUnits = function(/*Array*/bulkPromUnitsData, /*boolean?*/addDataOnlyIn){
	var lastMaxRowIndex = this._unitsCanvas.getRowCount() - 1;
	var realNewUnitAdded = false;
	//对传入的[促销代号]列表进行循环,逐笔加入;
	for (var i=0;i<bulkPromUnitsData.length;i++){
		var oneUnitInfo = bulkPromUnitsData[i];
		var bizPK = oneUnitInfo.unitNo;
		var unitType = oneUnitInfo.unitType;
		//1-1.检测当前传入的这笔商品是否已添加；
		if (this.isPromUnitNoAndTypeDuplicated(bizPK,unitType)){
			continue;
		}
		realNewUnitAdded = true;
		//1-2.将该笔[促销代号]数据压入混合栈中；
		this._unitList.push(oneUnitInfo);
		//1-3.在界面上显示该笔[促销代号]；
		//注意：加入“根据促销类型，控制[促销进价]和[促销售假]这2个输入框的可编辑性”；
		this._unitsCanvas.show([oneUnitInfo], this.buyPriceEditableFlag, this.sellPriceEditableFlag);
		//1-4.初始化当前传入[促销代号]的商品数据存储结构;
		if (bizPK && bizPK !=  this.CONST_EMPTY_AnyNO){
			this._unit2ItemsMapping[bizPK] = {};
			this._unit2ItemsMapping[bizPK].data = [];
			this._unit2ItemsMapping[bizPK].loaded = false;
		}
	}
	//2.默认激活新增加的第一笔.
	if (!addDataOnlyIn){
		var rowIndex2Select = realNewUnitAdded?lastMaxRowIndex+1:lastMaxRowIndex;
		this._unitsCanvas.clickRowByIndex(rowIndex2Select);
	}
};
/*
 * 对目标[促销代号]检查：“在内部数据结构中，该代号与商品的映射关系已建立”.
 * 处理逻辑如下：
 * 0.该促销代号是否真实有效，即在代号列表中是否能找到该促销代号；
 * 1.代号与商品的映射关系是否建立；
 */
PromMgmtHandler.prototype._doCheckAndForceUnit2ItemsMappingBuilt = function(/*String*/anyPromUnitNoIn){
	var isPromUnitExist = false;
	for (var unitIdx=0; unitIdx < this._unitList.length;unitIdx++){
		var unitRowData = this._unitList[unitIdx];
		if (unitRowData.unitNo == anyPromUnitNoIn){
			isPromUnitExist = true;
			break;
		}
	}
	if (!isPromUnitExist) return false;
	var unitItemsData = this._unit2ItemsMapping[anyPromUnitNoIn];
	if (!unitItemsData){
		unitItemsData = this._unit2ItemsMapping[anyPromUnitNoIn] = {};
		unitItemsData.data = [];
		unitItemsData.loaded = false;
	}
	if (!unitItemsData.data)
		unitItemsData.data = [];
	return true;
};
/*
 * 为指定的[促销代号]增加一批[商品].
 * 0.@promUnitNoIn:目标促销代号；
 * 1.@bulkUnitItemsData:商品列表数据；
 * 2.@addDataOnlyIn:只向内部结构体增加数据，不做界面的显示
 */
PromMgmtHandler.prototype.addNewItems2OnePromUnit = function(/*String*/promUnitNoIn,/*Array*/bulkUnitItemsData, /*boolean?*/addDataOnlyIn){
	var lastMaxRowIndex = this._itemsCanvas.getRowCount() - 1;
	//定义标志位，检测是否有新的商品加入到该笔[代号]中
	var realNewItemsAdded = false;
	//如果需要执行一些逻辑（比如逐行的检测），则需要对bulkUnitItemsData做循环；否则直接调用批处理函数；
	for (var i=0;i<bulkUnitItemsData.length;i++){
		var newUnitItemInfo = bulkUnitItemsData[i];
		var newItemNo = newUnitItemInfo.itemNo;
		var isUnitItemDuplicated =false;
		var currUnitItemsSnapshotData = this._unit2ItemsMapping[promUnitNoIn].data;
		//1-1.检测当前传入的这笔[商品]是否已添加；
		for (var itemIndex = 0;itemIndex<currUnitItemsSnapshotData.length;itemIndex++){
			var existedUnitItemInfo = currUnitItemsSnapshotData[itemIndex];
			if (existedUnitItemInfo.itemNo == newItemNo){
				isUnitItemDuplicated = true;
				break;
			}
		}
		if (isUnitItemDuplicated) continue;
		realNewItemsAdded = true;
		//获取与[当前商品]关联的[门店列表]数据，并将@stores从[当前商品]的结构中移除；
		var attachedStores = newUnitItemInfo.stores;
		delete newUnitItemInfo["stores"];//注意：非常关键
		//1-2.将传入的[商品]信息压入到线性结构中；
		currUnitItemsSnapshotData.push(newUnitItemInfo);
		//1-3.若@addDataOnlyIn标志为FALSE，则在[商品]区域显示这笔新加入的商品；
		if (!addDataOnlyIn)
			this._itemsCanvas.show([newUnitItemInfo]);
		//1-4.将这笔[商品]下挂的[门店列表]数据送进内部的数据结构中；
		var newPUIStores = this._item2StroresMapping[newItemNo] = {}; 
		newPUIStores.data = attachedStores;
		newPUIStores.loaded = true;
	}
	//设置[已加载]的标志
	this._unit2ItemsMapping[promUnitNoIn].loaded = true;
	//2.默认激活新增加的第一笔.
	var rowIndex2Select = realNewItemsAdded?lastMaxRowIndex+1:lastMaxRowIndex;
	this._itemsCanvas.clickRowByIndex(rowIndex2Select);
};
//检查是否存在空白的[促销代号];
PromMgmtHandler.prototype.hasEmptyUnitExist = function(/*none*/){
	//step1.使用“未初始化的值”（即undefined）进行检测；
	var naUnitNo = undefined;
	if (this.isPromUnitNoDuplicated(naUnitNo)) return true;
	//step2.使用“空字符串”进行检测；
	var blankUnitNoStr = '';
	if (this.isPromUnitNoDuplicated(blankUnitNoStr)) return true;
	//step3.使用“内部约定的N/A串”进行检测；
	if (this.isPromUnitNoDuplicated(this.CONST_EMPTY_AnyNO)) return true;
	return false;
};
/*
 * 激活目标[促销代号]元素。
 * 处理逻辑：
 * 0.根据传入的[促销代号]成员节点，获取目标[促销代号]元素；
 * 1.比较目标[促销代号]元素与[最近一次被激活的促销代号]元素是否相同；
 * 	--〉
 */
PromMgmtHandler.prototype.activatePromUnitByAnyElement = function(/*Node*/anyElementIn, /*boolean,optional*/forced){
	var promUnitRowNode = this._unitsCanvas.getRowNodeFromAnyElement(anyElementIn);
	if (!promUnitRowNode) return;
	var promUnitRowIndex = this._unitsCanvas.getRowIndex(promUnitRowNode);
	//0.从[代号列表]中按照索引值取待激活的促销代号
	var thPromUnitNo = this._unitList[promUnitRowIndex].unitNo;
	//1.检查[被激活的促销代号]是否有变化
	var realChanged = this._unitsCanvas.checkAndUpdateIfRowSelectionChanged(thPromUnitNo, promUnitRowIndex);
	if (!realChanged) return;
	//2.清空[商品列表]区域和[门店列表]区域；
	this._itemsCanvas.clear();
	this._storesLeftHeadCanvas.clear();
	this._storesRightBodyCanvas.clear();
	//3.为新的[被激活的促销代号]加载[商品列表]并显示；
	var unitItems = this._unit2ItemsMapping[thPromUnitNo];
	if (!unitItems || !unitItems.loaded) return;
	this._itemsCanvas.show(unitItems.data);
	this._itemsCanvas.clickRowByIndex(0);
	//清除[批量促销进价]输入框和[批量促销售价]输入框
	this.clearAllInputTextsAndButtons();
};
/*
 * 激活目标[商品]元素。
 * 处理逻辑：
 * 0.比较[目标商品]元素与[最近一次被激活的商品]元素是否相同；如果相同，则表示是连续点击，不做后续处理（在@forced为False时）。
 * 1.如果不同，则设置[目标商品]为[最近一次被激活的商品]；并同时重新加载该商品下的门店数据到[商品门店列表]显示区域。
 */
PromMgmtHandler.prototype.activateItemByAnyElement = function(/*Node*/anyElementIn, /*boolean,optional*/forced){
	var rowNode = this._itemsCanvas.getRowNodeFromAnyElement(anyElementIn);
	//fixup: 当anyElementIn处于“游离”状态时，rowNode可能为NULL；
	if (!rowNode) return;
	var rowIndex = this._itemsCanvas.getRowIndex(rowNode);
	//1.设置“被选中”样式；
	//this._itemsCanvas.tagSelectedByNode(rowNode);
	this.tagSelectedByIndex(rowIndex);
	//2.取当前被选中商品关联的[促销代号];
	var promUnitNo = this.getCurrentPromUnitNo();
	var unitItems = this._unit2ItemsMapping[promUnitNo];
	//3.检查该笔代号下的[商品列表]是否已被加载；
	if (!unitItems || !unitItems.loaded ){
		//todo.
	}
	var itemNo = unitItems.data[rowIndex].itemNo;
	//4.检测当前被选中的商品是否为"新选中"
	var realChanged = this._itemsCanvas.checkAndUpdateIfRowSelectionChanged(itemNo, rowIndex);
	if (!realChanged && !forced) return;
	//5.清除[门店列表]数据;
	this._storesLeftHeadCanvas.clear();
	this._storesRightBodyCanvas.clear();
	//在切换“商品”时，清除[批量促销进价]输入框和[批量促销售价]输入框
	this.clearAllInputTextsAndButtons();
	//5.执行“指定商品下的门店订购列表加载/显示”例程;
	var currPUIStores = this._item2StroresMapping[itemNo];
	if (!currPUIStores.loaded){
		//todo. 发送AJAX请求，去服务器抓取该商品下的[门店列表]数据
	}
	this._storesLeftHeadCanvas.show(currPUIStores.data);
	this._storesRightBodyCanvas.show(currPUIStores.data, this.buyPriceEditableFlag, this.sellPriceEditableFlag);
	
};
/*
 * 将一笔界面上已存在的促销代号,替换成新输入的促销代号.
 * 处理逻辑如下:
 * 0.移除掉老代号下的所有映射关系;
 * 1.初始化新代号的所有映射关系; 
 */
PromMgmtHandler.prototype.replaceOnePromUnitNodeWithNewVal = function(/*Node*/anyUnitRowMemberNodeIn, /*int*/newPromUnitNoIn){
	//0.取老的促销代号.注意:对于空白的可编辑行，unitNo可为三种值;
	var unitRowIndex = this._unitsCanvas.getRowIndex(anyUnitRowMemberNodeIn);
	var oldUnitRowData = this._unitList[unitRowIndex];
	var oldUnitNo = oldUnitRowData.unitNo;
	//1.将[老促销代号]下挂接的映射关系依次删除
	var oldUnitItems = this._unit2ItemsMapping[oldUnitNo];
	if (oldUnitItems && oldUnitItems.data){
		for (var itemIdx=0;itemIdx<oldUnitItems.data.length;itemIdx++){
			//取得一笔[老促销代号下的商品];
			var oneOldPUItem = oldUnitItems.data[itemIdx];
			//该商品下挂接的门店列表数据清除；
			delete this._item2StroresMapping[oneOldPUItem.itemNo];
		}
	}
	delete this._unit2ItemsMapping[oldUnitNo];
	//2.更新[代号输入框]的内容；
	this._unitsCanvas.setRowMemberNodeValue(anyUnitRowMemberNodeIn, newPromUnitNoIn, 1, 0);
	/*
	 * 3.为[当前促销代号位置]所代表的数据结构设置“新代号”和“新代号的类型”；
	 * 重要备注：这个操作必不可少：在对[新代号]进行任何任何操作之前，必须保证[新代号]已注册在[代号列表]中。
	 */
	var newUnitTypeVal = this._unitsCanvas.getRowMemberNodeValue(anyUnitRowMemberNodeIn, 0, 1);
	var newUnitRowData = this._unitList[unitRowIndex] = {};
	newUnitRowData.unitNo = newPromUnitNoIn;
	newUnitRowData.unitType = newUnitTypeVal;
	//4.初始化新代号的映射关系
	this._doCheckAndForceUnit2ItemsMappingBuilt(newPromUnitNoIn);
};
//删除当前传入的节点元素所在的[促销代号]数据行和下挂元素；不清除当前行.
PromMgmtHandler.prototype.removeOnePromUnitByNode = function(/*Node*/anyRowMemberNodeIn, /*boolean,optional*/removeDataOnlyIn){
	//1.取促销代号.注意:对于空白的可编辑行，unitNo为undefined或者'';
	var currentUnitNo = this.getCurrentPromUnitNo();
	var unitRowIndex = this._unitsCanvas.getRowIndex(anyRowMemberNodeIn);
	var unitRowData = this._unitList[unitRowIndex];
	var unitNo = unitRowData.unitNo;
	//2.清除相关数据
	var unitItems = this._unit2ItemsMapping[unitNo];
	//2-1.清除下挂在当前代号/商品下的门店信息
	if (unitItems && unitItems.data){
		for (var itemIdx=0; itemIdx<unitItems.data.length; itemIdx++){
			var oneItemNo = unitItems.data[itemIdx].itemNo;
			delete this._item2StroresMapping[oneItemNo];
		}
	}
	//2-2.清除“代号与商品”的映射关系
	delete this._unit2ItemsMapping[unitNo];
	//2-3.清除该笔“代号”数据
	this._unitList.splice(unitRowIndex, 1);
	//3.清除门店列表区域的显示信息
	if(currentUnitNo==unitNo){
		this._itemsCanvas.clear();
		this._storesLeftHeadCanvas.clear();
		this._storesRightBodyCanvas.clear();
	}
	//有些操作只需要清除数据，而不删除当前的[促销代号]DOM行
	if (!removeDataOnlyIn){
		this._unitsCanvas.removeOneRowByNode(anyRowMemberNodeIn);
		//?4.重新选择一个ROW
		if(currentUnitNo==unitNo){
			this._unitsCanvas.clickRowByIndex(unitRowIndex);
		}
		
	}
};
/*
 * 删除指定的促销商品.
 * 处理逻辑如下：
 * step-0.获取“商品编号+促销代号”这些关键编号，并作有效性检查；
 * step-1.从“商品--〉门店”的映射关系数据结构中，移除该笔商品下挂接的门店；
 * step-2.从“商品--〉门店”的映射关系数据结构（Client Map）中，移除以该“货号”为Key的Map Entry；
 * step-3.从“代号--〉商品”的映射关系数据结构中（List），移除该“货号”；
 * step-4.从“商品列表”显示区域，取与“被删除的商品DOM元素”相邻的DOM元素，并模拟点击；
 */
PromMgmtHandler.prototype.removeOnePromUnitItemByNode = function(/*Node*/anyRowMemberNodeIn){
	//0.取“促销代号”与“货号”
	var itemRowIndex = this._itemsCanvas.getRowIndex(anyRowMemberNodeIn);
	var currUnitNo = this.getCurrentPromUnitNo();
	var puItemsData = this._unit2ItemsMapping[currUnitNo].data;
	var itemRowData = puItemsData[itemRowIndex];
	var puItemNo = itemRowData.itemNo;
	//2.清除相关数据
	delete this._item2StroresMapping[puItemNo];
	puItemsData.splice(itemRowIndex, 1);
	//3.删除界面元素
	this._itemsCanvas.removeOneRowByIndex(itemRowIndex);
	
	var selectItemNo = this.getCurrentPromUnitItemNo();
	if(puItemNo==selectItemNo){
		//4.模拟点击临近的一笔商品；
		this._storesLeftHeadCanvas.clear();
		this._storesRightBodyCanvas.clear();
		this._itemsCanvas.clickRowByIndex(itemRowIndex);
	}
};
//取当前被选中的[促销代号]
PromMgmtHandler.prototype.getCurrentPromUnitNo = function(/*None*/){
	return this._unitsCanvas.getActivatedRowPK();
};
//取当前被选中的[促销代号类型]
PromMgmtHandler.prototype.getCurrentPromUnitType = function(/*None*/){
	var rowIdx = this._unitsCanvas.getActivatedRowIndex();
	var unitTypeVal = this._unitList[rowIdx].unitType;
	return unitTypeVal;
};
//取当前被选中的[货号]
PromMgmtHandler.prototype.getCurrentPromUnitItemNo = function(/*None*/){
	return this._itemsCanvas.getActivatedRowPK();
};
/*
 * 删除在[商品门店区域]被选中的多个门店.
 */
PromMgmtHandler.prototype.removeMultiPUIStoresByIndex = function(/*Array*/storeIdxsIn){
	//0.取“促销代号”与“货号”
	var currItemNo = this.getCurrentPromUnitItemNo();
	var puiStores = this._item2StroresMapping[currItemNo];
	//2.对传入的被选中[门店索引列表]进行循环，依次删除“门店”数据与“门店”DOM元素
	for (var dIdx=0;dIdx<storeIdxsIn.length;dIdx++){
		var stRowIndex = storeIdxsIn[dIdx];
		var realStRowIndex = stRowIndex - dIdx;
		//2-1.删除“门店”数据
		puiStores.splice(realStRowIndex, 1);
		//2-2.删除“门店”DOM元素(分为左右两个节点)
		this._storesRightBodyCanvas.removeOneRowByIndex(realStRowIndex);
		this._storesLeftHeadCanvas.removeOneRowByIndex(realStRowIndex);
	}
};
/*
 * 更新目标[促销代号行]的内容,包括界面和数据结构
 */
PromMgmtHandler.prototype.updateOnePromUnitRowContent = function(/*Node*/anyRowMemberNodeIn, /*Map*/newPromUnitDataIn){
	//1.取促销代号.注意:对于空白的可编辑行，unitNo为undefined或者'';
	var unitRowIndex = this._unitsCanvas.getRowIndex(anyRowMemberNodeIn);
	var unitRowData = this._unitList[unitRowIndex];
	var newUnitName = newPromUnitDataIn.unitName;
	//更新[内部数据结构体]中的“代号名称”；
	unitRowData.unitName = newUnitName;
	//重要备注：此处禁止对[内部数据结构体]中的“代号类型”进行更新
	if (newPromUnitDataIn.unitType)
		unitRowData.unitType = newPromUnitDataIn.unitType;
	//更新[代号名称]DOM元素的显示内容；
	this._unitsCanvas.setRowMemberNodeValue(anyRowMemberNodeIn, newUnitName, 2);
};

/*
 * 取当前客户端维护的数据，覆盖“促销代号；代号--〉商品的映射表；商品--〉门店的映射表”所有的关联关系。
 *重要备注：默认返回全版本（包含各类型的编号，名称/描述等）的数据；
 *开发者可以根据需要自行裁减（如只返回数据的编号和用户输入的数据等）。
*/
PromMgmtHandler.prototype.getData = function(/*none*/){
	var dataSnapshot = {};
	dataSnapshot.units = this._unitList;
	dataSnapshot.unit2items = this._unit2ItemsMapping;
	dataSnapshot.item2stores = this._item2StroresMapping;
	return dataSnapshot;
};
/*
 * 取当前客户端维护的数据的简化版本。
 * 重要备注：相比较于getData()的实现，本方法只返回“保存需要的数据“，包含：各类编号和价格。
*/
PromMgmtHandler.prototype.getData4SaveOnly = function(/*none*/){
	var dataSnapshot = {};
	//0.获得简化后的[促销代号]版本；
	var allReducedUnits = [];
	var integralUnits = this._unitList;
	for (var a0=0; a0 < integralUnits.length;a0++){
		var oneIntegralUnit = integralUnits[a0];
		var oneReducedUnit = {};
		//对[保存]操作必需要的多个属性进行设置；
		oneReducedUnit.unitType = oneIntegralUnit.unitType;
		oneReducedUnit.unitNo = oneIntegralUnit.unitNo;
		
		allReducedUnits.push(oneReducedUnit);
	}
	dataSnapshot.units = allReducedUnits;
	//1.获得简化后的[代号/商品映射关系定义]版本；
	var allReducedUnitItems = {};
	for (var anyUnitNo in this._unit2ItemsMapping){
		allReducedUnitItems[anyUnitNo] = {};
		var oneReducedUnitItems = allReducedUnitItems[anyUnitNo].data = [];
		var oneIntegralUnitItems = this._unit2ItemsMapping[anyUnitNo].data;
		
		for (var itemIdx=0;itemIdx<oneIntegralUnitItems.length;itemIdx++){
			var oneIntegralUnitItem = oneIntegralUnitItems[itemIdx];
			var oneReducedUnitItem = {};
			oneReducedUnitItem.itemNo = oneIntegralUnitItem.itemNo;
			oneReducedUnitItems.push(oneReducedUnitItem);
		}
	}
	dataSnapshot.unit2items = allReducedUnitItems;
	//2.获得简化后的[商品/门店]的映射关系定义
	var allReducedsItem2Stores = {};
	for (var anyItemNo in this._item2StroresMapping){
		allReducedsItem2Stores[anyItemNo] = {};
		var oneReducedItemStores = allReducedsItem2Stores[anyItemNo].data = [];
		var oneIntegralItemStores = this._item2StroresMapping[anyItemNo].data;
		//对某个商品下的[门店列表]进行循环；
		for (var storeIdx=0;storeIdx<oneIntegralItemStores.length;storeIdx++){
			var oneIntegralStore = oneIntegralItemStores[storeIdx];
			var oneReducedStore = {};
			//对[保存]操作必需要的多个属性进行设置
			oneReducedStore.storeNo = oneIntegralStore.storeNo;
			oneReducedStore.stMainSupNo = oneIntegralStore.stMainSupNo;
			oneReducedStore.normBuyPrice = oneIntegralStore.normBuyPrice;
			oneReducedStore.normSellPrice = oneIntegralStore.normSellPrice;
			oneReducedStore.promBuyPrice = oneIntegralStore.promBuyPrice;
			oneReducedStore.promSellPrice = oneIntegralStore.promSellPrice;			
			//将该笔简化后的[门店]数据压入到			
			oneReducedItemStores.push(oneReducedStore);
		}
	}
	dataSnapshot.item2stores = allReducedsItem2Stores;
	
	return dataSnapshot;
};
//清除所有数据，回复初始状态
PromMgmtHandler.prototype.clear = function(/*none*/){
	//0.依次删除“促销代号；代号--〉商品的映射表；商品--〉门店的映射表”
	this._unitList.splice(0, this._unitList.length);
	for (var unitNoVal in this._unit2ItemsMapping){
		delete this._unit2ItemsMapping[unitNoVal];
	}
	for (var itemNoVal in this._item2StroresMapping){
		delete this._item2StroresMapping[itemNoVal];
	}
	//1.依次清除“促销代号；代号--〉商品；商品--〉门店”这3个区域；
	this._unitsCanvas.clear();
	this._itemsCanvas.clear();
	this._storesLeftHeadCanvas.clear();
	this._storesRightBodyCanvas.clear();
};
//检查是否存在空白的[促销代号];
PromMgmtHandler.prototype.isPromUnitNoDuplicated = function(/*int*/unitNoIn){
	/**option-1.基于内部维护的商品列表，检查传入的货号是否已定义；
		注意：这种线性的检查方式在“商品列表”数量小(数10个)时，效率可以接受.
	**/
	var duplFlag = false;
	for (var unitIndex=0;unitIndex < this._unitList.length; unitIndex++){
		if (this._unitList[unitIndex].unitNo==unitNoIn){
			duplFlag = true;
			break;
		}
	}
	return duplFlag;
};

//检查是否已存在指定的[促销代号]
PromMgmtHandler.prototype.isPromUnitNoAndTypeDuplicated = function(/*int*/unitNoIn,/*int*/unitTypeIn){
	/**option-1.基于内部维护的商品列表，检查传入的货号是否已定义；
		注意：这种线性的检查方式在“商品列表”数量小(数10个)时，效率可以接受.
	**/
	var duplFlag = false;
	for (var unitIndex=0;unitIndex < this._unitList.length; unitIndex++){
		if (this._unitList[unitIndex].unitNo==unitNoIn && this._unitList[unitIndex].unitType==unitTypeIn){
			duplFlag = true;
			break;
		}
	}
	return duplFlag;
};
//<1-1>.更新在“指定代号，指定商品，指定门店”下的[促销进价]
PromMgmtHandler.prototype.doSyncPromBuyPriceAtStore = function(/*Number*/newPromBuyPriceVal, /*Node*/anyRowMemberIn){
	var currItemNo = this.getCurrentPromUnitItemNo();
	var storeRowIndex = this._storesRightBodyCanvas.getRowIndex(anyRowMemberIn);
	
	//检验规则1.促销进价必须<正常进价
	this._doCheckIfStoreItemBuyPriceValidAndSetTxtStyle(currItemNo, storeRowIndex, newPromBuyPriceVal);
	
	this._storesRightBodyCanvas.setRowMemberNodeValue(anyRowMemberIn, newPromBuyPriceVal, 2, 0);
	this._storesRightBodyCanvas.setRowMemberNodeValue(anyRowMemberIn, newPromBuyPriceVal, 3, 0);
	this._doSyncItemStoresNamedProperty("promBuyPrice", newPromBuyPriceVal, anyRowMemberIn);
};
/*
 * 根据输入的促销价格，获取到当前的店铺编号
 */
PromMgmtHandler.prototype.doGetStoreNoByPromPrice = function( /*Node*/anyRowMemberIn){
	var currItemNo = this.getCurrentPromUnitItemNo();
	var storeRowIndex = this._storesRightBodyCanvas.getRowIndex(anyRowMemberIn);
	var thItemStoresDataWrapper = this._item2StroresMapping[currItemNo];
	var thItemStoresData = thItemStoresDataWrapper.data;
	var storeNo = thItemStoresData[storeRowIndex].storeNo; 
	return storeNo;
};
//<1-2>.批量更新在“某代号某商品下的门店列表中的[促销进价]”
PromMgmtHandler.prototype.doBatchSyncPromBuyPriceAtItem = function(/*Number*/newBatchPromBuyPriceVal){
	var currItemNo = this.getCurrentPromUnitItemNo();
	var storesNode = this._storesRightBodyCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		//检验规则1.促销进价必须<正常进价
		this._doCheckIfStoreItemBuyPriceValidAndSetTxtStyle(currItemNo, storeIndex, newBatchPromBuyPriceVal);
		this._storesRightBodyCanvas.setRowMemberNodeValue(oneStoreRowNode, newBatchPromBuyPriceVal, 2, 0, 0);
		this._storesRightBodyCanvas.setRowMemberNodeValue(oneStoreRowNode, newBatchPromBuyPriceVal, 3, 0, 0);
		this._doSyncItemStoresNamedProperty("promBuyPrice", newBatchPromBuyPriceVal, oneStoreRowNode);	
	}
};

//<1-3>.批量更新在“某代号下所有商品下门店列表中的[促销进价]”
PromMgmtHandler.prototype.doBatchSyncPromBuyPriceAtUnit = function(/*Number*/newBatchPromBuyPriceVal){
	//0.先取当前在操作的[促销代号]
	var unitNo = this.getCurrentPromUnitNo();
	//1.对该代号下的“商品/门店列表”数据结构的属性进行更新；
	var unitItems = this._unit2ItemsMapping[unitNo].data;
	for (var itemIdx=0;itemIdx<unitItems.length;itemIdx++){
		var oneItem = unitItems[itemIdx];
		var unitItemStores = this._item2StroresMapping[oneItem.itemNo].data;
		for (var storeIdx=0;storeIdx<unitItemStores.length;storeIdx++){
			var oneItemStore = unitItemStores[storeIdx];
			oneItemStore.promBuyPrice = newBatchPromBuyPriceVal;
		}
	}
	//2.然后对当前页面上可见的[门店列表]区域的界面元素进行更新；(采用在[商品]级别的批量更改接口).
	this.doBatchSyncPromBuyPriceAtItem(newBatchPromBuyPriceVal);
};

//<2-1>.更新在“指定代号，指定商品，指定门店”下的[促销售价]
PromMgmtHandler.prototype.doSyncPromSellPriceAtStore = function(/*Number*/newPromSellPriceVal, /*Node*/anyRowMemberIn){
	//0.获取当前选中的商品编号
	var currItemNo = this.getCurrentPromUnitItemNo();
	//1.获取店铺所在行的编号
	var storeRowIndex = this._storesRightBodyCanvas.getRowIndex(anyRowMemberIn);
	//2.获取netcost值
	var netCostVal = this.getItemStorePropValue(currItemNo, storeRowIndex, "netCost");
	//3.获取税率
	var sellVatVal = this.getItemStorePropValue(currItemNo, storeRowIndex, "sellVat")==null?this.getItemStorePropValue(currItemNo, storeRowIndex, "vatVal"):this.getItemStorePropValue(currItemNo, storeRowIndex, "sellVat");
	//4.获取正常售价
	var normSellPriceVal =this.getItemStorePropValue(currItemNo, storeRowIndex, "normSellPrice");
	//检验规则1：促销售价必须 < =正常售价 * 0.95
	this._doCheckIfStoreItemSellPriceValidAndSetTxtStyle(currItemNo, storeRowIndex, newPromSellPriceVal);
	//5.在页面显示促销售价
	this._storesRightBodyCanvas.setRowMemberNodeValue(anyRowMemberIn, newPromSellPriceVal, 5, 0);
	//6.计算降价幅度和毛利率
	var priceCutVal ="";
	var netMarginVal ="";
	if(newPromSellPriceVal){
		priceCutVal = roundFun ((normSellPriceVal-newPromSellPriceVal)/normSellPriceVal*100,2);
		netMarginVal = roundFun((((Number(newPromSellPriceVal)/( 1 + Number(sellVatVal/100)))-Number(netCostVal))/( Number(newPromSellPriceVal)/( 1 + Number(sellVatVal/100))))*100,2);
	}
	//7.在页面显示降价幅度和毛利率
	this._storesRightBodyCanvas.setRowMemberNodeValue(anyRowMemberIn, priceCutVal, 6, 0,0);
	this._storesRightBodyCanvas.setRowMemberNodeValue(anyRowMemberIn, netMarginVal, 7, 0,0);
	//8.将促销售价保存在页面数组中
	this._doSyncItemStoresNamedProperty("promSellPrice", newPromSellPriceVal, anyRowMemberIn);
	this._doSyncItemStoresNamedProperty("priceCut", priceCutVal, anyRowMemberIn);
	this._doSyncItemStoresNamedProperty("netMargin", netMarginVal, anyRowMemberIn);
};
//<2-2>.批量更新在“某代号某商品下的门店列表中的[促销售价]”
PromMgmtHandler.prototype.doBatchSyncPromSellPriceAtItem = function(/*Number*/newBatchPromSellPriceVal){
	var currItemNo = this.getCurrentPromUnitItemNo();
	var storesNode = this._storesRightBodyCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		//2.获取netcost值
		var netCostVal = this.getItemStorePropValue(currItemNo, storeIndex, "netCost");
		//3.获取税率
		var sellVatVal = this.getItemStorePropValue(currItemNo, storeIndex, "sellVat");
		//4.获取正常售价
		var normSellPriceVal =this.getItemStorePropValue(currItemNo, storeIndex, "normSellPrice");
		
		//检验规则1：促销售价必须 < =正常售价 * 0.95
		this._doCheckIfStoreItemSellPriceValidAndSetTxtStyle(currItemNo, storeIndex, newBatchPromSellPriceVal);
		this._storesRightBodyCanvas.setRowMemberNodeValue(oneStoreRowNode, newBatchPromSellPriceVal, 5, 0, 0);
		
		//6.计算降价幅度和毛利率
		var priceCutVal ="";
		var netMarginVal ="";
		if(newBatchPromSellPriceVal){
			priceCutVal = roundFun ((normSellPriceVal-newBatchPromSellPriceVal)/normSellPriceVal*100,2);
			netMarginVal = roundFun((((Number(newBatchPromSellPriceVal)/( 1 + Number(sellVatVal/100)))-Number(netCostVal))/( Number(newBatchPromSellPriceVal)/( 1 + Number(sellVatVal/100))))*100,2);
		}
		//7.在页面显示降价幅度和毛利率
		this._storesRightBodyCanvas.setRowMemberNodeValue(oneStoreRowNode, priceCutVal, 6, 0,0);
		this._storesRightBodyCanvas.setRowMemberNodeValue(oneStoreRowNode, netMarginVal, 7, 0,0);
		this._doSyncItemStoresNamedProperty("promSellPrice", newBatchPromSellPriceVal, oneStoreRowNode);
		this._doSyncItemStoresNamedProperty("priceCut", priceCutVal, oneStoreRowNode);
		this._doSyncItemStoresNamedProperty("netMargin", netMarginVal, oneStoreRowNode);
	}
};
//<2-3>.批量更新在“某代号下所有商品下门店列表中的[促销售价]”
PromMgmtHandler.prototype.doBatchSyncPromSellPriceAtUnit = function(/*Number*/newBatchPromSellPriceVal){
	//0.先取当前在操作的[促销代号]
	var unitNo = this.getCurrentPromUnitNo();
	//1.对该代号下的“商品/门店列表”数据结构的属性进行更新；
	var unitItems = this._unit2ItemsMapping[unitNo].data;
	for (var itemIdx=0;itemIdx<unitItems.length;itemIdx++){
		var oneItem = unitItems[itemIdx];
		var unitItemStores = this._item2StroresMapping[oneItem.itemNo].data;
		for (var storeIdx=0;storeIdx<unitItemStores.length;storeIdx++){
			var oneItemStore = unitItemStores[storeIdx];
			//todo.检验规则1：促销售价必须 < =正常售价 * 0.95
			//@promSellPrice
			//1.获取netcost值
			var netCostVal = oneItemStore.netCost;
			//2.获取税率
			var sellVatVal = oneItemStore.sellVat;
			//3.获取正常售价
			var normSellPriceVal =oneItemStore.normSellPrice;
		
			//4.计算降价幅度和毛利率
			var priceCutVal ="";
			var netMarginVal ="";
			if(newBatchPromSellPriceVal){
				priceCutVal = roundFun ((normSellPriceVal-newBatchPromSellPriceVal)/normSellPriceVal*100,2);
				netMarginVal = roundFun((((Number(newBatchPromSellPriceVal)/( 1 + Number(sellVatVal/100)))-Number(netCostVal))/( Number(newBatchPromSellPriceVal)/( 1 + Number(sellVatVal/100))))*100,2);
			}
			oneItemStore.priceCut =priceCutVal;
			oneItemStore.netMargin = netMarginVal;
			oneItemStore.promSellPrice = newBatchPromSellPriceVal;
		}
	}
	//2.然后对当前页面上可见的[门店列表]区域的界面元素进行更新；
	this.doBatchSyncPromSellPriceAtItem(newBatchPromSellPriceVal);
};

PromMgmtHandler.prototype._doSyncItemStoresNamedProperty = function(/*String*/propName, /*String*/newPropVal, /*Node*/anyRowMemberIn){
	//1.取当前“门店列表”挂接到的商品PK（包含商品编号）和代号；
	var currItemNo = this.getCurrentPromUnitItemNo();
	//2.根据商品编号，取门店列表的数据结构体；
	var item2stores = this._item2StroresMapping[currItemNo];
	var storeRowIndex = this._storesRightBodyCanvas.getRowIndex(anyRowMemberIn);
	var oneItemStores = (item2stores?item2stores.data:null) || [];
	//3.对门店列表进行循环，更新数据结构体中相应位置(@storeIndex)相应属性的值;
	var oneItemStore = oneItemStores[storeRowIndex];
	oneItemStore[propName] = newPropVal;
};
//同时，对Store级别的多个成员属性设置新值；
PromMgmtHandler.prototype._doSyncItemStoresNamedProperties = function(/*Array*/propNameValues,/*Node*/anyRowMemberIn){
	if (!propNameValues || propNameValues.length <=0) return;
	//1.取当前“门店列表”挂接到的商品PK（包含商品编号）；
	var currItemNo = this._itemsCanvas.getActivatedRowPK();
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
//取传入的某[代号]节点元素所在记录行的指定属性值
PromMgmtHandler.prototype.getUnitRowPropValFromNode = function(/*Node*/anyRowMemberNode, /*String*/propName){
	var unitRowIndex = this._unitsCanvas.getRowIndex(anyRowMemberNode);
	var unitRowData = this._unitList[unitRowIndex];
	return unitRowData[propName];
};
//?取当前商品下已关联的门店号;
PromMgmtHandler.prototype.getStoreNOsOfCurrentItem = function(/*None*/){
	var thItemStoresData = this._getCurrentItemStoresData();
	var storeNOs = [];
	for (var storeIndex=0;storeIndex<thItemStoresData.length;storeIndex++){
		storeNOs.push(thItemStoresData[storeIndex].storeNo);
	}
	return storeNOs;
};
//取当前被选中商品的[门店]数据结构体。注意：请小心操作
PromMgmtHandler.prototype._getCurrentItemStoresData = function(/*None*/){
	var itemNo = this._itemsCanvas.getActivatedRowPK();
	var thItemStoresData = this.itemStoresMapping[itemNo].data;
	return thItemStoresData;
};
//检查对当前的场景是否可以增加更多的门店
PromMgmtHandler.prototype.checkCanAddMoreStores = function(/*None*/){
	var currItemNo = this._itemsCanvas.getActivatedRowPK();
	return currItemNo?true:false;
};
//为当前选中的商品增加更多的门店
PromMgmtHandler.prototype.addNewStores = function(/*Array*/bulkStoresData){
	var currItemNo = this._itemsCanvas.getActivatedRowPK();
	var lastMaxRowIndex = this._storesLeftHeadCanvas.getRowCount() - 1;
	var realNewStoreAdded = false;
	//如果需要执行一些逻辑（比如逐行的检测），则需要对bulkStoresData做循环；否则直接调用批处理函数；
	for (var i=0;i<bulkStoresData.length;i++){
		var newStoreInfo = bulkStoresData[i];
		newStoreInfo.promBuyPrice="";
		newStoreInfo.promSellPrice="";
		newStoreInfo.priceCut ="";
		newStoreInfo.netMargin ="";
		var isStoreDuplicated =false;
		var currItemStoresSnapshotData = this._item2StroresMapping[currItemNo].data;
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
		this._storesLeftHeadCanvas.show([newStoreInfo]);
		this._storesRightBodyCanvas.show([newStoreInfo], this.buyPriceEditableFlag, this.sellPriceEditableFlag);
	}
	//2.默认激活新增加的第一笔.
	var rowIndex2Select = realNewStoreAdded?lastMaxRowIndex+1:lastMaxRowIndex;
	this._storesLeftHeadCanvas.clickRowByIndex(rowIndex2Select);
};

/*
 * 当[促销代号类型]发生变化时,清除原先代号下的所有数据以及界面元素内容
 */
PromMgmtHandler.prototype.resetOnePromUnitToBlank = function(/*Node*/anyRowMemberNodeIn){
	this.replaceOnePromUnitNodeWithNewVal(anyRowMemberNodeIn, "");
	this._unitsCanvas.resetRowContentByNode(anyRowMemberNodeIn);
	//3.清除[商品列表]界面和[门店列表]界面
	this._storesLeftHeadCanvas.clear();
	this._storesRightBodyCanvas.clear();
	this._itemsCanvas.clear();
};
/* 当[促销代号]发生变化时,清除原先代号行的价格文本框
 */
PromMgmtHandler.prototype.resetOnePromUnitPriceToBlank = function(/*Node*/anyRowMemberNodeIn){
	this._unitsCanvas.resetRowPriceByNode(anyRowMemberNodeIn);
}

PromMgmtHandler.prototype.hasMoreUnits = function(/*None*/){
	return this._unitList.length>0;
};

/*
 * 设置新的[促销类型]。
 * 当界面上的2组日期区间中的任意一个日期发生变化时，page上需要调用本方法。
 */
PromMgmtHandler.prototype.changePromType = function(/*int*/newPromTypeVal,/*promIsBegin*/promIsBegin){
	this.promType = newPromTypeVal;
	if(!promIsBegin){
		switch (newPromTypeVal) {
			case 1://1-进-售价促销
				this.buyPriceEditableFlag = true;
				this.sellPriceEditableFlag = true;
				break;
			case 2://2-仅进价促销
				this.buyPriceEditableFlag = true;
				this.sellPriceEditableFlag = false;
				break;
			case 3://3-仅售价促销
				this.buyPriceEditableFlag = false;
				this.sellPriceEditableFlag = true;
				break;
			default://0-初始状态
				this.buyPriceEditableFlag = false;
				this.sellPriceEditableFlag = false;
		}
	}else{
		this.buyPriceEditableFlag = false;
		this.sellPriceEditableFlag = false;
	}
	this.setBuySellPriceStatus();
};

PromMgmtHandler.prototype.setBuySellPriceStatus = function(/*None*/){
	var bpElem = $("#txtChangePromBuyPriceAtItem");
	//设置“促销进价”
	if (this.buyPriceEditableFlag){
		bpElem.removeClass("Black");
		bpElem.attr("readonly",false);
	} else {
		bpElem.addClass("Black");
		bpElem.attr("readonly",true);
	}
	//设置“促销售价”
	var spElem = $("#txtChangePromSellPriceAtItem");
	if (this.sellPriceEditableFlag){
		spElem.removeClass("Black");
		spElem.attr("readonly",false);
	} else {
		spElem.addClass("Black");
		spElem.attr("readonly",true);
	}
};
/*
 * 清除[批量促销进价]输入框和[批量促销售价]输入框;
 * 清除[门店列表]勾选框；
 * 恢复[增加更多门店]和[增加更多商品]2个按钮为可操作状态;
 */
PromMgmtHandler.prototype.clearAllInputTextsAndButtons = function(/*None*/){
	document.getElementById("txtChangePromBuyPriceAtItem").value = '';
	document.getElementById("txtChangePromSellPriceAtItem").value = '';
	document.getElementById("ckbSelectAllStores").checked = false;
	document.getElementById("btnAddMoreStores").disabled = false;
	document.getElementById("btnAddMoreItems").disabled = false;
	
};
/*
 * 取得“指定代号/指定商品”在[目标门店]下的的属性值。
 */
PromMgmtHandler.prototype.getItemStorePropValue = function(/*String*/itemNoIn, /*int*/storeIdxIn, /*String*/propNameIn){
	var stores = this._item2StroresMapping[itemNoIn].data;
	var oneItemStoreInfo = stores[storeIdxIn];
	return oneItemStoreInfo[propNameIn];
};
/*
 * 关于“促销进价”的检验规则
 * 1.促销进价必须<正常进价
 */
PromMgmtHandler.prototype._doCheckIfStoreItemBuyPriceValidAndSetTxtStyle = function(/*int*/itemNoIn, /*int*/storeIdxIn, /*Number*/newPromBuyPriceValIn){
	//0.获取正常进价
	var currNormBuyPrice = this.getItemStorePropValue(itemNoIn, storeIdxIn, "normBuyPrice");
	//1.获取成本时点
	var currBuyWhen = this.getItemStorePropValue(itemNoIn, storeIdxIn, "buyWhen");
	//2.获取买家限制
	var buyPriceLimit = this.getItemStorePropValue(itemNoIn, storeIdxIn, "buyPriceLimit");
	var Message ="";
	var isItemBuyPriceValid = true;
	//3.判断用户输入的促销进价是不是金钱，并且不能超过四位小数
	if(!isMoney4(newPromBuyPriceValIn) /*|| newPromBuyPriceValIn ==""*/){
		Message = "促销进价必须是不能超过四位小数的数字";
		isItemBuyPriceValid = false;
	}else{
		//4.当成本时点等于2时
		if(currBuyWhen == "2"){
			//4-1判断促销进价是不是小于买家限制价格
    		if(buyPriceLimit && (Number(newPromBuyPriceValIn)>Number(buyPriceLimit))){
    			Message = "促销进价不能大于买价限制("+buyPriceLimit+"元)!";
    			isItemBuyPriceValid =false;
    		}
    	}else{//5.当成本时点不等于2时，判断促销进价是不是小于正常进价
  	    	if(Number(newPromBuyPriceValIn) >= Number(currNormBuyPrice)){
				Message = "促销进价必须小于正常进价!";
				isItemBuyPriceValid = false;
			}
    	}
	}
	//var isItemBuyPriceValid = newPromBuyPriceValIn < currNormBuyPrice;
	this._storesRightBodyCanvas.setAnyBuyPriceInputStyle(isItemBuyPriceValid, storeIdxIn,Message);
};
/*
 * 关于“促销售价”的检验规则
 * 1.促销售价必须 < =正常售价 * 0.95
 */
PromMgmtHandler.prototype._doCheckIfStoreItemSellPriceValidAndSetTxtStyle = function(/*int*/itemNoIn, /*int*/storeIdxIn, /*Number*/newPromSellPriceValIn){
	var currNormSellPrice = this.getItemStorePropValue(itemNoIn, storeIdxIn, "normSellPrice");
	var Message = "";
	var isItemSellPriceValid = true;
	if(!isMoney2(newPromSellPriceValIn) /*|| newPromSellPriceValIn==""*/){
		Message = "促销售价必须是不能超过二位小数的数字";
		isItemSellPriceValid = false;
	}else{
		if(Number(newPromSellPriceValIn) > Number(currNormSellPrice) * 0.95){
			Message = "促销售价必须小于等于正常售价*0.95";
			isItemSellPriceValid = false;
		}
	}
	this._storesRightBodyCanvas.setAnySellPriceInputStyle(isItemSellPriceValid, storeIdxIn,Message);
};
/*
 * 资源回收例程
 * 一般在发生“window.onunload”时被调用.
 */
PromMgmtHandler.prototype.destroy = function(/*none*/){
	//0.先将内部数据结构重设为Initial状态，并清除可见的界面部分；
	this.clear();
	//2.将组成当前实例的命名属性依次Detach掉；
	this._unitsCanvas.destroy();
//	this._unitsCanvas = null;
//	delete this._unitsCanvas;
	
	this._itemsCanvas.destroy();
//	this._itemsCanvas = null;
//	delete this._itemsCanvas;
	
	this._storesLeftHeadCanvas.destroy();
//	this._storesLeftHeadCanvas = null;
//	delete this._storesLeftHeadCanvas;
	
	this._storesRightBodyCanvas.destroy();
//	this._storesRightBodyCanvas = null;
//	delete this._storesRightBodyCanvas;
	//删除数据结构
/*
	this._unitList = null;
	delete this._unitList;
	
	this._unit2ItemsMapping = null;
	delete this._unit2ItemsMapping;
	
	this._item2StroresMapping = null;
	delete this._item2StroresMapping;
	*/
	for (var propName in this){
		this[propName] = null;
		delete this[propName];
	}
	
};
/*
 * 选择/取消全部的门店数据项。
 */
PromMgmtHandler.prototype.doSelectAllStoresOrNot = function(/*boolean*/selectedIn){
	var rowCount = this._storesLeftHeadCanvas.getRowCount();
	for (var rowIdx=0;rowIdx<rowCount;rowIdx++){
		var ckbNode = this._storesLeftHeadCanvas.getRowMemberNodeByIndex(rowIdx, 0, 0, 0);
		ckbNode.checked = selectedIn;
	}
};
/*
 * 从当前活动的商品中,将被选中的多笔门店删除。包含界面元素和内部数据结构中的数据项。
 */
PromMgmtHandler.prototype.delStoresFromActivatedItem = function(/*none*/){
	var toDelStoresTag = [];
	//0.取当前[门店列表]挂靠的“商品编号”;
	var attachedItemNo = this._itemsCanvas.getActivatedRowPK();
	var thItemStoresDataWrapper = this._item2StroresMapping[attachedItemNo];
	if (!thItemStoresDataWrapper) return;
	var thItemStoresData = thItemStoresDataWrapper.data;
	if (!thItemStoresData || thItemStoresData.length <=0) return;
	//1.对当前[门店列表]表格进行遍历，
	var storeLeftHeadContainer = this._storesLeftHeadCanvas.getContainerNode();
	var storeRightBodyContainer = this._storesRightBodyCanvas.getContainerNode();
	for (var rowIndex=0;rowIndex<storeLeftHeadContainer.children.length;rowIndex++){
		var oneStoreLeftRowNode = storeLeftHeadContainer.children[rowIndex];
		var oneStoreRightRowNode = storeRightBodyContainer.children[rowIndex];
		
		var ckbStore = this._storesLeftHeadCanvas.getRowMemberNodeByIndex(rowIndex, 0, 0, 0);
		if (!ckbStore.checked) continue;
		//for test only
		var storeNo2del = thItemStoresData[rowIndex].storeNo; 
		toDelStoresTag.push(storeNo2del);
		//从当前商品的门店列表数据中，删除当前选中的这笔
		thItemStoresData.splice(rowIndex, 1);
		//从门店列表HTML区域中，删除当前选中的这笔;
		storeLeftHeadContainer.removeChild(oneStoreLeftRowNode);
		storeRightBodyContainer.removeChild(oneStoreRightRowNode);
		rowIndex--;
	}
	//alert("被删除的门店为：" + toDelStoresTag);
};

/*
 * 获取到当前激活的商品下的选中的storeNo
 */
PromMgmtHandler.prototype.getSelectItemsStoreNo = function(/*none*/){
	var toDelStoresTag = [];
	//0.取当前[门店列表]挂靠的“商品编号”;
	var attachedItemNo = this._itemsCanvas.getActivatedRowPK();
	var thItemStoresDataWrapper = this._item2StroresMapping[attachedItemNo];
	if (!thItemStoresDataWrapper) return;
	var thItemStoresData = thItemStoresDataWrapper.data;
	if (!thItemStoresData || thItemStoresData.length <=0) return;
	var storeLeftHeadContainer = this._storesLeftHeadCanvas.getContainerNode();
	for (var rowIndex=0;rowIndex<storeLeftHeadContainer.children.length;rowIndex++){
		var ckbStore = this._storesLeftHeadCanvas.getRowMemberNodeByIndex(rowIndex, 0, 0, 0);
		if (!ckbStore.checked) continue;
		var storeNo2del = thItemStoresData[rowIndex].storeNo; 
		toDelStoresTag.push(storeNo2del);
	}
	return toDelStoresTag;
};


/*
 * 删除某个商品下的厂商，必须确保该商品下至少有一个门店
 * 1.获取到选中页面上显示的所有的门店信息
 * 2.判断没有被选中的店铺的个数是不是大于0
 */
PromMgmtHandler.prototype.checkIfAnyItemHasAtLeastOneStore = function(/*none*/){
	var isKeepMoreOneStore = false;
	//1.获取到选中页面上显示的所有的门店信息
	var storeLeftHeadContainer = this._storesLeftHeadCanvas.getContainerNode();
	for (var rowIndex=0;rowIndex<storeLeftHeadContainer.children.length;rowIndex++){
		var ckbStore = this._storesLeftHeadCanvas.getRowMemberNodeByIndex(rowIndex, 0, 0, 0);
		if (ckbStore.checked) continue;
		isKeepMoreOneStore = isKeepMoreOneStore +1;
		//2.判断没有被选中的店铺的个数是不是大于0
		if(isKeepMoreOneStore >= 1){
			isKeepMoreOneStore= true;
			break;
		}
	}
	return isKeepMoreOneStore;
};

/*
 * 删除某个代号下的商品，必须确保该代号下至少有一个商品
 * 1.获取页面显示的代号
 * 2.根据该代号获取该代号下所有的商品
 * 3.判断该商品的个数
 */
PromMgmtHandler.prototype.checkIfAnyUnitHasAtLeastOneItem = function(/*none*/){
	var isKeepMoreNoneItemNo = true;
	var currUnitNo = this.getCurrentPromUnitNo();
	var puItemsData = this._unit2ItemsMapping[currUnitNo].data;
	if(puItemsData.length <= 1){
		isKeepMoreNoneItemNo = false;
	}
	return isKeepMoreNoneItemNo;
};

/*
 * 判断当前的checkbox是否全部选中
 */
PromMgmtHandler.prototype.doSelectCheckAllCheckBox = function(/*none*/){
	var selectCheckAllCheckBox = true;
	var storeLeftHeadContainer = this._storesLeftHeadCanvas.getContainerNode();
	for (var rowIndex=0;rowIndex<storeLeftHeadContainer.children.length;rowIndex++){
		var ckbStore = this._storesLeftHeadCanvas.getRowMemberNodeByIndex(rowIndex, 0, 0, 0);
		if (!ckbStore.checked){
			selectCheckAllCheckBox = false;
			break;
		};
	}
	return selectCheckAllCheckBox;
};
/*
 * 判断新增的商品是否已经存在
 * 1.循环获取新增数据的ItemNo
 * 2.根据itemNo查找对象，如果存在则返回
 */
PromMgmtHandler.prototype.doCheckItemNoIsOnlyOne = function(/*Array*/newItemStoresArray,unitType){
	var item2stores = this._item2StroresMapping;
	var itemNoStr="";
	//var num =0;
	if(newItemStoresArray.length > 0){
		for (var itemStoreIndex = 0; itemStoreIndex < newItemStoresArray.length; itemStoreIndex++) {
			var itemNo = newItemStoresArray[itemStoreIndex].itemNo;
			var item2StoreObject = item2stores[itemNo];
			if(item2StoreObject){
				itemNoStr += itemNo+",";
			}/*else{
				num =1;
			}*/
		}
	}
	/*if(unitType !=0 && num ==0){
		itemNoStr=-1;
	}*/
	return itemNoStr;
}
/*
 *根据下标选择商品
 *1.循环所有页面的商品，将他们item_on状态去除
 *2.将当前传进来的下标所对应的商品选中
 */
PromMgmtHandler.prototype.tagSelectedByIndex = function(/*Int*/rowIndex){
	var containerNode = this._itemsCanvas.getContainerNode();
	var rowNode = containerNode.children; 
	for (var rowNodeIndex = 0; rowNodeIndex < rowNode.length; rowNodeIndex++) {
		$(rowNode[rowNodeIndex]).removeClass(this._itemsCanvas.getRowSelectedClassStr());
	}
	$(rowNode[rowIndex]).addClass(this._itemsCanvas.getRowSelectedClassStr());
};	
/*
 * 获取到页面所有的单品
 */ 
PromMgmtHandler.prototype.doGetSingleUnitNo= function(/*Int*/rowIndex){
	var unitList = this._unitList;
	var singleUnitNoJson={};
	var singleUnitNoArray = [];
	for (var unitListIndex = 0; unitListIndex < unitList.length; unitListIndex++) {
		if(unitList[unitListIndex].unitType == "0"&&unitList[unitListIndex].unitNo!=""){
			singleUnitNoArray.push(unitList[unitListIndex].unitNo);
		}
	}
	singleUnitNoJson.singleUnitNo = singleUnitNoArray;
	return singleUnitNoJson;
}

PromMgmtHandler.prototype.calculatePromBuyPrice= function(/*Int*/itemNoIn,/*Int*/storeIdxIn,/*Int*/buyPriceCutRange,/*int*/normBuyPrice,/*Node*/storeBuyPriceCutRangeElem){
	//计算促销进价
	var promBuyPrice = roundFun (Number(normBuyPrice) * (1-Number(buyPriceCutRange/100)),2);
	var stores = this._item2StroresMapping[itemNoIn].data;
	var oneItemStoreInfo = stores[storeIdxIn];
	oneItemStoreInfo.promBuyPrice = promBuyPrice;
	oneItemStoreInfo.buyPriceCutRange = buyPriceCutRange;
	this._storesRightBodyCanvas.setRowMemberNodeValue(storeBuyPriceCutRangeElem, promBuyPrice, 2, 0, 0);
	
}