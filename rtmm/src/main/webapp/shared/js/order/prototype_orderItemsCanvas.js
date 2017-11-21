/* 2.Order-Items Canvas*/
function OrderItemsCanvas(){
	
}
OrderItemsCanvas.prototype = new RowBasedCanvas();
OrderItemsCanvas.prototype.getContainerNode = function(){
	return document.getElementById('pro_store_tb_edit');
};
OrderItemsCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('orderItemTemplate');
	return templateNode.children[0].innerHTML;
};
OrderItemsCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn){
	var innerDivElem = $(rowNodeIn);
	$(innerDivElem.children()[0]).val(rowDataIn.itemNo);
	$(innerDivElem.children()[1]).val(rowDataIn.itemName);
	if(rowDataIn.sellUnit!=null){
		$(innerDivElem.children()[2]).val(rowDataIn.sellUnit+'-'+rowDataIn.sellUnitTitle);
	}
	if(rowDataIn.buyMethd!=null){
		$(innerDivElem.children()[3]).val(rowDataIn.buyMethd+'-'+rowDataIn.buyMethdTitle);		
	}
	if(rowDataIn.buyWhen!=null){
		$(innerDivElem.children()[4]).val(rowDataIn.buyWhen+'-'+rowDataIn.buyWhenTitle);		
	}
	$(innerDivElem.children()[5]).val(rowDataIn.ordQtyAmnt);
	$(innerDivElem.children()[6]).val(rowDataIn.presOrdQtyAmnt);
	$(innerDivElem.children()[7]).val(rowDataIn.recvBleQtyAmnt);
	$(innerDivElem.children()[8]).val(rowDataIn.stockAmnt);
};
OrderItemsCanvas.prototype.getActivatedRowPK = function(/*None*/){
	return this.rowSelectedTag.pk;
};

OrderItemsCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	$(newRowNodeIn).addClass('item');
	newRowNodeIn.setAttribute("onclick", "itemSelected(this);return false;");
	
};
OrderItemsCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "item_on";
};
OrderItemsCanvas.prototype.onAfterAnyMemberEnterEditable= function(/*Node*/anyNodeIn){
	setTimeout(function(){
		anyNodeIn.focus();
	}, 100);
};