<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});

		$("#Tools12").removeClass("Tools12").addClass("Tools12_disable").unbind('click');
	});
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 60px;"><auchan:i18n id="101004007"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 160px;"><auchan:i18n id="101004004"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 160px;"><auchan:i18n id="101004005"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101004008"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101004009"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101004010"></auchan:i18n></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 440px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr onclick="onClickRow('${item.catlgNo}')">
					<td style="width: 61px;" class="align_right">
						<span style="margin-right: 5px;">${item.catlgNo}</span>
					</td>
					<td style="width: 161px;">
						${item.catlgName}
					</td>
					<td style="width: 161px;">
						${item.catlgEnName}
					</td>
					<td style="width: 81px;">
						${item.foodNonfoodTitle}
					</td>
					<td style="width: 81px;">
						${item.ordDeletEnbldIndTitle}
					</td>
					<td style="width: 81px;">
						${item.statusTitle}
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


