<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<c:forEach items="${termList}" var="term">
	<div class="CM lnht30">
        <div class="CM-bar"></div>
        <div class="CM-div">${term.termName}</div>
        <div class="ctrt_down" onselectstart="return false;">
            <span class="arraw arraw1"></span>
            <span class="arr_txt">收起</span>
        </div>
    </div>
    <div class="deposit">
    	<div class="depositx">
    		<div class="w25 fl_left">
    			<div class="icol_text w40"><span>支付方式<span></span></span></div>
                     <input type="text" class="inputText w58 fl_left Black">
                     <c:if test="${acc.linkMainSupInd==1}">
                     <br class="clearBoth">
	                 <div class="icol_text w40"><span>关联厂商</span></div>
	                 <div class="iconPut w50 fl_left">
	                         <input class="w80" type="text">
	                         <div class="ListWin"></div>
	                 </div>
	                 <br class="clearBoth">
	                 <div class="icol_text w40">&nbsp;</div>
	                 <textarea class="txtarea Black"></textarea>
                      </c:if>    
    		</div>
    		<div class="tb49">
    			<c:set var="clear" value="0"></c:set>
                <c:forEach items="${accList}" var="obj">
                <!--  一个科目  -->
                <div>
                	<!-- 扣款计算方式 (人工:2或非递增条件:0) -->
                	<c:if test="${obj.calcBy==0}">
                	<!-- Tab的类型(一般科目:1或有条件科目:2或阶段性条款的科目:3) -->
                	<c:if test="${tab.tabType==1}">
                    <div class="icol_text w40"><span>${obj.grpAcctName}<span></span></span></div>
                    <input type="text" class="inputText w30 fl_left">
                    <div class="icol_text">&nbsp;元</div>
                    </c:if>
                    <c:if test="${tab.tabType==3}">
	                    <c:if test="${clear==1}"><br class="clearBoth"></c:if>
						<div class="icol_text"><span class="rangeNo">01</span>&nbsp;&nbsp;期间&nbsp;</div>
						<input id="creatDateSearch" class="Wdate fl_left" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })" readonly="readonly">
						<div class="icol_text">&nbsp;-&nbsp;</div>
						<input id="Text1" class="Wdate fl_left" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })" readonly="readonly">
						                                    
						<div class="icol_text w30">&nbsp;</div>
						<input type="text" class="inputText w20 fl_left">
						<div class="icol_text">&nbsp;元，返还&nbsp;</div>
						<input type="text" class="inputText w20 fl_left">
						<select class="w7  fl_left Black"><option>元</option></select>
						<div class="Icon-size2 fl_left Tools10"></div>
                    </c:if>
                	  
                 	<c:if test="${obj.degeeCondInd==1}">
                 		<br class="clearBoth">
                       <!--新增一条-->
                       <div class="icol_text w30">&nbsp;</div>
                       <div class="Icon-size2 fl_left Tools11"></div>
                       <div class="icol_text">&nbsp;新增条目</div>
                 	</c:if>
                   </c:if>
                </div>
                </c:forEach>
                <br class="clearBoth">
                <div class="icol_text w40"><span>DEPOSIT 交易保证金<span></span></span></div>
                <input type="text" class="inputText w30 fl_left">
                <div class="icol_text">&nbsp;元</div>
                
                <br class="clearBoth">
                <div class="icol_text w40"><span>ASSF 交易服务保证金<span></span></span></div>
                <input type="text" class="inputText w30 fl_left">
                <div class="icol_text">&nbsp;元</div>
    		</div>
    		<br style="clear:both;">
    	</div>
    </div>
</c:forEach>

