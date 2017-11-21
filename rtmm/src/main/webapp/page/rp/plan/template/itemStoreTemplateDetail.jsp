<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
/**
*
*模板中因为xxx原因，不需要定义最外部的<tr></tr>元素，
*所有在本模板中出现的DOM定义，都会被用到.
*强制要求：模板内容不允许出现任何注释。
**/
%>
<div class="item">
   <input type="text" class="inputText fl_left iconPut1" id="storeNo" style="width:200px; " /> 
   <input type="text" class="inputText fl_left" style="width:150px;" id="initQty"/>
   <input type="text" class="inputText fl_left longText" style="width:155px;"id="stCnfrmQty" value="SPECIAL BUY PRICE DISCOUNT" title="SPECIAL BUY PRICE DISCOUNT"/>
   <input type="text" class="inputText fl_left" style="width:150px;" id="finalQty"/ >
   <input type="text" class="inputText fl_left" style="width:120px;" id="chngDate" />
</div>