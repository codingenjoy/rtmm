<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemUpdate.js" type="text/javascript"></script>
<link href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css" type="text/css" rel="stylesheet" />
<style type="text/css">
.sp_icon1 {
	margin-left: 15px;
}

.list_ex12{
	width: 87%;
}

.list_ex {
	height: 260px;
	margin-left: 20px;
}
.list_ex21{
	margin-left: 5px;
}
.list_ex2{
	overflow: auto;
}

#oneStore {
	padding-right: 20px;
	float: left;
	min-width: 100px;
	line-height: 20px;
}

#storeInfoList{
	background-color: #f9f9f9;
}
</style>
<script type="text/javascript">
	
	var currtOpenObj = 0;
	$(function() {

		//成本始點!=2時, 買價限制不能輸入
		if ('${buyWhen}' != 2){
			$("#buyPriceLimit").attr("readonly", "readonly");
			$("#buyPriceLimit").addClass("Black");
		}
		
		$('#Tools20').unbind("click").removeClass("Tools20").addClass("Tools20_disable");
		$('#Tools11').unbind("click").removeClass("Tools11").addClass("Tools11_disable");
	});

	// Display or hide the group 
	$(".ssuo").die().live("click", function() {
		if (chkItemInfo()) {
			var on = $(this).parent().parent().hasClass('list_ex0_on');
			if (on) {
				
				if ($('#storeListDiv').find('.list_ex0_on').length != 1){
					$('#storeListDiv').children().removeClass('list_ex0_on');
					$('#storeInfoList > div').hide();
				}
			} else {

				$('#storeListDiv').children().removeClass('list_ex0_on');
				$('#storeInfoList > div').hide();

				var mm = '#' + $(this).parent().parent().attr('id');
				$('#storeInfoList').find(mm).toggle();
				$(this).parent().parent().toggleClass("list_ex0_on");
			}
		}
	});
	
	// Display a remove icon while approaching a store in a group
	$('#oneStore').die().live({
		mouseenter : function() {
			$(this).append("<div class=\"store_close\" style=\"float:right;\" onclick=\"removeThisStore($(this))\"></div>");
		},
		mouseleave : function() {
			$(this).find('div').remove();
		}
	}); 
	
	// Perform removing a store
	function removeThisStore(obj) {
		if ($(obj).parent().siblings().length != 0){
			var groupStores = '';
			var store ='';
			var groupStoreArray = [];
			var totalStores = '';
			
			// 將這間店從左邊的 group store list 裡刪除
			groupStores = $(obj).parent().parent().siblings('input').val();
			storeName = $(obj).parent().text();
			store =	storeName.substr(0,storeName.indexOf('-'));
			groupStoreArray = groupStores.split(',');
			groupStoreArray.splice($.inArray(store.toString(), groupStoreArray), 1);
			$(obj).parent().parent().siblings('input').val(groupStoreArray.toString());
			
			// 同步更新右邊的 group store list
			$('.storeInfo:visible').find('.supStoreNoList').val(groupStoreArray.toString());
			
			// 將這間店從全部選取過的 store list 裡刪除
			totalStores = $('#checkedStores').val().split(',');
			totalStores.splice($.inArray(store.toString(), totalStores),1);
			$('#checkedStores').val(totalStores.toString());
			
			// 刪掉這個 store
			$(obj).parent().remove();
		}else{
			removeThisGroup($(obj).parents('.list_ex2').siblings('.list_ex1').children('.Tools10'));
		}
		
	}

	// 刪除群組按鈕
	$(".list_ex14").die().live("click",function() {
		removeThisGroup($(this));
	});
	
	// 刪除下傳區域
	function removeThisGroup(obj){
		// 先刪掉右邊的
		var mm = '#' + $(obj).parent().parent().attr('id');
		$('#storeInfoList').find(mm).remove();

		// 要刪掉裡面勾選的店號, 先拿到這個群組的 storeNos
		var removeList = ($(obj).parent().parent().find('input').val()).split(',');
		var checkedStores = ($('#checkedStores').val()).split(',');
		$.each(removeList, function(index, value) {
			if ($.inArray($.trim(value).toString(), checkedStores) != -1){
				checkedStores.splice($.inArray($.trim(value).toString(),checkedStores), 1);
			}
		});
		$('#checkedStores').val(checkedStores.toString());
		$(obj).parent().parent().remove();
	}

	// Save changes button
	$('#Tools2').attr('class', 'Tools2').unbind('click').bind('click', function() {
		if ($('.list_ex0').length < 1) {
			top.jAlert("warning", "请新增厂商与下传区域", "消息提示");
			return false;
		}
		else {
			if (chkItemInfo()){
				saveNewSupArea();
			}
		}
	});
	
	var param = {
			'itemNo' : '${sessionScope.itemNoSearch}',
			'itemName' : '${sessionScope.itemNameSearch}',
			'storeNo' : '${sessionScope.storeNoSearch}',
			'storeName' : '${sessionScope.storeNameSearch}'
	};
	
	//商品总览(tab)
	$('#ovreviewTab').unbind("click").bind( 'click', function() {
		var itemNo = '${sessionScope.itemNoSearch}';
		if(itemNo != null && itemNo != ""){
			searchItemByItemNo('${sessionScope.itemNoSearch}','${sessionScope.storeNoSearch}');
			
		}else{
			$('#ovreviewContent').load(ctx + '/item/query/generalSearch', param);
		}
	});
	//变价信息(tab)
	$('#priceChangeTab').unbind("click").bind( 'click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemPriceChangeInfo', param);
	});
	//规格信息(tab)
	$('#specInfoTab').unbind("click").bind('click', function() {
		$('.Container').load(ctx + '/item/query/itemSpecInfo', param);
	});
	//商品条码(tab)
 		$('#barcodeInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemBarcodeInfo', param);
	}); 
	//商品关联(tab)
	$('#realativeInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemRealativeInfo', param);
	});
	//商品厂商(tab)
	$('#supInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemSupInfo',param);
	});
	//商品陈列(tab)
	$('#saleCtrlInfoTab').unbind("click").bind( 'click', function() {
		$('#ovreviewContent').load(ctx+ '/item/query/itemRealStoreSaleCtrlInfo',param);
    });
	//DC信息(tab)
	$('#dcInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemDCInfo', param);
	});
	
	// Close tag 
	$('.tags_close').unbind("click").bind("click", function(){
		var itemNo = '${sessionScope.itemNoSearch}';
		if(itemNo != null && itemNo != ""){
			searchItemByItemNo('${sessionScope.itemNoSearch}','${sessionScope.storeNoSearch}');
			
		}else{
			$('#ovreviewContent').load(ctx + '/item/query/generalSearch', param);
		}
	});

