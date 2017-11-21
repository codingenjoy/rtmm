<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="oneShopHeadTableRowTemplate" style="display: none;">
	<!-- 新增使用的模板 -->
	<table id="oneShopHeadTable">
		<tr>
			<td style='width:30px;'>
				<input type='checkbox' id='checkbox'/>
			</td>
			<td>
				<div style='width:110px;'>
					<input type='text' class='inputText w85 Black' readonly='readonly' value='' id='storeInfo'/>
				</div>
			</td>
		</tr>
	</table>
<!-- 	详情时候的模板 -->
	<table id="oneShopHeadTableDetail">
		<tr>
				<td><div style='width:30px;'><input type='hidden'  id='checkbox'/></div></td>
       			<td>
       				<div style='width:100px;'><input type='text' class='inputText w95 ' readonly='readonly' id='storeInfo'/></div>
       			</td>
		</tr>
	</table>
</div>