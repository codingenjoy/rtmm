/**
 * 课别添加弹出层事件
 */
function selectCatlg() {
	//打开弹出层
	openPopupWin(600, 500, '/commons/window/chooseSection');
}

/**
 * 课别回调信息
 * @param id
 * @param name
 */
function confirmChooseSection(id, name) {
	$('#catlgId').attr('value', id);
	$('#catlgName').attr('value', name);
	//关闭弹出层
	closePopupWin();
}

/**
 * 厂商信息弹出层
 */
function selectSup() {
	//打开弹出层
	openPopupWin(550, 510,
			'/commons/window/chooseSupNo?callback=confirmChooseSupNo');
}

/**
 * 厂商信息回调
 * @param supNo
 * @param comName
 */
function confirmChooseSupNo(supNo, comName) {
	$('#supNo').attr('value', supNo);
	$('#supName').attr('value', comName);
	$('#supName').attr('title', comName);
	//关闭弹出层
	closePopupWin();
}

/**
 * 验证信息
 * @returns {Boolean}
 */
function validata() {
	var ordNo = $.trim($("#ordNo").val());
	var bpDiscBegin = $.trim($("#bpDiscBegin").val());
	var bpDiscEnd = $.trim($("#bpDiscEnd").val());
	var secNo = $.trim($("#catlgId").val());
	var supNo = $.trim($("#supNo").val());

	var validataInfo = true;
	if (ordNo != '' && !isNumber(ordNo)) {
		$("#ordNo").addClass("errorInput");
		$("#ordNo").attr("title", "请输入正确的订单号(数字)");
		validataInfo = false;
	}
	if (bpDiscBegin != '' && !isNumber(bpDiscBegin)) {
		$("#bpDiscBegin").addClass("errorInput");
		$("#bpDiscBegin").attr("title", "请输入正确的折扣率");
		validataInfo = false;
	}
	if (bpDiscEnd != '' && !isNumber(bpDiscEnd)) {
		$("#bpDiscEnd").addClass("errorInput");
		$("#bpDiscEnd").attr("title", "请输入正确的折扣率");
		validataInfo = false;
	}
	if (secNo != '' && !isNumber(secNo)) {
		$("#catlgId").addClass("errorInput");
		$("#catlgId").attr("title", "请输入正确的课别号信息");
		validataInfo = false;
	}
	if (supNo != '' && !isNumber(supNo)) {
		$("#supNo").addClass("errorInput");
		$("#supNo").attr("title", "请输入正确的厂编信息");
		validataInfo = false;
	}
	if(ifHaveErrorInputInSearch()){
		validataInfo = false;
	}
	return validataInfo;
}

/**
 * 检测
 */
$(".inputNmuber").each(function(index, item) {
	$(this).focus(function() {
		$(this).removeClass("errorInput");
	});
});

function loadCatlgName() {
	var catlgId = $('#catlgId').val();
	if (catlgId != '') {
		//加载课别信息
		readCatalogInfoBySecNo(catlgId, function(data) {
			if (data != "" && data.length > 0) {
				$("#catlgName").val(data[0].secName);
				//search();
			} else {
				$("#catlgId").val('');
				$("#catlgName").val('');
				top.jAlert('warning', '该课别不存在', '提示消息');
				return false;

			}
		});
	} else {
		$("#catlgName").val('');
	}
}

function loadSupName() {
	var catlgId = $('#catlgId').val();
	var supNo = $('#supNo').val();
	if (supNo != '') {
		readSupInfoBySupNo(catlgId, supNo, function(data) {
			if (data != "" && data.length > 0) {
				$("#supName").val(data[0].comName);
				//search();
			} else {
				$("#supNo").val('');
				$("#supName").val('');
				top.jAlert('warning', '该厂商不存在', '提示消息');

			}
		});
	} else {
		$("#addSupName").val('');
	}
}

/**
 * 厂商选项
 */
$("#supNo").unbind("blur").blur(function() {
	loadSupName();
});

/**
 * 清空搜尋框
 */
