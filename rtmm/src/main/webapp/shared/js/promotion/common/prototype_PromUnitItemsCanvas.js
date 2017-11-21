/* 代号下的商品列表区域画布*/
function PromUnitItemsCanvas(){
	
};
PromUnitItemsCanvas.prototype = new RowBasedCanvas();
PromUnitItemsCanvas.prototype.getContainerNode = function(){
	return document.getElementById('promUnitItemsPanel');
};
PromUnitItemsCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('templateOnePromUnitItem');
	return templateNode.children[0].innerHTML;
};
PromUnitItemsCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn){
	rowNodeIn.children[0].innerText = rowDataIn.itemNo + "-" + rowDataIn.itemName;
};
//PromUnitItemsCanvas.prototype.getActivatedRowPK = function(/*None*/){
//	return this.rowSelectedTag.pk;
//};

PromUnitItemsCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	$(newRowNodeIn).addClass('item');
	newRowNodeIn.setAttribute("onclick", "doOnPromUnitItemSelected(this)");
};
PromUnitItemsCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "item_on";
};