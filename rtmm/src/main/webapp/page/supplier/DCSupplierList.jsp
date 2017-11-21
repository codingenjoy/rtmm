<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});
	});
	
	function onClickRow(){
		<auchan:operauth ifAnyGrantedCode="111322996">
			$("#Tools12").attr('class', "Icon-size1 Tools12").bind("click",
					function() {
						modifyDCSupplier();
					}
			);
		</auchan:operauth>
	}
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 60px"><auchan:i18n id="102010002" /><!-- 厂编 --></div></td>
				<td><div class="t_cols" style="display: none;"><auchan:i18n id="102010001" /><!-- DC Store --></div></td>
				<td><div class="t_cols" style="width: 270px;"><!-- 厂商名称 --><auchan:i18n id="102006006"/></div></td>
				<td><div class="t_cols" style="width: 180px;"><auchan:i18n id="102010003" /><!-- 配送中心 --></div></td>
				<td><div class="t_cols" style="width: 90px;"><auchan:i18n id="102010004" /><!-- 启用日期 --></div></td>
				<td><div class="t_cols" style="width: 90px;"><auchan:i18n id="102010005" /><!-- 截至日期 --></div></td>
				<td><div class="t_cols" style="width: 40px;"><!-- 状态 --><auchan:i18n id="102010006"/></div></td>
				<td><div class="t_cols" style="width: 100px">用戶</div></td>
				<td><div class="t_cols" style="width: 90px;"><!-- 创建日期 --><auchan:i18n id="102010008"/></div></td>
				<td><div class="t_cols" style="width: 90px;"><!-- 修改日期 --><auchan:i18n id="102009007"/></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="dcSupplier">
				<tr onclick="onClickRow('${dcSupplier.supNo}')">
					<td style="width: 61px" class="align_right"><span
						id="dcSupNo" style="margin-right: 5px;">${dcSupplier.supNo }</span></td>
					<td id="dcStoreNo" style="display: none;">
						${dcSupplier.storeNo}</td>
					<td id="comName" style="width: 271px;">
						${dcSupplier.comName}</td>
					<td id="dcStoreName" style="width: 181px;">
						${dcSupplier.storeName}</td>
					<td id="applyStartDateFrom" style="width: 91px;">
						${dcSupplier.applyStartDateFrom}</td>
					<td id="applyStartDateEnd" style="width: 91px;">
						${dcSupplier.applyStartDateEnd}</td>
					<td id="lockSttus" style="width: 41px;">
						<auchan:getDictValue code="${dcSupplier.lockSttus}" mdgroup="SUP_DC_CTRL_LOCK_STTUS"></auchan:getDictValue>
					<td id="chnyBy" style="width: 101px;">
						${dcSupplier.chngBy}</td>
					<td id="creatDate" style="width: 91px;">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${dcSupplier.creatDate}"/></td>
					<td id="chngDate" style="width: 91px;">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${dcSupplier.chngDate}"/></td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


