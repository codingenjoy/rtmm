<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style>
#storeQty {
	text-align: right;
	overflow: visible;
	padding-right: 2px;
}
</style>

<div class="Panel" style="border: none;">
	<div class="Panel_top">
		<span>保留计划分店详情</span>
		<div class="PanelClose" onclick="closePopupWin()"></div>
	</div>
	<form id="lRpItemValidStore">
		<div class="Table_Panel">
			<div class="ig_top10">
				<div class="icol_text w10">
					<span>货号</span>
				</div>
				<input type="text" name="itemNo" class="inputText w15" readonly="readonly" value="${itemNo }" />
			</div>
			<div class="ig">
				<div class="icol_text w10">
					<span>品名</span>
				</div>
				<input type="text" id="itemName" class="inputText w40" readonly="readonly" value="${itemName }" />
			</div>
			<input type="hidden" name="processId" id="processId" value="${processId }" />
			<input type="hidden" name="totalOrdQty" id="totalOrdQty" />
			<input type="hidden" name="totalOrdAmnt" id="totalOrdAmnt" />
			<input type="hidden" name="buyPrice" id="buyPrice" />
			<div style="height: 265px;">
				<div class="htable_div">
					<table>
						<thead>
							<tr>
								<td>
									<div class="t_cols align_center" style="width: 30px;">&nbsp;</div>
								</td>
								<td>
									<div class="t_cols" style="width: 300px;">店号</div>
								</td>
								<td>
									<div class="t_cols" style="width: 200px;">数量</div>
								</td>
								<td>
									<div style="width: 16px;">&nbsp;</div>
								</td>
							</tr>
						</thead>
					</table>
				</div>
				<div class="btable_div" style="height: 230px;">
					<table class="single_tb w100">
						<!--multi_tb为多选 width:1001px;-->
						<tbody>
							<c:if test="${not empty result}">
								<c:forEach items="${result}" var="itemStore" varStatus="seq1">
									<tr>
										<input type="hidden" name="storeNo" value="${itemStore.storeNo }" />
										<td class="align_center" style="width: 30px;">&nbsp;</td>
										<td style="width: 301px;">${itemStore.storeNo}-${itemStore.storeName}</td>
										<td class="align_right" style="width: 201px;"><input type="text" id="storeQty" name="storeQty" class="inputText w40 align_right"
												onfocus="removeError(this)"
												onblur="checkStoreQty(this,'${ordMultiParm }')" value="${itemStore.storeQty }" maxlength="10" /></td>
										<td style="width: auto">&nbsp;</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</form>
	<div class="clearBoth"></div>
</div>
<div class="Panel_footer" style="height: 45px;">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="updateStoreDetail()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>
<div class="clearBoth"></div>

<script>
	// 綁定 input.count_text 只能輸入整數值
	inputToInputIntNumber();
</script>
