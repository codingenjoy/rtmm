<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.Table_Panel1 {
	height: 200px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">

	$(function() {

		var catlgName = $('#secAttrSecNo').val() + "-" + $('#secAttrSecName').val();
		var secAttrSeqName = $('.item_on2 > #seqNo').text() + "-" + $('.item_on2 > #secAttrName').text() ;

		$('#valCatlgId').val($('#secAttrSecNo').val());
		$('#valSecAttrSeqNo').val($('.item_on2 > #seqNo').text());
		$('#valCatlgName').val(catlgName);
		$('#valSecAttrSeqName').val(secAttrSeqName);

		if ('${mode}' == 'UPDATE') {
			$('.Panel_top > span').text("修改课别属性");
			var secAttrValNo = $.trim($('#attrValList').find('.btable_checked').find('#secAttrValNo').text());
			var secAttrValName = $.trim($('#attrValList').find('.btable_checked').find('#secAttrValName').text());
			var secAttrId = $.trim($('#attrValList').find('.btable_checked').find('#secAttrId').text());
			$('#valSecAttrValNo').val(secAttrValNo);
			$('#valSecAttrValName').val(secAttrValName);
			$('#secAttrId').val(secAttrId);
			$('#prSecAttrValName').val(secAttrValName);
		}

	});
</script>
<div class="Panel_top">
	<span><auchan:i18n id="101005011"></auchan:i18n></span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel1">
	<form action="" id="ed_secAttr">
		<input id="valCatlgId" type="hidden" />
		<input id="valSecAttrSeqNo" type="hidden" />
		<input id="prSecAttrValName" type="hidden" />
		<table class="CM_table">
			<tr>
				<td><span>*&nbsp;<auchan:i18n id="101005002"></auchan:i18n></span></td>
				<td><input id="valCatlgName" name="catlgName" type="text" class="inputText w35 Black" title="数字格式" maxlength="6"
					onfocus="$(this).removeClass('errorInput')" readonly="readonly" /></td>
			</tr>
			<tr>
				<td><span>*&nbsp;<auchan:i18n id="101005001"></auchan:i18n></span></td>
				<td><input id="valSecAttrSeqName" name="secAttrSeqName" type="text" class="inputText w35 Black" title="数字格式" maxlength="6"
					onfocus="$(this).removeClass('errorInput')" readonly="readonly" /></td>
			</tr>
			<tr>
				<td><span><auchan:i18n id="101005010"></auchan:i18n></span></td>
				<td><input id="valSecAttrValNo" name="secAttrValNo" type="text" class="inputText w35 Black" title="数字格式" maxlength="6"
					onfocus="$(this).removeClass('errorInput')" readonly="readonly" /></td>
			</tr>
			<tr>
				<td><span>*&nbsp;<auchan:i18n id="101005008"></auchan:i18n></span></td>
				<td><input id="valSecAttrValName" name="secAttrValName" type="text" title="请输入对应属性值中文描述" class="inputText w35" maxlength="10"
					onfocus="$(this).removeClass('errorInput')" /></td>
			</tr>
			<input id="secAttrId" type="hidden">
		</table>
	</form>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="saveSecAttrVal()"><auchan:i18n id="100000004"></auchan:i18n></div>
		<div class="PanelBtn2" onclick="closePopupWin()"><auchan:i18n id="100000003"></auchan:i18n></div>
	</div>
</div>
