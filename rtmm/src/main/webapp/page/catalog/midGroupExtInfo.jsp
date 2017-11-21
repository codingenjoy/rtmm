<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="tb_bar">
	<div class="CM-bar">
		<div><auchan:i18n id="101007024"></auchan:i18n></div>
	</div>
	<div class="CM-div" id="midsizeMessage">
		<table class="CM_table">
			<tr>
				<td class="w15" style="height: 30px;">
					<span><auchan:i18n id="101007012"></auchan:i18n></span>
				</td>
				<td class="w20">
					<input value="<auchan:getDictValue code="${midGrpCtrlVO.specialGrpCtrl}" mdgroup="CL_MID_GRP_CTRL_SPECL_GRP_CTRL"></auchan:getDictValue>" type="text" class="inputText w95" readonly="readonly" />
				</td>
				<td class="w10">
					<span><auchan:i18n id="101007016"></auchan:i18n></span>
				</td>
				<td class="w25">
					<span style="float: left;">DMS&gt;</span>
					<input value="${midGrpCtrlVO.popDms}" type="text" class="inputText w35 fl_left align_right" readonly="readonly" />
				</td>
				<td class="w5">&nbsp;</td>
				<td class="w15">
					<span><auchan:i18n id="101007009"></auchan:i18n></span>
				</td>
				<td>
					<input id="createDate" type="text" class="inputText w95" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td style="height: 30px;">
					<span><auchan:i18n id="101007013"></auchan:i18n></span>
				</td>
				<td>
					<input value="<auchan:getDictValue code="${midGrpCtrlVO.stockCtrl}" mdgroup="CL_MID_GRP_CTRL_STOCK_CTRL"></auchan:getDictValue>" type="text" class="inputText w95" readonly="readonly" />
				</td>
				<td>
					<span><auchan:i18n id="101007017"></auchan:i18n></span>
				</td>
				<td>
					<span style="float: left;"><auchan:i18n id="101007018"></auchan:i18n><</span>
					<input value="${midGrpCtrlVO.oosTimesDms}" type="text" class="inputText w35 fl_left align_right" readonly="readonly" />
					<span style="float: left;">&nbsp;x&nbsp;DMS</span>
				</td>
				<td>&nbsp;</td>
				<td>
					<span><auchan:i18n id="101007010"></auchan:i18n></span>
				</td>
				<td>
					<input id="chngDate" type="text" class="inputText w95" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td style="height: 30px;">
					<span><auchan:i18n id="101007014"></auchan:i18n></span>
				</td>
				<td>
					<input type="text" value="${midGrpCtrlVO.sellVatNo}" class="inputText w15 fl_left align_right" readonly="readonly" />
					<input type="text" value="${midGrpCtrlVO.sellVat}" class="inputText w45 align_right" style="margin-left: 6px; float: left;" readonly="readonly" />
					<span style="margin: 0px; line-height: 25px; float: left;">&nbsp;%</span>
				</td>
				<td>
					<span><auchan:i18n id="101007019"></auchan:i18n></span>
				</td>
				<td>
					<span></span>
					<input value="${midGrpCtrlVO.idleDays}" type="text" class="inputText w15 align_right" readonly="readonly" />
					&nbsp;天
				</td>
				<td>&nbsp;</td>
				<td>
					<span><auchan:i18n id="101007011"></auchan:i18n></span>
				</td>
				<td>
					<input id="chngBy" type="text" class="inputText w95" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td style="height: 30px;">
					<span><auchan:i18n id="101007015"></auchan:i18n></span>
				</td>
				<td>
					<input type="text" value="${midGrpCtrlVO.buyVatNo}" class="inputText w15 fl_left align_right" readonly="readonly" />
					<input type="text" value="${midGrpCtrlVO.buyVat}" class="inputText w45 align_right" style="margin-left: 6px; float: left;" readonly="readonly" />
					<span style="margin: 0px; line-height: 25px; float: left;">&nbsp;%</span>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
	</div>
</div>

