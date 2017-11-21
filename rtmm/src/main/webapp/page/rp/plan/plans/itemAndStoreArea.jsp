<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div style="height: 200px; margin-top: 2px;" class="CM">
	<div class="CM-bar">
		<div>门店商品数量</div>
	</div>
	<div class="CM-div">
		<div class="contract_cm">
			<table cellpadding="0" cellspacing="0" class="align_center w100">
				<tr>
					<td style="width: 30px;">&nbsp;</td>
					<td style="width: 204px;">门店</td>
					<td style="width: 150px;">建议量</td>
					<td style="width: 163px;">门店确认量</td>
					<td style="width: 150px;">最终数量</td>
					<td style="width: 120px;">修改日期</td>
					<td style="width: auto;">&nbsp;</td>
				</tr>
				<tr style="background: #e0e0e0; border-top: 1px solid #999;">
					<td colspan="2"></td>
					<td>
						<input type="text" class="inputText" style="width: 150px;" onfocus="$(this).removeClass('errorInput');$(this).attr('title','');" onchange="batchUpdateInitQty(this);" />
					</td>
					<td colspan="4"></td>
				</tr>
			</table>

			<div id="itemStoreDivArea" class="cm_table2"></div>

			<div class="ig">
				<input type="checkbox" class="sp_icon1" onclick="planCheckBoxAll(this)" />
				<div class="Icon-size2 Tools10_disable sp_icon2" onclick="doDeleteItemStores(this);" ></div>
				<div class="Icon-size2 Line-1 sp_icon3 "></div>
				<div class="Icon-size2 Tools11_disable sp_icon4" onclick="showStoreWin(this);"></div>
			</div>
		</div>
	</div>
</div>