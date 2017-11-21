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
		         <span class="arr_txt" onclick="ctrtUpDown(this);">收起</span>
		      </div>
		  </div>
		  <div class="deposit">
		  	<div class="depositx">
		  		<div class="w25 fl_left">
    			<div class="icol_text w40"><span>支付方式<span></span></span></div>
    			
				
				<%-- <c:forEach items="${termPayMethdMap}" var="item">  
				  <c:out value="${item.key}"  
				</c:forEach>
    			<input type="text" class="inputText w58 fl_left mustInput Black" value=
    			"<c:forEach items="${term.payMethdList}" var="obj"><c:forEach items="${termPayMethdMap}" var="item"><c:if test="${obj.code eq ${termPayMethdMap[term.terId].value}}">${obj.code}-${obj.title}</c:if></c:forEach></c:forEach>">    
    			 --%>
    			
    			<input type="text" class="inputText w58 fl_left mustInput Black" value="<c:forEach items="${term.payMethdList}" var="obj"><c:if test="${obj.code eq termPayMethdMap[term.termId]}">${obj.code}-${obj.title}</c:if></c:forEach>">    
    			
		        </div>
    			<div class="tb49">
                	<c:forEach items="${term.acctList}" var="obj">
            		<c:forEach items="${obj.detailList}" var="detail">
                	<div>
                	<form action="" class="acctForm" onsubmit="return false;">
                        <div class="icol_text w40"><span>${obj.grpAcctName}<span></span></span></div>
                        <input type="text" class="inputText w15 fl_left" value="${detail.dedctVal}">
                        <!-- 扣款单位  ( P; A; A,P;) -->
                        <div class="icol_text">&nbsp;
                        <c:choose>
                        	<c:when test="${not empty detail.dedctValType  && detail.dedctValType eq 'A'}">元<input type="hidden" value=""/></c:when>
                        	<c:when test="${not empty detail.dedctValType  && detail.dedctValType eq 'P'}">%<input type="hidden" value=""/></c:when>  
                        </c:choose>
                        </div>
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
	$('.Container-1 .detail').find('input').attr('readonly','readonly');
	$('.Container-1 .detail').find('input').removeClass('Black');
});
</script>
</c:if>