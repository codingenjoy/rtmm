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
	    //top.jAlert('warning', '输入必须为整数','提示消息');
	    top.jAlert('warning', '<auchan:i18n id="100002011"/>','<auchan:i18n id="100000001"/>');
	    $("#goto_page").val("");
	    $("#goto_page").focus();
	    return;
	}else if (inputPage < 1 || inputPage > totalpage)
	{
		//top.jAlert('warning', '跳转的页码不存在','提示消息');
		top.jAlert('warning', '<auchan:i18n id="100002012"/>','<auchan:i18n id="100000001"/>');
		$("#goto_page").val("");
		$("#goto_page").focus();
		return;
	}else{
		pagination(inputPage);
	}
}
</script>
<div class="paging">
	<c:if test="${ not empty page.result}">
		<div class="fl_left">
			<!-- 第 -->
			<auchan:i18n id="100002001"/>
			${((page.pageNo-1)*(page.pageSize)+1)}-${((page.pageNo)*(page.pageSize))}
			<!-- 项 -->
			<auchan:i18n id="100002002"/>
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
			<span class="fl_right" style="margin-right: 10px;">
				&nbsp;&nbsp;&nbsp;
				<!-- 至第 -->
				<auchan:i18n id="100002007"/>
				<input name="pageNo" id="goto_page"
				class="page_no_input" maxlength="5" type="text" size="3"
				maxlength="5" onkeyup="this.value=this.value.replace(/\D/g,'')"
				onkeydown="if(event!== null && event.keyCode == 13) jumpPage(${page.totalPages});" />
				<!-- 页 -->
				<auchan:i18n id="100002008"/>
			</span>
			<input type="text" style="display:none;" maxlength="5">
			<!-- 
			<input value="跳转" type="button"
				onclick="jumpPage(${page.totalPages})" />
			-->
			<c:if test="${page.pageNo == page.totalPages}">
				<a title="<auchan:i18n id="100002010"/>" class="page_end_block_off"></a>
				<a title="<auchan:i18n id="100002006"/>" class="page_next_block_off"></a>
			</c:if>
			<c:if test="${page.pageNo < page.totalPages}">
				<a title="<auchan:i18n id="100002010"/>"
					onclick="javascript:pagination(${page.totalPages},${page.totalPages})"
					class="page_end_block"></a>
				<a title="<auchan:i18n id="100002006"/>"
					onclick="javascript:pagination(parseInt('${page.pageNo}')+1,${page.totalPages})"
					class="page_next_block"></a>
			</c:if>

			<c:choose>
				<c:when test="${page.totalPages<=5}">
					<c:forEach begin="1" end="5" var="v">
						<c:choose>
							<c:when test="${page.pageNo==(6-v)}">
								<a title="${page.pageNo}" class="click_block">${page.pageNo}</a>
							</c:when>
							<c:otherwise>
								<c:if test="${(6-v)<=page.totalPages}">
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
									<%-- <a class="click" onclick="pagination(${page.totalPages})">${page.totalPages}</a>&nbsp; 
									<a style="cursor: default;">...</a> --%>
									<a class="click" onclick="pagination(5)">5</a>
									<a class="click" onclick="pagination(4)">4</a>
									<a class="click" onclick="pagination(3)">3</a>
									<a class="click" onclick="pagination(2)">2</a>
									<a class="click_block">${(page.pageNo)}</a>
								</c:when>
								<c:when test="${page.pageNo==2}">
									<%-- <a class="click" onclick="pagination(${page.totalPages})">${page.totalPages}</a>&nbsp; 
									<a style="cursor: default;">...</a> --%>
									<a class="click" onclick="pagination(5)">5</a>
									<a class="click" onclick="pagination(4)">4</a>
									<a class="click" onclick="pagination(3)">3</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
								<c:when test="${page.pageNo==3}">
									<%-- <a class="click" onclick="pagination(${page.totalPages})">${page.totalPages}</a>&nbsp; 
									<a style="cursor: default;">...</a> --%>
									<a class="click" onclick="pagination(5)">5</a>
									<a class="click" onclick="pagination(4)">4</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(2)">2</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
								<c:when test="${page.pageNo==4}">
									<%-- <a class="click" onclick="pagination(${page.totalPages})">${page.totalPages}</a>&nbsp; 
									<a style="cursor: default;">...</a> --%>
									<a class="click" onclick="pagination(5)">5</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(3)">3</a>
									<a class="click" onclick="pagination(2)">2</a>
									<a class="click" onclick="pagination(1)">1</a>
								</c:when>
							</c:choose>
						</c:when>
						<c:when test="${page.pageNo>=5 and (page.pageNo+5)<=page.totalPages}">
							<%-- <a class="click" onclick="pagination(${page.totalPages})">${page.totalPages}</a>&nbsp; 
							<a style="cursor: default;">...</a> --%>
							<a class="click" onclick="pagination(${(page.pageNo+2)})">${(page.pageNo+2)}</a>
							<a class="click" onclick="pagination(${(page.pageNo+1)})">${(page.pageNo+1)}</a>
							<a class="click_block">${(page.pageNo)}</a>
							<a class="click" onclick="pagination(${(page.pageNo-1)})">${(page.pageNo-1)}</a>
							<a class="click" onclick="pagination(${(page.pageNo-2)})">${(page.pageNo-2)}</a>
							<!-- <a style="cursor: default;">...</a>
							<a class="click" onclick="pagination(1)">1</a> -->
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${page.pageNo==page.totalPages}">
									<a class="click_block">${page.pageNo}</a>
									<a class="click" onclick="pagination(${(page.pageNo-1)})">${(page.pageNo-1)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-2)})">${(page.pageNo-2)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-3)})">${(page.pageNo-3)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-4)})">${(page.pageNo-4)}</a>
									
									<!-- <a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(1)">1</a> -->
								</c:when>
								<c:when test="${page.pageNo==(page.totalPages-1)}">
									<a class="click" onclick="pagination(${page.totalPages})">${page.totalPages}</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-1)})">${(page.pageNo-1)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-2)})">${(page.pageNo-2)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-3)})">${(page.pageNo-3)}</a>
									<!-- <a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(1)">1</a> -->
								</c:when>
								<c:when test="${page.pageNo==(page.totalPages-2)}">
									<a class="click" onclick="pagination(${page.totalPages})">${page.totalPages}</a>
									<a class="click" onclick="pagination(${(page.pageNo+1)})">${(page.pageNo+1)}</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-1)})">${(page.pageNo-1)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-2)})">${(page.pageNo-2)}</a>
									<!-- <a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(1)">1</a> -->
								</c:when>
								<c:when test="${page.pageNo==(page.totalPages-3)}">
									<a class="click" onclick="pagination(${page.totalPages})">${page.totalPages}</a>
									<a class="click" onclick="pagination(${(page.pageNo+2)})">${(page.pageNo+2)}</a>
									<a class="click" onclick="pagination(${(page.pageNo+1)})">${(page.pageNo+1)}</a>
									<a class="click_block">${(page.pageNo)}</a>
									<a class="click" onclick="pagination(${(page.pageNo-1)})">${(page.pageNo-1)}</a>
									<!-- <a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(1)">1</a> -->
								</c:when>
								<c:when test="${page.pageNo==(page.totalPages-4)}">
									<a class="click" onclick="pagination(${page.totalPages})">${page.totalPages}</a>
									<a class="click" onclick="pagination(${(page.pageNo+3)})">${(page.pageNo+3)}</a>
									<a class="click" onclick="pagination(${(page.pageNo+2)})">${(page.pageNo+2)}</a>
									<a class="click" onclick="pagination(${(page.pageNo+1)})">${(page.pageNo+1)}</a>
									<a class="click_block">${(page.pageNo)}</a>
									<!-- <a style="cursor: default;">...</a>
									<a class="click" onclick="pagination(1)">1</a> -->
								</c:when>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>

			<c:if test="${page.pageNo == 1}">
				<a title="<auchan:i18n id="100002005"/>" class="page_prev_block_off"></a>
				<a title="<auchan:i18n id="100002009"/>" class="page_first_block_off"></a>
			</c:if>
			<c:if test="${page.pageNo > 1}">
				<a title="<auchan:i18n id="100002005"/>"
					onclick="javascript:pagination(parseInt('${page.pageNo}')-1,${page.totalPages})"
					class="page_prev_block"></a>
				<a title="<auchan:i18n id="100002009"/>" onclick="javascript:pagination(1,${page.totalPages})"
					class="page_first_block"></a>
			</c:if>
		</div>
	</c:if>
</div>