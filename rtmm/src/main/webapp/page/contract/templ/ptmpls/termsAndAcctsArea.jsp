<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div style="height: 275px; margin-top: 2px;" class="CM">
	<div class="CM-bar">
		<div>条款与科目组</div>
	</div>
	<div class="CM-div">
		<div class="contract_cm contract_cmx">
			<div class="contract_cm1">
				<table cellpadding="0" cellspacing="0" class="align_center">
					<tr>
						<td><div style="width: 30px;"></div></td>
						<td><div style="width: 53px;">序号</div></td>
						<td><div style="width: 113px;">中文名</div></td>
						<td><div style="width: 163px;">英文名</div></td>
						<td><div style="width: 108px;">支付方式</div></td>
						<td><div style="width: 63px;">固定条款</div></td>
						<td><div style="width: 63px;">纸版页数</div></td>
					</tr>
				</table>
				<div id="templTabTermDiv" class="cm_table2"></div>
				<div class="ig">
					<input type="checkbox" class="sp_icon1" onclick="templCheckBoxAll(this);" disabled="disabled" />
					<div class="Icon-size2 Tools10_disable sp_icon2" onclick="doDeleteTabTerms(this);" ></div>
					<div class="Icon-size2 Line-1 sp_icon3" ></div>
					<div class="Icon-size2 Tools11_disable sp_icon4" onclick="addTabTerm(this);" ></div>
				</div>
			</div>
			<div class="contract_cm2"></div>
			<div class="contract_cm3">
				<table cellpadding="0" cellspacing="0" class="align_center">
					<tr>
						<td><div style="width: 30px;"></div></td>
						<td><div style="width: 53px;">序号</div></td>
						<td><div style="width: 93px;">科目组编号</div></td>
						<td><div style="width: 93px;">中文名</div></td>
					</tr>
				</table>
				<div id="templTabTermAcctDiv" class="cm_table3"></div>
				<div class="ig">
					<input type="checkbox" class="sp_icon1" onclick="templCheckBoxAll(this);" disabled="disabled" />
					<div class="Icon-size2 Tools10_disable sp_icon2" onclick="doDeleteTabTermAccts(this);" ></div>
					<div class="Icon-size2 Line-1 sp_icon3" ></div>
					<div class="Icon-size2 Tools11_disable sp_icon4" onclick="openAcctGroupWin(this);" ></div>
					<!-- onclick="addTabTermAcct(this);" -->
				</div>
			</div>
		</div>
	</div>
</div>