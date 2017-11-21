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
    <input type="checkbox" class="ckbox fl_left isChecksTempl" onclick="templCheckBoxs(this);" />
    <input type="text" class="inputText fl_left Black" style="width:50px;" readonly="readonly" /> 
    <div class="iconPut fl_left" style="width:90px;" >
        <input style="width:75%" type="text" readonly="readonly" />
        <div class="ListWin" ></div>
    </div>
    <input type="text" class="inputText fl_left Black" style="width:90px;" readonly="readonly" />
</div>