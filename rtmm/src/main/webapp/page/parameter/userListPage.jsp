<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
	$(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});
		
		$("#Tools12").removeClass("Tools12").addClass("Tools12_disable").unbind('click');
	});
</script>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo}" />
<input type="hidden" name="pageSize" id="pageSize" value="${page.pageSize}" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 200px;">姓名</div></td>
				<td><div class="t_cols" style="width: 200px;">用户名</div></td>
				<td><div class="t_cols" style="width: 150px;">状态</div></td>
				<td><div class="t_cols" style="width: 150px;">失效日期</div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 430px;">
	<table class="single_tb w100">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr ondblclick="onDblClickStaffRow('${item.staffId}');" onclick="onClickStaffRow('${item.staffId}')">
					<td style="width:201px;">
						${item.name}
					</td>
					<td style="width: 201px;">
						${item.staffNo}
					</td>
					<td style="width: 151px;">
						<c:choose>
							<c:when test="${item.status==1}">有效</c:when>
							<c:when test="${item.status==1}">无效</c:when>
						</c:choose>
					</td>
					<td style="width: 151px;">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${item.validDate}"/>
					</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>


