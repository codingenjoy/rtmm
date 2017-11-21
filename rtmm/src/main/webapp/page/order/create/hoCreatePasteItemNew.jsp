<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.Panel {
	width: 635px;
}
.Table_Panel {
	height: 350px;
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
.txtarea {
   height: 250px;
}
.errortxtarea{
   margin-left: 19px;
   height: 60px;
   margin-top: 1px;
}

</style>
<div class="Panel_top">
	<span>输入新增的订单商品</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div class="p51_panel">
		<div>
			<textarea id="orderList" name="orderList" class="w90 txtarea"
				rows="3" placeholder="请输入正确的商品号"></textarea>
			<textarea id="errorOrderList" name="errorOrderList" class="w90 errortxtarea msg"
				rows="2"></textarea>
		</div>
		<div class="msg" id="errorMsg"></div>
	</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1"
			onclick="savePasteOrderItemList()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>
