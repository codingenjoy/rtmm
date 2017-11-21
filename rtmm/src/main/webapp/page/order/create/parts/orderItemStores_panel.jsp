<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="CM" style="height: 260px; margin-top: 2px;">
	<div class="CM-bar">
		<div>订单商品分店信息</div>
	</div>
	<div class="CM-div">
		<div class="pro_store_item hoOrderCreateStore">
			<div class="s_tit">
				<div class="s_tit2">
					<span class="psi1"> <auchan:i18n id="104002020"></auchan:i18n>
					</span> <span class="psi2"> <auchan:i18n id="104002021"></auchan:i18n>
					</span> <span class="psi3"> <auchan:i18n id="104002022"></auchan:i18n>
					</span> <span class="psi4"> <auchan:i18n id="104002023"></auchan:i18n>
					</span> <span class="psi5"> <auchan:i18n id="104002024"></auchan:i18n>
					</span> <span class="psi6"> <auchan:i18n id="104002025"></auchan:i18n>
					</span> <span class="psi6_2"> <auchan:i18n id="104002026"></auchan:i18n>
					</span> <span class="psi7"> <auchan:i18n id="104002027"></auchan:i18n>
					</span> <span class="psi8"> <auchan:i18n id="104002028"></auchan:i18n>
					</span> <span class="psi9"> <auchan:i18n id="104002029"></auchan:i18n>
					</span> <span class="psi10"> <auchan:i18n id="104002030"></auchan:i18n>
					</span> <span class="psi11"> <auchan:i18n id="104002031"></auchan:i18n>
					</span>
				</div>
				<div class="fu_div">
					<div class="iconPut w7 fl_left" style="margin-left: 274px;">
						<input type="text" class="inputText w65 ordMultiParmBody"
							style="border: none;" id="txtBatchChangeOrdQty"
							onchange="if(isNaN(value)){$(this).val('');return;}doBatchChangeOrdQty(this)" maxlength="7"
							onkeypress="validateIntOnly(window.event)"
							onafterpaste="if(isNaN(this.value))execCommand('undo')"/>
						<div class="ListWin" onclick="pasteOrdQty()"></div>
					</div>
					<input type="text" class="inputText w7  promotionalItemsBody"
						id="txtBatchChangePresOrdQty"
						onchange="if(isNaN(value)){$(this).val('');return;}doBatchChangePresOrdQty(this)" maxlength="11"
						onkeypress="if(isNaN(this.value))execCommand('undo')"
						onafterpaste="if(isNaN(this.value))execCommand('undo')" />
					<input type="text" class="inputText w10  buyPriceChangeBody Black buyPriceFormat"
						readonly="readonly" id="txtBatchChangeBuyPrice"
						onchange="if(isNaN(value)){$(this).val('');return;}doBatchChangeBuyPrice(this)" maxlength="11"
						onkeypress="if(isNaN(this.value))execCommand('undo')"
						onafterpaste="if(isNaN(this.value))execCommand('undo')" />

				</div>
			</div>
			<div class="pro_store_tb store_tb2" style="height: 58%;" id="orderItemStoreList" onkeydown="trapNavigable(event)"></div>
			<div class="top5">
				<input class="fl_left top3 checkAll" type="checkbox" name="storeNoCk" onclick="chkAllStoreNo(this)"/>
				<div class="deleteBar fl_left" onclick="page_OnDelStoresBtnClicked()"></div>
				<div class="lineToolbar fl_left"></div>
				<div class="listBar fl_left showStoresBar" onclick="page_OnAddMoreStoresBtnClicked()"></div>
			</div>
		</div>
	</div>
</div>