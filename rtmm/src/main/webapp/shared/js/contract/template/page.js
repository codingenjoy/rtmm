/*
 * 本文件定义了在本功能页面上所有DOM元素的事件处理函数.
 */
var pTemplateHandler = new TemplateHandler();
//科目组编号
var acctsArray = [];

//添加页签信息行
function addTabNo(/*Node*/theCurrentElement){
    //TODO validate
	if (checkTabSum()) {
		jWarningAlert('添加页签不能超过8个！');
		return ;
	}
    //调用，增加新
    pTemplateHandler.addOneEmptyTab();
	$("#templTabCodeDiv").scrollTop($("#templTabCodeDiv").scrollTop()+30);
};

//添加条款信息行
function addTabTerm(/*Node*/theCurrentElement){
    //调用，增加新
    pTemplateHandler.addNewTerms2OneTab();
	$("#templTabTermDiv").scrollTop($("#templTabTermDiv").scrollTop()+30);
};

//添加科目信息行
function addTabTermAcct(/*Node*/theCurrentElement){
    //调用，增加新
    pTemplateHandler.addNewAccts2OneTerm();
};
//删除选择的页签以及页签级联的数据
function removeTabs(/*Node*/theCurrentElement){
	pTemplateHandler.removeOneTabByNode(theCurrentElement);
}
//删除选择的模版页签(由用户发起)
function doDeleteTabs(/*Node*/anyPURowMemberNodeIn){
	//验证是否有可删除信息
	if (checkedWhetherDeleteMess(/**/"templTabCodeDiv")) {
		jWarningAlert('请选择要删除的页签！');
		return ;
	}
	pTemplateHandler.removeOneTabByNode(/*Null*/);
};
//删除某个模版页签下的条款(由用户发起)
function doDeleteTabTerms(/*Node*/anyPUIRowMemberNodeIn){
	//验证是否有可删除信息
	if (checkedWhetherDeleteMess(/**/"templTabTermDiv")) {
		jWarningAlert('请选择要删除的条款！');
		return ;
	}
	pTemplateHandler.removeOneTabTermByNode(/*Null*/);
};
//删除某个模版页签/某个条款下被选中的多个科目(由用户发起)
function doDeleteTabTermAccts(/*None*/anyPUIRowMemberNodeIn){
	//验证是否有可删除信息
	if (checkedWhetherDeleteMess(/**/"templTabTermAcctDiv")) {
		jWarningAlert('请选择要删除的科目！');
		return ;
	}
	//to-do.取选中的多个科目编号
	pTemplateHandler.removeOneTabTermAcctByNode(/*Null*/);
};

//页签表单录入数据存放
function doUpdateOneTab(/*Node*/doOneTabElement){
	var valStr = doOneTabElement.value;
	var valIndex = $(doOneTabElement).index();
	if (valIndex == 2) {
		//验证长度
		if (valMaxLength(/*string*/valStr, /*int*/21)) {
			$(doOneTabElement).addClass("errorInput");
			doOneTabElement.value = "";
			$(doOneTabElement).attr("title","限制输入20个字符或10个汉字");
			return ;
		}
	} else if (valIndex == 3) {
		//验证长度
		if (valMaxLength(/*string*/valStr, /*int*/41)) {
			$(doOneTabElement).addClass("errorInput");
			doOneTabElement.value = "";
			$(doOneTabElement).attr("title","限制输入40个字符");
			return ;
		}
	}
	//flag为true是回车事件，
	if (flag) {
		pTemplateHandler._doUpdateOneTabRowContent(/*Node*/doOneTabElement, /*Boolean*/true);
	} else {
		pTemplateHandler._doUpdateOneTabRowContent(/*Node*/doOneTabElement, /*Boolean*/false);
	}
	flag = false;
	//回车下个元素获取光标
	//eventOperation(/*Node*/doOneTabElement);
};
//条款表单录入数据存放
function doUpdateOneTabTerm(/*Node*/doOneTabTermElement){
	var valStr = doOneTabTermElement.value;
	var valIndex = $(doOneTabTermElement).index();
	if (valIndex == 2) {
		//验证长度
		if (valMaxLength(/*string*/valStr, /*int*/21)) {
			$(doOneTabTermElement).addClass("errorInput");
			doOneTabTermElement.value = "";
			$(doOneTabTermElement).attr("title","限制输入20个字符或10个汉字");
			return ;
		}
	} else if (valIndex == 3) {
		//验证长度
		if (valMaxLength(/*string*/valStr, /*int*/41)) {
			$(doOneTabTermElement).addClass("errorInput");
			doOneTabTermElement.value = "";
			$(doOneTabTermElement).attr("title","限制输入40个字符");
			return ;
		}
	} else if (valIndex == 6) {
		//验证长度
		if (valMaxLength(/*string*/valStr, /*int*/3)) {
			$(doOneTabTermElement).addClass("errorInput");
			doOneTabTermElement.value = "";
			$(doOneTabTermElement).attr("title","限制输入2个数字");
			return ;
		}
		//验证数字
		if (isNoNum(/*string*/valStr, /*int*/2)) {
			$(doOneTabTermElement).addClass("errorInput");
			doOneTabTermElement.value = "";
			$(doOneTabTermElement).attr("title","限制输入2个数字");
			return ;
		}
	}
	//flag为true是回车事件，
	if (flag) {
		pTemplateHandler._doUpdateOneTabTermRowContent(/*Node*/doOneTabTermElement, /*Boolean*/true);
	} else {
		pTemplateHandler._doUpdateOneTabTermRowContent(/*Node*/doOneTabTermElement, /*Boolean*/false);
	}
	flag = false;
};
//当目标[模版页签行]被点击后,执行本操作
function doOnPromUnitSelected(/*Node*/anyRowMemberNodeIn){
	pTemplateHandler.activateTabByAnyElement(/*Node*/anyRowMemberNodeIn, /*Boolean*/true);
};
//当目标[条款行]被点击后,执行本操作
function doOnTempTabTermSelected(/*Node*/anyRowMemberNodeIn){
	pTemplateHandler.activateTermByAnyElement(/*Node*/anyRowMemberNodeIn, /*Boolean*/true);
};
//当目标[科目行]被点击后,执行本操作
function doOnTempTabTermAcctSelected(/*Node*/anyRowMemberNodeIn){
	pTemplateHandler.activateTermAcctByAnyElement(/*Node*/anyRowMemberNodeIn, /*Boolean*/true);
};
//键盘回车调入下个input框中
var flag = false;
function eventClick(/*Node*/theCurrentElement){
	 if (event.keyCode == 13){
		 flag = true;
	 }
}
// 保存新增或修改信息
function save() {
	var templateInfo = pTemplateHandler.getData();
	templateInfo.templateNo = $.trim($("#tmplId").val());
	templateInfo.inUseInd = $.trim($("#inUseIndSelect").val());
	//验证信息
	var errorMessArray = checkSaveBefore(/*JSON*/templateInfo);
	if (errorMessArray.length > 0) {
		var errorStr = errorMessArray[0];
		var errorMess = errorStr.substring(1,errorStr.length);
		var tabIndex = errorStr.substring(0,1);
		if (/^\d+$/.test(tabIndex)) {
			//不合法输入表红显示
			pTemplateHandler.showErrorElement(/*String*/tabIndex);
		}
		jWarningAlert(errorMess);
		return ;
	}
	$.ajax({
		type : "post",
		url : ctx + "/supplier/contract/templ/save",
		data : {templateStr : JSON.stringify(templateInfo)},
		success : function(data) {
			if (data.status == "success") {
				jSuccessAlert(data.message);
				openCreatePage();
			} else if (data.status == "error") {
				jErrorAlert(data.message);
			} else {
				jWarningAlert(data.message);
			}
		}
	});
}

