<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/contents.css" rel="Stylesheet" />
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/g_nr.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/dayEnd/dayEndMonitor.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/g_nr.js" type="text/javascript"></script>
<script>
$(function(){
	/*initiate the show status of dayEnd monitor.*/
	showListOrDetail();
});
</script>
<div id="nrMonitorMgmtList" style="display: none;">
	<%@ include file="/page/dayend/nr_Monitor_List.jsp"%>
</div>
<div id="nrMonitorMgmtDetail">
	<%@ include file="/page/dayend/nr_Monitor_Detail.jsp"%>
</div>

