<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach var="obj" items="${itemStoreList}">
<div class="ig">
<form onSubmit="return false;">
    <c:if test="${empty show}">
    <input type="checkbox" class="fl_left ck isChecksProm" <c:if test="${ not empty orderStr }">disabled="disabled"</c:if>>
    <input type="hidden" value="${promStoreItemVO.unitType}" name="unitType">
    <input type="hidden" value="${promStoreItemVO.promUnitNo}" name="promUnitNo">
    <input type="hidden" value="${promStoreItemVO.itemNo}" name="itemNo">
    <input type="hidden" value="${obj.storeNo}" name="storeNo">
    </c:if>
    <input type="text" value="${obj.storeNo}-${obj.storeName}" class="inputText w15 fl_left Black" readonly="readonly" name="storeName">
    <input type="text" value="${obj.supNo}" readonly="readonly" class="w10 fl_left inputText" name="promSupNo">
    <input type="text" value="${obj.comName}" readonly="readonly" class="inputText w28 fl_left Black" name="comName">
    <input type="text" value="<auchan:getDictValue code="${obj.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>" readonly="readonly" class="inputText w12_5 fl_left Black" name="statusName">
    <input type="text" value="${obj.normBuyPrice}" class="inputText w12_5 fl_left Black" readonly="readonly" name="normBuyPrice">
    <input type="text" buyPriceLimit="${obj.buyPriceLimit}" buywhen="${obj.buyWhen}" onfocus="{$(this).removeClass('errorInput');$(this).attr('title','');}" value="<fmt:formatNumber value='${obj.promBuyPrice}' pattern='#0.####'/>"<c:if test="${not empty checkUpdate}"> readonly="readonly"</c:if><c:if test="${ not empty orderStr }"> readonly="readonly"</c:if><c:if test="${empty checkUpdate}"> onkeyup="inputToInputDoubleNumber(this)"</c:if> class="inputText w12_5 fl_left <c:if test="${empty show && (empty obj.promBuyPrice)}">errorInput</c:if> <c:if test="${ not empty orderStr }">Black</c:if>" name="promBuyPrice">
    <input type="hidden" value="${obj.normSellPrice}" name="normSellPrice">
    <input type="hidden" value="${promStoreItemVO.itemName}" name="itemName">
    <input type="hidden" value="${obj.buyPriceLimit}" name="buyPriceLimit">
    <input type="hidden" value="${obj.buyWhen}" name="buyWhen">
    <input type="hidden" value="${orderStr }" name="checkOrders">
     <input type="hidden" value="${obj.batchPriceChngInd}" name="batchPriceChngInd">
</form>
</div>
</c:forEach>
