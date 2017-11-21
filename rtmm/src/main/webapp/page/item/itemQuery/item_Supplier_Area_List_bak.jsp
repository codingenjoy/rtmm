<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<div class="fx_div21">
	<span class="zr_11">所属区域</span> 
	<span class="zr_12">所属省份</span> 
	<span class="zr_13">所属城市</span> 
	<span class="zr_14">店号</span> 
	<span class="zr_15">状态</span> 
	<span class="zr_16">当前进价（元）</span> 
	<span class="zr_17">当前售价（元）</span> 
	<span class="zr_18">净成本（元）</span>
	<span class="zr_19">净毛率</span>
	<span class="zr_20">买价限制</span>
</div>
<div class="zz_2 itemSuppList">
	<c:if test="${not empty page.result }">
		<c:forEach items="${page.result}" var="vo">
			<div class="row">
				<input type="text" class="inputText w7 fl_left" value="${vo.regnName }" readonly="readonly"/> 
				<input type="text" class="inputText w7 fl_left" value="${vo.provName }" readonly="readonly"/> 
				<input type="text" class="inputText w10 fl_left" value="${vo.cityName }" readonly="readonly"/> 
				<input type="text" class="inputText w15 fl_left" value="${vo.storeNo }-${vo.storeName }" readonly="readonly"/> 
				<input type="text" class="inputText w10 fl_left" value="<auchan:getDictValue  code="${vo.status}" mdgroup="SUP_STORE_SEC_INFO_STATUS" ></auchan:getDictValue>" readonly="readonly"/> 
				<input type="text" class="inputText w9 fl_left align_right" value="${vo.normBuyPrice}" readonly="readonly"/> 
				<input type="text" class="inputText w9 fl_left align_right" value="${vo.normSellPrice}" readonly="readonly"/> 
				<input type="text" class="inputText w7 fl_left align_right" value="${vo.netCost}" readonly="readonly"/>
				<input type="text" class="inputText w7 fl_left align_right" readonly="readonly"
					<c:if test="${vo.normSellPrice ne null && vo.vatVal ne null && vo.netCost ne null }">
						value="<fmt:formatNumber value="${((vo.normSellPrice*(1-(vo.vatVal/100)))-vo.netCost)/(vo.normSellPrice*(1-(vo.vatVal/100))) }" type="percent" pattern="#0.00%"/>"
						 <%-- value="<fmt:formatNumber value="${((vo.normSellPrice*(1-(vo.vatVal/100)))-vo.netCost)/(vo.normSellPrice*(1-(vo.vatVal/100)))" type="percent" pattern="#0.00%"/>"
						--%>
					</c:if>
				/>
				<input type="text" class="inputText w7 fl_left align_right" value="${vo.buyPriceLimit}" readonly="readonly"/>
				<div class="clearBoth"></div>
			</div>
		</c:forEach>
	</c:if>
</div>
<%-- <jsp:include page="/page/commons/pageSet.jsp"></jsp:include>  --%>
	                               
