<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="gyBlock">
    <!-- <span class="mpbtn item" id="cytk">常用条款</span>
    <span class="mpbtn item" id="fltk">返利条款</span>
    <span class="mpbtn item" id="qttk">其他条款</span>
    <span class="mpbtn item item_on" id="jdtk">阶段条款</span>
     -->
    <c:forEach items="${tabList}" var="obj" varStatus="status">
    <span class="mpbtn item<c:if test="${status.index==0}"> item_on</c:if>" onclick="getTabDetail('${obj.tabId}','${obj.tabType}','${contract.cntrtId}','${readonly}');" id="tab_${obj.tabId}">${obj.tabName}</span>
    </c:forEach>
</div>