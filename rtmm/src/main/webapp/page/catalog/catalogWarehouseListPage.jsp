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
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101002002"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101002003"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 500px;"><auchan:i18n id="101003024"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="101003025"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 120px;"><auchan:i18n id="101003027"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 120px;"><auchan:i18n id="101003028"></auchan:i18n></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr onclick="onClickRow('${item.whseNo}')">
					<td style="width: 81px;" class="align_right">
						<span style="margin-right: 5px;">${item.whseNo}</span>
					</td>
					<td style="width: 81px;">
						${item.cityName}
					</td>
					<td style="width: 501px;">
						${item.detllAddr}
					</td>
					<td style="width: 101px;">
						${item.postCode}
					</td>
					<td style="width: 121px;">
						${item.phoneNo}
					</td>
					<td style="width: 121px;">
						${item.faxNo}
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


