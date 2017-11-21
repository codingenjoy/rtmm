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
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo}" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="101009002"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 135px;"><auchan:i18n id="101009003"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 155px;"><auchan:i18n id="101009004"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 155px;"><auchan:i18n id="101009005"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 155px;"><auchan:i18n id="101009006"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 155px;"><auchan:i18n id="101009007"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 50px;">B</div></td>
				<td><div class="t_cols" style="width: 50px;">N</div></td>
				<td><div class="t_cols" style="width: 50px;">O</div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 480px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr>
					<td style="width: 101px;" class="align_right">
						<span>${item.regnNo}-${item.regnName}&nbsp;&nbsp;</span>
					</td>
					<td style="width: 136px;">
						${item.divNo}-${item.divTitle}
					</td>
					<td style="width: 156px;">
						${item.secNo}-${item.secTitle}
					</td>
					<td style="width: 156px;">
						${item.grpNo}-${item.grpTitle}
					</td>
					<td style="width: 156px;">
						${item.midNo}-${item.midTitle}
					</td>
					<td style="width: 156px;">
						${item.catlgNo}-${item.catlgTitle}
					</td>
					<td style="width: 51px;">
						${item.trgtNbrB}
					</td>
					<td style="width: 51px;">
						${item.trgtNbrN}
					</td>
					<td style="width: 51px;">
						${item.trgtNbrO}
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


