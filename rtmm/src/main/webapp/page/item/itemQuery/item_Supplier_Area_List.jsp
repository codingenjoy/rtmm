<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="htable_div">
    <table>
    <thead>
        <tr>
            <td><div class="t_cols" style="width:40px;">区域</div></td>
            <td><div class="t_cols" style="width:50px;">省份</div></td>
            <td><div class="t_cols" style="width:60px;">城市</div></td>
            <td><div class="t_cols" style="width:110px;">店号</div></td>
            <td><div class="t_cols" style="width:90px;">状态</div></td>
            <td><div class="t_cols" style="width:140px;">主厂商</div></td>
            <td><div class="t_cols" style="width:70px;">当前进价</div></td>
            <td><div class="t_cols" style="width:70px;">当前售价</div></td>
            <td><div class="t_cols" style="width:60px;">净成本</div></td>
            <td><div class="t_cols" style="width:70px;">净毛利率%</div></td>
            <td><div class="t_cols" style="width:75px;">库存</div></td>
            <td><div class="t_cols" style="width:70px;">买价限制</div></td>
            <td><div style="width:20px;">&nbsp;</div></td>
           </tr>
    </thead>
	</table>
</div>
<div class="btable_div itemSuppAreaList" style="height:398px;">
    <table  class="single_tb w100">
    	<c:if test="${not empty page.result }">
    	<c:forEach items="${page.result}" var="vo">
           <tr >
              <td style="width:41px;">${vo.regnName }</td>
              <td style="width:51px;">${vo.provName }</td>
              <td style="width:61px;">${vo.cityName }</td>
              <td style="width:111px;">${vo.storeNo }-${vo.storeName }</td>
              <td style="width:91px;"><auchan:getDictValue  code="${vo.status}" mdgroup="ITEM_STORE_INFO_STATUS" ></auchan:getDictValue></td>
              <td style="width:141px;" title="${vo.stMainSupNo }-${vo.mainComName }">${vo.stMainSupNo }-${vo.mainComName }</td>
              <td style="width:71px;" class="align_right"><span style="margin-right:5px;"><fmt:formatNumber value="${vo.normBuyPrice}" pattern="#0.0000"/></span></td>
              <td style="width:71px;" class="align_right"><span style="margin-right:5px;"><fmt:formatNumber value="${vo.normSellPrice}" pattern="#0.00"/></span></td>
              <td style="width:61px;" class="align_right"><span style="margin-right:5px;"><fmt:formatNumber value="${vo.netCost}" pattern="#0.0000"/></span></td>
              <td style="width:71px;" class="align_right"><span style="margin-right:5px;">
              		<c:if test="${vo.normSellPrice ne null && vo.normSellPrice ne 0 && vo.vatVal ne null && vo.netCost ne null }">
						<fmt:formatNumber value="${((vo.normSellPrice/(1+(vo.vatVal/100)))-vo.netCost)/(vo.normSellPrice/(1+(vo.vatVal/100))) }" type="percent" pattern="#0.00%"/>
					</c:if></span>
			</td>
              <td style="width:76px;" class="align_right"><span style="margin-right:5px;"><fmt:formatNumber value="${vo.stock}" pattern="#0.000"/></span></span></td>
              <td style="width:71px;" class="align_right"><span style="margin-right:5px;"><fmt:formatNumber value="${vo.buyPriceLimit}" pattern="#0.0000"/></span></span></td>
              <td style="width:auto">&nbsp;</td>
               </tr>
    	</c:forEach>
    	</c:if>
    </table> 
</div>
<!-- <div class="fx_div21">
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
</div> -->
<%-- <div class="zz_2 itemSuppList">
	<c:if test="${not empty page.result }">
		<c:forEach items="${page.result}" var="vo">
			<div class="row">
				<input type="text" class="inputText w7 fl_left" value="${vo.regnName }" readonly="readonly"/> 
				<input type="text" class="inputText w7 fl_left" value="${vo.provName }" readonly="readonly"/> 
				<input type="text" class="inputText w10 fl_left" value="${vo.cityName }" readonly="readonly"/> 
				<input type="text" class="inputText w15 fl_left" value="${vo.storeNo }-${vo.storeName }" readonly="readonly"/> 
				<input type="text" class="inputText w10 fl_left" value="<auchan:getDictValue  code="${vo.status}" mdgroup="ITEM_STORE_INFO_STATUS" ></auchan:getDictValue>" readonly="readonly"/> 
				<input type="text" class="inputText w9 fl_left align_right" value="${vo.normBuyPrice}" readonly="readonly"/> 
				<input type="text" class="inputText w9 fl_left align_right" value="${vo.normSellPrice}" readonly="readonly"/> 
				<input type="text" class="inputText w7 fl_left align_right" value="${vo.netCost}" readonly="readonly"/>
				<input type="text" class="inputText w7 fl_left align_right" readonly="readonly"
					<c:if test="${vo.normSellPrice ne null && vo.vatVal ne null && vo.netCost ne null }">
						value="<fmt:formatNumber value="${((vo.normSellPrice*(1-(vo.vatVal/100)))-vo.netCost)/(vo.normSellPrice*(1-(vo.vatVal/100))) }" type="percent" pattern="#0.00%"/>"
					</c:if>
				/>
				<input type="text" class="inputText w7 fl_left align_right" value="${vo.buyPriceLimit}" readonly="readonly"/>
				<div class="clearBoth"></div>
			</div>
		</c:forEach>
	</c:if>
</div> --%>
	                               
