/*
 * 本文件定义了在本功能页面上所有的校验逻辑.
 */

//验证主题，可别信息
function checkSubjName(){
	var subjName = $("#subjName").val();
 	$("#subjName").removeClass('errorInput');
    $("#subjName").attr("title",'');
 	if($.trim(subjName)==''){
 		$("#subjName").addClass('errorInput');
        $("#subjName").attr("title",'请输入主题!');
 	}else if(charLen($.trim(subjName))>30){
 		$("#subjName").addClass('errorInput');
 		$("#subjName").attr("title",'主题不能超过30个字节!');
		}
}
//计算字符串的字节数
function charLen(s) {
    	var l = 0;
    	var a = s.split("");
    	for (var i=0;i<a.length;i++)
    	{
    		if (a[i].charCodeAt(0)<299) {
    			l++;
    			} 
    		else {
    			l+=2;
    			}
    	}
    	return l;
};

//判断代号是不是都为空
function checkUnitListIsEmpty(){
	var falg = true;
	$("input[name=unitNo]").each(function(){
		if($(this).val() !=""){
			falg = false;
			return;
		}
	});
	return falg;
}
//验证input是否为数字
/**
 * param digit 限制位数
 */
function isNoNum(/*string*/val, /*int*/digit){
	var reg = new RegExp("^[0-9]{1,"+digit+"}(\.?[0-9]{0,4})$");
	if (reg.test(val)) {
		return false;
	} else {
		return true;
	}
}
//显示input长度
/**
 * param val 字符串
 * param length
 */
function valMaxLength(/*string*/val, /*int*/length){
	var valCode = 0;
	if (!$.trim(val)) {
		return false;
	}
	for(var i=0;i<val.length;i++){
	    var strCode = val.charCodeAt(i);
	    if(strCode > 255){
	    	valCode += 2;
	    }else{
	    	valCode +=1;
	    }
	}
	if (valCode < length) {
		return false;
	} else {
		return true;
	}
}
//验证新增页签是否超过8过
function checkTabSum(){
	var templTabCodeDiv = $("#templTabCodeDiv").children();
	if (templTabCodeDiv.length > 7) {
		return true;
	} else {
		return false;
	}
}
//验证是否有可删除的信息
function checkedWhetherDeleteMess(/*String*/divStr){
	var flag = true;
	var templChildre = $("#"+divStr).children();
	for (var index = 0; index < templChildre.length; index++) {
		var firstChildren = templChildre[index].children[0];
		if (firstChildren.checked) {
			flag = false;
			break ;
		}
	}
	return flag;
}

/** 验证输入整数值 */
function checkInputValueIntNum(obj) {
	if ($(obj).val()!=''&&!(/^\d{1,10}$/).test($(obj).val())) {
		if($.trim($(obj).val()) == ''){
			$(obj).val('');
			return false;
		}
		if($.trim($(obj).val()) != ''){
			$(obj).val($(obj).attr('preval'));
		}
		return true;
	}
	$(obj).attr('preval',$(obj).val());
}

/** 验证输入小数值 */
function checkInputValueDoubleNum(obj) {
	if ($(obj).val()!=''&&!(/^\d{0,10}\.?\d{0,2}$/).test($(obj).val())) {
		if($.trim($(obj).val()) == ''){
			$(obj).val('');
			return false;
		}
		if($.trim($(obj).val()) != ''){
			$(obj).val($(obj).attr('preval'));
		}
		return true;
	}
	$(obj).attr('preval',$(obj).val());
}
//验证保留计划信息
function checkRpPlan(planInfo){
	var errorObj = {};
	var flag = false;
	//课别验证
	if (!planInfo.catlgId) {
		$("#crCatlgId").addClass("errorInput");
		$("#crCatlgId").attr("title", '课别不能为空');
		flag = true;
	}
	if ($(".cks").get(0).checked) {
		//门店确认时间验证
		if (!planInfo.stCnfrmBeginDate) {
			$("#crStCnfrmBeginDate").addClass("errorInput");
			$("#crStCnfrmBeginDate").attr("title", '门店确认期间开始日不能为空');
			flag = true;
		}
		if (!planInfo.stCnfrmEndDate) {
			$("#crStCnfrmEndDate").addClass("errorInput");
			$("#crStCnfrmEndDate").attr("title", '门店确认期间结束日不能为空');
			flag = true;
		}
	}
	//门店补货日期验证
	if (!planInfo.stRepBeginDate) {
		$("#crStRepBeginDate").addClass("errorInput");
		$("#crStRepBeginDate").attr("title", '门店补货期间开始日不能为空');
		flag = true;
	}
	/*
	if (!planInfo.stRepEndDate) {
		$("#crStRepEndDate").addClass("errorInput");
		$("#crStRepEndDate").attr("title", '门店补货期间结束日不能为空');
		flag = true;
	}*/
	//物流中心验证
	if (!planInfo.dcStoreNo) {
		$("#crDcStoreNo").addClass("errorInput");
		$("#crDcStoreNo").attr("title", '物流中心不能为空');
		flag = true;
	}
	//商品验证
	//存放门店建议量为空的门店
	var errorStore = "";
	var stores = "";
	var items = planInfo.items;
	if (planInfo.rpNo) {
		if (!items) {
			errorObj.flag = flag;
			return errorObj;
		}
	}

	for(var ind = 0; ind < items.length; ind++){
		var itemObj = items[ind];
		if (!itemObj.itemNo) {
			flag = true;
			jWarningAlert('商品不能为空！');
			break;
		}
		//验证商品下的门店是否为空
		if (!planInfo.item2store[itemObj.itemNo]) {
			flag = true;
			jWarningAlert('货号['+itemObj.itemNo+']下的门店不能为空！');
			break;
		}
		var storeArray = planInfo.item2store[itemObj.itemNo].data;
		if (storeArray.length == 0) {
			flag = true;
			jWarningAlert('货号['+itemObj.itemNo+']下的门店不能为空！');
			break;
		}
		//验证门店下的建议量是否为空
		for (var indStore = 0; indStore < storeArray.length; indStore++) {
			var storeObj = storeArray[indStore];
			if ($.trim(storeObj.initQty) == "" || $.trim(storeObj.initQty) == "0") {
				stores = stores + storeObj.storeNo + ",";
			}
		}
		if (stores != "") {
			stores = stores.substring(0, stores.length-1);
			errorStore = "货号：[" + itemObj.itemNo + "]下的门店[" + stores + "]建议量不能为空！";
			flag = true;
			break;
		}
	}
	errorObj.flag = flag;
	errorObj.errorStore = errorStore;
	errorObj.indexOf = ind;
	return errorObj;
}