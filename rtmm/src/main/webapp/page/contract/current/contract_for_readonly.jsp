<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="CM" style="height: 180px;">
  <div class="inner_half">
      <div class="CM-bar">
          <div>合同基本信息</div>
      </div>
      <div class="CM-div">
              <div class="ig_top20">
                  <div class="icol_text w14"><span>合同编号</span></div>
                  <input type="text" class="inputText w20 fl_left" readonly="readonly" value="${contract.cntrtId}">
                  <div class="icol_text w7"><span>年份</span></div>
                  <input type="text" class="inputText w10 fl_left count_text" value="<c:if test="${not empty contract}">${contract.year}</c:if><c:if test="${empty contract}">${year}</c:if>">
                  <div class="icol_text w14"><span>合同状态</span></div>
                  <input type="text" class="inputText w15 fl_left" readonly="readonly" value="<auchan:getDictValue code="${contract.status}" mdgroup="CONTRACT_TMPL_IN_USE_IND"/>">
              </div>
              <div class="ig">
                  <div class="icol_text w14"><span>厂编</span></div>
                  <input type="text" class="inputText w15 fl_left" id="supNo" value="${contract.supNo}" >
                  
                  <input type="text" class="inputText w47 fl_left" id="supName" readonly="readonly" value="${supplier.supComVO.comName}">
              </div>
              <div class="ig">
                  <div class="icol_text w14"><span>税号</span></div>
                  <input type="text" class="inputText w40 fl_left" readonly="readonly" value="${contract.unifmNo}" id="unifmNo" >
                  <div class="icol_text w7"><span>税率</span></div>
	              <auchan:select4Vat _class="w20 supVatNo" id="supVatNo" name="supVatNo" value="${contract.supVatNo}" disabled="disabled"/>
              </div>
          <div class="ig">
                  <div class="icol_text w14"><span>预估营业额</span></div>
                  <input type="text" class="inputText w20 fl_left count_text" value="<fmt:formatNumber value='${contract.estmtPurchAmnt}' type='number' pattern='##########'/>" maxlength="10">
                  <div class="icol_text"><span>&nbsp;元&nbsp;&nbsp;预估毛利率</span></div>
                  <input type="text" class="inputText w20 fl_left" value="${contract.estmtMargin}">
                  <div class="icol_text"><span>%</span></div>
              </div>
          <div class="ig">
                  <div class="icol_text w14"><span>备注</span></div>
                  <input type="text" class="inputText w68 fl_left" value="${contract.memo}">
                  
              </div>
          </div>
  </div>
  <div class="inner_half">
      <div class="ig_top20">
                  <div class="icol_text w14"><span>课别</span></div>
                  <input type="text" class="inputText w15 fl_left" readonly="readonly"  value="${contract.catlgId}">
                  <input type="text" class="inputText w20 fl_left" readonly="readonly" value="${contract.catlgName}">
                  <div class="icol_text w7"><span>采购</span></div>
                  <input type="text" class="inputText w15" value="<c:if test="${not empty contract.buyer}"><auchan:getStuffName value="${contract.buyer}"/></c:if>">
       </div>
      <div class="ig">
      		<c:if test="${not empty supplier}">
                  <div class="icol_text w14"><span>厂商种类</span></div>
                  <input type="text" class="inputText w30 fl_left" id="supType" readonly="readonly" value="<auchan:getDictValue code="${supplier.supType}" mdgroup="SUPPLIER_SUP_TYPE"/>">
                  <div class="icol_text">&nbsp;合同标准&nbsp;</div>
                  <input type="text" class="inputText w12_5 fl_left" id="cntrtType" readonly="readonly" value="<auchan:getDictValue code="${supplier.cntrtType}" mdgroup="SUPPLIER_CONTRT_TYPE"/>">
                  <div class="icol_text">&nbsp;采购方式&nbsp;</div>
                  <input type="text" class="inputText w12_5 fl_left" id="buyMethd" readonly="readonly" value="<auchan:getDictValue code="${supplier.buyMethd}" mdgroup="SUPPLIER_BUY_METHD"/>">
            </c:if>
            <c:if test="${empty supplier}">
            	<div class="icol_text w14"><span>厂商种类</span></div>
            	<input type="hidden" name="">
                <input type="text" class="inputText w30 fl_left" id="supType" readonly="readonly">
                <div class="icol_text">&nbsp;合同标准&nbsp;</div>
                <input type="text" class="inputText w12_5 fl_left" id="contrtType" value="" readonly="readonly">
                <div class="icol_text">&nbsp;采购方式&nbsp;</div>
                <input type="text" class="inputText w12_5 fl_left" id="buyMethd" value="" readonly="readonly">
            </c:if>
              </div>
      <div class="ig">
                  <div class="icol_text w14"><span>有效期间</span></div>
                  <input class="inputText w20 fl_left" type="text" readonly="readonly" value="<c:if test="${not empty contract}"><fmt:formatDate pattern="yyyy-MM-dd" value="${contract.validStartDate}"/></c:if><c:if test="${empty contract}">${today}</c:if>" >
                  <div class="icol_text">&nbsp;-&nbsp;</div>
                  <input class="inputText w20 fl_left" type="text" readonly="readonly" value="<c:if test="${not empty contract}"><fmt:formatDate pattern="yyyy-MM-dd" value="${contract.validEndDate}"/></c:if><c:if test="${empty contract}">${lastDay}</c:if>">
                  <input type="checkbox" class="fl_left" style="margin:6px auto auto 7px;"
                  <c:if test="${contract.autoExtnd eq 1}">checked="checked"</c:if> disabled="disabled"
                  >
                    <div class="icol_text">&nbsp;自动续约&nbsp;</div>
                </div>
        <div class="ig">
					<div class="icol_text w14"><span>付款天数</span></div>
                    <input type="text" class="inputText w30 Black fl_left payPerd" readonly="readonly" value="${payment.payPerd}">
                    <div class="icol_text">&nbsp;天&nbsp;&nbsp;付款周期&nbsp;</div>
                    <input type="text" class="inputText w20 Black fl_left frontPay" id="buyMethd" readonly="readonly" value="<auchan:getDictValue code="${payment.frontPay}" mdgroup="SUP_PAYMENT_FRONT_PAY"/>">
                    
                </div>
        <div class="ig">
                    <div class="icol_text w14"><span>凭证</span></div>
                    <input type="text" class="inputText w30" value="<auchan:getDictValue mdgroup="CONTRACT_REF" code="${contract.ref}"/>">
                </div>
    </div>
</div>
<script type="text/javascript">
$(function(){
	$('.detail input').attr('readonly','readonly');
});
</script>