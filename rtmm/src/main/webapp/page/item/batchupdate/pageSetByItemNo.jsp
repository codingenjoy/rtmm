<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	    top.jAlert('warning', '输入必须为整数','提示消息');
	    $("#goto_page").val("");
	    $("#goto_page").focus();
	    return;
	}else if (inputPage < 1 || inputPage > totalpage)
	{
		top.jAlert('warning', '跳转的页码不存在','提示消息');
		$("#goto_page").val("");
		$("#goto_page").focus();
		return;
	}else{
		pagination(inputPage);
	}
}
</script>
<div class="paging">
		<div class="fl_left">
		    该页显示${page.totalCount}项&nbsp;&nbsp;
		</div>
		<div class="fl_right page_list">
			<span class="fl_right" style="margin-right: 10px;">
				&nbsp;&nbsp;&nbsp;至第 <input name="pageNo" id="goto_page"
				class="page_no_input" maxlength="5" type="text" size="3"
				maxlength="5" onkeyup="this.value=this.value.replace(/\D/g,'')"
				onkeydown="if(event!== null && event.keyCode == 13) jumpPage(${page.pageNum});" />
				页
			</span> <input type="text" style="display: none;" maxlength="5">
			<c:if test="${page.pageNo == page.pageNum}">
				<a title="尾页" class="page_end_block_off"></a>
				<a title="下一页" class="page_next_block_off"></a>
			</c:if>
			<c:if test="${page.pageNo < page.pageNum}">
				<a title="尾页"
					onclick="javascript:pagination(${page.pageNum},${page.pageNum})"
					class="page_end_block"></a>
				<a title="下一页"
					onclick="javascript:pagination(parseInt('${page.pageNo}')+1,${page.pageNum})"
					class="page_next_block"></a>
			</c:if>

			<c:choose>
				<c:when test="${page.pageNum<=5}">
					<c:forEach begin="1" end="5" var="v">
						<c:choose>
							<c:when test="${page.pageNo==(6-v)}">
								<a title="${page.pageNo}" class="click_block">${page.pageNo}</a>
							</c:when>
							<c:otherwise>
								<c:if test="${(6-v)<=page.pageNum}">
									<a onclick="pagination(${(6-v)})">${(6-v)}</a>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${page.pageNo<5}">
							<c:choose>
								<c:when test="${page.pageNo==1}">
									<a class="click" onclick="pagination(${page.pageNum})">${page.pageNum}</a>&nbsp; 
									<a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(5)">5</a>
									<a class="click" onclick="pagination(4)">4</a>
									<a class="click" onclick="pagination(3)">3</a>
									<a class="click" onclick="pagination(2)">2</a>
									<a class="click_block">${(page.pageNo)}</a>
								</c:when>
								<c:when test="${page.pageNo==2}">
									<a class="click" onclick="pagination(${page.pageNum})">${page.pageNum}</a>&nbsp; 
									<a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(5)">5</a>
									<a class="click" onclick="pagination(4)">4</a>
									<a class="click" onclick="pagination(3)">3</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
								<c:when test="${page.pageNo==3}">
									<a class="click" onclick="pagination(${page.pageNum})">${page.pageNum}</a>&nbsp; 
									<a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(5)">5</a>
									<a class="click" onclick="pagination(4)">4</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(2)">2</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
								<c:when test="${page.pageNo==4}">
									<a class="click" onclick="pagination(${page.pageNum})">${page.pageNum}</a>&nbsp; 
									<a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(5)">5</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(3)">3</a>
									<a class="click" onclick="pagination(2)">2</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
							</c:choose>
						</c:when>
						<c:when
							test="${page.pageNo>=5 and (page.pageNo+5)<=page.pageNum}">
							<a class="click" onclick="pagination(${page.pageNum})">${page.pageNum}</a>&nbsp; 
							<a style="cursor: default;">...</a>
							<a class="click" onclick="pagination(${(page.pageNo+2)})">${(page.pageNo+2)}</a>
							<a class="click" onclick="pagination(${(page.pageNo+1)})">${(page.pageNo+1)}</a>
							<a class="click_block">${(page.pageNo)}</a>
							<a class="click" onclick="pagination(${(page.pageNo-1)})">${(page.pageNo-1)}</a>
							<a class="click" onclick="pagination(${(page.pageNo-2)})">${(page.pageNo-2)}</a>
							<a style="cursor: default;">...</a>
							<a class="click" onclick="pagination(1)">1</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${page.pageNo==page.pageNum}">
									<a class="click_block">${page.pageNo}</a>
									<a class="click" onclick="pagination(${(page.pageNo-1)})">${(page.pageNo-1)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-2)})">${(page.pageNo-2)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-3)})">${(page.pageNo-3)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-4)})">${(page.pageNo-4)}</a>

									<a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
								<c:when test="${page.pageNo==(page.pageNum-1)}">
									<a class="click" onclick="pagination(${page.pageNum})">${page.pageNum}</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-1)})">${(page.pageNo-1)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-2)})">${(page.pageNo-2)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-3)})">${(page.pageNo-3)}</a>
									<a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
								<c:when test="${page.pageNo==(page.pageNum-2)}">
									<a class="click" onclick="pagination(${page.pageNum})">${page.pageNum}</a>
									<a class="click" onclick="pagination(${(page.pageNo+1)})">${(page.pageNo+1)}</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-1)})">${(page.pageNo-1)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-2)})">${(page.pageNo-2)}</a>
									<a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
								<c:when test="${page.pageNo==(page.pageNum-3)}">
									<a class="click" onclick="pagination(${page.pageNum})">${page.pageNum}</a>
									<a class="click" onclick="pagination(${(page.pageNo+2)})">${(page.pageNo+2)}</a>
									<a class="click" onclick="pagination(${(page.pageNo+1)})">${(page.pageNo+1)}</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-1)})">${(page.pageNo-1)}</a>
									<a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
								<c:when test="${page.pageNo==(page.pageNum-4)}">
									<a class="click" onclick="pagination(${page.pageNum})">${page.pageNum}</a>
									<a class="click" onclick="pagination(${(page.pageNo+3)})">${(page.pageNo+3)}</a>
									<a class="click" onclick="pagination(${(page.pageNo+2)})">${(page.pageNo+2)}</a>
									<a class="click" onclick="pagination(${(page.pageNo+1)})">${(page.pageNo+1)}</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>

			<c:if test="${page.pageNo == 1}">
				<a title="上一页" class="page_prev_block_off"></a>
				<a title="首页" class="page_first_block_off"></a>
			</c:if>
			<c:if test="${page.pageNo > 1}">
				<a title="上一页"
					onclick="javascript:pagination(parseInt('${page.pageNo}')-1,${page.pageNum})"
					class="page_prev_block"></a>
				<a title="首页" onclick="javascript:pagination(1,${page.pageNum})"
					class="page_first_block"></a>
			</c:if>
		</div>
</div>