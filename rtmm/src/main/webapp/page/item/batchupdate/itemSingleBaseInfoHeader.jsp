<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.paging .page_list {
	width: 380px;
}
</style>
<script type="text/javascript">
$(".addSingleItem").unbind().bind('dblclick',function(){
	var confirm=$("#popupWin").find("#confirm");
	$(confirm).click();
});
</script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols" style="width: 30px;"></div></td>
				<td><div class="t_cols" style="width: 80px;">货号</div></td>
				<td><div class="t_cols" style="width: 415px;">商品名称</div></td>
				<td><div class="t_cols" style="width: 160px;">状态</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 320px;">
	<table class="single_tb">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="item">
				<tr>
					<td><div class="t_cols"
							style="width: 30px; border-right: 0px !important; text-align: center;">
						</div></td>
					<td><div class="t_cols addSingleItem"
							style="width: 80px; text-align: right; border-right: 0px !important;">${item.itemNo}&nbsp;&nbsp;</div>
						<input type="hidden" name="itemNo" value="${item.itemNo}">
					</td>
					<td><div class="t_cols addSingleItem"
							style="width: 415px; border-right: 0px !important;">${item.itemName }</div>
						<input type="hidden" name="itemName" value="${item.itemName}">
					</td>

					<td><div class="t_cols addSingleItem"
							style="width: 160px; border-right: 0px !important;">
							<auchan:getDictValue mdgroup="ITEM_BASIC_STATUS"
								code="${item.status}"></auchan:getDictValue>
						</div> <input type="hidden" name="status" value="${item.status}">
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>