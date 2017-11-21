<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="CM" style="height: 180px;">
	<div class="inner_half">
		<div class="CM-bar">
			<div>合同基本信息</div>
		</div>
		<div class="CM-div">
			<div class="ig_top20">
				<div class="icol_text w14">
					<span>合同编号</span>
				</div>
				<input type="text" class="inputText count_text w20 fl_left" name="cntrtId" value="${contractVO.cntrtId}" id="cntrtId" placeholder="输入合同编号"
					maxlength="15">
				<div class="icol_text w7">
					<span>年份</span>
				</div>
				<input type="text" class="inputText w10 fl_left count_text align_right" name="year" value="${contractVO.year}" id="year" placeholder="输入年份" maxlength="4">
				<div class="icol_text w14">
					<span>合同状态</span>
				</div>
				<input type="text" class="inputText w15 fl_left" readonly="readonly"
					value='<auchan:getDictValue code="${contractVO.status }" mdgroup="CONTRIBUTION_GRP_ACCOUNT_STATUS"></auchan:getDictValue>'>
			</div>
			<div class="ig">
				<div class="icol_text w14">
					<span>厂编</span>
				</div>
				<div class="iconPut w20 fl_left">
					<input class="w80 count_text" type="text" name="supNo" value="${contractVO.supNo}" id="supNo" placeholder="输入厂编" maxlength="8">
					<div class="ListWin" <c:if test="${empty contractVO }"> onclick="chooseOfSupplier()" </c:if>></div>
				</div>
				<input type="text" class="inputText w47 fl_left" readonly="readonly" id="supName" value="${contractVO.supName }">
			</div>
			<div class="ig">
				<div class="icol_text w14">
					<span>税号</span>
				</div>
				<input type="text" class="inputText w40 fl_left" readonly="readonly" value="${contractVO.unifmNo}">
				<div class="icol_text w7">
					<span>税率</span>
				</div> 
				<input type="text" class="inputText w20 fl_left align_right" readonly="readonly" <c:if test="${not empty contractVO.supVatNo}" > value="${contractVO.supVatNo}-${contractVO.supVatVaule}%" </c:if> >
			</div>
			<div class="ig">
				<div class="icol_text w14">
					<span>预估营业额</span>
				</div>
				<input type="text" class="inputText w20 fl_left align_right" readonly="readonly"
					value="<fmt:formatNumber value='${contractVO.estmtPurchAmnt}' type='number' pattern='##########'/>">
				<div class="icol_text">
					<span>&nbsp;元&nbsp;&nbsp;预估毛利率</span>
				</div>
				<input type="text" class="inputText w20 fl_left align_right" readonly="readonly"
					value="<fmt:formatNumber value='${contractVO.estmtMargin}' type='number' pattern='########.##'/>">
				<div class="icol_text">
					<span>%</span>
				</div>
			</div>
			<div class="ig">
				<div class="icol_text w14">
					<span>备注</span>
				</div>
				<input type="text" class="inputText w68 fl_left" readonly="readonly" value="${contractVO.memo}">

			</div>
		</div>
	</div>
	<div class="inner_half">
		<div class="ig_top20">
			<div class="icol_text w14">
				<span>课别</span>
			</div>
			<div class="iconPut w15 fl_left">
				<input class="w70" type="text" readonly="readonly" value="${contractVO.catlgId}">
				<div class="ListWin"></div>
			</div>
			<input type="text" class="inputText w20 fl_left" readonly="readonly" style="margin-left: 8px;" value="${contractVO.catlgName }">
			<div class="icol_text w7">
				<span>采购</span>
			</div>
			<input type="text" class="inputText w12_5" readonly="readonly" <c:if test = "${not empty contractVO.buyer }" > value='<auchan:getStuffName value="${contractVO.buyer}"/> '</c:if>>
		</div>
		<div class="ig">
			<div class="icol_text w14">
				<span>厂商种类</span>
			</div>
			<input type="text" class="inputText w30 fl_left" readonly="readonly"
				value='<auchan:getDictValue code="${extSupVO.supType}" mdgroup="SUPPLIER_SUP_TYPE"></auchan:getDictValue>'>
			<div class="icol_text" style="margin-left: 16px;">&nbsp;合同标准&nbsp;</div>
			<input type="text" class="inputText w12_5 fl_left" readonly="readonly"
				value='<auchan:getDictValue code="${extSupVO.cntrtType}" mdgroup="SUPPLIER_CONTRT_TYPE"></auchan:getDictValue>'>
			<div class="icol_text">&nbsp;采购方式&nbsp;</div>
			<input type="text" class="inputText w12_5 fl_left" readonly="readonly"
				value='<auchan:getDictValue code="${extSupVO.buyMethd}" mdgroup="SUPPLIER_BUY_METHD"></auchan:getDictValue>'>
		</div>
		<div class="ig">
			<div class="icol_text w14">
				<span>有效期间</span>
			</div>
			<input class="Wdate w20 fl_left" type="text" readonly="readonly"
				value='<fmt:formatDate pattern="yyyy-MM-dd" value="${contractVO.validStartDate}"/>'>
			<div class="icol_text">&nbsp;-&nbsp;</div>
			<input class="Wdate w20 fl_left" type="text" readonly="readonly" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${contractVO.validEndDate}"/>'>
			<input type="checkbox" class="fl_left" disabled="disabled" style="margin: 6px auto auto 7px;"
				<c:if test="${contractVO.autoExtnd == 1 }">
				checked="checked"
			</c:if>>
			<div class="icol_text">&nbsp;自动续约&nbsp;</div>
		</div>
		<div class="ig">
			<div class="icol_text w14">
				<span>付款天数</span>
			</div>
			<input type="text" class="inputText w15 fl_left align_right" readonly="readonly" value="${supPaymentVO.payPerd}">
			<div class="icol_text">&nbsp;天&nbsp;&nbsp;付款周期&nbsp;</div>
			<auchan:select id="lockSttusSearch" _class="w20" disabled="disabled" value="${supPaymentVO.frontPay}" mdgroup="SUP_PAYMENT_FRONT_PAY"></auchan:select>
		</div>
		<div class="ig">
			<div class="icol_text w14">
				<span>凭证</span>
			</div>
			<auchan:select id="lockSttusSearch" _class="w30" disabled="disabled" value="${contractVO.ref}" mdgroup="CONTRACT_REF"></auchan:select>
		</div>
	</div>
</div>