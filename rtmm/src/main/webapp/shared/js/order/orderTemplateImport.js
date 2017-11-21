/*
 * Import HoOrder: remove the 'errorInput' class when 'onClick' is triggered
 */
function removeElements(obj){
	$(obj).removeClass('errorInput');
	$(obj).removeAttr('title');
}

/*
 * Import HoOrder: Save the imported order
 */
function saveImportOrder(){
	if ($(':visible .errorInput').length > 0){
		top.jAlert('warning','请修正标红栏位','消息提示');
		return;
	}
	if ($('#excelLines').val() != $("#successCount").val()){
		top.jConfirm('是否要忽略错误, 继续导入订单?', '提示消息', function(ret) {
			if (ret) {
				saveOrders();
				return;
			}
			else{
				return;
			}
		});
	}
	else{
		saveOrders();
	}
}

function saveOrders(){
	var formData = $('#orderForm').serialize();
	var url =  ctx+'/order/generateOrder';
	$.post(url, formData, function(data){
		if(data.status=='success'){
			$(".Container-1").load(ctx+'/order/getTempOrderPage?processId='+$('#orderForm input[name=processId]').val());	
		}else{
			top.jWarningAlert(data.message);
		}
	});
}

/*
 *Import HoOrder: Validate the decimal's length
 */
function valFloatNumOnBlur(obj,Integer,decimal){
	if(!obj){
		$(obj).removeClass('errorInput');
		$(obj).removeAttr('title');
		return false;
	}
	if(/^[0-9]{0,}[.]{0,1}[0-9]{0,}$/.test(obj.value)){
		$(obj).removeClass('errorInput');
		$(obj).removeAttr('title');
		if(obj.value>=0){
			$(obj).removeClass('errorInput');
			$(obj).removeAttr('title');
		if(obj.value.indexOf('.')==-1){
			if(obj.value.length>Integer){
				$(obj).addClass('errorInput');
				$(obj).attr("title","请输入小于或等于"+Integer+"位的数字");	
				return false;
			}
			else{
				$(obj).removeClass('errorInput');
				$(obj).removeAttr('title');
			}
		}
		else{
		   var index=obj.value.indexOf('.');
		   var integerVal=obj.value.substring(0,index);
		   var decimalVal=obj.value.substring(index+1,obj.value.length);
			if(integerVal.length>Integer){
				$(obj).addClass('errorInput');
				$(obj).attr("title","整数位数需小于或等于"+Integer+"位");
				return false;
           	}
			else{
				$(obj).removeClass('errorInput');
				$(obj).removeAttr('title');
				if(decimalVal.length>decimal){
					$(obj).addClass('errorInput');
					$(obj).attr("title","小数位数需小于或等于"+decimal+"位");
					return false;
				}
				else{
					$(obj).removeClass('errorInput');
					$(obj).removeAttr('title');
				}
			}
		}
		}
		else{
			$(obj).addClass('errorInput');
			$(obj).attr("title","请输入大于0的数字");	
			return false;
		}
	}
	else{
		$(obj).addClass('errorInput');
		$(obj).attr("title","请输入合法数字");
		return false;
	}
	/*if (obj.value == 0){
		$(obj).addClass('errorInput');
		$(obj).attr("title","订购数量不可为0");
		return false;
	}*/
	return true;
}
/*
 * Import HoOrder: Check the order quantity 
 */
function checkQty(ordMultiParm, obj){
	// 檢查倍數
	var quantity = $(obj).val();
	if (quantity != null){
		if (quantity % ordMultiParm != 0){
			quantity = ordMultiParm * (Math.ceil(quantity/ordMultiParm));
			$(obj).val(quantity);
		}
	}else{
		$(obj).addClass("errorInput");
		$(obj).attr("title", "請輸入訂購數量");
	}
}

/*
 *Import HoOrder: Calculate the total order quantity and the total purchase amount
 */
function calculate(ordMultiParm, buyPrice, obj){
	// 檢查是否為數字
	if (!checkIsNumber(obj)) {
		return false;
	}
	checkAgain(obj);
	checkQty(ordMultiParm, obj);
	// 更改後的訂購數量
	var qty = $(obj).val();
	// 原本的訂購數量
	var orgQty = $(obj).parent().parent().find("#orgOrdQty").val();
	if ( (qty-orgQty) != 0){
		//算訂購數差, 然後更新回訂購總數量
		var difference = orgQty - qty;
		var orgTotalQty = $("#totalQuantity").val();
		$("#totalQuantity").val(orgTotalQty - difference);
		$(obj).parent().parent().find("#orgOrdQty").val(qty);
		
		// 算差價, 然後更新回訂購總金額
		difference = (orgQty - qty) * buyPrice;
		var orgTotalAmount  = $("#totalAmount").val();
		var totalAmount = parseFloat(orgTotalAmount - difference).toFixed(2);
		$("#totalAmount").val(totalAmount);
	}
}

function presCalculate(itemType, obj){
	if (obj){
		if (!checkIsNumber(obj)){
			return false;
		}
		checkAgain(obj);
		if ( ($(obj).val()) && itemType != 1){
			var presOrdQty = $(obj).val();
			presOrdQty = Math.round(presOrdQty);
			$(obj).val(presOrdQty);
		}
		else if (($(obj).val()) && itemType == 1){
			valFloatNumOnBlur(obj,7,3);
		}
	}
}

function displayInvalid(){
	$("#validTag").attr("class", "order_item");
	$("#invalidTag").attr("class", "order_item item_on");
	$("#validArea").hide();
	$("#invalidArea").show();
	var failCount = $('#invalidArea').find("#failCount:first").val();
	if(failCount&&failCount>0){
		$("#Tools23").removeClass("Tools23_disable")
			.addClass("Tools23").unbind().bind("click",function(){
				exportFailOrderList($("#processId").val());
			});		  
	}
}


function exportFailOrderList(processId){
	var paramsObj = {
			'processId':processId
		};
	 exportReport('sync','113112005',paramsObj); 	
}

function displayValid(){
	
	$("#validTag").attr("class", "order_item item_on");
	$("#invalidTag").attr("class", "order_item");
	$("#invalidArea").hide();
	$("#validArea").show();
	$("#Tools23").removeClass("Tools23")
	.addClass("Tools23_disable").unbind();
	
}

function checkIsNumber(obj){
	if( /^[0-9]{0,}[.]{0,1}[0-9]{0,}$/.test(obj.value)){
		var presOrdQty = $(obj).parent().parent().find('.presOrdQty').val();
		var ordQty = $(obj).parent().parent().find('.ordQty').val();
		
		if ((ordQty != "" && parseFloat(ordQty)!=0) || (presOrdQty != "" && parseFloat(presOrdQty) != 0  ) ){
			$(obj).removeAttr("title");
			$(obj).removeClass("errorInput");
			return true;
		}
		else{
			$(obj).attr("title", "订购数量与赠品数量不可都为空");
		}
	}
	else{
		$(obj).attr("title", "请输入数字");
	}
	$(obj).addClass("errorInput");
}

function checkAgain(obj){
	var ordQty = $(obj).parent().parent().find('.ordQty');
	var presOrdQty = $(obj).parent().parent().find('.presOrdQty');
	if ($(ordQty).attr('title')== '订购数量与赠品数量不可都为空' || $(presOrdQty).attr('title')== '订购数量与赠品数量不可都为空'){
		$(ordQty).removeAttr('title');
		$(ordQty).removeClass('errorInput');
		$(presOrdQty).removeAttr('title');
		$(presOrdQty).removeClass('errorInput');
	}
}

