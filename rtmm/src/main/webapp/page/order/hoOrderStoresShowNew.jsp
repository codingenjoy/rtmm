<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css" rel="Stylesheet" />
<style type="text/css">
.Table_Panel {
	height: 325px;
	overflow: hidden;
}

.CM_p {
	height: 280px;
	width: 595px;
	margin: 20px 2px 0px 20px;
}

.t2,.t3 {
	height: 240px;
	overflow-x: hidden;
	overflow-y: auto;
	float: left;
	background: #fff;
	margin-top: 20px;
	border: 1px solid #808080;
}

.t2 {
	width: 328px;
	margin-left: 20px;
}

.t3 {
	width: 200px;
	margin-left: 5px;
}

.CM2 {
	background: #f9f9f9;
	width: 296px;
	height: 240px;
	float: right;
	margin-top: 3px;
}

.b {
	height: 209px;
	overflow: auto;
}

.d {
	width: 235px;
	height: 200px;
	background: #fff;
	margin: 20px auto auto 40px;
	border: 1px solid #808080;
}

.e,.f,.b {
	width: 215px;
	margin: 0 auto;
	line-height: 26px;
}

.e {
	overflow: auto;
	height: 169px;
	width:95%;
}

.e div,.b div {
	border-top: 1px solid #fff;
	height: 28px;
	cursor: pointer;
}

.f {
	border-top: 1px solid #808080;
	height: 30px;
	width:95%;
}

.tree-icon {
	display: none;
}

.Panel_footer {
	width: 937px;
}

.first_div {
	height: 100%;
	width: 100%;
}

.second_div {
	height: 89px;
	width: 100%;
	margin-top: 2px;
}
</style>
<script type="text/javascript">
/*bind the checkbox event.*/
$("#storeDiv input[name='hypeMarketNo']").unbind().bind('click', function(){
	checkChkAllBoxStat();
    });
/*rewrite the indexOf method of Array.*/
Array.prototype._indexOf = function(n){
	if("indexOf" in this){   
	return this["indexOf"](n);   
	}   
	for(var i=0;i<this.length;i++){   
	if(n===this[i]){   
	return i;   
	}   
	}   
	return -1;   
}; 
/*init the hype market tree.*/
initHypeMarketTree();

function initHypeMarketTree(){
	var count=0;
	var itemNo = $('.pro_store_tb_edit .item_on').find("input[name='itemNo']").val();
	var supId=$('#supNo').val();
	var catlgId=$('#catlgId').val();
	//get store Nos of the current item.
	var existedStores = pHOOrderHandler.getStoreNOsOfCurrentItem();
	//delete the hypeMarket tree.
	$('#hypeMarketArea').find('li').remove();		
	//load the hypeMarket tree.
	$.post(ctx + "/order/getItemRegion?itemNo="+itemNo + '&catlgId=' + catlgId + '&supId=' + supId, {
	}, function(data) {
		$('#hypeMarketArea').tree({
			checkbox : true,
			data : data.tree,
			onCheck : function(node,checked) {
				count++;
				if(count>1){
					getStoreByRegion(node,checked,existedStores,itemNo,catlgId,supId);
				}
			}
		});
	}, "json");
}

/*check all the hype market when multiply modify
  the item store page.*/	
function hypeMarketCheckAll(self) {
	if (self.checked) {
		$("#storeDiv input[name='hypeMarketNos']").not('[disabled="disabled"]').attr(
				'checked', true);
	} else {
		$("#storeDiv input[name='hypeMarketNos']").not('[disabled="disabled"]').attr(
				'checked', false);
	}
}

/*change the checkALLBox's state when 
 check the single store state.*/	
