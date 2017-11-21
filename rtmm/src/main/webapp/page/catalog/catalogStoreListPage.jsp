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
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="101003002"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 150px;"><auchan:i18n id="101003003"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="101003004"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="101003005"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 250px;"><auchan:i18n id="101003006"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="101003007"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101003008"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101003021"></auchan:i18n></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item" varStatus="count">
				<tr ondblclick="onDblClickRow('${item.storeNo}','${count.count}');" onclick="onClickRow('${item.storeNo}','${count.count}')">
					<td style="width: 101px;" class="align_right">
						<span style="margin-right: 5px;">${item.storeNo}</span>
					</td>
					<td style="width: 151px;">
						${item.storeName}
					</td>
					<td style="width: 101px;">
						${item.statusTitle}
					</td>
					<td style="width: 101px;">
						${item.lvlTiltle}
					</td>
					<td style="width: 251px;">
						${item.comTitle}
					</td>
					<td style="width: 101px;">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${item.openDate}"/>
					</td>
					<td style="width: 81px;">
						${item.bizTitle}
					</td>
					<td style="width: 81px;">
						${item.regnName}
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


