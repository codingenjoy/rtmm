<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="SearchTop">
	<span>查询条件</span>
	<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
</div>
<div class="line"></div>
<form id="searchForm" class="clean_from" name="searchForm" action="/supplier/contract/current/search" onsubmit="searchFormSubmit();return false;">
	<div class="SMiddle">
		<table class="SearchTable">
			<tbody>
				<tr>
					<td class="ST_td1">
						<span>合同编号</span>
					</td>
					<td>
						<input class="w85 inputText count_text enterBind" type="text" name="cntrtId" maxlength="15">
					</td>
				</tr>
				<tr>
					<td>
						<span>厂编</span>
					</td>
					<td>
						<div class="iconPut w85 fl_left">
							<input type="text" class="w80 count_text supNo enterBind" id="supNo" name="supNo" maxlength="8" >
							<div class="ListWin" onclick="chooseOfSupplier()"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<span>&nbsp;</span>
					</td>
					<td>
						<input class="w85 inputText Black supName " type="text" id="supName" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>
						<span>税率</span>
					</td>
					<td>
						<auchan:select4Vat _class="w85 enterBind" name="supVatNo" id="supVatNo" />
					</td>
				</tr>
				<tr>
					<td>
						<span>支付方式</span>
					</td>
					<td>
						<auchan:select mdgroup="CONTRACT_DETL_PAY_METHD" _class="select1 w85 enterBind" name="supVatNo" id="supVatNo" />
					</td>
				</tr>
				<tr>
					<td>
						<span>赞助科目</span>
					</td>
					<td>
						<div class="iconPut w85 fl_left">
							<input type="hidden" class="w82" name="grpAcctIds" id="grpAcctIds">
							<input type="text" class="w82 enterBind" name="grpAcctAbbrs" id="grpAcctAbbrs" >
							<div class="ListWin" onclick="openAcctGroupWin(this)"></div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="line"></div>
	<div class="SearchFooter">
		<div class="Icon-size1 Tools20" onclick="clean_form()"></div>
		<div class="Icon-size1 Tools6" onclick="searchFormSubmit();"></div>
	</div>
</form>

<script>
function clean_form(){
	$.each($(".clean_from").find('input'),function(index,item){
		if(!$(item).hasClass('Wdate')){
			$(item).removeClass('errorInput');
			$(item).attr('title','');
			$(item).attr('value','');
		}
	});
$($(".clean_from").find('select')[0]).attr('value','');
$($(".clean_from").find('select')[1]).attr('value','');
}
</script>