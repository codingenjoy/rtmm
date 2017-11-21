<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="/tld/auchan" prefix="auchan"%>
<div class="CM-div">
	<div class="pro_store_item">
		<div class="pro_store_item1">
			<div class="top15">所选商品</div>
			<div class="pro_store_items" style="height: 75%;">
				<c:forEach items="${itemList }" var="itemVO" >
					<c:choose>
						<c:when test="${unitType == 0 }">
							<div class="item item_on" checkOrders="">
								<span itemNameValue="${itemVO.itemName }" itemNoValue="${itemVO.itemNo }" class="pstb_1" onclick="switchItemStoreMess(this)" >${itemVO.itemNo }-${itemVO.itemName }</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="item" checkOrders="">
								<span itemNameValue="${itemVO.itemName }" itemNoValue="${itemVO.itemNo }" class="pstb_1" onclick="switchItemStoreMess(this)" >${itemVO.itemNo }-${itemVO.itemName }</span><span class="pstb_del2" onclick="delItemSupMessMethods(this)" ></span>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<div class="ig_top10">
				<c:if test="${itemList.size() == 1 }">
					<div id="showDeleteItems" class="createNewBar_off" ></div>
				</c:if>
				<c:if test="${itemList.size() > 1 }">
					<div id="showDeleteItems" class="createNewBar" onclick="addSelectedItem(this)"></div>
				</c:if>
			</div>
		</div>
		<c:forEach items="${itemList }" var="itemVO" >
			<div class="pro_store_item2" style="display:none" >
				<table>
					<tr>
						<td class="psi0">&nbsp;</td>
						<td class="psi1">门店</td>
						<td class="psi2">厂商</td>
						<td class="psi3">&nbsp;</td>
						<td class="psi4">商品状态</td>
						<td class="psi5">正常进价(元)</td>
						<td class="psi6">促销进价(元)</td>
					</tr>
				</table>
				<div class="fu_div">
					<input type="text" class="inputText w12_5 updatePriceAll" onkeyup="inputToInputDoubleNumber(this)" style="margin-left: 565px;" value="" />
				</div>
				<div class="pro_store_tb promItemStoreMess_div" style="height: 65%;">
					<div class="top5"></div>
					<c:forEach var="storeVO" items="${storeList }">
						<c:if test="${itemVO.itemNo == storeVO.itemNo }">
							<div class="ig" >
								<form onSubmit="return false;">
									<input type="checkbox" class="fl_left ck isChecksProm"> 
									<input type="hidden" value="${promStoreItemVO.unitType}" name="unitType"> 
									<input type="hidden" value="${promStoreItemVO.promUnitNo}" name="promUnitNo">
									<input type="hidden" value="${itemVO.itemNo}" name="itemNo"> 
									<input type="hidden" value="${storeVO.storeNo}" name="storeNo"> 
									<input type="text" value="${storeVO.storeNo}-${storeVO.storeName}" class="inputText w15 fl_left Black" readonly="readonly" name="storeName"> 
									<input type="text" value="${storeVO.stMainSupNo}" readonly="readonly" class="w10 fl_left inputText" name="promSupNo"> 
									<input type="text" value="${storeVO.mainComName}" readonly="readonly" class="inputText w28 fl_left Black" name="comName"> 
									<input type="text" value="<auchan:getDictValue code="${storeVO.status}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>" readonly="readonly" class="inputText w12_5 fl_left Black" name="statusName"> 
									<input type="text" value="${storeVO.normBuyPrice}" class="inputText w12_5 fl_left Black" readonly="readonly" name="normBuyPrice"> 
									<input type="text" value="" onkeyup="inputToInputDoubleNumber(this);" buyPriceLimit="${storeVO.buyPriceLimit}" buywhen="${storeVO.buyWhen}" onfocus="{$(this).removeClass('errorInput');$(this).attr('title','');}" class="inputText w12_5 fl_left errorInput" name="promBuyPrice">
									<input type="hidden" value="${storeVO.normSellPrice}" name="normSellPrice"> 
									<%-- <input type="hidden" value="${promStoreItemVO.itemName}" name="itemName"> --%>
									<input type="hidden" value="${storeVO.buyPriceLimit}" name="buyPriceLimit">
									<input type="hidden" value="${storeVO.buyWhen}" name="buyWhen">
									<input type="hidden" value="${orderStr }" name="checkOrders">
								</form>
							</div>
						</c:if>
					</c:forEach>
				</div>
				<div class="top10">
					<input class="fl_left top3 isCheckAllsProm" type="checkbox" />
					<div class="deleteBar fl_left deleteCheckedsProm" checkUnitType="" checkItemNo="" checkPromNo=""></div>
					<div class="lineToolbar fl_left"></div>
					<div class="createNewBar fl_left" id="promItemStore_div" checkUnitType="" checkItemNo="" checkPromNo="" onclick="addStoreSupMess(this)"></div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>


