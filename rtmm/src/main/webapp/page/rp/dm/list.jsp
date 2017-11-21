<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/paginator/paginator.css" />
<script src="${ctx}/shared/js/paginator/paginator.js" type="text/javascript"></script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td><div class="t_cols align_center" style="width: 30px;">&nbsp;</td>
				<td><div class="t_cols" style="width: 100px;">DM编号</div></td>
				<td><div class="t_cols" style="width: 120px;">主题</div></td>
				<td><div class="t_cols" style="width: 100px;">活动开始日</div></td>
				<td><div class="t_cols" style="width: 100px;">活动结束日</div></td>
				<td><div class="t_cols" style="width: 120px;">门店最少确认天数</div></td>
				<td><div class="t_cols" style="width: 120px;">SCM补货提前天数</div></td>
				<td><div class="t_cols" style="width: 120px;">门店补货提前天数</div></td>
				<td><div class="t_cols" style="width: 100px;">创建日期</div></td>
				<td><div class="t_cols" style="width: 100px;">修改日期</div></td>
				<td><div style="width: 16px;">&nbsp;</div></td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 509px;">
	<table class="single_tb w100">
		<!--multi_tb为多选 width:1001px;-->
		 <c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="rpDmVo" varStatus="num">
            <tr onclick="listTrClick(this)" ondblclick="listTrDblClick(this)">
			<td class="align_center" style="width: 30px;">&nbsp;</td>
			<td style="width: 101px;">${rpDmVo.rdmNo }<input type="hidden" name="rdmNo" value="${rpDmVo.rdmNo }"/></td>
			<td style="width: 121px;">${rpDmVo.rdmTopic }</td>
			<td style="width: 101px;"><c:if test="${rpDmVo.rdmBeginDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVo.rdmBeginDate }" /></c:if></td>
			<td style="width: 101px;"><c:if test="${rpDmVo.rdmEndDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVo.rdmEndDate }" /></c:if></td>
			<td style="width: 111px;" class="align_right">${rpDmVo.stCnfrmDays }</td>
			<td style="width: 111px;" class="align_right">${rpDmVo.scmPrepDays }</td>
			<td style="width: 111px;" class="align_right">${rpDmVo.stDlvryBefDays }</td>
			<td style="width: 101px;"><c:if test="${rpDmVo.creatDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVo.creatDate }" /></c:if></td>
			<td style="width: 101px;"><c:if test="${rpDmVo.chngDate!=null}"><fmt:formatDate pattern="yyyy-MM-dd" value="${rpDmVo.chngDate }" /></c:if></td>
			<td style="width: auto">&nbsp;</td>
		   </tr>
             </c:forEach>
       </c:if>
	</table>
</div>
<div class="paging" id="currentContract"></div>
<%@ include file="/page/commons/paginator.jsp"%>
<script type="text/javascript">
	var p = new Paginator({
		totalItems:'${page.totalCount}',
		itemsPerPage:'${page.pageSize}',
		page:'${page.pageNo}',
		paginatorElem:'currentDM',
		callback:function(pageNo,pageSize){
			currentDMPageQuery(pageNo,pageSize);
		}
	});
	$(window).unload(function() {
		//0.清理资源;
		p.destroy();
	});
	
	$(function(){
		$(".btable_div").scroll(function () {
		    var left = $(this).scrollLeft();
		    $(".htable_div").scrollLeft(left);
		});
		
	});
</script>
