/*
 *  本文定义了"所有 类似于[总部进价促销]以及[ART促销]的客户端主控类, 为抽象基类.
 *  [总部进价促销]以及[ART促销]必须扩展当前的主控类.
 *  */
function TemplateHandler(/*optional*/pOrderNoIn, /*optional, boolean*/readonly){
	this.CONST_EMPTY_AnyNO = "n/a";
	//0.存储所有的页签列表
	this._tabList = [];
	/*
	 * 存储所有的“tab--〉Terms List”的映射关系定义,为Key-Value结构。
	 * 其中Key的值为[tabId], Value的值为Map类型，具有如下结构：
	 * 	{
	 * 	loaded: [true|false],
	 *  terms: [Array of ContractTmplTermVO];"根据某个页签序号(@tabId)拿到的条款(terms)列表"
	 * }
	 */
	this._tab2TermMapping = {};
	
	/*
	 * 存储所有的“tab.term--〉Accts List”的映射关系定义,为Key-Value结构。
	 * 其中Key的值为[termId], Value的值为Map类型，具有如下结构：
	 * 	{
	 * 	loaded: [true|false],
	 *  accts: [Array of ContractTmplAcctVO];"根据某个条款(@termId)拿到的科目(Accts)列表"
	 * }
	 */
	this._term2AcctsMapping = {};
	/* [页签NO]列表显示区域*/
	this._tabsCanvas = new TempTabCanvas();
	/* [某页签NO下的条款]列表显示区域*/
	this._termsCanvas = new TempTabTermCanvas();
	/* [某页签NO/条款下的科目]列表显示区域， 冻结表头*/
	//this._storesLeftHeadCanvas = new PromUnitItemStoresFirstfCanvas();
	/* [某页签NO/条款下的科目]列表显示区域， 主体*/
	this._AcctBodyCanvas = new TempTabTermAccSecondCanvas();
	//存放科目信息
	this._AcctsMapping = {};
	
}
//取得[页签区域]的画布元素
TemplateHandler.prototype.getTabsCanvas = function(/*None*/){
	return this._tabsCanvas;
};
//取得[某模版页签下的条款区域]的画布元素
TemplateHandler.prototype.getTermsCanvas = function(/*None*/){
	return this._termsCanvas;
};
//取得[某条款下的科目区域]的画布元素
TemplateHandler.prototype.getAcctsCanvas = function(/*None*/){
	return this._AcctBodyCanvas;
};
//增加一笔空白/待编辑的页签Tab
TemplateHandler.prototype.addOneEmptyTab = function(/*none*/){
 	//TODO 校验
	//step2.伪造一笔tabId为“N/A”的空数据，并执行 batch操作
	var newEmptyTabData = {};
	newEmptyTabData.tabId = this._tabsCanvas.getIndexId();
	newEmptyTabData.tabType = 1;
	//调用“批量增加 页签Tab”的接口，将该笔 [空白页签]加入到内部结构中；
	this.addNewTabs([newEmptyTabData]);
};
//增加一批[模版页签]
TemplateHandler.prototype.addNewTabs = function(/*Array*/bulkTabData){
	var lastMaxRowIndex = this._tabsCanvas.getRowCount() - 1;
	var realNewTabAdded = false;
	//对传入的[页签id]列表进行循环,逐笔加入;
	for (var i=0;i<bulkTabData.length;i++){
		var oneTabInfo = bulkTabData[i];
		var bizPK = oneTabInfo.tabId;
		//1-1.检测当前传入的这笔商品是否已添加；
/*		if (this.isPromUnitNoDuplicated(bizPK)){
			//alert("货号:\n" + oneTabInfo.itemNo + "-" +oneTabInfo.itemName+ "已加入");
			//top.jAlert('warning', "货号:\n" + oneTabInfo.itemNo + "-" +oneTabInfo.itemName+ "已加入",'提示消息');
			continue;
		}*/
		realNewTabAdded = true;
		//1-2.将该笔[促销代号]数据压入混合栈中；
		this._tabList.push(oneTabInfo);
		//1-3.显示该笔[促销代号]的关键参数；
		this._tabsCanvas.show([oneTabInfo]);
		//1-4.初始化当前传入[促销代号]的商品数据存储结构;
		if (bizPK && bizPK !=  this.CONST_EMPTY_AnyNO){
			this._tab2TermMapping[bizPK] = {};
			this._tab2TermMapping[bizPK].data = [];
			this._tab2TermMapping[bizPK].loaded = false;
		}
	}
	//设置多选框为false;
	this._tabsCanvas.setAttributeCheckBox(false);
	//2.默认激活新增加的第一笔.
	var rowIndex2Select = realNewTabAdded?lastMaxRowIndex+1:lastMaxRowIndex;
	this._tabsCanvas.clickRowByIndex(rowIndex2Select);
	//新增和删除置亮
	this._termsCanvas.setButtonRearLight();
};
//为指定的[模版页签]增加[条款]
TemplateHandler.prototype.addNewTerms2OneTab = function(/*Node*/){
	//判断是否可点击
	var whetherClick = this._termsCanvas.checkedAndButton();
	if (whetherClick) {
		return ;
	}
	//判断页签是否为空
	var tabSum = this._tabsCanvas.checkChildrenIsNotNull();
	if (tabSum) {
		return ;
	}
	//获取页签tabId
	var tabIdIn = this._tabsCanvas.rowSelectedTag.pk;
	//页签下的条款数据
	var currTabTermsSnapshotData = this._tab2TermMapping[tabIdIn].data;
	//新建条款对象
	var newTabTermInfo = {};
	//条款Id
	newTabTermInfo.termId = this._termsCanvas.getIndexId(tabIdIn, currTabTermsSnapshotData);
	var newTermId = newTabTermInfo.termId;
/*	var isTabTermDuplicated =false;
	//1-1.检测当前传入的这笔[条款]是否已添加；
	for (var termIndex = 0;termIndex<currTabTermsSnapshotData.length;termIndex++){
		var existedUnitItemInfo = currTabTermsSnapshotData[termIndex];
		if (existedUnitItemInfo.termId == newTermId){
			isTabTermDuplicated = true;
			break;
		}
	}
	if (isTabTermDuplicated) continue;
	realNewTermsAdded = true;
	//获取与[当前条款]关联的[科目列表]数据，并将@terms从[当前条款]的结构中移除；
	var attachedAccts = newTabTermInfo.accts;
	delete newTabTermInfo["terms"];//注意：非常关键
*/	//1-2.将传入的[条款]信息压入到线性结构中;
	currTabTermsSnapshotData.push(newTabTermInfo);
	//1-3.在[条款]区域显示这笔新加入的条款;
	this._termsCanvas.show([newTabTermInfo]);
	//1-4.将这笔[条款]下挂的[科目列表]数据送进内部的数据结构中；
	var newPUIAccts = this._term2AcctsMapping[newTermId] = {}; 
	newPUIAccts.accts = [];
	newPUIAccts.loaded = false;
	//设置[已加载]的标志
	this._tab2TermMapping[tabIdIn].loaded = true;
	//设置多选框为false;
	this._termsCanvas.setAttributeCheckBox(false);
	//条款最后一条数据
	var lastMaxRowIndex = this._termsCanvas.getRowCount();
	//2.默认激活新增加的第一笔.
	//var rowIndex2Select = realNewTermsAdded?lastMaxRowIndex+1:lastMaxRowIndex;
	this._termsCanvas.clickRowByIndex(lastMaxRowIndex);
	//新增和删除置亮
	this._AcctBodyCanvas.setButtonRearLight();
};
//为指定的[条款]增加[科目]
TemplateHandler.prototype.addNewAccts2OneTerm = function(/*Object*/acctObject){
	//判断是否可点击
	var whetherClick = this._AcctBodyCanvas.checkedAndButton();
	if (whetherClick) {
		return ;
	}
	//判断条款是否为空
	var termSum = this._termsCanvas.checkChildrenIsNotNull();
	if (termSum) {
		return ;
	}
	//获取条款termId
	var termIdIn = this.getCurrentTabTermId();
	//获取条款下标
	var termIndex = this.getCurrentTabTermIndex();
	var termNameElem = this._termsCanvas.getRowMemberNodeByIndex(termIndex, 2);
	//条款下的科目数据
	var currTabTermAcctsSnapshotData = this._term2AcctsMapping[termIdIn].accts;
	//科目下标
	var tabIndex = this.getCurrentTabIndex();
	//科目Id
	var grpAcctId = this._AcctBodyCanvas.getIndexId(termIdIn, currTabTermAcctsSnapshotData);
	acctObject.grpAcctId = grpAcctId;
	//1-2.将传入的[科目]信息压入到线性结构中;
	currTabTermAcctsSnapshotData.push(acctObject);
	//获取页签
	var tabNameElem = this._tabsCanvas.getRowMemberNodeByIndex(tabIndex, 2);
	var tabTypeElem = this._tabsCanvas.getRowMemberNodeByIndex(tabIndex, 4);
	var tabMess = this._AcctsMapping[acctObject.grpAcctNo] = {};
	tabMess.tabName = tabNameElem.value;
	tabMess.tabType = tabTypeElem.value;
	tabMess.termName = termNameElem.value;
	tabMess.grpAcctNo = acctObject.grpAcctNo;
	//1-3.在[科目]区域显示这笔新加入的科目;
	this._AcctBodyCanvas.show([acctObject]);
	//设置[已加载]的标志;
	this._term2AcctsMapping[termIdIn].loaded = true;
};
/*
 * 激活目标[模块页签]元素。
 * 处理逻辑：
 * 0.根据传入的[模块页签]成员节点，获取目标[模块页签]元素；
 * 1.比较目标[模块页签]元素与[最近一次被激活的模块页签]元素是否相同；
 * 	--〉
 */
