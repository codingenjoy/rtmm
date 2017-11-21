/**
 * 存储订单商品信息及相应订单商品门店信息
 */
var orderItemArr = [];
var orderStoreArr = [];

Array.prototype.del = function(n) {
	if (n < 0)
		return this;
	else
		return this.slice(0, n).concat(this.slice(n + 1, this.length));
};

$('#catlgId').each(function(){
	$(this).keydown(function (e) {
		if (e.keyCode == 13) {
			$(this).change();
		}
	});
});

$('#supId').each(function(){
	$(this).keydown(function (e) {
		if (e.keyCode == 13) {
			$(this).change();
		}
	});
});

$(function() {
	$(".pstb_del2,.pstb_del").die("click");
	$("#Tools2").removeClass("Tools2_disable");
	$("#Tools2").addClass("Icon-size1 Tools2");
});


$("#catlgId").bind("focus", function() {
	$("#catlgId").removeClass("errorInput");
	$("#catlgId").removeAttr("title");
});
$("#supId").bind("focus", function() {
	$("#supId").removeClass("errorInput");
	$("#supId").removeAttr("title");
});
$("#planRecptDate").bind("focus", function() {
	$("#planRecptDate").removeClass("errorInput");
	$("#planRecptDate").removeAttr("title");

});
$("#Tools2").unbind().bind("click",function(){
	var error=0;
	var addCatlgId=$("#catlgId").val();

	if(!chkMustInputItem())
	{
		return;
	}
	if($.trim(addCatlgId)=='')
	{
		$("#catlgId").removeClass("errorInput").addClass(
			'errorInput');
		$("#catlgId").attr("title",'请选择课别!');
		error++;
    }
	var addSupId=$("#supId").val();
	if($.trim(addSupId)=='')
	{
		$("#supId").removeClass("errorInput").addClass(
			'errorInput');
		$("#supId").attr("title",'请选择厂商!');
		error++;
    }
	
	var planRecptDate=$("#planRecptDate").val();
	if($.trim(planRecptDate)=='')
	{
		$("#planRecptDate").removeClass("errorInput").addClass(
			'errorInput');
		$("#planRecptDate").attr("title",'请输入预订收货日期!');
		error++;
    }
		
	if(error>0)
	{
	 return;
	}
	var flag=true;
	  $.ajax({
		    async:false,
	    	url: ctx + '/hoOrderCreate/checkTime?planRecptDate='+planRecptDate,
			type: "post",
			dataType:"json",
			success: function(result) {
			    if(result.message!=null && result.message !="success"){
			    	top.jAlert('warning', result.message, '提示消息');
			    	flag=false;
			    }    	
			}
	    });
	  if(!flag)
		{
	       return;
		}
	if(orderItemArr.length==0)
		{
		top.jAlert('warning', '请添加订单商品！', '消息提示');
        return;
		}
	
	
	var buyer=$("#buyer").val();
	if(buyer=="")
	{
		top.jAlert('warning', '采购为空，请联系管理员！', '消息提示');
        return;
	}
	for (var i = 0; i < orderItemArr.length; i++) {
		var orderItemJs=orderItemArr[i];
		if(orderItemJs.orderItemStoreArr.length==0)
		{
		   top.jAlert('warning','货号'+orderItemJs.itemNo+'下订单商品分店店信息为空!', '提示消息');
			   return;
		}
		for (var j = 0; j < orderItemJs.orderItemStoreArr.length; j++) {
 		   var orderItemStoreJson=orderItemJs.orderItemStoreArr[j];
 		   if(orderItemStoreJson.buyCount==''&&orderItemStoreJson.promotionalItemsCount=='')
 			  {
 			   top.jAlert('warning', '货号'+orderItemJs.itemNo+'下有分店订购数量和赠品数量都为空!', '提示消息');
 			   return;
 			  }
 		   if(orderItemStoreJson.buyCount=='')
			   {
			     orderItemStoreJson.buyCount='0';
			   }
 		   if(orderItemStoreJson.promotionalItemsCount=='')
 			   {
 			     orderItemStoreJson.promotionalItemsCount='0';
 			   }
 		   
 		   if(orderItemJs.buyWhen && orderItemStoreJson.buyPriceLimit < orderItemStoreJson.buyPriceChange)
 			   {
 			   top.jAlert('warning', '货号'+orderItemJs.itemNo+'下有分店超出买价限制!', '提示消息');
 			   return;
 			   }
		}
	}
	var comma = "--";
	var storeArr=[];
	var orderItemAndStoreArr=[];
	var buyPriceChangeArr=[];
	//去掉重复门店  一个门店对应一个订单  并且拼装订单商品门店数据
	for (var i = 0; i < orderItemArr.length; i++) {
		  var orderItemJs=orderItemArr[i];
		  var orderItemStoreArr=orderItemArr[i].orderItemStoreArr;
		  for(var j=0;j<orderItemStoreArr.length;j++)
			 {
			    var itemStore=orderItemStoreArr[j];
			    var flag=false;
			    for(var m=0;m<storeArr.length;m++){
			    	if(storeArr[m]==orderItemStoreArr[j].storeNo)
			    		{
			    		flag=true;
			    		}
			    }
			    if(!flag){
			    storeArr.push(orderItemStoreArr[j].storeNo);
			    }
			    
			    var orderItemStoreJs={};
			    var buyPriceChangeJs={};
			    orderItemStoreJs.itemNo = itemStore.itemNo;
				orderItemStoreJs.storeNo = itemStore.storeNo;
				orderItemStoreJs.catlgId = addCatlgId;
				if(itemStore.promNo!="")
				{
				orderItemStoreJs.promNo = itemStore.promNo;
				}
				if(orderItemJs.buyWhen!=2)
				{
				orderItemStoreJs.buyPrice = itemStore.buyPrice;
				}
				else{
					if(itemStore.buyPrice==itemStore.buyPriceChange){
						orderItemStoreJs.buyPrice = itemStore.buyPrice;
					}
					else{
						orderItemStoreJs.buyPrice = itemStore.buyPriceChange;
						buyPriceChangeJs.buyPrice=itemStore.buyPriceChangeWithOutBpDisc;
						buyPriceChangeJs.itemNo = itemStore.itemNo;
						buyPriceChangeJs.storeNo = itemStore.storeNo;
						buyPriceChangeArr.push(JSON.stringify(buyPriceChangeJs));
					}
				}
				orderItemStoreJs.buyVatNo = itemStore.buyVatNo;
			    orderItemStoreJs.buyVatVal = itemStore.buyVatVal;
				//orderItemStoreJs.recptQty=itemStore.recvBleQty;
				orderItemStoreJs.ordQty = itemStore.buyCount;
				orderItemStoreJs.presOrdQty=itemStore.promotionalItemsCount;
				orderItemAndStoreArr.push(JSON.stringify(orderItemStoreJs));
			 }
	}
	var orderInfoArr=[];//存放订单基本信息
	var comNo=$("#comNo").val();
	var supUnifmNo=$("#supUnifmNo").val();
	var demo=$("#demo").val();
	var bpDisc=$("#bpDisc").val();
	var invDisc=$("#invDisc").val();
	var discMemo=$("#discMemo").val();
	var supType=$("#supType").val();
    
	for (var m = 0; m < storeArr.length; m++) {
		var orderInfo = {};
		//订单基本信息
		orderInfo.storeNo=storeArr[m];
		orderInfo.catlgId = addCatlgId;
		orderInfo.supNo = addSupId;
		orderInfo.supUnifmNo=supUnifmNo;
		orderInfo.supComNo =comNo;
		orderInfo.planRecptDate = planRecptDate;
		orderInfo.bpDisc = bpDisc;
		orderInfo.invDisc=invDisc;
		orderInfo.discMemo=discMemo;
		orderInfo.memo=demo;
		orderInfo.buyer=buyer;
		 
		orderInfoArr.push(JSON.stringify(orderInfo));
	}
	
	var orderInfoListStr=orderInfoArr.join(comma);
	var orderItemAndStoreListStr=orderItemAndStoreArr.join(comma);
	var buyPriceChangeListStr=buyPriceChangeArr.join(comma);

	$.post(ctx + '/hoOrderCreate/hoOrderCreate?ti='
				+ (new Date()).getTime(),{
			'orderInfoListStr' : orderInfoListStr,
			'orderItemAndStoreListStr' : orderItemAndStoreListStr,
			'supType':supType,
			'buyPriceChangeListStr':buyPriceChangeListStr,
			'catlgId':addCatlgId
		},function(response){
			var res= response["message"];
			if(res=='true'){
				top.jAlert('success', '订单已创建', '提示消息');
				//showContent(ctx+"/order/hoOrder");
				
				showContent(ctx+"/hoOrderCreate/hoOrderCreatePage");
			}
		});
	/*$.ajax({
		async : false,
		url : ctx + '/hoOrderCreate/hoOrderCreate?ti='
				+ (new Date()).getTime(),
		data : {
			'orderInfoListStr' : orderInfoListStr,
			'orderItemAndStoreListStr' : orderItemAndStoreListStr,
			'supType':supType,
			'buyPriceChangeListStr':buyPriceChangeListStr
		},
		type : 'POST',
		success : function(response) {
			var res= response["message"];
			if(res=='true'){
				top.jAlert('success', '添加成功', '提示消息');
				//showContent(ctx+"/order/hoOrder");
				
				showContent(ctx+"/hoOrderCreate/hoOrderCreatePage");
			}

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			top.jAlert('error', '网络超时!请稍后重试', '提示消息');
		}
	});*/	
});
// 课别添加弹出层事件
$("[name=catlgId]").unbind("click focus").bind("click focus", function() {
	$("#catlgId").removeClass("errorInput");

	// 打开弹出层
	openPopupWin(600, 500, '/commons/window/chooseSection');
});
//课别选项
$("#catlgId").unbind("change").change(function(){
$("#addCatlgName").val("");
var addCatlgId=$.trim($("#catlgId").val());
$("#catlgId").attr('value',addCatlgId);
//清除之前订单商品数组
orderItemArr = [];
$("#pro_store_tb_edit").html("");
$(".pro_store_tb").html("");
$("#buyerName").val("");
$("#buyer").val("");

$('#supId').val("");
$('#addSupName').val("");
$('#comNo').val("");
$('#supUnifmNo').val("");
$('#supType').val("");

$("#bpDisc").val("");
$("#invDisc").val("");
$("#discMemo").val("");
if(addCatlgId=="")
{
	//nothing to do;
}
else if(!isNumber(addCatlgId)){
	   top.jAlert('warning','请注意输入课别！', '提示消息');
	   $("#catlgId").val("");
	   return;
}
if(isNumber(addCatlgId) && addCatlgId!=""){
     //加载课别信息
	readCatalogInfoBySecNo(addCatlgId,function(data){
          if(data!=""){
				$("#addCatlgName").val(data[0].secName);
              }
          else{
       	   top.jAlert('warning','没有找到相应课别信息！', '提示消息');
       	   $("#catlgId").val("");
          }
		});		
}
else{
	$("#catlgId").val("");
}
});
var item_create_content=1;
// 厂商信息弹出层
$("[name=supId]").unbind("click focus").bind("click focus",function() {
	        //$("#supId").removeClass("errorInput");
			var catlgId = $('#catlgId').val();
			if (catlgId == "") {
				top.jAlert('warning', '请选择课别！', '消息提示');
				return;
			}
			if (typeof (supInfo) != "undefined")
				supInfo = "";
			
			
			// 打开弹出层
			openPopupWin(680, 548,
					'/hoOrderCreate/orderSupplierSelectWindowAction?catlgId='
							+ catlgId);
		});

