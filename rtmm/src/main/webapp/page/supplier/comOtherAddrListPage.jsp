<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jumpPage.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});
	});
	
	function onClickRow(){
		$("#Tools22").attr('class', "Icon-size1 Tools22");
		if ($("#Tools21").parent().attr('class').indexOf('ToolsBg') > 0) {
			$("#Tools21").attr('class', "Icon-size1 Tools21_on");
		} else {
			$("#Tools21").attr('class', "Icon-size1 Tools21");
		}
	}
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="102005003"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102005004"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102005005"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 202px;"><auchan:i18n id="102005006"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="102005007"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="102005008"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px"><auchan:i18n id="102005009"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px"><auchan:i18n id="102005010"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 90px"><auchan:i18n id="102005011"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px"><auchan:i18n id="102005012"></auchan:i18n></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 480px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="addr">
				<tr id="${addr.addrId }">
					<td style="width: 81px" class="align_right">
					   <span style="margin-right: 5px;">${addr.addrId }</span>
					</td>
					<td  style="width: 101px;"><auchan:getDictValue code="${addr.addrType}" mdgroup="COM_OTH_ADDRESS_ADDR_TYPE"></auchan:getDictValue></td>
					<td  style="width: 101px;">${addr.cityName}</td>
					<td  style="width: 202px;" title="${addr.detllAddr}">${addr.detllAddr}</td>
					<td  style="width: 81px;">${addr.cntctName}</td>
					<td  style="width: 81px;">${addr.postCode}</td>
					<td  style="width: 101px;">${addr.moblNo}</td>
					<td  style="width: 81px;">${addr.phoneNo}</td>
					<td  style="width: 91px;">${addr.faxNo}</td>
					<td  style="width: 101px;">${addr.emailAddr}</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


