<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/analysis/historicalWeather.js" type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function() {
	$(".btable_div").scroll(function() {
		var left = $(this).scrollLeft();
		$(".htable_div").scrollLeft(left);
	});

});
</script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td>
					<div class="t_cols" style="width: 100px; padding-left: 5px;">日期</div>
				</td>
				<c:forEach items="${result}" var="city">
					<td>
						<div class="t_cols" style="width: 150px;" title="${city[0].regnName }">${city[0].regnName }</div>
					</td>
				</c:forEach>
				<td>
					<div class="t_cols" style="width: 16px;"></div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div weather" style="height: 450px;">
	<table class="single_tb w100" id="weatherHistory">
		<c:forEach items="${result[0] }" var="outer" varStatus="seq1">
			<tr>
				<c:forEach items="${result }" var="inner" varStatus="seq2">
					<c:if test="${seq2.index == 0 }">
						<td style="width: 102px; padding-left: 5px;">${outer.calDate }</td>
					</c:if>
					<td style="width: 152px;" class="align_left">
						<c:choose>
							<c:when test="${ not empty inner[seq1.index].weatherCode}">
								<div class="weather${inner[seq1.index].weatherCode }"></div>
								<span style="margin-right: 5px;"><auchan:getDictValue code="${inner[seq1.index].weatherCode }" showType="2" mdgroup="day_Wther_Code"></auchan:getDictValue>,
									${inner[seq1.index].nightTemp }~${inner[seq1.index].dayTemp }</span>
							</c:when>
						</c:choose>
					</td>
				</c:forEach>
				<td style="width: auto;">&nbsp;</td>
			</tr>
		</c:forEach>
	</table>
</div>


