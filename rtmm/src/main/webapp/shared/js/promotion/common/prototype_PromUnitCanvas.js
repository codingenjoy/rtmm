/* 促销代号画布*/
function PromUnitCanvas(){
};
PromUnitCanvas.prototype = new RowBasedCanvas();
PromUnitCanvas.prototype.getContainerNode = function(){
	return document.getElementById('ArtPromoCodeDiv');
};
PromUnitCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('templateOnePromUnit');
	return templateNode.children[0].innerHTML;
};
PromUnitCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn){
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.unitType, 0);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.unitNo, 1, 0);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.unitName || '', 2);
	var promType = rowDataIn.pricePromType; 
	var buybegin = rowDataIn.buyBegin;
	var sellbegin = rowDataIn.sellBegin;
	var promIsBegin = false;
	if(promType ==1 || promType==2){
		 if(buybegin==1){
		 	promIsBegin=true;
		 }
	}
	if(promType ==3){
		if(sellbegin==1){
			promIsBegin=true;
		}
	}
	if(promIsBegin){
		this.setRowMemberReadonlyByNode(rowNodeIn,0);
		this.setRowMemberReadonlyByNode(rowNodeIn,1,0);
		this.setRowMemberReadonlyByNode(rowNodeIn,3);
		this.setRowMemberReadonlyByNode(rowNodeIn,4);
	}
	
};
PromUnitCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn, /*Array ?*/extArgsArray){
	//0.根据模板文件中的定义，设置样式；
	newRowNodeIn.setAttribute("onclick", "doOnPromUnitSelected(this)");
	//$(newRowNodeIn).addClass("item supplerItem clone");
	$(newRowNodeIn).addClass("item");
	//1.设置“切换代号类别”的事件处理函数；
	newRowNodeIn.children[0].setAttribute("onchange", "doOnUnitTypeChanged(this)");
	//2.设置焦点[代号输入框]
	if($("#initOver").val() != 1){
		this.setRowMemberFocusedByNode(newRowNodeIn, 1, 0);
	}
	//3.根据[促销类型]设置[促销进价/售价]的可编辑性
	if (!extArgsArray) return;
	//3-1.计算[促销进价]的可编辑性；
	var buyPriceEditable = (extArgsArray.length >=1?extArgsArray[0]:false); 
	if (buyPriceEditable)
		this.setRowMemberEditableByNode(newRowNodeIn, 3);
	else
		this.setRowMemberReadonlyByNode(newRowNodeIn, 3);
	//3-2.计算[促销售价]的可编辑性；
	var sellPriceEditable = (extArgsArray.length >=2?extArgsArray[1]:false); 
	if (sellPriceEditable)
		this.setRowMemberEditableByNode(newRowNodeIn, 5);
	else
		this.setRowMemberReadonlyByNode(newRowNodeIn, 5);
};
PromUnitCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "item_on";
};
//清除目标代号行上的所有文本框内容（注意：除[促销代号类型]）
PromUnitCanvas.prototype.resetRowContentByNode = function(/*Node*/anyRowMemberNodeIn){
	this.setRowMemberNodeValue(anyRowMemberNodeIn, "", 1, 0);
	this.setRowMemberNodeValue(anyRowMemberNodeIn, "", 2);
	this.setRowMemberNodeValue(anyRowMemberNodeIn, "", 3);
	this.setRowMemberNodeValue(anyRowMemberNodeIn, "", 4);
};
//清除目标代号行上的价格的内容（注意：只包含促销进价，促销售价的text框）
PromUnitCanvas.prototype.resetRowPriceByNode = function(/*Node*/anyRowMemberNodeIn){
	this.setRowMemberNodeValue(anyRowMemberNodeIn, "", 3);
	this.setRowMemberNodeValue(anyRowMemberNodeIn, "", 5);
}
