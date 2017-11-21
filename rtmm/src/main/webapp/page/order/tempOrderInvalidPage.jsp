<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style>
.order_item {
	display: inline-block;
	float: left;
	padding: 3px 20px;
	margin-left: 5px;
	margin-top: 1px;
	cursor: pointer;
}

.btable_checked .Icon-size1 {
	display: block;
	/* background: url("${ctx}/shared/themes/${theme}/images/choosed.png") 0 0 no-repeat;   */
	margin-left: 4px;
}

.error_import .choosed {
	display: block;
	float: left;
	width: 17px;
	height: 17px;
	/* background: url("${ctx}/shared/themes/${theme}/images/choosed.png") -20px 0 no-repeat; */
	margin-left: 4px;
	margin-top: 3px;
}
</style>

<div class="ig_top10 error_import">
	<div class="icol_text">错误条目数&nbsp;</div>
	<input id="failCount" type="text" class="inputText w5 fl_left" value="${page.totalCount }" />
	<div class="icol_text">&nbsp;&nbsp;错误原因&nbsp;</div>
	<select id="errorCode" class="w30 fl_left" onchange="pageQuery1()" value="${errorCode}">
		<option value="">请选择</option>
		<c:if test="${not empty errorList }">
			<c:forEach items="${errorList }" var="code">
				<option value="${code}" 
				<c:if test="${code == errorCode }">
					selected="selected" 
				</c:if>
				>
				<auchan:getDictValue code="${code }" showType="3" mdgroup="ORDERS_IMPORT_ERROR_INFO"></auchan:getDictValue></option>
			</c:forEach>
		</c:if>
	</select>
	<%-- 
	<auchan:select mdgroup="ORDERS_IMPORT_ERROR_INFO" _class="select1" id="errorCode" onchange="pageQuery1()" value="${errorCode}"/>
	 --%>
	<span class="choosed"></span>
	<!-- <div class="icol_text">&nbsp;验证全部</div> -->
</div>
<div class="htable_div error_import">
	<table>
		<thead>
			<tr>
				<!--<td><div class="t_cols align_center" style="width:30px;"><input type="checkbox" /></div></td>-->
				<td>
					<div class="t_cols" style="width: 85px;">
						店号
						<!--<div style="display:inline-block;width:10px;height:20px;"></div>-->
					</div>
				</td>
				<td>
					<div class="t_cols" style="width: 65px;">厂编</div>
				</td>
				<td>
					<div class="t_cols" style="width: 130px;">公司名称</div>
				</td>
				<td>
					<div class="t_cols" style="width: 65px;">货号</div>
				</td>
				<td>
					<div class="t_cols" style="width: 140px;">品名</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">订购数量</div>
				</td>
				<td>
					<div class="t_cols" style="width: 80px;">赠品数量</div>
				</td>
				<td>
					<div class="t_cols" style="width: 75px;">订货收货日</div>
				</td>
				<td>
					<div class="t_cols" style="width: 45px;">导入行号</div>
				</td>
				<td>
					<div class="t_cols" style="width: 205px;">错误原因</div>
				</td>
				<!-- <td>
					<div class="t_cols" style="width: 25px;">&nbsp;</div>
				</td> -->
				<td>
					<div style="width: 16px;">&nbsp;</div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<form id="orderInvalidForm">
	<div class="btable_div error_import" style="height: 439px;">
		<table class="single_tb w100">
			<c:forEach items="${page.result}" var="record">
				<tr>
					<td style="width: 86px;" title="${record.storeNo }-${record.storeName }">${record.storeNo }-${record.storeName }</td>
					<td style="width: 66px;" class="align_right"><span style="margin-right: 5px;">${record.supNo }</span></td>
					<td style="width: 131px;" title="${record.supName }">${record.supName }</td>
					<td style="width: 66px;" class="align_right"><span style="margin-right: 5px;">${record.itemNo }</span></td>
					<td style="width: 141px;" title="${record.itemName}">${record.itemName }</td>
					<td style="width: 81px;" class="align_right"><span style="margin-right: 5px;"><fmt:formatNumber value="${record.ordQty}"
								pattern="#.###" minFractionDigits="3" /></span></td>
					<td style="width: 81px;" class="align_right"><span style="margin-right: 5px;"><fmt:formatNumber value="${record.presOrdQty}"
								pattern="#.###" minFractionDigits="3" /></span></td>
					<td style="width: 76px;">${record.planRecptDate }</td>
					<td style="width: 46px;" class="align_right"><span style="margin-right: 5px;">${record.recordNum }</span></td>
					<td style="width: 206px;" class="align_left"
						title="<auchan:getDictValue code="${record.errorInfo }" showType="3" mdgroup="ORDERS_IMPORT_ERROR_INFO"></auchan:getDictValue>"><span
						class="longText"> <auchan:getDictValue code="${record.errorInfo }" showType="3" mdgroup="ORDERS_IMPORT_ERROR_INFO"></auchan:getDictValue>
					</span></td>
					<!-- <td style="width: 26px;">
					<span class="Icon-size1"></span>
				</td> -->
					<td style="width: auto">&nbsp;</td>
				</tr>
			</c:forEach>
		</table>
	</div>
	<div class="paging" id="invalidOrder"></div>
	<input type="hidden" name="pageSize" value="${page.pageSize}" /> <input type="hidden" name="pageNo" value="${page.pageNo}" /> <input type="hidden"
		name="processId" id="processId" value="${processId }" /> <input type="hidden" name="errorCode" />
	<%@ include file="/page/commons/paginator.jsp"%>
</form>


<script type="text/javascript">
	var p = new Paginator({
		totalItems : '${page.totalCount}',
		itemsPerPage : '${page.pageSize}',
		page : '${page.pageNo}',
		paginatorElem : 'invalidOrder',
		psConfigurable : [ 100, 200, 300 ],
		callback : function(pageNo, pageSize) {
			$("#orderInvalidForm input[name=pageNo]").val(pageNo);
			$("#orderInvalidForm input[name=pageSize]").val(pageSize);
			$("#orderInvalidForm input[name=errorCode]").val($("#errorCode").val());
			pageQuery1();
		}
	});
	$(window).unload(function() {
		//0.清理资源;
		p.destroy();
	});
</script>