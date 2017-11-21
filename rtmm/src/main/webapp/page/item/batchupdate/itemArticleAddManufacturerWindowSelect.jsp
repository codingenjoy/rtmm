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
<script type="text/javascript">
	$(function() {
		$("#AreaItemNum").keydown(function(event) {
			if (event.keyCode == 13) {
				var txtAreaItemNum = $("#AreaItemNum").val();
				var strs = $("#AreaItemNum").val().split("\n");
				var strLength = str.length;
				$.each(strs, function(index, val) {
					if ($.trim(val) != "") {
						if (val.substring(val.length - 1, val.length) != ";") {
							$("#AreaItemNum").val(val + "");
						}
					}
				});
			}
		});
		var cancelHidden = $("#cancelHidden").val();
		if (cancelHidden == "cancel") {
			$("#so_itemSpans").text("输入需要取消的货号");
		}
	});
</script>
<div class="Panel_top">
	<span id="so_itemSpans">输入需要新增的商品</span>
	<div class="PanelClose" onclick="closePopupWin()" onclick=""></div>
</div>
<div class="Table_Panel">
	<div class="p51_panel">
		<div>
			<textarea class="w90 txtarea" rows="5" id="txtAreaItemNum">${itemNo }</textarea>
			<input type="hidden" id="AreaItemNum" />
		</div>
		<div class="ig"></div>
		<div class="msg" id="bulkEditPasteError">
			<!-- *以下内容无此厂商或厂商格式有误。(38765498； 12467895) -->
		</div>
	</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="validateItemNo('manufacturer')">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>