</script>

<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div class="tagsM" id="ovreviewTab">商品总览</div>
	<div class="tags"></div>
	<div class="tagsM" id="priceChangeTab">商品变价</div>
	<div class="tags"></div>
	<div class="tagsM" id="specInfoTab">商品规格</div>
	<div class="tags"></div>
	<div class="tagsM" id="barcodeInfoTab">商品条码</div>
	<div class="tags"></div>
	<div class="tagsM" id="realativeInfoTab">商品关联</div>
	<div class="tags"></div>
	<div class="tagsM" id="supInfoTab">商品厂商</div>
	<div class="tags "></div>
	<div class="tagsM" id="saleCtrlInfoTab">商品陈列</div>
	<div class="tags "></div>
	<div class="tagsM" id="dcInfoTab">DC信息</div>
	<div class="tags tags_right_on"></div>
	<div class="tagsM tagsM_on" id="updateSupAreaTab">新增商品下传区域</div>
	<div class="tags3_close_on">
	<div class="tags_close"></div>
	</div>
</div>
<div class="CInfo"></div>
<form action="/item/create/doCreateItemStoreInfoAudit" onsubmit="return false;" id="item_create_5"></form>
<div style="height: 60px;" class="CM">
	<div class="CM-bar">
		<div>货号</div>
	</div>
	<div class="CM-div">
		<div class="hh_item">
			<div class="icol_text w7">
				<span>货号</span>
			</div>
			<div class="iconPut iq Black" style="width: 13%;">
				<input style="width: 83%" type="text" id="itemNo" name="itemNo" value="${itemNo }" class="itemNo Black" readonly="readonly" />
				<div class="ListWin"></div>
			</div>
			<input class="inputText iq Black itemName" style="width: 20%;" type="text" name="itemName" value="${itemName }" readonly="readonly" />
			<input id="catlgId" type="hidden" type="text" name="catlgId" value="${catlgId }"/> 
		</div>
	</div>
