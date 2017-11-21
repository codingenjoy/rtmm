<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(function(){
	setToolsbarAllDisable();
	$("#Tools6").removeClass("Tools6_disable").addClass("Tools6").bind("click",function(){
		pageQuery();
	});
	
	//传递参数 
	var param = {
		'itemNo' : '${sessionScope.itemNoSearch}',
		'storeNo' : '${sessionScope.storeNoSearch}'
	};
	//商品总览(tab)
	$('#ovreviewTab').unbind("click")
			.bind(
					'click',
					function() {
						var itemNo = '${sessionScope.itemNoSearch}';
						if (itemNo) {
							searchItemByItemNo(
									'${sessionScope.itemNoSearch}',
									'${sessionScope.storeNoSearch}','');
						} else {
							$('#ovreviewContent').load(ctx + '/item/query/itemBaseInfo',function(){
								$('#ovreviewList').hide();
								$('#ovreviewContent').show();
								$("#barcode").attr("readonly",false);
								$("#itemNo").attr("readonly",false);
							});
						}
					});
	//变价信息(tab)
	$('#priceChangeTab').unbind("click").bind(
			'click',
			function() {
				$('#ovreviewContent').load(ctx + '/item/query/itemPriceChangeInfo', param);
			});
	//规格信息(tab)
	$('#specInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemSpecInfo', param);
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
		$('#ovreviewContent').load(ctx + '/item/query/itemSupInfo', param);
	});
	//商品陈列(tab)
	$('#saleCtrlInfoTab').unbind("click").bind(
			'click',
			function() {
				$('#ovreviewContent').load(
						ctx + '/item/query/itemRealStoreSaleCtrlInfo',
						param);
			});
	//DC信息(tab)
	$('#dcInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemDCInfo', param);
	});
	//商品产地(tab)
	$('#originInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemOriginInfo', param);
	});
	//商品供应区域(tab)
	$('#supAreaInfoTab').unbind("click").bind('click', function() {
		$('#ovreviewContent').load(ctx + '/item/query/itemSupplierAreaInfo', param);
	});
	
	//添加键盘enter功能
	$("#itemNo").keydown(function(e){
		if(e.keyCode == 13){
			pageQuery();
		}
	});
	
	//消除
	$('#Tools20').unbind().bind('click',function(){
		$('input').val('');
		$(".itemOrder .tkbody").remove();
		$('#itemNo').removeAttr('readonly');
		$("#Tools6").removeClass("Tools6_disable").addClass("Tools6");
		$("#Tools20").removeClass("Tools20").addClass("Tools20_disable");
	});
});
function pageQuery(){
	var itemNo = $("#itemNo").val();
	if(itemNo == ""){
		return;
	}
	$.ajax({
		type : "post",
		url : ctx + "/item/query/itemOrderQuery",
		data : {itemNo : itemNo},
		success : function(data){
			if(typeof(data.message) == "undefined"){
				$('#ovreviewContent').html(data);
				$("#itemNo").attr("readonly","readonly");
				$("#Tools6").removeClass("Tools6").addClass("Tools6_disable");
				$("#Tools20").removeClass("Tools20_disable").addClass("Tools20");
			}else{
				jSuccessAlert(data.message);
			}
		}
	});
}
/**
 * 验证只能输入数字
 * 
 * @param obj
 */
