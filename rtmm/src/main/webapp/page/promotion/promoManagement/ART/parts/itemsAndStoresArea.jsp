<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<div class="CM" style="height: 270px; margin-top: 2px;">
	<div class="CM-bar">
		<div>促销商品门店信息</div>
	</div>
	<div class="CM-div">
		<div class="pro_store_item" id="pro_item_store_info">
			<div class="pro_store_item1">
				<div class="top15">所选商品</div>
				<div class="pro_store_items" id="promUnitItemsPanel" style="height: 70%;" forced="false"></div>
				<div class="top5">
					<div class="createNewBar_off" id="btnAddMoreItems" onclick="addMoreItems(this)"></div>
				</div>
			</div>
			<div class="pro_store_item2">
				<div class="frozen_div">
					<!--left frozen parts of a table-->
					<div id="frozen_cols">
						<!--frozen top head parts-->
						<div id="f_cols_head">
							<div class="f_head_1">
								<table cellpadding="0" cellspacing="0">
									<tr>
										<td><div style="width: 30px;">&nbsp;</div></td>
										<td><div style="width: 110px;">门店</div></td>
									</tr>

									<tr style="border-top: 1px solid #808080; background: #ccc;">
										<td><div style="width: 30px;">&nbsp;</div></td>
										<td><div style="width: 110px;">&nbsp;</div></td>
									</tr>
								</table>
							</div>
						</div>
						<!--frozen body parts-->
						<div id="f_cols_body" style="position: relative;">
							<table cellpadding="0" cellspacing="0" id="shopHeadTable">
								<tbody></tbody>
							</table>
							<div
								style="height: 17px; position: relative; left: 0; bottom: 0;">
							</div>

						</div>
					</div>
					<!--right parts that can scroll-->
					<div id="move_cols">
						<!--frozen top head parts when drag the y-scroll -->
						<div id="m_cols_head">
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td><div style="width: 90px;">商品状态</div></td>
									<td><div style="width: 90px;">正常进价(元)</div></td>
									<td><div style="width: 90px;">促销进价(元)</div></td>
									<td><div style="width: 100px;">降价幅度(%)</div></td>
									<td><div style="width: 90px;">正常售价(元)</div></td>
									<td><div style="width: 90px;">促销售价(元)</div></td>
									<td><div style="width: 90px;">降价幅度(%)</div></td>
									<td><div style="width: 90px;">净毛利(%)</div></td>
									<td><div style="width: 60px;">厂商</div></td>
									<td><div style="width: 185px;">&nbsp;</div></td>
									<td><div style="width: 90px;">&nbsp;</div></td>
									<!--占位-->
								</tr>
								<tr style="border-top: 1px solid #808080; background: #ccc;">
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td><div style="width: 90px; text-align: left;">
											<input type="text" class="inputText w95" id="txtChangePromBuyPriceAtItem" maxlength=10 readonly 
												onafterpaste="if(isNaN(value)) execCommand('undo')" onkeypress="doCheckOnPromBuyPriceKeyin(event, this)" onblur="doItemLevelBuyPriceChange(this)" />
										</div></td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td><div style="width: 90px; text-align: left;">
											<input type="text" class="inputText w95" id="txtChangePromSellPriceAtItem" maxlength=8 readonly 
												onafterpaste="if(isNaN(value)) execCommand('undo')" onkeypress="doCheckOnPromSellPriceKeyin(event, this)" onblur="doItemLevelSellPriceChange(this)" />
										</div></td>
									
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>

									<td>&nbsp;</td>
									<!--占位-->
								</tr>
							</table>
						</div>
						<!--this parts can be scrolled all the time-->
						<div id="m_cols_body">
							<table cellpadding="0" cellspacing="0" id="shopBodyTable">
								<tbody></tbody>
							</table>

						</div>
					</div>
				</div>
				<div class="top5">
					<input class="fl_left top3" type="checkbox" id="ckbSelectAllStores" onclick="selectAllItemStores(this)"/>
					<div class="deleteBar fl_left" id="btnDeleteStores" onclick="doBatchItemStoresRemoval(this)"></div>
					<div class="lineToolbar fl_left"></div>
					<div class="createNewBar_off fl_left" id="btnAddMoreStores" onclick="addMoreStores(this)"></div>
				</div>
			</div>
		</div>
	</div>
</div>