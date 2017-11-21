<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src='${ctx}/shared/js/easyUI/jquery.easyui.min.js'></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/window.css" rel="Stylesheet" />
<c:choose>
	<c:when test="${lang =='en'}">
		<script src='${ctx}/shared/js/easyUI/lang/easyui-lang-en.js'></script>
	</c:when>
	<c:otherwise>
		<script src='${ctx}/shared/js/easyUI/lang/easyui-lang-zh_CN.js'></script>
	</c:otherwise>
</c:choose>

