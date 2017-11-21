<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/tld/auchan" prefix="auchan"%>
<c:forEach var="obj" items="${itemStoreList}">
<div class="ig">
<form onSubmit="return false;">
    <input type="checkbox" class="fl_left ck isChecksProm">
    <input type="hidden" value="${promStoreItemVO.unitType}" name="unitType">
    <input type="hidden" value="${promStoreItemVO.promUnitNo}" name="promUnitNo">
    <input type="hidden" value="${promStoreItemVO.itemNo}" name="itemNo">
    <input type="hidden" value="${obj.storeNo}" name="storeNo">
    <input type="text" value="${obj.storeNo}-${obj.storeName}" class="inputText w15 fl_left Black" readonly="readonly" name="storeName">
    <input type="text" value="${obj.stMainSupNo}" readonly="readonly" class="w10 fl_left inputText" name="promSupNo">
    <input type="text" value="${obj.mainComName}" readonly="readonly" class="inputText w28 fl_left Black" name="comName">
    <input type="text" value="<auchan:getDictValue code="${obj.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>" readonly="readonly" class="inputText w12_5 fl_left Black" name="statusName">
    <input type="text" value="${obj.normBuyPrice}" class="inputText w12_5 fl_left Black" readonly="readonly" name="normBuyPrice">
    <input type="text" value="" onkeyup="inputToInputDoubleNumber(this);" buyPriceLimit="${obj.buyPriceLimit}" buywhen="${obj.buyWhen}" onfocus="{$(this).removeClass('errorInput');$(this).attr('title','');}" class="inputText w12_5 fl_left errorInput" name="promBuyPrice">
    <input type="hidden" value="${obj.normSellPrice}" name="normSellPrice">
    <input type="hidden" value="${promStoreItemVO.itemName}" name="itemName">
    <input type="hidden" value="${obj.buyPriceLimit}" name="buyPriceLimit">
    <input type="hidden" value="${obj.buyWhen}" name="buyWhen">
    <input type="hidden" value="${orderStr }" name="checkOrders">
    <input type="hidden" value="${obj.batchPriceChngInd}" name="batchPriceChngInd">
</form>
</div>
</c:forEach>