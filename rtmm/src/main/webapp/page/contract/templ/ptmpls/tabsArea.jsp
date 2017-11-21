<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div style="height: 195px; margin-top: 2px;" class="CM">
	<div class="CM-bar">
		<div>页签</div>
	</div>
	<div class="CM-div">
		<div class="contract_cm">
			<table cellpadding="0" cellspacing="0" class="align_center">
				<tr>
					<td><div style="width: 30px;"></div></td>
					<td><div style="width: 53px;">序号</div></td>
					<td><div style="width: 313px;">中文名</div></td>
					<td><div style="width: 313px;">英文名</div></td>
					<td><div style="width: 203px;">类型</div></td>
				</tr>
			</table>

			<div id="templTabCodeDiv" class="cm_table cm_table1">
			</div>
			<div class="ig">
				<input type="checkbox" class="sp_icon1" onclick="templCheckBoxAll(this);" />
				<div class="Icon-size2 Tools10 sp_icon2" onclick="doDeleteTabs(this);"></div>
				<div class="Icon-size2 Line-1 sp_icon3 "></div>
				<div class="Icon-size2 Tools11 sp_icon4" onclick="addTabNo(this);"></div>
			</div>
		</div>
	</div>
</div>