// 订单添加弹出层事件
$("[name=addOrderItem]").unbind("click").bind(
		"click",
		function() {
			var catlgId = $('#catlgId').val();
			//var catlgName = encodeURI(encodeURI($('#addCatlgName').val()));
			if (catlgId == "") {
				top.jAlert('warning', '请选择课别！', '消息提示');
				return;
			}
			var addSupId = $('#supId').val();
			if (addSupId == "") {
				top.jAlert('warning', '请选择厂商！', '消息提示');
				return;
			}
			var planRecptDate = $('#planRecptDate').val();
			if (planRecptDate == "") {
				top.jAlert('warning', '请选择预订收货日期！', '消息提示');
				return;
			}
			addNewOrderItem($(this).parent().prev());
			
			$(".pro_store_tb_edit .item_on")[0].scrollIntoView();//sv
		});
// 订单输入弹出层事件
$("[name=addOrderPasteItem]").unbind("click").bind("click",
		function() {
			
			if(!chkMustInputItem())
			{
				return;
			}
			var catlgId = $('#catlgId').val();
			
			if (catlgId == "") {
				top.jAlert('warning', '请选择课别！', '消息提示');
				return;
			}
			var addSupId = $('#supId').val();
			if (addSupId == "") {
				top.jAlert('warning', '请选择厂商！', '消息提示');
				return;
			}
			var planRecptDate = $('#planRecptDate').val();
			if (planRecptDate == "") {
				top.jAlert('warning', '请选择预订收货日期！', '消息提示');
				return;
			}
			// 打开弹出层
			openPopupWin(650, 500, '/hoOrderCreate/addOrderPasteItem');
		});

//订单PopWin弹出层事件
$("[name=addOrderPopWin]").unbind("click").bind(
		"click",
		function() {
			
			if(!chkMustInputItem())
			{
				return;
			}
			
			var catlgId = $('#catlgId').val();
			var catlgName = encodeURI(encodeURI($('#addCatlgName').val()));
			if (catlgId == "") {
				top.jAlert('warning', '请选择课别！', '消息提示');
				return;
			}
			var addSupId = $('#supId').val();
			if (addSupId == "") {
				top.jAlert('warning', '请选择厂商！', '消息提示');
				return;
			}
			var planRecptDate = $('#planRecptDate').val();
			if (planRecptDate == "") {
				top.jAlert('warning', '请选择预订收货日期！', '消息提示');
				return;
			}
			// 打开弹出层
			openPopupWin(680, 550, '/hoOrderCreate/addOrderItem?catlgId='
					+ catlgId + '&catlgName=' + catlgName + '&supNo='
					+ addSupId);
		});
// 课别回调信息
function confirmChooseSection(id, name) {
	$('#catlgId').attr('value', id);
	$('#addCatlgName').attr('value', name);
	// 清除之前订单商品数组
	orderItemArr = [];
	$("#pro_store_tb_edit").html("");
	$(".pro_store_tb").html("");
	$("#buyerName").val("");
	$("#buyer").val("");

	$('#supId').val("");
	$('#addSupName').val("");
	$('#comNo').val("");
	$('#supUnifmNo').val("");
	$('#supType').val("");
	
	$("#bpDisc").val("");
	$("#invDisc").val("");
	$("#discMemo").val("");
	// 关闭弹出层
	closePopupWin();
}

// 厂商信息
function saveManufacturerNo() {
	if (typeof (readSupInfo) != "undefined") {
		// 回调信息
		readSupInfo(function(id, name,comNo,supUnifmNo,supType) {
			var catlgId = $('#catlgId').val();
			$('#supId').attr('value', id);
			$('#addSupName').attr('value', name);
			$('#comNo').attr('value', comNo);
			$('#supUnifmNo').attr('value', supUnifmNo);
			$('#supType').attr('value', supType);
			
			$("#bpDisc").val("");
			$("#invDisc").val("");
			$("#discMemo").val("");
			
			// 清除之前订单商品数组
			orderItemArr=[];
		 $("#pro_store_tb_edit").html("");
		 $(".pro_store_tb").html("");
		 $("#buyerName").val("");
		 $("#buyer").val("");
			if (typeof (id) != "undefined" && id != ""
					&& typeof (catlgId) != "undefined" && catlgId != "") {
				$.ajax({
					async : false,
					url : ctx + '/hoOrderCreate/getSupDiscInfo?ti='
							+ (new Date()).getTime(),
					data : {
						'supNo' : id,
						'catlgId' : catlgId
					},
					type : 'POST',
					success : function(response) {
						var supplier = response["row"];
						if (supplier != null && supplier != "") {
							$("#bpDisc").val(supplier.bpdisc);
							$("#invDisc").val(supplier.invDisc);
							$("#discMemo").val(supplier.discMemo);
						}

					},
					error : function(XMLHttpRequest, textStatus, errorThrown) {
						top.jAlert('error', '网络超时!请稍后重试', '提示消息');
					}
				});
			}
			
		});
	}

}
function savePasteOrder(){
	top.grid_layer_open();
	var orderStr=$.trim($("#orderList").val()).replace(/;$/,"");
//	var orderStr=$.trim($("#orderList").val());
	var catlgId = $('#catlgId').val();
	var supId = $('#supId').val();
	var reg = /[\n;]/;
	var errOrderArr=[];//保存错误的货号
	var htmlStr="";
	$(".msg").html("");
	var orderArr=[];
	var itemNoAddArr=[];
	var flag=false;
	if(orderStr!="")
	{
	   orderArr=orderStr.split(reg);
	   for(var i=0;i<orderArr.length;i++)
		  {
		    orderArr[i] = $.trim(orderArr[i]);
		    if(!/^[1-9]{1}[0-9]*$/.test(orderArr[i])){
		    	errOrderArr.push(orderArr[i]);	    	
		    }
		    else if(orderArr[i].length>8)
		    {
		    	errOrderArr.push(orderArr[i]);
		    }
		  }
	}
	else{
		top.jAlert('warning', '请输入订单商品！', '消息提示');
		return false;
	}
	if(errOrderArr.length>0)
	{
		$(".msg").html("*以下内容货号格式有误。("+errOrderArr.join(";")+")");
		return;
	}
	
	 for(var i=0;i<orderArr.length;i++)
	    {
	        for(var j = 0; j < orderItemArr.length; j++){
	            if(orderArr[i]==orderItemArr[j].itemNo){ 
	            flag=true;
	            break;
	            }
	        }
	        if(flag==false){
	            itemNoAddArr.push(orderArr[i]);
	        }
	        flag=false;
	}  
	
	
	
	
	
	
	var itemListAdd="";
	$.ajax({
		async : false,
		url : ctx + '/hoOrderCreate/getHoOrderItemList?ti='+(new Date()).getTime(),
		data : {'itemNo':itemNoAddArr.join(","),supNo:supId,catlgId:catlgId},
		type : 'POST',
		success : function(response) {
			var itemList=response["row"];
			
			var buyer=response["buyer"];
			if(orderItemArr.length==0)
			{
				$("#buyer").val(buyer.buyer);
				$("#buyerName").val(buyer.buyerName);
			}
			if(itemList==null)
			{
				$(".msg").html("*以下内容无此货号。("+orderArr.join(";")+")");
				 return false;
			}
			/*var orderList=[];
			for(var i=0;i<itemList.length;i++)
				{
				   orderList.push(itemList[i].itemNo);
				}
			var c = [];
			var tmp = orderList.concat(orderArr);
			var o = {};
			for (var i = 0; i < tmp.length; i ++)
				(tmp[i] in o) ? o[tmp[i]] ++ : o[tmp[i]] = 1;
			for (x in o) if (o[x] == 1) c.push(x);
			if(c.length>0)
			{
			$(".msg").html("以下内容无此货号。("+c.join(";")+")");
			return;
			}*/
			itemListAdd=itemList[0];
			htmlStr=$("#pro_store_tb_edit").html();
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
				
				if(item.itemName==null)
				{
					item.itemName = "";
				}

				if(item.itemEnName==null)
				{
					item.itemEnName = "";
				}
				
				orderItemArr.push(orderItemJs);
				var sellUnitName=getDictValue('UNIT',item.sellUnit);
				var buyMethdName=getDictValue('ITEM_BASIC_BUY_METHD',item.buyMethd);
				var buyWhenName=getDictValue('ITEM_BASIC_BUY_WHEN',item.buyWhen);

				
				
				htmlStr+="<div class='item'>";
				htmlStr+="<input type='hidden' name='itemType' value='"+item.itemType+"' class='inputText pedit_f Black' />";
				htmlStr+="<input type='text' readonly='readonly' name='itemNo' value='"+item.itemNo+"' class='inputText pedit_f Black' />";
				htmlStr+="<input type='text' readonly='readonly' name='itemName' value='"+item.itemName+"' class='inputText w20 fl_left Black' />";     
				htmlStr+="<input type='text' readonly='readonly' name='itemEnName' value='"+item.itemEnName+"' class='inputText w25 fl_left Black' />";
				htmlStr+="<input type='text' readonly='readonly' name='sellUnit' value='"+sellUnitName+"' class='inputText w10 fl_left Black' />";
				htmlStr+="<input type='text' readonly='readonly' name='buyMethd' value='"+buyMethdName+"' class='inputText pedit_fth Black' />";
				htmlStr+="<input type='text' readonly='readonly' name='buyWhen' value='"+buyWhenName+"' class='inputText w15 fl_left Black' realvalue='"+item.buyWhen+"'/>";
				htmlStr+="<div class='pstb_del'></div>";  
				htmlStr+="</div>";
            
			}
			
		    $("#pro_store_tb_edit").html(htmlStr);
//		    if(htmlStr!=""){
//				$("#pro_store_tb_edit").find(".item:first").click();
//			}
		    //关闭弹出层
			closePopupWin();
			//取消選取全選框
			clearCheckAll();
		
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			top.jAlert('error', '网络超时!请稍后重试', '提示消息');
		}
	});
    if(htmlStr!=""){
		//$("#pro_store_tb_edit").find(".item:first").click();
		$("#pro_store_tb_edit").find("input[value='"+itemListAdd.itemNo+"']").parent().click();
		
		top.grid_layer_close();
	}
    
}

