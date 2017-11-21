<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<style type="text/css">
.Tb_Panel2 {
	height: 200px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}

.iconPut {
	height: 22px;
	border: 1px solid #999;
}

.twoinput23 {
	width: 25%;
	float: left;
}

.twoinput22 {
	width: 10%;
	float: left;
}
</style>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/catalog/catalogCommon.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/catalog/warehouse.js" type="text/javascript"></script>
<script type="text/javascript">
	var viewModel = new ViewModel("${wareHouseVO.whseNo}","${wareHouseVO.whseName }","${wareHouseVO.addrId}",
			"${wareHouseVO.provName}","${wareHouseVO.cityName}","${wareHouseVO.detllAddr}","${wareHouseVO.postCode}",
			"${wareHouseVO.areaCode}","${wareHouseVO.phoneNo}","${wareHouseVO.moblNo}","${wareHouseVO.faxNo}",
			"${wareHouseVO.emailAddr}","${action}");
	ko.applyBindings(viewModel, document.getElementById('warehouseForm'));
</script>
<div class="Panel_top">
	<span>
	<c:choose>
		<c:when test="${action =='create'}">
			<auchan:i18n id="101002010"></auchan:i18n>
		</c:when>
		<c:otherwise>
			<auchan:i18n id="101002014"></auchan:i18n><!-- 修改仓库 -->
		</c:otherwise>
	</c:choose>
	</span>
	<div class="PanelClose" onclick="closePopupWinTwo()"></div>
</div>
<div class="Tb_Panel2" style="height: 260px">
	<form id="warehouseForm" action="">
		<table class="CM_table">
			<tr>
				<td class="w20">
					<span>*&nbsp;<auchan:i18n id="101003023"></auchan:i18n></span>
				</td>
				<td>
					<input data-bind="value:whseNo,attr:{'readonly':isEdit()},validationElement:whseNo" type="text" name="whseNo" title="数字格式" class="inputText w20" 
					maxlength="4" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
				</td>
			</tr>
			<tr>
				<td class="w20">
					<span>*&nbsp;<auchan:i18n id="101002009"></auchan:i18n></span>
				</td>
				<td>
					<input data-bind="value:whseName,validationElement:whseName" type="text" name="whseName" class="inputText w50" maxlength="30" />
				</td>
			</tr>
			<tr>
				<td>
					<span>*&nbsp;<auchan:i18n id="101002004"></auchan:i18n></span>
				</td>
				<td>
					<div class="iconPut" style="width: 20%; float: left;">
						<input data-bind="value:addrId" id="addrId" name="addrId" type="hidden" />
						<input data-bind="value:provName,validationElement:provName" id="cr_provName" name="provName" type="text" readonly="readonly"
							style="width: 75%;" />
						<input id="code" name="code" type="hidden" />
						<div style="color: #999;"><auchan:i18n id="101002011"></auchan:i18n></div>
					</div>
					<div class="iconPut" style="width: 28%; float: left; margin-left: 7px;">
						<input data-bind="value:cityName,validationElement:cityName" id="cr_cityName" name="cityName" type="text" readonly="readonly"
							style="width: 69%;" />
						<div class="ListWin" onclick="openCityWindow()"></div>
						<input id="regnNo" name="regnNo" type="hidden" />
						<div style="color: #999;"><auchan:i18n id="101002012"></auchan:i18n></div>
					</div>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
					<input data-bind="value:detllAddr,validationElement:detllAddr" type="text" name="detllAddr" class="inputText w80" maxlength="30"/>
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101003025"></auchan:i18n></span>
				</td>
				<td>
					<input data-bind="value:postCode,validationElement:postCode" type="text" name="postCode" 
					class="inputText w20" maxlength="6" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101003027"></auchan:i18n></span>
				</td>
				<td>
					<input type="text" data-bind="value:areaCode,validationElement:areaCode" name="areaCode" 
					class="fl_left inputText w10" maxlength="4" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
					<span style="float: left; margin: 0;">-</span>
					<input type="text" data-bind="value:phoneNo,validationElement:phoneNo" name="phoneNo" 
					class="fl_left inputText w25" maxlength="8" onkeyup="this.value=this.value.replace(/\D/g,'')" />
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101002008"></auchan:i18n></span>
				</td>
				<td>
					<input data-bind="value:moblNo,validationElement:moblNo" name="moblNo" class="inputText w35 fl_left" 
					type="text" maxlength="12" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101003028"></auchan:i18n></span>
				</td>
				<td>
					<input type="text"  data-bind="value:areaCode,validationElement:areaCode"  class="fl_left inputText w10" 
					maxlength="4" onkeyup="this.value=this.value.replace(/\D/g,'')"/>
					<span style="float: left; margin: 0;">-</span>
					<input type="text" data-bind="value:faxNo,validationElement:faxNo"  name="faxNo" class="fl_left inputText w25" 
					maxlength="8" onkeyup="this.value=this.value.replace(/\D/g,'')" />
				</td>
			</tr>
			<tr>
				<td>
					<span>Email</span>
				</td>
				<td>
					<input data-bind="value:emailAddr,validationElement:emailAddr" name="emailAddr" class="inputText w60 fl_left" type="text" maxlength="30" />
				</td>
			</tr>
		</table>
	</form>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="viewModel.save()"><auchan:i18n id="100000002"></auchan:i18n></div>
		<div class="PanelBtn2" onclick="closePopupWinTwo()"><auchan:i18n id="100000003"></auchan:i18n></div>
	</div>
</div>
