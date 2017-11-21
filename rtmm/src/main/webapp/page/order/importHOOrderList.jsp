<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style>
.btable_div{
	/* overflow-x: hidden; */
}
.errorRecord td{
	color: lightgrey;
}
</style>
<div class="ig">
	<div class="icol_text">总条目数&nbsp;</div>
	<input type="text" class="inputText w5 fl_left" readonly="readonly" value="${totalRecords }" />
	<div class="icol_text">&nbsp;&nbsp;订购总数量&nbsp;</div>
	<input type="text" class="inputText w10 fl_left" readonly="readonly" id="totalQuantity" />
	<div class="icol_text">&nbsp;&nbsp;订购总金额&nbsp;</div>
	<input type="text" class="inputText w10 fl_left" readonly="readonly" id="totalAmount" />
	<div class="icol_text">&nbsp;元</div>
</div>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td>
					<div class="t_cols" style="width: 120px;">
						店号
						<!--<div style="display:inline-block;width:10px;height:20px;"></div>-->
					</div>
				</td>
				<td>
					<div class="t_cols" style="width: 60px;">厂编</div>
				</td>
				<td>
					<div class="t_cols" style="width: 160px;">公司名称</div>
				</td>
				<td>
					<div class="t_cols" style="width: 60px;">货号</div>
				</td>
				<td>
					<div class="t_cols" style="width: 155px;">品名</div>
				</td>
				<td>
					<div class="t_cols" style="width: 70px;">订购数量</div>
				</td>
				<td>
					<div class="t_cols" style="width: 50px;">赠品数量</div>
				</td>

				<td>
					<div class="t_cols" style="width: 75px;">导入进价(元)</div>
				</td>
				<td>
					<div class="t_cols" style="width: 75px;">实际进价(元)</div>
				</td>
				<td>
					<div class="t_cols" style="width: 85px;">促销期数</div>
				</td>
								<td>
					<div class="t_cols" style="width: 85px;">错误讯息</div>
				</td>
				<td>
					<div style="width: auto;">&nbsp;</div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 469px;">
	<form id="orderForm">
	<input id="memo" name="ordMemo" type="hidden" value="${memo }">
	<table class="single_tb w100" id="orders">
		<c:forEach items="${orderList}" var="order">
				<tr <c:if test="${order.orderBasic.errorFlag == '1' }">class="errorRecord" </c:if> >
				<!--multi_tb为多选 width:1001px;-->
					<td style="width: 121px;">
						<input name="storeNo" type="hidden" value="${order.orderBasic.storeNo}" />
						<input name="supNo" type="hidden" value="${order.orderBasic.supNo }" />
						<input name="comName" type="hidden" value="${order.orderDetailInfo.supComName }">
						<input name="itemNo" type="hidden" value="${order.orderBasic.itemNo}">
						<input name="catlgId" type="hidden" value="${order.orderDetailInfo.catlgId }">
						<input name="supComNo" type="hidden" value="${order.orderDetailInfo.supComNo }">
						<input name="supUnifmNo" type="hidden" value="${order.orderDetailInfo.supUnifmNo }">
						<input name="supType" type="hidden" value="${order.orderDetailInfo.supType }">
						<input name="planRecptDate" type="hidden" value="${order.orderBasic.planRecptDate }">
						<input name="bpDisc" type="hidden" value="${order.orderDetailInfo.bpDisc }">
						<input name="invDisc" type="hidden" value="${order.orderDetailInfo.invDisc }">
						<input name="discMemo" type="hidden" value="${order.orderDetailInfo.discMemo }">
						<input name="sectionNo" type="hidden" value="${order.orderBasic.sectionNo }">
						<input name="catlgName" type="hidden" value="${order.orderDetailInfo.catlgName }">
						<input name="memo" type="hidden" value="${order.orderBasic.memo }">
						<input name="chngPriceInd" type="hidden" value="${order.orderBasic.chngPriceInd }">
						<input name="promNo" type="hidden" value="${order.orderDetailInfo.promNo }">
						${order.orderBasic.storeNo }-${order.orderDetailInfo.storeName }</td>
					<td style="width: 61px;">${order.orderBasic.supNo }</td>
					<td style="width: 161px;" title="${order.orderDetailInfo.supComName }">${order.orderDetailInfo.supComName }</td>
					<td style="width: 61px;">${order.orderBasic.itemNo }</td>
					<td style="width: 156px;" title="${order.orderDetailInfo.itemName }">${order.orderDetailInfo.itemName }</td>
					<td style="width: 71px;">
						<input type="text" name="ordQty" class="inputText w90 align_right quantity" value="${order.orderBasic.ordQty }" 
							onchange="calculate('${order.orderDetailInfo.ordMultiParm}',this)" />
					</td>
					<td style="width: 51px;">
						<input type="text" name="presOrdQty" class="inputText w90 align_right" value="${order.orderBasic.presOrdQty }" onchange = "presCalculate('${order.orderDetailInfo.itemType }', this)"  />
					</td>
					<td style="width: 76px;" class="align_right">${order.orderBasic.buyPrice }</td>
					<td style="width: 76px;" class="align_right amount">
						<input type="text" name="buyPrice" class="inputText w85 align_right Black" readonly="readonly"  value="${order.orderBasic.realBuyPrice }"  />
					</td>
					<td style="width: 86px;" class="align_right">${order.orderDetailInfo.promNo }</td>
					<td style="width: 86px;color:red;" title="${order.orderBasic.errorNotice }" class="align_right">${order.orderBasic.errorNotice }</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
	
		</c:forEach>
	</table>
	</form>
</div>
<%-- 	<jsp:include page="/page/commons/pageSet.jsp"></jsp:include> --%>
<script src="${ctx}/shared/js/order/orderTemplateImport.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		
		if ('${success}' == 1) { 
			calculate();
		} 
	});

</script>
