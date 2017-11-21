<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
._w120 {
	width: 120px;
}

._w80 {
	width: 80px;
}
</style>
<div class="jjxs_1">
	<span id="price1" class="item item_on" style="margin-left: 0px;" onclick="setSearchTypeVal('buy');pageQuery();">进价信息</span>
	<span id="price2" class="item" onclick="setSearchTypeVal('sell');pageQuery();">售价信息</span>
</div>
<div class="txm_info price1">
	<div class="txm_title">
		<span style="margin-left: 65px;">进价(元)</span>
		<span style="margin-left: 85px;">生效日</span> 
		<span style="margin-left: 65px;">发起日期</span>
		<span style="margin-left: 80px;">发起人</span> 
		<span style="margin-left: 80px;">渠道</span>
	</div>

	<div class="price_tb">
		<c:if test="${priceChgList != null}">
			<c:forEach items="${priceChgList}" var="priceChg">
				<div class="ig">
					<input type="text" class="w20 inputText" value="${priceChg.buyPrice }" />
					<div class="fl_right" style="width: 120px;">
						<input class="inputText _w120" 
							<c:if test="${priceChg.chngChanl != null}">
		                          	value="<auchan:getDictValue code="${priceChg.chngChanl}" mdgroup="ITEM_PRICE_CHANGE_REQUEST_CHNG_CHANNEL"></auchan:getDictValue>"
		                    </c:if>
						 />
					</div>
					<input type="text" class="inputText jxs" value="${priceChg.reqstBy }" />
					<div class="iconPut jxs">
						<input type="text" style="width: 79%" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${priceChg.reqstDate }"/>" />
					</div>
					<div class="iconPut jxs">
						<input type="text" style="width: 79%" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${priceChg.bpActiveDate}"/>" />
					</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
</div>
