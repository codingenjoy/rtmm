<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<c:forEach items="${acctList}" var="obj">
<c:forEach items="${obj.detailList}" var="detail">                
<div class="contractAcc<c:if test="${obj.degeeCondInd==1}"> degeeCondInd</c:if>" grpAcctId="${obj.grpAcctId}">
<c:if test="${clear==1}"><br class="clearBoth"></c:if>
<c:if test="${clear==0}"><c:set var="clear" value="1"></c:set></c:if>
<form action="" class="<c:if test="${not empty detail.cntrtDetlId}">acctForm update</c:if>" onsubmit="return false;">
 <input type="hidden" class="cntrtDetlId" name="cntrtDetlId" value="${detail.cntrtDetlId}">
 <input type="hidden" name="grpAcctId" value="${obj.grpAcctId}">
 <input type="hidden" name="year" value="${detail.year}">
 <input type="hidden" class="linkMainSupNo" name="linkMainSupNo" value="${detail.linkMainSupNo}">
  <input type="hidden" name="phaseConbnInd" value="0">
 <input type="hidden" name="payMethd" class="payMethd" value="${detail.payMethd}">
 <input type="hidden" name="chngAllLinkInd" value="0">
 <div class="icol_text w30 accTitle"><span>${obj.grpAcctName}&nbsp;&nbsp;达到<span></span></span></div>
 <input type="text" readonly="readonly" class="inputText w20 fl_left condVal count_text<c:if test="${obj.degeeCondInd==1}"> degeeCondInd</c:if>" name="condVal" value="<fmt:formatNumber type="number" value="${detail.condVal}" pattern='##########'/>" maxlength="10">
 <div class="icol_text w12_5">&nbsp;
  	<c:if test="${not empty obj.condValType  && obj.condValType eq 'A'}">元<input type="hidden" class="condValType" name="condValType" value="A"/></c:if>
  	<c:if test="${not empty obj.condValType  && obj.condValType eq 'P'}">%<input type="hidden" class="condValType" name="condValType" value="P"/></c:if>
  	<c:if test="${(not empty obj.condValType)  && (obj.condValType eq 'A,P')}">
  	   <input type="hidden" class="condValType" name="condValType" value="<c:if test="${not empty detail.condValType}">${detail.condValType}</c:if><c:if test="${empty detail.condValType}">P</c:if>"/>
    <select disabled="disabled" class="inputText w58 fl_left condValType<c:if test="${obj.degeeCondInd==1}"> degeeCondInd</c:if>">
    <option value="P" <c:if test="${detail.condValType eq 'P'}">selected="selected"</c:if>>%</option>
    <option value="A" <c:if test="${detail.condValType eq 'A'}">selected="selected"</c:if>>元</option>
    </select>
 	</c:if>
返还</div>
            <input type="text"  readonly="readonly" class="inputText w20 fl_left dedctVal double_text_with_len<c:if test="${obj.degeeCondInd==1}"> degeeCondInd</c:if>" intval="8" decval="2" maxlength="11" name="dedctVal" value="${detail.dedctVal}">
 <div class="icol_text w12_5">&nbsp;
 <c:choose>
   	<c:when test="${not empty obj.dedctValType  && obj.dedctValType eq 'A'}">元<input type="hidden" class="dedctValType" name="dedctValType" value="A"/></c:when>
   	<c:when test="${not empty obj.dedctValType  && obj.dedctValType eq 'P'}">%<input type="hidden" class="dedctValType" name="dedctValType" value="P"/></c:when>
   	<c:otherwise>
   		<input type="hidden" class="dedctValType" name="dedctValType" value="<c:if test="${not empty detail.dedctValType}">${detail.dedctValType}</c:if><c:if test="${empty detail.dedctValType}">P</c:if>"/>
     <select disabled="disabled" class="inputText w58 fl_left dedctValType <c:if test="${obj.degeeCondInd==1}">degeeCondInd</c:if>">
     <option value="P" <c:if test="${detail.dedctValType eq 'P'}">selected="selected"</c:if>>%</option>
     <option value="A" <c:if test="${detail.dedctValType eq 'A'}">selected="selected"</c:if>>元</option>
     </select>
  	</c:otherwise>  
 </c:choose>
 </div>
  </form>
  </div>
<div>
<br style="clear:both;">
</div>
</c:forEach>
</c:forEach>