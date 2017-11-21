<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<div class="tb_bar">
	<div class="CM-bar">
		<div><auchan:i18n id="101008024"></auchan:i18n></div>
	</div>
	<div class="CM-div" id="subMessage">
		<table class="CM_table">
			<tr align="center">
				<td class="w7">&nbsp;</td>
				<td class="w10"><auchan:i18n id="101008013"></auchan:i18n></td>
				<td class="w10"><auchan:i18n id="101008014"></auchan:i18n></td>
				<td class="w10"><auchan:i18n id="101008015"></auchan:i18n></td>
				<td class="w10"><auchan:i18n id="101008016"></auchan:i18n></td>
				<td class="w10"><auchan:i18n id="101008017"></auchan:i18n></td>
				<td class="w10"><auchan:i18n id="101008018"></auchan:i18n></td>
				<td class="w10"><auchan:i18n id="101008019"></auchan:i18n></td>
				<td class="w10">&nbsp;</td>
				<td class="w10">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="8" style="height: 1px; overflow: hidden;">
					<div class="line"></div>
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>

			</tr>
			<tr class="textRight">
				<td>
					<span><auchan:i18n id="101008020"></auchan:i18n></span>
				</td>
				<td>
					<input type="text" value="${hdSubgrpCtrlVO.mktPostn}" class="inputText w85" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hbSubgrpCtrlVO.mktPostn}" class="inputText w85" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${xnSubgrpCtrlVO.mktPostn}" class="inputText w85" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hnSubgrpCtrlVO.mktPostn}" class="inputText w85" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${dbSubgrpCtrlVO.mktPostn}" class="inputText w85" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hzSubgrpCtrlVO.mktPostn}" class="inputText w85" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${xbSubgrpCtrlVO.mktPostn}" class="inputText w85" readonly="readonly" />
				</td>
				<td>
					<span><auchan:i18n id="101008010"></auchan:i18n></span>
				</td>
				<td>
					<input id="createDate" type="text" class="inputText w85" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td>
					<span>B</span>
				</td>
				<td>
					<input type="text" value="${hdSubgrpCtrlVO.trgtNbrB}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hbSubgrpCtrlVO.trgtNbrB}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${xnSubgrpCtrlVO.trgtNbrB}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hnSubgrpCtrlVO.trgtNbrB}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${dbSubgrpCtrlVO.trgtNbrB}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hzSubgrpCtrlVO.trgtNbrB}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${xbSubgrpCtrlVO.trgtNbrB}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<span><auchan:i18n id="101008011"></auchan:i18n></span>
				</td>
				<td>
					<input id="chngDate" type="text" class="inputText w85" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td>
					<span>N</span>
				</td>
				<td>
					<input type="text" value="${hdSubgrpCtrlVO.trgtNbrN}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hbSubgrpCtrlVO.trgtNbrN}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${xnSubgrpCtrlVO.trgtNbrN}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hnSubgrpCtrlVO.trgtNbrN}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${dbSubgrpCtrlVO.trgtNbrN}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hzSubgrpCtrlVO.trgtNbrN}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${xbSubgrpCtrlVO.trgtNbrN}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<span><auchan:i18n id="101008012"></auchan:i18n></span>
				</td>
				<td>
					<input id="chngBy" type="text" class="inputText w85" readonly="readonly" />
				</td>
			</tr>
			<tr>
				<td>
					<span>O</span>
				</td>
				<td>
					<input type="text" value="${hdSubgrpCtrlVO.trgtNbrO}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hbSubgrpCtrlVO.trgtNbrO}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${xnSubgrpCtrlVO.trgtNbrO}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hnSubgrpCtrlVO.trgtNbrO}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${dbSubgrpCtrlVO.trgtNbrO}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${hzSubgrpCtrlVO.trgtNbrO}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>
					<input type="text" value="${xbSubgrpCtrlVO.trgtNbrO}" class="inputText w85 align_right" readonly="readonly" />
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>
	</div>
</div>
