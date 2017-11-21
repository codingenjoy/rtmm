<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tld/auchan" prefix="auchan"%>
<%
/**
*最外端的"<div class="item supplerItem clone">"元素，不属于模板内容；
*但是必须存在，因为它起着承接DOM节点的作用.
*强制要求：模板内容不允许出现任何注释。
<div class="iconPut w8 fl_left">
<input type="hidden" name="oUnitNo" id="oUnitNo" /> 
<input class="w74 unitNo" type="text" id="unitNo" name="unitNo" onkeydown="enterUnitNoShow(event,this)" onblur="doLoadOnePromUnit(this)"/>
<div class="ListWin showUnitWin" onclick="doChooseOnePromUnitNo(this)"></div>
</div>

**/
%>
<div class="item supplerItem clone" onclick="doOnPromUnitSelected(this)">
	<auchan:select mdgroup="PROM_UNIT_BY_ST_UNIT_TYPE" iscaption="0"
		_class="w8 first_ztdb fl_left unitTypeChange" name="unitType"
		onchange="doOnUnitTypeChanged(this)"/>
	<div class="iconPut w8 fl_left">
		<input class="w74 unitNo" type="text" name="unitNo" onkeydown="enterUnitNoShow(event,this)" onblur="doLoadOnePromUnit(this)"/>
		<div class="ListWin showUnitWin" onclick="doChooseOnePromUnitNo(this)"></div>
	</div>
	<input type="text" class="inputText w17 fl_left Black" readonly="readonly" name="promUnitName" /> 
	<input type="text" class="inputText w7 fl_left " maxlength=10 
		onafterpaste="alert();if(isNaN(value)) execCommand('undo')" onkeypress="doCheckOnPromBuyPriceKeyin(event, this)" onblur="doUnitLevelBuyPriceChange(this)" /> 
	<input type="text" class="inputText w7 fl_left " maxlength=8 
		onafterpaste="if(isNaN(value)) execCommand('undo')" onkeypress="doCheckOnPromSellPriceKeyin(event, this)" onblur="doUnitLevelSellPriceChange(this)" />
	<div class="listIcon fl_left"></div>
	<div class="pstb_del" onclick="doDeletePromUnit(this)"></div>
</div>