<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<label>店号&nbsp; <select id=selectShop class="PLeftPanelTitleText" onchange="onHandleLoadDeptTreeWhenStoreChanged()">
		<c:forEach items="${stores }" var="oneStore">
			<option value="${oneStore.id}">${oneStore.id}-${oneStore.name}</option>
		</c:forEach>
</select>
</label>
<input type="image" src="${ctx}/shared/themes/${theme}/images/tool_10.gif" class="roleTitleAdd" onclick="myttTree3()" />
