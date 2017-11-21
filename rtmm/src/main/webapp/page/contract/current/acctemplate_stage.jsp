<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<!--新增一条-->
<!--阶段条款-->
<div>
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
</div>