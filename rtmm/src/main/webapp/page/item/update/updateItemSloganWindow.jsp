<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.Panel {
	width: 500px;
}

.Table_Panel {
	height: 350px;
	overflow: hidden;
}

.zz_11 {
	margin-left: 50px;
}

.zz_12 {
	margin-left: 100px;
}

.zz_13 {
	margin-left: 180px;
}
</style>
<script type="text/javascript">
	$(function(){
		searchItemSlogan();
	});
</script>
<div class="Panel_top">
	<span>修改广告语</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div class="create3_p">
		<div class="zz_1">
			<span class="zz_11">编号</span><span class="zz_12">中文</span> <span class="zz_13">英文</span>
		</div>
		<div class="create3_zz_2 fzcsgl" id="itemBarDiv" >
		</div>
		<div class="ig">
			<input type="checkbox" class="sp_icon1 isCheckAllsItem" />
			<div class="Icon-size2 Tools10 sp_icon2 deleteCheckedsItem"></div>
			<div class="Icon-size2 Line-1 sp_icon3 "></div>
			<div class="Icon-size2 Tools11 sp_icon4" onclick="addItemSlogan()"></div>
		</div>
	</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="saveSelectSlogan()">保存</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>