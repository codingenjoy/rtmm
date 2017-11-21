<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});
	});

	function onClickRow(comNo,comName,comgrpNo, comgrpName) {
		confirmChooseSupCom(comNo, comName,comgrpNo,comgrpName);
		closePopupWin();
	}
	
</script>
<input type="hidden" name="pageNo1" id="pageNo1" value="${page.pageNo}" />
<div class="btable_div" style="height: 310px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr id="${item.comNo}" onclick="onClickRow('${item.comNo}','<c:out value="${item.comName}"/>','${item.comgrpNo}','<c:out value="${item.comgrpName}"/>')" >
					<td style="width: 101px" class="align_right">
						<span style="margin-right: 5px;">${item.comNo }</span>
					</td>
					
					<td style="width: 301px;">${item.comName}</td>
					<td style="width: 151px;">${item.unifmNo}</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet1.jsp"></jsp:include>


