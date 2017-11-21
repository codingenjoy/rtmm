<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<c:if test="${page.totalCount!=0}">
<c:forEach items="${page.result}" var="data">
<div class="ig" style="margin-top: 5px;">
	<input type="checkbox" class="isCheck" name="itemBulkEditCheck"/>
	<input class="inputText twoinput20 w15 Black itemNoList" id="itemNo" type="text" value="${data.itemNo}" readonly="readonly" />
	<input class="inputText twoinput20 w35 Black" type="text" value="${data.itemName}" readonly="readonly" />
	<input class="inputText twoinput20 w15 Black" type="text" value="+getDictValue('ITEM_BASIC_STATUS','${data.status }')" readonly="readonly" />
	<input class="inputText twoinput20 w20 Black" type="text" value="${data.buyVatNo}" readonly="readonly" />
</div>
</c:forEach>
 </c:if> 
 