function rmvOrderItem(itemNoRmvArr){
	/*remove the items from the page*/
	$.each(itemNoRmvArr,function(index,value){	
		var removeValue=value;
		$.each($("#pro_store_tb_edit").find("input[name='itemNo']"),function(index,obj){		
			if(obj.value==removeValue){
				$(obj).parent().remove();
				return false;
			}
		});
	});
	/*remove the items from the orderItemArr...*/
	$.each(itemNoRmvArr,function(index,value){	
		var removeValue=value;
		$.each(orderItemArr,function(index,obj){
			if(obj.itemNo==removeValue){
				orderItemArr.splice(index,1);
				return false;
			}
		});
	});
}    

// 回调函数
function saveHoOrderItemNo() {
	var itemNoAddArr = [];
	var itemNoRmvArr= [];
	var htmlStr="";
	var flag=false;
	var itemList1="";
	//从勾选的所有货号中删除已有的货号
	
    var itemNoArrChecked=$("input[name='itemNoCk']:checked");
	  for(var i=0;i<itemNoArrChecked.length;i++)
	{
		for(var j = 0; j < orderItemArr.length; j++){
			if(itemNoArrChecked[i].value==orderItemArr[j].itemNo){ 
			flag=true;
			break;
			}
	    }
		if(flag==false){
			itemNoAddArr.push(itemNoArrChecked[i].value);
		}
		flag=false;
	}
	//没有勾选的里面选择已在原来页面上存在的    
	for (var j = 0; j < orderItemArr.length; j++) {
		var beforeOrderItemArr = orderItemArr[j];
		for(var i=0;i < itemNoArrChecked.length;i++){
		if (beforeOrderItemArr.itemNo == itemNoArrChecked[i].value) {
			flag = true;
			break;
		}
		}
	if (flag==false) {
		itemNoRmvArr.push(beforeOrderItemArr.itemNo);
	}
	flag=false;
	}
	if (itemNoArrChecked.length <= 0) {
		top.jAlert("warning", "请选择要添加的订单商品", "提示消息");
		return false;
	} else {
	/*remove the order itemNos needed to cancel */
		if(itemNoRmvArr.length>0){
			rmvOrderItem(itemNoRmvArr);
		}
	/*send the needed to add order itemNos. */	
		if(itemNoAddArr==""){
			closePopupWin();
			return false;
		
		}
		
		$.ajax({
			async : false,
			url : ctx + '/hoOrderCreate/getHoOrderItemList?ti='
					+ (new Date()).getTime(),
			data : {
				'itemNo' : itemNoAddArr.join(",")
			},
			type : 'POST',
			success : function(response) {
				var itemList = response["row"];
				  itemList1=itemList[0];
				var buyer=response["buyer"];
				if(orderItemArr.length==0)
				{
					$("#buyer").val(buyer.buyer);
					$("#buyerName").val(buyer.buyerName);
				}
				if (itemList == null) {
					return;
				}
			    htmlStr = $("#pro_store_tb_edit").html();
				for (var i = 0; i < itemList.length; i++) {
					var item = itemList[i];
					/** 判断订单商品是否已经添加 已经添加不再添加 * */
					var flag = false;
					for (var j = 0; j < orderItemArr.length; j++) {
						var beforeOrderItemArr = orderItemArr[j];
						if (beforeOrderItemArr.itemNo == item.itemNo) {
							flag = true;
						}
					}
					if (flag) {
						continue;
					}

					var orderItemJs = {};
					orderItemJs.itemNo = item.itemNo;
					orderItemJs.itemName = item.itemName;
					orderItemJs.itemEnName = item.itemEnName;
					orderItemJs.sellUnit = item.sellUnit;
					orderItemJs.buyMethd = item.buyMethd;
					orderItemJs.buyWhen = item.buyWhen;
					orderItemJs.orderItemStoreArr = [];

					if(item.itemName==null)
					{
						item.itemName = "";
					}
					if(item.itemEnName==null)
					{
						item.itemEnName = "";
					}

					orderItemArr.push(orderItemJs);
					var sellUnitName = getDictValue('UNIT',
							item.sellUnit);
					var buyMethdName = getDictValue(
							'ITEM_BASIC_BUY_METHD', item.buyMethd);
					var buyWhenName = getDictValue(
							'ITEM_BASIC_BUY_WHEN', item.buyWhen);

					htmlStr += "<div class='item'>";
					htmlStr+="<input type='hidden' name='itemType' value='"
					        +item.itemType+"' class='inputText pedit_f Black' />";
					htmlStr += "<input type='text' readonly='readonly' name='itemNo' value='"
							+ item.itemNo
							+ "' class='inputText pedit_f Black' />";
					htmlStr += "<input type='text' readonly='readonly' name='itemName' value='"
							+ item.itemName
							+ "' class='inputText w20 fl_left Black' />";
					htmlStr += "<input type='text' readonly='readonly' name='itemEnName' value='"
							+ item.itemEnName
							+ "' class='inputText w25 fl_left Black' />";
					htmlStr += "<input type='text' readonly='readonly' name='sellUnit' value='"
							+ sellUnitName
							+ "' class='inputText w10 fl_left Black' />";
					htmlStr += "<input type='text' readonly='readonly' name='buyMethd' value='"
							+ buyMethdName
							+ "' class='inputText pedit_fth Black' />";
					htmlStr += "<input type='text' readonly='readonly' name='buyWhen' value='"
							+ buyWhenName
							+ "' class='inputText w15 fl_left Black' realvalue='"+item.buyWhen+"'/>";
					htmlStr += "<div class='pstb_del'></div>";
					htmlStr += "</div>";

				}
				$("#pro_store_tb_edit").html(htmlStr);

				//关闭弹出层
				closePopupWin();

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				top.jAlert('error', '网络超时!请稍后重试', '提示消息');
			}
		});
		
		if(htmlStr!=""){
			//$("#pro_store_tb_edit").find(".item:first").click();//修改处，如何找到添加的第一个商品  bug寻找   即是一个jquery筛选问题
	   $("#pro_store_tb_edit").find("input[value='"+itemList1.itemNo+"']").parent().click();
		}  
	}

}
$("#pro_store_tb_edit .item").die("click").live('click',function(){
	
	  if($(this).hasClass("item_on get_store"))
	  {
		  return;
	  }
	  $(this).parent().find(".item_on").removeClass("item_on");
		
	  $(this).addClass("item_on");
	  //清空订购数量,赠品数量,买价格
	  $(".ordMultiParmBody").attr('value','');
	  $(".promotionalItemsBody").attr('value','');
	  $(".buyPriceChangeBody").attr('value','');
	  
	  var itemNo=$(this).find("input[name='itemNo']").val();
	  var emptyItem=$(this).find("input[name='itemNo']").hasClass('mustInput');
	  var ordSupNo=$('#supId').val();
	  var ordCatlgId=$('#catlgId').val();
	  
	  var planRecptDate = $('#planRecptDate').val();
	  var orderDate = $('#orderDate').val();
	  var bpdisc = $('#bpDisc').val();
	  if (planRecptDate == "") {
			top.jAlert('warning', '请选择预订收货日期！', '消息提示');
			return;
		}
	  
	  $(".pro_store_tb").html("");
	  orderStoreArr=[];
	  if(emptyItem)
	  {
		  return;
	  }
	  var isExists=false;
	  var index=0;
	  for (var i = 0; i < orderItemArr.length; i++) {
		  var orderItemJs=orderItemArr[i];
		  if(orderItemJs.itemNo==itemNo)
			{
			     index=i;
			    if(orderItemJs.orderItemStoreArr.length>0)
			    {
			    	isExists=true;
			    }
			    
			}
		  
	  }

	  if(isExists){
		  grid_layer_open();
		  for (var i = 0; i < orderItemArr.length; i++) {
			  var orderItemJs=orderItemArr[i];
			  if(orderItemJs.itemNo==itemNo)
				{
				    if(orderItemJs.orderItemStoreArr.length>0)
				    {
				    	var htmlStr = "";
				    	  if(orderItemJs.buyWhen==2)
							{
								$(".buyPriceChangeBody").removeClass("Black");
								$(".buyPriceChangeBody").removeAttr("readonly");

							}
				    	  else
				    		{
				    		  $(".buyPriceChangeBody").addClass("Black");
				    		  $(".buyPriceChangeBody").attr('readonly','readonly');
				    		}
						for (var j = 0; j < orderItemJs.orderItemStoreArr.length; j++) {
							
							var itemStore =orderItemJs.orderItemStoreArr[j];
							var storeJs={'storeNo':itemStore.storeNo};
							orderStoreArr.push(storeJs);
	                        var statusName = getDictValue('ITEM_BASIC_STATUS',itemStore.status);
	                        var promNo="";
	                        if(itemStore.promNo!=null)
	                        {
	                        	promNo=itemStore.promNo;
	                        }
	                        var stock='0';
	                        if(itemStore.stock!=null)
	                        {
	                        	stock=itemStore.stock;
	                        }
	                        var recvBleQty="0";
	                        if(itemStore.recvBleQty!=null)
	                        {
	                        	recvBleQty=itemStore.recvBleQty;
	                        }
	                        var dms='0';
	                        if(itemStore.dms!=null)
	                        {
	                        	dms=itemStore.dms;
	                        }
	                        htmlStr+="<div class='ig_padding'>";
	                        htmlStr+="<input type='checkbox' name='storeNoCk' value='"+itemStore.storeNo+'_'+itemStore.itemNo+"' class='fl_left' onchange='checkSelectAll(this)' />";
	                        htmlStr+="<input type='text' name='storeNoAndName' value='"+itemStore.storeNo+"-"+itemStore.storeName+"' class='inputText w10 fl_left Black' readonly='readonly'/>";
	                        htmlStr+="<input type='text' name='status' value='"+statusName+"' class='inputText w8 fl_left Black' readonly='readonly'/>";
	                        htmlStr+="<input type='text' name='promNo' value='"+promNo+"' class='inputText w8 fl_left Black' readonly='readonly'/>";
	                        htmlStr+="<input type='hidden' name='promNoBefore' value='"+promNo+"' />";
	                        htmlStr+="<input type='text' name='ordMultiParmInput' value='"+itemStore.buyCount+"' id='ordQty-"+itemStore.storeNo +"' class='inputText w7 fl_left ' />";
	                        htmlStr+="<input type='text' name='promotionalItemsCount' value='"+itemStore.promotionalItemsCount+"' class='inputText w7 fl_left ' />";
	                        if(orderItemJs.buyWhen==2)
	                        {
	                        htmlStr+="<input type='text' name='buyPriceChange' value='"+itemStore.buyPriceChange+"' class='inputText w10 fl_left' />";
	                        htmlStr+="<input type='hidden' name='buyPrice' value='"+itemStore.buyPrice+"' />";

	                        }
	                        else{
		                        htmlStr+="<input type='text' name='buyPrice' value='"+itemStore.buyPrice+"' class='inputText w10 fl_left Black' readonly='readonly'/>";
	                        }
	                        htmlStr+="<input type='text' name='ordMultiParm' value='"+itemStore.ordMultiParm+"' class='inputText w5 fl_left Black' readonly='readonly'/>";
	                        htmlStr+="<input type='text' name='buyVatVal' value='"+itemStore.buyVatVal+"%' class='inputText w5 fl_left Black' readonly='readonly'/>";
	                        htmlStr+="<input type='hidden' name='buyVatNo' value='"+itemStore.buyVatNo+"' />";
	                        htmlStr+="<input type='text' name='netCost' value='"+itemStore.netCost+"' class='inputText w8 fl_left Black' readonly='readonly'/>";
	                        htmlStr+="<input type='text' name='dms' value='"+dms+"' class='inputText w7 fl_left Black' readonly='readonly'/>";
	                        htmlStr+="<input type='text' name='recvBleQty' value='"+recvBleQty+"' class='inputText w7 fl_left Black' readonly='readonly'/>";
	                        htmlStr+="<input type='text' name='stock' value='"+stock+"' class='inputText w7 fl_left Black' readonly='readonly'/>";
	                        htmlStr+="<input type='hidden' name='itemNo' value='"+itemStore.itemNo+"'/>";
	                        htmlStr+="<input type='hidden' name='storeNo' value='"+itemStore.storeNo+"' />";
	                        htmlStr+="<input type='hidden' name='buyPriceLimit' value='"+itemStore.buyPriceLimit+"' />";

	                        htmlStr+="<div class='clearBoth'></div>";
	                        htmlStr+="</div>";
	                        
						}
						$(".pro_store_tb").html(htmlStr);
						//取消選取全選框
						clearCheckAll();
				    }				    
				}
			  
		  }
		  grid_layer_close();
	  }
	  else
	  {
		  
		  if($(this).hasClass("get_store"))
		  {
			  return;
		  }
		  else
		  {
			  $(this).addClass("get_store");
		  }
	      var orderItemJsGlo={};
		  for (var i = 0; i < orderItemArr.length; i++) {
			  var orderItemJs=orderItemArr[i];
			  if(orderItemJs.itemNo==itemNo)
				{
				  orderItemJsGlo=orderItemArr[i];
				}
		  }
		  if(orderItemJsGlo.buyWhen==2)
		  {
				$(".buyPriceChangeBody").removeClass("Black");
				$(".buyPriceChangeBody").removeAttr("readonly");

		  }
		  else
		  {
    		  $(".buyPriceChangeBody").addClass("Black");
    		  $(".buyPriceChangeBody").attr('readonly','readonly');
		  }
		  $.ajax({
			    async : true,
				url : ctx + '/hoOrderCreate/getHoOrderItemStoreList?ti='
						+ (new Date()).getTime(),
				data : {
					'itemNo' : itemNo,
					'planRecptDate':planRecptDate,
					'orderDate':orderDate,
					'bpDisc' : bpdisc,
					'supNo':ordSupNo,
					'catlgId':ordCatlgId
				},
				type : 'POST',
				success : function(response) {
					var itemStoreList = response["row"];
					if (itemStoreList == null) {
						return;
					}
					var htmlStr = "";
					var orderItemStoreArr=[];
					for (var i = 0; i < itemStoreList.length; i++) {
						var itemStore = itemStoreList[i];
						var orderItemStoreJs={};
						var storeJs={'storeNo':itemStore.storeNo};
						orderStoreArr.push(storeJs);
						orderItemStoreJs.itemNo = itemStore.itemNo;
						orderItemStoreJs.storeNo = itemStore.storeNo;
						orderItemStoreJs.storeName = itemStore.storeName;
						orderItemStoreJs.status = itemStore.status;
						orderItemStoreJs.netCost = itemStore.netCost;
						if(itemStore.netCost==null)
					    {
							itemStore.netCost="";
					    }
						
						orderItemStoreJs.dms = itemStore.dms;
						orderItemStoreJs.stock = itemStore.stock;
						orderItemStoreJs.ordMultiParm = itemStore.ordMultiParm;
						orderItemStoreJs.promNo = itemStore.promNo;
						orderItemStoreJs.promNoBefore = itemStore.promNo;
						orderItemStoreJs.buyPrice = itemStore.buyPrice;
						orderItemStoreJs.buyPriceChange = itemStore.buyPrice;
						orderItemStoreJs.buyPriceChangeWithOutBpDisc = itemStore.buyPrice;
						orderItemStoreJs.buyVatNo = itemStore.buyVatNo;
						orderItemStoreJs.buyVatVal = itemStore.buyVatVal;
						orderItemStoreJs.recvBleQty="";
						if(itemStore.recvBleQty!=null){
							orderItemStoreJs.recvBleQty = itemStore.recvBleQty;
						}
						orderItemStoreJs.buyCount = "";
						orderItemStoreJs.promotionalItemsCount="";
						orderItemStoreJs.buyPriceLimit=itemStore.buyPriceLimit;
                        orderItemStoreArr.push(orderItemStoreJs);
                        var statusName = getDictValue('ITEM_BASIC_STATUS',
                        		itemStore.status);
                        var promNo="";
                        if(itemStore.promNo!=null)
                        {
                        	promNo=itemStore.promNo;
                        }
                        var stock='0';
                        if(itemStore.stock!=null)
                        {
                        	stock=itemStore.stock;
                        }
                        var dms='0';
                        if(itemStore.dms!=null)
                        {
                        	dms=itemStore.dms;
                        }
                        var recvBleQty="0";
                        if(itemStore.recvBleQty!=null)
                        {
                        	recvBleQty=itemStore.recvBleQty;
                        }

                        htmlStr+="<div class='ig_padding'>";
                        htmlStr+="<input type='checkbox' name='storeNoCk' value='"+itemStore.storeNo+'_'+itemStore.itemNo+"' class='fl_left' onchange='checkSelectAll(this)' />";
                        htmlStr+="<input type='text' name='storeNoAndName' value='"+itemStore.storeNo+"-"+itemStore.storeName+"' class='inputText w10 fl_left Black' readonly='readonly'/>";
                        htmlStr+="<input type='text' name='status' value='"+statusName+"' class='inputText w8 fl_left Black' readonly='readonly'/>";
                        htmlStr+="<input type='text' name='promNo' value='"+promNo+"' class='inputText w8 fl_left Black' readonly='readonly'/>";
                        htmlStr+="<input type='hidden' name='promNoBefore' value='"+promNo+"' />";
                        htmlStr+="<input type='text' name='ordMultiParmInput' id='ordQty-"+itemStore.storeNo +"' class='inputText w7 fl_left ' />";
                        htmlStr+="<input type='text' name='promotionalItemsCount' class='inputText w7 fl_left ' />";
                        if(orderItemJsGlo.buyWhen==2)
                        {
                        htmlStr+="<input type='text' name='buyPriceChange' value='"+itemStore.buyPrice+"' class='inputText w10 fl_left' />";
                        htmlStr+="<input type='hidden' name='buyPrice' value='"+itemStore.buyPrice+"' />";

                        }
                        else{
                            htmlStr+="<input type='text' name='buyPrice' value='"+itemStore.buyPrice+"' class='inputText w10 fl_left Black' readonly='readonly'/>";
                        }
                        htmlStr+="<input type='text' name='ordMultiParm' value='"+itemStore.ordMultiParm+"' class='inputText w5 fl_left Black' readonly='readonly'/>";
                        htmlStr+="<input type='text' name='buyVatVal' value='"+itemStore.buyVatVal+"%' class='inputText w5 fl_left Black' readonly='readonly'/>";
                        htmlStr+="<input type='hidden' name='buyVatNo' value='"+itemStore.buyVatNo+"' />";
                        htmlStr+="<input type='text' name='netCost' value='"+itemStore.netCost+"' class='inputText w8 fl_left Black' readonly='readonly'/>";
                        htmlStr+="<input type='text' name='dms' value='"+dms+"' class='inputText w7 fl_left Black' readonly='readonly'/>";
                        htmlStr+="<input type='text' name='recvBleQty' value='"+recvBleQty+"' class='inputText w7 fl_left Black' readonly='readonly'/>";
                        htmlStr+="<input type='text' name='stock' value='"+stock+"' class='inputText w7 fl_left Black' readonly='readonly'/>";
                        htmlStr+="<input type='hidden' name='itemNo' value='"+itemStore.itemNo+"' />";
                        htmlStr+="<input type='hidden' name='storeNo' value='"+itemStore.storeNo+"' />";
                        htmlStr+="<input type='hidden' name='buyPriceLimit' value='"+itemStore.buyPriceLimit+"'/>";
                        
                        htmlStr+="<div class='clearBoth'></div>";
                        htmlStr+="</div>";

					}
				    var oldOrderItemJs=orderItemArr[index];
				    oldOrderItemJs.orderItemStoreArr=orderItemStoreArr;
				    orderItemArr[index]=oldOrderItemJs;
					$(".pro_store_tb").html(htmlStr);
					//取消選取全選框
					clearCheckAll();

				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
					top.jAlert('error', '网络超时!请稍后重试', '提示消息');
				}
			});
	  }

	
});
$(".pstb_del").die("click").live('click', function(e) {
	e.stopPropagation();
	var emptyItem =$(this).parent(".item").find("input[name='itemNo']").hasClass('mustInput');
	var itemNo = $(this).parent(".item").find("input[name='itemNo']").val();
	// 清除相应订单商品数据
	for (var i = 0; i < orderItemArr.length; i++) {
		var orderItemJson = orderItemArr[i];
		if (orderItemJson.itemNo == itemNo) {
			orderItemArr = orderItemArr.del(i);
			i = -1;
		}
	}
	var itemNoStore=$(".pro_store_tb").find(".ig_padding:first").find("input[name=itemNo]").val();

	var $row = $(this).parent(".item");
	$row.remove();
	if(emptyItem||itemNoStore==itemNo){
		$(".pro_store_tb").html("");
		//清空订购数量,赠品数量,买价格
		$(".ordMultiParmBody").attr('value','');
		$(".promotionalItemsBody").attr('value','');
		$(".buyPriceChangeBody").attr('value','');
		if($("#pro_store_tb_edit").html()!=""){
		$("#pro_store_tb_edit").find(".item:first").click();
		}
	}
	//取消選取全選框
	clearCheckAll();
});
$(".deleteBar").on('click', function(e) {
	var storeNoCkArr=[];
	$('input[name="storeNoCk"]:checked').each(function() {
		    storeNoCkArr.push($(this).val());
			var storeNoAndItemNo=$(this).val();
			var storeNoAndItemNoArr=storeNoAndItemNo.split("_");
			if(storeNoAndItemNoArr.length>1)
			{
				var storeNo=storeNoAndItemNoArr[0];
				
				for (var  j= 0; j < orderStoreArr.length; j++) {
					var storeJs=orderStoreArr[j];
					if(storeJs.storeNo==storeNo)
			    	   {
						orderStoreArr=orderStoreArr.del(j);
			    	    j=-1;
			    	   }
				}
				var itemNo=storeNoAndItemNoArr[1];
				// 清除相应订单商品门店数据
				for (var i = 0; i < orderItemArr.length; i++) {
					var orderItemJson = orderItemArr[i];
					if (orderItemJson.itemNo == itemNo) {
						 if(orderItemArr[i].orderItemStoreArr)
       	    		  {
					       var orderItemStoreArr=orderItemArr[i].orderItemStoreArr;
					       for (var j = 0; j < orderItemStoreArr.length; j++) {
					    	   var orderItemStore=orderItemStoreArr[j];
						       if(orderItemStore.storeNo==storeNo)
						    	   {
						    	   orderItemStoreArr=orderItemStoreArr.del(j);
						    	    j=-1;
						    	   }
					        }
					       $(this).parent().remove();
					       orderItemArr[i].orderItemStoreArr=orderItemStoreArr;
					       
       	    		 }
						
					}
				}
				
		}
	
    });
	//取消選取全選框
	clearCheckAll();
	if(storeNoCkArr.length==0)
	{
		top.jAlert('warning', '请选择要删除的订单商品分店信息！', '提示消息');
		return;
	}
});

