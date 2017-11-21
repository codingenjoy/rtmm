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

	function onClickRow(comgrpNo,comgrpName,comgrpEnName){
		record.comGrpNo = comgrpNo;
		record.comGrpName = comgrpName;
		record.comGrpEnName = comgrpEnName;
	}
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="102001002"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 300px;"><auchan:i18n id="102001003"></auchan:i18n></div></td>
				<td><div class="t_cols" style="width: 300px;"><auchan:i18n id="102001004"></auchan:i18n></div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="comGrp">
				<tr id="${comGrp.comgrpNo }">
					<td style="width: 101px" class="align_right">
					   <span style="margin-right: 5px;">${comGrp.comgrpNo }</span>
					</td>
					<td  style="width: 301px;"> ${comGrp.comgrpName}</td>
					<td  style="width: 301px;">${comGrp.comgrpEnName}</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