function clean_form() {
	//将日期文本域重置为空, 以及帶出的課別和廠商中文名稱,其他元素的重置在common.js中使用clean_from清空
	$('.clean_from .Wdate').removeClass('errorInput');
	$('.clean_from .Wdate').attr('title','');
	$('.clean_from .Wdate').attr('value', '');
	$("#catlgName").attr('value', '');
	$("#supName").attr('value', '');
}

/**
 * 切換成 詳情頁面
 * @param obj
 */
function orderDetail(obj) {
	// 隱藏列表清單的div
	$("#hoOrderListView").hide();
	$("#hoOrderListTag").hide();

	// 顯示詳情頁面的div
	$("#hoOrderDetailView").show();
	$("#hoOrderDetailTag").show();
	$("#Tools1").removeClass("Tools1").addClass("Tools1_disable").off();
	var param = {
		'ordNo' : $(obj).find("#ordNo").text()
	};
	var url = ctx + "/order/hoOrderDetail";
	$.post(url, param, function(data) {
		$("#hoOrderDetailView").html(data);
	}, 'html');
}

/**
 * 勾選多選框時, 點亮 delete icon 
 */
function countChecked() {
	checkSelectAll();
	if ($(".inputDiv input[type=checkbox]:checked:visible").length > 0) {
		checkDeletePrivilege();
	} else{
		$("#Tools10").removeClass("Tools10").addClass("Tools10_disable");
		$("#Tools10").off("click");
	}	
}

/**
 * 刪除訂單
 */
function deleteOrder() {
	var ids = $("#hoOrder_tab_List [type=checkbox]:checked:visible");
	var ordNoList = [];
	$.each(ids, function(key, value) {
		ordNoList.push(value.id);
	});
	var param = {
		ordNoList : ordNoList.toString()
	};
	var url = ctx + "/order/deleteOrder";
	$.post(url, param, function(data) {
		top.jAlert("success", "已删除" +data.count+ "笔订单" , "提示消息");
		pageQuery();
		toolbar.disable('Tools12');
	}, 'json');

}
/**
 * 上面全選框勾選時, 選取所有底下的多選框
 * @param obj
 */
function selectAllHoOrder(obj){
	if ($(obj).attr("checked") == "checked"){
		$("input[name=hoOrderCheck]").attr("checked","checked");
	}else{
		$("input[name=hoOrderCheck]").removeAttr("checked");
	}
	countChecked();
}

/**
 * 檢查上面全選框要不要勾選
 */
function checkSelectAll(){
	if ($("#hoOrder_tab_List tr").length> 0 && ($("#hoOrder_tab_List input[type=checkbox]:checked").length == $("#hoOrder_tab_List tr").length) ){
		$(".t_cols input[type=checkbox]:visible").attr("checked", "checked");
	}
	else{
		$(".t_cols input[type=checkbox]:visible").removeAttr("checked");
	}
}

/**
 *check the validity of the hoOrderPlanRecptEndDate.
 */
function hoOrderPlanRecptEndDateQuery(dp){
	$("#planRecptDateEnd").attr('title','');
	$("#planRecptDateEnd").removeClass('errorInput');
	var planRecptBeginDate=$("#planRecptDateBegin").val();
	var planRecptEndDate= dp.cal.getNewDateStr();
	if(planRecptBeginDate){		
		var subDays=getSubDays(planRecptBeginDate,planRecptEndDate);
		if(subDays<0){
			$("#planRecptDateEnd").attr('title','结束日期小于开始日期');
			$("#planRecptDateEnd").addClass('errorInput');
			return false;
		}
	} 
}

/**
 *check the validity of the hoOrderPlanRecptStartDate.
 */
function hoOrderPlanRecptStartDateQuery(dp){
	$("#planRecptDateEnd").attr('title','');
	$("#planRecptDateEnd").removeClass('errorInput');
	var planRecptEndDate=$("#planRecptDateEnd").val();
	var planRecptBeginDate= dp.cal.getNewDateStr();
	if(planRecptEndDate){		
		var subDays=getSubDays(planRecptBeginDate,planRecptEndDate);
		if(subDays<0){
			$("#planRecptDateEnd").attr('title','结束日期小于开始日期');
			$("#planRecptDateEnd").addClass('errorInput');
			return false;
		}
	} 
}
