function ViewModel(lang,theme) {
	var self = this;
	self.lang = ko.observable(lang).extend({
		required : {
			params : true,
			message : "请选择语言"
		}
	});
	self.theme = ko.observable(theme).extend({
		required : {
			params : true,
			message : "请选择主题"
		}
	});
	self.save = function(form, event) {
		// 验证表单
		viewModel.errors = ko.validation.group(viewModel);
		if (!viewModel.isValid()) {
			viewModel.errors.showAllMessages();
			return;
		}
		// 提交表单
		$.ajax({
			type : "post",
			async : false,
			url : ctx + "/setting/doChangeUserPreference",
			dataType : "json",
			data : {
				lang : self.lang(),
				theme : self.theme()
			},
			success : function(data) {
				if (data) {
					$('.Table_Panel').hide();
					$('.Panel_footer').hide();
					$('.msgDiv').html('操作成功');
					$('.msgDiv').show();
					window.location.href = ctx + '/index';
				} else {
					$('.Table_Panel').hide();
					$('.Panel_footer').hide();
					$('.msgDiv').html('操作失败');
					$('.msgDiv').show();
					setTimeout(closePopupWin, "3000");
				}
			}
		});
	};
}
// 回车提交表单
$("#userPreference").bind("keypress", function(event) {
	if (event.keyCode == 13) {
		viewModel.save();
	}
});