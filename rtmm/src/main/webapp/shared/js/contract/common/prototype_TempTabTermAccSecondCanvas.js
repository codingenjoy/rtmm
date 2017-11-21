/*3.页签No--〉条款--〉科目列表 区域画布*/
function TempTabTermAccSecondCanvas(){
};
TempTabTermAccSecondCanvas.prototype = new RowBasedCanvas();
TempTabTermAccSecondCanvas.prototype.getContainerNode = function(){
	return document.getElementById('templTabTermAcctDiv');
};
TempTabTermAccSecondCanvas.prototype.getRowTemplateHTMLStr = function(/*none*/){
	var templateNode = document.getElementById('templateOneTabTermAcct');
	return templateNode.children[0].innerHTML;
};
/**
 * 根据传入的单笔【科目】数据，在画布区域上显示。
 * @param {} rowNodeIn
 * @param {} rowDataIn
 */
TempTabTermAccSecondCanvas.prototype.renderRowFromData = function(/*Node*/rowNodeIn, /*JSON*/rowDataIn){
	//科目数据赋值
	var pseudoAcctNo = this.getRowIndex(rowNodeIn)+1;
	this.setRowMemberNodeValue(rowNodeIn, pseudoAcctNo, 1);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.grpAcctNo || '', 2,0);
	this.setRowMemberNodeValue(rowNodeIn, rowDataIn.grpAcctName || '', 3);
};
TempTabTermAccSecondCanvas.prototype.getSelectedRowsTag = function(/*None*/){

};
TempTabTermAccSecondCanvas.prototype.onAfterOneNewRowCreated = function(/*Node*/newRowNodeIn){
	$(newRowNodeIn).addClass("item");
	$(newRowNodeIn).attr("onclick","doOnTempTabTermAcctSelected(this);");
};

TempTabTermAccSecondCanvas.prototype.getRowSelectedClassStr = function(/*none*/){
	return "item";
};
TempTabTermAccSecondCanvas.prototype.getActivatedRowPK = function(/*None*/){
	return this.rowSelectedTag.pk;
};
TempTabTermAccSecondCanvas.prototype.getActivatedRowIndex = function(/*None*/){
	return this.rowSelectedTag.position;
};
/**
 * 获取科目的标识符，（格式：1-0-0）
 * @param {} tabIdIn
 * @param {} currTabTermsSnapshotData
 * @return {}
 */
RowBasedCanvas.prototype.getIndexId = function(/*String*/tabIdIn, /*Array*/currTabTermsSnapshotData){
	var termIdOld = "";
	if (currTabTermsSnapshotData.length > 0) {
		termIdOld = currTabTermsSnapshotData[currTabTermsSnapshotData.length-1].grpAcctId;
		var termIdFirst = termIdOld.substring(0,termIdOld.lastIndexOf('-'));
		var termIdNew = termIdOld.substring(termIdOld.lastIndexOf('-')+1);
		return termIdFirst + "-" + (Number(termIdNew)+1);
	} else {
		return tabIdIn+"-"+0;
	}
};
TempTabTermAccSecondCanvas.prototype.setAttributeCheckBox = function(/*Boolean*/ flag){
	$(this.getContainerNode()).next().get(0).children[0].checked = flag;
};
//获取已存在的科目编号
TempTabTermAccSecondCanvas.prototype.getGrpAcctNos = function(/*Boolean*/flag){
	var grpAcctNoArray = [];
	var currentElem = this.getContainerNode();
	var acctChildrens = currentElem.children;
	for(var i = 0; i < acctChildrens.length; i++){
		var divElem = acctChildrens[i];
		if (flag) {
			if (divElem.children[0].checked) {
				var grpAcctNo = divElem.children[2].children[0].value;
				grpAcctNoArray.push(grpAcctNo);
			}
		} else {
			var grpAcctNo = divElem.children[2].children[0].value;
			grpAcctNoArray.push(grpAcctNo);
		}
	}
	return grpAcctNoArray;
};
//验证是否有科目存在
TempTabTermAccSecondCanvas.prototype.checkChildrenIsNotNull = function(/*Null*/){
	//获取科目总条数
	var acctSum = this.getRowCount();
	//判断科目是否为空
	if (acctSum <= 0) {
		return true;
	} else {
		return false;
	}
};
//新增和删除按钮置灰
TempTabTermAccSecondCanvas.prototype.setButtonPutTheAsh = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	$(nextElem.children[0]).attr("disabled","disabled");
	$(nextElem.children[1]).attr("class", "Icon-size2 Tools10_disable sp_icon2");
	$(nextElem.children[3]).attr("class", "Icon-size2 Tools11_disable sp_icon4");
};
//新增和删除按钮置亮
TempTabTermAccSecondCanvas.prototype.setButtonRearLight = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	$(nextElem.children[0]).removeAttr("disabled");
	$(nextElem.children[1]).attr("class", "Icon-size2 Tools10 sp_icon2");
	$(nextElem.children[3]).attr("class", "Icon-size2 Tools11 sp_icon4");
};
//新增和删除按钮置亮
TempTabTermAccSecondCanvas.prototype.setButtonRearLight = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	$(nextElem.children[0]).removeAttr("disabled");
	$(nextElem.children[1]).attr("class", "Icon-size2 Tools10 sp_icon2");
	$(nextElem.children[3]).attr("class", "Icon-size2 Tools11 sp_icon4");
};
//判断删除按钮
TempTabTermAccSecondCanvas.prototype.checkedDeleButton = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	var deleElem = $(nextElem.children[1]);
	if (deleElem.hasClass("Tools10_disable")) {
		return true;
	} else {
		return false;
	}
};
//判断新增按钮
TempTabTermAccSecondCanvas.prototype.checkedAndButton = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var nextElem = $(containerNode).next().get(0);
	var deleElem = $(nextElem.children[3]);
	if (deleElem.hasClass("Tools11_disable")) {
		return true;
	} else {
		return false;
	}
};
//序号重新赋值
TempTabTermAccSecondCanvas.prototype.toAssignValue = function(/*Null*/){
	var containerNode = this.getContainerNode();
	var containerChildren = containerNode.children;
	for (var index = 0; index < containerChildren.length; index++) {
		var secondChildren = containerChildren[index].children[1];
		secondChildren.value = index + 1;
	}
};