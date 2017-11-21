<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel2 {
	height: 360px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">
	function ViewModel(name,enName,status,IdleDays,oosTimesDms,popDms) {
		var self = this;
		self.name = ko.observable(name).extend({
			required : {
				params : true,
				message : "请输入中文名称"
			}
		});
		self.enName = ko.observable(enName).extend({
			required : {
				params : true,
				message : "请输入英文名称"
			}
		});
		self.status = ko.observable(status).extend({
			required : {
				params : true,
				message : "请输入状态"
			}
		});
		self.IdleDays = ko.observable(IdleDays).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.oosTimesDms = ko.observable(oosTimesDms).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.popDms = ko.observable(popDms).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.save = function(form, event) {
			
			// 验证表单
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages(true);
				return;
			}
			var actionUrl = '/catalog/doUpdateMidGroup';
			var formData = $('#updateMidGroupForm').serialize();
			$.ajax({
				type : 'post',
				url : ctx + actionUrl,
				data : formData,
				success : function(data) {
					if(data.status=='success'){
						top.jSuccessAlert(window.v_operationSuc,window.v_messages);
						closePopupWin();
						pageQuery();
					}else{
						top.jErrorAlert(window.v_operationFail,window.v_messages);
					}
				}
			});
		};
	}

	var viewModel = new ViewModel('${midsizeGroupVO.name}','${midsizeGroupVO.enName}','${midsizeGroupVO.status}',
			'${idleDays}','${midGrpCtrlVO.oosTimesDms}','${midGrpCtrlVO.popDms}');
	ko.applyBindings(viewModel);
	$(function(){
		$("#statusSelect").find("option:not(:selected)").remove();
	});
</script>
<div>
	<form id="updateMidGroupForm">
	<div class="Panel_top">
		<span><auchan:i18n id="101007022"></auchan:i18n></span>
		<div class="PanelClose" onclick="closePopupWin()"></div>
	</div>
	<div class="Table_Panel2">
			<table class="CM_table">
				<tr>
					<td><span><auchan:i18n id="101007007"></auchan:i18n></span></td>
					<td>
						<input type="text" class="inputText Black w35" readonly="readonly" 
						value="${midsizeGroupVO.divisionId}-${midsizeGroupVO.divisionName}" />
					</td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="101007008"></auchan:i18n></span></td>
					<td>
						<input type="text" class="inputText Black w35" readonly="readonly"
						 value="${midsizeGroupVO.sectionId}-${midsizeGroupVO.sectionName}" />
					</td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="101007002"></auchan:i18n></span></td>
					<td>
						<input type="text" class="inputText Black w35" readonly="readonly"
						 value="${midsizeGroupVO.groupNo}-${midsizeGroupVO.groupName}" />
					</td>
				</tr>
				<tr>
					<td class="w35"><span><auchan:i18n id="101007003"></auchan:i18n></span></td>
					<td>
						<input type="text" name="code" value="${midsizeGroupVO.code}"
						class="inputText Black w35" readonly="readonly" />
						<input type="hidden" value="${midsizeGroupVO.midGroupId}" name="id"/>
					</td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="101007004"></auchan:i18n></span></td>
					<td>
						<input name="name" type="text" style="margin-left: 0px;" maxlength="15" 
						data-bind="value: name,validationElement: name"
						class="inputText w70" />
					</td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="101007005"></auchan:i18n></span></td>
					<td>
						<input type="text" name="enName"
						data-bind="value: enName, validationElement: enName" maxlength="35" 
						class="inputText w70" />
					</td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="101007006"></auchan:i18n></span></td>
					<td>
						<auchan:select id="statusSelect" name="status" dataBind="value:status" mdgroup="CL_CATALOG_STATUS" _class="w35 Black" ignoreValue="0,9"></auchan:select>
<!-- 						<select
							data-bind="options: statusName, optionsText: 'name', optionsValue: 'value', value: status"
							class="w35">
						</select> -->
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101007012"></auchan:i18n></span>
					</td>
					<td>
						<auchan:select mdgroup="CL_MID_GRP_CTRL_SPECL_GRP_CTRL" _class="w35"  
						name="specialGrpCtrl" value="${midGrpCtrlVO.specialGrpCtrl}" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101007013"></auchan:i18n></span>
					</td>
					<td>
						<auchan:select mdgroup="CL_MID_GRP_CTRL_STOCK_CTRL" _class="w35"
						name="stockCtrl" value="${midGrpCtrlVO.stockCtrl}" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101007016"></auchan:i18n></span>
					</td>
					<td>
						DMS &gt;&nbsp;<input id="selllikewildfire" data-bind="value:popDms,validationElement:popDms" 
						name="popDms" type="text" title="数字格式"  
						class="inputText w23" maxlength="8"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101007017"></auchan:i18n></span>
					</td>
					<td>
						<auchan:i18n id="101007018"></auchan:i18n>&nbsp; &lt;&nbsp;<input id="oosTimesDms" data-bind="value:oosTimesDms,validationElement:oosTimesDms" 
						name="oosTimesDms" type="text" title="数字格式"
						 class="inputText w23" maxlength="8"/>&nbsp;x&nbsp;DMS
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101007019"></auchan:i18n></span>
					</td>
					<td>
						<input id="days" name="IdleDays" data-bind="value:IdleDays,validationElement:IdleDays" type="text" 
						class="inputText w15" title="数字格式" maxlength="8"/>&nbsp;天
					</td>
				</tr>
<!-- 				<tr>
				<td>
					<span>进价税率</span>
				</td>
				<td>
					<input data-bind="value: buyVatNo,validationElement: buyVatNo" id="buyVatNo" name="buyVatNo" type="text" class="inputText w15" title="数字格式" maxlength="2" />&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					<span>售价税率</span>
				</td>
				<td>
					<input data-bind="value: sellVatNo,validationElement: sellVatNo" id="sellVatNo" name="sellVatNo" type="text" class="inputText w15" title="数字格式" maxlength="2" />&nbsp;
				</td>
			</tr> -->
			</table>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="viewModel.save()"><auchan:i18n id="100000004"></auchan:i18n></div>
			<div class="PanelBtn2" onclick="closePopupWin()"><auchan:i18n id="100000003"></auchan:i18n></div>
		</div>
	</div>
	</form>
</div>
