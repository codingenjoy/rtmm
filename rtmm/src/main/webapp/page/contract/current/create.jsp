<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ include file="/page/contract/detail_top.jsp"%>
<%@ include file="/page/contract/current/contract.jsp"%>
<c:if test="${not empty tabId}">
<%@ include file="/page/contract/current/accGroup.jsp"%>
</c:if>
<script type="text/javascript">
<c:if test="${not empty tabId}">
	getTabDetail('${tabId}','${tabList[0].tabType}','${contract.cntrtId}','${readonly}');
</c:if>
$(function(){
	inputToInputDoubleNumberAndChkLen($('.contract:visible'));
	showTools26 = function(){return false};
});
</script>