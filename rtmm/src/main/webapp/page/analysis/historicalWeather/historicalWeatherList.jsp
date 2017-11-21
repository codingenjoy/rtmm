<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/analysis/historicalWeather.js"
	type="text/javascript"></script>
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
					<div class="t_cols firstColumn" style="">城市</div>
				</td>
				<c:forEach items="${result[0]}" var="city" > 
				<td>
					<div class="t_cols" style="width: 150px;">${city.calDate }</div>
				</td>
				</c:forEach>
				<td>
					<div class="t_cols" style="width: 16px;"></div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div weather" style="height: 490px;">
	<table class="single_tb w100" id="weatherHistory">
		<c:forEach items="${result}" var="outer" varStatus="seq1" >
			<tr>
				<c:forEach items="${outer }" var="inner" varStatus="seq2">
						<c:if test="${seq2.index == 0 }">
							<td class="firstColumn" style="" title="${inner.regnName }">${inner.regnName }</td>
						</c:if>
							<td style="width: 152px;" class="align_left">
							<c:choose>
								<c:when test="${ not empty inner.weatherCode}" >
									<div class="weather${inner.weatherCode }"></div>
									<span style="margin-right: 5px;"><auchan:getDictValue code="${inner.weatherCode }" showType="2" mdgroup="day_Wther_Code"></auchan:getDictValue>, ${inner.nightTemp }~${inner.dayTemp }</span>
								</c:when>	
							</c:choose>
							</td>
				</c:forEach>
				<td style="width: auto;"  >&nbsp;</td>
			</tr>
		</c:forEach> 
	</table>
</div>


