<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.Panel {
	width: 635px;
}

.Table_Panel {
	height: 400px;
	overflow: hidden;
}

.iconPut {
	width: 20%;
	float: left;
	margin-left: 5px;
}

.txtarea {
	margin-left: 20px;
	height: 310px;
}

.msg {
	margin-left: 20px;
	color: #f00;
}
</style>
<div class="Panel_top">
	<span>输入需要修改的厂商</span>
	<div class="PanelClose" onclick="closePopupWin()" onclick=""></div>
</div>
<div class="Table_Panel">
	<div class="p51_panel">
		<div>
			<textarea class="w90 txtarea" rows="5" id="txtAreaItemNum"></textarea>
		</div>
		<div class="ig"></div>
		<div class="msg" id="bulkEditPasteError">
			*以下内容无此货号或货号格式有误。(38765498； 12467895)</div>
	</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="item">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>