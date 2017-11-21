<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>


<!-- Bar_on-->
<div class="line" style="width: 100%;"></div>
<div class="SearchTopx">
	<span><auchan:i18n id="101005001"></auchan:i18n></span>
</div>
<div class="con_title">
	<table class="w100">
		<tr>
			<td class="w10 align_center" style="border-right: 1px solid #cccccc;"></td>
			<td class="w10 align_center" style="border-right: 1px solid #cccccc;"><auchan:i18n id="101005003"></auchan:i18n></td>
			<td class="w35 align_center" style="border-right: 1px solid #cccccc;"><auchan:i18n id="101005004"></auchan:i18n></td>
		</tr>
	</table>
</div>
<div class="tbx">
	<table class="w100">
		<tr id="attrId1" onclick="showAttrContent('1')" class="tbr">
			<td class="w10 align_center"></td>
			<td id="seqNo" class="w10 align_center" style="text-align: center;">01</td>
			<td id="secAttrName" class="w35">${sectionCtrlVO.secAttr1Name }</td>
		</tr>
		<tr id="attrId2" onclick="showAttrContent('2')" class="tbr">
			<td class="w10 align_center"></td>
			<td id="seqNo" class="w10 align_center" style="text-align: center;">02</td>
			<td id="secAttrName" class="w35">${sectionCtrlVO.secAttr2Name }</td>
		</tr>
		<tr id="attrId3" onclick="showAttrContent('3')" class="tbr">
			<td class="w10 align_center"></td>
			<td id="seqNo" class="w10 align_center" style="text-align: center;">03</td>
			<td id="secAttrName" class="w35">${sectionCtrlVO.secAttr3Name }</td>
		</tr>
		<tr id="attrId4" onclick="showAttrContent('4')" class="tbr">
			<td class="w10 align_center"></td>
			<td id="seqNo" class="w10 align_center" style="text-align: center;">04</td>
			<td id="secAttrName" class="w35">${sectionCtrlVO.secAttr4Name }</td>
		</tr>
	</table>
</div>
<div class="line"></div>