TemplateHandler.prototype.activateTabByAnyElement = function(/*Node*/anyElementIn, /*boolean,optional*/forced){
	var tabRowNode = this._tabsCanvas.getRowNodeFromAnyElement(anyElementIn);
	if (!tabRowNode) return;
	var tabRowIndex = this._tabsCanvas.getRowIndex(tabRowNode);
	//0.从[页签列表]中按照索引值取待激活的模版页签
	var thTabId = this._tabList[tabRowIndex].tabId;
	//1.检查[被激活的模版页签]是否有变化
	var realChanged = this._tabsCanvas.checkAndUpdateIfRowSelectionChanged(thTabId, tabRowIndex);
	if (!realChanged) return;
	//2.清空[条款列表]区域和[科目列表]区域；
	this._termsCanvas.clear();
	//this._storesLeftHeadCanvas.clear();
	this._AcctBodyCanvas.clear();
	//3.为新的[被激活的模块页签]加载[条款列表]并显示；
	var tabTerms = this._tab2TermMapping[thTabId];
	if (!tabTerms || !tabTerms.loaded) {
		this._AcctBodyCanvas.setButtonPutTheAsh();
		return;
	}
	this._termsCanvas.show(tabTerms.data);
	this._termsCanvas.clickRowByIndex(0);
	this._AcctBodyCanvas.setButtonRearLight();
};
/*
 * 激活目标[条款]元素。
 * 处理逻辑：
 * 0.比较[目标条款]元素与[最近一次被激活的条款]元素是否相同；如果相同，则表示是连续点击，不做后续处理（在@forced为False时）。
 * 1.如果不同，则设置[目标条款]为[最近一次被激活的条款]；并同时重新加载该条款下的科目数据到[条款科目列表]显示区域。
 */
