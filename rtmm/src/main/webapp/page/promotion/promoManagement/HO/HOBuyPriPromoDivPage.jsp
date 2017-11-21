<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/common.js?t=1" charset="utf-8"></script>
<script type="text/javascript">
	$(function () {
		$(".tr_close").die("click");
		$(".tr_open").die("click");
		$(".single_tb .ptr:even").addClass("default_bg");
		$(".btable_div").scroll(function () {
		    var left = $(this).scrollLeft();
		    $(".htable_div").scrollLeft(left);
		});
	});
	function pagination(currentPage) {
		$("#pageNo").val(currentPage);
		$("#pageSizeHidden").val($('#pageSize').val());
		pageQuery();
	}
</script>
<style type="text/css">
    .temp {
        width:150px;
    }
    .trSpecial table tr {
        border-bottom:0;
    }
    .btable_div .innerTb {
    	width: 99%;
	}
</style>

<div class="btable_div" style="height: 509px;">
    <table  class="single_tb w100"><!--multi_tb为多选 width:1001px;-->
       <c:forEach items="${page.result }" var="HOPricPromVO" varStatus="num">
			<tr ondblclick="onDblClickRow()" class="ptr pricPromTr_click" >
				<td class="align_center tr_close" style="width:30px;" onclick="showChildTr(this)"></td>
                <td style="width:121px;">${HOPricPromVO.promNo }</td>
                <td style="width:281px;">${HOPricPromVO.subjName }</td>
                <td style="width:191px;">${HOPricPromVO.catlgId }-${HOPricPromVO.catlgName }</td>
                <td style="width:121px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${HOPricPromVO.buyBeginDate }" /></td>
                <td style="width:121px;"><fmt:formatDate pattern="yyyy-MM-dd" value="${HOPricPromVO.buyEndDate }" /></td>
                <td style="width:81px;">${HOPricPromVO.promDays }</td>
                <td >&nbsp;</td>
			</tr>
		</c:forEach>
   </table>
</div>
<div class="paging">
	<div class="fl_left">
		<!-- 第 -->
		${((page.pageNo-1)*(page.pageSize)+1)}-${((page.pageNo)*(page.pageSize))}
		<!-- 项 -->
		项 &nbsp;&nbsp; 
		<span class="pageSizeBar"> |&nbsp; <!-- 每页显示  -->
			每页显示 <select name="pageSize" id="pageSize" onchange="pagination(${page.pageNo})">
				<option value="10"
					<c:if test="${page.pageSize == 10}">selected="selected"</c:if>>10</option>
				<option value="20"
					<c:if test="${page.pageSize == 20}">selected="selected"</c:if>>20</option>
				<option value="30"
					<c:if test="${page.pageSize == 30}">selected="selected"</c:if>>30</option>
			</select>  <!-- 项 --> 项
		</span>
	</div>
	<div class="fl_right page_list">
		<c:if test="${isEnd eq 0}">
			<a title="下一页" onclick="javascript:pagination(parseInt('${page.pageNo}')+1)" class="page_next_block rtA" ></a> 
		</c:if>
		<c:if test="${isEnd eq 1}">
			<a title="下一页" class="page_next_block_off rtA"></a> 
		</c:if>
		<a class="click_block">${(page.pageNo)}</a>
		<c:if test="${page.pageNo > 1}">
			<a title="上一页" onclick="javascript:pagination(parseInt('${page.pageNo}')-1)" class="page_prev_block"></a> 
		</c:if>
		<c:if test="${page.pageNo == 1}">
			<a title="上一页" class="page_prev_block_off"></a> 
		</c:if>
	</div>

</div>

