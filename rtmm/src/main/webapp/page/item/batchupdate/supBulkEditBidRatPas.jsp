<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<jsp:include page="/page/commons/knockout.jsp" />
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
		var itemNos = '${itemNos}';
		if ( itemNos != null || itemNos != undefined ){
			$('#itemNoTextArea').text(itemNos.replace(/,/g, ";"));
		}
	});

	function validateInput() {
		//	viewModel.save();
		var flag = true;
		var items;
		var itemNoRule = /^\d{1,8}$/;
		var errMsg = "";
		
		var itemNos = $('#itemNoTextArea').val();
		if (itemNos.substring(itemNos.length,itemNos.length-1) == ";") {
			itemNos = itemNos.substring(0,itemNos.length-1);
		}
		itemNos=itemNos.replace(/[\n]/ig,';').replace(/;+/g, ';').replace(/\s+/g,"").replace(/;/g,',');
		
		
		if (itemNos != "" ){
			items = itemNos.split(",");
			$.each(items, function(index, item){
				// 檢查貨號是否都為數字
				if (! itemNoRule.test(item)){
					errMsg = errMsg + item + "; " ;
					flag = false;
				}
			});
			if (!flag){
				errMsg = "以下內容无此货号或格式有误 (" + errMsg + ")";
			}
			
			// 檢查是否有超過 50個貨號
			if ((items.length)-1 >50){
				errMsg = errMsg + ", 货号不能超过50个";
				flag = false;
			}
		}else{
			errMsg = "请输入货号, 并以分号区隔";
			flag = false;
		}
		
		// 前面格式都OK了, 再檢查貨號是否屬於該廠商
		if (flag){
			// 檢查貨號是否屬於該廠商
			$.ajax({
				async : false,
				url : ctx + '/item/batchupdate/validateSupItemNo',
				type : 'POST',
				data : {
					'supNo' : '${supNo}',
					'itemNoString' : itemNos
				},
				success : function(response) {
					if (response != "") {
						errMsg = "以下货号不属于该厂商 (" + response + ")";
						$('#itemNoTextArea').addClass("errorInput");
						errMsg=errMsg.substring(0,errMsg.lastIndexOf(';'));
						$('#errMsg').text(errMsg+")");
					}
					else{
						addSupItems("paste",'${supNo}');
					}
				},
			});
			
		}else{
			$('#itemNoTextArea').addClass("errorInput");
			$('#errMsg').text(errMsg);
		}

	}
</script>

<div class="Panel_top">
	<span>输入需要修改的商品</span>
	<div class="PanelClose" onclick="closePopupWin()" onclick=""></div>
</div>
<div class="Table_Panel">
	<div class="p51_panel">
		<div>
			<textarea class="w90 txtarea" rows="5" id="itemNoTextArea"></textarea>
		</div>
		<div class="ig"></div>
		<div class="msg">
			<font color="red" id="errMsg">&nbsp;</font>
		</div>
	</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="validateInput()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>