$(".checkAll").on("click",function(){
	var check=$(this).attr("checked");
	$('input[name="storeNoCk"]').each(function() {
		if(check=='checked'&&!$(this).attr("disabled"))
			{
    	      $(this).attr("checked",true);
			}
		else
			{
			 $(this).attr("checked",false);
			}
  });	
});

function isNumber(val){
	if(/^[0-9]*[1-9][0-9]*$/.test(val))
	{
		return true;
	}
	return false;
}


$(".ordMultiParmBody").die("blur").live("blur",function(){
		var ordMultiParmVal = $(this).val();
		if(ordMultiParmVal!=""&&!isNumber(ordMultiParmVal))
		{
		top.jAlert('warning', '请输入整数!', '提示消息');
		$(this).val('');
		return;
	    }
		$("input[name='ordMultiParmInput']").each(function(){
		   var ordMultiParm=$(this).parent().find("input[name='ordMultiParm']").val();
     	   var bei=Math.ceil((ordMultiParmVal)/Number(ordMultiParm));
     	   var ordMultiParmAcc=Number(ordMultiParm)*Number(bei);
     	   if(ordMultiParmAcc==0){
     		  $(this).val("");
     	   }
     	   else{
     		  $(this).val(ordMultiParmAcc); 
     	   }
		    //订购数量
		  var itemNo=$(this).parent().find("input[name='itemNo']").val();
		  var storeNo=$(this).parent().find("input[name='storeNo']").val();
	      for (var i = 0; i < orderItemArr.length; i++) {
	    	 
	    	  if(orderItemArr[i].orderItemStoreArr)
	    		  {
			       var orderItemStore=orderItemArr[i].orderItemStoreArr;
			       for (var j = 0; j < orderItemStore.length; j++) {
			    	   var orderItemStoreInfo=orderItemStore[j];
				       if(orderItemStoreInfo.itemNo==itemNo&&orderItemStoreInfo.storeNo==storeNo)
				    	   {
				    	   orderItemStoreInfo.buyCount=ordMultiParmAcc;
				    	   orderItemStore[j]=orderItemStoreInfo;
				    	   }
			        }
			       orderItemArr[i].orderItemStoreArr=orderItemStore;
			       
	    		 }
			  
		  }
		});
		
	});
