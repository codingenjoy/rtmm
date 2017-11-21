<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tld/auchan" prefix="auchan"%>
<%
/**
*最外端的"<div class="item supplerItem clone">"元素，不属于模板内容；
*但是必须存在，因为它起着承接DOM节点的作用.
*强制要求：模板内容不允许出现任何注释。

**/
%>
<div class="item" onclick="changeItem(this)">
      <input type="text" class="inputText fl_left iconPut1" style="width:100px;" id="itemNo" />
      <input type="text" class="inputText fl_left" style="width:150px;" id="itemName"/> 
      <input type="text" class="inputText fl_left" style="width:90px;" id="ordMultiParm" />
      <input type="text" class="inputText fl_left" style="width:90px;" id="buyPrice"/>
      <input type="text" class="inputText fl_left" style="width:90px;" id="normBuyPrice"/>
      <input type="text" class="inputText fl_left" style="width:100px;" id="dcSupNo"/>
      <input type="text" class="inputText fl_left" style="width:150px;" id="comName"/>
      <input type="text" class="inputText fl_left" style="width:90px;" id="stMinOrdQty"/>
      <input type="text" class="inputText fl_left" style="width:90px;" id="totalQty" />
</div>

