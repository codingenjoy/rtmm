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
            <span class="arr_txt">收起</span>
        </div>
     </div>
     <div class="deposit">
         <!--内容-->
         <div class="depositx">
             <div class="w25 fl_left">
    			<div class="icol_text w40"><span>支付方式<span></span></span></div>
	    			<c:if test="${fn:length(term.payMethdList) gt 1}">
	                     <select class="inputText w58 fl_left payMethd" onchange="$(this).parent().parent().parent().find('.payMethd').val(this.value);">
	                     <option value="">请选择支付方式</option>
	                     <c:forEach items="${term.payMethdList}" var="obj">
	                     <option value="${obj.code}"<c:if test="${obj.code eq termPayMethdMap[term.termId]}"> selected="selected"</c:if>>${obj.code}-${obj.title}</option>
	                     </c:forEach>
	                     </select>
	                </c:if>
	                <c:if test="${fn:length(term.payMethdList) eq 1}">
	                <input type="text" class="inputText w58 fl_left Black" value="${term.payMethdList[0].code}-${term.payMethdList[0].title}">
	                </c:if>
		         	 <!-- 关联厂商 -->
                     <c:if test="${not empty term.acctList[0].linkMainSupInd && term.acctList[0].linkMainSupInd==1}">
                     <input type="hidden" value="${term.termId}" class="termId">
                     <br class="clearBoth">
	                 <div class="icol_text w40"><span>关联厂商</span></div>
	                 <div class="iconPut w50 fl_left">
	                     <input class="w80 supNo" type="text" onchange="selectRebateSupplier(this.value)"
	                   	 <c:if test="${not empty term.acctList[0] && not empty term.acctList[0].detailList[0]}">value='${term.acctList[0].detailList[0].linkMainSupNo}'
	                     </c:if>>
	                     <div class="ListWin" onclick="chooseSupplier();"></div>
	                 </div>
	                 <br class="clearBoth">
	                 <div class="icol_text w40">&nbsp;</div>
	                 <textarea class="txtarea w55 Black supName" readonly="readonly"><c:if test="${not empty term.acctList[0] && not empty term.acctList[0].detailList[0]}">${term.acctList[0].detailList[0].supName}</c:if></textarea>
                     </c:if>    
    		</div>
             <div class="w71 fl_left<c:if test="${not empty term.acctList[0].linkMainSupInd && term.acctList[0].linkMainSupInd==1}"> linkMainSup</c:if>">
             <c:set var="clear" value="0"></c:set>
                <c:forEach items="${term.acctList}" var="obj">
                <c:forEach items="${obj.detailList}" var="detail" varStatus="num">    
             
             <c:if test="${not empty term.acctList[0].linkMainSupInd && term.acctList[0].linkMainSupInd==1 && not empty detail.linkMainSupNo && detail.linkMainSupNo!=contract.supNo && empty hasScirpt}">
             <script type="text/javascript"><c:set var="hasScirpt" value="1"/>
	             $(function(){
	            	 $('.contract .linkMainSup').find('input').attr('readonly','readonly').removeAttr('onblur').removeAttr('onfocus');
	            	 $('.contract .linkMainSup').find('select').attr('disabled','disabled');
	            	 $('.contract .add').remove();
	             });
             </script>
             </c:if>            
                <div class="contractAcc<c:if test="${obj.degeeCondInd==1}"> degeeCondInd</c:if>" grpAcctId="${obj.grpAcctId}">
				<c:if test="${clear==1}"><br class="clearBoth"></c:if>
				<c:if test="${clear==0}"><c:set var="clear" value="1"></c:set></c:if>
                <form action="" class="<c:if test="${not empty detail.cntrtDetlId}">acctForm update</c:if>" onsubmit="return false;">
            	 <input type="hidden" name="taskId" value="${taskId}">
                 <input type="hidden" class="cntrtDetlId" name="cntrtDetlId" value="${detail.cntrtDetlId}">
                 <input type="hidden" name="grpAcctId" value="${obj.grpAcctId}">
                 <input type="hidden" name="year" value="${detail.year}">
                 <input type="hidden" name="phaseConbnInd" value="0">
                 <input type="hidden" name="linkMainSupNo" value="${detail.linkMainSupNo}">
                 <input id="taskId" type="hidden" value="${taskId}">
                 <input type="hidden" name="chngAllLinkInd" value='<c:if test="${not empty taskId}">${chngAllLinkInd}</c:if>'>
                 <input type="hidden" name="payMethd" class="payMethd" value="<c:if test="${fn:length(term.payMethdList) eq 1}">${term.payMethdList[0].code}</c:if><c:if test="${fn:length(term.payMethdList) gt 1}">${detail.payMethd}</c:if>">
                 <div class="icol_text w30 accTitle"><span>${obj.grpAcctName}&nbsp;&nbsp;达到<span></span></span></div>
                 <input type="text" class="inputText w20 fl_left condVal count_text<c:if test="${obj.degeeCondInd==1}"> degeeCondInd</c:if>" onblur="checkRebateFormClass(this)" onfocus="checkPayMehod(this);$(this).removeClass('errorInput')" name="condVal" value="<fmt:formatNumber type="number" value="${detail.condVal}" pattern="##########"/>" maxlength="10">
                 <div class="icol_text w12_5">&nbsp;
                  	<c:if test="${not empty obj.condValType  && obj.condValType eq 'A'}">元<input type="hidden" class="condValType" name="condValType" value="A"/></c:if>
                  	<c:if test="${not empty obj.condValType  && obj.condValType eq 'P'}">%<input type="hidden" class="condValType" name="condValType" value="P"/></c:if>
                  	<c:if test="${(not empty obj.condValType)  && (obj.condValType eq 'A,P')}">
                  	   <input type="hidden" class="condValType" name="condValType" value="<c:if test="${not empty detail.condValType}">${detail.condValType}</c:if><c:if test="${empty detail.condValType}">P</c:if>"/>
	                   <select class="inputText w58 fl_left condValType<c:if test="${obj.degeeCondInd==1}"> degeeCondInd</c:if>" onChange="changeRebateValType(this,'condValType');$(this).prev().val(this.value);">
	                   <option value="P" <c:if test="${detail.condValType eq 'P'}">selected="selected"</c:if>>%</option>
	                   <option value="A" <c:if test="${detail.condValType eq 'A'}">selected="selected"</c:if>>元</option>
	                   </select>
                 	</c:if>
				 返还</div>
                 <input type="text" class="inputText w20 fl_left dedctVal double_text_with_len<c:if test="${obj.degeeCondInd==1}"> degeeCondInd</c:if>" onblur="checkRebateFormClass(this)" onfocus="checkPayMehod(this);$(this).removeClass('errorInput')" intval="8" decval="2" maxlength="11" name="dedctVal" value="${detail.dedctVal}">
                 <div class="icol_text w12_5">&nbsp;
                 <c:choose>
                   	<c:when test="${not empty obj.dedctValType  && obj.dedctValType eq 'A'}">元<input type="hidden" class="dedctValType" name="dedctValType" value="A"/></c:when>
                   	<c:when test="${not empty obj.dedctValType  && obj.dedctValType eq 'P'}">%<input type="hidden" class="dedctValType" name="dedctValType" value="P"/></c:when>
                   	<c:otherwise>
                   		<input type="hidden" class="dedctValType" name="dedctValType" value="<c:if test="${not empty detail.dedctValType}">${detail.dedctValType}</c:if><c:if test="${empty detail.dedctValType}">P</c:if>"/>
	                    <select class="inputText w55 fl_left dedctValType <c:if test="${obj.degeeCondInd==1}">degeeCondInd</c:if>" onChange="changeRebateValType(this,'dedctValType');$(this).prev().val(this.value);">
	                    <option value="P" <c:if test="${detail.dedctValType eq 'P'}">selected="selected"</c:if>>%</option>
	                    <option value="A" <c:if test="${detail.dedctValType eq 'A'}">selected="selected"</c:if>>元</option>
	                    </select>
                  	</c:otherwise>  
                 </c:choose>
                 </div>
                 <c:if test="${obj.degeeCondInd==1}">
                 <div class="Icon-size2 fl_left <c:choose><c:when test="${num.index == 0}">Tools10_disable</c:when><c:otherwise>Tools10</c:otherwise></c:choose>" onclick="if(!$(this).hasClass('Tools10_disable'))removeDataRow($(this).parent().parent())"></div>
                 </c:if>
                 </form>
                 </div>
             	 </c:forEach>
             	 <div class="add">
             	 <c:if test="${obj.degeeCondInd==1}">
             	 <div class="icol_text w30">&nbsp;</div>
                 <div class="Icon-size2 fl_left Tools11" onclick="addDataRow($(this).parent());"></div>
                 <div class="icol_text">&nbsp;新增条目</div>
                 </c:if>
             	 </div>
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
	inputToInputIntNumber();
	inputToInputDoubleNumberAndChkLen($('.contract:visible'));
});
</script>
</c:if>