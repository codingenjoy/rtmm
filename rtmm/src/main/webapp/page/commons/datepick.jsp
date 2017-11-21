<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
	<c:when test="${lang =='en'}">
		<script src='${ctx}/shared/js/My97DatePicker/en_WdatePicker.js'></script>
	</c:when>
	<c:otherwise>
		<script src='${ctx}/shared/js/My97DatePicker/cn_WdatePicker.js'></script>
	</c:otherwise>
</c:choose>