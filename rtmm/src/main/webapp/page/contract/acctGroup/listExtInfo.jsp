<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.contract_cm3 {
	width: 325px;
	height: 132px;
	margin-left: 25px;
}
.cm_table3 {
	height: 100px;
}
</style>
<div style="height: 160px;" class="CM">
	<div class="CM-bar">
		<div>选中项赞助科目</div>
	</div>
	<div class="CM-div">
		<div class="contract_cm3">
			<table cellpadding="0" cellspacing="0" class="align_center">
				<tbody>
					<tr>
						<td>
							<div style="width: 5px;"></div>
						</td>
						<td>
							<div style="width: 123px;">科目编号</div>
						</td>
						<td>
							<div style="width: 83px;">税率</div>
						</td>
						<td>
							<div style="width: 83px;">目标单位</div>
						</td>
					</tr>
				</tbody>
			</table>

			<div class="cm_table3" id="acclist">
				<c:forEach items="${acctList}" var="acc">
					<div class="item">
						<input type="text" class="inputText fl_left" style="width: 120px; margin-left: 5px;" value="${acc.conbnAcctNo}" readonly="readonly">
						<input type="text" class="inputText fl_left" style="width: 70px;"
							value="${acc.vatNo}-<fmt:formatNumber value="${acc.vatVal}" pattern="#.##" minFractionDigits="2"/>%" readonly="readonly">
					<!-- 	<input type="text" class="inputText fl_left" style="width: 80px;"> -->
						<c:choose>
							<c:when test="${acc.condValType=='A'}">
								<input type="text" value="A-金额" class="inputText align_left" readonly="readonly" style="width: 95px;"/>
							</c:when>
							<c:when test="${grpAccount.condValType=='P'}">
								<input type="text" value="P-百分比" class="inputText align_left" readonly="readonly" style="width: 95px;"/>
							</c:when>
							<c:otherwise>
								<input type="text" value="A,P-金额和百分比" class="inputText align_left" readonly="readonly" style="width: 95px;"/>
							</c:otherwise>
						</c:choose>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>


