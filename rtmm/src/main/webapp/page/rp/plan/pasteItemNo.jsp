<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<script>

function save(){
	var validItems=addPromUnitNoAndBuyPriceList();
	if (!validItems){ return;}
	closePopupWin();
	batchPasteItemNo(validItems);
}

//validate the format of the promUnitNo and the promBuyPrice.
function addPromUnitNoAndBuyPriceList(){
	var validItems = [];
	var errorMsg = "";
	var validMsg = "";
	var inputListStr=$.trim($('#inputList').val())=='请输入货号,格式"货号"'?'':$.trim($('#inputList').val());
	if(!inputListStr){
		jWarningAlert('请输入货号！');
		return false;
	}
	var lines = inputListStr.split('\n');
   //circulate all lines and get the valid lines and the error lines.
	$.each(lines, function(index, value){
		if ($.trim(value)){
			var oneItemInfo = value.split(value.match(/\s+/));
			if (!(/^\d+$/).test(value)){
				errorMsg += value+'\n';
				return true;
			}
			var unitNoVal = $.trim(oneItemInfo[0]);
			if (isNoNum(unitNoVal,8)){
				errorMsg += value+'\n';
				return true;
			}
			validMsg += value+'\n';
			validItems.push(unitNoVal);
		}
	});
	if(validItems.length>50){
		jWarningAlert('货号最多输入50组！');
		return null;
	}
	if(errorMsg){
		$('#inputList').val("");
		$('#inputList').val(validMsg);
		$('#errorList').val("");
		$('#errorList').val("以下货号格式不正确:\n"+errorMsg);
	}
	//if having errors,opening popWin and confirming if continuing to add unitNo and promBuyPrice.
	if($.trim($('#errorList').val())){
		top.jConfirm('你确定忽视错误的货号继续添加吗','提示消息',function(ret){		
			if(ret){
				if (!validItems) return;
				closePopupWin();
				batchPasteItemNo(validItems);
			}
		});
		return null;
	}	
	return validItems;
}
</script>
<div class="Panel_top">
	<span>输入货号</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div class="p51_panel">
		<div>
			<textarea id="inputList" name="inputList" class="w90 txtarea"
				rows="3" placeholder='请输入货号,格式"货号"'></textarea>
			<textarea id="errorList" name="errorList" class="w90 errortxtarea msg"
				rows="2"></textarea>
		</div>
		<div class="msg" id="errorMsg"></div>
	</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1"
			onclick="save()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>
