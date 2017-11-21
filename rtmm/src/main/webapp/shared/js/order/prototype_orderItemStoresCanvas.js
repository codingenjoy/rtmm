/*3.Order-Items-Stores Canvas*/
function OrderItemStoresCanvas(){
	
}
OrderItemStoresCanvas.prototype = new RowBasedCanvas();
OrderItemStoresCanvas.prototype.getContainerNode = function(){
	return document.getElementById('orderItemStoreList');
};
OrderItemStoresCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('orderItemStoreTemplate');
	return templateNode.children[0].innerHTML;
};
OrderItemStoresCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn/*maybe the caller push buyWhen here*/){
	var variantArgs = this.getTruncatedArray(arguments, 2);
	var buyWhenVal = variantArgs && variantArgs.length>0?variantArgs[0]:null;
	var pDivElem = $(rowNodeIn);
	$(pDivElem.children()[0]).val(rowDataIn.storeNo);
	$(pDivElem.children()[1]).val(rowDataIn.storeNo + '-' + rowDataIn.storeName);
	$(pDivElem.children()[2]).val(rowDataIn.itemSttus+'-'+rowDataIn.itemSttusTitle);//商品状态
	$(pDivElem.children()[3]).val(rowDataIn.promNo);// 促销 期数
	$(pDivElem.children()[4]).prop("id",  'ordQty-'+rowDataIn.storeNo);
	$(pDivElem.children()[4]).val(rowDataIn.ordQty);// 订购数量
	$(pDivElem.children()[5]).val(rowDataIn.presOrdQty);// 赠品数量
	
	$(pDivElem.children()[6]).val(rowDataIn.buyPrice);// 买价
	$(pDivElem.children()[6]).prop("title", "买价限制:" + rowDataIn.buyPriceLimit);//@buyPriceLimit,买价限制
	this.setElementEditable(rowNodeIn.children[6], buyWhenVal==2);
	
	
	$(pDivElem.children()[7]).val(rowDataIn.ordMultiParm);// 订购倍数
	$(pDivElem.children()[8]).val(rowDataIn.buyVatVal + "%");// 税率
	$(pDivElem.children()[9]).val(rowDataIn.netCost||0);// 净成本
	$(pDivElem.children()[10]).val(rowDataIn.dms||0);// 均销量
	$(pDivElem.children()[11]).val(rowDataIn.recvbleQty||0);// 在途量
	$(pDivElem.children()[12]).val(rowDataIn.stock||0);// 库存量
};
OrderItemStoresCanvas.prototype.getSelectedRowsTag = function(/*None*/){

};
OrderItemStoresCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	$(newRowNodeIn).addClass('ig_padding');
	newRowNodeIn.setAttribute("onclick", "itemStoreSelected(this)");
};
//移动上一行
OrderItemStoresCanvas.prototype.moveToPreviousRow = function(/*int*/currRowIndexIn,/*int*/currMemberIndexIn){
	if (currRowIndexIn<=0) return;
	var currRowElem = this.getContainerNode().children[currRowIndexIn];
	$(currRowElem).removeClass("store_on");
  var prevRowElem = this.getContainerNode().children[currRowIndexIn-1];
  prevRowElem.children[currMemberIndexIn].focus();
  $(prevRowElem).addClass("store_on");
};
//移动到下一行
OrderItemStoresCanvas.prototype.moveToNextRow = function(/*int*/currRowIndexIn,/*int*/currMemberIndexIn){
	if (currRowIndexIn>=this.getRowCount()-1) return;
	var currRowElem = this.getContainerNode().children[currRowIndexIn];
	$(currRowElem).removeClass("store_on");
	
	  var nextRowElem = this.getContainerNode().children[currRowIndexIn+1];
	  nextRowElem.children[currMemberIndexIn].focus();
	  $(nextRowElem).addClass("store_on");
};
//移动到上一个可编辑的兄弟节点；
OrderItemStoresCanvas.prototype.moveToPreviousSibling = function(/*int*/currRowIndexIn,/*int*/currMemberIndexIn){
	var currRowElem = this.getContainerNode().children[currRowIndexIn];
	  if (currMemberIndexIn == 5 || currMemberIndexIn == 6)
		  currRowElem.children[currMemberIndexIn - 1].focus();
	  else if (currMemberIndexIn == 4)
		  this.moveToPreviousRow(currRowIndexIn, currMemberIndexIn);
};
//移动到下一个可编辑的兄弟节点；
OrderItemStoresCanvas.prototype.moveToNextSibling = function(/*int*/currRowIndexIn,/*int*/currMemberIndexIn){
	var currRowElem = this.getContainerNode().children[currRowIndexIn];
  if (currMemberIndexIn == 4 || currMemberIndexIn == 5)
	  currRowElem.children[currMemberIndexIn + 1].focus();
  else if (currMemberIndexIn == 6)
	  this.moveToNextRow(currRowIndexIn, currMemberIndexIn);
};
OrderItemStoresCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "store_on";
};