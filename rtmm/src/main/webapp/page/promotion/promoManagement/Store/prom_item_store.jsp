<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach var="obj" items="${itemStoreList}">
<div class="pro_ig"  id="pro_ig_${obj.itemNo}">
<input type="hidden" id="netCost" name="netCost" value="${obj.netCost}" /><input type="hidden" id="vat" name="vat" value="${obj.vatVal}" /><input type="checkbox" class="fl_left" name="proStoreCK" value="${obj.itemNo}" onclick="proStoreCKClick()" />
<input type="text" name="itemNo" value="${obj.itemNo}"  class="inputText w8 Black fl_left readonly="readonly"" />
<input type="text" name="itemName" value="<c:out value='${obj.itemName}'/>" class="inputText w14 Black fl_left" readonly="readonly"/>
<input type="text" name="supplier" value="<c:out value='${obj.mainComName}'/>" class="inputText w14 Black fl_left" readonly="readonly"/>
<input type="text" name="normalBuyPrice" value="${obj.normBuyPrice}" class="inputText w9 Black fl_left" readonly="readonly"/>
<c:choose><c:when test="${buyBegin==1 or pricePromType==3 or obj.status>5 or obj.buyMethd ==2 or obj.prcssType==2 or obj.prcssType==4 or obj.prcssType==5}">
<input type="text" name="promBuyPrice" value="${obj.promBuyPrice}" disabled="disabled" class="inputText w9 fl_left Black" />
</c:when>
<c:otherwise>
<input type="text" name="promBuyPrice" value="${obj.promBuyPrice}" class="inputText w9 fl_left" onfocus="promPriceFocus(this)" onchange="promBuyPriceChange(this)" onkeyup="promBuyPriceKeyUp(this,event)" onblur="promBuyPriceBlur(this)"/>
</c:otherwise>
</c:choose>
<input type="text" name="normalSalePrice" value="${obj.normSellPrice}" class="inputText w9 Black fl_left" readonly="readonly"/>
<c:choose><c:when test="${sellBegin==1 or pricePromType==2 }">
<input type="text" name="promSalePrice" value="${obj.promSellPrice}" disabled="disabled" class="inputText w9 fl_left Black" />
</c:when>
<c:otherwise>
<input type="text" name="promSalePrice" value="${obj.promSellPrice}" class="inputText w9 fl_left" onfocus="promPriceFocus(this)" onchange="promSalePriceChange(this)" onkeyup="promSalePriceKeyUp(this,event)" onblur="promSalePriceBlur(this)"/>
</c:otherwise></c:choose>
<input type="text" name="priceRanage" value="${obj.priceRange}" class="inputText w9 Black fl_left" readonly="readonly"/>
<input type="text" name="netProfit" value="${obj.profit}" class="inputText w9 Black fl_left" readonly="readonly"/>
<input type="hidden" name="buyPriceLimit" value="${obj.buyPriceLimit}"  readonly="readonly"/>
<input type="hidden" name="buyWhen" value="${obj.buyWhen}"  readonly="readonly"/>
<input type="hidden" name="headMinMargin" value="${obj.headMinMargin}"  readonly="readonly"/>
<input type="hidden" name="branchMinMargin" value="${obj.branchMinMargin}"  readonly="readonly"/>
</div>
</c:forEach>