function checkChkAllBoxStat(){
	/*check the checkAllBox if　disabled*/
	if($("#storeDiv input[name='hypeMarketNos']").not('[disabled="disabled"]').length==0){
		$('#storeCheckAll').attr("disabled","disabled");
	}
	else{
		$('#storeCheckAll').removeAttr("disabled");
		/*check the checkAllBox if　checked*/
		if ($("#storeDiv input[name='hypeMarketNos']:checked").not('[disabled="disabled"]').length != 0 && 
				($("#storeDiv input[name='hypeMarketNos']").not('[disabled="disabled"]').length == 
				$("#storeDiv input[name='hypeMarketNos']:checked").not('[disabled="disabled"]').length))
		{
			$('#storeCheckAll').attr("checked", "checked");
		}
		else{
			$('#storeCheckAll').removeAttr("checked");
		}
	}
	return;
}

/*get the stores when checking the region in the hype market tree.*/
function getStoreByRegion(node,checked,existedStores,itemNo,catlgId,supId){
	/*get all the region id.*/
	var nodes = $('#hypeMarketArea').tree('getChildren', node.target);
	var regnNoList="";
	if(nodes.length>0){
		for(var i=0;i<nodes.length;i++){
			regnNoList = regnNoList +","+ nodes[i].id;
		}
		regnNoList=regnNoList.substring(1,regnNoList.length);
	}
	else{
		return false;
	}
	/*send the request and get the valid stores according by the filtering.*/
		$.ajax({
			type : "post",
			async : false,
			url : ctx + "/order/getStoreList",
			dataType : "json",
			data : {
				"itemNo" :itemNo,
				"catlgId":catlgId,
				"supId" :supId,
				"regnNoList" : regnNoList
			},
			success : function(data) {
				$.each(data,function(index,item){
					if(checked){
						$("#storeDiv").append("<div id='store_"+item.storeNO+"'><label>"
						+"<input type='checkbox' class='check1' name='hypeMarketNos' onclick='checkChkAllBoxStat()' value="+item.storeNO+"></label>"
						+"<span>"+item.storeNO+"-"+item.storeName+"</span></div>");
					}else{
						$("#storeDiv").find("div[id=store_"+item.storeNO+"]").remove();
					}
				});
			}
		});
		/*disable the existed stores*/
		if(existedStores.length>0){
			disableExistedStore(existedStores);
		}
		checkChkAllBoxStat();
}

function disableExistedStore(existedStores){
	var stores=$("#storeDiv input[name='hypeMarketNos']");
	if(stores.length>0){
	$.each(stores,function(index,store){
		if(!(existedStores._indexOf(parseInt(store.value))<0)){
			$(store).attr("disabled","disabled");
		}
	});
	}
	else{
		return false;
	}
 }

function getAllCheckedStores(){
	var storeArr=[];
	var storeArrObj=$("#storeDiv input[name='hypeMarketNos']:checked");
	if(storeArrObj.length>0){
		$.each(storeArrObj,function(index,storeObj){
			storeArr.push(storeObj.value);
		});
	}
	return storeArr;
}
</script>
<div class="Panel_top">
	<span>选择需要订购商品的门店</span>
	<div class="PanelClose" onclick="closePopupWinTwo()"></div>
</div>
<div class="Table_Panel">
	<div class="" style="width: 615px; height: 285px; float: left;">
		<div class="CM_p CM">
			<div class="CM-bar" style="height: 280px;">
				<div>大卖场</div>
			</div>
			<div class="t2" id="hypeMarCity">
				<ul id="hypeMarketArea"></ul>
			</div>
			<div class="t3">
				<div class="b inputDiv" style="width: 180px;" id="storeDiv"></div>
				<div class="f" style="width: 180px;">
					<label> <input id="storeCheckAll" type="checkbox"
						name="hypeMarketNosAll" class="checkAll"
						onclick="hypeMarketCheckAll(this)" />
					</label><span>全选</span>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="Panel_footer" style="width: 610px;">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="addOrderItemStores(getAllCheckedStores())">确定</div>
		<div class="PanelBtn2" onclick="closePopupWinTwo()">取消</div>
	</div>
</div>