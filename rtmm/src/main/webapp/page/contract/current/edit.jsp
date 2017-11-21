<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<c:if test="${not empty taskId}">
<script type="text/javascript" src="${ctx}/shared/js/contract/current/current.js"></script>
</c:if>

<%@ include file="/page/contract/detail_top.jsp"%>
<%@ include file="/page/contract/current/contract.jsp"%>
<c:if test="${not empty tabList}">
<%@ include file="/page/contract/current/accGroup.jsp"%>

<%-- 审批的合同 --%>
<c:if test="${not empty taskId}">
<c:forEach items="${tabList}" var="obj" varStatus="status">
<c:set var="termList" value="${obj.termList}"></c:set>
<c:set var="tabId" value="${obj.tabId}"></c:set>
<c:set var="tabType" value="${obj.tabType}"></c:set>
<%@ include file="/page/contract/current/contract_detail_Basic.jsp"%>
<%@ include file="/page/contract/current/contract_detail_Rebate.jsp"%>
<%@ include file="/page/contract/current/contract_detail_Phase.jsp"%>
</c:forEach>
</c:if>
</c:if>
<%-- 审批的合同 --%>

<script type="text/javascript">
<c:if test="${empty taskId && not empty tabList}">
getTabDetail('${tabList[0].tabId}','${tabList[0].tabType}','${contract.cntrtId}','${readonly}');
</c:if>

$(function(){
	$('.contract').hide();
	<c:if test="${not empty tabList}">
	$('#content_${tabList[0].tabId}').show();
	</c:if>
	<c:if test="${empty taskId}">
	<c:forEach items="${tabList}" var="obj" varStatus="status">
	<c:if test="${status.index gt 0}">
	getTabDetailHidden('${obj.tabId}','${obj.tabType}','${contract.cntrtId}');
	</c:if>
	</c:forEach>
	</c:if>
	
	showCreatePage = function(){return false;};
});
</script>


