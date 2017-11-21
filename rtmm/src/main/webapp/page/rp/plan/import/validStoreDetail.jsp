<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
#ordMultiParm, #buyPrice{
	text-align: right;
	overflow: visible;
	padding-right: 2px;
}
</style>
<form id="validForm">
	<div style="height: 330px; padding-top: 8px;">
		<div class="htable_div">
			<table>
				<thead>
					<tr>
						<td>
							<div class="t_cols align_center" style="width: 30px;">&nbsp;</div>
						</td>
						<td>
							<div class="t_cols" style="width: 70px;">货号</div>
						</td>
						<td>
							<div class="t_cols" style="width: 180px;">品名</div>
						</td>
						<td>
							<div class="t_cols" style="width: 100px;">*买价(元)</div>
						</td>
						<td>
							<div class="t_cols" style="width: 70px;">厂编</div>
						</td>
						<td>
							<div class="t_cols" style="width: 180px;">公司名称</div>
						</td>
						<td>
							<div class="t_cols" style="width: 70px;">订购倍数</div>
						</td>
						<td>
							<div class="t_cols" style="width: 100px;">商品总建议量</div>
						</td>
						<td>
							<div class="t_cols" style="width: 100px;">商品总金额(元)</div>
						</td>
						<td>
							<div class="t_cols" style="width: 70px;">分店详情</div>
						</td>
						<td>
							<div style="width: 16px;">&nbsp;</div>
						</td>
					</tr>
				</thead>
			</table>
		</div>
		<div class="btable_div" style="height: 270px;">
			<table class="single_tb w100">
				<!--multi_tb为多选 width:1001px;-->
				<tbody>
					<c:if test="${not empty page.result}">
						<c:forEach items="${page.result}" var="rpItem" varStatus="rpindex">
							<tr id="${rpItem.itemNo}" ondblclick="showStoreDetail('${processId}','${rpItem.itemNo }')">
								<input type="hidden" name="itemNo" value="${rpItem.itemNo}" />
								<input type="hidden" name="initTotQty" value="${rpItem.initTotQty}" onchange="updateDisplayQty('${rpItem.itemNo }', this)"/>
								<input type="hidden" name="initTotAmnt" value="${rpItem.initTotAmnt}" onchange="updateDisplayAmnt('${rpItem.itemNo }', this)" />
								<input type="hidden" id ="normBuyPrice" value="${rpItem.normBuyPrice}" />
								<input type="hidden" id ="itemType" value="${rpItem.itemType}" />
								<td class="align_center" style="width: 30px;">&nbsp;</td>
								<td class="align_right" style="width: 66px; padding-right:5px;">${rpItem.itemNo}</td>
								<td style="width: 181px;" title="${rpItem.itemName}">${rpItem.itemName}</td>
								<td class="align_center" style="width: 101px;" >
									<input type="text" id="buyPrice" name="buyPrice" class="inputText w80 align_right" value="<fmt:formatNumber value="${rpItem.buyPrice}" pattern="#.####" minFractionDigits="4" />" onfocus="removeError(this);" onblur="checkBuyPrice('${rpItem.itemNo }', this)"></input>
								</td>
								<td class="align_right" style="width: 66px; padding-right:5px;">${rpItem.dcSupNo}</td>
								<td style="width: 181px;" title="${rpItem.dcSupName}">${rpItem.dcSupName}</td>
								<td class="align_center" style="width: 71px;">
									<input type="text" id="ordMultiParm"  name="ordMultiParm" class="inputText w80 align_right count_text" value="${rpItem.ordMultiParm}" maxlength="6" onfocus="this.oldvalue = this.value; removeError(this);" onchange="updateMultiParm('${processId }', '${rpItem.itemNo }', this)">
								</td>
								<td class="align_right" style="width: 101px;" id="initTotQty" >${rpItem.initTotQty}</td>
								<td class="align_right" style="width: 101px;" id="initTotAmnt"><fmt:formatNumber value="${rpItem.initTotAmnt}" pattern="#.##" minFractionDigits="2" /></td>
								<td style="width: 71px; padding-left: 25px;">
									<div class="ListWin" style="width: 23px; margin-top: 6px;"
										onclick="showStoreDetail('${processId}','${rpItem.itemNo }')"></div>
								</td>
								<td style="width: auto">&nbsp;</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="paging" id="currentValidRpItem"></div>
		<input type="hidden" name="pageSize" value="${page.pageSize}" />
		<input type="hidden" name="pageNo" value="${page.pageNo}" />
		<input type="hidden" name="processId" id="processId" value="${processId }" />
		<%@ include file="/page/commons/paginator.jsp"%>
	</div>
</form>
<script type="text/javascript">
	var p = new Paginator({
		totalItems : '${page.totalCount}',
		itemsPerPage : '${page.pageSize}',
		page : '${page.pageNo}',
		paginatorElem : 'currentValidRpItem',
		psConfigurable : [ 100, 200, 300 ],
		callback : function(pageNo, pageSize) {
			$("#validForm input[name=pageSize]").val(pageSize);
			$("#validForm input[name=pageNo]").val(pageNo);
			validRpQuery();
		}
	});
	$(window).unload(function() {
		//0.清理资源;
		p.destroy();
	});

	$(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});

		document.onkeydown = function(e) {
			enterShow(e);
		};
		
		if ('${page.totalCount}' != null){
			$("#validBasicInfo").find("#successCount").val('${page.totalCount}');
		}	
		
		// 綁定 input.count_text 只能輸入整數值
		inputToInputIntNumber();
	});
</script>

