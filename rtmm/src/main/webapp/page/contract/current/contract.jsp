<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link href="${ctx}/shared/themes/theme2/css/jquery.autocomplete.css" rel="stylesheet" type="text/css" />
<script src="${ctx}/shared/js/jquery/auto/jquery.autocomplete.js" type="text/javascript"></script>
<div class="CM" style="height: 180px;">
<form action="" onsubmit="return false;" id="contractForm">
  <div class="inner_half">
      <div class="CM-bar">
          <div>合同基本信息</div>
      </div>
      <div class="CM-div">
              <div class="ig_top20">
                  <div class="icol_text w14"><span>合同编号</span></div>
                  <input type="hidden" id="taskId" name="taskId" value="${taskId}">
                  <input type="text" class="inputText w20 Black fl_left cntrtId" readonly="readonly" name="cntrtId" value="${contract.cntrtId}">
                  <div class="icol_text w7"><span>年份</span></div>
                  <input type="text" class="inputText w10 fl_left count_text" readonly="readonly" name="year" value="<c:if test="${not empty contract}">${contract.year}</c:if><c:if test="${empty contract}">${year}</c:if>">
                  <div class="icol_text w14"><span>合同状态</span></div>
                  <c:if test="${not empty contract}">
                  <input type="text" class="inputText w15 Black fl_left Blue" readonly="readonly" value="<auchan:getDictValue code="${contract.status}" mdgroup="CONTRACT_TMPL_IN_USE_IND"/>">
                  <input type="hidden" name="status" class="inputText w15 Black fl_left" value="${contract.status}">
                  </c:if>
                  <c:if test="${empty contract}">
                  <input type="text" class="inputText w15 Black fl_left Blue" readonly="readonly" value="<auchan:getDictValue code="1" mdgroup="CONTRACT_TMPL_IN_USE_IND"/>">
                  <input type="hidden" name="status" class="inputText w15 Black fl_left" value="1">
                  </c:if>
              </div>
              <div class="ig">
                  <div class="icol_text w14"><span>厂编</span></div>
                  <c:if test="${empty contract}">
                  <div class="iconPut w20 fl_left">
                     <!--  <input class="w80" type="text"/> -->
                  	  <input type="text" class="w80 supNo count_text mustInput" maxlength="8" name="supNo" id="supNo" value="${contract.supNo}" onblur="supplierBlur(this);" onKeyDown="supplierKeydown(event,this);">
                      <div class="ListWin" onclick="chooContractSupplier()"></div>
                  </div>
                  </c:if>
                  <c:if test="${not empty contract}">
                  <input type="text" class="inputText supNo w20 fl_left Black" readonly="readonly" name="supNo" id="supNo" value="${contract.supNo}">
                  </c:if>
                  <input type="text" class="inputText w47 fl_left Black supName" id="supName" value="${supplier.supComVO.comName}" readonly="readonly">
              </div>
              <div class="ig">
                  <div class="icol_text w14"><span>税号</span></div>
                  <input type="text" class="inputText w40 Black fl_left unifmNo" readonly="readonly" value="${contract.unifmNo}" id="unifmNo" name="unifmNo">
                  <div class="icol_text w7"><span>税率</span></div>
                  <auchan:select4Vat _class="w20 supVatNo mustInput" name="supVatNo" value="${contract.supVatNo}" />
              </div>
          <div class="ig">
                  <div class="icol_text w14"><span>预估营业额</span></div>
                  <input type="text" class="inputText w20 fl_left count_text mustInput" value="<fmt:formatNumber value='${contract.estmtPurchAmnt}' type='number' pattern='##########'/>" name="estmtPurchAmnt" maxlength="10">
                  <div class="icol_text"><span>&nbsp;元&nbsp;&nbsp;预估毛利率</span></div>
                  <input type="text" class="inputText w20 fl_left double_text_with_len" intval="8" decval="2" value="${contract.estmtMargin}" name="estmtMargin">
                  <div class="icol_text"><span>%</span></div>
              </div>
          <div class="ig">
                  <div class="icol_text w14"><span>备注</span></div>
                  <input type="text" class="inputText w68 fl_left" name="memo" value="${contract.memo}" onkeyup="limMemo(this)">
                  
              </div>
          </div>
  </div>
  <div class="inner_half">
      <div class="ig_top20">
                  <div class="icol_text w14"><span>课别</span></div>
                  <div class="iconPut w15 fl_left">
                      <input class="w70" type="hidden">
                      <input name="divNo" type="hidden" id="divNo" value="">
                      <input class="w70 count_text mustInput <c:if test="${not empty contract.catlgId}">Black</c:if>" preval="${contract.catlgId}" readonly="readonly" type="text" id="kebieInput" name="catlgId" value="${contract.catlgId}" onblur="isContractExists($('#contractForm input[name=supNo]').val(),$(this).val())">
                      <div class="ListWin" onclick="$(this).prev().focus();$(this).prev().click();"></div>
                  </div>
                  <input type="text" class="inputText w20 fl_left Black mustInput" readonly="readonly" id="kebieInputValue" value="${contract.catlgName}">
                  <div class="icol_text w7"><span>采购</span></div> 
                  
                  <input type="hidden" class="inputText w15" id="buyInputValue" name="buyer" readonly="readonly" value="${contract.buyer}">
                  <input type="text" class="inputText w15 mustInput" id="buyInput" readonly="readonly" value="<c:if test="${not empty contract.buyer}"><auchan:getStuffName value="${contract.buyer}"/></c:if><c:if test="${isBuyer eq true}">${staffForName}</c:if>">
       </div>
      <div class="ig">
      		<c:if test="${not empty supplier}">
                  <div class="icol_text w14"><span>厂商种类</span></div>
                  <input type="text" class="inputText w30 Black fl_left supType" id="supType" readonly="readonly" value="<auchan:getDictValue code="${supplier.supType}" mdgroup="SUPPLIER_SUP_TYPE"/>" readonly="readonly">
                  <div class="icol_text">&nbsp;合同标准&nbsp;</div>
                  <input type="text" class="inputText w12_5 Black fl_left cntrtType" id="cntrtType" readonly="readonly" value="<auchan:getDictValue code="${supplier.cntrtType}" mdgroup="SUPPLIER_CONTRT_TYPE"/>">
                  <div class="icol_text">&nbsp;采购方式&nbsp;</div>
                  <input type="text" class="inputText w12_5 Black fl_left buyMethd" id="buyMethd" readonly="readonly" value="<auchan:getDictValue code="${supplier.buyMethd}" mdgroup="SUPPLIER_BUY_METHD"/>">
            </c:if>
            <c:if test="${empty supplier}">
            	<div class="icol_text w14"><span>厂商种类</span></div>
            	<input type="hidden" name="">
                <input type="text" class="inputText w30 Black fl_left supType" id="supType" readonly="readonly">
                <div class="icol_text">&nbsp;合同标准&nbsp;</div>
                <input type="text" class="inputText w12_5 Black fl_left cntrtType" id="contrtType" readonly="readonly" value="">
                <div class="icol_text">&nbsp;采购方式&nbsp;</div>
                <input type="text" class="inputText w12_5 Black fl_left buyMethd" id="buyMethd" readonly="readonly" value="">
            </c:if>
              </div>
      <div class="ig">
                  <div class="icol_text w14"><span>有效期间</span></div>
                  <input class="Wdate w20 fl_left" type="text" readonly="readonly" value="<c:if test="${not empty contract}"><fmt:formatDate pattern="yyyy-MM-dd" value="${contract.validStartDate}"/></c:if><c:if test="${empty contract}">${today}</c:if>" name="validStartDate">
                  <div class="icol_text">&nbsp;-&nbsp;</div>
                  <input class="Wdate w20 fl_left" type="text" readonly="readonly" value="<c:if test="${not empty contract}"><fmt:formatDate pattern="yyyy-MM-dd" value="${contract.validEndDate}"/></c:if><c:if test="${empty contract}">${lastDay}</c:if>" name="validEndDate">
                  <input type="checkbox" class="fl_left" style="margin:6px auto auto 7px;"<c:if test="${empty contract.autoExtnd || contract.autoExtnd==1}"> checked="checked"</c:if> name="autoExtnd" value="1">
                    <div class="icol_text">&nbsp;自动续约&nbsp;</div>
                </div>
        <div class="ig">
                    <div class="icol_text w14"><span>付款天数</span></div>
                    <input type="text" class="inputText w30 Black fl_left payPerd" readonly="readonly" value="${payment.payPerd}">
                    <div class="icol_text">&nbsp;天&nbsp;&nbsp;付款周期&nbsp;</div>
                    <input type="text" class="inputText w20 Black fl_left frontPay" id="frontPay" readonly="readonly" value="<auchan:getDictValue code="${payment.frontPay}" mdgroup="SUP_PAYMENT_FRONT_PAY"/>">
                    <%-- <select class="w20"><option></option></select>
                    <auchan:select mdgroup="CONTRIBUTION_GRP_ACCOUNT_DEDCT_FREQ" _class="select1 w30" name="ref" id="ref" value="${contract.ref}"/> --%>
                </div>
        <div class="ig">
                    <div class="icol_text w14"><span>凭证</span></div>
                    <auchan:select mdgroup="CONTRACT_REF" _class="select1 w30" name="ref" id="ref" value="${contract.ref}"/>
                </div>
    </div>
</form>
</div>
<script type="text/javascript">
	var deleteData='';
	nullInputCheck();
	inputToInputIntNumber();
	inputToInputDoubleNumberAndChkLen($('#content .Content.detail'));
$(function(){
	nullInputCheck();
});
$('#buyInput').die().live('focus',function(e){
	$(this).attr('preval',this.value);this.value='';
}).live('blur',function(e){
	if(this.value==''){
	this.value=$(this).attr('preval');
	}
});
</script>