//变价处理
$(".hoOrderCreateStore .buyPriceChangeBody").die().live("blur",function(){
	var buyPriceChangeVal = $.trim($(this).val());
	var buyPriceChangeValWithOutBpDisc = $.trim($(this).val());
	var buyBpDisc = $.trim($('#bpDisc').val());
	if(!isMoney(buyPriceChangeVal))
	{
	top.jAlert('warning', '金额格式有误!', '提示消息');
	$(this).val('');
	return;
    }
	
	if(buyBpDisc!='')
	{
		buyPriceChangeVal = Math.round((buyPriceChangeVal*(1-buyBpDisc/100))*10000)/10000;
	}
	
	$("input[name='buyPriceChange']").each(function(){
	   var buyPrice=$(this).parent().find("input[name='buyPrice']").val();
	   var curBuyPriceLimit=$(this).parent().find("input[name='buyPriceLimit']").val();
	   $(this).parent().find("input[name='buyPriceChange']").removeClass("errorInput");
	   $(this).parent().find("input[name='buyPriceChange']").removeAttr('title');

	   if(buyPriceChangeVal > curBuyPriceLimit)
	   {
		   $(this).parent().find("input[name='buyPriceChange']").addClass("errorInput");
		   $(this).parent().find("input[name='buyPriceChange']").attr('title','超出买价限制');
	   }
	   if(buyPriceChangeVal=="")
		   {
		   var  promNoBefore=$(this).parent().find("input[name='promNoBefore']").val();
    	   $(this).parent().find("input[name='promNo']").val(promNoBefore);
    	   $(this).parent().find("input[name='buyPriceChange']").val(buyPrice);
	          var itemNo=$(this).parent().find("input[name='itemNo']").val();
			  var storeNo=$(this).parent().find("input[name='storeNo']").val();
		      for (var i = 0; i < orderItemArr.length; i++) {
		    	 
		    	  if(orderItemArr[i].orderItemStoreArr)
		    		  {
				       var orderItemStore=orderItemArr[i].orderItemStoreArr;
				       for (var j = 0; j < orderItemStore.length; j++) {
				    	   var orderItemStoreInfo=orderItemStore[j];
					       if(orderItemStoreInfo.itemNo==itemNo&&orderItemStoreInfo.storeNo==storeNo)
					    	   {
					    	   orderItemStoreInfo.buyPriceChange=buyPrice;
					    	   orderItemStoreInfo.promNo=promNoBefore;
					    	   orderItemStore[j]=orderItemStoreInfo;
					    	   }
				        }
				       orderItemArr[i].orderItemStoreArr=orderItemStore;
				       
		    		 }
				  
			  }
		   }
      else if(buyPrice!=buyPriceChangeVal)
    	   {
    	  $(this).parent().find("input[name='promNo']").val("");
    	   $(this).parent().find("input[name='buyPriceChange']").val(buyPriceChangeVal);
	  var itemNo=$(this).parent().find("input[name='itemNo']").val();
	  var storeNo=$(this).parent().find("input[name='storeNo']").val();
      for (var i = 0; i < orderItemArr.length; i++) {
    	 
    	  if(orderItemArr[i].orderItemStoreArr)
    		  {
		       var orderItemStore=orderItemArr[i].orderItemStoreArr;
		       for (var j = 0; j < orderItemStore.length; j++) {
		    	   var orderItemStoreInfo=orderItemStore[j];
			       if(orderItemStoreInfo.itemNo==itemNo&&orderItemStoreInfo.storeNo==storeNo)
			    	   {
			    	   orderItemStoreInfo.buyPriceChange=buyPriceChangeVal;
			    	   orderItemStoreInfo.buyPriceChangeWithOutBpDisc = buyPriceChangeValWithOutBpDisc;
			    	   orderItemStoreInfo.promNo="";
			    	   orderItemStore[j]=orderItemStoreInfo;
			    	   }
		        }
		       orderItemArr[i].orderItemStoreArr=orderItemStore;
		       
    		 }
		  
	  }
    	   }
       
       else{
    	   var  promNoBefore=$(this).parent().find("input[name='promNoBefore']").val();
    	   $(this).parent().find("input[name='promNo']").val(promNoBefore);
    	   $(this).parent().find("input[name='buyPriceChange']").val(buyPrice);
	          var itemNo=$(this).parent().find("input[name='itemNo']").val();
			  var storeNo=$(this).parent().find("input[name='storeNo']").val();
		      for (var i = 0; i < orderItemArr.length; i++) {
		    	 
		    	  if(orderItemArr[i].orderItemStoreArr)
		    		  {
				       var orderItemStore=orderItemArr[i].orderItemStoreArr;
				       for (var j = 0; j < orderItemStore.length; j++) {
				    	   var orderItemStoreInfo=orderItemStore[j];
					       if(orderItemStoreInfo.itemNo==itemNo&&orderItemStoreInfo.storeNo==storeNo)
					    	   {
					    	   orderItemStoreInfo.buyPriceChange=buyPriceChangeVal;
					    	   orderItemStoreInfo.buyPriceChangeWithOutBpDisc = buyPriceChangeValWithOutBpDisc;
					    	   orderItemStoreInfo.promNo=promNoBefore;
					    	   orderItemStore[j]=orderItemStoreInfo;
					    	   }
				        }
				       orderItemArr[i].orderItemStoreArr=orderItemStore;
				       
		    		 }
				  
			  }
       }
	});
	
});
$(".hoOrderCreateStore input[name='buyPriceChange']").die().live('change',function(){
	   var buyPrice=$(this).parent().find("input[name='buyPrice']").val();
	   var buyBpDisc = $.trim($('#bpDisc').val());
	   var buyPriceChangeVal = $.trim($(this).val());
	   var buyPriceChangeValWithOutBpDisc = $.trim($(this).val());
	   var curBuyPriceLimit=$(this).parent().find("input[name='buyPriceLimit']").val();
	   $(this).removeClass("errorInput");
	   $(this).removeAttr('title');
	if (!isMoney(buyPriceChangeVal)) {
		top.jAlert('warning', '金额格式有误!', '提示消息');
		$(this).val('');
		return;
	}
	if(buyPriceChangeVal > curBuyPriceLimit)
	{
		$(this).addClass("errorInput");
		$(this).attr('title','超出买价限制');
		return false;
	}
	if(buyBpDisc!='')
	{
		buyPriceChangeVal = Math.round((buyPriceChangeVal*(1-buyBpDisc/100))*10000)/10000;
	}
	if (buyPriceChangeVal == "") {
		var promNoBefore = $(this).parent().find("input[name='promNoBefore']").val();
		$(this).parent().find("input[name='promNo']").val(promNoBefore);
		$(this).parent().find("input[name='buyPriceChange']").val(buyPrice);
		var itemNo = $(this).parent().find("input[name='itemNo']").val();
		var storeNo = $(this).parent().find("input[name='storeNo']").val();
		for (var i = 0; i < orderItemArr.length; i++) {
	
			if (orderItemArr[i].orderItemStoreArr) {
				var orderItemStore = orderItemArr[i].orderItemStoreArr;
				for (var j = 0; j < orderItemStore.length; j++) {
					var orderItemStoreInfo = orderItemStore[j];
					if (orderItemStoreInfo.itemNo == itemNo
							&& orderItemStoreInfo.storeNo == storeNo) {
						orderItemStoreInfo.buyPriceChange = buyPrice;
						orderItemStoreInfo.promNo = promNoBefore;
						orderItemStore[j] = orderItemStoreInfo;
					}
				}
				orderItemArr[i].orderItemStoreArr = orderItemStore;
	
			}
	
		}
	} else if (buyPrice != buyPriceChangeVal) {
		$(this).parent().find("input[name='promNo']").val("");
		$(this).parent().find("input[name='buyPriceChange']")
				.val(buyPriceChangeVal);
		var itemNo = $(this).parent().find(
				"input[name='itemNo']").val();
		var storeNo = $(this).parent().find(
				"input[name='storeNo']").val();
		for (var i = 0; i < orderItemArr.length; i++) {
	
			if (orderItemArr[i].orderItemStoreArr) {
				var orderItemStore = orderItemArr[i].orderItemStoreArr;
				for (var j = 0; j < orderItemStore.length; j++) {
					var orderItemStoreInfo = orderItemStore[j];
					if (orderItemStoreInfo.itemNo == itemNo
							&& orderItemStoreInfo.storeNo == storeNo) {
						orderItemStoreInfo.buyPriceChange = buyPriceChangeVal;
						orderItemStoreInfo.buyPriceChangeWithOutBpDisc = buyPriceChangeValWithOutBpDisc;
						orderItemStoreInfo.promNo = "";
						orderItemStore[j] = orderItemStoreInfo;
					}
				}
				orderItemArr[i].orderItemStoreArr = orderItemStore;
	
			}
	
		}
	}
	
	else {
		var promNoBefore = $(this).parent().find(
				"input[name='promNoBefore']").val();
		$(this).parent().find("input[name='promNo']").val(
				promNoBefore);
		$(this).parent().find("input[name='buyPriceChange']")
				.val(buyPrice);
		var itemNo = $(this).parent().find(
				"input[name='itemNo']").val();
		var storeNo = $(this).parent().find(
				"input[name='storeNo']").val();
		for (var i = 0; i < orderItemArr.length; i++) {
	
			if (orderItemArr[i].orderItemStoreArr) {
				var orderItemStore = orderItemArr[i].orderItemStoreArr;
				for (var j = 0; j < orderItemStore.length; j++) {
					var orderItemStoreInfo = orderItemStore[j];
					if (orderItemStoreInfo.itemNo == itemNo
							&& orderItemStoreInfo.storeNo == storeNo) {
						orderItemStoreInfo.buyPriceChange = buyPriceChangeVal;
						orderItemStoreInfo.buyPriceChangeWithOutBpDisc = buyPriceChangeValWithOutBpDisc;
						orderItemStoreInfo.promNo = promNoBefore;
						orderItemStore[j] = orderItemStoreInfo;
					}
				}
				orderItemArr[i].orderItemStoreArr = orderItemStore;
	
			}
	
		}
	}
});

