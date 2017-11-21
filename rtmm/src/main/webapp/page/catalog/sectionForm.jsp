<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<jsp:include page="/page/commons/knockout.jsp" />
<style type="text/css">
.Table_Panel {
	height: 190px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">
	function ViewModel(id, code, name, enName, status) {
		var self = this;
		self.id = ko.observable(id);
		self.code = ko.observable('').extend({
			required : {
				params : true,
				message : "请输入课别"
			}
		});
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
				message : "请选择状态"
			}
		});
		;
		self.save = function(form, event) {
			// 验证表单
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages();
				return;
			}
			// 提交表单
			$.ajax({
				type : "POST",
				url : ctx + "/catalog/doSaveSection",
				dataType : "json",
				data : {
					id : self.id(),
					code : self.code(),
					name : self.name(),
					enName : self.enName(),
					status : self.status()
				},
				success : function(data) {
					if (data) {
						top.jSuccessAlert('操作成功');
					} else {
						top.jErrorAlert('操作失败');
					}
					closePopupWin();
				}
			});
		};
	}
	var viewModel = new ViewModel('','','','','');
	ko.applyBindings(viewModel);
</script>
<div class="Panel_top">
	<span>维护课信息</span>
	<div class="PanelClose" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<table class="CM_table">
		<tr>
			<td class="w35">
				<span>课别</span>
			</td>
			<td>
				<input type="text" class="inputText w35" data-bind="value:viewModel.code" /> <font color="red" data-bind="validationMessage:viewModel.code">&nbsp;</font>
			</td>
		</tr>
		<tr>
			<td>
				<span>中文名称</span>
			</td>
			<td>
				<input type="text" class="inputText w35" data-bind="value:viewModel.name" /> <font color="red" data-bind="validationMessage:viewModel.name">&nbsp;</font>
			</td>
		</tr>
		<tr>
			<td>
				<span>英文名称</span>
			</td>
			<td>
				<input type="text" class="inputText w55" data-bind="value:viewModel.enName" /> <font color="red" data-bind="validationMessage:viewModel.enName">&nbsp;</font>
			</td>
		</tr>
		<tr>
			<td>
				<span>状态</span>
			</td>
			<td>
				<select class="w35" data-bind="value:viewModel.status">
					<option value="">请选择</option>
					<option value="0">0- 尚未生效</option>
					<option value="1">1- 正常</option>
					<option value="9">9- 删除</option>
				</select> <font color="red" data-bind="validationMessage:viewModel.status">&nbsp;</font>
			</td>
		</tr>
	</table>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" data-bind='event:{click:$root.save}'>保存</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>