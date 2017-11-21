/*3.促销代号--〉商品--〉门店列表 区域画布*/
function PromUnitItemStoresFirstCanvas(){
	this.isPickyRowCreation = true;
};
PromUnitItemStoresFirstCanvas.prototype = new RowBasedCanvas("tr");
PromUnitItemStoresFirstCanvas.prototype.getContainerNode = function(){
	var tblLeft = document.getElementById('shopHeadTable'); 
	return tblLeft.children[0] || tblLeft;
};
PromUnitItemStoresFirstCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('oneStoreLeftHeadRowTemplate');
	return templateNode.innerHTML;
};
PromUnitItemStoresFirstCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn/*maybe the caller push buyWhen here*/){
	var storeVal = rowDataIn.storeNo+"-"+rowDataIn.storeName;
	var isStoreValid = false;
	if(rowDataIn.appendBuy>0 || rowDataIn.appendProm>0){
		isStoreValid = true;
	}
	this.setItemStoreTdStyle(isStoreValid,rowNodeIn,rowDataIn);
	this.setRowMemberNodeValue(rowNodeIn, storeVal, 1, 0, 0);
};
PromUnitItemStoresFirstCanvas.prototype.getSelectedRowsTag = function(/*None*/){

};
PromUnitItemStoresFirstCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	$(newRowNodeIn).addClass('ig_padding');
//	newRowNodeIn.setAttribute("onclick", "itemStoreSelected(this)");
};
PromUnitItemStoresFirstCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	//return "store_on";
};
//返回一行新创建的冻结表头元素，为<tr></tr>
PromUnitItemStoresFirstCanvas.prototype.getPickyRowNodeOnCreation = function(/*None*/){
	var oneNewTR = this.getContainerNode().insertRow();
	var td0 = oneNewTR.insertCell();
	var td1 = oneNewTR.insertCell();
	var templateNode = document.getElementById('oneStoreLeftHeadRowTemplate');
	td0.innerHTML = templateNode.children[0].children[0].innerHTML;
	td1.innerHTML = templateNode.children[0].children[1].innerHTML;
	return oneNewTR;
};
PromUnitItemStoresFirstCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "item_on";
};

PromUnitItemStoresFirstCanvas.prototype.setItemStoreTdStyle =  function(/*boolean*/isInputValid, /*int*/rowIndexIn,/*JSON*/rowDataIn){
	if(isInputValid){//此门店在促销范围内已经参加了其他的促销活动
		$(rowIndexIn).addClass("errorDiv");
		var currRowElem = this.getRowNodeFromAnyElement(rowIndexIn);
		var pseudoTargetElem = currRowElem.children[1].children[0];
		$(pseudoTargetElem).attr("title","该期间内，该商品门店已经在促销期数"+rowDataIn.promNo+"中存在！");
	}
}

function appendShopBodyTable(storeJson,num,unitType,unitNo,catlgId,flag){
	var shopBodyTable = $("#oneShopBodyTable");
		var promBuyPrice;
		var promSellPrice;
		var status;
		var promSupNo;
		var priceCut;
		var netMaori;
		if(storeJson.statusName !=undefined){
			status = storeJson.statusName;
			promBuyPrice = storeJson.promBuyPrice;
			promSellPrice =  storeJson.promSellPrice;
			promSupNo = storeJson.promSupNo;
			priceCut = storeJson.priceCut;
			netMaori =storeJson.netMaori;
		}else{
			status = storeJson.itemStatusName;
			promBuyPrice = "";
			promSellPrice = "";
			priceCut = "";
			netMaori ="";
			promSupNo = storeJson.stMainSupNo;
		}
		
		shopBodyTable.find("input[id='status']").attr("value",storeJson.status+"-"+status);
		shopBodyTable.find("input[id='promSupNo']").attr("value",promSupNo);
		shopBodyTable.find("input[id='promSellPriceBody']").attr("value",promSellPrice);
		shopBodyTable.find("input[id='promBuyPriceBody']").attr("value",promBuyPrice);
		shopBodyTable.find("tr").attr("id",num);
		shopBodyTable.find("input[id='status']").addClass("status").attr("name",storeJson.basicStatus);
		shopBodyTable.find("input[id='normBuyPrice']").attr("value",storeJson.normBuyPrice);
		shopBodyTable.find("input[id='promBuyPriceBody']").addClass("promBuyPriceBody").attr("buyPriceLimit",storeJson.buyPriceLimit).attr("buyWhen",storeJson.buyWhen);
		shopBodyTable.find("input[id='normSellPrice']").addClass("normSellPrice").attr("value",storeJson.normSellPrice);
		shopBodyTable.find("input[id='promSellPriceBody']").addClass("promSellPriceBody");
		shopBodyTable.find("input[id='priceCut']").addClass("priceCut").attr("value",priceCut);
		shopBodyTable.find("input[id='netMaori']").addClass("netMaori").attr("value",netMaori);
		shopBodyTable.find("input[id='netCost']").attr("value",storeJson.netCost);
		shopBodyTable.find("input[id='vat']").attr("value",storeJson.sellVat);
		shopBodyTable.find("input[id='mainComName']").attr("value",storeJson.mainComName);
	$("#shopBodyTable").append(shopBodyTable.html());
	 clearShopBodyTalbe();
	
}
	function appendShopHeadTable(storeJson,num,unitType,unitNo,catlgId){
		var shopHeadTable = $("#oneShopHeadTable");
		shopHeadTable.find("input[id='checkbox']").addClass("isChecksART").attr("deleteId",num).attr("name",storeJson.storeNo).attr("unitTypeVal",unitType).attr("unitNoVal",unitNo).attr("itemNoVal",storeJson.itemNo).attr("colagNoVal",catlgId);
		shopHeadTable.find("input[id='storeInfo']").attr("value",storeJson.storeNo+"-"+storeJson.storeName);
		$("#shopHeadTable").append(shopHeadTable.html());
		if(storeJson.appendBuy==1 || storeJson.appendProm==1 || storeJson.appendProm==2){
			checkHaveOtherStorePromForAll(storeJson.itemNo,storeJson.storeNo);
		}
		
		clearShopHeadTable();
	}

	