/**
 * 當已填入分店訊息後, 修改預定收貨日時彈出提示訊息 
 * @param dp DatePicker
 */
function dateChangeConfirm(dp){
	if ($(".hoOrderCreateStore .pro_store_tb .ig_padding").length >0 && (dp.cal.getDateStr() != dp.cal.getNewDateStr())){
		var old_date = dp.cal.getDateStr();
		top.jConfirm('修改预定收货日期, 分店信息将清空. 是否要继续  ?', '提示消息', function(ret) {
			if (ret) {
				planDateChange();
			} else {
				$("#planRecptDate").val(old_date);
				return;
			}
		});
	}
}

function planDateChange(){
	//清空订购数量,赠品数量,买价格
	$(".s_tit .ordMultiParmBody").attr('value',"");
	$(".s_tit .promotionalItemsBody").attr('value',"");
	$(".s_tit .buyPriceChangeBody").attr('value',"");
	// 清除订单商品门店数据
	for (var i = 0; i < orderItemArr.length; i++) {
		orderItemArr[i].orderItemStoreArr=[];
	}
	 $(".pro_store_tb").html("");
	 $(".get_store").removeClass("get_store");
	 if(orderItemArr.length>0){
	 $("#pro_store_tb_edit").find(".item:first").click();
	 }
}
function planDateChange1(){
	//触发change事件
    $("#planRecptDate").blur();
}
$("input[name='ordMultiParmInput']").die("change").live("change",function(){
	var ordMultiParmVal = $(this).val();
	if(ordMultiParmVal!=""&&!isNumber(ordMultiParmVal))
	{
	top.jAlert('warning', '请输入整数!', '提示消息');
	$(this).val('');
	return;
    }
	  var ordMultiParm=$(this).parent().find("input[name='ordMultiParm']").val();
	  var bei=Math.ceil((ordMultiParmVal)/Number(ordMultiParm));
	  ordMultiParmAcc=Number(ordMultiParm)*Number(bei);
     
	  if(ordMultiParmAcc==0){
		  $(this).val("");
	  }
	  else{
		  $(this).val(ordMultiParmAcc);  
	  }
	    //订购数量
	  var itemNo=$(this).parent().find("input[name='itemNo']").val();
	  var storeNo=$(this).parent().find("input[name='storeNo']").val();
      for (var i = 0; i < orderItemArr.length; i++) {
  	 
  	  if(orderItemArr[i].orderItemStoreArr)
  		  {
		       var orderItemStore=orderItemArr[i].orderItemStoreArr;
		       for (var j = 0; j < orderItemStore.length; j++) {
		    	   var orderItemStoreInfo=orderItemStore[j];
			       if(orderItemStoreInfo.itemNo==itemNo&&orderItemStoreInfo.storeNo==storeNo)
			    	   {
			    	   orderItemStoreInfo.buyCount=ordMultiParmAcc;
			    	   orderItemStore[j]=orderItemStoreInfo;
			    	   }
		        }
		       orderItemArr[i].orderItemStoreArr=orderItemStore;
		       
  		 }
		  
	  }
});
$(".promotionalItemsBody").die("blur").live("blur",function(){
	var promotionalItemsCountVal = $.trim($(this).val());
	var itemType=$(".item_on").find("input[name='itemType']").val();
	if(promotionalItemsCountVal!='' && itemType == 1)
	{
		if(!isFloat(promotionalItemsCountVal,6,3))
		{
			top.jAlert('warning', '整数不能超过7位,小数不能超过3位!', '提示消息');
			$(this).val('');
			return;
		}
	}	
	else if(promotionalItemsCountVal!=''&&!isNumber(promotionalItemsCountVal))
	{
	top.jAlert('warning', '请输入整数!', '提示消息');
	$(this).val('');
	return;
    }
	if(promotionalItemsCountVal!='')
	{
		promotionalItemsCountVal=Number($(this).val());
	}

	$("input[name='promotionalItemsCount']").each(function(){
	   $(this).val(promotionalItemsCountVal);
	    //赠品数量
	  var itemNo=$(this).parent().find("input[name='itemNo']").val();
	  var storeNo=$(this).parent().find("input[name='storeNo']").val();
      for (var i = 0; i < orderItemArr.length; i++) {
    	 
    	  if(orderItemArr[i].orderItemStoreArr)
    		  {
		       var orderItemStore=orderItemArr[i].orderItemStoreArr;
		       for (var j = 0; j < orderItemStore.length; j++) {
		    	   var orderItemStoreInfo=orderItemStore[j];
			       if(orderItemStoreInfo.itemNo==itemNo&&orderItemStoreInfo.storeNo==storeNo)
			    	   {
			    	   orderItemStoreInfo.promotionalItemsCount=promotionalItemsCountVal;
			    	   orderItemStore[j]=orderItemStoreInfo;
			    	   }
		        }
		       orderItemArr[i].orderItemStoreArr=orderItemStore;
		       
    		 }
		  
	  }
	});
	
});

