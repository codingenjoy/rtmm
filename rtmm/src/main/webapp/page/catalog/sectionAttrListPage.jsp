<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});
	});
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="attrSeqNo" id="attrSeqNo" value="${attrSeqNo}" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="display: none;">attrId </div></td>
				<td><div class="t_cols" style="width: 100px;"><auchan:i18n id="101005003"></auchan:i18n> </div></td>
				<td><div class="t_cols" style="width: 500px;"><auchan:i18n id="101005009"></auchan:i18n> </div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 445px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="secAttrVal">
				<tr onclick="onClickRow('${secAttrVal.secAttrValNo}')">
					<td id="secAttrId" style="display:none;">${secAttrVal.secAttrId }</td>
					<td style="width: 101px;" class="align_right">
						<span id="secAttrValNo" style="margin-right: 5px;">${secAttrVal.secAttrValNo}</span>
					</td>
					<td id="secAttrValName" style="width: 501px;">
						${secAttrVal.secAttrValName}
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


