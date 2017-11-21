<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js"
	type="text/javascript"></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css"
	rel="Stylesheet" />
<script src="${ctx}/shared/js/rtmm.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/common.js" type="text/javascript"></script>
<%@ include file="/page/commons/loadding.jsp"%>
<%@ include file="/page/commons/jquery-alerts.jsp"%>
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/welcome.css" rel="Stylesheet" />
<jsp:include page="/page/commons/knockout.jsp" />
<%@ include file="/page/commons/zWindow.jsp"%>
<script src="${ctx}/shared/js/parameter/staff.js" type="text/javascript"></script>
<script>
	function confirm(jobFuncId, jobFuncName) {
		
		top.window.$.zWindow.close({
			'jobFuncId' : jobFuncId,
			'jobFuncName' : jobFuncName
		});
	}
	function cancel() {
		top.window.$.zWindow.close();
	}
</script>

<style type="text/css">
.Table_Panel {
	height: 320px;
	width: 440px;
	overflow: hidden;
	margin-top: 10px;
}

.Table_Panel td {
	height: 30px;
}

.item {
	height: 30px;
	line-height: 28px;
	cursor: pointer;
}

.item div {
	float: right;
	margin-right: 10px;
}

.item span {
	float: left;
	margin-left: 10px;
}

.item:hover,.item_on {
	/*background: url('../images/icon0401.png') no-repeat  -11px -476px;*/
	background: #3F9673;
}
</style>
<div class="Table_Panel">
	<div style="margin: 10px 0px 5px 5px; width: 430px">
		<div
			style="height: 403px; overflow-x: hidden; overflow-y: scroll; border-left: 2px solid #f9f9f9; border-bottom: 2px solid #f9f9f9;">
			<c:forEach items="${list}" var="vo">
				<div id="${vo.id}" class="item"
					onclick="confirm('${vo.id}','${vo.jobFunctionName}')">
					<span>${vo.jobFunctionName }</span>
					<div class="ListIcon"></div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