TemplateHandler.prototype.activateTermByAnyElement = function(/*Node*/anyElementIn, /*boolean,optional*/forced){
	var termRowNode = this._termsCanvas.getRowNodeFromAnyElement(anyElementIn);
	//fixup: 当anyElementIn处于“游离”状态时，termRowNode可能为NULL；
	if (!termRowNode) return;
	//获取当前DOM的下标
	var rowIndex = this._termsCanvas.getRowIndex(termRowNode);
	//1.设置“被选中”样式；
	this._termsCanvas.tagSelectedByNode(termRowNode);
	//2.取当前被选中条款关联的[模版页签];
	var tabId = this.getCurrentTab();
	//获取页签下的条款data
	var tabTerms = this._tab2TermMapping[tabId];
	//3.检查该笔代号下的[商品列表]是否已被加载；
	if (!tabTerms || !tabTerms.loaded ){
		//todo.
	}
	var termId = tabTerms.data[rowIndex].termId;
	//4.检测当前被选中的条款是否为"新选中"
	var realChanged = this._termsCanvas.checkAndUpdateIfRowSelectionChanged(termId, rowIndex);
	if (!realChanged && !forced) return;
	//5.清除[科目列表]数据;
	this._AcctBodyCanvas.clear();
	//todo：在切换“条款”时，清除哪些栏位？
	//5.执行“指定条款下的科目列表加载/显示”例程;
	var currPUIAccts = this._term2AcctsMapping[termId];
/*	if (!currPUIAccts.loaded){
		//todo. 发送AJAX请求，去服务器抓取该商品下的[门店列表]数据
	}*/
	//this._storesLeftHeadCanvas.show(currPUIAccts.stores);
	this._AcctBodyCanvas.show(currPUIAccts.accts);
};
/*
 * 激活目标[科目]元素。
 */
TemplateHandler.prototype.activateTermAcctByAnyElement = function(/*Node*/anyElementIn, /*boolean,optional*/forced){
	var termRowNode = this._AcctBodyCanvas.getRowNodeFromAnyElement(anyElementIn);
	//fixup: 当anyElementIn处于“游离”状态时，termRowNode可能为NULL；
	if (!termRowNode) return;
	//获取当前DOM的下标
	var rowIndex = this._AcctBodyCanvas.getRowIndex(termRowNode);
	//2.取当前被选中科目关联的[条款];
	var termId = this.getCurrentTabTermId();
	//获取科目下的条款data
	var acctsData = this._term2AcctsMapping[termId];
	var acctId = acctsData.accts[rowIndex].grpAcctId;
	//4.记住已选中的科目
	this._AcctBodyCanvas.checkAndUpdateIfAcctRowSelectionChanged(acctId, rowIndex);

};
/*
 * 将一笔界面上已存在的模版页签,替换成新输入的模版页签.
 * 处理逻辑如下:
 * 0.移除掉老页签下的所有映射关系;
 * 1.初始化新页签的所有映射关系; 
 */
TemplateHandler.prototype.replaceOneTabNodeWithNewVal = function(/*Node*/anyTabRowMemberNodeIn, /*int*/newTabIn){
	//0.取老的模版页签.注意:对于空白的可编辑行，tabId可为三种值;
	var tabRowIndex = this._tabsCanvas.getRowIndex(anyTabRowMemberNodeIn);
	var oldTabRowData = this._tabList[tabRowIndex];
	var oldUnitNo = oldTabRowData.tabId;
	//1.将[老模版页签]下挂接的映射关系依次删除
	var oldTabTerms = this._tab2TermMapping[oldUnitNo];
	if (oldTabTerms && oldTabTerms.data){
		for (var termIdx=0;termIdx<oldTabTerms.data.length;termIdx++){
			//取得一笔[老模版页签下的条款];
			var oneOldPUTerm = oldTabTerms.data[termIdx];
			//该商品下挂接的门店列表数据清除；
			delete this._term2AcctsMapping[oneOldPUTerm.termId];
		}
	}
	delete this._tab2TermMapping[oldUnitNo];
	/*
	 * 2.为[当前模版页签位置]所代表的数据结构设置“新页签”；
	 * 重要备注：这个操作必不可少：在对[新页签]进行任何任何操作之前，必须保证[新页签]已注册在[页签列表]中。
	 */
	var newTabRowData = this._tabList[tabRowIndex] = {};
	newTabRowData.tabId = newTabIn;
	//3.初始化新页签的映射关系
	this._doCheckAndForceTab2TermsMappingBuilt(newTabIn);
};
//删除当前传入的节点元素所在的[模版页签]数据行和下挂元素；不清除当前行.
TemplateHandler.prototype.removeOneTabByNode = function(/*Node*/){
	//判断页签是否为空
	var tabSum = this._tabsCanvas.checkChildrenIsNotNull();
	if (tabSum) {
		return ;
	}
	//0.取模版页签要删除的tabRowIndex[]
	var tabRowIndexs = this._tabsCanvas.getRowsIndex();
	//0-1根据tabRowIdnex删除页签上的DOM行
	this._tabsCanvas.removeMultiRows(tabRowIndexs);
	//1.取模版页签.注意:对于空白的可编辑行，tabId为undefined或者'';
	//按照最大的index一次往前删除，则不会出现找不到指定的下标
	for(var i = tabRowIndexs.length-1; i > -1; i--){
		var tabRowData = this._tabList[tabRowIndexs[i]];
		var tabId = tabRowData.tabId;
		//2.清除相关数据
		var tabTerms = this._tab2TermMapping[tabId].data;
		//2-1.清除下挂在当前页签/条款下的科目信息
		for (var termInd = 0; termInd < tabTerms.length; termInd++){
			var term = tabTerms[termInd];
			//删除验证Map里条款下所属的科目
			this._doDeleteCheckAcctNoMap(/*String*/term.termId);
			delete this._term2AcctsMapping[term.termId];
		}
		//2-2.清除“页签与条款”的映射关系
		delete this._tab2TermMapping[tabId];
		//2-3.清除该笔“页签”数据
		this._tabList.splice(tabRowIndexs[i], 1);
	}
	//序号重新赋值
	this._tabsCanvas.toAssignValue();
	//验证当前被选中的页签是否删除，如果不删除，不做任何操作。
	var flag = this._tabsCanvas.checkCurrentRowWhetherSelected();
	if (flag) return ;
	//清除条款列表区域的显示信息
	this._termsCanvas.clear();
	//清除科目列表区域的显示信息
	this._AcctBodyCanvas.clear();
	//设置多选框为false;
	this._tabsCanvas.setAttributeCheckBox(false);
	//执行最后一行事件
	var tabLastRowIndex =  this._tabsCanvas.getRowCount();
	this._tabsCanvas.clickRowByIndex(tabLastRowIndex);
	//判断页签是否全部删除
	var delAll = this._tabsCanvas.checkChildrenIsNotNull();
	if (delAll) {
		this._termsCanvas.setButtonPutTheAsh();
		this._AcctBodyCanvas.setButtonPutTheAsh();
	}
};
/*
 * 删除指定的页签条款
 */
