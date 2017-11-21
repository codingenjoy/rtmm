<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
// 存储订单商品信息及相应订单商品门店信息
var orderItemArr=[];
//课别添加弹出层事件
$("[name=addCatlgId]").unbind("click focus").bind("click focus", function() {
	//打开弹出层
	openPopupWin(600, 500, '/commons/window/chooseSection');
		});

//厂商信息弹出层
$("[name=addSupId]").unbind("click focus").bind("click focus", function() {
	var catlgId=$('#addCatlgId').val();
	if(catlgId=="")
	{
		top.jWarningAlert('请选择课别！');
		return;
	}
	if(typeof(supInfo)!="undefined")supInfo="";
	//打开弹出层
	openPopupWin(660, 548, '/item/batchupdate/itemManufacturerSelectWindowAction?catlgId='+catlgId);
		});


//订单添加弹出层事件
$("[name=addOrderItem]").unbind("click focus").bind("click focus", function() {
	var catlgId=$('#addCatlgId').val();
	var catlgName=encodeURI(encodeURI($('#addCatlgName').val()));
	if(catlgId=="")
	{
		top.jWarningAlert('请选择课别！');
		return;
	}
	var addSupId=$('#addSupId').val();
	if(addSupId=="")
	{
		top.jWarningAlert('请选择厂商！');
		return;
	}
	//打开弹出层
	openPopupWin(660, 550, '/hoOrderCreate/addOrderItem?catlgId='+catlgId+'&catlgName='+catlgName+'&supNo='+addSupId);
		});
//订单输入弹出层事件
$("[name=addOrderPasteItem]").unbind("click focus").bind("click focus", function() {
	var catlgId=$('#addCatlgId').val();
	if(catlgId=="")
	{
		top.jWarningAlert('请选择课别！');
		return;
	}
	//打开弹出层
	openPopupWin(650, 500, '/hoOrderCreate/addOrderPasteItem');
		});

//课别回调信息
function confirmChooseSection(id, name) {
	$('#addCatlgId').attr('value', id);
	$('#addCatlgName').attr('value', name);
	//关闭弹出层
	closePopupWin();
}

//厂商信息
function saveManufacturerNo(){
	if(typeof(readSupInfo)!="undefined"){ 
	//回调信息
	readSupInfo(function(id,name){
		var catlgId=$('#addCatlgId').val();
		$('#addSupId').attr('value', id);
		$('#addSupName').attr('value', name);
		if(typeof(id)!="undefined"&&id!=""&&typeof(catlgId)!="undefined"&&catlgId!="")
		{
		$.ajax({
			async : false,
			url : ctx + '/hoOrderCreate/getSupDiscInfo?ti='+(new Date()).getTime(),
			data : {'supNo':id,'catlgId':catlgId},
			type : 'POST',
			success : function(response) {
				var supplier=response["row"];
				if(supplier!=null&&supplier!="")
				{
				$("#bpDisc").val(supplier.bpdisc);
				}
			
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jErrorAlert('网络超时!请稍后重试');
			}
		});
		}
		
		});
	}
	//关闭弹出层
	closePopupWin();
}

//回调函数
function saveHoOrderItemNo(){
	var itemNoArr=[];
	$('input[name="itemNoCk"]:checked').each(function() {
		itemNoArr.push($(this).val());
     });
	if(itemNoArr.length<=0)
	{
		top.jWarningAlert("请选择要添加的订单商品");
		return;
	}
	else
	{
		$.ajax({
			async : false,
			url : ctx + '/hoOrderCreate/getHoOrderItemList?ti='+(new Date()).getTime(),
			data : {'itemNo':itemNoArr.join(",")},
			type : 'POST',
			success : function(response) {
				var itemList=response["row"];
				if(itemList==null)
				{
					 return;
				}
				var htmlStr=$("#pro_store_tb_edit").html();
				$("#pro_store_tb_edit").html("");
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
						continue;
					}
					var orderItemJs={};
					orderItemJs.itemNo=item.itemNo;
					orderItemJs.itemName=item.itemName;
					orderItemJs.itemEnName=item.itemEnName;
					orderItemJs.sellUnit=item.sellUnit;
					orderItemJs.buyMethd=item.buyMethd;
					orderItemJs.buyWhen=item.buyWhen;
					orderItemJs.orderItemStoreArr=[];
					
					orderItemArr.push(orderItemJs);
				    var sellUnitName=getDictValue('UNIT',item.sellUnit);

					htmlStr+="<div class='item'>";
					htmlStr+="<input type='text' name='itemNo' value='"+item.itemNo+"' class='inputText pedit_f Black' />";
					htmlStr+="<input type='text' name='itemName' value='"+item.itemName+"' class='inputText w20 fl_left Black' />";     
					htmlStr+="<input type='text' name='itemEnName' value='"+item.itemEnName+"' class='inputText w25 fl_left Black' />";
					htmlStr+="<input type='text' name='sellUnit' value='"+sellUnitName+"' class='inputText w10 fl_left Black' />";
					htmlStr+="<input type='text' name='buyMethd' value='"+item.buyMethd+"' class='inputText pedit_fth Black' />";
					htmlStr+="<input type='text' name='buyWhen' value='"+item.buyWhen+"' class='inputText w15 fl_left Black' />";
					htmlStr+="<div class='pstb_del'></div>";  
					htmlStr+="</div>";
                
				}
				
			    $("#pro_store_tb_edit").html(htmlStr);
			    //关闭弹出层
				closePopupWin();
			
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				jErrorAlert('网络超时!请稍后重试');
			}
		});
	}
	
	
}

</script>