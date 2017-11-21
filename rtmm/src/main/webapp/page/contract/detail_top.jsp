<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="CInfo">
<!-- 无数据不显示创建信息 -->
<c:if test="${not empty auditInfoVO}">
<!-- 无分页信息,不显示这部分信息 -->
<c:if test="${not empty auditInfoVO.totalRow && not empty auditInfoVO.curRow}">
	<span>项</span>
	<span>${auditInfoVO.totalRow}</span>
	<span>/</span>
	<span>${auditInfoVO.curRow}</span>
	<span>第</span>
	<span>|</span>
</c:if>
	<span><auchan:getStuffName value="${auditInfoVO.chngBy}"/></span>
	<span>修改人</span>
	<span><fmt:formatDate pattern="yyyy-MM-dd" value='${auditInfoVO.chngDate}' /></span>
	<span>修改日期</span>
	<span><auchan:getStuffName value="${auditInfoVO.creatBy}"/></span>
	<span>建档人</span>
	<span><fmt:formatDate pattern="yyyy-MM-dd" value="${auditInfoVO.creatDate}" /></span>
	<span>创建日期</span>
</c:if>
</div>