TemplateHandler.prototype.removeOneTabTermByNode = function(/*Node*/){
	//判断是否可点击
	var whetherClick = this._termsCanvas.checkedDeleButton();
	if (whetherClick) {
		return ;
	}
	//判断条款是否为空
	var termSum = this._termsCanvas.checkChildrenIsNotNull();
	if (termSum) {
		return ;
	}
	//0.取模版页签编号
	var currTabId = this.getCurrentTab();
	//1.取条款下标位置termRowIdnex[]
	var termRowIndex = this._termsCanvas.getRowsIndex();
	//2.取页签下的条款数据
	var puTermsData = this._tab2TermMapping[currTabId].data;
	//3.删除界面元素
	this._termsCanvas.removeMultiRows(termRowIndex);
	//4.删除数据
	//按照最大的index一次往前删除，则不会出现找不到指定的下标
	for(var i = termRowIndex.length-1; i > -1; i--){
		//4.1取某一个条款
		var termRowData = puTermsData[termRowIndex[i]];
		//4.2取条款编号
		var puTermId = termRowData.termId;
		//4.3删除验证Map里条款下所属的科目
		this._doDeleteCheckAcctNoMap(/*String*/puTermId);
		//4.4“条款--〉科目”的映射关系数据结构（Client Map）中，移除以该“条款”为Key的Map Entry；
		delete this._term2AcctsMapping[puTermId];
		//4.5从“页签--〉条款”的映射关系数据结构中（List），移除该“条款”；
		puTermsData.splice(termRowIndex[i], 1);
	}
	//序号重新赋值
	this._termsCanvas.toAssignValue();
	//验证当前被选中的条款是否删除，如果不删除，不做任何操作。
	var flag = this._termsCanvas.checkCurrentRowWhetherSelected();
	if (flag) return ;
	//设置多选框为false;
	this._termsCanvas.setAttributeCheckBox(false);
	//模拟点击临近的一笔商品;
	this._AcctBodyCanvas.clear();
	this._termsCanvas.clickRowByIndex(termRowIndex[termRowIndex.length-1]);
	//判断页签是否全部删除
	var delAll = this._termsCanvas.checkChildrenIsNotNull();
	if (delAll) {
		this._AcctBodyCanvas.setButtonPutTheAsh();
	}
};
/*
 * 删除指定的条款科目
 */
TemplateHandler.prototype.removeOneTabTermAcctByNode = function(/*Node*/){
	//判断是否可点击
	var whetherClick = this._AcctBodyCanvas.checkedDeleButton();
	if (whetherClick) {
		return ;
	}
	//判断科目是否为空
	var acctSum = this._AcctBodyCanvas.checkChildrenIsNotNull();
	if (acctSum) {
		return ;
	}
	//获取科目原有的科目
	var acctOldArray = this._AcctBodyCanvas.getGrpAcctNos(/*Boolean*/true);
	//删除原有的数据
	for(var i = 0; i < acctOldArray.length; i++){
		delete this._AcctsMapping[acctOldArray[i]];
	}
	//0.取条款termId
	var currTermId = this.getCurrentTabTermId();
	//1.取科目的下标位置acctRowIdnex[]
	var acctRowIdnex = this._AcctBodyCanvas.getRowsIndex();
	//2.取条款下的科目accts
	var acctData = this._term2AcctsMapping[currTermId].accts;
	//3.按照最大的index一次往前删除，则不会出现找不到指定的下标
	for (var i = acctRowIdnex.length-1; i > -1; i--){
		//3.1删除“科目”数据
		acctData.splice(acctRowIdnex[i], 1);
	}
	//设置多选框为false;
	this._AcctBodyCanvas.setAttributeCheckBox(false);
	//4.删除界面元素
	this._AcctBodyCanvas.removeMultiRows(acctRowIdnex);
	//序号重新赋值
	this._AcctBodyCanvas.toAssignValue();
};
//取当前被选中的[模版页签]
TemplateHandler.prototype.getCurrentTab = function(/*None*/){
	return this._tabsCanvas.getActivatedRowPK();
};
//取当前被选中的[模版页签]下标
TemplateHandler.prototype.getCurrentTabIndex = function(/*None*/){
	return this._tabsCanvas.getActivatedRowIndex();
};
//取当前被选中的[条款]
TemplateHandler.prototype.getCurrentTabTermId = function(/*None*/){
	//TODO
	return this._termsCanvas.getActivatedRowPK();
};
//取当前被选中的[条款]下标
TemplateHandler.prototype.getCurrentTabTermIndex = function(/*None*/){
	//TODO
	return this._termsCanvas.getActivatedRowIndex();
};
//取当前被选中的[科目]下标
TemplateHandler.prototype.getCurrentTabTermAcctIndex = function(/*None*/){
	//TODO
	return this._AcctBodyCanvas.getActivatedRowIndex();
};
/*
 * 取当前客户端维护的数据，覆盖“模版页签；页签--〉条款的映射表；条款--〉科目的映射表”所有的关联关系。
 * 重要备注：默认返回全版本（包含各类型的编号，名称/描述等）的数据；
 * 开发者可以根据需要自行裁减（如只返回数据的编号和用户输入的数据等）。
*/
TemplateHandler.prototype.getData = function(/*none*/){
	var dataSnapshot = {};
	dataSnapshot.tabs = this._tabList;
	dataSnapshot.tab2terms = this._tab2TermMapping;
	dataSnapshot.term2accts = this._term2AcctsMapping;
	return dataSnapshot;
};

