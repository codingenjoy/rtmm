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
		<auchan:operauth ifAnyGrantedCode="111321996">
			$("#Tools12").attr('class', "Icon-size1 Tools12").unbind("click").bind("click",
					function() {
						modifyInternalSupplier();
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
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102009002" /><!-- 内部厂编 --></div></td>
				<td><div class="t_cols" style="width: 300px;"><auchan:i18n id="102009003" /><!-- 厂商名称 --></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102009004" /><!-- 准备天数 --></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102003006" /><!-- 创建日期 --></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102009006" /><!-- 创建人 --></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102009007" /><!-- 修改日期 --></div></td>
				<td><div class="t_cols" style="width: 100px"><auchan:i18n id="102009008" /><!-- 修改人 --></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="intrnSupplier">
				<tr onclick="onClickRow('${intrnSupplier.supNo}')">
					<td style="width: 101px" class="align_right"><span id="supNo"
						style="margin-right: 5px;">${intrnSupplier.supNo }</span></td>
					<td id="intrnSupName" style="width: 301px;">
						${intrnSupplier.intrnSupName}</td>
					<td id="leadTime" style="width: 101px;">
						${intrnSupplier.leadTime}</td>
					<td id="creatDate" style="width: 101px;"><fmt:formatDate
							pattern="yyyy-MM-dd" value="${intrnSupplier.creatDate}" /></td>
					<td id="creatBy" style="width: 101px;">
						<auchan:getStuffName value="${intrnSupplier.creatBy}"/></td>
					<td id="chngDate" style="width: 101px;"><fmt:formatDate
							pattern="yyyy-MM-dd" value="${intrnSupplier.chngDate}" /></td>
					<td id="chngBy" style="width: 101px;"><auchan:getStuffName value="${intrnSupplier.chngBy}"/></td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


