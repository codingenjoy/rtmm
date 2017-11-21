//课别添加弹出层事件
function selectCatlg(){
	//打开弹出层
	openPopupWin(600, 500, '/commons/window/chooseSection');
}

//课别回调信息
function confirmChooseSection(id, name) {
	$('#catlgId').attr('value', id);
	$('#addCatlgName').attr('value', name);
	//关闭弹出层
	closePopupWin();
}

//厂商信息弹出层
function selectSup(){
	//打开弹出层
	openPopupWin(550, 510,'/commons/window/chooseSupNo?callback=confirmChooseSupNo');
}

//厂商信息回调
function confirmChooseSupNo(supNo, comName) {
	$('#supNo').attr('value', supNo);
	$('#supName').attr('value', comName);
	$('#supName').attr('title', comName);
	//关闭弹出层
	closePopupWin();
}

function resetCheckAll(obj) {
	if (obj.find('input:checkbox:not(:checked)').size()!=0 || obj.find('input:checkbox:checked').size()==0) {
		obj.prev().find('.checkAll').attr('checked', false);
	} else if (obj.find('input:checkbox:not(:checked)').size() == 0) {
		obj.prev().find('.checkAll').attr('checked', true);
	}
}

function addNewOrderItem(obj) {
	
	if(!chkMustInputItem())
	{
		return;
	}
	
	obj.append($('#orderItemTemplate').html());
	$("#pro_store_tb_edit").find(".item:last").find('input[name="itemNo"]').unbind('change').bind('change',function() {
		newOrderItemHandler($(this));
	});			
	$("#pro_store_tb_edit").find(".item:last").find('input[name="itemNo"]').unbind('keydown').bind('keydown',function(e) {
	if (e.keyCode == 13) {
		newOrderItemHandler($(this));
		return false;
		}
	});
	obj.find(".item_on").removeClass("item_on");
	$("#pro_store_tb_edit").find(".item:last").addClass("item_on");
	$("#pro_store_tb_edit").find(".item:last").click();
}

function newOrderItemHandler(obj) {
	var curItemNo = $.trim($(obj).val());
	var curParent = $(obj).parent();
	var catlgId = $('#catlgId').val();
	var supId = $('#supId').val();
	var itemNoArr=[];
	var getItemFlag=false;
	$(obj).val(curItemNo);
	if (curItemNo == "") {
		top.jAlert("warning", "请输入商品号", "提示消息");
		return false;
	}
	if(!isNumber(curItemNo))
	{
		top.jAlert("warning", "请输入数字", "提示消息");
		return false;
	}

	itemNoArr.push(curItemNo);

	$.ajax({
		async : false,
		url : ctx + '/hoOrderCreate/getHoOrderItemList?ti='+(new Date()).getTime(),
		data : {'itemNo':itemNoArr.join(","),supNo:supId,catlgId:catlgId},
		type : 'POST',
		success : function(response) {
			if (response.status == 'success') {
				
				var itemList=response["row"];
				var buyer=response["buyer"];
				if(orderItemArr.length==0)
				{
					$("#buyer").val(buyer.buyer);
					$("#buyerName").val(buyer.buyerName);
				}

				for(var i=0;i<itemList.length;i++)
				{
					var item=itemList[i];
					/** 判断订单商品是否已经添加 已经添加不再添加 **/
					var flag=false;
					for(var j=0;j<orderItemArr.length;j++)
					{
						 var beforeOrderItemArr=orderItemArr[j];
						 if(beforeOrderItemArr.itemNo==item.itemNo)
						   {
							 flag=true;
						   }
					}
					if(flag)
					{
						top.jAlert("warning", "该货号已存在 请重新输入", "提示消息");
						curParent.find('input[name="itemNo"]').attr('value',"");
						return false;
					}
					var orderItemJs={};
					orderItemJs.itemNo=item.itemNo;
					orderItemJs.itemName=item.itemName;
					orderItemJs.itemEnName=item.itemEnName;
					if(item.itemEnName==null)
					{
						item.itemEnName = "";
					}
					
					orderItemJs.sellUnit=item.sellUnit;
					orderItemJs.buyMethd=item.buyMethd;
					orderItemJs.buyWhen=item.buyWhen;
					orderItemJs.orderItemStoreArr=[];
					
					orderItemArr.push(orderItemJs);
					var sellUnitName=getDictValue('UNIT',item.sellUnit);
					var buyMethdName=getDictValue('ITEM_BASIC_BUY_METHD',item.buyMethd);
					var buyWhenName=getDictValue('ITEM_BASIC_BUY_WHEN',item.buyWhen);
					
					curParent.find('input[name="itemType"]').attr('value',item.itemType);			
					curParent.find('input[name="itemNo"]').attr('value',item.itemNo).attr('readonly','readonly').removeClass('mustInput').addClass('Black').unbind();
					curParent.find('input[name="itemName"]').attr('value',item.itemName);
					curParent.find('input[name="itemEnName"]').attr('value',item.itemEnName);
					curParent.find('input[name="sellUnit"]').attr('value',sellUnitName);
					curParent.find('input[name="buyMethd"]').attr('value',buyMethdName);
					curParent.find('input[name="buyWhen"]').attr('value',buyWhenName).attr('realvalue',item.buyWhen);
				}
				getItemFlag=true;
				
			}
			else
			{
				if (response.message) {
					top.jAlert('warning', response.message, '消息提示');					
				}
				$(obj).attr('value','');
			}					
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			top.jAlert('error', '网络超时!请稍后重试', '提示消息');
		}
	});
	if(getItemFlag)
	{
		$("#pro_store_tb_edit").find(".item:last").click();
	}
	return getItemFlag;

}

function chkMustInputItem()
{
	if ($("#pro_store_tb_edit").find('.mustInput').length > 0)
	{
		top.jAlert('warning', '请输入商品号', '提示消息');
		return false;
	}
	return true;
}

function isFloat(val,intval,scale){
//	if(/^\d+[.]{0,1}\d*$/.test(val))
//	{
//		return true;
//	}
	var reg = new RegExp("^([1-9][0-9]{0,"+intval+"}|0)([.][0-9]{1,"+scale+"})?$");
	if(reg.test(val))
	{
		return true;
	}
	return false;
}
