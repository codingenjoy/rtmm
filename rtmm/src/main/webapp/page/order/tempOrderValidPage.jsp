<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style>
.order_item {
	display: inline-block;
	float: left;
	padding: 3px 20px;
	margin-left: 5px;
	margin-top: 1px;
	cursor: pointer;
}

.btable_checked .Icon-size1 {
	display: block;
	background: url(../images/choosed.png) 0 0 no-repeat;
	margin-left: 4px;
}

.right_import .choosed {
	display: block;
	float: left;
	width: 17px;
	height: 17px;
	background: url(../images/choosed.png) -20px 0 no-repeat;
	margin-left: 4px;
	margin-top: 3px;
}

#orders .ordQty,#orders .presOrdQty {
	text-align: right;
	overflow: visible;
	padding-right: 2px;
}
</style>
<div class="ig_top10 right_import">
	<div class="icol_text">正确条目数&nbsp;</div>
	<input type="hidden" id="excelLines" value="${totalCount }">
	<input type="text" class="inputText w5 fl_left" id="successCount" value="${page.totalCount }" readonly="readonly" />
	<div class="icol_text">&nbsp;&nbsp;订购总数量&nbsp;</div>
	<input id="totalQuantity" type="text" class="inputText w10 fl_left" value="<fmt:formatNumber value="${validInfo.totalOrdQty }" pattern="#" />"
		readonly="readonly" />
	<div class="icol_text">&nbsp;&nbsp;订购总金额&nbsp;</div>
	<input id="totalAmount" type="text" class="inputText w10 fl_left"
		value="<fmt:formatNumber value="${validInfo.totalAmount }" pattern="#.##" minFractionDigits="2"/>" readonly="readonly" />
	<div class="icol_text">&nbsp;元</div>
</div>

<div class="htable_div right_import">
	<table>
		<thead>
			<tr>
				<!--<td><div class="t_cols align_center" style="width:30px;"><input type="checkbox" /></div></td>-->
				<td>
					<div class="t_cols" style="width: 95px;">
						店号
						<!--<div style="display:inline-block;width:10px;height:20px;"></div>-->
					</div>
				</td>
				<td>
					<div class="t_cols" style="width: 65px;">厂编</div>
				</td>
				<td>
					<div class="t_cols" style="width: 140px;">公司名称</div>
				</td>
				<td>
					<div class="t_cols" style="width: 65px;">货号</div>
				</td>
				<td>
					<div class="t_cols" style="width: 145px;">品名</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">订购数量</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">赠品数量</div>
				</td>
				<td>
					<div class="t_cols" style="width: 75px;">预定收货日</div>
				</td>
				<td>
					<div class="t_cols" style="width: 85px;">导入进价(元)</div>
				</td>
				<td>
					<div class="t_cols" style="width: 85px;">实际进价(元)</div>
				</td>
				<td>
					<div class="t_cols" style="width: 85px;">促销期数</div>
				</td>
				<td>
					<div style="width: 16px;">&nbsp;</div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<form id="orderForm">
	<div class="btable_div right_import" style="height: 439px;">
		<table class="single_tb w100" id="orders">
			<c:forEach items="${page.result}" var="record">
				<tr>
					<!--multi_tb为多选 width:1001px;-->
					<td style="width: 96px;" title="${record.storeNo }-${record.storeName }">
						<input name="id" type="hidden" value="${record.id}" />
						<input id="orgOrdQty" type="hidden" value="<fmt:formatNumber value="${record.ordQty}" pattern="#.###" minFractionDigits="3"/>" />
						<input id="orgPresOrdQty" type="hidden" value="<fmt:formatNumber value="${record.presOrdQty}" pattern="#.###" minFractionDigits="3"/>" />
						${record.storeNo }-${record.storeName }
					</td>
					<td style="width: 66px;" class="align_right">
						<span style="margin-right: 5px;">${record.supNo}</span>
					</td>
					<td style="width: 141px;" title="${record.supName }">${record.supName }</td>
					<td style="width: 66px;" class="align_right">
						<span style="margin-right: 5px;">${record.itemNo}</span>
					</td>
					<td style="width: 146px;" title="${record.itemName }">${record.itemName }</td>
					<td style="width: 81px;">
						<input type="text" name="ordQty" class="inputText w90 quantity ordQty"
							value="<fmt:formatNumber value="${record.ordQty}" pattern="#.###" minFractionDigits="3"/>"
							onchange="calculate('${record.orderMultiParm}',${record.buyPrice },this)" />
					</td>
					<td style="width: 81px;">
						<input type="text" name="presOrdQty" class="inputText w90 presOrdQty"
							value="<fmt:formatNumber value="${record.presOrdQty }" pattern="#.###" minFractionDigits="3"/>"
							onchange="presCalculate('${record.itemType}', this)" />
					</td>
					<td style="width: 76px;" class="align_right">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${record.planRecptDate}" />
					</td>
					<td style="width: 86px;" class="align_right">
						<fmt:formatNumber value="${record.importBuyPrice}" pattern="#.####" minFractionDigits="4" />
					</td>
					<td style="width: 86px;" class="align_right amount">
						<input type="text" name="buyPrice" class="inputText w85 align_right Black" readonly="readonly"
							value="<fmt:formatNumber value="${record.buyPrice}" pattern="#.####" minFractionDigits="4"/>" />
					</td>
					<td style="width: 86px;" class="align_right">
						<span style="margin-right: 5px;">${record.promNo }</span>
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>

			</c:forEach>
		</table>
	</div>
	<div class="paging" id="validOrder"></div>
	<input type="hidden" name="pageSize" value="${page.pageSize}" />
	<input type="hidden" name="pageNo" value="${page.pageNo}" />
	<input type="hidden" name="processId" id="processId" value="${processId }" />
	<%@ include file="/page/commons/paginator.jsp"%>
</form>

<script type="text/javascript">
	var p = new Paginator({
		totalItems : '${page.totalCount}',
		itemsPerPage : '${page.pageSize}',
		page : '${page.pageNo}',
		paginatorElem : 'validOrder',
		psConfigurable : [ 100, 200, 300 ],
		callback : function(pageNo, pageSize) {
			$("#orderForm input[name=pageNo]").val(pageNo);
			$("#orderForm input[name=pageSize]").val(pageSize);
			pageQuery();
		}
	});
	$(window).unload(function() {
		//0.清理资源;
		p.destroy();
	});
	
</script>
