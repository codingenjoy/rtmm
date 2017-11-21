<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
/**
*模板中因为xxx原因，不需要定义最外部的<tr></tr>元素，
*所有在本模板中出现的DOM定义，都会被用到.
*强制要求：模板内容不允许出现任何注释。
*<tr>
*<td style='width:30px;'>
*	<input type='checkbox' id='checkbox'/>
*</td>
*<td>
*	<div style='width:110px;'>
*		<input type='text' class='inputText w85 Black' readonly='readonly' value='' />
*	</div>
*</td>
*</tr>
**/
%>
<div>
	<div>
		<div style='width:30px'>
			<input type='checkbox' id='checkbox' onclick="checkOneStore()"/>
		</div>
	</div>
	<div>
		<div style='width:110px;'>
			<input type='text' class='inputText w85 Black' readonly='readonly' value='' />
		</div>
	</div>
</div>
