<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.paging .fl_left{
	margin-left: 9px;
}
.paging .page_list {
 	width: 300px;
}

</style>

<script type="text/javascript">
	$(document).ready(function() {
		$(".btable_div").scroll(function() {
			var left = $(this).scrollLeft();
			$(".htable_div").scrollLeft(left);
		});
	});
	function pageQuery(){
		querySupplier();
	}

</script>


<div id="supplierList">
	<div class="Panel_top">
		<span>选择厂商</span>
		<div class="PanelClose" style="margin-right: 0;"
			onclick="closePopupWin()"></div>
	</div>
	<div class="Table_Panel" style="height: 450px;">
		<div style="height: 30px; background: #CCC;">
				<div class="Icon-div">
					<input type="text" class="IS_input" id="searchSup" placeholder="输入厂编或厂商名称查询(支持厂商名称模糊查询)"/>
					<div class="cbankIcon" onclick="querySupplier()"></div>
				</div>
		</div>
		<input type="hidden" name="itemNo" id="itemNo" value="${itemNo }" />
		<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
		<div class="htable_div">
			<table>
				<thead>
					<tr>
						<td><div class="t_cols" style="width: 100px;">厂商</div></td>
						<td><div class="t_cols" style="width: 400px;">厂商名称</div></td>
						<td><div class="t_cols" style="width: 100px;">状态</div></td>
						<td><div style="width: 16px;">&nbsp;</div></td>
					</tr>
				</thead>
			</table>
		</div>
		<div class="btable_div" style="height: 350px;">
			<table class="single_tb w100">
				<c:if test="${not empty page.result }">
					<c:forEach items="${page.result}" var="supplier">
						<tr ondblclick="chooseSup()">
							<td style="width: 100px;" class="align_right"><span
								id="supNo" style="margin-right: 5px;">${supplier.supNo }</span></td>
							<td id="comName" style="width: 400px;">${supplier.comName}</td>
							<td id="supStatus" style="width: 100px;"><auchan:getDictValue code="${supplier.status}" mdgroup="SUP_STORE_SEC_INFO_STATUS"></auchan:getDictValue></td>
							<td style="width: auto">&nbsp;</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
		</div>
		<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="chooseSup()">确定</div>
			<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
		</div>
	</div>
</div>
