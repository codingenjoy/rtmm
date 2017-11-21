<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<c:if test="${tabType==3}">
<!-- 阶段性合同条款 -->
<div class="contract jdtk" id="content_${tabId}" style="display:none;">
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
 		<div class="w25 fl_left">
 			<div class="icol_text w40"><span>支付方式<span></span></span></div>
 					<c:if test="${fn:length(term.payMethdList) gt 1}">
	                     <select class="inputText w58 fl_left payMethd" onchange="$(this).parent().parent().parent().find('.beginDate,.endDate,.dedctVal').val('');$(this).parent().parent().parent().find('.payMethd').val(this.value);">
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
     	<div class="depositx">
     		<div class="w71 fl_left">
     		<c:set var="clear" value="0"></c:set>
     		<c:forEach items="${term.acctList}" var="obj">
            <c:forEach items="${obj.detailList}" var="detail" varStatus="num">
     		<div class="contractAcc" style="width:100%;height:30px">
			<c:if test="${clear==1}"></c:if>
			<c:if test="${clear==0}"><c:set var="clear" value="1"></c:set></c:if>
     		<form action="" class="<c:if test="${not empty detail.cntrtDetlId}">acctForm update</c:if>" onsubmit="return false;">
            <input type="hidden" class="cntrtDetlId" name="cntrtDetlId" value="${detail.cntrtDetlId}">
            <input type="hidden" name="grpAcctId" value="${obj.grpAcctId}">
            <input type="hidden" name="year" value="${detail.year}">
            <input type="hidden" name="phaseConbnInd" value="1">
            <input id="taskId" type="hidden" value="${taskId}">
            <input type="hidden" name="payMethd" class="payMethd" value="<c:if test="${fn:length(term.payMethdList) eq 1}">${term.payMethdList[0].code}</c:if><c:if test="${fn:length(term.payMethdList) gt 1}">${detail.payMethd}</c:if>">
			<input type="hidden" name="lineNo" value="0${num.index+1}">
			<div class="icol_text"><span class="wauto fl_left rangeNo">0${num.index+1}</span><span class="wauto fl_left">&nbsp;&nbsp;期间&nbsp;</span></div>
			<input class="Wdate fl_left beginDate" name="beginDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${detail.beginDate}"/>" onblur="checkPhaseFormClass(this)" onfocus="checkPayMehod(this);$(this).removeClass('errorInput')" type="text" onclick="WdatePicker({onpicked:function(){getBeginDate(this);}, isShowClear: false, readOnly: true })" readonly="readonly">
			<div class="icol_text">&nbsp;-&nbsp;</div>
			<input class="Wdate fl_left endDate" name="endDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${detail.endDate}"/>" onblur="checkPhaseFormClass(this)" onfocus="checkPayMehod(this);$(this).removeClass('errorInput')" type="text" onclick="WdatePicker({onpicked:function(){getEndDate(this);}, isShowClear: false, readOnly: true })" readonly="readonly">
			                                    
			<div class="icol_text">&nbsp;返还&nbsp;</div>
			<input type="text" class="inputText w15 fl_left dedctVal double_text_with_len" onblur="checkPhaseFormClass(this)" onfocus="checkPayMehod(this);$(this).removeClass('errorInput')" intval="8" decval="2" maxlength="11" name="dedctVal" value="${detail.dedctVal}">
            <c:choose>
            	<c:when test="${not empty obj.dedctValType  && obj.dedctValType eq 'P'}"><div class="icol_text">&nbsp;%<input type="hidden" name="dedctValType" value="P"></div></c:when>
            	<c:when test="${not empty obj.dedctValType  && obj.dedctValType eq 'A'}"><div class="icol_text">&nbsp;元<input type="hidden" name="dedctValType" value="A"></div></c:when>
            	<c:otherwise>
             <select class="inputText w55 fl_left dedctValType" name="dedctValType">
             <option value="P"<c:if test="${detail.dedctValType eq 'P'}"> selected="selected"</c:if>>%</option>
             <option value="A"<c:if test="${detail.dedctValType eq 'A'}"> selected="selected"</c:if>>元</option>
             </select>
           		</c:otherwise>  
            </c:choose>
			<div class="icol_text">&nbsp;扣款状态&nbsp;</div>
			<c:if test="${empty detail.cntrtDetlId}">
			<input type="text" class="inputText w7 fl_left read" value="<auchan:getDictValue code="1" mdgroup="CONTRACT_DETL_DEDCT_STTUS"/>" readonly="readonly">
			<input type="hidden" name="dedctSttus" value="1">
			</c:if>
			<c:if test="${not empty detail.cntrtDetlId}">
			<input type="text" class="inputText w7 fl_left read" value="<auchan:getDictValue code="${detail.dedctSttus}" mdgroup="CONTRACT_DETL_DEDCT_STTUS"/>" readonly="readonly">
			<input type="hidden" name="dedctSttus" value="${detail.dedctSttus}">
			</c:if>			
			<div class="Icon-size2 fl_left <c:choose><c:when test="${num.index == 0}">Tools10_disable</c:when><c:otherwise>Tools10</c:otherwise></c:choose>" onclick="if(!$(this).hasClass('Tools10_disable'))removeDataRow($(this).parent().parent())"></div>
			</form>
			</div>
			</c:forEach>
     		</c:forEach>
     		<div class="clearBoth">
               <!--新增一条-->
               <div class="Icon-size2 fl_left Tools11" onclick="addDataRow($(this).parent());"></div>
               <div class="icol_text">&nbsp;新增条目</div>
     		</div>
     		</div>
    	 <br class="clearBoth">
     	</div>
     </div>
</c:if>
</c:forEach>
  </div>
<script type="text/javascript">
$(function(){
	inputToInputDoubleNumberAndChkLen($('.contract'));
	nullInputCheck();
});
</script>
</c:if>