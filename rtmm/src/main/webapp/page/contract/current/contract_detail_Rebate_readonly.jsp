<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<c:if test="${tabType==2}">
<!-- 返利条款 -->
<div class="contract fltk" id="content_${tabId}" style="display:none;">
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
         <!--内容-->
         <div class="depositx">
             <div class="w25 fl_left">
    			<div class="icol_text w40"><span>支付方式<span></span></span></div>
		   			<input type="text" class="inputText w58 fl_left mustInput Black" value="<c:forEach items="${term.payMethdList}" var="obj"><c:if test="${obj.code eq termPayMethdMap[term.termId]}">${obj.code}-${obj.title}</c:if></c:forEach>">    
    			
		         	 <!-- 关联厂商 -->
                     <c:if test="${not empty term.acctList[0].linkMainSupInd && term.acctList[0].linkMainSupInd==1}">
                     <br class="clearBoth">
	                 <div class="icol_text w40"><span>关联厂商</span></div>
	                 <input type="text" class="inputText w58 fl_left mustInput Black" <c:if test="${not empty term.acctList[0] && not empty term.acctList[0].detailList[0]}">value='${term.acctList[0].detailList[0].linkMainSupNo}'
	                     </c:if>>
	                 <br class="clearBoth">
	                 <div class="icol_text w40">&nbsp;</div>
	                 <textarea class="txtarea w55 Black supplierName" readonly="readonly"><c:if test="${not empty term.acctList[0] && not empty term.acctList[0].detailList[0]}">${term.acctList[0].detailList[0].supName}</c:if></textarea>
                     </c:if>    
    		</div>
             
             
             <div class="w71 fl_left">
             <c:set var="clear" value="0"></c:set>
                <c:forEach items="${term.acctList}" var="obj">
            	<c:forEach items="${obj.detailList}" var="detail">
                <div class="contractAcc" style="width:100%;height:30px">
                <form action="" class="acctForm" onsubmit="return false;">
                 <input type="hidden" name="" value="" class="">
                 <div class="icol_text w30 accTitle"><span>${obj.grpAcctName}&nbsp;&nbsp;达到<span></span></span></div>
                 <input type="text" class="inputText w20 fl_left" value="<fmt:formatNumber type="number" value="${detail.condVal}" pattern="##########"/>">
                 <div class="icol_text w12_5">&nbsp;
                 	
                  	<c:if test="${not empty detail.condValType  && detail.condValType eq 'A'}">元<input type="hidden" value=""/></c:if>
                  	<c:if test="${not empty detail.condValType  && detail.condValType eq 'P'}">%<input type="hidden" value=""/></c:if>
				 返还&nbsp;</div>
                 <input type="text" class="inputText w20 fl_left" value="${detail.dedctVal}">
				 <c:choose>
				  
	             	<c:when test="${not empty detail.dedctValType  && detail.dedctValType eq 'A'}">元</c:when>
	             	<c:when test="${not empty detail.dedctValType  && detail.dedctValType eq 'P'}">%</c:when>  
	             </c:choose>
                 <c:if test="${obj.degeeCondInd==1}">
                 </c:if>
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
	//初始化供应商
	$('.Container-1 .detail').find('input').attr('readonly','readonly');
	$('.Container-1 .detail').find('input').removeClass('Black');
});
</script>
</c:if>