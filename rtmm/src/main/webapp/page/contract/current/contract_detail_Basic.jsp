<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<c:if test="${tabType==1}">
<!-- 基本条款 -->
<div class="contract cytk" id="content_${tabId}" style="display:none;">
    <c:forEach items="${termList}" var="term">
	<c:if test="${not empty term.acctList}">
		   <div class="CM lnht30">
		      <div class="<c:if test="${term.fixDsplyInd eq 1}">CM-bar</c:if><c:if test="${term.fixDsplyInd eq 0}">CM-bar_disable</c:if>"></div>
		      <div class="CM-div">${term.termName}</div>
		      <div class="ctrt_down" onselectstart="return false;" onclick="ctrtUpDown(this);" upText="展开" downText="收起">
		         <span class="arraw arraw1"></span>
		         <span class="arr_txt">收起</span>
		      </div>
		  </div>
		  <div class="deposit">
		  	<div class="depositx">
		  		<div class="w25 fl_left">
    			<div class="icol_text w40"><span>支付方式<span></span></span></div>
    			<c:if test="${fn:length(term.payMethdList) gt 1}">
                     <select class="inputText w58 fl_left payMethd" onchange="$(this).parent().parent().parent().find('input[name=dedctVal]').val('');$(this).parent().parent().parent().find('.payMethd').val(this.value);$(this).parent().parent().find('form').removeClass('acctForm update')">
                     <option value="">请选择支付方式</option>
                     <c:forEach items="${term.payMethdList}" var="obj">
                     <option value="${obj.code}"<c:if test="${obj.code eq termPayMethdMap[term.termId]}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
                     </c:forEach>
                     </select>
                </c:if>
                <c:if test="${fn:length(term.payMethdList) eq 1}">
                <input type="text" class="inputText w58 fl_left Black" value="${term.payMethdList[0].code}-${term.payMethdList[0].title}">
                </c:if>
    			</div>
    			<!-- 科目组 -->
    			<div class="tb49">
             		<c:set var="clear" value="0"></c:set>
                	<c:forEach items="${term.acctList}" var="obj">
                	<c:forEach items="${obj.detailList}" var="detail">
                	<div>
					<c:if test="${clear==1}"></c:if>
					<c:if test="${clear==0}"><c:set var="clear" value="1"></c:set></c:if>
                	<form action="" class="<c:if test="${not empty detail.cntrtDetlId}">acctForm update</c:if>" onsubmit="return false;">
			            <input type="hidden" class="cntrtDetlId" name="cntrtDetlId" value="${detail.cntrtDetlId}">
			            <input type="hidden" name="grpAcctId" value="${obj.grpAcctId}">
			            <input type="hidden" name="year" value="${detail.year}">
			            <input type="hidden" name="phaseConbnInd" value="0">
			            <input name="taskId" type="hidden" value="${taskId}">
			            <input type="hidden" name="payMethd" class="payMethd" value="<c:if test="${fn:length(term.payMethdList) eq 1}">${term.payMethdList[0].code}</c:if><c:if test="${fn:length(term.payMethdList) gt 1}">${detail.payMethd}</c:if>">
                        <div class="icol_text w40"><span>${obj.grpAcctName}<span></span></span></div>
                        <input type="text" class="inputText w15 fl_left double_text_with_len" onblur="checkBasicFormClass(this)" onfocus="checkPayMehod(this);" intval="8" decval="2" maxlength="11" name="dedctVal" value="<fmt:formatNumber value='${detail.dedctVal}' type='number' pattern='########'/>">
                        <!-- 扣款单位  ( P; A; A,P;) -->
                        <c:choose>
                        	<c:when test="${not empty obj.dedctValType  && obj.dedctValType eq 'P'}">%<input type="hidden" name="dedctValType" value="P"/></c:when>
                        	<c:when test="${not empty obj.dedctValType  && obj.dedctValType eq 'A'}">元<input type="hidden" name="dedctValType" value="A"/></c:when>
                        	<c:otherwise>
		                       <select class="inputText w10 fl_left" name="dedctValType">
		                       <option value="P"<c:if test="${detail.dedctValType eq 'P'}"> selected="selected"</c:if>>%</option>
		                       <option value="A"<c:if test="${detail.dedctValType eq 'A'}"> selected="selected"</c:if>>元</option>
		                       </select>
                       		</c:otherwise>  
                        </c:choose>
	                	<br style="clear:both;">
	                </form>
	               	</div>
	               	</c:forEach>
                	</c:forEach>
    			</div>
		  <br style="clear:both;">
		  	</div>
		  </div>
		  </c:if>
	</c:forEach>
</div>
<script type="text/javascript">
$(function(){
	inputToInputDoubleNumberAndChkLen($('.contract:visible'));
	nullInputCheck();
});
</script>
</c:if>