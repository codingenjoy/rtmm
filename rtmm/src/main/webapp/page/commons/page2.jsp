<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<div class="paging">
	<c:if test="${ not empty page.result}">
		<div class="fl_left">
			第 ${((page.pageNo-1)*(page.pageSize)+1)}-${((page.pageNo)*(page.pageSize))} 项,共 ${page.totalCount } 项&nbsp;&nbsp;|&nbsp;每页显示 <select
				id="page_size_select" name="pageSize">
				<option value="10" <c:if test="${page.pageSize == 10 }">selected="selected"</c:if>>10</option>
				<option value="20" <c:if test="${page.pageSize == 20 }">selected="selected"</c:if>>20</option>
				<option value="30" <c:if test="${page.pageSize == 30 }">selected="selected"</c:if>>30</option>
			</select> 项
		</div>
		<div class="fl_right page_list" style="width:auto;">
			<div style="width:auto;" class="fl_left">
			<c:if test="${page.pageNo>1}">
				<a title="首页" onclick="jumpPage2(1)" class="page_first_block" style="float:left;"></a>
				<a title="上一页" onclick="jumpPage2(${page.pageNo-1})" class="page_prev_block" style="float:left;"></a>
			</c:if>
			<c:if test="${page.pageNo == 1}">
				<a title="首页" class="page_first_block_off" style="float:left;"></a>
				<a title="上一页" class="page_prev_block_off" style="float:left;"></a>
			</c:if>
			</div>
			<div style="width:auto;" class="fl_left">
			<c:choose>
				<c:when test="${page.totalPages<=5}">
					<c:forEach begin="1" end="5" var="v">
						<c:choose>
							<c:when test="${page.pageNo==v}">
								<a title="${page.pageNo}" class="click_block" style="float:left;">${page.pageNo}</a>
							</c:when>
							<c:otherwise>
								<c:if test="${v<=page.totalPages}">
									<a onclick="jumpPage2(${v})" style="float:left;">${v}</a>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:choose>
						<c:when test="${page.pageNo>1}">
							<c:forEach begin="${page.pageNo-1}" end="${page.pageNo+3}" var="v">
								<c:choose>
									<c:when test="${page.pageNo==v}">
										<a title="${page.pageNo}" class="click_block" style="float:left;">${page.pageNo}</a>
									</c:when>
									<c:otherwise>
										<c:if test="${v<=page.totalPages}">
											<a class="click" onclick="jumpPage2(${v})" style="float:left;">${v}</a>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${(page.pageNo+3)<page.totalPages}">
<a style="float:left;">...</a>&nbsp; <a class="click" onclick="jumpPage2(${page.totalPages})" style="float:left;">${page.totalPages}</a>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:forEach begin="${page.pageNo}" end="${page.pageNo+4}" var="v">
								<c:choose>
									<c:when test="${page.pageNo==v}">
										<a class="click_block" style="float:left;">${page.pageNo}</a>
									</c:when>
									<c:otherwise>
										<c:if test="${v<=page.totalPages}">
											<a class="click" onclick="jumpPage2(${v})" style="float:left;">${v}</a>
										</c:if>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${(page.pageNo+4)<page.totalPages}">
<a style="float:left;">...</a><a class="click" onclick="jumpPage2(${page.totalPages})" style="float:left;">${page.totalPages}</a>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
			</div>
			<div style="width:auto;" class="fl_left">
			<c:if test="${page.pageNo < page.totalPages }">
				<a onclick="jumpPage2(${page.nextPage})" style="float:left;" style="float:left;" title="下一页" class="page_next_block"></a>
				<a onclick="jumpPage2(${page.totalPages})" title="尾页" class="page_end_block"></a>
			</c:if>
			<c:if test="${page.pageNo == page.totalPages }">
				<a class="page_end_block_off" title="尾页"></a>
				<a class="page_next_block_off" title="下一页"></a>
			</c:if>
			</div>
			&nbsp;&nbsp;&nbsp;到第
			<input type="text"  id="goto_page" onkeyup="this.value=this.value.replace(/\D/g,'');" onblur="jumpPage2(this.value, ${page.totalPages });" class="page_no_input" maxlength="5">
			<input type="text" style="display:none;" maxlength="5">
			页
		</div>
		</c:if>
</div>
<input type="hidden" class="pageNo" name="pageNo" value="1">
<script>
var currEle;
document.onmousedown = function(e) {
	var e = e?e:event
	var d = e.srcElement || e.target;
	currEle = d;
}
/**
 * 通过form进行跳转,把page包含在form中
 * 跳转
 * @param 跳转的页号
 */
function jumpPage2(pageNo,totalPage) {
	var formEle = $(currEle).parents('form');
	if(totalPage){
		if(pageNo.length == 0 || isNaN(pageNo)) {
			pageNo = 1;
		} else if(parseInt(pageNo) > parseInt(totalPage)) {
			pageNo = totalPage;
		}
	}
	formEle.find('.pageNo').val(pageNo);
	if(pageNo!=''){
		formEle.submit();
	}
}
</script>