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
				<td><div class="t_cols" style="width: 90px;"><auchan:i18n id="101010011"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 90px;"><auchan:i18n id="101010003"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 90px;"><auchan:i18n id="101010004"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 90px;"><auchan:i18n id="101010005"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 90px;"><auchan:i18n id="101010006"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 90px;"><auchan:i18n id="101010007"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 60px;"><auchan:i18n id="101010008"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 60px;">B</div></td>
				<td><div class="t_cols" style="width: 60px;"><auchan:i18n id="101010009"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 60px;">N</div></td>
				<td><div class="t_cols" style="width: 60px;"><auchan:i18n id="101010009"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 60px;">O</div></td>
				<td><div class="t_cols" style="width: 60px;"><auchan:i18n id="101010009"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 60px;"><auchan:i18n id="101010010"></auchan:i18n></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr>
					<td style="width: 91px;" class="align_right">
						<span>${item.storeNo}-${item.storeName}</span>
					</td>
					<td style="width: 91px;">
						${item.divNo}-${item.divTitle}
					</td>
					<td style="width: 91px;">
						${item.secNo}-${item.secTitle}
					</td>
					<td style="width: 91px;">
						${item.grpNo}-${item.grpTitle}
					</td>
					<td style="width: 91px;">
						${item.midNo}-${item.midTitle}
					</td>
					<td style="width: 91px;">
						${item.catlgNo}-${item.catlgTitle}
					</td>
					<td style="width: 61px;" align="center" align="center">
						${item.mktPostN}
					</td>
					<td style="width: 61px;" align="center">
						<c:choose>
							<c:when test="${item.realNbrB > item.trgtNbrB}">
								<div style="color:red">${item.trgtNbrB}</div>
							</c:when>
							<c:otherwise>
								${item.trgtNbrB}
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width: 61px;" align="center">
						<c:choose>
							<c:when test="${item.realNbrB > item.trgtNbrB}">
								<div style="color:red">${item.realNbrB}</div>
							</c:when>
							<c:otherwise>
								${item.realNbrB}
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width: 61px;" align="center">
						<c:choose>
							<c:when test="${item.realNrbN > item.trgtNbrN}">
								<div style="color:red">${item.trgtNbrN}</div>
							</c:when>
							<c:otherwise>
								${item.trgtNbrN}
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width: 61px;" align="center">
						<c:choose>
							<c:when test="${item.realNrbN > item.trgtNbrN}">
								<div style="color:red">${item.realNrbN}</div>
							</c:when>
							<c:otherwise>
								${item.realNrbN}
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width: 61px;" align="center">
						<c:choose>
							<c:when test="${item.realNbrO > item.trgtNbrO}">
								<div style="color:red">${item.trgtNbrO}</div>
							</c:when>
							<c:otherwise>
								${item.trgtNbrO}
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width: 61px;" align="center">
						<c:choose>
							<c:when test="${item.realNbrO > item.trgtNbrO}">
								<div style="color:red">${item.realNbrO}</div>
							</c:when>
							<c:otherwise>
								${item.realNbrO}
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width: 61px;" align="center">
						<c:choose>
							<c:when test="${item.exceed =='Y'}">
								<div style="color:red">${item.exceed}</div>
							</c:when>
							<c:otherwise>
								${item.exceed}
							</c:otherwise>
						</c:choose>
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


