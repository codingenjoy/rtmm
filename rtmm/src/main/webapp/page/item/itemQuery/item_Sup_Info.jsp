<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize"value="${page.pageSize }" />
<div class="txm_info">
	<div class="txm_title">
		<span style="margin-left: 60px;">采购厂编</span>
		<span style="margin-left: 140px;">公司名称</span> 
		<span style="margin-left: 120px;">厂商货号</span>
		<span style="margin-left: 60px;">特殊进价税率</span>
	</div>
	<div class="sp_tb">
		<c:forEach items="${page.result}" var="supplierVO">
			<div class="ig">
				<input type="text" class="w17 inputText " value="${supplierVO.supNo }" readonly="readonly"/> 
				<input type="text" class="w35 inputText " value="${supplierVO.comName }" readonly="readonly"/> 
				<input type="text" class="w17 inputText " value="${supplierVO.supItemId }" readonly="readonly"/> 
				<input type="text" class="w17 inputText " value="${supplierVO.speclBuyVatVal }" readonly="readonly"/>%
			</div>
		</c:forEach>
	</div>
	<div class="paging">
		<jsp:include page="/page/commons/pageSet.jsp"></jsp:include>
	</div>
</div>