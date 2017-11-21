<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div style="display: none" class="cloneDiv">

	<div class="item" id="addPromCode_div" >
		<auchan:select mdgroup="PROM_UNIT_BY_ST_UNIT_TYPE"
			_class="w12_5 first_ztdb fl_left" name="unitType" value="0" onchange="unitTypeChange(this)"
			iscaption="0" />
		<div class="iconPut w10 fl_left">
			<input id="promUnitNo" name="promUnitNo"
				onkeydown="enterInUnitNo(event,this)" maxlength="8" onblur="promUnitNoBlur(this)" class="w71 type=" text"/> <input
				id="beforePromUnitNo" name="beforePromUnitNo" type="hidden" />
			<div class="ListWin showUnitWin" onclick="showUnitWin(this)"></div>
		</div>
		<input type="text" name="promUnitName" readonly="readonly"
			class="inputText w23 fl_left Black" /> <input type="text"
			class="inputText w10 fl_left Black promBuyPriceHead"
			disabled="disabled" onkeyup="promPriceKeyUp(this,event)" onblur="promBuyPriceHeadBlur(this)"/> <input type="text"
			class="inputText w10 fl_left Black promSellPriceHead"
			disabled="disabled" onkeyup="promPriceKeyUp(this,event)" onblur="promSalePriceHeadBlur(this)"/> <select name="promActvy" onchange="promActvyChange(this)"
			class="inputText w10 fl_left">
			<c:forEach items="${actvyList }" var="actvy">
				<option value="${actvy.metaCode }" title="${actvy.codeName }">${actvy.codeName }</option>
			</c:forEach>
		</select> <input type="text" name="promGiftHint" onchange="promGiftHintChange(this)" class="inputText w10 fl_left" />

		<div class="pstb_del" onclick="delUnitClick(this,event)"></div>
	</div>
</div>
