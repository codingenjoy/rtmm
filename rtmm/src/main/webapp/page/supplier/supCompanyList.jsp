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
		$("#Tools21").attr('class', "Icon-size1 Tools21_disable");
		$("#Tools22").attr('class', "Icon-size1 Tools22");
		/* if ($("#Tools21").parent().attr('class').indexOf('ToolsBg') > 0) {
			$("#Tools21").attr('class', "Icon-size1 Tools21_on");
		} else {
			$("#Tools21").attr('class', "Icon-size1 Tools21");
		} */
	}
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102002002"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 300px;"><auchan:i18n id="102002003"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102002004"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102002005"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102002006"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102002007"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 120px"><auchan:i18n id="102002008"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px"><auchan:i18n id="102002009"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px"><auchan:i18n id="102002010"></auchan:i18n></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="supCom">
				<tr onclick="onClickRow()" ondblclick="goSupCompanyDetailed('${supCom.comNo}');" id="${supCom.comNo}">
					<td style="width: 101px" class="align_right">
					   <span style="margin-right: 5px;">${supCom.comNo }</span>
					</td>
					<td  style="width: 301px;">${supCom.comName}</td>
					<td  style="width: 101px;">${supCom.comEnName}</td>
					<td  style="width: 101px;">${supCom.comgrpNo}</td>
					<td  style="width: 101px;">${supCom.comgrpName}</td>
					<td  style="width: 101px;"><auchan:getDictValue code="${supCom.econType}" mdgroup="COMPANY_ECON_TYPE"></auchan:getDictValue></td>
					<td  style="width: 121px;">${supCom.unifmNo}</td>
					<td  style="width: 101px;">${supCom.cityName}</td>
					<td  style="width: 101px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${supCom.setupDate}" /></td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


