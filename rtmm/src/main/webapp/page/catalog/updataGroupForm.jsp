<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel2 {
	height: 200px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>

<script type="text/javascript">
	function ViewModel(name,enName,status) {
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
		
		self.save = function(form, event) {
			
			// 验证表单
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages(true);
				return;
			}
			var actionUrl = '/catalog/doUpdataGroup';
			var formData = $('#groupUpdateFrom').serialize();
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

	var viewModel = new ViewModel('${groupVO.name}','${groupVO.enName}','${groupVO.status}');
	ko.applyBindings(viewModel,document.getElementById('groupUpdateFrom'));
	$(function(){
		$("select[name='status']").find("option:not(:selected)").remove();
	});
</script>
<div id="updateForm">
	<div class="Panel_top">
		<span><auchan:i18n id="101006015"></auchan:i18n></span>
		<div class="PanelClose" onclick="closePopupWin()"></div>
	</div>
	<div class="Table_Panel2">
		<form id="groupUpdateFrom" action="">
			<table class="CM_table">
				<tr>
					<td>
						<span><auchan:i18n id="101006006"></auchan:i18n></span>
					</td>
					<td>
						<input type="text" class="inputText Black w35" readonly="readonly" 
						value="${groupVO.divisionId}-${groupVO.divisionName}" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101006007"></auchan:i18n></span>
					</td>
					<td>
						<input type="text" class="inputText Black w35" readonly="readonly"
						 value="${groupVO.sectionId}-${groupVO.sectionName}" />
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101006002"></auchan:i18n></span>
					</td>
					<td>
						<input value="${groupVO.code}" type="text" class="inputText Black w35" 
						readonly="readonly" />
						<input value="${groupVO.groupId}" name="id" type="hidden" class="inputText Black w35" 
						readonly="readonly" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101006003"></auchan:i18n></span>
					</td>
					<td>
						<input style="margin-left: 0px;" name="name" data-bind="value:name,validationElement:name" maxlength="15" type="text" class="inputText w70" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101006004"></auchan:i18n></span>
					</td>
					<td>
						<input data-bind="value: enName,validationElement: enName" name="enName" maxlength="35" class="inputText w70" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101006005"></auchan:i18n></span>
					</td>
					<td>
						<auchan:select name="status" dataBind="value:status" mdgroup="CL_CATALOG_STATUS" _class="w35 Black" ignoreValue="0,9" ></auchan:select>
						<!-- 							<select
							data-bind="options: statusName, optionsText: 'name', optionsValue: 'value', value: status"
							class="w35">
						</select> <font id="status" color="red">&nbsp;</font> -->
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="viewModel.save()"><auchan:i18n id="100000002"></auchan:i18n></div>
			<div class="PanelBtn2" onclick="closePopupWin()"><auchan:i18n id="100000003"></auchan:i18n></div>
		</div>
	</div>
</div>
