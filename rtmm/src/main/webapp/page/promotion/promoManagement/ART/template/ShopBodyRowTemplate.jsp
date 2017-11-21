<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="oneShopBodyTableRowTemplate" style="display: none;">
	<table id="oneShopBodyTable">
		<tr>
			<td><div style='width:100px;' > <input type='text' class='inputText w95 Black ' id='status' readonly='readonly'/></div></td>
			<td><div style='width:110px;'><input type='text' class='inputText w95 Black' readonly='readonly' id='normBuyPrice' name='normBuyPrice' ></div></td>
			<td><div style='width:110px;'><input type='hidden' class='inputText w95 ' value='' id='oldPromBuyPrice'/><input type='text' class='inputText w95 ' buyPriceLimit='' buyWhen='' value='' id='promBuyPriceBody'/></div></td>
			<td><div style='width:110px;'><input type='text' class='inputText w95 Black ' readonly='readonly' name='normSellPrice'  id='normSellPrice'  value=''/></div></td>
			<td><div style='width:100px;'><input type='hidden' class='inputText w95 ' value='' id='oldPromSellPrice'/><input type='text' class='inputText w95 ' value='' id='promSellPriceBody'/></div></td>
			<td><div style='width:100px;'><input type='text' class='inputText w95 Black ' readonly='readonly' value='' id='priceCut' /></div></td>
			<td><div style='width:100px;'><input type='text' class='inputText w95 Black ' readonly='readonly' value='' id='netMaori'/></div></td>
			<td><div style='width:60px;'><input type='hidden' id='netCost' name='' value='' /><input type='hidden' id='vat' name='' value='' /><input class='w95 Black inputText' type='text' id='promSupNo' value=''></div></td>
			<td><div style='width:185px;'><input type='text' class='inputText w95 Black' readonly='readonly'  value='' id='mainComName'/></div></td>
		</tr>
	</table>
	
	<table id="oneShopBodyTableDetail">
		<tr>
			<td><div style='width:100px;' > <input type='text' class='inputText w95  ' id='status' readonly='readonly'/></div></td>
			<td><div style='width:110px;'><input type='text' class='inputText w95 ' readonly='readonly' id='normBuyPrice' name='normBuyPrice' ></div></td>
			<td><div style='width:110px;'><input type='text' class='inputText w95 '  readonly='readonly' buyPriceLimit='' buyWhen='' value='' id='promBuyPriceBody'/></div></td>
			<td><div style='width:110px;'><input type='text' class='inputText w95  ' readonly='readonly' name='normSellPrice'  id='normSellPrice'  value=''/></div></td>
			<td><div style='width:100px;'><input type='text' class='inputText w95 '  readonly='readonly' value='' id='promSellPriceBody'/></div></td>
			<td><div style='width:100px;'><input type='text' class='inputText w95  ' readonly='readonly' value='' id='priceCut' /></div></td>
			<td><div style='width:100px;'><input type='text' class='inputText w95  ' readonly='readonly' value='' id='netMaori'/></div></td>
			<td><div style='width:60px;'><input type='hidden' id='netCost' name='' value='' /><input type='hidden' id='vat' name='' value='' /><input class='w95  inputText' readonly='readonly' type='text' id='promSupNo' value=''></div></td>
			<td><div style='width:185px;'><input type='text' class='inputText w95 ' readonly='readonly'  value='' id='mainComName'/></div></td>
		</tr>
	</table>
</div>