//检查是否已存在指定的[模版页签]
TemplateHandler.prototype.isPromUnitNoDuplicated = function(/*int*/tabIdIn){
	/**option-1.基于内部维护的商品列表，检查传入的货号是否已定义；
		注意：这种线性的检查方式在“商品列表”数量小(数10个)时，效率可以接受.
	**/
	var duplFlag = false;
	for (var tabIndex=0;tabIndex < this._tabList.length; tabIndex++){
		if (this._tabList[tabIndex].tabId==tabIdIn){
			duplFlag = true;
			break;
		}
	}
	return duplFlag;
};
//<1-1>.更新在“指定页签，指定条款，指定科目”下的[科目组编号]
TemplateHandler.prototype.doSyncGrpAcctIdAtStore = function(/*Number*/newGrpAcctIdVal, /*Node*/anyRowMemberIn){
	this._AcctBodyCanvas.setRowMemberNodeValue(anyRowMemberIn, newGrpAcctIdVal, 2, 1);
	this._doSyncTermAcctsNamedProperty("grpAcctId", newGrpAcctIdVal, anyRowMemberIn);
};

//<1-2>.批量更新在“某代号下所有商品下门店列表中的[促销进价]”
/*TemplateHandler.prototype.doBatchSyncPromBuyPriceAtUnit = function(NumbernewBatchPromBuyPriceVal){
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var presOrdQtyElem = oneStoreRowNode.children[5];//oneStoreRowNode.children[0].children[5]; 
		presOrdQtyElem.value = newBatchPresOrdQtyVal;
		this._doSyncNamedStoreProperty("promBuyPrice", newBatchPresOrdQtyVal, presOrdQtyElem);	
	}
};*/
//<1-3>.批量更新在“某代号某商品下的门店列表中的[促销进价]”
/*TemplateHandler.prototype.doBatchSyncPromBuyPriceAtItem = function(NumbernewBatchPromBuyPriceVal){
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var presOrdQtyElem = oneStoreRowNode.children[5];//oneStoreRowNode.children[0].children[5]; 
		presOrdQtyElem.value = newBatchPresOrdQtyVal;
		this._doSyncTermAcctsNamedProperty("grpAcctId", newBatchPresOrdQtyVal, presOrdQtyElem);	
	}
};*/
//<2-1>.更新在“指定代号，指定商品，指定门店”下的[促销售价]
/*TemplateHandler.prototype.doSyncPromSellPriceAtStore = function(NumbernewPromSellPriceVal, NodeanyRowMemberIn){
	var currStoreQrdQtyCalcVal = this._getOrdQtyCalculated(anyRowMemberIn, newOrdQtyVal);
	var rowNode = this.itemStoresCanvas.getRowNodeFromAnyElement(anyRowMemberIn);
	var ordQtyElem = rowNode.children[4]; 
	ordQtyElem.value = currStoreQrdQtyCalcVal;
	this._doSyncNamedStoreProperty("promSellPrice", currStoreQrdQtyCalcVal, anyRowMemberIn);
};*/
//<2-2>.批量更新在“某代号下所有商品下门店列表中的[促销售价]”
/*TemplateHandler.prototype.doBatchSyncPromSellPriceAtUnit = function(NumbernewBatchPromSellPriceVal){
	var storesNode = this.itemStoresCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesNode.children.length;storeIndex++){
		var oneStoreRowNode = storesNode.children[storeIndex];
		var presOrdQtyElem = oneStoreRowNode.children[5];//oneStoreRowNode.children[0].children[5]; 
		presOrdQtyElem.value = newBatchPresOrdQtyVal;
		this._doSyncNamedStoreProperty("promSellPrice", newBatchPresOrdQtyVal, presOrdQtyElem);	
	}
};*/
//<2-3>.批量更新在“某代号某商品下的门店列表中的[促销售价]”
/*TemplateHandler.prototype.doBatchSyncPromSellPriceAtItem = function(NumbernewBatchPromSellPriceVal){
	var storesAreaLeft = this._storesLeftHeadCanvas.getContainerNode();
	var storesAreaRight = this._AcctBodyCanvas.getContainerNode();
	for (var storeIndex =0;storeIndex<storesAreaLeft.children.length;storeIndex++){
		var oneStoreRowNode = storesAreaRight.children[storeIndex];
		//设置界面上[促销售价]文本框的值;
		this._AcctBodyCanvas.setRowMemberNodeValue(oneStoreRowNode, newBatchPresOrdQtyVal, storeIndex, 4, 0);
		
		this._doSyncTermAcctsNamedProperty("promSellPrice", newBatchPresOrdQtyVal, presOrdQtyElem);	
	}
};*/

