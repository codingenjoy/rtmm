<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="itemInfoModel" style="display:none;">
    <div unittype="0" catlgIdValue="12" unitNoValue="12240" itemNoValue="${item.unitNo}" class="item addItems item_on">
    <span class="pstb_1">${item.unitNo}-${unitName}</span></div>
</div>
<div id="itemInfoModel2" style="display:none;">
    <div unitType="${item.unitType }" catlgIdValue="${item.catlgId}" unitNoValue="${item.unitNo}" itemNoValue="${obj.itemNO}" class="item addItems<c:if test="${idx.index==0}"> item_on</c:if>">
    <span class="pstb_1">${obj.itemNO}-${obj.itemName}</span><span class='pstb_del2'></span></div>
</div>
 
<table id="tableStoreModel" style="display:none;">
   <tbody>
   <tr>
      <td style="width:30px;">
          <input type="checkbox" colagNoVal="${item.catlgId}" itemNoVal="${obj.itemNo}" unitNoVal="${item.unitNo}" unitTypeVal="${item.unitType}" name="${obj.storeNo}" deleteId="${obj.storeNo}" class="isChecksART">
      </td>
      <td>
         <div style="width:110px;">
             <input type="text" value="${obj.storeNo}-${obj.storeName}" readonly="readonly" class="inputText w85 Black">
         </div>
       </td>
   </tr>
   </tbody>
</table>

<table id="shopBodyTableModel" style="display:none;">
	<tbody>
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
                <input type="text" name="status" value="${store.status}-${store.itemStatusName}" readonly="readonly" class="inputText w95 Black">
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
    </tbody>
</table>
