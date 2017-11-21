var catlgList;
var buyerList;
/** 输入整数值 */
function inputToInputIntNumber() {
	$("input.count_text").each(function() {
		$(this).keyup(function() {
			if ($(this).val() != '' && !(/^\d+$/).test($(this).val())) {
				if ($(this).val() == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
		$(this).attr('preval', $(this).val());
		});
		$(this).blur(function(){
			$(this).attr('preval', $(this).val());
			if ($(this).val() != '' && !(/^\d+$/).test($(this).val())) {
				if ($(this).val() == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
		});
	});
}

/** 输入小数值 double_text */
function inputToInputDoubleNumberAndChkLen(obj) {
	obj.find("input.double_text_with_len").each(function() {
		var intval = $(this).attr('intval');
		var decval = $(this).attr('decval');	
		var reg = new RegExp("^[0-9]{1," + intval +"}[.][0-9]{0,"+decval+"}$|^[0-9]{1,"+intval+"}$");
		$(this).keyup(function(){		
			if ($(this).val() != '' && !reg.test($(this).val())) {
				if ($(this).val() == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
			$(this).attr('preval', $(this).val());
		});
		$(this).blur(function(){
			var val = $(this).val();
			if (val!= '' && !reg.test(val)) {
				if (val == ' ') {
					$(this).val('');
					return false;
				}
				if ($(this).val() != '') {
					$(this).val($(this).attr('preval'));
				}
				return true;
			}
			if (val.indexOf('.')==val.length-1) {
					$(this).val(val.substring(0,val.length-1));
			}
			$(this).attr('preval', $(this).val());
		});
	});
}

//查询表单提交
function searchFormSubmit(){
	
	var supNo = $("#searchForm #supNo").val();
	if (supNo){
		$.ajaxSetup({
			async : false
		});
		readSupInfoBySupNo("", supNo, function(data) {
			if (data != "" && data.length > 0) {
				$("#searchForm #supName").val(data[0].comName);
			}
		});
		$.ajaxSetup({
			async : true
		});
		
		if ($("#listViewCon #searchForm #supName").val()){
			return true;
		}
	}
	
	
	
	if(checkSearchForm()){
		currentContractPageQuery();
	}
}

//翻页信息
function currentContractPageQuery(pageNo,pageSize) {
	var param = $('#searchForm').serialize();
	param = joinPostParam(param,'pageNo',pageNo||1);
	param = joinPostParam(param,'pageSize',pageSize||20);
	$.post(ctx + $('#searchForm').attr('action'),param,
			function(data) {
		$('.Container-1 .Content.list').html(data);
	});
};

/**
 * 隐藏显示搜索栏
 */
function showHideLeftSearchDiv(){
	if($('.Container-1 .Search').is(':visible')){
		hideLeft();
	}
	else{
		showLeft();
	}
}

//隐藏左边查询
function hideLeft(){
	if(!$('.Container-1 .Search').is(':visible')) return;
	$('.Container-1 .Search').hide();
	$('.Container-1 .Content').css('width','99%');
}

//显示左边查询
function showLeft(){
	if($('.Container-1 .Search').is(':visible')) return;
	$('.Container-1 .Search').show();
	$('.Container-1 .Content').css('width','74%');
}

//显示列表页面
function showListPage(){
	$('.list').show();
	$('.detail').hide();
	$('.detail input').val('');
	$('#Tools1').removeClass('Tools1_disable').addClass('Tools1');
	$('#Tools2').removeClass('Tools2').addClass('Tools2_disable');
	$('#Tools21').removeClass('Tools21').addClass('Tools21_disable');
	$('#Tools11').removeClass('Tools11_disable').addClass('Tools11');
	if($('.btable_checked').size()<1){
		$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
		$('#Tools22').removeClass('Tools22').removeClass('Tools22_on').addClass('Tools22_disable').removeClass('Tools22_hover').parent().removeClass('ToolsBg');
	}
	else{
		$('#Tools12').addClass('Tools12').removeClass('Tools12_disable');
		$('#Tools22').addClass('Tools22').removeClass('Tools22_disable');
	}
	if($('#Tools26').hasClass('Tools26')){
		$('#Tools26').removeClass('Tools26').addClass('Tools26_disable');
	}
}

//切换到详细页
function switchDetail(title){
	$('.newTitle').text(title);
	$('.list').hide();
	$('.detail').show(); 
	hideLeft();
	$('#Tools1').removeClass('Tools1_on').parent().removeClass('Tools1Parent_bg');
	$('#Tools1').removeClass('Tools1').addClass('Tools1_disable');
	$('#Tools2').removeClass('Tools2').addClass('Tools2_disable');
	$('#Tools11').removeClass('Tools11').addClass('Tools11_disable');
	$('#Tools12').removeClass('Tools12').addClass('Tools12_disable');
	$('#Tools21').removeClass('Tools21').addClass('Tools21_disable').removeClass('Tools21_hover').removeClass('Tools21_on').parent().removeClass('ToolsBg');
	$('#Tools22').removeClass('Tools22').addClass('Tools22_disable');
}

//显示detail页面
function showDetailPage(cntrtId){
	refreshFlag=0;
	$.ajaxSetup({
		async : false
	});
	var contractId = $('.btable_checked').attr('id');
	$('.Container-1').find('.Content.detail').html('');
	$.post(ctx+'/supplier/contract/current/detail?cntrtId='+cntrtId,function(data){
		$('.Container-1').find('.Content.detail').html(data);
	});
	switchDetail('合同详情');
	$('#Tools21').removeClass('Tools21_disable').addClass('Tools21');
	$.ajaxSetup({
		async : true
	});
}

//判断合同能否修改
function checkCanSubmit(cntrtId){
	var flag = false;
	$.ajax({
		type : 'post',
		url : ctx + '/supplier/contract/current/isCanSubmit',
		data : {
			cntrtId : cntrtId
		},
		async : false,
		success : function(data){
			if(data.isCanSubmit == false){
				jWarningAlert("该合同不能修改");
				flag = true;
			}
		}
	});
	return flag;
}
//修改合同
function showEditPage(cntrtId){
	refreshFlag=1;
	if(checkCanSubmit(cntrtId)){
		return;
	}
	$.post(ctx+'/supplier/contract/current/edit?cntrtId='+cntrtId,function(data){
		$('.Container-1').find('.Content.detail').html(data);
	});
	switchDetail('修改合同');
	$('#Tools2').removeClass('Tools2_disable').addClass('Tools2');
/*	$('#Tools26').removeClass('Tools26_disable').addClass('Tools26').unbind().bind('click',function(){
		top.jConfirm('你确定要提交信息进行审核吗?','提示消息',function(ret){
			if(ret){
				var taskId = $('#taskId').val();
				$.ajax({
					type : "post",
					url : ctx+'/workspace/task/doSubmitContract2Audit',
					async :false,
					dataType : "json",
					data : {'taskId':taskId},
					success : function(data) {
						if(data.status=='success'){
							top.jAlert('success', '提交成功','提示消息',function(){
								//onSubMenuItemClick(52);
							});
						}else{
							top.jAlert('warning', data.message,'提示消息');
						}
					}
				});
			}
		});
	
	});*/
}

//创建新合同
function showCreatePage(){
	refreshFlag=1;
	$.post(ctx+'/supplier/contract/current/create?_t='+(new Date()).getTime(),function(data){
		$('.Container-1').find('.Content.detail').html(data);
	});
	switchDetail('创建新合同');
	$('#Tools2').removeClass('Tools2_disable').addClass('Tools2');
}

//合同模块toolbar初始化
function initEnventForContract(){
	$('#Tools1,#Tools2,#Tools11,#Tools12,#Tools21,#Tools22').die().unbind().bind('click',function(){
		bindEvent($(this).attr('id'));
	});
}

//绑定函数,因为仅根据id绑定函数的话,到不同页面要来回绑定/取消,所以根据是否disable,disable的tool不执行相关函数
function bindEvent(toolId){
	var toolElem = $('#'+toolId);
	if(toolElem.hasClass(toolId+'_disable')){
		return ;
	}
	switch(toolId){
		case 'Tools1':showHideLeftSearchDiv();break;
		case 'Tools2':saveContract();break;
		case 'Tools11':showCreatePage();break;
		case 'Tools12':showEditPage($('.btable_checked').attr('cntrtId'));break;
		case 'Tools21':showListPage();break;
		case 'Tools22':showDetailPage($('.btable_checked').attr('cntrtId'));break;
	}
}

//选中一条记录
function selectContract(id){
	$('#Tools12').addClass('Tools12').removeClass('Tools12_disable');
	$('#Tools22').addClass('Tools22').removeClass('Tools22_disable');
}

//供应商失去焦点
function supplierBlur(obj,forRebate){
	if($(obj).attr('preval2')==obj.value){
		return false;
	}
	$(obj).attr('preval2',obj.value);
	if(obj.value==''){
		return false;
	}
	var returnVal = selectSupplier(obj.value);
	if(!returnVal){
		obj.attr('error','true');
	}
}
var catlgList;
var buyerList;
//获取课别数据
function getCatlgListBuySupNo(supNo){
	//获取数据前，先清空
	$("#kebieInput").val('').unautocomplete();
	$("#kebieInputValue").val('').unautocomplete();
	if($("#kebieInput").hasClass('errorInput')){
		$("#kebieInput").removeClass('errorInput');
	}
	$('#buyInput').val('').unautocomplete();
	$.post(ctx+'/supplier/contract/current/catlgList','supNo='+supNo,function(data){
		if(data.status!='error'){
			if(data.list.length==1){
				$("#kebieInput").val(data.list[0].secNo);
				$("#divNo").val(data.list[0].divNo);
				$("#kebieInputValue").val(data.list[0].secName);
				if($("#kebieInput").val()!=''&&$("#kebieInput").hasClass('errorInput')){
					$("#kebieInput").removeClass('errorInput');
				}
				if($("#kebieInputValue").val()!=''&&$("#kebieInputValue").hasClass('errorInput')){
					$("#kebieInputValue").removeClass('errorInput');
				}
				getBuyerListBySupCatlgId(supNo,data.list[0].secNo);
				isContractExists(supNo, data.list[0].secNo);
			}
			else{
				bindCatlgInput(supNo,data.list);
			}
		}
	});
}

//绑定课别
function bindCatlgInput(supNo,data){
	$("#kebieInput").unautocomplete().autocomplete(data, {
		minChars : 0,
		width : 180,
		max : 3000,
		matchContains : true,
		matchCase : false,// 不区分大小写
		autoFill : false,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.secNo + "-" + row.secName;
		},
		formatResult : function(row) {
			return row.secNo + "-" + row.secName;
		}

	}).result(
		function(event, data, formatted) { // 回调
			isContractExists(supNo, data.secNo);
			$('#kebieInput').val(data.secNo);
			$("#divNo").val(data.divNo);
			$('#kebieInputValue').val(data.secName);
			getBuyerListBySupCatlgId(supNo,data.secNo);
		});
}

function getBuyerListBySupCatlgId(supNo,catlgId){
	$.post(ctx+'/supplier/contract/current/buyer','supNo='+supNo+'&catlgId='+catlgId,function(data){
		if(data.status!='error'){
			bindBuyerInput(data.list);
			if($("#buyInput").val() == ""){
				$("#buyInput").val('');
				$("#buyInput").val(data.list[0].name);
				$('#buyInputValue').val(data.list[0].staffNo);
				if($("#buyInput").val()!=''&&$("#buyInput").hasClass('errorInput')){
					$("#buyInput").removeClass('errorInput');
				}
			}
		}
	});
}

//绑定采购
function bindBuyerInput(data){
	$("#buyInput").unbind().bind('keydown',function(e){
		var e = e || window.event || arguments.callee.caller.arguments[0];
		
	});
	$("#buyInput").unautocomplete().autocomplete(data, {
		minChars : 0,
		width : $(this).attr('acWidth'),
		max : 3000,
		matchContains : true,
		matchCase : false,// 不区分大小写
		autoFill : false,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.staffNo+'-'+row.name;
		},
		formatResult : function(row) {
			return row.name;
		}

	}).result(
			function(event, data, formatted) { // 回调
			$('#buyInputValue').val(data.staffNo);
	});
}

function getSupName(supNo){
	readSupInfoBySupNo(null,supNo,getSupNameCallBack);
}

function getSupNameCallBack(data){
	$('#supName').attr('value',data.supName);
}

//供应商回车
function supplierKeydown(event,obj,forRebate){
	if(event.keyCode == 13){
		$(obj).attr('preval2',obj.value);
		if(obj.value==''){
			return false;
		}
		//返利条款中的sup
		if(forRebate){
			return selectRebateSupplier(obj.value);
		}
		else{
			return selectSupplier(obj.value);
		}
	}
}

//获取供应商
function selectSupplier(supNo){
	var returnVal = true;
	$.post(ctx+'/supplier/contract/current/supInfo','supNo='+supNo,function(data){
		if($.trim(data.status)!='error'){
			$('#contractForm .supNo:visible').val(supNo);
			$('#contractForm .supName:visible').val(data.sup.supComVO.comName);
			$('.supType:visible').val(getDictValue('SUPPLIER_SUP_TYPE',data.sup.supType));
			$('.buyMethd:visible').val(getDictValue('SUPPLIER_BUY_METHD',data.sup.buyMethd));
			$('.cntrtType:visible').val(getDictValue('SUPPLIER_CONTRT_TYPE',data.sup.cntrtType));
			$('.unifmNo:visible').val(data.sup.supComVO.unifmNo);
			$('.payPerd:visible').val(data.payment.payPerd);
			$('.frontPay:visible').val(getDictValue('SUP_PAYMENT_FRONT_PAY',data.payment.frontPay));
			getCatlgListBuySupNo(supNo);
		}
		else{
			top.jAlert('warning', '厂商不存在!', '消息提示');
			$('.supNo:visible').val('');
			$('.supName:visible').val('');
			$('.supType:visible').val('');
			$('.buyMethd:visible').val('');
			$('.cntrtType:visible').val('');
			$('.unifmNo:visible').val('');
			$('.payPerd:visible').val('');
			$('.frontPay:visible').val('');
			returnVal = false;
		}
	});
	return returnVal;
}

function setRebateSupplierName(supNo,supName){
	$('.contract:visible').find('.supNo').val(supNo);
	$('.contract:visible').find('.supName').val(supName);
}

//获取供应商
function selectRebateSupplier(supNo){
	var returnVal = true;

	var secNo = $('#kebieInput').val();
	if(secNo==''){
		top.jAlert('warning', '请选择课别!', '消息提示');
		return;
	}
	if(supNo==$('#contractForm .supNo').val()){
		$('.contract:visible').find('.supNo').val($('#contractForm .supNo').val());
		$('.contract:visible').find('.supName').val($('#contractForm .supName').val());
		getSupplierContractDetail(supNo,secNo);
	}else if(supNo==""){
		$('.contract:visible').find('.supNo').val("");
		$('.contract:visible').find('.supName').val("");
		getSupplierContractDetail(supNo,secNo);
	}else{
		$.post(ctx+'/supplier/contract/current/mainSup',"secNo="+secNo+"&supNo="+supNo+"&supName="+supNo+"&pageNo=1&pageSize=1&catlgId="+secNo,function(data){
				if($.trim(data)!=''){
					$('.contract').find('.supNo').val(data.supNo);
					$('.contract').find('.supName').val(data.supName);
					getSupplierContractDetail(supNo,secNo);
				}
				else{
					top.jAlert('warning', '该厂编无法做关联!', '消息提示',function(){
						$('.contract').find('.supNo').val('');
						$('.contract').find('.supName').val('');
					});
					returnVal = false;
				}
		});
	}
	
	return returnVal;
}

function getSupplierContractDetail(mainSupNo,secNo){
	var supNo = $('#contractForm').find('.supNo').val();
	var termId = $('.contract .termId').val();
	$.post(ctx+'/supplier/contract/current/sup',"termId="+termId+'&supNo='+supNo+'&mainSupNo='+mainSupNo+"&catlgId="+secNo,function(data){
		$('.contract .linkMainSup').html(data);
		$('.contract input[name="taskId"]').val($('#taskId').val());
		$('.linkMainSup input[name=linkMainSupNo]').val(mainSupNo);
		$('.linkMainSup input[name=payMethd]').val($('.linkMainSup').parent().find('select.payMethd').val());
	});
}

//获取tabDetail
function getTabDetail(tabId,tabType,cntrtId,readonly){
	var tabElem = $("#content_"+tabId);
	$.ajaxSetup({
		async : false
	});
	if($.trim(tabElem.html())==''){
		var url=$.trim(readonly)==''?'/supplier/contract/current/tabDetail':'/supplier/contract/current/tabDetailForReadOnly';
		$.post(ctx+url,'tabId='+tabId+"&tabType="+tabType+"&cntrtId="+cntrtId,function(data){
			$('.Container-1 .detail').append(data);
		});
	}
	$('.Container-1 .contract').hide();
	$('.item_on').removeClass('item_on');
	$('#tab_'+tabId).addClass('item_on');
	$("#content_"+tabId).show();
	$.ajaxSetup({
		async : true
	});
}

//获取tabDetail(不显示鸟)
function getTabDetailHidden(tabId,tabType,cntrtId){
	var tabElem = $("#content_"+tabId);
	if($.trim(tabElem.html())==''){
		var url='/supplier/contract/current/tabDetail';
		$.ajaxSetup({global:false});
		$.post(ctx+url,'tabId='+tabId+"&tabType="+tabType+"&cntrtId="+cntrtId,function(data){
			$('.Container-1 .detail').append(data);
		});
		$.ajaxSetup({global:true});
	}
}

//新增一行
function addDataRow(obj){
	/*遇到输入错误,不新增
	var errorInputEle = obj.parent().find('div .errorInput');
	if(errorInputEle.size()>0){
		return ;
	}*/
	$($('.contractAcc:visible:last').clone()).insertBefore(obj);
	$('.contractAcc:visible:last').find('.accTitle').text('');
	if($('.contractAcc:visible:last').find('.brType').size()==0){
		//$('.contractAcc:visible:last form').prepend('<br class="brType" style="clear:both;">');
		$('.contractAcc:visible:last').find('.Tools10_disable').removeClass('Tools10_disable').addClass('Tools10');
	}
	$('.contractAcc:visible:last').find('.cntrtDetlId').val('');
	$('.contractAcc:visible:last').find('input:not(:hidden):not(.read)').val('');
	inputToInputIntNumber();
	inputToInputDoubleNumberAndChkLen($('.contract:visible'));
	rangeNoReload();
}

//删除一行
function removeDataRow(obj){
	$(obj).remove();
	var tempDelStr = $(obj).find('.cntrtDetlId').val();
	if($.trim(tempDelStr)!=''){
		deleteData=deleteData+tempDelStr+",";
	}
	rangeNoReload();
}

//重新计算rangeNo
function rangeNoReload(){
	$('.rangeNo').each(function(){
		var rangeNo = $(this).parent().parent().parent().index('.contractAcc:visible')+1;
		$(this).text(rangeNo>9?rangeNo:('0'+rangeNo));
	});
}

//查询表单校验
function checkSearchForm(){
	var returnVal=true;
	return returnVal;
}

//for basic 常用条款
function checkBasicFormClass(obj){
	var dedctVal = $(obj).val();
	var dedctType = $(obj).parent().find('input[name=dedctValType]').val();
	$(obj).parent().find('.errorInput').removeClass('errorInput');
	if(dedctType == 'P' && dedctVal > 100){
		$(obj).addClass('errorInput');
		top.jAlert('warning', '百分比不能大于100!', '消息提示');
		return ;
	}
	if($.trim(obj.value)==''){
		$(obj).parent().removeClass('acctForm');
	}
	else{
		$(obj).parent().find('.payMethd').val($(obj).parent().parent().parent().parent().find('.payMethd').first().val());
		$(obj).parent().addClass('acctForm');
	}
}

//for rebit 返利条款
function checkRebateFormClass(obj){
	var formEle = $(obj).parent();
	var condVal = formEle.find('.condVal');
	var dedctVal = formEle.find('.dedctVal');
	var condValType = formEle.find('select.condValType');
	var dedctValType = formEle.find('select.dedctValType');
	formEle.find('.errorInput').removeClass('errorInput');
	formEle.removeClass('acctForm');

	if(condVal.val()=='0' || dedctVal.val()=='0'){
		top.jAlert('warning', '目标值/返利值必须大于0!', '消息提示');
		return ;
	}
	
	if(condVal.val()>100 && condValType.val()=='P' && $(obj).hasClass('condVal')){
		condVal.addClass('errorInput');
		top.jAlert('warning', '百分比不能大于100!', '消息提示');
		return ;
	}
	if(dedctVal.val()>100 && dedctValType.val()=='P' && $(obj).hasClass('dedctVal')){
		dedctVal.addClass('errorInput');
		top.jAlert('warning', '百分比不能大于100!', '消息提示');
		return ;
	}
	if(!(condVal.val()=='' && dedctVal.val()=='')){
		if(condVal.val()==''){
			condVal.addClass('errorInput');
			return false;
		}
		if(dedctVal.val()==''){
			dedctVal.addClass('errorInput');
			return false;
		}
	}
	
	if(checkRebateRule(obj)){
		top.jAlert('warning', '返利条目填写不符合规则,上下条目之间须是递增的.', '消息提示');
		return ;
	}
	
	if(condVal.val()!='' && dedctVal.val()!=''){
		formEle.addClass('acctForm');
	}
}

//上下条目规则,上一目标值和返利值必须递增
function checkRebateRule(obj){
	var returnVal = false;
	var rebateEles = $('.contractAcc.degeeCondInd');
	rebateEles.find('.errorInput').removeClass('errorInput');
	rebateEles.each(function(){
		var prevEle = $(this).prev('.degeeCondInd');
		if(prevEle){
			var condValEle = $(this).find('.condVal');		//当前目标值
			var prevCondValEle = prevEle.find('.condVal');	//上一目标值
			var dedctValEle = $(this).find('.dedctVal');	//当前返利值
			var prevDedctValEle = prevEle.find('.dedctVal');//上一返利值
			if(condValEle.val()!=''){
				if(prevCondValEle.val()==''){
					prevCondValEle.addClass('errorInput');
					returnVal = true;
				}
				else{
					if(parseFloat(condValEle.val())<=parseFloat(prevCondValEle.val())){
						$(obj).addClass('errorInput');
						returnVal = true;
					}
				}
			}
			if(dedctValEle.val()!=''){
				if(prevDedctValEle.val()==''){
					prevDedctValEle.addClass('errorInput');
					returnVal = true;
				}
				else{
					if(parseFloat(dedctValEle.val())<=parseFloat(prevDedctValEle.val())){
						$(obj).addClass('errorInput');
						returnVal = true;
					}
				}
			}
		}
	});
	return returnVal;
}

//for phase 阶段性条款
function checkPhaseFormClass(obj){
	var formEle = $(obj).parent();
	var beginDate = formEle.find('.beginDate');
	var endDate = formEle.find('.endDate');
	var dedctVal = formEle.find('.dedctVal');
	formEle.find('.errorInput').removeClass('errorInput');
	if(!(beginDate.val()=='' && endDate.val()=='' && dedctVal.val()=='')){
		if(beginDate.val()==''){
			beginDate.addClass('errorInput');
			return;
		}
		if(endDate.val()==''){
			endDate.addClass('errorInput');
			return;
		}
		//验证结束时间大于开始时间
		var iDays = getSubDays(beginDate.val(),endDate.val());
		if(iDays < 0){
			endDate.addClass('errorInput').attr('title','结束日期必须大于开始日期');
			return;
		}
		if(dedctVal.val()==''){
			dedctVal.addClass('errorInput');
			return;
		}
		//验证百分比小于100
		if(dedctVal.val() > 100){
			dedctVal.addClass('errorInput');
			top.jAlert('warning', '百分比不能大于100!', '消息提示');
			return;
		}
	}
	if(beginDate.val()!='' && endDate.val()!='' && dedctVal!=''){
		formEle.addClass('acctForm');
	}
}

//改变select的联动效果
function changeRebateValType(obj,className){
	var valType = $(obj).val();
	$(obj).parent().parent().parent().parent().find('.degeeCondInd.'+className).each(function(){
		$(this).val(valType);
	});
	if(valType=='P'){
		var valClassName = className.replace('Type','');
		var hasError = false;
		$(obj).parent().parent().parent().parent().find('.degeeCondInd.'+valClassName).each(function(){
			if(this.value>100){
				$(this).addClass('errorInput');
				hasError = true;
			}
		});
		if(hasError){
			top.jAlert('warning', '百分比不能大于100!', '消息提示');
		}
	}
}

//如果有mustInput 样式,就校验是否为空,空则绑定聚焦和失去焦点事件
function nullInputCheck() {
	$('.mustInput').each(function() {
		$(this).blur(function() {
			if ($.trim($(this).val()) == '' && !($(this).hasClass())) {
				$(this).addClass('errorInput');
			}
		});
		$(this).focus(function() {
			$(this).removeClass('errorInput');
		});
	});
}

//校验必填字段是否为空
function checkNull(obj){
	var errorFlag = false;
	var errorInput = $(obj).find('.errorInput');
	if(errorInput.size()>0){
		var contractDetail = $(errorInput[0]).parents('.contract');
		if(contractDetail != null){
			var contractDetailEleId = contractDetail.attr('id');
			var contractId = contractDetailEleId.substr(contractDetailEleId.indexOf('_')+1);
			$('.mpbtn.item_on').removeClass('item_on');
			$('#tab_'+contractId).addClass('item_on');
			$('.contract:visible').hide();
			$('#content_'+contractId).show();
			errorFlag = true;
		}
	}
	return errorFlag;
}

/** form 空校验 */
function chkContractInfo() {
	var inputOk = true;
	$('.mustInput:visible').each(function() {
		if ($.trim($(this).val()) == '') {
			if (!($(this).hasClass('errorInput'))) {
				$(this).addClass('errorInput');
			}
			inputOk = false;
		}
	});
	return inputOk;
}

//校验表单
function checkSaveForm(){
	var retVal = true;
	if(!chkContractInfo()){
		return false;
	}
	if(checkNull($('.Container-1 .detail'))){
		retVal = false;
	}
	return retVal;
}
function checkRebate(){
	var errorFlag = false;
	//检查有条件返利关联厂商处是否为空
	var linkMainSup = $('.contract .supNo');
	var payMethd = $('.linkMainSup').parent().find('select.payMethd');
	var condVal = $('.linkMainSup').find('.condVal').first();
	if(linkMainSup.val() != ""){
		if(payMethd.val() == ""){
			errorFlag = true;
		}else{
			if(condVal.val() == ""){
				errorFlag = true;
			}
		}
	}else if(payMethd.val() != ""){
		errorFlag = true;
	}
	return errorFlag;
}
//保存操作
function saveContract(){
	//判断当前课别在本年度是否已有合同
	var supNo = $('#contractForm .supNo').val();
	var catlgId = $('#kebieInput').val();
	$.ajaxSetup({
		async : false
	});
	if(isContractExists(supNo,catlgId)){
		return;
	}
	$.ajaxSetup({
		async : true
	});
	//check返利条款
	if(checkRebate()){
		jWarningAlert('关联厂编支付方式和年返最低不能为空！');
		return;
	}
	//页面校验
	if(checkSaveForm()){
		var contractData = JSON.stringify($("#contractForm").serializeObject());
		var detailList = $('.Container-1 .detail').find('.acctForm').map(
				function() {
					return JSON.stringify($(this).serializeObject());
				}).get().join(",");
		if(detailList==''){
			top.jAlert('warning', '合同条款的内容不能为空!', '消息提示');
			return false;
		}
		detailList="["+detailList+"]";
		if($('.Container-1 .detail').find('.cntrtId').val()!=''){
			var tempDeleteData = $('.Container-1 .detail').find('.update:not(".acctForm")').map(
					function() {
						return $(this).find('.cntrtDetlId').val();
					}).get().join(",");
			deleteData = deleteData+tempDeleteData;
		}
		var taskId = $('#taskId').val();
		$.ajax({
			type : "post",
			async : false,
			url : ctx + '/supplier/contract/current/save',
			dataType : "json",
			data : {
				contractStr : contractData,
				detailList : detailList,
				deleteData:deleteData,
				taskId:taskId
			},
			success : function(data,status) {
				if(status == 'success'){
					$('#taskId').val(data.contract.taskId);
					$('#contractForm .cntrtId').val(data.contract.cntrtId);
					if(data.contract.taskId == null){
						$('#taskId').val(data.taskId);
					}
					top.jAlert('success', '保存成功', '消息提示',function(){
						showCreatePage();
						showTools26();
					});
				}
			}
			});
	}
}

//显示Tools26并绑定提交事件
function showTools26(){
	if($('#Tools26').hasClass('Tools26_disable')){
		$('#Tools26').removeClass('Tools26_disable').addClass('Tools26').unbind().bind('click',function(){
			top.jConfirm('你确定要提交信息进行审核吗?','提示消息',function(ret){
				if(ret){
					var taskId = $('#taskId').val();
					$.ajax({
						type : "post",
						url : ctx+'/workspace/task/doSubmitContract2Audit',
						async :false,
						dataType : "json",
						data : {'taskId':taskId},
						success : function(data) {
							if(data.status=='success'){
								top.jAlert('success', '提交成功','提示消息');
							}else{
								top.jAlert('warning', data.message,'提示消息');
							}
						}
					});
				}
			});
		});
	}
}

//展开+收起
function ctrtUpDown(obj){
    var $ets = $(obj);
    var $content = $ets.parent().next(".deposit");
    var $arraw = $ets.find(".arraw");
    var $arrTxt = $ets.find(".arr_txt");

    if ($arraw.hasClass("arraw1")) {
        $arraw.addClass("arraw2").removeClass("arraw1");
        $arrTxt.text($ets.attr('upText'));
        $content.toggle();
    }
    else {
        $arraw.addClass("arraw1").removeClass("arraw2");
        $arrTxt.text($ets.attr('downText'));
        $content.toggle();
    }
}

//设置开始时间
function getBeginDate(obj){
	var startDate = $(obj).val();
	$(obj).val(startDate.substr(0,startDate.length-2)+'01');
	checkPhaseFormClass(obj);
}

//设置结束时间
function getEndDate(obj){
	var endDate = $(obj).val();
	var d = endDate.substr(0,endDate.length-3).split('-');
	$(obj).val(getLastDay(d[0],d[1]));
	checkPhaseFormClass(obj);
}

//获取当月最后一天
function getLastDay(year,month)  
{  
 var new_year = year;    //取当前的年份  
 var new_month = month++;//取下一个月的第一天，方便计算（最后一天不固定）  
 if(month>12)            //如果当前大于12月，则年份转到下一年  
 {  
  new_month -=12;        //月份减  
  new_year++;            //年份增  
 }  
 var new_date = new Date(new_year,new_month,1);                //取当年当月中的第一天  
 return (new Date(new_date.getTime()-1000*60*60*24)).format('yyyy-MM-dd');//获取当月最后一天日期  
}

//校验是否选择支付方式
function checkPayMehod(obj){
	var payMehodEle = $(obj).parents('.deposit').find('select.payMethd');
	if(payMehodEle.size()>0){
		if(payMehodEle.val()==''){
			top.jAlert('warning', '请先选择当前条款的支付方式!', '消息提示',function(){
				payMehodEle.focus()
			});
			return false;
		}
	}
	var supNoEle = $(obj).parents('.deposit').find('.supNo');
	if(supNoEle.size()>0){
		if(supNoEle.val()==''){
			top.jAlert('warning', '请先选择当前条款的关联主厂商!', '消息提示',function(){
				supNoEle.focus();
			});
		}
	}
}

//选择厂商
function chooseSupplier() {
	var secNo = $('#kebieInput').val();
	if(secNo==''){
		top.jAlert('warning', '请选择课别!', '消息提示');
		return;
	}
	var mainSup = $('.depositx .supNo').val();
	openPopupWin(876, 563, "/supplier/contract/current/supList?mainSup="+mainSup);
}

//选择合同的厂商
function chooContractSupplier() {
	openPopupWin(700, 548, "/supplier/contract/current/chooseSuplier");
}

$.fn.serializeObject = function() {
	var o = {};
	var a = this.serializeArray();
	$.each(a, function() {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [ o[this.name] ];
			}
			o[this.name].push(this.value || null);
		} else {
			o[this.name] = this.value || null;
		}
	});
	return o;
};

function isContractExists(supNo,catlgId){
	var isExists = false;
	var cntrtId = $('.cntrtId:visible').val();
	if(cntrtId!=''){
		return false;
	}
	$.post(ctx+'/supplier/contract/current/isContractExists','supNo='+supNo+"&catlgId="+catlgId,function(data){
		if(data.status=='error'){
			top.jAlert('warning', '请选择厂商和课别', '消息提示');
			isExists = true;
		}
		if(data.status=='success'){
			if(data.flag==1){
				top.jAlert('warning', '本年度该厂商已在当前课别下创建合同!', '消息提示');
				$('#kebieInput').addClass('errorInput');
				isExists = true;
			}
		}
	});
	return isExists;
}

function enterBind(){
	$(".enterBind").keydown(function(e) {
		if (e.keyCode == 13) {
			searchFormSubmit();
		}
	});
}

//限制备注长度
function limMemo(obj){
	if(charLen($.trim($(obj).val())) > 254){
		$(obj).val($(obj).attr('preval'));
	}
	$(obj).attr('preval',$(obj).val());
}
//判断字符长度。英文一个字符，中文两个字符
function charLen(s)
   {
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
    }