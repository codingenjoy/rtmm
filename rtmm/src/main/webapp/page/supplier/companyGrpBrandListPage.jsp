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
	<auchan:operauth ifAnyGrantedCode="111113996">
		function onClickRow(){
			$("#Tools12").attr('class', "Icon-size1 Tools12 B-id");
		}
	</auchan:operauth>
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 133px;"><auchan:i18n id="102003002"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 124px;"><auchan:i18n id="102003003"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 309px;"><auchan:i18n id="102003004"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 343px;"><auchan:i18n id="102003005"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 120px;"><auchan:i18n id="102003006"></auchan:i18n></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="brand">
				<tr id="${brand.brandId }" onclick="onClickRow();">
					<td style="width: 134px" class="align_right">
					   <span style="margin-right: 5px;">${brand.comgrpNo}-${brand.comGrpName}</span>
					</td>
					<input name="comGrpName" type="hidden" value="${brand.comGrpName}" />
					<td  style="width: 125px;"> ${brand.brandId}</td>
					<td  style="width: 310px;">${brand.brandName}</td>
					<td  style="width: 344px;">${brand.brandEnName}</td>
					<td  style="width: 121px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${brand.creatDate}"/></td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