//同时，对Store级别的多个成员属性设置新值；
/*TemplateHandler.prototype._doSyncItemStoresNamedProperties = function(ArraypropNameValues,NodeanyRowMemberIn){
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
TemplateHandler.prototype.getTabRowPropValFromNode = function(/*Node*/anyRowMemberNode, /*String*/tabId){
	var tabRowIndex = this._tabsCanvas.getRowIndex(anyRowMemberNode);
	var tabRowData = this._tabList[tabRowIndex];
	return tabRowData[tabId];
};
//?取当前条款下已关联的科目;
/*TemplateHandler.prototype.getStoreNOsOfCurrentItem = function(None){
	var thItemStoresData = this._getCurrentItemStoresData();
	var storeNOs = [];
	for (var storeIndex=0;storeIndex<thItemStoresData.length;storeIndex++){
		storeNOs.push(thItemStoresData[storeIndex].storeNo);
	}
	return storeNOs;
};*/
//取当前被选中商品的[门店]数据结构体。注意：请小心操作
/*TemplateHandler.prototype._getCurrentItemStoresData = function(None){
	var termId = this.itemsCanvas.getActivatedRowPK();
	var thItemStoresData = this.itemStoresMapping[termId].data;
	return thItemStoresData;
};*/
//取当前被选中商品的数据结构体。注意：请小心操作
/*TemplateHandler.prototype.getCurrentItemRowData = function(None){
	var selctedItemNo = this.itemsCanvas.getActivatedRowPK();
	var selectedItemData = null;
	for (var rowIndex=0;rowIndex<this.itemsList.length;rowIndex++){
		selectedItemData = this.itemsList[rowIndex];
		if (selectedItemData.termId == selctedItemNo){
			break;
		}
		selectedItemData = null;//Important:重置
	}
	return selectedItemData;
};*/
//检查对当前的场景是否可以增加更多的门店
/*TemplateHandler.prototype.checkCanAddMoreStores = function(None){
	var currTermId = this.itemsCanvas.getActivatedRowPK();
	return currTermId?true:false;
};*/
//为当前选中的商品增加更多的门店
/*TemplateHandler.prototype.addNewStores = function(ArraybulkStoresData){
	var currTermId = this.itemsCanvas.getActivatedRowPK();
	var lastMaxRowIndex = this.itemStoresCanvas.getRowCount() - 1;
	var realNewStoreAdded = false;
	//如果需要执行一些逻辑（比如逐行的检测），则需要对bulkStoresData做循环；否则直接调用批处理函数；
	for (var i=0;i<bulkStoresData.length;i++){
		var newStoreInfo = bulkStoresData[i];
		var isStoreDuplicated =false;
		var currItemStoresSnapshotData = this.itemStoresMapping[currTermId].data;
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
		this.itemStoresCanvas.show([newStoreInfo]);
	}
	//2.默认激活新增加的第一笔.
	var rowIndex2Select = realNewStoreAdded?lastMaxRowIndex+1:lastMaxRowIndex;
	this.itemStoresCanvas.clickRowByIndex(rowIndex2Select);
};*/

//清空批量修改的文本框的值
/*TemplateHandler.prototype.cleanBatchElement = function(){
	document.getElementById("txtBatchChangeOrdQty").value = '';
	document.getElementById("txtBatchChangePresOrdQty").value = '';
	document.getElementById("txtBatchChangeBuyPrice").value='';
};*/
/*
 * 当[模版页签类型]发生变化时,清除原先代号下的所有数据以及界面元素内容
 */
TemplateHandler.prototype.resetOneTabToBlank = function(/*Node*/anyRowMemberNodeIn){
	this.replaceOneTabNodeWithNewVal(anyRowMemberNodeIn, "");
	this._tabsCanvas.resetRowContentByNode(anyRowMemberNodeIn);
	//3.清除[商品列表]界面和[门店列表]界面
	//this._storesLeftHeadCanvas.clear();
	//this._storesLeftHeadCanvas.clear();
	this._termsCanvas.clear();
};
TemplateHandler.prototype.hasMoreUnits = function(/*None*/){
	return this._tabList.length>0;
};
//获取条款的区域
TemplateHandler.prototype.getTermContainerNode = function(/*None*/){
	return this._termsCanvas.getContainerNode();
};
//获取科目的区域
TemplateHandler.prototype.getAcctContainerNode = function(/*None*/){
	return this._AcctBodyCanvas.getContainerNode();
};

//
/**
 * 修改时，查询出所有的数据全部存放数组里，
 * 页面操作数据时，只对数据进行操作。
 * 
 */
