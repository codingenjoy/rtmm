//保存提交
function saveFormSubmit(action) {
	if (!validata())
		return;
	pageSave(action);
}
//数据校验
function validata() {
	var grpAcctSeqNo = $.trim($("#searchCreateForm").find(
			"input[name='grpAcctSeqNo']").val());
	var grpAcctId = $.trim($("#searchCreateForm").find(
			"input[name='grpAcctId']").val());
	var grpAcctName = $.trim($("#searchCreateForm").find(
			"input[name='grpAcctName']").val());
	var grpAcctEnName = $.trim($("#searchCreateForm").find(
			"input[name='grpAcctEnName']").val());
	var grpAcctAbbr = $.trim($("#searchCreateForm").find(
			"input[name='grpAcctAbbr']").val());
	var dedctFreq = $.trim($("#searchCreateForm").find("[name='dedctFreq']")
			.val());
	var linkMainSupInd = $.trim($("#searchCreateForm").find(
			"[name='linkMainSupInd']").val());
	var degeeCondInd = $.trim($("#searchCreateForm").find(
			"[name='degeeCondInd']").val());
	var usedForType = $.trim($("#searchCreateForm")
			.find("[name='usedForType']").val());
	var status = $.trim($("#searchCreateForm").find("[name='status']").val());
	var grpGrpAbbr = $.trim($("#searchCreateForm").find("[name='grpGrpAbbr']").val());
	var dedctValType = $.trim($("#searchCreateForm").find(
			"[name='dedctValType']").val());
	var calcBy = $.trim($("#searchCreateForm").find("[name='calcBy']").val());
	var feeType = $.trim($("#searchCreateForm").find("[name='feeType']").val());
	var validataInfo = true;
	if (grpAcctSeqNo == "") {
		$($("#searchCreateForm").find("input[name='grpAcctSeqNo']")).addClass(
				"errorInput");
		$($("#searchCreateForm").find("input[name='grpAcctSeqNo']")).attr(
				"title", "请输入正确的序号(数字)");
		validataInfo = false;
	}
	if (grpAcctId == "") {
		$("#searchCreateForm").find("input[name='grpAcctId']").addClass(
				"errorInput");
		$("#searchCreateForm").find("input[name='grpAcctId']").attr("title",
				"请输入正确的科目组编号(数字)");
		validataInfo = false;
	}
	if (grpAcctName == "") {
		$("input[name='grpAcctName']").addClass("errorInput");
		$("input[name='grpAcctName']").attr("title", "请输入正确的中文名称");
		validataInfo = false;
	}
	if (grpAcctEnName == "") {
		$("input[name='grpAcctEnName']").addClass("errorInput");
		$("input[name='grpAcctEnName']").attr("title", "请输入正确的英文名称");
		validataInfo = false;
	}
	if (grpAcctAbbr == "") {
		$("#searchCreateForm").find("input[name='grpAcctAbbr']").addClass(
				"errorInput");
		$("#searchCreateForm").find("input[name='grpAcctAbbr']").attr("title",
				"请输入正确的缩写");
		validataInfo = false;
	}
	if (dedctFreq == "") {
		$("#searchCreateForm").find("[name='dedctFreq']")
				.addClass("errorInput");
		$("#searchCreateForm").find("[name='dedctFreq']").attr("title",
				"请选择扣款频率");
		validataInfo = false;
	}
	if (linkMainSupInd == "") {
		$("#searchCreateForm").find("[name='linkMainSupInd']").addClass(
				"errorInput");
		$("#searchCreateForm").find("[name='linkMainSupInd']").attr("title",
				"请选择是否关联主厂商");
		validataInfo = false;
	}
	if (degeeCondInd == "") {
		$("#searchCreateForm").find("[name='degeeCondInd']").addClass(
				"errorInput");
		$("#searchCreateForm").find("[name='degeeCondInd']").attr("title",
				"请选择递增条件科目");
		validataInfo = false;
	}
	if (usedForType == "") {
		$("#searchCreateForm").find("[name='usedForType']").addClass(
				"errorInput");
		$("#searchCreateForm").find("[name='usedForType']").attr("title",
				"请选择使用范围");
		validataInfo = false;
	}
	if (status == "") {
		$("#searchCreateForm").find("[name='status']").addClass("errorInput");
		$("#searchCreateForm").find("[name='status']")
				.attr("title", "请输入科目状态");
		validataInfo = false;
	}
	if (grpGrpAbbr == "") {
		$("#searchCreateForm").find("input[name='grpGrpAbbr']").addClass(
				"errorInput");
		$("#searchCreateForm").find("input[name='grpGrpAbbr']").attr("title",
				"请选择组别");
		validataInfo = false;
	}
	if (dedctValType == "") {
		$("#searchCreateForm").find("[name='dedctValType']").addClass(
				"errorInput");
		$("#searchCreateForm").find("[name='dedctValType']").attr("title",
				"请选择扣款单位");
		validataInfo = false;
	}
	if (calcBy == "") {
		$("#searchCreateForm").find("[name='calcBy']").addClass("errorInput");
		$("#searchCreateForm").find("[name='calcBy']")
				.attr("title", "请选择扣款计算方式");
		validataInfo = false;
	}
	if (feeType == "") {
		$("#searchCreateForm").find("[name='feeType']").addClass("errorInput");
		$("#searchCreateForm").find("[name='feeType']")
				.attr("title", "请选择费用类型");
		validataInfo = false;
	}
	$.each($(".p52_tb1").find(".ig"), function(index, obj) {
		var acctId = $.trim($(obj).find("input[name='acctId']").val());
		var vatNo = $.trim($(obj).find("[name='vatNo']").val());
		if (acctId == "") {
			$(obj).find("input[name='acctId']").addClass("errorInput");
			$(obj).find("input[name='acctId']").attr("title",
					"请输入正确的科目编号(数字)");
			 validataInfo = false;
		}
		if (vatNo == "") {
			$(obj).find("[name='vatNo']").addClass("errorInput");
			$(obj).find("[name='vatNo']").attr("title", "请选择税率");
			validataInfo = false;
		}
	});
	if($(".p52_tb1").find("input[name='acctId']").length==0){
		top.jAlert('warning','请至少添加一条科目编号','提示消息');
		return false;
	}
	return validataInfo;
}

