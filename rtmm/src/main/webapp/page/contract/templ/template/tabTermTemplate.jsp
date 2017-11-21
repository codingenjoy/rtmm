<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tld/auchan" prefix="auchan"%>
<%
/**
*最外端的"<div class="item supplerItem clone">"元素，不属于模板内容；
*但是必须存在，因为它起着承接DOM节点的作用.
*强制要求：模板内容不允许出现任何注释。
**/
%>
<div>
    <input type="checkbox" class="ckbox fl_left isChecksTempl" onclick="templCheckBoxs(this);" />
    <input type="text" class="inputText fl_left Black" style="width:50px;" readonly="readonly" /> 
    <input type="text" class="inputText fl_left" style="width:110px;" onfocus="inputFocus(this);" onchange="doUpdateOneTabTerm(this);" onkeydown="eventClick(this);" />
    <input type="text" class="inputText fl_left longText" style="width:155px;" onfocus="inputFocus(this);" onchange="doUpdateOneTabTerm(this);" onkeydown="eventClick(this);" />
    <div class="iconPut fl_left" style="width:100px;">
        <input style="width:80%" type="text" readonly="readonly" />
        <input type="hidden" />
        <div class="ListWin" onclick="openOfPaymentWin(this);" ></div>
    </div>
    <select class="fl_left" style="width:65px;" onchange="doUpdateOneTabTerm(this);" >
    	<option value="0" selected="selected" >0-否</option>
    	<option value="1" >1-是</option>
    </select>
    <input type="text" class="inputText fl_left" style="width:60px;" onfocus="inputFocus(this);" maxlength="2" onchange="doUpdateOneTabTerm(this);" />
</div>