<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<input id="acctTotalCount" type="hidden" value="${page.totalCount }" />
<div class="btable_div" style="height: 340px;">
	<table class="single_tb w100">
		<c:forEach items="${page.result }" var="itemVO" varStatus="num">
			<tr onclick="onclickCheckBox(this);" ondblclick="ondbclickcheckBox(this);" >
				<td class="align_center" style="width: 30px;">
					<input type="checkbox" />
				</td>
				<td style="width: 95px;">${itemVO.itemNo }</td>
				<td style="width: 370px;">${itemVO.itemName }</td>
				<td style="width: auto">&nbsp;</td>
			</tr>
		</c:forEach>
	</table>
</div>
<div class="paging" id="planItemPage"></div>
<script type="text/javascript">
	var plan = new Paginator({
		totalItems:'${page.totalCount}',
		itemsPerPage:'${page.pageSize}',
		page:'${page.pageNo}',
		paginatorElem:'planItemPage',
		callback:function(pageNo,pageSize){
			planPageQuery(pageNo,pageSize);
		}
	});
	$(window).unload(function() {
		//0.清理资源;
		plan.destroy();
	});
	$(function(){
	//TODO
	});
</script>
