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
	var reg = new RegExp("^[0-9]{0,"+digit+"}$");
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
//保存之前验证数据是否正确
function checkSaveBefore(/*JSON*/jsonObject){
	//存放错误信息
	var errorMessArray = [];
	var tabList = jsonObject.tabs;
	var termMap = jsonObject.tab2terms;
	var acctMap = jsonObject.term2accts;
	var tabChildren = $("#templTabCodeDiv").children();
	if (tabChildren.length < 1) {
		var errorStr = "页签不能为空!";
		errorMessArray.push(errorStr);
		return errorMessArray;
	}
	for(var tabInd = 0; tabInd < tabChildren.length; tabInd++){
		//验证页签
		var errorMess = "";
		var tabObj = tabList[tabInd];
		var tabElem = tabChildren[tabInd];
		//验证页签中文名是否为空
		if ($.trim(tabObj.tabName) == "") errorMess = "页签序号[" +tabElem.children[1].value+"]的中文名不能为空，\n";
		//tabIndex.push(tabElem.children[1].value);
		//验证条款
		var termArray = termMap[tabObj.tabId].data;
		//验证条款是否为空
		if (termArray.length < 1) {
			if (errorMess == "") {
				errorMess = "页签序号[" +tabElem.children[1].value+"]下条款不能为空，";
			} else {
				errorMess = errorMess + "条款不能为空!";
			}
			errorMessArray.push(errorMess);
			break;
		}
		for (var termInd = 0; termInd < termArray.length; termInd++) {
			var termObj = termArray[termInd];
			var acctArray = acctMap[termObj.termId].accts;
			//验证科目是否为空
			if (acctArray.length < 1) {
				if (errorMess == "") {
					errorMess = "页签序号[" +tabElem.children[1].value+"]下条款序号["+(termInd+1)+"]下的科目不能为空，";
					break;
				} else {
					errorMess = errorMess + "条款序号["+(termInd+1)+"]下的科目不能为空，";
					break;
				}
			}
			//验证条款中文名是否为空
			if ($.trim(termObj.termName) == ""){
				if (errorMess == "") {
					errorMess = "页签序号[" +tabElem.children[1].value+"]下条款的中文名或支付方式不能为空，";
					break;
				} else {
					errorMess = errorMess + "条款的中文名或支付方式不能为空，";
					break;
				}
			}
			//验证条款支付方式是否为空
			if ($.trim(termObj.payMethdOptns) == ""){
				if (errorMess == "") {
					errorMess = "页签序号[" +tabElem.children[1].value+"]下条款的中文名或支付方式不能为空，";
					break;
				} else {
					errorMess = errorMess + "条款的中文名或支付方式不能为空，";
					break;
				}
			}
		}
		if (errorMess != "") {
			errorMess = tabElem.children[1].value + errorMess;
			errorMessArray.push(errorMess);
		}
	}
	return errorMessArray;
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