<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
 /**
  * 跳转
  */	
function pagination(currentPage) {
	$("#pageNo").val(currentPage);
	pageQuery();
}
</script>
<div class="paging">
	<%-- <c:if test="${ not empty page.result}"> --%>
		<div class="fl_left">
			<!-- 第 -->
			<auchan:i18n id="100002001"/>
			${((page.pageNo-1)*(page.pageSize)+1)}-${((page.pageNo)*(page.pageSize))}
			<!-- 项 -->
			<auchan:i18n id="100002002"/>
			&nbsp;&nbsp;
			<span class="pageSizeBar">
			|&nbsp;
			<!-- 每页显示  -->
			<auchan:i18n id="100002004"/>
			<select name="pageSize" id="pageSize" onchange="pagination(${page.pageNo})">
				<option value="10"
					<c:if test="${page.pageSize == 10}">selected="selected"</c:if>>10</option>
				<option value="20"
					<c:if test="${page.pageSize == 20}">selected="selected"</c:if>>20</option>
				<option value="30"
					<c:if test="${page.pageSize == 30}">selected="selected"</c:if>>30</option>
			</select> 
			<!-- 项 -->
			<auchan:i18n id="100002002"/>
			</span>
		</div>
		<div class="fl_right page_list">
		
			<c:if test="${isEnd eq 0 }">
				<a title="<auchan:i18n id="100002006"/>" onclick="javascript:pagination(parseInt('${page.pageNo}')+1)" class="page_next_block rtA" ></a> 
			</c:if>
		
		<c:if test="${isEnd eq 1}">
			<a title="<auchan:i18n id="100002006"/>" class="page_next_block_off rtA"></a> 
		</c:if>
		<a class="click_block">${(page.pageNo)}</a>
		<c:if test="${page.pageNo > 1}">
			<a title="<auchan:i18n id="100002005"/>" onclick="javascript:pagination(parseInt('${page.pageNo}')-1)" class="page_prev_block"></a> 
		</c:if>
		<c:if test="${page.pageNo == 1}">
			<a title="<auchan:i18n id="100002005"/>" class="page_prev_block_off"></a> 
		</c:if>
	</div>
</div>
	
<%-- </c:if> --%>