$("input[name='promotionalItemsCount']").die("change").live("change",function(){
	var promotionalItemsCountVal = $.trim($(this).val());
	var itemType=$(".item_on").find("input[name='itemType']").val();
	if(promotionalItemsCountVal!='' && itemType == 1)
	{
		if(!isFloat(promotionalItemsCountVal,6,3))
		{
			top.jAlert('warning', '整数不能超过7位,小数不能超过3位!', '提示消息');
			$(this).val('');
			return;
		}
	}		
	else if(promotionalItemsCountVal!='' && !isNumber(promotionalItemsCountVal))
	{
	top.jAlert('warning', '请输入整数!', '提示消息');
	$(this).val('');
	return;
    }
	
	if(promotionalItemsCountVal!='')
	{
		promotionalItemsCountVal=Number($(this).val());
	}	
	$(this).val(promotionalItemsCountVal);
	    //赠品数量
	  var itemNo=$(this).parent().find("input[name='itemNo']").val();
	  var storeNo=$(this).parent().find("input[name='storeNo']").val();
      for (var i = 0; i < orderItemArr.length; i++) {
    	 
    	  if(orderItemArr[i].orderItemStoreArr)
    		  {
		       var orderItemStore=orderItemArr[i].orderItemStoreArr;
		       for (var j = 0; j < orderItemStore.length; j++) {
		    	   var orderItemStoreInfo=orderItemStore[j];
			       if(orderItemStoreInfo.itemNo==itemNo&&orderItemStoreInfo.storeNo==storeNo)
			    	   {
			    	   orderItemStoreInfo.promotionalItemsCount=promotionalItemsCountVal;
			    	   orderItemStore[j]=orderItemStoreInfo;
			    	   }
		        }
		       orderItemArr[i].orderItemStoreArr=orderItemStore;
		       
    		 }
		  
	  }
});
function isMoney(param)
{
	var reg = /^([1-9][\d]{0,5}|0)(\.[\d]{1,4})?$/;
    if($.trim(param)=='')
    {
    	return true;
    }
    if(!reg.test(param)){  
       return false; 
     }
    else
    {
    	return true;
    }
}

//查询厂商信息
function readSupInfoByCatlgIdAndSupNo(catlgId,supNo, methodName) {
	$.ajax({
		type : 'post',
		url : ctx + '/hoOrderCreate/readSupInfoBySupNo?tt='
				+ new Date().getTime(),
		dataType:"json",		
		data : {
			catlgId : catlgId,
			supNo:supNo
		},
		success : function(data) {
			methodName(data);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			//这里是ajax错误信息
			top.jAlert('error', '网络超时!请稍后重试', '提示消息');
		}
	});
}

//厂商选项
$("#supId").unbind("change").change(function(){
	$("#addSupName").val("");
var addSupId=$.trim($("#supId").val());
$("#supId").attr('value',addSupId);
var addCatlgId=$("#catlgId").val();
var catlgId = $('#catlgId').val();
if (catlgId == "") {
	top.jAlert('warning', '请选择课别！', '消息提示');
	$("#supId").val("");
	return;
}
//清除之前订单商品数组
orderItemArr = [];
$("#pro_store_tb_edit").html("");
$(".pro_store_tb").html("");
$("#buyerName").val("");
$("#buyer").val("");

//$('#supId').val("");
$('#addSupName').val("");
$('#comNo').val("");
$('#supUnifmNo').val("");
$('#supType').val("");

$("#bpDisc").val("");
$("#invDisc").val("");
$("#discMemo").val("");
if(addSupId=="")
{
	//nothing to do;
}
else if(!isNumber(addSupId))
{
	top.jAlert('warning', '请注意输入厂商编号！', '消息提示');
	$("#supId").val("");
	return;
}
if(isNumber(addCatlgId) && isNumber(addSupId) && addSupId!=""){
     //加载厂商信息
	readSupInfoByCatlgIdAndSupNo(addCatlgId,addSupId,function(data){
          if(data!=""&&data!=null){
				var catlgId = $('#catlgId').val();
				$('#supId').attr('value', data[0].supNo);
				$('#addSupName').attr('value', data[0].comName);
				$('#comNo').attr('value', data[0].comNo);
				$('#supUnifmNo').attr('value', data[0].unifmNo);
				$('#supType').attr('value', data[0].supType);
				
				
				
				// 清除之前订单商品数组
				orderItemArr=[];
			 $("#pro_store_tb_edit").html("");
			 $(".pro_store_tb").html("");
			 $("#buyerName").val("");
			 $("#buyer").val("");
				if (typeof (data[0].supNo) != "undefined" && data[0].supNo != ""
						&& typeof (catlgId) != "undefined" && catlgId != "") {
					$.ajax({
						async : false,
						url : ctx + '/hoOrderCreate/getSupDiscInfo?ti='
								+ (new Date()).getTime(),
						data : {
							'supNo' : data[0].supNo,
							'catlgId' : catlgId
						},
						type : 'POST',
						success : function(response) {
							var supplier = response["row"];
							if (supplier != null && supplier != "") {
								$("#bpDisc").val(supplier.bpdisc);
								$("#invDisc").val(supplier.invDisc);
								$("#discMemo").val(supplier.discMemo);
							}

						},
						error : function(XMLHttpRequest, textStatus, errorThrown) {
							top.jAlert('error', '网络超时!请稍后重试', '提示消息');
						}
					});
				}
              }else{
            		top.jAlert('warning', '没有找到符合条件的厂商！', '消息提示');
            		$("#supId").val("");
            	}
		});		
}
});

$(".showStoresBar").unbind("click").bind("click",function(){

	var itemNo = $('.pro_store_tb_edit .item_on').find("input[name='itemNo'").val();
	if(itemNo=""||itemNo==undefined)
		{
		 top.jAlert('warning', '请选择订单商品', '提示消息');
    	 return;
		}
	//取消選取全選框
	clearCheckAll();
	openPopupWinTwo(624, 423, "/order/hoOrderStoresShow?itemNumModStr="
								+ itemNo);
});

