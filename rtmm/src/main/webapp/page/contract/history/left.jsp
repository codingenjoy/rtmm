<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="SearchTop">
	<span>查询条件</span>
	<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
</div>
<div class="line"></div>
<form id="searchForm" name="searchForm" action="/supplier/contract/history/searchList" onsubmit="historyContractPageQuery();return false;">
	<div class="SMiddle">
		<table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
			<tbody>
				<tr>
					<td class="ST_td1">
						<span>合同编号</span>
					</td>
					<td>
						<input class="w85 inputText count_text" id="cntrtId" type="text" name="cntrtId" maxlength="15"/>
					</td>
				</tr>
				<tr>
					<td>
						<span>年份</span>
					</td>
					<td>
						<select name="year" class="w85" id="year">
							<option value="">请选择</option>
							<c:forEach items="${yearList}" var="year">
								<option value="${year}">${year}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<span>厂编</span>
					</td>
					<td>
						<div class="iconPut w85 fl_left">
							<input type="text" class="w85 count_text" id="supNo" name="supNo" maxlength="8">
							<div class="ListWin" onclick="chooseOfSupplier()"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input class="w85 inputText Black" type="text" id="supName" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>
						<span>税率</span>
					</td>
					<td> 
						<auchan:select4Vat _class="w85" name="supVatNo" id="supVatNo" /> 
					</td>
				</tr>
				<tr>
					<td>
						<span>支付方式</span>
					</td>
					<td>
						<auchan:select mdgroup="CONTRACT_DETL_PAY_METHD" _class="select1 w85" name="payMethd"/>
					</td>
				</tr>
				<tr>
					<td>
						<span>赞助科目</span>
					</td>
					<td>
						<div class="iconPut w85 fl_left">
							<input type="hidden" class="w82" name="grpAcctIds" id="grpAcctIds">
							<input type="text" class="w82" name="grpAcctAbbrs" id="grpAcctAbbrs" readonly="readonly">
							<div class="ListWin" onclick="openAcctGroupWin(this)"></div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="line"></div>
	<div class="SearchFooter">
		<div class="Icon-size1 Tools20" onclick="reset();"></div>
		<div class="Icon-size1 Tools6" onclick="historyContractPageQuery(1,20);"></div>
	</div>
</form>