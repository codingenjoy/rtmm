<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript" src="${ctx}/shared/js/promotion/periodsToTheTopic.js" charset="utf-8"></script>
<script type="text/javascript">
$(".btable_div").scroll(function () {
    var left = $(this).scrollLeft();
    //alert(left);
    $(".htable_div").scrollLeft(left);
});
</script>
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td>
					<div class="t_cols align_center" style="width: 50px;"></div>
				</td>
				<td>
					<div class="t_cols align_center" style="width: 81px;">档期</div>
				</td>
				<td>
					<div class="t_cols align_center" style="width: 227px;">主题</div>
				</td>
				<td>
					<div class="t_cols align_center" style="width: 121px;">开始日</div>
				</td>
				<td>
					<div class="t_cols align_center" style="width: 121px;">结束日</div>
				</td>
				<td>
					<div class="t_cols align_center" style="width: 122px;">计划起日</div>
				</td>
				<td>
					<div class="t_cols align_center" style="width: 121px;">计划迄日</div>
				</td>
				<td>
					<div class="t_cols align_center" style="width: 101px;">套系</div>
				</td>
				<td>
					<div class="t_cols align_center"
						style="width: 71px; border-right: 0;">上档中</div>
				</td>
				<td>
					<div style="width: 16px;">&nbsp;</div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<c:if test="${ not empty page.result}">
	<div class="btable_div" style="height: 510px;">
		<table class="single_tb w100">
			<!--multi_tb为多选 width:1001px;-->
			<c:forEach items="${page.result }" var="promThemeVO">
				<tr class="promotionTable" style="color: #ff6a00">
					<td class="align_center tr_close" style="width: 48px;"></td>
					<td style="width: 82px;">${promThemeVO.promNo }</td>
					<td style="width: 228px;">${promThemeVO.subjName }</td>
					<td style="width: 121px;">
						<fmt:formatDate pattern="yyyy-MM-dd"
							value="${promThemeVO.promBeginDate }" />
					</td>
					<td style="width: 121px;">
						<fmt:formatDate pattern="yyyy-MM-dd"
							value="${promThemeVO.buyBeginDate }" />
					</td>
					<td style="width: 122px;">
						<fmt:formatDate pattern="yyyy-MM-dd"
							value="${promThemeVO.dmPlanBeginDate }" />
					</td>
					<td style="width: 122px;">
						<fmt:formatDate pattern="yyyy-MM-dd"
							value="${promThemeVO.dmPriceAvailDate }" />
					</td>
					<td style="width: 102px;">${promThemeVO.promSubjId }-${promThemeVO.grpTypeName }</td>
					<td style="width: 50px;">${promThemeVO.promNo }</td>
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>

			<!-- 		<tr class="trSpecial Bar_off" style="height: auto;">
			<td class="align_center" style="width: 30px;"></td>
			<td colspan="9" style="white-space: normal;">
				<div class="htable_div" style="height: 30px;">
					<table>
						<thead>
							<tr style="background: none; color: #333;">
								<td>
									<div class="t_cols align_center" style="width: 70px;">
										编号
										<div style="display:inline-block;width:10px;height:20px;"></div>
									</div>
								</td>
								<td>
									<div class="t_cols align_center" style="width: 232px;">主题</div>
								</td>
								<td>
									<div class="t_cols align_center" style="width: 80px;">渠道</div>
								</td>
								<td>
									<div class="t_cols align_center" style="width: 262px;">参与组别</div>
								</td>
								<td>
									<div style="width: 16px;">&nbsp;</div>
								</td>
							</tr>
						</thead>
					</table>
				</div>
				<div class="btable_div "
					style="height: 60px; overflow: auto; text-align: center;">
					<table width="100%">
						<tr>
							<td style="width: 71px;">data1</td>
							<td style="width: 233px;">data2</td>
							<td style="width: 81px;">data3</td>
							<td style="width: 263px;">data4</td>
							<td style="width: auto;">&nbsp;</td>
						</tr>
						<tr>
							<td>data1</td>
							<td>data2</td>
							<td>data3</td>
							<td>data4</td>
							<td style="width: auto;">&nbsp;</td>
						</tr>
					</table>
				</div>
			</td>
		</tr> -->
		</table>
	</div>
	<div class="paging">
		<%-- <jsp:include page="/page/commons/pageSet.jsp"></jsp:include> --%>

		<div class="fl_left">
			第
			${((page.pageNo-1)*(page.pageSize)+1)}-${((page.pageNo)*(page.pageSize))}
			项,共 ${page.totalCount } 项&nbsp;&nbsp;|&nbsp;每页显示 <select>
				<option value="10"
					<c:if test="${page.pageSize == 10 }">selected="selected"</c:if>>10</option>
				<option value="20"
					<c:if test="${page.pageSize == 20 }">selected="selected"</c:if>
					selected="selected">20</option>
				<option value="30"
					<c:if test="${page.pageSize == 30 }">selected="selected"</c:if>>30</option>
			</select> 项
		</div>
		<div class="fl_right page_list">
			<span class="fl_right" style="margin-right: 10px;">&nbsp;&nbsp;&nbsp;到第
				<input name="pageNo" id="goto_page" class="page_no_input"
					maxlength="5" type="text" /> 页 <input value="go" type="button" />
			</span>
			<a class="page_end_block" title="尾页"></a>
			<a class="page_next_block" title="下一页"></a>
			<c:choose>
				<c:when test="${page.pageNo < page.totalPages }">
					<a title="首页" onclick="jumpPage(1)" class="page_first_block"
						style="float: left;"></a>
					<a title="上一页" onclick="jumpPage(${page.pageNo-1})"
						class="page_prev_block" style="float: left;"></a>
					<a onclick="jumpPage(${page.nextPage})" style="float: left;"
						tyle="float:left;" title="下一页" class="page_next_block"></a>
					<a onclick="jumpPage(${page.totalPages})" title="尾页"
						class="page_end_block"></a>
				</c:when>
				<c:otherwise>
					<a class="page_end_block" title="尾页"></a>
					<a class="page_next_block" title="下一页"></a>
				</c:otherwise>
			</c:choose>
			<a title="6" class="num">999999</a>
			<a style="cursor: default;">...</a>
			<a title="2" class="num">3</a>
			<a title="2" class="num">2</a>
			<a title="1" class="num">1</a>

			<c:choose>
				<c:when test="${page.pageNo>1}">
					<a title="首页" onclick="jumpPage(1)" class="page_first_block"
						style="float: left;"></a>
					<a title="上一页" onclick="jumpPage(${page.pageNo-1})"
						class="page_prev_block" style="float: left;"></a>
				</c:when>
				<c:otherwise>
					<a title="上一页" class="page_prev_block_off"></a>
					<a title="首页" class="page_first_block_off"></a>
				</c:otherwise>
			</c:choose>

		</div>
	</div>
</c:if>