</div>
<div style="height: 322px;">
	<div class="tb50">
		<div style="height: 320px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>主厂商及下传区域</div>
			</div>
			<div class="CM-div list_ex" id="storeListDiv"></div>
			<div style="height: 30px; width: 85%; margin: 0 auto;">
				<div id="add_area" class="Icon-size2 Tools11 fl_left" onclick="openNewPopupSupAreaWin(650,650);"></div>
				<span class="fl_left" style="line-height: 20px;">&nbsp;&nbsp;新增厂商与下传区域</span>
			</div>
			<input id="checkedStores" type="hidden">
		</div>
	</div>
	<div class="tb50" id="storeInfoList">
		<div id="template" style="display:none;">
			<form class="itemStoreInfo">
				<div class="storeInfo">
					<div class="ztjg_info CM">
						<input type="hidden" class="supStoreNoList" name="supStoreNoList">
						<input type="hidden" class="stMainSupNo" name="stMainSupNo">
						<input type="hidden" class="grpId" name="grpId">
						<div class="CM-bar">
							<div>状态及价格信息</div>
						</div>
						<div class="CM-div">
							<div class="ig" style="margin-top: 15px;">
								<div class="msg_txt">BNO属性</div>
								<select class="w15 bnoName" name="mops" disabled="disabled">
									<option value="">请选择</option>
									<option value="B">B-基本</option>
									<option value="N">N-正常</option>
									<option value="O">O-专卖店</option>
								</select>
								<input id="bnoValue" name="mops" type="hidden"> 
								<span>&nbsp;&nbsp;&nbsp;新品试销&nbsp;&nbsp;</span>
								<input type="checkbox" class="newSell" name="trialSaleInd" onclick="selectTrialSale($(this))" />
								<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;特殊进价税率&nbsp;&nbsp;</span> <select
									class="w15 speclBuyVatNo" name="speclBuyVatNo">
									<option value="">请选择</option>
									<c:forEach items="${vatList}" var="obj">
										<option value="${obj.vatNo}">${obj.vatNo}-${obj.vatVal}%</option>
									</c:forEach>
								</select>
							</div>
							<div class="ig">
								<div class="msg_txt">*正常进价</div>
								<input type="text" class="w20 inputText mustInput" name="normBuyPrice" onblur="valFloatNumOnBlur(this,6,4)" />
								<span>&nbsp;元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*正常售价</span>
								<input type="text" class="w20 inputText mustInput" name="normSellPrice" onblur="valFloatNumOnBlur(this,6,2)" />
								<span>&nbsp;元</span>
							</div>
							<div class="ig">
								<div class="msg_txt">买价限制</div>
								<input type="text" id="buyPriceLimit" class="w20 inputText" name="buyPriceLimit" title="仅当成本时点为2时，店内采购时输入"
									onblur="valFloatNumOnBlur(this,6,4)" />
								<span>&nbsp;元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;最低售价</span>
								<input type="text" class="w20 inputText" name="minSellPrice" onblur="valFloatNumOnBlur(this,6,2)" />
								<span>&nbsp;元</span>
							</div>
							<div class="ig">
								<div class="msg_txt">*门店变价</div>
								<select class="w20 storeUpdtSpInd mustInput" name="storeUpdtSpInd">
									<option value="">请选择</option>
									<c:forEach items="${priceChList}" var="obj">
										<option value="${obj.code}">${obj.code}-${obj.title}</option>
									</c:forEach>
								</select> <span>&nbsp;元&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*DC属性&nbsp;</span> <select class="w20 mustInput dcAttr" name="dcAttr">
									<option value="">请选择</option>
									<c:forEach items="${dcAttrList}" var="obj">
										<option value="${obj.code}">${obj.code}-${obj.title}</option>
									</c:forEach>
								</select> <span>&nbsp;</span>
							</div>
						</div>
					</div>
					<div class="dhxx_info CM">
						<div class="CM-bar">
							<div>订货信息</div>
						</div>
						<div class="CM-div">
							<div class="ig dhxx_info_1" style="margin-top: 15px;">
								<div class="msg_txt">*订货方式</div>
								<input type="hidden" name="ordCreatMethd" class="ordCreatMethd">
								<c:forEach items="${itemStoreInfo}" var="obj">
									<input type="checkbox" value="${obj.code}" onclick="changeOrdCreatMethd($(this))" class="ordCreatMethds" />
									<span>${obj.title}</span>
								</c:forEach>
							</div>
							<div style="height: 120px;">
								<div class="dh_info1">
									<div class="ig">
										<input type="radio" class="order" checked="checked" style="margin-left: 12px;" />
										<span>订货周期</span>
										<input type="text" class="w30 inputText" name="oplCycle" onblur="valFloatNumOnBlur(this,2,0)" />
										<span>周</span>
									</div>
									<div style="height: 60px;">
										<div class="dh_radio1" style="margin-top: 25px;">
											<input type="radio" name="order" disabled="disabled" />
										</div>
										<div class="dh_radio2">
											<div class="ig">
												<span>&nbsp;&nbsp;&nbsp;订购点&nbsp;&nbsp;</span>
												<input type="text" class="w50 inputText Black" readonly="readonly" />
											</div>
											<div class="ig">
												<span>&nbsp;&nbsp;&nbsp;订购量&nbsp;&nbsp;</span>
												<input type="text" class="w50 inputText Black" readonly="readonly" />
											</div>
										</div>
									</div>
								</div>
								<div class="dh_info2">
									<div class="ig">
										<span>&nbsp;*可否退货&nbsp;</span> <select class="w50 mustInput rtnAllow" name="rtnAllow">
											<option value="">请选择</option>
											<c:forEach items="${rtnAllowList}" var="obj">
												<option value="${obj.code}">${obj.code}-${obj.title}</option>
											</c:forEach>
										</select>
									</div>
									<div class="ig">
										<span style="margin-left: 20px;">箱含量&nbsp;</span>
										<input type="text" class="w50 inputText" name="upb" onblur="valFloatNumOnBlur(this,4,0)" />
									</div>
								</div>
								<div class="dh_info3">
									<div class="ig">
										<span>&nbsp;*订购倍数&nbsp;</span>
										<input type="text" class="w35 inputText mustInput" name="ordMultiParm" onblur="valFloatNumOnBlur(this,4,0)" />
									</div>
									<div class="ig">
										<span style="margin-left:9px;">允收天数&nbsp;</span>
										<input type="text" class="w35 inputText" name="rcvShelfLifeDays" onblur="valFloatNumOnBlur(this,4,0)" />
										&nbsp;天
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<div id="popupItemWin" class="Panel" style="display: none"></div>

