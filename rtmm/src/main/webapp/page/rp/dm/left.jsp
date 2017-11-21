<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="SearchTop">
	<span>查询条件</span>
	<div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
</div>
<div class="line"></div>
<div class="SMiddle">
	<table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td class="ST_td1"><span>DM编号</span></td>
			<td><input name="rdmNo" class="w65 inputText enterBind" type="text" onfocus="removeError(this)" onblur="checkRdmNo(this)"/></td>
		</tr>

		<tr>
			<td><span>主题</span></td>
			<td><input name="rdmTopic" class="w85 inputText enterBind" type="text" onfocus="removeError(this)"  maxlength="60"/></td>
		</tr>

		<tr>
			<td><span>活动开始日期</span></td>
			<td><input id="rdmBeginDateBegin" name="rdmBeginDateBegin" class="Wdate w65 fl_left enterBind" type="text"
				onclick="WdatePicker({onpicked:function(){if(this.value>$dp.$('rdmBeginDateEnd').value){$dp.$('rdmBeginDateEnd').value='';$dp.$('rdmBeginDateEnd').focus();}}, isShowClear: false, readOnly: true })" />&nbsp;-</td>
		</tr>
		<tr>
			<td><span>&nbsp;</span></td>
			<td><input name="rdmBeginDateEnd" id="rdmBeginDateEnd" class="Wdate w65 fl_left enterBind" type="text"
				onclick="WdatePicker({ isShowClear: false, readOnly: true,minDate:'#F{$dp.$D(\'rdmBeginDateBegin\')}'})" /></td>
		</tr>
		<tr>
			<td><span>活动结束日期</span></td>
			<td><input id="rdmEndDateBegin" name="rdmEndDateBegin" class="Wdate w65 fl_left enterBind" type="text"
				onclick="WdatePicker({onpicked:function(){if(this.value>$dp.$('rdmEndDateEnd').value){$dp.$('rdmEndDateEnd').value='';$dp.$('rdmEndDateEnd').focus();}},  isShowClear: false, readOnly: true })" />&nbsp;-</td>
		</tr>
		<tr>
			<td><span>&nbsp;</span></td>
			<td><input name="rdmEndDateEnd" id="rdmEndDateEnd" class="Wdate w65 fl_left enterBind" type="text"
				onclick="WdatePicker({ isShowClear: false, readOnly: true,minDate:'#F{$dp.$D(\'rdmEndDateBegin\')}' })" /></td>
		</tr>
		
	</table>
</div>
<div class="line"></div>
<div class="SearchFooter">
	<div class="Icon-size1 Tools20" onclick="clearInput()"></div>
	<div class="Icon-size1 Tools6" onclick="searchFormSubmit()"></div>
</div>