function addStoreLs(){
	var itemNo = $('.pro_store_tb_edit .item_on').find("input[name='itemNo'").val();
	var planRecptDate = $('#planRecptDate').val();
	var orderDate = $('#orderDate').val();
	var bpDisc = $('#bpDisc').val();
	var ordSupNo=$('#supId').val();
	var ordCatlgId=$('#catlgId').val();
	var storeArr=[];
	$('input[name="hypeMarketNo"]:checked').each(function() {
		storeArr.push($(this).val());
     });
	$('input[name="machiningNo"]:checked').each(function() {
		storeArr.push($(this).val());
     });
	
	if(storeArr.length==0){
		 top.jAlert('warning', '请选择要添加的门店信息', '提示消息');
    	 return;
	}
	 var index=0;
	 var orderItemJsGlo={};
	  for (var i = 0; i < orderItemArr.length; i++) {
		  var orderItemJs=orderItemArr[i];
		  if(orderItemJs.itemNo==itemNo)
			{
			     index=i;
			     orderItemJsGlo=orderItemArr[i];
			}
		  
	  }
	 
	 
	  if(orderItemJsGlo.buyWhen==2)
		{
			$(".buyPriceChangeBody").removeClass("Black");
			$(".buyPriceChangeBody").removeAttr("readonly");

		}
	$.ajax({
		async : false,
		url : ctx + '/hoOrderCreate/getHoOrderItemStoreList?ti='+(new Date()).getTime(),
		data : {'itemNo':itemNo,
				'storeStr':storeArr.join(","),
				'planRecptDate':planRecptDate,
				'orderDate':orderDate,
				'bpDisc':bpDisc,
				'supNo':ordSupNo,
				'catlgId':ordCatlgId},
		type : 'POST',
		success : function(response) {
			var itemStoreList = response["row"];
			if (itemStoreList == null) {
				return;
			}
			var htmlStr = $(".pro_store_tb").html();
			var orderItemStoreArr=orderItemArr[index].orderItemStoreArr;
			for (var i = 0; i < itemStoreList.length; i++) {
				var itemStore = itemStoreList[i];
				var orderItemStoreJs={};
				var storeJs={'storeNo':itemStore.storeNo};
				orderStoreArr.push(storeJs);
				orderItemStoreJs.itemNo = itemStore.itemNo;
				orderItemStoreJs.storeNo = itemStore.storeNo;
				orderItemStoreJs.storeName = itemStore.storeName;
				orderItemStoreJs.status = itemStore.status;
				orderItemStoreJs.netCost = itemStore.netCost;
				if(itemStore.netCost==null)
				{
					itemStore.netCost="";
				}
				orderItemStoreJs.dms = itemStore.dms;
				orderItemStoreJs.stock = itemStore.stock;
				orderItemStoreJs.ordMultiParm = itemStore.ordMultiParm;
				orderItemStoreJs.promNo = itemStore.promNo;
				orderItemStoreJs.promNoBefore = itemStore.promNo;
				orderItemStoreJs.buyPrice = itemStore.buyPrice;
				orderItemStoreJs.buyPriceChange = itemStore.buyPrice;
				orderItemStoreJs.buyPriceChangeWithOutBpDisc = itemStore.buyPrice;
				orderItemStoreJs.buyVatNo = itemStore.buyVatNo;
				orderItemStoreJs.buyVatVal = itemStore.buyVatVal;
				orderItemStoreJs.recvBleQty="";
				if(itemStore.recvBleQty!=null){
					orderItemStoreJs.recvBleQty = itemStore.recvBleQty;
				}
				
				 var stock='0';
                 if(itemStore.stock!=null)
                 {
                 	stock=itemStore.stock;
                 }
                 var recvBleQty="0";
                 if(itemStore.recvBleQty!=null)
                 {
                 	recvBleQty=itemStore.recvBleQty;
                 }
                 var dms='0';
                 if(itemStore.dms!=null)
                 {
                 	dms=itemStore.dms;
                 }
				orderItemStoreJs.buyCount = "";
				orderItemStoreJs.promotionalItemsCount="";
				orderItemStoreJs.buyPriceLimit=itemStore.buyPriceLimit;
                orderItemStoreArr.push(orderItemStoreJs);
                var statusName = getDictValue('ITEM_BASIC_STATUS',
                		itemStore.status);
                var promNo="";
                if(itemStore.promNo!=null)
                {
                	promNo=itemStore.promNo;
                }
                htmlStr+="<div class='ig_padding'>";
                htmlStr+="<input type='checkbox' name='storeNoCk' value='"+itemStore.storeNo+'_'+itemStore.itemNo+"' class='fl_left' onchange='checkSelectAll(this)' />";
                htmlStr+="<input type='text' name='storeNoAndName' value='"+itemStore.storeNo+"-"+itemStore.storeName+"' class='inputText w10 fl_left Black' readonly='readonly'/>";
                htmlStr+="<input type='text' name='status' value='"+statusName+"' class='inputText w8 fl_left Black' readonly='readonly'/>";
                htmlStr+="<input type='text' name='promNo' value='"+promNo+"' class='inputText w8 fl_left Black' readonly='readonly'/>";
                htmlStr+="<input type='hidden' name='promNoBefore' value='"+promNo+"' />";
                htmlStr+="<input type='text' name='ordMultiParmInput' id='ordQty-"+itemStore.storeNo +"' class='inputText w7 fl_left ' />";
                htmlStr+="<input type='text' name='promotionalItemsCount' class='inputText w7 fl_left ' />";
                if(orderItemJsGlo.buyWhen==2)
                {
                htmlStr+="<input type='text' name='buyPriceChange' value='"+itemStore.buyPrice+"' class='inputText w10 fl_left' />";
                htmlStr+="<input type='hidden' name='buyPrice' value='"+itemStore.buyPrice+"' />";

                }
                else{
                    htmlStr+="<input type='text' name='buyPrice' value='"+itemStore.buyPrice+"' class='inputText w10 fl_left Black' readonly='readonly'/>";
                }
                htmlStr+="<input type='text' name='ordMultiParm' value='"+itemStore.ordMultiParm+"' class='inputText w5 fl_left Black' readonly='readonly'/>";
                htmlStr+="<input type='text' name='buyVatVal' value='"+itemStore.buyVatVal+"%' class='inputText w5 fl_left Black' readonly='readonly'/>";
                htmlStr+="<input type='hidden' name='buyVatNo' value='"+itemStore.buyVatNo+"' />";
                htmlStr+="<input type='text' name='netCost' value='"+itemStore.netCost+"' class='inputText w8 fl_left Black' readonly='readonly'/>";
                htmlStr+="<input type='text' name='dms' value='"+dms+"' class='inputText w7 fl_left Black' readonly='readonly'/>";
                htmlStr+="<input type='text' name='recvBleQty' value='"+recvBleQty+"' class='inputText w7 fl_left Black' readonly='readonly'/>";
                htmlStr+="<input type='text' name='stock' value='"+stock+"' class='inputText w7 fl_left Black' readonly='readonly'/>";
                htmlStr+="<input type='hidden' name='itemNo' value='"+itemStore.itemNo+"' />";
                htmlStr+="<input type='hidden' name='storeNo' value='"+itemStore.storeNo+"' />";
                htmlStr+="<input type='hidden' name='buyPriceLimit' value='"+itemStore.buyPriceLimit+"' />";
                
                htmlStr+="<div class='clearBoth'></div>";
                htmlStr+="</div>";

			}
		    var oldOrderItemJs=orderItemArr[index];
		    oldOrderItemJs.orderItemStoreArr=orderItemStoreArr;
		    orderItemArr[index]=oldOrderItemJs;
			$(".pro_store_tb").html(htmlStr);
			closePopupWinTwo();

		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			top.jAlert('error', '网络超时!请稍后重试', '提示消息');
		}
	});
}

function resetCheckAll(obj) {
	if (obj.find('input:checkbox:not(:checked)').size()!=0 || obj.find('input:checkbox:checked').size()==0) {
		obj.prev().find('.checkAll').attr('checked', false);
	} else if (obj.find('input:checkbox:not(:checked)').size() == 0) {
		obj.prev().find('.checkAll').attr('checked', true);
	}
}

/**
 * 批量輸入訂購數量視窗 
 */
function pasteOrdQty(){
	if ($(".hoOrderCreateStore:visible .store_tb2 .ig_padding").length == 0) {
		top.jAlert('warning', '请选择要编辑订购数量的商品', '提示消息');
		return;
	}
	openPopupWin(650, 500, '/hoOrderCreate/pasteOrdQty');
}

/**
 * 批量貼上訂購數量後, 分開店號和數量, 檢查完後放到頁面上  
 */
function parseOrdQty(){
	var result = [];
	var count = 0;
	var errorMsg = "";
	var lines = $('#ordQtyArea').val().split('\n');
	var inputArray = [];
	// 分析輸入的內容, 將店號與數量分開, 放入 result array
	$.each(lines, function(index, value){
		if ($.trim(value)){
			var temp = $.trim(value).split(/(\s+)/);
			if (isNumber($.trim(temp[0]).substr(0,3)) && isNumber($.trim(temp[temp.length-1]))){
				inputArray = [];
				inputArray.push($.trim(temp[0].substr(0,3)));
				inputArray.push($.trim(temp[(temp.length-1)]));
				result[count] = inputArray;
				count ++;
			}else{
				errorMsg += "第" + (index+1) + "行有誤; ";
			}
		}
	});
	if (errorMsg){
		$('.msg').text(errorMsg);
		return false;
	}
	$.each(result, function(index, value){
		$('#ordQty-'+ $.trim(value[0]) +':visible').val($.trim(value[1]));
	});
	return true;
}

/**
 * 批量輸入的訂購數量後, trigger change 的檢查 
 */
function submitOrdQty(){
	if (parseOrdQty()){
		closePopupWin();
		var valueArray = $("input[name='ordMultiParmInput']:visible");
		$.each(valueArray, function(index, value){
			if ($.trim(value.value)!="" && $.trim(value.value) != 0){
				$("input[name='ordMultiParmInput']:visible:eq("+ index+ ")").trigger('change');
			}
		});
	}
}

/**
 * 檢查全選框是否要勾選
 * @param obj
 */
function checkSelectAll(obj){
	var name = $(obj).attr("name");
	if ($(".hoOrderCreateStore .store_tb2 input[name=" + name + "]").length == $(".hoOrderCreateStore .store_tb2 input[name=" + name + "]:checked").length){
		$(".hoOrderCreateStore .top5 .checkAll").attr("checked", "checked");
	}
	else{
		$(".hoOrderCreateStore .top5 .checkAll").removeAttr("checked");
	}
}

/**取消選取下方分店訊息的全選框
 * 
 */
function clearCheckAll(){
	$('input[name="storeNoCk"]').removeAttr("checked");	
}
