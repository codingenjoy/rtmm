<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css" rel="Stylesheet" />
<style>
.tbx {
	height: 507px;
	overflow: auto;
	border-top: 1px solid #cccccc;
	border-bottom: 1px solid #cccccc;
}

.tbx td {
	height: 30px;
}

.tbx tr {
	cursor: pointer;
}

.tbx tr:hover {
	background: #3F9673;
}
</style>
<div class="SearchTopx">
	<span>组织架构</span>
</div>
<div class="line" style="width: 100%;"></div>
<div class="SearchTopx">
	店号&nbsp; <select class="PLeftPanelTitleText" id="storeList"
		style="width: 195px; margin-top: 3px; margin-left: 10px">
		<option value="">请选择</option>
		<c:forEach items="${stores}" var="store">
			<option value="${store.storeNo}">${store.storeNo}-${store.storeName}</option>
		</c:forEach>
	</select>
</div>
<div class="tbx">
	<ul id="deptTree"></ul>
</div>