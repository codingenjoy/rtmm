<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="ig_padding" onclick="itemStoreSelected(this)">
	<input type="checkbox" name="storeNoCk" class="fl_left" onchange="checkSelectAll(this)"/>
	<input type="text" class="inputText w10 fl_left Black" readonly="readonly" />
	<input type="text" class="inputText w8 fl_left Black" readonly="readonly">
	<input type="text" name="promNo" class="inputText w8 fl_left Black" readonly="readonly" onkeyup="if(isNaN(value))execCommand('undo')"
		onafterpaste="if(isNaN(value))execCommand('undo')" >
	<input type="text" name="ordQty" class="inputText w7 fl_left" value="" 
	    onchange="if(isNaN(value)){$(this).val('');return;}changeOrdQty(this)" maxlength="7"
		onkeypress="this.value=this.value.replace(/[^\d]/,'')" onafterpaste="if(isNaN(value))execCommand('undo')" >
	<input type="text" name="presOrdQty" class="inputText w7 fl_left " value="" 
	    onchange="if(isNaN(value)){$(this).val('');return;}changePresOrdQty(this)" maxlength="11"
		onkeypress="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')">
	<input type="text" name="buyPrice" class="inputText w10 fl_left buyPriceFormat" 
	    onchange="if(isNaN(value)){$(this).val('');return;}changeBuyPrice(this)" maxlength="11"
		onafterpaste="if(isNaN(value))execCommand('undo')">
	<input type="text" name="ordMultiParm" class="inputText w5 fl_left Black" readonly="readonly">
	<input type="text" class="inputText w5 fl_left Black" readonly="readonly">
	<input type="text" name="netCost" class="inputText w8 fl_left Black" readonly="readonly">
	<input type="text" name="dms" class="inputText w7 fl_left Black" readonly="readonly">
	<input type="text" name="recvBleQty" class="inputText w7 fl_left Black" readonly="readonly">
	<input type="text" name="stock" class="inputText w7 fl_left Black" readonly="readonly">
	<div class="clearBoth"></div>
</div>

