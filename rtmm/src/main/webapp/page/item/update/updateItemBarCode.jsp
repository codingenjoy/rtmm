<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.auchan.rtmm.common.session.SessionHelper"
	language="java"%>
<%@ page import="java.util.Date"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/item/itemSearch.js" type="text/javascript"></script>
<style type="text/css">
.CInfo .combo,.CInfo input {
	background-color: #cccccc;
}
.tagsM{
    min-width: 55px;
}
</style>
<script>
    /*disabled the all toolbar.*/
    setToolsbarAllDisable();
	var delBarcodeList = '';
	//商品总览(tab)
	$('#ovreviewTab').unbind("click").bind( 'click', function() {
		var itemNo = '${sessionScope.itemNoSearch}';
		if(itemNo != null && itemNo != ""){
			searchItemByItemNo('${sessionScope.itemNoSearch}');
		}else{
			$('.Container').load(ctx + '/item/query/generalSearch', getParam());
		}
	});
	//变价信息(tab)
	$('#priceChangeTab').unbind("click").bind( 'click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemPriceChangeInfo', getParam());
	});
	//商品条码(tab)
	$('#barcodeInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemBarcodeInfo', getParam());
	});
	//商品关联(tab)
	$('#realativeInfoTab').unbind("click").bind('click', function() {
		$('.Container').load(ctx + '/item/query/itemRealativeInfo', getParam());
	});
	//商品厂商(tab)
	$('#supInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemSupInfo', getParam());
	});
	//商品陈列(tab)
	$('#saleCtrlInfoTab').unbind("click").bind( 'click', function() {
		$('#ovreviewContent').load(ctx+ '/item/query/itemRealStoreSaleCtrlInfo',getParam());
    });
	//DC信息(tab)
	$('#dcInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemDCInfo', getParam());
	});
	//商品产地(tab)
	$('#originInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemOriginInfo', getParam());
	});
	//商品供应区域(tab)
	$('#supAreaInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemSupplierAreaInfo', getParam());
	});
	$("#itemBarCodeClose").unbind().bind('click',function(){
		closeUptItemInfo('itemBarcode',getParam());
	});
	$(".deleteChecked").live("click", function() {
		delBarcodeList = deleteBarcode(delBarcodeList);
	});
	$('#isCheckAll').live("click", function() {
		if ($('#isCheck:checked') != null) {
			$('#barcodeList > .ig').find('#isCheck').attr("checked", true);
		} else {
			$('#barcodeList > .ig').find('#isCheck').attr("checked", false);
		}
	});
	$('#Tools2').attr("class", "Tools2");
	$('#Tools2').unbind("click").bind("click", function() {
		saveBarcodeUpdate(delBarcodeList);
	});
	var date = new Date().format('yyyy-MM-dd');
	$('#template > #creatDate').val(date);
</script>
<div class="CTitle">
	<div class="tags1_left "></div>
	<div class="tagsM " id="ovreviewTab">商品总览</div>
	<div class="tags "></div>
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
    <div class="tags"></div>
	<div id="dcInfoTab" class="tagsM">DC信息</div>
	<div class="tags"></div>
	<div class="tagsM" id="originInfoTab">商品产地</div>
	<div class="tags "></div>
	<div class="tagsM " id="supAreaInfoTab">商品供应区域</div>
	<div class="tags tags3 tags_right_on"></div>
	<div class="tagsM_q  tagsM_on">修改商品条码信息</div>
	<div class="tags3_close_on">
		<div class="tags_close" id="itemBarCodeClose"></div>
	</div>
</div>

<div class="Container-1">
	<div class="Content">
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
						<input id="itemNo" style="width: 83%" type="text" class="Black"
							value='${itemNo }' readonly="readonly" />
						<div class="ListWin"></div>
					</div>
					<input id="itemName" class="inputText iq Black" readonly="readonly"
						value='${itemName }' style="width: 20%;" type="text" />
				</div>

			</div>
		</div>
		<div style="height: 470px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>商品条码信息</div>
			</div>
			<div class="CM-div">
				<div class="txm_info">
					<div class="txm_title">
						<span style="margin-left: 90px;">*条码</span> <span
							style="margin-left: 100px;">创建日期</span> <span
							style="margin-left: 65px;">建档人</span>
					</div>
					<div id="barcodeList" class="sp_tb">
						<c:forEach items="${barcodeList}" var="barCode">
							<div class="ig">
								<input class="isCheck" type="checkbox" /> <input id="barcode"
									type="text" class="w110 inputText Black"
									value="${barCode.barcode }" readonly="readonly" /> <input
									id="creatDate" type="text" class="inputText Black w20"
									value="<fmt:formatDate pattern="yyyy-MM-dd" value="${barCode.creatDate}"/>"
									readonly="readonly"/> <input id="creatBy"
									type="text" class="w25 inputText Black"
									value="${barCode.creatBy }" readonly="readonly" />
							</div>
						</c:forEach>
						<div class="ig" id="template" style="display: none;">
							<input type="checkbox" /> <input id="barcode" type="text"
								class="w110 inputText"
								onclick="removeElements(this)"
								onblur="checkValidBarcode(this)" /> <input id="creatDate"
								type="text" class="inputText Black w20" readonly="readonly"
								 /> <input id="creatBy" type="text"
								class="w25 inputText Black" readonly="readonly"
								value="<%=SessionHelper.getCurrentStaffNo()%>" />
						</div>
					</div>
					<div class="ig">
						<input type="checkbox" id="isCheckAll" class="sp_icon1 isCheckAll" />
						<div class="Icon-size2 Tools10 sp_icon2 deleteChecked"></div>
						<div class="Icon-size2 Line-1 sp_icon3"></div>
						<div class="Icon-size2 Tools11 sp_icon4" onclick="newBarcode()"></div>
					</div>
					<div class="msg" id="barcodeError"></div>
				</div>
			</div>
		</div>
	</div>
</div>