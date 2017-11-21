<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>


     <div class="CM lnht30">
         <div class="CM-bar"></div>
         <div class="CM-div">DEPOSIT 保证金</div>
         <div class="ctrt_down" onselectstart="return false;">
             <span class="arraw arraw1"></span>
             <span class="arr_txt">收起</span>
         </div>
     </div>
      <div class="deposit">
              <!--内容-->
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
                  <div>
                  	<c:if test="${obj.calcBy==0}">
                      <div class="icol_text w40"><span>DEPOSIT 交易保证金<span></span></span></div>
                      <input type="text" class="inputText w30 fl_left">
                      <div class="icol_text">&nbsp;元</div>
                  	  
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