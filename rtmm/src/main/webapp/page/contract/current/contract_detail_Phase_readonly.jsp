<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.contractAcc{
  	width : 100%;
	height : 30px;
}
</style>
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
            <span class="arr_txt" onclick="ctrtUpDown(this);">收起</span>
        </div>
     </div>
     <div class="deposit">
 		<div class="w25 fl_left">
 			<div class="icol_text w40"><span>支付方式<span></span></span></div>
			<input type="text" class="inputText w58 fl_left mustInput Black" value="<c:forEach items="${term.payMethdList}" var="obj"><c:if test="${obj.code eq termPayMethdMap[term.termId]}">${obj.code}-${obj.title}</c:if></c:forEach>">    
    		
 		</div>
     	<div class="depositx">
     		<div class="w71 fl_left">
     		<c:set var="clear" value="0"></c:set>
     		<c:forEach items="${term.acctList}" var="obj">
            <c:forEach items="${obj.detailList}" var="detail" varStatus="num">
     		<div class="contractAcc">
     		<form action="" class="acctForm" onsubmit="return false;">
			<c:if test="${clear==1}"><br class="clearBoth"><c:set var="clear" value="1"></c:set></c:if>
			<div class="icol_text"><span class="wauto fl_left rangeNo">0${num.index+1}</span><span class="wauto fl_left">&nbsp;&nbsp;期间&nbsp;</span></div>
			<input class="Wdate fl_left beginDate" name="beginDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${detail.beginDate}"/>" onblur="checkPhaseFormClass(this)" type="text" readonly="readonly">
			<div class="icol_text">&nbsp;-&nbsp;</div>
			<input class="Wdate fl_left endDate" name="endDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${detail.endDate}"/>" onblur="checkPhaseFormClass(this)" type="text" readonly="readonly">
			                                    
			<div class="icol_text">&nbsp;返还&nbsp;</div>
			<input type="text" class="inputText w15 fl_left dedctVal double_text_with_len" onblur="checkPhaseFormClass(this)" intval="8" decval="2" maxlength="11" name="dedctVal" value="${detail.dedctVal}">
            <c:choose>
            	<c:when test="${not empty obj.dedctValType  && obj.dedctValType eq 'P'}"><div class="icol_text">&nbsp;%<input type="hidden" name="dedctValType" value="P"></div></c:when>
            	<c:when test="${not empty obj.dedctValType  && obj.dedctValType eq 'A'}"><div class="icol_text">&nbsp;元<input type="hidden" name="dedctValType" value="A"></div></c:when>
            	<c:otherwise>
             <select class="inputText w58 fl_left dedctValType" name="dedctValType">
             <option value="P"<c:if test="${detail.dedctValType eq 'P'}"> selected="selected"</c:if>>%</option>
             <option value="A"<c:if test="${detail.dedctValType eq 'A'}"> selected="selected"</c:if>>元</option>
             </select>
           		</c:otherwise>  
            </c:choose>
			<div class="icol_text">&nbsp;扣款状态&nbsp;</div>
			<input type="text" class="inputText w7 fl_left" <c:if test="${not empty detail.cntrtDetlId}"> value="<auchan:getDictValue code="1" mdgroup="CONTRACT_DETL_DEDCT_STTUS"/>" </c:if> readonly="readonly">
			</form>
			</div>
			</c:forEach>
     		</c:forEach>
     		</div>
     	</div>
     </div>
     <br class="clearBoth">
</c:if>
</c:forEach>
  </div>

<script type="text/javascript">
$(function(){
	$('.Container-1 .detail').find('input').attr('readonly','readonly');
	$('.Container-1 .detail').find('input').removeClass('Black');
});
</script>
</c:if>