<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="gyBlock">
	<span class="mpbtn item item_on" id="jbtk"
		<c:if test="${not empty contractVO.cntrtId }">
		onclick="getGrpAccount('${contractVO.cntrtId}','1')"
		</c:if>
	>基本条款</span> 
	<span class="mpbtn item" id="fltk" 
		<c:if test="${not empty contractVO.cntrtId }">
		onclick="getGrpAccount('${contractVO.cntrtId}','2')"
		</c:if>
	>返利条款</span>
	<span class="mpbtn item " id="jdtk" 
		<c:if test="${not empty contractVO.cntrtId }">
		onclick="getGrpAccount('${contractVO.cntrtId}','3')"
		</c:if>
	>阶段条款</span>
</div>