//处理科目组编号，序号的错误的输入
function handleErrorInput(obj){
	$(obj).removeClass(
	"errorInput");
	$(obj).attr('title','');
	var objVal = $.trim($(obj).val());
	if(!isNumber(objVal)){
		top.jAlert("warning", "请输入数字", "提示消息",function(ret){
			if(ret){
				$(obj).attr('value', '');
				$(obj).focus();
			};
		});
		return false;
	};
	}
//处理目标单位相关逻辑
function handleCondValType(){
	var acctTmp = $($('#acctTmp').find('select')[1]).html();
	var condValType = $("#searchCreateForm").find('[name=condValType]').val();
	$.each($(".p52_tb1").find("[name='accCondValType']"), function(index, obj) {
		$(obj).html(acctTmp);
		if(condValType=='A'){
			$(obj).find('option').not("option[value='A']").remove();
		}
		if(condValType=='P'){
			$(obj).find('option').not("option[value='P']").remove();
		}
		if(condValType==''){
			$(obj).find('option').not("option[value='']").remove();
		}
		if(condValType=='A,P'){
			$(obj).find("option[value='']").remove();
			$(obj).find("option[value='A,P']").remove();
		}
	});
}
	
//新增或修改页面保存
function pageSave(action) {
	var param = $("#searchCreateForm").serialize();
	var url='';
	if(action =='create'){
		 url=ctx + '/supplier/contract/acctGroup/doCreate';
	}
	else{
		 url=ctx + '/supplier/contract/acctGroup/doUpdate';
	}
	$.post(url, param, function(data) {
		  if(data.status=="success"){
			  top.jAlert("success",data.message,"提示消息",function(ret){
				  closePopupWin(600, 500,
					'/supplier/contract/acctGroup/create');
				  searchFormSubmit();
			  });
		  }
		  else{
			  top.jAlert("warning",data.message,"提示消息");
		  }
	}, 'json');
}

//去除数据为空时的数据标红样式
function RmerrorInput(obj) {
	$(obj).removeClass(
	"errorInput");
	$(obj).attr('title','');
}

//添加科目编号
function addAccId(conbnAcctNo,vatNo,condValType) {
	var condValType = $("#searchCreateForm").find('[name=condValType]').val();
	var acctTmp = $('#acctTmp').clone().find('div')[0];
	$($(acctTmp).find('input')[1]).attr('value',conbnAcctNo);
	$($(acctTmp).find('select')[0]).attr('value',vatNo);
	$($(acctTmp).find('select')[1]).attr('value',condValType);
	if(condValType=='A'){
		$($(acctTmp).find('select')[1]).find('option').not("option[value='A']").remove();
	}
	if(condValType=='P'){
		$($(acctTmp).find('select')[1]).find('option').not("option[value='P']").remove();
	}
	if(condValType==''){
		$($(acctTmp).find('select')[1]).find('option').not("option[value='']").remove();
	}
	if(condValType=='A,P'){
		$($(acctTmp).find('select')[1]).find("option[value='']").remove();
		$($(acctTmp).find('select')[1]).find("option[value='A,P']").remove();
	}
	$('.p52_tb1').append(acctTmp);
}
//删除勾选项科目编号
function removeAccId() {
	if($(".isChecks:checked").length>0){
	$.each($(".p52_tb1").find(".isChecks"), function(index, obj) {
		if ($(obj).attr("checked") == "checked") {
			$(obj).parent().remove();
		}
	});
   }
	else{
		top.jAlert("warning","请至少勾选一条科目编号","提示消息");
		return false;
	}
	if($(".p52_tb1").find(".isChecks").length==0){
		$(".isCheckAllss").removeAttr("checked");
	}
	if($(".p52_tb1").find(".isChecks:checked").length==0){
		$(".isCheckAllss").removeAttr("checked");
	}
}
// 全选科目编号
function selectAllAcc(obj) {
	if ($(obj).attr("checked") == "checked") {
		$(".p52_tb1").find(".isChecks").attr("checked", "checked");
	} else {
		$(".p52_tb1").find(".isChecks").removeAttr("checked");
	}
}
//当多选框全(不)勾选时，全选框自动(不)勾选;
function chooseSelectAll(){
	var flag1=true;
	$.each($(".p52_tb1").find(".isChecks"), function(index, obj) {
		if ($(obj).attr("checked") != "checked") {
			  flag1=false;
			  $(".isCheckAllss").removeAttr("checked");
			  return false;
		}
	});
	if(flag1){
		$(".isCheckAllss").attr("checked","checked");
	}
	/*var flag2=false; 
	$.each($(".p52_tb1").find(".isChecks"), function(index, obj) {
		if ($(obj).attr("checked") == "checked") {
			  flag2=true;
			  return false;
		}
	});
	if(!flag2){
		$(".isCheckAllss").removeAttr("checked");
	}
	*/
}
