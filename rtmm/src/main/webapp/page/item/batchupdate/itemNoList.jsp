<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<c:if test="${page.totalCount!=0}">
<c:forEach items="${page.result}" var="data">
<div class="ig" style="margin-top: 5px;">
	<input type="checkbox" class="fl_left isCheck" name="itemBulkEditCheck"/>
	<input class="inputText twoinput20 w20 Black itemNoList" type="text" value="${data.itemNo}"/>
	<input class="inputText twoinput20 w50 Black" type="text" value="${data.itemName}"/>
	<input class="inputText twoinput20 w20 Black" type="text" value="${data.itemName}"/>
</div>
</c:forEach>
 </c:if> 