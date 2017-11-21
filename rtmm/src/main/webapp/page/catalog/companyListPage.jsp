<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});

		$("#Tools22").removeClass("Tools22").addClass("Tools22_disable").unbind('click');
	});
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo}" />
<input type="hidden" id="totalCount" value="${page.totalCount}" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101001002"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 280px;"><auchan:i18n id="101001003"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 120px;"><auchan:i18n id="101001004"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 120px;"><auchan:i18n id="101001005"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 160px;"><auchan:i18n id="101001006"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 120px;"><auchan:i18n id="101001007"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 120px;"><auchan:i18n id="101001008"></auchan:i18n></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item" varStatus="count">
				<tr ondblclick="onDblClickRow('${item.comNo}','${count.count}');" onclick="onClickRow('${item.comNo}','${count.count}')">
					<td style="width: 81px;" class="align_right">
						<span style="margin-right: 5px;">${item.comNo}</span>
					</td>
					<td style="width: 281px;">
						${item.comName}
					</td>
					<td style="width: 121px;">
						${item.econTitle}
					</td>
					<td style="width: 121px;">
						${item.statusTitle}
					</td>
					<td style="width: 161px;">
						${item.unifmNo}
					</td>
					<td style="width: 121px;">
						${item.cityName}
					</td>
					<td style="width: 121px;">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${item.setupDate}"/>
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


