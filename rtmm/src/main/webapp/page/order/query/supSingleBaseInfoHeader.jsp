<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.paging .page_list {
	width: 340px;
}
</style>
<input type="hidden" id="totalCount" value="${page.totalCount }"/>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize" value="${page.pageSize }" />
<input type="hidden" name="catlgId" id="catlgId" value="${catlgId }" />
<div class="htable_div">
	<table>
		<thead>
			<tr>
				<td>
					<div class="t_cols" style="width: 80px;">厂编</div>
				</td>
				<td>
					<div class="t_cols" style="width: 440px;">公司名称</div>
				</td>
				<td>
					<div class="t_cols" style="width: 100px;">状态</div>
				</td>
			</tr>
		</thead>
	</table>
</div>
<div class="btable_div" style="height: 320px;">
	<table class="single_tb" id="supInfoList">
		<c:if test="${not empty page.result }">
			<c:forEach items="${page.result}" var="sup">
				<tr onclick="onClick('${sup.supNo}','${sup.comName}','${sup.comNo}','${sup.unifmNo}','${sup.supType}','${sup.cntrtType}','${sup.buyMethd}');" 
				ondblclick="onDbClick('${sup.supNo}','${sup.comName}','${sup.comNo}','${sup.unifmNo}','${sup.supType}','${sup.cntrtType}','${sup.buyMethd}');">
					<td>
						<div class="t_cols addSingleSup" style="width: 81px; text-align: right; border-right: 0px !important;">${sup.supNo}&nbsp;&nbsp;</div>
						<input type="hidden" name="supNo" value="${sup.supNo}">
					</td>
					<td>
						<div class="t_cols addSingleSup" style="width: 441px; border-right: 0px !important;">${sup.comName }</div>
						<input type="hidden" name="supName" value="${sup.comName}">
					</td>

					<td>
						<div class="t_cols addSingleSup" style="width: 100px; border-right: 0px !important;">
							<auchan:getDictValue mdgroup="SUPPLIER_STATUS" code="${sup.status}"></auchan:getDictValue>
						</div>
						<input type="hidden" name="status" value="${sup.status}">
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
</div>
<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>