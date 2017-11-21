<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${defaultTitle }</title>
<meta name="keywords" content="${defaultKeyWords }" />
<meta name="description" content="${defaultDescription }" />
<meta name="author" content="${defaultKeyWords }" />
<meta http-equiv="pragma" content="no-cache"/>
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate"/> 
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.min.js" type="text/javascript"></script>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/G.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/rtmm.js"  type="text/javascript"></script>
<script src="${ctx}/shared/js/common.js" type="text/javascript"></script>
<%@ include file="/page/commons/easyui.jsp"%>
<%@ include file="/page/commons/loadding.jsp"%>
<%@ include file="/page/commons/jquery-alerts.jsp"%>
<%@ include file="/page/commons/datepick.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/welcome.css" rel="Stylesheet" />
<script type="text/javascript">
 	 function stopError() {
		return true;
	}
	window.onerror = stopError;  

	/* 屏蔽backspace、F5,F4为刷新 */
	document.onkeydown = function(e) {
		/* var ev = document.all ? window.event : e;
		ev.cancelBubble = true; */
		var e = e || window.event || arguments.callee.caller.arguments[0];
		var d = e.srcElement || e.target;
		if (e.keyCode && e.keyCode == 115) {
			e.keyCode=0;
			e.returnValue=false;
			$('#forwardForm').submit();
			return false;
		}
		if (e.keyCode && e.keyCode == 116) {
			e.keyCode=0;
			return false;
		}
		if (e && e.keyCode == 8) {
			if(d.tagName.toUpperCase() == 'INPUT' && d.readOnly == true){
				return false;
			}else if(d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA'){
				return true;	
			}else{
				return false;
			}
		}
	};
</script> 
</head>
<body>
	<div id="console" style="display: none"></div>
	<div class="TopMenu" id="top_menu">
		<jsp:include page="/page/commons/menu.jsp"></jsp:include>
	</div>
	<div id="content_body">
		<jsp:include page="/page/commons/lefthead.jsp"></jsp:include>
	</div>
</body>

</html>
