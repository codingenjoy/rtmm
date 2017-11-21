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

/**
 * 设置跳转页
 * @param currentPage
 */
function jumpPage(totalpage)
{
	var inputPage = $("#goto_page").val();
	if ($.trim(inputPage) == '' || !inputPage.match(/^\d+$/))
	{
	    top.jAlert('error', '输入必须为整数','提示消息');
	    $("#goto_page").val("");
	    $("#goto_page").focus();
	    return;
	}
	if (inputPage < 1 || inputPage > totalpage)
	{
		top.jAlert('error', '跳转的页码不能大于总页数','提示消息');
		$("#goto_page").val("");
		$("#goto_page").focus();
		return;
	}
	pagination(inputPage);
}
</script>
<div class="paging">
	<c:if test="${ not empty page.result}">
		<div class="fl_left">
			第
			${((page.pageNo-1)*(page.pageSize)+1)}-${((page.pageNo)*(page.pageSize))}项,共${page.totalCount}项&nbsp;&nbsp;|&nbsp;
			 <select name="pageSize" id="pageSize" onchange="pagination(1)">
				<option value="10"
					<c:if test="${page.pageSize == 10}">selected="selected"</c:if>>10</option>
				<option value="20"
					<c:if test="${page.pageSize == 20}">selected="selected"</c:if>>20</option>
				<option value="30"
					<c:if test="${page.pageSize == 30}">selected="selected"</c:if>>30</option>
			</select> 项
		</div>
		<div class="fl_right page_list">
			<span class="fl_right" style="margin-right: 10px;">
				&nbsp;&nbsp;&nbsp;至第 <input name="pageNo" id="goto_page"
				class="page_no_input" maxlength="5" type="text" size="3"
				maxlength="5" onkeyup="this.value=this.value.replace(/\D/g,'')"
				onkeydown="if(event!== null && event.keyCode == 13) jumpPage(${page.totalPages});" />
				页
			</span>
			<!-- 
			<input value="跳转" type="button"
				onclick="jumpPage(${page.totalPages})" />
			-->
			<c:if test="${page.pageNo == page.totalPages}">
				<a title="尾页" class="page_end_block_off"></a>
				<a title="下一页" class="page_next_block_off"></a>
			</c:if>
			<c:if test="${page.pageNo < page.totalPages}">
				<a title="尾页"
					onclick="javascript:pagination(${page.totalPages},${page.totalPages})"
					class="page_end_block"></a>
				<a title="下一页"
					onclick="javascript:pagination(parseInt('${page.pageNo}')+1,${page.totalPages})"
					class="page_next_block"></a>
			</c:if>

			

			<c:if test="${page.pageNo == 1}">
				<a title="上一页" class="page_prev_block_off"></a>
				<a title="首页" class="page_first_block_off"></a>
			</c:if>
			<c:if test="${page.pageNo > 1}">
				<a title="上一页"
					onclick="javascript:pagination(parseInt('${page.pageNo}')-1,${page.totalPages})"
					class="page_prev_block"></a>
				<a title="首页" onclick="javascript:pagination(1,${page.totalPages})"
					class="page_first_block"></a>
			</c:if>
		</div>
	</c:if>
</div>