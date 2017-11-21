<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel3 {
	height: 240px;
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
			var actionUrl = '/catalog/doUpdateSubGroup';
			var formData = $('#cr_updateSubsizeForm').serialize();
			$.ajax({
				type : 'post',
				url : ctx + actionUrl,
				data : formData,
				success : function(data) {
					if (data.status == 'success') {
						top.jSuccessAlert( window.v_operationSuc, window.v_messages);
						closePopupWin();
						pageQuery();
					} else {
						top.jErrorAlert(window.v_operationFail,window.v_messages);
						//closePopupWin();
					}
				}
			});
		};
	}

	var viewModel = new ViewModel('${subGroupVO.name}','${subGroupVO.enName}','${subGroupVO.status}');
	ko.applyBindings(viewModel);
	$(function(){
		$("select[name='status']").find("option:not(:selected)").remove();
	});
</script>
<div class="Panel_top">
	<span><auchan:i18n id="101008023"></auchan:i18n></span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<form id="cr_updateSubsizeForm" action="">
	<div class="Table_Panel3">
		<table class="CM_table" style="width: 90%; margin-left: 40px;">
			<tr>
				<td><span><auchan:i18n id="101009003"></auchan:i18n></span></td>
				<td>
					<input type="text" class="inputText Black w35" readonly="readonly" 
					value="${subGroupVO.divisionId}-${subGroupVO.divisionName}" />
				</td>
			</tr>
			<tr>
				<td><span><auchan:i18n id="101009004"></auchan:i18n></span></td>
				<td>
					<input type="text" class="inputText Black w35" readonly="readonly"
					 value="${subGroupVO.sectionId}-${subGroupVO.sectionName}" />
				</td>
			</tr>
			<tr>
				<td><span><auchan:i18n id="101009005"></auchan:i18n></span></td>
				<td>
					<input type="text" class="inputText Black w35" readonly="readonly"
					 value="${subGroupVO.groupNo}-${subGroupVO.groupName}" />
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101009006"></auchan:i18n></span>
				</td>
				<td>
					<input type="text" class="inputText Black w35" readonly="readonly"
					 value="${subGroupVO.midGroupNo}-${subGroupVO.midGroupName}" />
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td class="w35"><span><auchan:i18n id="101009007"></auchan:i18n></span></td>
				<td>
					<input type="text" name="code" value="${subGroupVO.code}"
					class="inputText Black w35" readonly="readonly" />
					<input type="hidden" value="${subGroupVO.subGroupId}" name="id"/>
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101008005"></auchan:i18n></span>
				</td>
				<td>
					<input type="text" name="name" class="inputText w60" maxlength="15" data-bind="value:name,validationElement: name" />
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101008006"></auchan:i18n></span>
				</td>
				<td>
					<input type="text" name="enName" class="inputText w90" maxlength="35" data-bind="value:enName,validationElement: enName" />
				</td>
			</tr>
			<tr>
				<td>
					<span><auchan:i18n id="101008007"></auchan:i18n></span>
				</td>
				<td>
					<auchan:select name="status" dataBind="value: status" mdgroup="CL_CATALOG_STATUS" _class="w35 Black" ignoreValue="0,9"></auchan:select>
					<!-- 						<select data-bind="options: statusName, optionsText: 'name', optionsValue: 'value', value: viewModel.status" class="w35">
						</select>
						<font color="red">&nbsp;</font> -->
				</td>
			</tr>
			<tr style="display: none">
				<td colspan="3" style="height: 155px;">
					<table class="w100">
						<tr style="text-align: center;">
							<td class="w20">&nbsp;</td>
							<td class="w11"><auchan:i18n id="101008013"></auchan:i18n></td>
							<td class="w11"><auchan:i18n id="101008016"></auchan:i18n></td>
							<td class="w11"><auchan:i18n id="101008014"></auchan:i18n></td>
							<td class="w11"><auchan:i18n id="101008018"></auchan:i18n></td>
							<td class="w12"><auchan:i18n id="101008019"></auchan:i18n></td>
							<td class="w12"><auchan:i18n id="101008015"></auchan:i18n></td>
							<td class="w12"><auchan:i18n id="101008017"></auchan:i18n></td>
						</tr>
						<tr>
							<td>
								<span>B-Basic</span>
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
						</tr>
						<tr>
							<td>
								<span>N-National</span>
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
						</tr>
						<tr>
							<td>
								<span>O-Optional</span>
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
						</tr>
						<tr>
							<td>
								<span>L-Local</span>
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
							<td>
								<input type="text" class="inputText w85" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="viewModel.save()"><auchan:i18n id="100000004"></auchan:i18n></div>
			<div class="PanelBtn2" onclick="closePopupWin()"><auchan:i18n id="100000003"></auchan:i18n></div>
		</div>
	</div>
</form>
