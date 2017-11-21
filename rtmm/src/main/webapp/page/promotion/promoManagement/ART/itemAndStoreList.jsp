<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="firstItemNo"></c:set>
 <c:if test="${not empty storeList}">
 <div class="pro_store_item1">
    <div class="top15">所选商品</div>
    <div style="height:70%;" class="pro_store_items">
    <c:if test="${not empty item.unitType && item.unitType==0}" >
    <c:set var="firstItemNo" value="${item.unitNo}"></c:set>
    <div unittype="0" catlgidvalue="12" unitnovalue="12240" itemNoValue="${item.unitNo}" class="item addItems item_on">
    <span class="pstb_1">${item.unitNo}-${unitName}</span></div>
    </c:if>
    <c:if test="${not empty item.unitType && item.unitType != 0}" >
    <c:forEach items="${itemList}" var="obj" varStatus="idx">
    <c:if test="${idx.index==0}"><c:set var="firstItemNo" value="${obj.itemNo}"></c:set></c:if>
    <div unitType="${item.unitType }" catlgIdValue="${item.catlgId}" unitNoValue="${item.unitNo}" itemNoValue="${obj.itemNo}" class="item addItems<c:if test="${idx.index==0}"> item_on</c:if>">
    <span class="pstb_1">${obj.itemNo}-${obj.itemName}</span><span class='pstb_del2'></span>
    </div>
    </c:forEach>
    </c:if>
    </div>
    <div class="top5"><div id="showDeleteItems" class="createNewBar"></div></div>
</div>

 <div class="pro_store_item2">
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
		            <c:if test="${obj.itemNo==firstItemNo}">
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
		            </c:if>
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
		            <c:if test="${store.itemNo==firstItemNo}">
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
		                            <input type="text" buywhen="${store.buyWhen}" buyPriceLimit="${store.buyPriceLimit}"  class="inputText w95 promBuyPriceBody">
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
		            </c:if>
		            </c:forEach>
		            </tbody>
		        </table>
		    </div>
		</div>
	</div>
	<div class="top5">
	  <input type="checkbox" class="fl_left top3 isCheckAllsART">
	  <div id="deleteAllART" class="deleteBar fl_left"></div>
	  <div class="lineToolbar fl_left"></div>
	  <div onclick="ARTPromoItem()" id="showDeleteSuppler" class="fl_left createNewBar"></div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	var storeArray=new Array();
	var storeJson = '';
	<c:forEach items="${storeList}" var="store">
	storeJson = {"promSupNo":${store.stMainSupNo},"basicStatus":"${store.basicStatus}","mainComName":"${store.mainComName}","status":${store.status},"statusName":"${store.itemStatusName}","storeNo":${store.storeNo},"storeName":"${store.storeName}","itemNo":${store.itemNo},"unitType":${item.unitType},"unitNo":${item.unitNo},"normBuyPrice":${store.normBuyPrice},"normSellPrice":${store.normSellPrice},"promBuyPrice":"","promSellPrice":"","netCost":${store.netCost},"sellVat":'${store.vatVal}',"itemName":"<c:out value="${store.itemName}"/>","priceCut":"","netMaori":"","buyPriceLimit":'${store.buyPriceLimit}',"buyWhen":${store.buyWhen}};
	storeArray.push(storeJson);
	</c:forEach>
	var itemsStoreJson ={"unitType":${item.unitType},"unitNo":${item.unitNo},"catlgId":${item.catlgId},"promActvy":"0","pmGiftHint":"","memo":"","storeArray":storeArray};
	ItemsStoreArray[ItemsStoreArray.length] = itemsStoreJson;
	$(".item_on").find("input[name='promUnitName']").val('${unitName}');
	$(".item_on").find("input[name='oUnitNo']").val('${unitNo}');
	$("#m_cols_head").scrollLeft(0);
	$("#m_cols_body").scrollLeft(0);
	changeInputByPromPriceType(promType);
	doScrollEvent();
});
</script>
</c:if>