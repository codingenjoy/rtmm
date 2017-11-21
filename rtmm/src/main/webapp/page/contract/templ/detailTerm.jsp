<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<c:forEach items="${tmplVO.tabList}" var="tabList">
	<div id="term-${tabList.tabId}" class="term">
	<c:forEach items="${tabList.termList}" var="termList" varStatus="num">
		<div class="item" onclick="changeAcc(this)">
	          <input type="text" class="inputText fl_left" style="width:50px;margin-left:30px;" value="${num.index+1}" readonly="readonly"/> 
	          <input type="text" class="inputText fl_left" style="width:110px;" value="${termList.termName}" readonly="readonly"/>
	          <input type="text" class="inputText fl_left longText" style="width:155px;" value="${termList.termEnName}" readonly="readonly"/>
	          <c:set value="${fn:split(termList.payMethdOptns,',')}" var="pay"></c:set>
	          <input type="text" class="inputText fl_left" style="width:100px;" readonly="readonly"
	          	value='<c:forEach items="${pay}" var="payMethod"><auchan:getDictValue mdgroup="CONTRACT_DETL_PAY_METHD" code="${payMethod}"/>;</c:forEach>'
	          />
	 		  <input type="text" class="inputText fl_left" style="width:60px;" value="<c:if test="${termList.fixDsplyInd==1}">${termList.fixDsplyInd}-是</c:if><c:if test="${termList.fixDsplyInd==0}">${termList.fixDsplyInd}-否</c:if>" readonly="readonly"/>
	          <input type="text" class="inputText fl_left" style="width:60px;" value="${termList.paperPageNo}" readonly="readonly"/>
	          <input name="termId" type="hidden" value="${termList.termId}">
     	</div>
	</c:forEach>
	</div>
</c:forEach>	
	          