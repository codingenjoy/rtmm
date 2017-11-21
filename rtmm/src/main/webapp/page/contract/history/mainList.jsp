<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<div class="Search Bar_on" style="display: none;">
	<!-- Bar_on-->
	<%@ include file="/page/contract/history/left.jsp"%>
</div>

<div class="Content list" style="width: 99%;">
	<%@ include file="/page/contract/history/list.jsp"%>
</div>

<script type="text/javascript">
	var refreshFlag = 0;
	enableDetailViewIcon();
	inputToInputIntNumber();
</script>