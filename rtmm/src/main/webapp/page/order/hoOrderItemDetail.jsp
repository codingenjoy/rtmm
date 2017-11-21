<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="storeDetailInfo-${itemNo }" class="store" >
	<c:forEach var="item" items="${itemList}">
		<div class='ig_padding'>
			<input type='text' class='inputText w11 fl_left' readonly='readonly'
				title="${item.storeNo}-${item.storeName}"
				value="${item.storeNo}-${item.storeName}" />
			<input type='text' class='inputText w8 fl_left' readonly='readonly'
				value="<auchan:getDictValue code="${item.itemSttus}" mdgroup="ITEM_BASIC_STATUS"></auchan:getDictValue>" />
			<input type='text' class='inputText w8 fl_left ' readonly='readonly'
				value="${item.promNo}" />
			<input type='text' class='inputText w8 fl_left align_right'
				readonly='readonly' value="${item.ordQty}" />
			<input type='text' class='inputText w5 fl_left align_right'
				readonly='readonly' value="<fmt:formatNumber value="${item.presOrdQty}" type="number" pattern="#.###"/>" />
			<input type='text' class='inputText w8 fl_left align_right'
				readonly='readonly'
				value="<fmt:formatNumber value="${item.buyPrice}" type="number" pattern="#.####"/>" />
			<input type='text' class='inputText w8 fl_left align_right'
				readonly='readonly' value="${item.ordMultiParm }" />
			<input type='text' class='inputText w5 fl_left align_right'
				readonly='readonly' value="${item.buyVatVal}%" />
			<input type='text' class='inputText w8 fl_left align_right'
				readonly='readonly' readonly='readonly' value="${item.netCost }" />
			<input type='text' class='inputText w8 fl_left align_right'
				readonly='readonly' value="${item.dms }" />
			<input type='text' class='inputText w8 fl_left align_right'
				readonly='readonly' readonly='readonly' value="${item.recvbleQty }" />
			<input type='text' class='inputText w8 fl_left align_right'
				readonly='readonly' value="${item.stock }" />
			<div class='clearBoth'></div>
		</div>
	</c:forEach>
</div>