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
<div class="btable_div" style="height: 510px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr ondblclick="onDblClickRow('${item.module}','${item.taskId}');" onclick="if($(this).hasClass('btable_checked')){return false;}onClickRow('${item.module}','${item.taskId}','${item.prcssId}','${item.taskType}')">
					<td style="width: 151px;" class="align_right">
						<span style="margin-right: 5px;">${item.taskId}</span>
					</td>
					<td style="width: 201px;">
						<auchan:getDictValue code="${item.taskType}" mdgroup="TASK_TYPE"></auchan:getDictValue>
					</td>
					<td style="width: 151px;">
						<auchan:getDictValue code="${item.taskSttus}" mdgroup="META_TASK_STTUS"></auchan:getDictValue>
					</td>
					<td style="width: 151px;" class="align_right">
						${item.bizObjPkNo}&nbsp;&nbsp;
					</td>
					<td style="width: 151px;">
						${item.chngBy}
					</td>
					<td style="width: 151px;">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${item.chngDate}"/>
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


