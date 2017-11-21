<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>


<select id="basicSelectRole" style="width: 90%; height: 22px;">
	<c:forEach items="${roleList }" var="roleLists">
		<option value="${roleLists.id }">${roleLists.name }</option>
	</c:forEach>
</select>