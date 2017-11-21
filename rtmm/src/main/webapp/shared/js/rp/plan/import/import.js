//RP導入保留計畫 toolbar 初始化
function initEnventForRpImport(){
	$("#Tools2").removeClass("Tools2").addClass("Tools2_disable");
	$("#Tools23").removeClass("Tools23").addClass("Tools23_disable");
	$('#Tools2, #Tools23').die().unbind().bind('click',function(){
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
		case 'Tools2':submitImportRp();break;
	}
}
/**
 * 顯示導入成功列表
 */
function displayInvalid(){
	$("#validContent").hide();
	$("#invalidContent").show();
}

/**
 * 顯示導入錯誤列表
 */
function displayValid(){
	$("#validContent").show();
	$("#invalidContent").hide();
}

/**
 * 顯示分店詳情彈出框
 * @param processId
 * @param itemNo
 */
function showStoreDetail(processId, itemNo){
	if ($("#validForm #"+ itemNo).find(".inputError").length == 0){
		var ordMultiParm = $("#validForm #"+ itemNo).find("input[name=ordMultiParm]").val();
		openPopupWin(614,437, '/rp/plan/showStoreDetail?processId='+processId+'&itemNo='+itemNo +'&ordMultiParm='+ordMultiParm);
	}
	else{
		jWarningAlert("请先修正标红栏位");
	}
}

/**
 * 檢查分店訂購數量是否大於零, 並且將訂購數量修改訂購倍數的倍數
 * @param obj
 * @param ordMultiParm
 */
function checkStoreQty(obj, ordMultiParm){
	if (!valFloatNumOnBlur(obj, 6, 4)){
		return;
	}
	if ($(obj).val()=='' || parseInt($(obj).val()) == 0){
		$(obj).addClass("errorInput");
		$(obj).attr("title", "订购数量必须大于0");
		return ;
	}
	var quantity = parseFloat($(obj).val());
	if (quantity != null){
		if (quantity % ordMultiParm != 0){
			quantity = ordMultiParm * (Math.ceil(quantity/ordMultiParm));
			$(obj).val(quantity);
		}
	}
}

/**
 * 計算分店詳情彈出框裡的總訂購數量 和總金額
 */
function calculateTotalStoreQty(){
	var totalQty = 0;
	$("#lRpItemValidStore input[name=storeQty]").each(function(){
		totalQty = parseInt($(this).val())+ totalQty;
	});
	$("#lRpItemValidStore #totalOrdQty").val(totalQty);
	
	var totalAmnt = 0;
	var itemNo = $("#lRpItemValidStore input[name=itemNo").val();
	var buyPrice = $("#validForm #"+ itemNo).find("input[name=buyPrice]").val();
	
	totalAmnt = parseFloat(buyPrice) * totalQty;
	$("#lRpItemValidStore #totalOrdAmnt").val(totalAmnt);
	$("#lRpItemValidStore #buyPrice").val(buyPrice);
	
	return;
}

/**
 * 將分店訂購數量寫回資料庫
 * @returns {Boolean}
 */
function updateStoreDetail(){
	if ($("#lRpItemValidStore").find('.errorInput').length>0){
		return false;
	}
	// 算訂購總數
	calculateTotalStoreQty();
	
	var formData = $("#lRpItemValidStore").serialize();
	$.post(ctx + '/rp/plan/updateLRpStoreDetail',formData, function(data){
		if (data.status == 'success'){
			closePopupWin();
			// 重新計算該商品的 "商品總建議量" 和 "商品總金額"
			var itemNo = data.content.itemNo;
			var itemOrdQty = data.content.totalOrdQty;
			var itemOrdAmnt = data.content.totalOrdAmnt;
			updateTotQty(itemNo, itemOrdQty);
			updateTotAmnt(itemNo, itemOrdAmnt);
		}else{
			jWarningAlert("保存失败");
		}
	},'json');
}

/**
 * input 框只能輸入整數值, 且不為空
 */
function inputToInputIntNumber() {
	$("input.count_text").each(function() {
		$(this).focus(function(){
			$(this).removeAttr("title");
			$(this).removeClass("errorInput");
		});
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

/**
 * 保存導入結果入口
 */
function submitImportRp(){
	if ($(':visible .errorInput').length > 0){
		top.jAlert('warning','请修正标红栏位','消息提示');
		return;
	}
	if ($('#excelLines').val() != $("#successCount").val()){
		top.jConfirm('是否要忽略错误, 继续导入保留计划?', '提示消息', function(ret) {
			if (ret) {
				saveImportRP();
				return;
			}
			else{
				return;
			}
		});
	}
	else{
		saveImportRP();
	}
}

/**
 * 檢查有小數的 input
 * @param obj
 * @param Integer 整數長度
 * @param decimal 小數長度
 * @returns {Boolean}
 */
function valFloatNumOnBlur(obj, Integer, decimal) {
	var error = false;
	var message = "";
	if ( $(obj).val()!= "" && /^[0-9]{0,}[.]{0,1}[0-9]{0,}$/.test(obj.value)) {
		if (obj.value > 0) {
			if (obj.value.indexOf('.') == -1) {
				if (obj.value.length > Integer){
					error = true;
					message = "请输入小于或等于" + Integer + "位的数字" ; 
				}
			} else {
				var index = obj.value.indexOf('.');
				var integerVal = obj.value.substring(0, index);
				var decimalVal = obj.value.substring(index + 1,obj.value.length);
				if (integerVal.length > Integer) {
					error = true;
					message = "整数位数需小于或等于" + Integer + "位" ;
				} else if(decimalVal == "" || parseInt(decimalVal) == 0){
					$(obj).val(integerVal);
				} else if (decimalVal.length > decimal) {
					
					error = true;
					message = "小数位数需小于或等于" + decimal + "位" ;
				}
				
			}
		} else {
			error = true;
			message = "请输入大于0的数字" ;
		}
	} else {
		error = true;
		message = "请输入合法数字" ;
	}
	
	if (error){
		$(obj).addClass("errorInput");
		$(obj).attr("title", message);
		return false;
	}
	return true;
}


/**
 * 保存導入
 */
function saveImportRP(){
	var formData = $("#validForm").serialize();
	$.post(ctx + '/rp/plan/saveToRpPlan',formData, function(data){
		if (data.status == 'success'){
			jSuccessAlert(data.message);
			var parmData = {
					rpNo:data.content
			};
			// 進去下一頁
			$.post(ctx + '/rp/plan/afterSubmit', parmData, function(data){
				$(".newTitle").text("新保留计划导入結果");
				$(".CInfo").remove();
				$("#detailDiv").html(data);
			}, 'html');
		}else{
			jWarningAlert("保存失败");
		}
	},'json');
}
/**
 * 更新 "商品的總建議量" 和整筆導入的 "訂購總數量"
 * @param itemNo
 * @param newQty
 */
function updateTotQty(itemNo, newQty){
	var preQty = parseFloat($("#validForm #"+ itemNo).find("input[name=initTotQty]").val());
	// 更新隱藏的 input
	$("#validForm #"+ itemNo).find("input[name=initTotQty]").val(newQty);
	// 更新訂購總數量
	var newTotQty = parseFloat($("#validBasicInfo #totalQuantity").val()) - parseFloat(preQty) + parseFloat(newQty);
	$("#validBasicInfo #totalQuantity").val(newTotQty);
	$("#validForm #"+ itemNo).find("input[name=initTotQty]").trigger("change");
}

/**
 * 更新 "商品的總金額" 和整筆導入的 "訂購總金額"
 * @param itemNo
 * @param newAmnt 可為空
 * @param obj 可為空
 */
function updateTotAmnt(itemNo, newAmnt){
	var preAmnt = $("#validForm #"+ itemNo).find("input[name=initTotAmnt]").val();
	// 如果沒有傳進新的訂購金額, 那就算一下
	if (!newAmnt){
		var qty = parseFloat($("#validForm #"+ itemNo).find("input[name=initTotQty]").val());
		var buyPrice = parseFloat($("#validForm #"+ itemNo).find("#buyPrice").val());
		newAmnt = (buyPrice * qty).toFixed(2);
	}else{
		newAmnt = parseFloat(newAmnt).toFixed(2);
	}
	// 更新隱藏的 input
	$("#validForm #"+ itemNo).find("input[name=initTotAmnt]").val(newAmnt);
	// 更新訂購總數量
	var newTotAmnt = parseFloat($("#validBasicInfo #totalAmount").val()) - parseFloat(preAmnt) + parseFloat(newAmnt);
	$("#validBasicInfo #totalAmount").val(newTotAmnt.toFixed(2));
	$("#validForm #"+ itemNo).find("input[name=initTotAmnt]").trigger("change");
}

/**
 * 當 hidden input 的 totQty 更新的時候, 同時更新顯示在頁面上的商品總建議量
 * @param itemNo
 */
function updateDisplayQty(itemNo, obj){
	$("#validForm #"+ itemNo).find("#initTotQty").text($(obj).val());
}

/**
 * 當 hidden input 的 totAmnt 更新的時候, 同時更新顯示在頁面上的商品總金額
 * @param itemNo
 * @param obj
 */
function updateDisplayAmnt(itemNo, obj){
	$("#validForm #"+ itemNo).find("#initTotAmnt").text($(obj).val());
}

/**
 * 確認是否要修改訂購倍數
 * @param processId
 * @param itemNo
 * @param obj
 */
function updateMultiParm(processId, itemNo, obj){
	if (obj.oldvalue != obj.value){
		if (obj.value == ""){
			$(obj).attr("title", "订购倍数不可为空");
			$(obj).addClass("errorInput");
			return;
		}
		top.jConfirm('若修改订购倍数，将自动更新分店的订购数量。是否继续？', '提示消息', function(ret) {
			if (ret) {
				var buyPrice = $("#validForm #"+ itemNo).find("input[name=buyPrice]").val();
				upateStoreOrdQty(processId, itemNo, obj.value, buyPrice);
				return;
			}
			else{
				// 若取消修改, 則還原成舊值
				obj.value = obj.oldvalue;
				return;
			}
		});
	}
	return;
}

/**
 * 修改訂購倍數, 重新計算分店訂購數量, 更新資料庫後, 傳回更新後的總計
 */
function upateStoreOrdQty(processId, itemNo, newOrdMultiParm, buyPrice){
	var sendData = {
			processId: processId,
			itemNo: itemNo,
			ordMultiParm: newOrdMultiParm,
			buyPrice: buyPrice
	};
	
	$.post(ctx + '/rp/plan/updateStoreOrdQty',sendData, function(data){
		if (data.status == 'success'){
			// 更新商品總建議量, 商品總金額
			var itemNo = data.CONTENT.itemNo;
			$("#validForm #"+ itemNo).find("input[name=initTotQty]").val(data.CONTENT.initTotQty);
			$("#validForm #"+ itemNo).find("input[name=initTotAmnt]").val( data.CONTENT.initTotAmnt);
			$("#validForm #"+ itemNo).find("input[name=initTotQty]").trigger("change");
			$("#validForm #"+ itemNo).find("input[name=initTotAmnt]").trigger("change");
			// 更新訂購總數量, 訂購總金額
			$("#validBasicInfo #totalQuantity").val(data.CONTENT.totQuantity);
			$("#validBasicInfo #totalAmount").val(data.CONTENT.totAmount);
			
		}else{
			jWarningAlert("更新失败");
		}
	},'json');
}
/**
 * 顯示導入錯誤的分店詳細內容
 * @param processId
 * @param itemNo
 */
function showStoreError(processId, itemNo){
	openPopupWin(614,437, '/rp/plan/showStoreError?processId='+processId+'&itemNo='+itemNo);
}

/**
 * 檢查 buyPrice 是否有高於正常買價
 * @param itemNo
 * @param obj
 */
function checkBuyPrice(itemNo, obj){
	// find normBuyPrice
	var normBuyPrice = $("#validForm #"+ itemNo).find("input[id=normBuyPrice]").val();
	if (!valFloatNumOnBlur(obj, 6,4)){
		return;
	}
	if (parseFloat(obj.value) > parseFloat(normBuyPrice)){
		$(obj).attr("title", "不可高於正常買價: " + normBuyPrice );
		$(obj).addClass("errorInput");
		return;
	}
	updateTotAmnt(itemNo);
}

function removeError(obj){
	$(obj).removeAttr("title");
	$(obj).removeClass("errorInput");
}
