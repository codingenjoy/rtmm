<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="tb_bg">
	<div class="CM-bar">
		<div><auchan:i18n id="101006017"></auchan:i18n></div>
	</div>
	<div class="CM-div" id="groupMessage">
		<table class="CM_table">
			<tr>
				<td class="w20">
					<span><auchan:i18n id="101006011"></auchan:i18n></span>
				</td>
				<td class="w20">
					<input style="width: 30px" value="${grpCtrlVOs.m3DepreRate}" type="text" class="inputText align_right" readonly="readonly" />
					&nbsp;%
				</td>
				<td class="w20">&nbsp;</td>
				<td class="w20">
					<span><auchan:i18n id="101006008"></auchan:i18n></span>
				</td>
				<td>
					<input id="createDate"  type="text" class="inputText w80" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101006012"></auchan:i18n></span>
				</td>
				<td>
					<input type="text" style="width: 30px" value="${grpCtrlVOs.m6DepreRate}" class="inputText align_right" readonly="readonly" />
					&nbsp;%
				</td>
				<td>&nbsp;</td>
				<td>
					<span><auchan:i18n id="101006009"></auchan:i18n></span>
				</td>
				<td>
					<input id="chngDate"  type="text" class="inputText w80" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101006013"></auchan:i18n></span>
				</td>
				<td>
					<input style="width: 30px" value="${grpCtrlVOs.m12DepreRate}" type="text" class="inputText align_right" readonly="readonly" />
					&nbsp;%
				</td>
				<td>&nbsp;</td>
				<td>
					<span><auchan:i18n id="101006010"></auchan:i18n></span>
				</td>
				<td>
					<input id="chngBy" type="text" class="inputText w80" readonly="readonly" />
				</td>
			</tr>
		</table>
	</div>
</div>


