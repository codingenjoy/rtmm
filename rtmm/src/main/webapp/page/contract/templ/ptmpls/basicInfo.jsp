<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div style="height: 60px;" class="CM">
	<div class="CM-bar">
		<div>模版</div>
	</div>
	<div class="CM-div">
		<div class="hh_item">
			<div class="icol_text w7">
				<span>模板编号</span>
			</div>
			<input id="tmplId" class="inputText w10 fl_left Black" readonly="readonly" type="text" value="${templVO.tmplId }" />
			<div class="icol_text w7">
				<span>使用状态</span>
			</div>
			<auchan:select mdgroup="CONTRACT_TMPL_IN_USE_IND" _class="w7 fl_left" id="inUseIndSelect" iscaption="0" value="${templVO.inUseInd }" ></auchan:select>
		</div>
	</div>
</div>