// 打开选择支付方式弹出框
function openOfPaymentWin(/*Node*/theCurrentElement) {
	$(theCurrentElement.parentNode.children[0]).removeClass("errorInput");
	//获取支付方式
	var payMethdOptnsStr = "";
	payMethdOptnsStr = pTemplateHandler.getPayMethdOptnsValue(/*Node*/theCurrentElement);
	openPopupWin(405, 275, '/supplier/contract/templ/openOfPaymentWin?payMethdOptnsStr=' + payMethdOptnsStr);
}

//选择的支付方式填入表单中
function writePayMethdOptns(){
	//获取选择的支付方式
	//支付方式全称
	var payMethOpensStr = "";
	//支付方式编号
	var payMethOpens = "";
	$("#payMethOptnsDiv").children().each(function(i, payMeth){
		if (payMeth.children[0].checked){
			payMethOpensStr = payMethOpensStr + payMeth.children[1].innerHTML + ";";
			payMethOpens = payMethOpens + payMeth.children[1].getAttribute("payMethd") + ",";
		}
	});
	if (payMethOpens == "") {
		jWarningAlert('请选择支付方式！');
		return ;
	}
	payMethOpensStr = payMethOpensStr.substring(0,payMethOpensStr.length-1);
	payMethOpens = payMethOpens.substring(0,payMethOpens.length-1);
	//赋值
	pTemplateHandler._doAssignmentPayMethOpens(/*String*/payMethOpens,/*String*/payMethOpensStr);
	//关闭弹出框
	closePopupWin();
}
//选择科目组编号填入表单中
function writeGrpAcctId(){
	//检查条款下的科目是否已经存在
	var acctsList = pTemplateHandler._doCheckGrpAcctNoWhetherExist(/*Array*/acctsArray);
	if (acctsList.length > 0) {
		jWarningAlert('科目组编号：'+acctsList[0].grpAcctNo+'已经存在！');
		return ;
	}
	//关闭弹出框
	closePopupWin();
	//赋值并显示在科目区域上
	pTemplateHandler._doAssignmentGrpAccts(/*Array*/acctsArray);
}
/**
 * 修改数据存放数组里
 * 修改时，根据模版编号查询出所有的信息，分别存放到this._tabList = [],this._tab2TermMapping = {},this._term2AcctsMapping = {}
 */
function packageEditData(/*JSON*/jsonObject){
	pTemplateHandler.packageEditData2Array(/*JSON*/jsonObject);
}
//清除errorInput样式
function inputFocus(/*Node*/currentNode){
	$(currentNode).removeClass("errorInput");
	$(currentNode).attr("title","");
}