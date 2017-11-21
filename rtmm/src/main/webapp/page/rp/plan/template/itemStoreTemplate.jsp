<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
/**
*
*模板中因为xxx原因，不需要定义最外部的<tr></tr>元素，
*所有在本模板中出现的DOM定义，都会被用到.
*强制要求：模板内容不允许出现任何注释。
**/
%>
<div>
	<input type="checkbox" class="ckbox fl_left isChecksPlan" onclick="planCheckBoxs(this);" />
	<input type="text" class="inputText fl_left Black" style="width:200px; " readonly="readonly" />
	<input type="text" class="inputText fl_left" style="width:150px;" onfocus="$(this).removeClass('errorInput');$(this).attr('title','');" onchange="doUpdateOneItemStore(this);" />
	<input type="text" class="inputText fl_left longText" style="width:155px;" readonly="readonly" />
	<input type="text" class="inputText fl_left" style="width:150px;" readonly="readonly" />
	<input type="text" class="inputText fl_left" style="width:120px;" readonly="readonly" />
	<input type="hidden"  />
</div>