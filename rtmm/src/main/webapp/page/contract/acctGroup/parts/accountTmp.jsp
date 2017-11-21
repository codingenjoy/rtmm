<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="ig">
	<input class="isChecks" type="checkbox" onclick="chooseSelectAll()"> 
	<input type="text" class="w30 inputText" name="acctId" maxlength=9 onchange="handleErrorInput(this)">
	<auchan:select4Vat name="vatNo" _class="w25" onchange="RmerrorInput(this)" />
	<!-- <select name="accCondValType" class="w25" onchange="RmerrorInput(this)">
		<option value="">请选择</option>
		<option value="A">A-金额</option>
		<option value="P">P-百分比</option>
		<option value="A,P">A,P-金额和百分比</option>
	</select> -->
	<auchan:select2 name="accCondValType" mdgroup="CONTRACT_COND_VAL_TYPE" _class="w25"  onchange="RmerrorInput(this)"/>
</div>


