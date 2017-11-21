<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	window.v_messages = '<auchan:i18n id="100000001"></auchan:i18n>'; //提示信息
	window.v_operationFail = '<auchan:i18n id="100000008"></auchan:i18n>'; //操作失败
	window.v_operationSuc = '<auchan:i18n id="100000007"></auchan:i18n>'; //操作成功
	window.v_confirm = '<auchan:i18n id="100000002"></auchan:i18n>'; //确认
	window.v_cancel = '<auchan:i18n id="100000003"></auchan:i18n>'; //取消
	window.pleaseSelect = '<auchan:i18n id="100000009"></auchan:i18n>'; //请选择
</script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${lang =='en'}">
		<script src="${ctx}/shared/js/jquery-alerts/jquery.alerts_en.js" type="text/javascript"></script>
	</c:when>
	<c:otherwise>
		<script src="${ctx}/shared/js/jquery-alerts/jquery.alerts_cn.js" type="text/javascript"></script>
	</c:otherwise>
</c:choose>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/js/jquery-alerts/jquery.alerts.css"/>