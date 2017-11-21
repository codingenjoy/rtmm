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
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="101008002"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101008003"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101008004"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 120px;"><auchan:i18n id="101008005"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 120px;"><auchan:i18n id="101008006"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101008007"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101008008"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101008009"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101008010"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101008011"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 80px;"><auchan:i18n id="101008012"></auchan:i18n></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 350px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr ondblclick="onDblClickRow('${item.catlgId}');" onclick="onClickRow('${item.catlgId}','<c:out value="${item.catlgName}"/>','<c:out value="${item.catlgEnName}"/>','${item.status}','<c:out value="${item.divTitle}"/>','<c:out value="${item.secTitle}"/>','<fmt:formatDate pattern="yyyy-MM-dd" value="${item.createDate}"/>','<fmt:formatDate pattern="yyyy-MM-dd" value="${item.chngDate}"/>','${item.chngBy}')">
					<td style="width: 101px;">
						<span >${item.grpNo}-${item.grpTitle}</span>
					</td>
					<td style="width: 101px;">
						<span >${item.midNo}-${item.midTitle}</span>
					</td>
					<td style="width: 81px;">
						<span>${item.catlgNo}</span>
					</td>
					<td style="width: 121px;">
						${item.catlgName}
					</td>
					<td style="width: 121px;">
						${item.catlgEnName}
					</td>
					<td style="width: 81px;">
						<auchan:getDictValue code="${item.status}" mdgroup="CL_CATALOG_STATUS"></auchan:getDictValue>
					</td>
					<td style="width: 81px;">
						${item.divNo}-${item.divTitle}
					</td>
					<td style="width: 81px;">
						${item.secNo}-${item.secTitle}
					</td>
					<td style="width: 81px;">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${item.createDate}"/>
					</td>
					<td style="width: 81px;">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${item.chngDate}"/>
					</td>
					<td style="width: 81px;">
					  <auchan:getStuffName value="${item.chngBy}"/>
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


