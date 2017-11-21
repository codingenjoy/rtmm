<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <c:if test="${not empty storeList}">
 <!--left frozen parts of a table-->
	<div class="frozen_div">
		<div id="frozen_cols">
		    <!--frozen top head parts-->
		    <div id="f_cols_head">
		        <div class="f_head_1">
		            <table cellspacing="0" cellpadding="0">
		                <tbody>
		                    <tr>
		                        <td>
		                            <div style="width:30px;">
		                                &nbsp;
		                            </div>
		                        </td>
		                        <td>
		                            <div style="width:110px;">
		                                门店
		                            </div>
		                        </td>
		                    </tr>
		                    <tr style="border-top:1px solid #808080;background:#ccc;">
		                        <td>
		                            <div style="width:30px;">
		                                &nbsp;
		                            </div>
		                        </td>
		                        <td>
		                            <div style="width:110px;">
		                                &nbsp;
		                            </div>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		    </div>
		    <!--frozen body parts-->
		    <div id="f_cols_body">
		        <table cellspacing="0" cellpadding="0" id="shopHeadTable">
		            <tbody>
		            <c:forEach items="${storeList}" var="obj" varStatus="idx">
		                <tr>
		                    <td style="width:30px;">
		                        <input type="checkbox" colagNoVal="${item.catlgId}" itemNoVal="${obj.itemNo}" unitNoVal="${item.unitNo}"
		                        unitTypeVal="${item.unitType}" name="${obj.storeNo}" deleteId="${obj.storeNo}" class="isChecksART">
		                    </td>
		                    <td>
		                        <div style="width:110px;">
		                            <input type="text" value="${obj.storeNo}-${obj.storeName}" readonly="readonly" class="inputText w85 Black">
		                        </div>
		                    </td>
		                </tr>
		            </c:forEach>
		            </tbody>
		        </table>
		        <table>
		            <tbody>
		                <tr>
		                    <td>
		                        &nbsp;
		                    </td>
		                    <td>
		                        &nbsp;
		                    </td>
		                </tr>
		            </tbody>
		        </table>
		    </div>
		</div>
		<!--right parts that can scroll-->
		<div id="move_cols">
		    <!--frozen top head parts when drag the y-scroll -->
		    <div id="m_cols_head">
		        <table cellspacing="0" cellpadding="0">
		            <tbody>
		                <tr>
		                    <td>
		                        <div style="width:60px;">厂商</div>
		                    </td>
		                    <td>
		                        <div style="width:185px;">
		                            &nbsp;
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:100px;">
		                            商品状态
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:110px;">
		                            正常进价(元)
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:110px;">
		                            促销进价(元)
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:110px;">
		                            正常售价(元)
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:100px;">
		                            促销售价(元)
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:100px;">
		                            降价幅度(%)
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:100px;">
		                            净毛利(%)
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:90px;">
		                            &nbsp;
		                        </div>
		                    </td>
		                    <!--占位-->
		                </tr>
		                <tr style="border-top:1px solid #808080;background:#ccc;">
		                    <td>
		                        &nbsp;
		                    </td>
		                    <td>
		                        &nbsp;
		                    </td>
		                    <td>
		                        &nbsp;
		                    </td>
		                    <td>
		                        &nbsp;
		                    </td>
		                    <td>
		                        <div style="width:110px;">
		                            <input type="text" id="promBuyPriceHead" child="1" class="inputText w95 promBuyPriceHead">
		                        </div>
		                    </td>
		                    <td>
		                        &nbsp;
		                    </td>
		                    <td>
		                        <div style="width:100px;">
		                            <input type="text" id="promSellPriceHead" child="1" class="inputText w95 promSellPriceHead Black"
		                            readonly="readonly">
		                        </div>
		                    </td>
		                    <td>
		                        &nbsp;
		                    </td>
		                    <td>
		                        &nbsp;
		                    </td>
		                    <td>
		                        &nbsp;
		                    </td>
		                    <!--占位-->
		                </tr>
		            </tbody>
		        </table>
		    </div>
		    <!--this parts can be scrolled all the time-->
		    <div id="m_cols_body">
		        <table cellspacing="0" cellpadding="0" id="shopBodyTable">
		            <tbody>
		            <c:forEach items="${storeList}" var="store">
		                <tr id="${store.storeNo}">
		                    <td>
		                        <div style="width:60px;">
		                            <input type="hidden" value="${store.netCost}" name="" id="netCost">
		                            <input type="hidden" value="${store.vatVal}" name="" id="vat">
		                            <input type="text" value="${store.stMainSupNo}" class="w95 Black inputText">
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:185px;">
		                            <input type="text" value="${store.mainComName}" readonly="readonly" class="inputText w95 Black">
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:100px;">
		                            <input type="text" name="${store.basicStatus}" value="${store.status}-${store.itemStatusName}" readonly="readonly" class="inputText w95 Black">
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:110px;">
		                            <input type="text" value="${store.normBuyPrice}" name="normBuyPrice" readonly="readonly"
		                            class="inputText w95 Black">
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:110px;">
		                            <input type="text" buywhen="${store.buyWhen}" buyPriceLimit="${store.buyPriceLimit}" value="${store.buyPriceLimit}" class="inputText w95 promBuyPriceBody">
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:110px;">
		                            <input type="text" value="${store.normSellPrice}" name="normSellPrice" readonly="readonly"
		                            class="inputText w95 Black normSellPrice">
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:100px;">
		                            <input type="text" value="" class="inputText w95 promSellPriceBody Black"
		                            readonly="readonly">
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:100px;">
		                            <input type="text" value="" readonly="readonly" class="inputText w95 Black priceCut">
		                        </div>
		                    </td>
		                    <td>
		                        <div style="width:100px;">
		                            <input type="text" value="" readonly="readonly" class="inputText w95 Black netMaori">
		                        </div>
		                    </td>
		                </tr>
		            </c:forEach>
		            </tbody>
		        </table>
		    </div>
		</div>
	</div>
