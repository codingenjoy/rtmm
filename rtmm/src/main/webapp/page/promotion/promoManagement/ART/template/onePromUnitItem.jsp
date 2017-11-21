<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
/**
*最外端的"<div class="item supplerItem clone">"元素，不属于模板内容；
*但是必须存在，因为它起着承接DOM节点的作用.
*强制要求：模板内容不允许出现任何注释。
**/
%>
<div class='item addItems' onclick="doOnPromUnitItemSelected(this)">
	<span class='pstb_1'></span>
	<span class='pstb_del2' onclick="doDeletePromUnitItem(this)"></span>
</div>