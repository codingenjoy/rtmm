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
	<input type="text" class="inputText fl_left Black" style="width: 50px;" readonly="readonly" /> 
	<input type="text" class="inputText fl_left" style="width: 310px;" onfocus="inputFocus(this);" onchange="doUpdateOneTab(this);" onkeydown="eventClick(this);" /> 
	<input type="text" class="inputText fl_left" style="width: 310px;" onfocus="inputFocus(this);" onchange="doUpdateOneTab(this);" onkeydown="eventClick(this);" /> 
	<auchan:select mdgroup="CONTRACT_TMPL_TAB_TAB_TYPE" style="width:200px;" _class="fl_left" iscaption="0" onchange="doUpdateOneTab(this);"/>
</div>