<c:if test="${empty show}">
<script type="text/javascript">
$(function(){
	for (var i = 0; i < ItemsStoreArray.length; i++) {
	 	var itemsStoreJson = ItemsStoreArray[i];
	 	var jsonUnitNo = itemsStoreJson.unitNo;
	 	var jsonUnitType = itemsStoreJson.unitType;
	 	var jsonCatlgId = itemsStoreJson.catlgId;
	 	var unitType = '${unitType}';
	 	var catlgId = '${catlgId}';
	 	var unitNo = '${unitNo}';
	 	if(jsonUnitNo == unitNo && jsonUnitType == unitType && jsonCatlgId == catlgId  ){
	 		<c:forEach items="${storeList}" var="store" varStatus="idx">
	 		storeJson = {"promSupNo":${store.stMainSupNo},"mainComName":"${store.mainComName}","basicStatus":"${store.basicStatus}","status":${store.status},"status":"${store.itemStatusName}","storeNo":${store.storeNo},"storeName":"${store.storeName}","itemNo":${store.itemNo},"unitType":unitType,"unitNo":unitNo,"normBuyPrice":${store.normBuyPrice},"normSellPrice":${store.normSellPrice},"promBuyPrice":"","promSellPrice":"","netCost":${store.netCost},"sellVat":${store.vatVal},"itemName":"${store.itemName}","priceCut":"","netMaori":"","buyPriceLimit":${store.buyPriceLimit},"buyWhen":${store.buyWhen}};
	 		itemsStoreJson.storeArray.push(storeJson);
	 		</c:forEach>
	 	}
	}
	$("#m_cols_head").scrollLeft(0);
	$("#m_cols_body").scrollLeft(0);
	changeInputByPromPriceType(promType);
	doScrollEvent();
});
</script>
</c:if>
</c:if>