TemplateHandler.prototype.packageEditData2Array = function(/*JSON*/jsonObject){
	var tabList = jsonObject.tabList;
	//1以下是封装数据到各个数组里
	for(var tabInd = 0; tabInd < tabList.length; tabInd++){
		//1存放页签到_tabList数组里
		//1-1获取页签对象
		var tabObj = tabList[tabInd];
		//1-2创建新的页签对象
		var tabId = tabObj.tabRankNo;
		var tabNewObj = {};
		tabNewObj.tabId = tabId;		//页签序号
		tabNewObj.tabName = tabObj.tabName;		//页签中文名
		tabNewObj.tabEnName = tabObj.tabEnName;	//页签英文名
		tabNewObj.tabType = tabObj.tabType;		//页签类型
		//1-3页签对象存放到._tabList
		this._tabList.push(tabNewObj);
		//1-4创建一个条款Map，添加一个空的数组data
		var tab2Term = this._tab2TermMapping[tabId] = {};
		tab2Term.data = [];
		tab2Term.loaded = false;
		//显示在页面上
		this._tabsCanvas.show([tabNewObj]);
		// 存放条款到_tab2TermMapping数组里,key是tabId，value为条款数据
		//2获取条款数据
		var termData = tabObj.termList;
		for(var termInd = 0; termInd < termData.length; termInd++){
			//2-1获取条款对象
			var termObj = termData[termInd];
			//2-2创建新的条款对象
			var termId = termObj.termRankNo;
			var termIdIndex = tabId + "-" + termId;
			var termNewObj = {};
			termNewObj.termId = termIdIndex;					//条款序号 注意termId只做标识符操作，不做数据保存。
			termNewObj.termName = termObj.termName;				//条款中文名
			termNewObj.termEnName = termObj.termEnName;			//条款英文名
			termNewObj.payMethdOptns = termObj.payMethdOptns;	//条款支付方式
			termNewObj.payMethOpensStr = this.getpayMethdOptnsAllName(termObj.payMethdOptns);	//条款支付方式
			termNewObj.fixDsplyInd = termObj.fixDsplyInd;		//条款固定条款
			termNewObj.paperPageNo = termObj.paperPageNo;		//条款纸板页数
			//2-3条款对象存放到._tab2TermMapping
			var termArray = tab2Term.data;
			tab2Term.loaded = true;
			termArray.push(termNewObj);
			//2-4创建一个科目Map，添加一个空的数组accts
			var term2Acct = this._term2AcctsMapping[termIdIndex] = {};
			term2Acct.accts = [];
			term2Acct.loaded = false;
			// 存放科目到_term2AcctsMapping数组里,key是termId，value为科目数据
			//3获取科目数据
			var acctData = termObj.acctList;
			for(var acctInd = 0; acctInd < acctData.length; acctInd++){
				//3-1获取科目对象
				var acctObj = acctData[acctInd];
				//3-2创建新的科目对象
				var grpAcctRankNo = termIdIndex + "-" + acctObj.grpAcctRankNo;
				var acctNewObj = {};
				acctNewObj.grpAcctId = grpAcctRankNo;			//科目组序号 注意grpAcctId只做标识符操作，不做数据保存。
				acctNewObj.grpAcctNo = acctObj.grpAcctId;		//科目组编号
				acctNewObj.grpAcctName = acctObj.grpAcctName;	//科目组中文名
				var tabMess = this._AcctsMapping[acctObj.grpAcctId] = {};
				tabMess.tabName = tabNewObj.tabName;
				tabMess.tabType = tabNewObj.tabType;
				tabMess.termName = termNewObj.termName;
				tabMess.grpAcctNo = acctObj.grpAcctId;
				//3-3科目对象存放到._term2AcctsMapping
				var acctArray = term2Acct.accts;
				term2Acct.loaded = true;
				acctArray.push(acctNewObj);
			}
		}
	}
	//默认显示第一条页签
	this._tabsCanvas.clickRowByIndex(0);
	//新增和删除置亮
	this._termsCanvas.setButtonRearLight();
	this._AcctBodyCanvas.setButtonRearLight();
};
//获取支付方式全名
TemplateHandler.prototype.getpayMethdOptnsAllName = function(/*string*/payMethdOptns){
	var payMethOpensStr = "";
	var payMethdOptnsList = payMethdOptns.split(',');
	for(var index = 0; index < payMethdOptnsList.length; index++){
		var code = payMethdOptnsList[index];
		payMethOpensStr = payMethOpensStr + getDictValue("CONTRACT_DETL_PAY_METHD", code, 1) + ";";
	}
	return payMethOpensStr;
};
//更新页签数据
TemplateHandler.prototype._doUpdateOneTabRowContent = function(/*Node*/anyTabRowMemberNodeIn, /*Boolean*/flag){
	//var oneTabRowNode = this._tabsCanvas.getRowNodeFromAnyElement(anyTabRowMemberNodeIn);
	var oneTabRowIdx = this._tabsCanvas.getRowIndex(anyTabRowMemberNodeIn);
	var tabNameElem = this._tabsCanvas.getRowMemberNodeByIndex(oneTabRowIdx, 2);
	var tabEnNameElem = this._tabsCanvas.getRowMemberNodeByIndex(oneTabRowIdx, 3);
	var tabTypeElem = this._tabsCanvas.getRowMemberNodeByIndex(oneTabRowIdx, 4);
	var currTabData = this._tabList[oneTabRowIdx];
	currTabData.tabName = tabNameElem.value;		//页签中文名
	currTabData.tabEnName = tabEnNameElem.value;	//页签英文名
	currTabData.tabType = tabTypeElem.value;		//页签类型
	//获取下一个光标
	if (flag) {
		this._tabsCanvas.getNextCursor(/*Node*/anyTabRowMemberNodeIn);
	}
};
//更新条款数据
TemplateHandler.prototype._doUpdateOneTabTermRowContent = function(/*Node*/anyTermRowMemberNodeIn){
	//1.获取条款的index
	var oneTermRowIdx = this._termsCanvas.getRowIndex(anyTermRowMemberNodeIn);
	var termNameElem = this._termsCanvas.getRowMemberNodeByIndex(oneTermRowIdx, 2);
	var termEnNameElem = this._termsCanvas.getRowMemberNodeByIndex(oneTermRowIdx, 3);
	var termPayMethdOptnsElem = this._termsCanvas.getRowMemberNodeByIndex(oneTermRowIdx, 4);
	var termFixDsplyIndElem = this._termsCanvas.getRowMemberNodeByIndex(oneTermRowIdx, 5);
	var termPaperPageNoElem = this._termsCanvas.getRowMemberNodeByIndex(oneTermRowIdx, 6);
	//2.获取页签的tabId
	var tabId = this.getCurrentTab();
	//3.获取页签下的条款data
	var tabTermData = this._tab2TermMapping[tabId].data[oneTermRowIdx];
	//4.更新[内部数据结构体]中的“条款中文名”;
	tabTermData.termName = termNameElem.value;
	//4.1更新[内部数据结构体]中的“条款英文名”
	tabTermData.termEnName = termEnNameElem.value;
	//4.2更新[内部数据结构体]中的“条款支付方式”
	tabTermData.payMethdOptns = termPayMethdOptnsElem.children[1].value;
	tabTermData.payMethOpensStr = termPayMethdOptnsElem.children[0].value;
	//4.3更新[内部数据结构体]中的“固定条款”
	tabTermData.fixDsplyInd = termFixDsplyIndElem.value;
	//4.4更新[内部数据结构体]中的“纸板页数”
	tabTermData.paperPageNo = termPaperPageNoElem.value;
	//获取下一个光标
	if (flag) {
		this._termsCanvas.getNextCursor(/*Node*/anyTermRowMemberNodeIn);
	}
};
/*
 * 对目标[模版页签]检查：“在内部数据结构中，该页签与条款的映射关系已建立”.
 * 处理逻辑如下：
 * 0.该模版页签是否真实有效，即在页签列表中是否能找到该页签；
 * 1.页签与条款的映射关系是否建立；
 */
