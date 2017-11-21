<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ include file="/page/commons/taglibs.jsp"%>

 <div class="SearchTop">
     <span>查询条件</span>
     <div class="Icon-size1 CircleClose C-id" onclick="DispOrHid('C-id')"></div>
 </div>
 <div class="line"></div>
 <div id="plan_div" class="SMiddle">
     <table class="SearchTable" border="0" cellspacing="0" cellpadding="0">
         <tbody><tr>
             <td class="ST_td1"><span>计划号</span></td>
             <td><input class="w65 inputText cleanInput" type="text" name="rpNo" id="rpNo" ></td>
         </tr>
         
         <tr>
             <td><span>主题</span></td>
             <td>
                 <input class="w85 inputText cleanInput" type="text" name="rdmTopic" id="rdmTopic">
             </td>
         </tr>
         <tr>
             <td><span>物流中心</span></td>
             <td>
                 <select class="w85 cleanInput" name="dcStoreNo" id="dcStoreNo">
                 	<option value="">请选择</option>
                 	<c:forEach items="${dcStoreList}" var="dcStore">
                 		<option value="${dcStore.storeNo }" title="${dcStore.storeNo }-${dcStore.storeName }">${dcStore.storeNo }-${dcStore.storeName }</option>
                 	</c:forEach>
                 </select>
             </td>
         </tr>
         <tr>
             <td><span>DM</span></td>
             <td>
                 <input class="w65 inputText cleanInput" type="text" name="rdmNo" id="rdmNo">
             </td>
         </tr>

         
         <tr>
             <td><span>课别</span></td>
             <td>
             	<div class="iconPut w65 fl_left">
                    <input type="text" class="w82 cleanInput" id="CatlgId" name="catlgId" onkeypress="doSearchCatlgKeyin(event, this)" onblur="doSearchCatlg(this)" onafterpaste="if(isNaN(value)) execCommand('undo')" >
                    <div class="ListWin" onclick="showCatlgWin(this)"></div>
               </div>
             </td>
         </tr>
         <tr>
             <td><span>&nbsp;</span></td>
             <td>
                 <input class="w85 inputText Black cleanInput" id="CatlgName" name="CatlgName" type="text">
             </td>
         </tr>
         <tr>
             <td><span>开始日期间</span></td>
             <td><input class="Wdate w65 fl_left cleanInput" name="rdmBeginDateBegin"  id="rdmBeginDateBegin" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })">&nbsp;-</td>
         </tr>
         <tr>
             <td><span>&nbsp;</span></td>
             <td><input class="Wdate w65 fl_left cleanInput" name="rdmBeginDateEnd" id="rdmBeginDateEnd" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })">
             </td>
         </tr>
         <tr>
             <td><span>结束日期间</span></td>
             <td><input class="Wdate w65 fl_left cleanInput" name="rdmEndDateBegin" id="rdmEndDateBegin" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })">&nbsp;-</td>
         </tr>
         <tr>
             <td><span>&nbsp;</span></td>
             <td><input class="Wdate w65 fl_left cleanInput" name="rdmEndDateEnd" id="rdmEndDateEnd" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })">
             </td>
         </tr>
         <tr>
             <td><span>门店确认期间</span></td>
             <td><input class="Wdate w65 fl_left cleanInput" name="stCnfrmBeginDate" id="stCnfrmBeginDate" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })">&nbsp;-</td>
         </tr>
         <tr>
             <td><span>&nbsp;</span></td> 
             <td><input class="Wdate w65 fl_left cleanInput" name="stCnfrmEndDate"  id="stCnfrmEndDate" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })">
             </td>
         </tr>
         <tr>
             <td><span>门店补货期间</span></td>
             <td><input class="Wdate w65 fl_left cleanInput" name="stRepBeginDate" id="stRepBeginDate" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })">&nbsp;-</td>
         </tr>
         <tr>
             <td><span>&nbsp;</span></td>
             <td><input class="Wdate w65 fl_left cleanInput" name="stRepEndDate" id="stRepEndDate" type="text" onclick="WdatePicker({ isShowClear: false, readOnly: true })">
             </td>
         </tr>
         <tr>
             <td><span>总金额</span></td>
             <td><input class="w65 inputText cleanInput" type="text" name="finalAmntBegin" id="finalAmntBegin">&nbsp;-</td>
         </tr>
         <tr>
             <td><span>&nbsp;</span></td>
             <td><input class="w65 inputText cleanInput" type="text" name="finalAmntEnd" id="finalAmntEnd"></td>
         </tr>
     </tbody></table>
 </div>
 <div class="line"></div>
 <div class="SearchFooter">
     <div class="Icon-size1 Tools20" onclick="clearInput()"></div>
     <div class="Icon-size1 Tools6" onclick="searchRpPlan()"></div>
 </div>
