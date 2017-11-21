<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/default.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />

<script type="text/javascript"
	src="${ctx}/shared/js/My97DatePicker/WdatePicker.js" charset="utf-8"></script>
<script type="text/javascript"
	src="${ctx}/shared/js/promotion/promotionCreate.js?t=1001"
	charset="utf-8"></script>
<script type="text/javascript">
	$(function() {
		$("input").attr("readonly","readonly");
		var pro_store_items = $(".pro_store_items").find(".item_on");
		var itemNo = $(pro_store_items).attr("name");
		showItemStoreSupList(itemNo,1);
	});
	
/* 	$(".pcmVOClickItem").die("click").live("click",function(){
		var itemNo = $(this).attr("name");
		showItemStoreSupList(itemNo);
	}); */
</script>
<style type="text/css">
.psi1 {
	margin-left: 40px;
}

.psi2 {
	margin-left: 73px;
}

.psi3 {
	margin-left: 215px;
}

.psi4 {
	margin-left: 32px;
}

.psi5 {
	margin-left: 15px;
}
/*overwrite*/
.item:hover {
	background: #99cc66;
}

.fl_left {
	margin-left: 3px;
}
.pro_store_tb, .pro_store_items {
    height:85%;padding-top:8px;
}
</style>
<div class="pro_store_item">
	<div class="pro_store_item1">
		<div class="top15">所选商品</div>
		<div class="pro_store_items">
			<c:forEach items="${pcmVOList }" var="pcmVO" varStatus="num">
				<c:if test="${num.index == 0}">
					<div name="${pcmVO.itemNo }" class="item item_on pcmVOClickItem">
						<span class="pstb_1">${pcmVO.itemNo }-${pcmVO.itemName }</span>
					</div>
				</c:if>
				<c:if test="${num.index != 0}">
					<div name="${pcmVO.itemNo }" class="item pcmVOClickItem">
						<span class="pstb_1">${pcmVO.itemNo }-${pcmVO.itemName }</span>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	<div class="pro_store_item2">
		<div class="top15">
			<span class="psi1">门店</span><span class="psi2">厂商</span> <span
				class="psi3">商品状态</span><span class="psi4">正常进价(元)</span> <span
				class="psi5">促销进价(元)</span>
		</div>
		<div class="pro_store_tb" id="promItemStoreMess_div">
			
		</div>
	</div>
</div>