function inputNumbers(obj) {
	if ($(obj).val() != '' && !(/^\d{0,10}$/).test($(obj).val())) {
		if ($(obj).val() == ' ') {
			$(obj).val('');
			return false;
		}
		if ($(obj).val() != '') {
			$(obj).val($(obj).attr('preval'));
		}
		return true;
	}
	$(obj).attr('preval', $(obj).val());
	if ($(obj).val() != '') {
		$(obj).removeClass('errorInput');
	}
}
</script>
<div class="CTitle">
	<!--第一个-->
	<div class="tags1_left"></div>
	<div id="ovreviewTab" class="tagsM">商品总览</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="priceChangeTab" class="tagsM">商品变价</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="specInfoTab" class="tagsM">商品规格</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="barcodeInfoTab" class="tagsM">商品条码</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="realativeInfoTab" class="tagsM">商品关联</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="supInfoTab" class="tagsM">商品厂商</div>
	<div class="tags"></div>
	<!--中间-->
	<div id="saleCtrlInfoTab" class="tagsM">商品陈列</div>
	<div class="tags"></div>
	<!--最后一个-->
	<div id="dcInfoTab" class="tagsM">DC信息</div>
	<div class="tags tags3"></div>
	<!--一定不要忘了tag3-->
	<div class="tagsM " id="originInfoTab">商品产地</div>
	<div class="tags"></div>
	<!--  -->
	<div class="tagsM" id="supAreaInfoTab">商品供应区域</div>
	<div class="tags tags_right_on"></div>
	<!--add-->
	<div class="tagsM_q  tagsM_on">商品订单查询</div>
	<div class="tags tags3_r_on"></div>
	<!--<div class="tags3_close_on">
                                <div class="tags_close"></div>
                            </div>-->
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo"></div>
		<div class="CM" style="height: 90px;">
			<div class="inner_half">
				<div class="CM-bar">
					<div>商品信息</div>
				</div>
				<div class="CM-div">
					<div class="ig_top20">
						<div class="icol_text w14">
							<span>货号</span>
						</div>
						<div class="iconPut w17 fl_left">
							<input class="w75" type="text" id="itemNo" value="${itemBasicVO.itemNo}" onkeyup="inputNumbers(this)"/>
							<div class="ListWin"></div>
						</div>
						<input type="text" class="inputText w50 fl_left Black" value="${itemBasicVO.itemName}"  readonly="readonly"/>
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>销售单位</span>
						</div>
						1&nbsp; <input type="text" class="inputText w10 Black" value="<auchan:getDictValue code="${itemBasicVO.sellUnit}" mdgroup="UNIT" showType="2"></auchan:getDictValue>" readonly="readonly"/>
					</div>
				</div>
			</div>
			<div class="inner_half">
				<div class="CM-div">
					<div class="ig_top20">
						<div class="icol_text w14">
							<span>状态</span>
						</div>
						<input type="text" class="inputText w20 fl_left Black" value="<auchan:getDictValue mdgroup="CONTRACT_TMPL_IN_USE_IND" code="${itemBasicVO.status}"></auchan:getDictValue>" readonly="readonly"/>
					</div>
					<div class="ig">
						<div class="icol_text w14">
							<span>订货方式</span>
						</div>
						<input type="text" class="inputText w50 fl_left Black" value="" readonly="readonly"/>
					</div>
				</div>
			</div>
		</div>

		<div class="itemOrder jbtk" style="margin-top: 2px;">
			<div class="CM" style="height: 100%">
				<div class="CM-bar">
					<div>订单信息</div>
				</div>
				<div class="CM-div">
					<table class="tkhead">
						<tr>
							<td style="width: 100px;">店号</td>  
							<td style="width: 95px;">订单号码</td> 
							<td style="width: 85px;">促销</td>   
							<td style="width: 85px;">类别</td> 
							<td style="width: 85px;">状态</td>
							<td style="width: 85px;">收货日期</td>  
							<td style="width: 95px;">收货号码</td>
							<td style="width: 80px;">订购数量</td> 
							<td style="width: 80px;">收货数量</td> 
							<td style="width: 80px;">买价</td>    
							<td style="width: 85px;">厂编</td>
						</tr>
					</table>
					<div class="tkbody">
					<c:forEach items="${orderList}" var="order">
						<div class="ig">
							<input type="text" class="inputText fl_left" style="width: 95px;" value="${order.storeNo}" readonly="readonly"/>
							<input type="text" class="inputText fl_left" style="width: 90px;" value="${order.ordNo}" readonly="readonly"/>
							<input type="text" class="inputText fl_left" style="width: 80px;" value="${order.promNo}" readonly="readonly"/>
							<input type="text" class="inputText fl_left" style="width: 80px;" value="<auchan:getDictValue mdgroup="ORDERS_ORD_TYPE" code="${order.ordType}"></auchan:getDictValue>" readonly="readonly"/>
							<input type="text" class="inputText fl_left" style="width: 80px;" value="<auchan:getDictValue mdgroup="ORDERS_ORD_STTUS" code="${order.ordSttus}"></auchan:getDictValue>" readonly="readonly"/>
							<input type="text" class="inputText fl_left" style="width: 80px;" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${order.realRecptDate}"/>" readonly="readonly"/>
							<input type="text" class="inputText fl_left" style="width: 90px;" value="${order.recptNo}" readonly="readonly"/>
							<input type="text" class="inputText fl_left" style="width: 75px;" value="${order.ordQty}" readonly="readonly"/>
							<input type="text" class="inputText fl_left" style="width: 75px;" value="${order.recptQty}" readonly="readonly"/>
							<input type="text" class="inputText fl_left" style="width: 75px;" value="${order.buyPrice}" readonly="readonly"/>
							<input type="text" class="inputText fl_left" style="width: 80px;" value="${order.supNo}" readonly="readonly"/>
						</div>
					</c:forEach>	
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
