<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div>
  <form action="" class="acctForm" onsubmit="return false;">
	<div class="icol_text"><span class="wauto fl_left rangeNo"></span><span class="wauto fl_left">&nbsp;&nbsp;期间&nbsp;</span></div>
	<input id="creatDateSearch" class="Wdate fl_left" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })" readonly="readonly">
	<div class="icol_text">&nbsp;-&nbsp;</div>
	<input id="Text1" class="Wdate fl_left" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })" readonly="readonly">
	                                    
	<div class="icol_text">&nbsp;达到&nbsp;</div>
	<input type="text" class="inputText w15 fl_left">
	<div class="icol_text">&nbsp;元，返还&nbsp;</div>
	<input type="text" class="inputText w15 fl_left">
	<select class="w7  fl_left Black"><option>元</option></select>
	<div class="Icon-size2 fl_left Tools10"></div>
	</form>
    <br class="clearBoth">
</div>
