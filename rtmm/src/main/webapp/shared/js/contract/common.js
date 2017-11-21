//选择厂商
function chooseOfSupplier() {
	openPopupWin(680, 548, "/supplier/contract/common/chooseOfSupplierList");
}
// 确认选择厂商
function confirmSupplierSelected(supInfo) {
	$('.supNo:visible').val(supInfo.supNo);
	$('.supName:visible').val(supInfo.comName);
	$('.unifmNo:visible').val(supInfo.unifmNo);
	$('.dlvryMethd:visible').val(supInfo.dlvryMethd);
	/*
	 * $('.cntrtType:visible').val(supInfo.cntrtType);
	$('.buyMethd:visible').val(supInfo.buyMethd);
	$('.supType:visible').val(supInfo.supType);*/
	$('.supType:visible').val(getDictValue('SUPPLIER_SUP_TYPE',supInfo.supType));
	$('.buyMethd:visible').val(getDictValue('SUPPLIER_BUY_METHD',supInfo.buyMethd));
	$('.cntrtType:visible').val(getDictValue('SUPPLIER_CONTRT_TYPE',supInfo.cntrtType));
}

// 打开选择科目组弹出框
function openAcctGroupWin(obj) {
	if ($(obj).hasClass("Tools11_disable")) {
		return ;
	}
	// 檢查是否在這個頁面已經點過了
	var count = $(obj).val();
	if (count == 0 || count == ""){
		//建立 acctsArray 
		acctsArray = [];
		count ++;
		$(obj).val(count);
	}
	/* revised by Rachel @Feb.6 2015. keep this part temporary 
	//清空数组
	//acctsArray = [];
	*/
	//获取画布区域
	var templTabTermAcctChildren = document.getElementById("templTabTermAcctDiv");
	//判断画布是否存在
	if (templTabTermAcctChildren) {
		var acctChildren = templTabTermAcctChildren.children;
		if (acctChildren.length != 0) {
			for(var acctInd = 0; acctInd < acctChildren.length; acctInd++){
				var acctElem = acctChildren[acctInd];
				var acctMap = {};
				acctMap.grpAcctNo = acctElem.children[2].children[0].value;
				acctMap.grpAcctName = acctElem.children[3].value;
				acctsArray.push(acctMap);
			}
		} else {
			acctsArray = [];
		}
	}
	//获取页签类型
	var tabType = "";
	var tabElem = $("#templTabCodeDiv .item_on").get(0);
	if (tabElem) {
		tabType = tabElem.children[4].value;
	}
	openPopupWin(800, 546, '/supplier/contract/common/openAcctGroupWin?tabType=' + tabType);
}

//选择科目组编号填入表单中
function writeGrpAcctId(){
	var grpAcctArray = [];
	/* revised by Rachel @Feb.6 2015. keep this part temporary 
	var checkedTrs = $("#grpAcctsDiv table :checked").parent().parent();
	$.each(checkedTrs,function(index,obj){
		grpAcctArray.push({'grpAcctId':$(obj.children[1]).text(),'grpAcctAbbr':$(obj.children[5]).text()});
	});
	*/
	if (acctsArray.length != 0){
		$.each(acctsArray,function(index,obj){
			grpAcctArray.push({'grpAcctId':obj.grpAcctId,'grpAcctAbbr':obj.grpAcctAbbr});
		});
	}
	
	if(grpAcctArray.length==0){
		top.jAlert('warning', '请选科目组！', '提示消息');
		return ;
	}
	var grpAcctIds = joinObject(grpAcctArray,'grpAcctId',',');
	var grpAcctAbbrs = joinObject(grpAcctArray,'grpAcctAbbr',',');
	$('#grpAcctIds').attr('value',grpAcctIds);
	$('#grpAcctAbbrs').attr('value',grpAcctAbbrs);
	closePopupWin();
}