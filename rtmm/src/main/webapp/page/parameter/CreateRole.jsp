<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<div class="Panel">
	<div class="PanelTop">
		<span>创建新角色</span>
		<div class="PanelClose" onclick="closeModify()"></div>
	</div>
	<div class="PanelMiddle">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
					<span>*角色</span>
				</td>
				<td>
					<input id="roleName" type="text" class="B_InHalf" />
				</td>
			</tr>
			<tr>
				<td class="Width5">
					<span>角色描述</span>
				</td>
				<td rowspan="2">
					<textarea id="describe" class="B_InArea Border" rows="2" cols="40"></textarea>
				</td>
			</tr>
		</table>
	</div>
	<div class="PanelFooter">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="roleSave()">保存</div>
			<div class="PanelBtn2" onclick="clearText()">取消</div>
		</div>
	</div>
</div>

