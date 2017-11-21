<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ctx}/shared/js/jquery/jquery-1.7.1.js"
	type="text/javascript"></script>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/parameter/staff.js" type="text/javascript"
	defer="defer"></script>
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/default.css" rel="Stylesheet" />
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/iframeContent.css"
	rel="Stylesheet" />
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/tree.css"
	rel="Stylesheet" />
<script src="${ctx}/shared/js/jquery-zwindow/js/zWindow.js"
	type="text/javascript"></script>
<%@ include file="/page/commons/easyui.jsp"%>
<style type="text/css">
.Table_Panel {
	height: 190px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}

.PanelBtn {
	display: table;
}

.zwindow_pannel {
	z-index: 8012;
}

.zwindow_bg {
	z-index: 8010;
}
</style>
<script type="text/javascript" defer="defer">
	var chooseId = '';
	$.post(ctx + "/param/loadDeptTreeData", {
		'storeId' : '${storeId}'
	}, function(data) {
		// 初始化树
		$('#deptTree').tree({
			checkbox : false,
			data : data,
			onDblClick : function(node) {
				top.window.$.zWindow.close({
					'deptId' : node.id,
					'deptName' : node.text
				});
			}
		});
	}, "json");

	function cancel() {
		
		top.window.$.zWindow.close();
	}
	function confirm() {
		if($('#deptTree').tree('getSelected')==undefined){
			top.jAlert('warning','请先选择部门','提示消息');
		     return false;
		}
		var deptId = $('#deptTree').tree('getSelected').id;
		var deptName = $('#deptTree').tree('getSelected').text;
		top.window.$.zWindow.close({
			'deptId' : deptId,
			'deptName' : deptName
		});
	}
</script>
<div class="PanelTree"
	style="overflow: auto; overflow-x: hidden; width: 450px; height: 420px;">
	<ul id="deptTree" class="easyui-tree"
		style="margin-top: 5px; margin-left: 5px; height: 380px;">
	</ul>
</div>
<div class="Panel_footer" style="width: 450px;">
		<span class="PanelBtn1" onclick="confirm()">确定</span>
		<span class="PanelBtn2" onclick="cancel()">取消</span>
</div>
<div style="clear: both;"></div>
