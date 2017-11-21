<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.cks {
	margin-top: 6px;
	float: left;
}

.w2x {
	width: 35.2%;
	width: 35.5% \9;
}
</style>

<div class="ig_top10 validSummary">
	<div class="icol_text">正确条目数&nbsp;</div>
	<input type="hidden" id="excelLines" value="${totalCount }">
	<input type="text" class="inputText w5 fl_left align_right" id="successCount" readonly="readonly" />
	<div class="icol_text">&nbsp;&nbsp;订购总数量&nbsp;</div>
	<input id="totalQuantity" type="text" class="inputText w10 fl_left align_right" value="<fmt:formatNumber value="${validInfo.rpTotQty }" pattern="#" />" readonly="readonly" />
	<div class="icol_text">&nbsp;&nbsp;订购总金额&nbsp;</div>
	<input id="totalAmount" type="text" class="inputText w10 fl_left align_right" value="<fmt:formatNumber value="${validInfo.rpTotAmnt }" pattern="#.##" minFractionDigits="2"/>" readonly="readonly" />
	<div class="icol_text">&nbsp;元</div>
</div>

<div style="height: 130px;" class="CM">
	<div class="inner_half">
		<div class="CM-bar">
			<div>保留计划基本信息</div>
		</div>
		<div class="CM-div">
			<div class="ig_top20">
				<div class="icol_text w20">
					<span>RP DM</span>
				</div>
				<input type="text" class="inputText fl_left Black align_right" readonly="readonly" value='${rpDmVO.rdmNo }' style="width:60px;" />
			</div>
			<div class="ig">
				<div class="icol_text w20">
					<span class="icol_text">课别&nbsp;</span>
				</div>
				<div class="iconPut fl_left" style="width: 61px;">
					<input class="align_right" style="width: 68%" type="text" id="catlgId" name='catlgId' value='${rpDmVO.catlgId }' readonly="readonly" />
					<div class="ListWin"></div>
				</div>
				<div class="fl_left">&nbsp;</div>
				<input type="text" class="inputText w30 fl_left Black" id="catlgName" name="catlgName" readonly="readonly" value="${rpDmVO.catlgName }" />
			</div>
			<div class="ig">
				<div class="icol_text w20">
					<span>物流中心</span>
				</div>
				<input type="text" class="inputText w20 fl_left align_right" readonly="readonly" value='${rpDmVO.dcStoreName }'  /> 
			</div>
		</div>
	</div>
	<div class="inner_half">
		<div class="ig_top20">
			<div class="icol_text">
				<span>需要门店确认</span>
			</div>
			<input type="checkbox" class="cks" 
			<c:if test="${rpDmVO.stCnfrmInd == 1 }" >
				checked="checked"
			</c:if>
				disabled="disabled">
			<div class="icol_text">
				<span>&nbsp;&nbsp;&nbsp;门店确认期间</span>
			</div>
			<input class="Wdate w20 fl_left Black" readonly="readonly" name="stBeginDate" type="text" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${rpDmVO.stCnfrmBeginDate }' />">
			<div class="icol_text">
				<span>&nbsp;-</span>
			</div>
			<input class="Wdate w20 fl_left Black" readonly="readonly" name="stEndDate" type="text" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${rpDmVO.stCnfrmEndDate }' />">
		</div>
		<div class="ig">
			<!--<div class="icol_text"><span>需要门店确认</span></div>
                                <input type="checkbox" class="cks" />-->
			<div class="icol_text w2x">
				<span>门店补货期间</span>
			</div>
			<input class="Wdate w20 fl_left Black" type="text" readonly="readonly"  name="repBeginDate" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${rpDmVO.stRepBeginDate }' />">
			<div class="icol_text">
				<span>&nbsp;-</span>
			</div>
			<input class="Wdate w20 fl_left Black" type="text" readonly="readonly" name="repEndDate" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${rpDmVO.stRepEndDate }' />">
		</div>
		<div class="ig">
			<span class="icol_text">RP总建议量&nbsp;</span> <input type="text" class="inputText w20 fl_left Black align_right" readonly="readonly" value="<fmt:formatNumber value="${validInfo.rpTotQty }" pattern="#.##" minFractionDigits="2"/>">&nbsp;&nbsp;
			<span class="icol_text" style="margin-left:60px;">RP总金额&nbsp;</span> <input type="text" class="inputText w20 Black align_right" readonly="readonly" value="<fmt:formatNumber value="${validInfo.rpTotAmnt }" pattern="#.##" minFractionDigits="2"/>" >&nbsp;元
		</div>
	</div>
</div>