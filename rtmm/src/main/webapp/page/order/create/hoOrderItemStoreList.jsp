<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="s_tit">
	<div class="s_tit2">
		<span class="psi1">分店</span>
		<span class="psi2">商品状态</span>
		<span class="psi3">促销期数</span>
		<span class="psi4">订购数量</span>
		<span class="psi5">赠品数量</span>
		<span class="psi6">买价(元)</span>
		<span class="psi6_2">订购倍数</span>
		<span class="psi7">税率</span>
		<span class="psi8">净成本(元)</span>
		<span class="psi9">均销量</span>
		<span class="psi10">在途量</span>
		<span class="psi11">库存量</span>
	</div>
	<div class="fu_div">
		<input type="text" class="inputText w7 ordMultiParmBody" style="margin-left: 274px;" onchange="batchUpdateOrdQty(this)" maxlength="10"
			onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" />
		<input type="text" class="inputText w7  promotionalItemsBody" onchange="batchUpdatePresOrdQty(this)" maxlength="10"
			onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" />
		<c:choose>
			<c:when test="${buyWhen=='2'}">
				<input type="text" class="inputText w10  buyPriceChangeBody" onchange="batchUpdateBuyPrice(this)" maxlength="10"
					onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" />
			</c:when>
			<c:otherwise>
				<input type="text" class="inputText w10  buyPriceChangeBody Black" readonly="readonly" maxlength="10"
					onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" />
			</c:otherwise>
		</c:choose>
	</div>
</div>
<div class="pro_store_tb store_tb2" style="height: 170px">
	<c:forEach var="itemStore" items="${orderItemStoreList}">
		<div class="ig_padding item_store">
			<input type="checkbox" name="storeNoCk" value="${itemStore.storeNo}" class="fl_left" ">
			<input type="text" value="${itemStore.storeNo}-${itemStore.storeName}" class="inputText w10 fl_left Black" readonly="readonly">
			<input type="text" value="<auchan:getDictValue code="${itemStore.status}" mdgroup="ITEM_BASIC_STATUS"/>" class="inputText w8 fl_left Black"
				readonly="readonly">
			<input type="text" name="promNo" value="${itemStore.promNo}" class="inputText w8 fl_left Black" readonly="readonly"
				onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')">
			<input type="text" name="ordQty" id="ordQty-${itemStore.storeNo }" class="inputText w7 fl_left " value="" onchange="validateOrdQty($(this).parent())" maxlength="10"
				onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')">
			<input type="text" name="presOrdQty" class="inputText w7 fl_left " value="" onchange="validateOrdQty($(this).parent())" maxlength="10" onkeyup="if(isNaN(value))execCommand('undo')"
				onafterpaste="if(isNaN(value))execCommand('undo')">
			<c:choose>
				<c:when test="${buyWhen=='2'}">
					<input type="text" name="buyPrice" value="<fmt:formatNumber value="${itemStore.buyPrice}" pattern="#.####" minFractionDigits="4"/>"
						class="inputText w10 fl_left" onchange="validateBuyPrice(this)" maxlength="10" onkeyup="if(isNaN(value))execCommand('undo')"
						onafterpaste="if(isNaN(value))execCommand('undo')">
				</c:when>
				<c:otherwise>
					<input type="text" name="buyPrice" value="<fmt:formatNumber value="${itemStore.buyPrice}" pattern="#.####" minFractionDigits="4"/>"
						class="inputText w10 fl_left Black" maxlength="10" onkeyup="if(isNaN(value))execCommand('undo')"
						onafterpaste="if(isNaN(value))execCommand('undo')">
				</c:otherwise>
			</c:choose>
			<input type="text" name="ordMultiParm" value="${itemStore.ordMultiParm}" class="inputText w5 fl_left Black" readonly="readonly">
			<input type="text" value="<fmt:formatNumber value="${itemStore.buyVatVal/100}" type="percent" />"
				class="inputText w5 fl_left Black" readonly="readonly">
			<input type="text" name="netCost" value="${itemStore.netCost}" class="inputText w8 fl_left Black" readonly="readonly">
			<input type="text" name="dms" value="${itemStore.dms}" class="inputText w7 fl_left Black" readonly="readonly">
			<input type="text" name="recvBleQty" value="<fmt:formatNumber value="${itemStore.recvBleQty}" pattern="#" minFractionDigits="0"/>"
				class="inputText w7 fl_left Black" readonly="readonly">
			<input type="text" name="stock" value="${itemStore.stock}" class="inputText w7 fl_left Black" readonly="readonly">
			<input type="hidden" name="storeNo" value="${itemStore.storeNo}">
			<input type="hidden" name="buyVatNo" value="${itemStore.buyVatNo}">
			<input type="hidden" name="buyVatVal" value="${itemStore.buyVatVal}">
			<input type="hidden" name="buyPriceLimit" value="${itemStore.buyPriceLimit}">
			<input type="hidden" name="oldBuyPrice" value="<fmt:formatNumber value="${itemStore.buyPrice}" pattern="#.####" minFractionDigits="4"/>">
			<div class="clearBoth"></div>
		</div>
	</c:forEach>
</div>
<div class="top5">
	<input class="fl_left top3 checkAll" name="storeNoCk" type="checkbox" onclick="checkAllStore(this)" />
	<div class="deleteBar fl_left" onclick="deleteCheckedStore(this)"></div>
	<div class="lineToolbar fl_left" ></div>
	<div class="listBar fl_left showStoresBar" onclick="showOrderItemStore()"></div>
</div>