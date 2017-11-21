<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class='item' onclick="itemSelected(this);return false;">
	<input type='text' readonly="readonly" name='itemNo' onchange="newOrderItemHandler(this)" class='inputText w8 pedit_f Black mustInput' size="8"
		onafterpaste="this.value=this.value.replace(/\D/g,'')" />
	<input type='text' readonly='readonly' name='itemName' value='' class='inputText w12 fl_left Black' />
	<input type='text' readonly='readonly' name='sellUnit' value='' class='inputText w10 fl_left Black' />
	<input type='text' readonly='readonly' name='buyMethd' value='' class='inputText pedit_fth Black' />
	<input type='text' readonly='readonly' name='buyWhen' value='' class='inputText pedit_fth Black' />
	<input type='text' readonly='readonly' name='ordQtyAmnt' value='' class='inputText w10 fl_left Black' />
	<input type='text' readonly='readonly' name='presOrdQtyAmnt' value='' class='inputText w10 fl_left Black' />
	<input type='text' readonly='readonly' name='stockAmnt' value='' class='inputText w10 fl_left Black' />
	<input type='text' readonly='readonly' name='recvBleQtyAmnt' value='' class='inputText w10 fl_left Black' />
	<div class='pstb_del' onclick="removeItem(this)"></div>
</div>

