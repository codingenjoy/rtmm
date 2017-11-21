<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/page/commons/knockout.jsp" />
<script src="${ctx}/shared/js/catalog/catalogCommon.js" type="text/javascript"></script>
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
	function ViewModel() {
		var self = this;
		self.divisionId = ko.observable('').extend({
			required : {
				params : true,
				message : "请输入处别"
			}
		});
		self.sectionId = ko.observable('').extend({
			required : {
				params : true,
				message : "请输入课别"
			}
		});
		self.groupId = ko.observable('').extend({
			required : {
				params : true,
				message : "请输入大分类"
			}
		});
		self.midGroupId = ko.observable('').extend({
			required : {
				params : true,
				message : "请输入大分类"
			}
		});
		self.code = ko.observable('').extend({
			required : {
				params : true,
				message : "请输入小分类"
			},
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.name = ko.observable('').extend({
			required : {
				params : true,
				message : "请输入中文名称"
			}
		});
		self.enName = ko.observable('').extend({
			required : {
				params : true,
				message : "请输入英文名称"
			}
		});
		self.status = ko.observable('').extend({
			required : {
				params : true,
				message : "请输入状态"
			}
		});
		self.IdleDays = ko.observable('').extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.outofstock = ko.observable('').extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.popDms = ko.observable('').extend({
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
			var actionUrl = '/catalog/doCreateSubGroup';
			var formData = $('#cr_createSubsizeForm').serialize();
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
						top.jWarningAlert(data.message,window.v_messages);
						//closePopupWin();
					}
				}
			});
		};
	}

	var viewModel = new ViewModel();
	ko.applyBindings(viewModel);

	//默认不显示错误消息
	viewModel.errors = ko.validation.group(viewModel);
	viewModel.errors.showAllMessages(false);
	
</script>
<div class="Panel_top">
	<span><auchan:i18n id="101008022"></auchan:i18n></span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel3">
	<form id="cr_createSubsizeForm">
	<table class="CM_table" style="width:90%;margin-left:40px;">
		<tr>
			<td>
				<span>*&nbsp;<auchan:i18n id="101008008"></auchan:i18n></span>
			</td>
			<td>
				<select id="divisionId" name="divisionId" onchange="sectionSelect(this.value,'createSectionId')"  data-bind="value:divisionId,validationElement:divisionId" class="w35">
					<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
					<c:forEach items="${divisionList }" var="item">
						<option value="${item.id}">${item.id}-${item.name}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<span>*&nbsp;<auchan:i18n id="101008009"></auchan:i18n></span>
			</td>
			<td>
				<select id="createSectionId" name="sectionId" class="w35" onchange="groupSelect(this.value,'createGroupId')" data-bind="value:sectionId,validationElement:sectionId">
				<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<span>*&nbsp;<auchan:i18n id="101008002"></auchan:i18n></span>
			</td>
			<td>
				<select id="createGroupId" name="groupId" class="w35" onchange="subGroupSelect(this.value,'createMidGroupId')" data-bind="value:groupId,validationElement:groupId">
				<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
				</select>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
				<span>*&nbsp;<auchan:i18n id="101008003"></auchan:i18n></span>
			</td>
			<td>
				<select id="createMidGroupId" name="midGroupId" title="请选择中分类" class="w35" data-bind="value:midGroupId,validationElement:midGroupId">
				<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
				</select>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
				<span>*&nbsp;<auchan:i18n id="101008004"></auchan:i18n></span>
			</td>
			<td>
			<input id="code" name="code" type="text" class="inputText w35" title="数字格式" 
			maxlength="3" data-bind="value:code,validationElement:code"/>
			</td>
		</tr>
		<tr>
			<td>
				<span>*&nbsp;<auchan:i18n id="101008005"></auchan:i18n></span>
			</td>
			<td>
				<input id="name" name="name" type="text" style="margin-left: 0px;" maxlength="15" 
				class="inputText w70" title="请输入中文名称" data-bind="value:name,validationElement:name" />
			</td>
		</tr>
		<tr>
			<td>
				<span>*&nbsp;<auchan:i18n id="101008006"></auchan:i18n></span>
			</td>
			<td>
				<input type="text" id="enName" name="enName" maxlength="35" class="inputText w70" title="请输入英文名称"
				 data-bind="value:enName,validationElement:enName"/>
			</td>
		</tr>
		<tr>
			<td>
				<span>*&nbsp;<auchan:i18n id="101008007"></auchan:i18n></span>
			</td>
			<td>
				<select id="status" name="status" class="w35 Black" data-bind="value:status,validationElement:status">
					<option value="1">1-正常</option>
				</select>
			</td>
		</tr>
		</table>
	</form>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="viewModel.save()"><auchan:i18n id="100000004"></auchan:i18n></div>
		<div class="PanelBtn2" onclick="closePopupWin()"><auchan:i18n id="100000003"></auchan:i18n></div>
	</div>
</div>