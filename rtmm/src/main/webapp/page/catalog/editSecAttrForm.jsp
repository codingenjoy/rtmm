<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.Table_Panel1 {
	height: 100px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">
	$(function(){
		
		var catlgName = $.trim($('#secAttrSecNo').val()) + "-" + $('#secAttrSecName').val() ;
		var seqNo =  $.trim($('.item_on2 > #seqNo').text());
		var secAttrName =  $.trim($('.item_on2 > #secAttrName').text());
		$('#editcatlgId').val($.trim($('#secAttrSecNo').val()));
		$('#editcatlgName').val(catlgName);
		$('#editseqNo').val(seqNo);
		$('#editsecAttrValName').val(secAttrName);
		
	});
</script>
<div class="Panel_top">
	<span>修改课别属性</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel1">
	<form action="" id="ed_secAttr" >
		<table class="CM_table">
			<tr>
				<td>
					<span>*&nbsp;<auchan:i18n id="101005002"></auchan:i18n></span>
				</td>
				<td>
					<input id="editcatlgId" name="catlgId" type="hidden" />
					<input id="editcatlgName" name="catlgName" type="text" class="inputText w25 Black" title="数字格式" maxlength="6" onfocus="$(this).removeClass('errorInput')" readonly="readonly"  />
				</td>
			</tr>
			<tr>
				<td>
					<span>*&nbsp;<auchan:i18n id="101005003"></auchan:i18n></span>
				</td>
				<td>
					<input id="editseqNo" name="seqNo" type="text" class="inputText w25 Black" title="数字格式" maxlength="6" onfocus="$(this).removeClass('errorInput')" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td>
					<span>*&nbsp;<auchan:i18n id="101005004"></auchan:i18n></span>
				</td>
				<td>
					<input id="editsecAttrValName" name="secAttrValName" type="text" title="请输入属性中文名称" class="inputText w35"  onfocus="$(this).removeClass('errorInput')" />
				</td>
			</tr>
		</table>
	</form>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="saveSecAttr()"><auchan:i18n id="100000004"></auchan:i18n></div>
		<div class="PanelBtn2" onclick="closePopupWin()"><auchan:i18n id="100000003"></auchan:i18n></div>
	</div>
</div>