TemplateHandler.prototype._doCheckAndForceTab2TermsMappingBuilt = function(/*String*/anyTabIdIn){
	var isTabExist = false;
	for (var tabIdx=0; tabIdx < this._tabList.length;tabIdx++){
		var tabRowData = this._tabList[tabIdx];
		if (tabRowData.tabId == anyTabIdIn){
			isTabExist = true;
			break;
		}
	}
	if (!isTabExist) return false;
	var tabTermsData = this._tab2TermMapping[anyTabIdIn];
	if (!tabTermsData){
		tabTermsData = this._tab2TermMapping[anyTabIdIn] = {};
		tabTermsData.data = [];
		tabTermsData.loaded = false;
	}
	if (!tabTermsData.data)
		tabTermsData.data = [];
	return true;
};
TemplateHandler.prototype._doSyncTermAcctsNamedProperty = function(/*String*/propName, /*String*/newPropVal, /*Node*/anyRowMemberIn){
	//1.取当前“门店列表”挂接到的商品PK（包含商品编号）和代号；
	var currTermId = this.getCurrentTabTermId();
	//2.根据商品编号，取门店列表的数据结构体；
	var item2stores = this._term2AcctsMapping[currTermId];
	var oneItemStores = (item2stores?item2stores.data:null) || [];
	//3.对门店列表进行循环，更新数据结构体中相应位置(@storeIndex)相应属性的值;
	for (var storeIdx=0;storeIdx<oneItemStores.length;storeIdx++){
		var oneItemStore = oneItemStores[storeIdx];
		oneItemStore[propName] = newPropVal;
	}
};
//获取选择支付方式
TemplateHandler.prototype.getPayMethdOptnsValue = function(/*Node*/theCurrentElement){
	var payMethdOptns = $.trim($(theCurrentElement).prev().val());
	return payMethdOptns;
};
//选择支付方式弹出框，点击确认赋值
TemplateHandler.prototype._doAssignmentPayMethOpens = function(/*string*/payMethdOptns, /*string*/payMethOptnsStr){
	//1.获取条款的index
	var oneTermRowIdx = this.getCurrentTabTermIndex();
	var termPayMethdOptnsElem = this._termsCanvas.getRowMemberNodeByIndex(oneTermRowIdx, 4);
	//2.获取页签的tabId
	var tabId = this.getCurrentTab();
	//3.获取页签下的条款data
	var tabTermData = this._tab2TermMapping[tabId].data[oneTermRowIdx];
	//赋值到页面上
	termPayMethdOptnsElem.children[1].value = payMethdOptns;
	termPayMethdOptnsElem.children[0].value = payMethOptnsStr;
	termPayMethdOptnsElem.children[0].setAttribute("title",payMethOptnsStr);
	//5更新[内部数据结构体]中的“条款支付方式”
	tabTermData.payMethdOptns = payMethdOptns;
	tabTermData.payMethOpensStr = payMethOptnsStr;
};
//选择科目组弹出框，点击确认赋值
TemplateHandler.prototype._doAssignmentGrpAccts = function(/*Array*/grpAcctsArray){
	//获取条款id
	var termId = this.getCurrentTabTermId();
	var acctArray = this._term2AcctsMapping[termId];
	acctArray.accts = [];
	//获取科目原有的科目
	var acctOldArray = this._AcctBodyCanvas.getGrpAcctNos(/*Boolean*/false);
	//删除原有的数据
	for(var i = 0; i < acctOldArray.length; i++){
		delete this._AcctsMapping[acctOldArray[i]];
	}
	//设置多选框为false;
	this._AcctBodyCanvas.setAttributeCheckBox(false);
	//清空画布所有元素
	this._AcctBodyCanvas.clear();
	//赋值到._term2AcctsMapping
	for(var index = 0; index < grpAcctsArray.length; index++){
		//获取一条科目组对象
		var acctObj = grpAcctsArray[index];
		//更新到._term2AcctsMapping,并显示到科目区域画布中
		this.addNewAccts2OneTerm(/*Object*/acctObj);
	}
};
//验证选择科目组弹出框
TemplateHandler.prototype._doCheckGrpAcctNoWhetherExist = function(/*Array*/grpAcctsArray){
	//获取条款id
	var termId = this.getCurrentTabTermId();
	//获取条款的科目数据
	var acctArray = this._term2AcctsMapping[termId].accts;
	//存放已存在的科目信息
	var acctsArray = [];
	for(var index = 0; index < grpAcctsArray.length; index++){
		//获取一条科目组对象
		var acctObj = grpAcctsArray[index];
		var flag = false;
		//跳过已有的科目
		for (var acctInd = 0; acctInd < acctArray.length; acctInd++) {
			var grpAcctObj = acctArray[acctInd];
			if (grpAcctObj.grpAcctNo == acctObj.grpAcctNo) {
				flag = true;
				break ;
			}
		}
		if (flag) {
			continue ;
		}
		var acctNo = this._AcctsMapping[acctObj.grpAcctNo];
		if (acctNo) {
			acctsArray.push(acctNo);
			continue;
		}
	}
	return acctsArray;
};
//保存验证信息
TemplateHandler.prototype.checkSaveMessage = function(/*Array*/grpAcctsArray){
	
};
//删除验证Map里条款下所属的科目
TemplateHandler.prototype._doDeleteCheckAcctNoMap = function(/*String*/puTermId){
	var acctArray = this._term2AcctsMapping[puTermId].accts;
	for (var acctInd = 0; acctInd < acctArray.length; acctInd++) {
		var acctObj = acctArray[acctInd];
		delete this._AcctsMapping[acctObj.grpAcctNo];
	}
};
//错误的数标红显示
TemplateHandler.prototype.showErrorElement = function(/*String*/tabIndex){
	this._tabsCanvas.clickRowByIndex(tabIndex-1);
	//页签标红
	var oneTabRowIdx = this.getCurrentTabIndex();
	var tabNameElem = this._tabsCanvas.getRowMemberNodeByIndex(oneTabRowIdx, 2);
	this._tabsCanvas.errorElementFlag(/*Node*/tabNameElem);
	//条款标红
	this._termsCanvas.errorElementFlag();
	
};