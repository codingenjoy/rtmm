/*3.促销代号--〉商品--〉门店列表 区域画布*/
function PromUnitItemStoresSecondCanvas(){
	this.isPickyRowCreation = true;
};
PromUnitItemStoresSecondCanvas.prototype = new RowBasedCanvas("tr");
PromUnitItemStoresSecondCanvas.prototype.getContainerNode = function(){
	var tblRight = document.getElementById('shopBodyTable'); 
	return tblRight.children[0] || tblRight;
};
PromUnitItemStoresSecondCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('oneStoreRightBodyRowTemplate');
	return templateNode.children[0].innerHTML;
};
//返回一行新创建的冻结表头元素，为<tr></tr>
PromUnitItemStoresSecondCanvas.prototype.getPickyRowNodeOnCreation = function(/*None*/){
	var templateNode = document.getElementById('oneStoreRightBodyRowTemplate');
	var oneNewTR = this.getContainerNode().insertRow();
	for (var cellIndex=0;cellIndex<=9;cellIndex++){
		var newCell = oneNewTR.insertCell();
		newCell.innerHTML = templateNode.children[0].children[cellIndex].innerHTML;
	}
	return oneNewTR;
};

PromUnitItemStoresSecondCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn/*maybe the caller push buyWhen here*/){
	//设置各Cell的显示值；
	this.setRowMemberNodeValue(rowNodeIn, (rowDataIn.itemStatus==null?rowDataIn.status:rowDataIn.itemStatus)+"-"+ rowDataIn.itemStatusName, 0, 0, 0);
	//设置  正常进价
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.normBuyPrice, 1, 0, 0);
	//设置  促销进价
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.promBuyPrice, 2, 0, 0);
	//设置  进价降价幅度
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.buyPriceCutRange || '', 3, 0, 0);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.normSellPrice, 4, 0, 0);
	
	//设置“促销售价”
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.promSellPrice, 5, 0, 0);
	//设置“降价幅度”
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.priceCut, 6, 0, 0);
	//设置“净毛利”
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.netMargin, 7, 0, 0);
	
	//显示“主厂商编号”
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.stMainSupNo, 8, 0, 0);
	//显示“主厂商名称”
	this.setRowMemberNodeValue(rowNodeIn, (rowDataIn.stMainSupName==null?rowDataIn.mainComName:rowDataIn.stMainSupName), 9, 0, 0);
	//===========================================检验进价促销====================================================
	//检验1.判断"[促销进价]是否小于[正常进价]" 
	//3.判断用户输入的促销进价是不是金钱，并且不能超过四位小数pricePromType = "2"
	var isItemBuyPriceValid = true;
	var buyPriceMessage ="";
	var stRowIndex = this.getRowIndex(rowNodeIn);
	var promType = rowDataIn.promType==null?rowDataIn.pricePromType:rowDataIn.promType;
	if(promType ==1 || promType ==2){
		if(!isMoney4(rowDataIn.promBuyPrice) || rowDataIn.promBuyPrice==""){
			buyPriceMessage = "促销进价不能为空且必须是不能超过四位小数的数字";
			isItemBuyPriceValid = false;
		}else{
			//4.当成本时点等于2时
			if(rowDataIn.buyWhen == "2"){
				//4-1判断促销进价是不是小于买家限制价格
	    		if(rowDataIn.buyPriceLimit && (Number(rowDataIn.promBuyPrice)>Number(rowDataIn.buyPriceLimit))){
	    			buyPriceMessage = "促销进价不能大于买价限制("+rowDataIn.buyPriceLimit+"元)!";
	    			isItemBuyPriceValid =false;
	    		}
	    	}else{//5.当成本时点不等于2时，判断促销进价是不是小于正常进价
	  	    	if(Number(rowDataIn.promBuyPrice) >= Number(rowDataIn.normBuyPrice)){
					buyPriceMessage = "促销进价必须小于正常进价!";
					isItemBuyPriceValid = false;
				}
	    	}
		}
		
		this.setAnyBuyPriceInputStyle(isItemBuyPriceValid, stRowIndex,buyPriceMessage);
	}
	//===========================================检验售价促销=====================================================
	//检验2.判断"[促销售价]是否小于[正常售价]的0.95倍"
	var isItemSellPriceValid =true;
	var sellPriceMessage ="";
	if(promType ==1 || promType ==3){
		if(!isMoney2(rowDataIn.promSellPrice) || rowDataIn.promSellPrice ==""){
			sellPriceMessage = "促销售价不能为空且必须是不能超过二位小数的数字";
			isItemSellPriceValid = false;
		}else{
			if(Number(rowDataIn.promSellPrice) > Number(rowDataIn.normSellPrice) * 0.95){
				sellPriceMessage = "促销售价必须小于等于正常售价*0.95";
				isItemSellPriceValid = false;
			}
		}
		//var isItemSellPriceValid = rowDataIn.promSellPrice <= rowDataIn.normSellPrice * 0.95;
		this.setAnySellPriceInputStyle(isItemSellPriceValid, stRowIndex,sellPriceMessage);
	}
	//========================================检验该门店是否在其他促销中已经存在========================================
	//检验3，@appendbuy 可以进行进价促销，0可以通过，1代表日期重叠，@appendProm 可以进行售价促销，0代表通过，1代表日期重叠，2代表前七后七重叠
	var isStoreValid = false;
	if(rowDataIn.appendBuy>0 || rowDataIn.appendProm>0){
		isStoreValid = true;
	}
	this.setItemStoreTdStyle(isStoreValid,stRowIndex);
	
};
PromUnitItemStoresSecondCanvas.prototype.getSelectedRowsTag = function(/*None*/){

};
PromUnitItemStoresSecondCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn, /*Array?*/extArgsArray){
	//1.根据[促销类型]设置[促销进价/售价]的可编辑性
	if (!extArgsArray) return;
	//1-1.计算[促销进价]的可编辑性；
	var buyPriceEditable = (extArgsArray.length >=1?extArgsArray[0]:false); 
	if (buyPriceEditable)
		this.setRowMemberEditableByNode(newRowNodeIn, 2, 0, 0);
	else
		this.setRowMemberReadonlyByNode(newRowNodeIn, 2, 0, 0);
	
	//1-2.计算[(进售价)降价幅度]的可编辑性；
	var sellPriceEditable = (extArgsArray.length >=2?extArgsArray[1]:false); 
	if (sellPriceEditable)
		this.setRowMemberEditableByNode(newRowNodeIn, 3, 0, 0);
	else
		this.setRowMemberReadonlyByNode(newRowNodeIn, 3, 0, 0);	
	
	//1-3.计算[促销售价]的可编辑性；
	var sellPriceEditable = (extArgsArray.length >=2?extArgsArray[1]:false); 
	if (sellPriceEditable)
		this.setRowMemberEditableByNode(newRowNodeIn, 5, 0, 0);
	else
		this.setRowMemberReadonlyByNode(newRowNodeIn, 5, 0, 0);	
	
	//1-4.计算[（促销进售价）降价幅度]的可编辑性；
	var sellPriceEditable = (extArgsArray.length >=2?extArgsArray[1]:false); 
	if (sellPriceEditable)
		this.setRowMemberEditableByNode(newRowNodeIn, 6, 0, 0);
	else
		this.setRowMemberReadonlyByNode(newRowNodeIn, 6, 0, 0);	
};
PromUnitItemStoresSecondCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	//return "store_on";
};

PromUnitItemStoresSecondCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "item_on";
};
/*
 * 根据传入的[合法性]标志和[ROW索引]值，设置[目标进价输入框]的样式
 */
PromUnitItemStoresSecondCanvas.prototype.setAnyBuyPriceInputStyle = function(/*boolean*/isInputValid, /*int*/rowIndexIn,/*String*/Message){
	var oneStoreRowNode = this.getContainerNode().children[rowIndexIn];
	if (isInputValid){//重置[促销进价]为正常的编辑状态
		this.clearRowMemberErrorInput(oneStoreRowNode, 2, 0, 0);
	} else {//设置[促销进价]为错误的输入状态
		this.setRowMemberErrorInput(oneStoreRowNode, Message, 2, 0, 0);
	}
};
/*
 * 根据传入的[合法性]标志和[ROW索引]值，设置[目标售价输入框]的样式
 */
PromUnitItemStoresSecondCanvas.prototype.setAnySellPriceInputStyle = function(/*boolean*/isInputValid, /*int*/rowIndexIn,/*String*/Message){
	var oneStoreRowNode = this.getContainerNode().children[rowIndexIn];
	if (isInputValid){//重置[促销进价]为正常的编辑状态
		this.clearRowMemberErrorInput(oneStoreRowNode, 5, 0, 0);
	} else {//设置[促销进价]为错误的输入状态
		this.setRowMemberErrorInput(oneStoreRowNode,Message, 5, 0, 0);
	}
};
PromUnitItemStoresSecondCanvas.prototype.setItemStoreTdStyle =  function(/*boolean*/isInputValid, /*int*/rowIndexIn){
	var oneStoreRowNode = this.getContainerNode().children[rowIndexIn];
	if(isInputValid){//此门店在促销范围内已经参加了其他的促销活动
		$(oneStoreRowNode).addClass("errorDiv");
	}
};


