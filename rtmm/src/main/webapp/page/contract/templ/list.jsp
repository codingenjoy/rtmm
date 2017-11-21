<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript"
	src="${ctx}/shared/js/contract/template/template.js"></script>
<style>
.align_right {
	padding-right:20px;
}
</style>
<script>
	$(function(){
		//滚动条事件
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});
	})
</script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<!-- <td>
					<div class="t_cols align_center" style="width: 30px;">
						<input type="checkbox" />
					</div>
				</td> -->
				<td><div class="t_cols" style="width: 180px;">模板编号</div></td>
				<td><div class="t_cols" style="width: 150px;">使用状态</div></td>
				<td><div class="t_cols" style="width: 150px;">创建日期</div></td>
				<td><div class="t_cols" style="width: 160px;">建档人</div></td>
				<td><div class="t_cols" style="width: 150px;">修改日期</div></td>
				<td><div class="t_cols" style="width: 150px;">修改人</div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 509px;">
	<table class="single_tb w100">
		<c:forEach items="${page.result}" var="list" varStatus="num">
			<!--multi_tb为多选 width:1001px;-->
			<tr ondblclick="switchDetailPage(this)" onclick="showTools(this)">
				<td style="width: 181px;"><div class="align_right">${list.tmplId}</div></td>
				<td style="width: 151px;"><div><auchan:getDictValue mdgroup="CONTRACT_TMPL_IN_USE_IND" code="${list.inUseInd }" ></auchan:getDictValue></div></td>
				<td style="width: 151px;"><div><fmt:formatDate pattern="yyyy-MM-dd" value="${list.creatDate }"/></div></td>
				<td style="width: 161px;"><div><auchan:getStuffName value="${list.creatBy }"/></div></td>
				<td style="width: 151px;"><div><fmt:formatDate pattern="yyyy-MM-dd" value="${list.chngDate }"/></div></td>
				<td style="width: 151px;"><div><auchan:getStuffName value="${list.chngBy }"/></div></td>
				<td style="width: auto">&nbsp;</td>
			</tr>
		</c:forEach>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>