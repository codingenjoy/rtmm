<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<c:forEach items="${tmplVO.tabList}" var="tabList">
	<c:forEach items="${tabList.termList}" var="termList">
		<div id="acc-${termList.termId}" class="term">
			<c:forEach items="${termList.acctList}" var="acct" varStatus="num">
				<div class="item">
					<input type="text" class="inputText fl_left" style="width: 50px; margin-left: 30px;" value="${num.index+1}" readonly="readonly"/>
					<input type="text" class="inputText fl_left" style="width: 90px;" value="${acct.grpAcctId}" readonly="readonly"/> 
					<input type="text" class="inputText fl_left" style="width: 90px;" value="${acct.grpAcctName}" readonly="readonly"/>
				</div>
			</c:forEach>
		</div>
	</c:forEach>
</c:forEach>
