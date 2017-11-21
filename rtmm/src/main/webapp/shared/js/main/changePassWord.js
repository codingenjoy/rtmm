//验证两次密码是否一致
ko.validation.rules['custom1'] = {
	validator : function(val, self) {
		return !(self.newPwd() != '' && self.newPwdAgain() != '' && self
				.newPwd() != self.newPwdAgain());
	},
	message : '新密码两次输入不一致'
};

//验证密码由数字和字母组成
ko.validation.rules['pwStyleValidation'] = {	
	validator : function(val, self) {
		var numLength=0;
		var charLength=0;
		var isValid=false;
		for(var i=0;i<val.length;i++){
			if(/\d/.test(val.charAt(i))){
				numLength++;
			}
			else if(/^[A-Za-z]$/.test(val.charAt(i))){
				charLength++;
			}
		}
		if(numLength>0&&charLength>0){
			isValid=true;
		}
		return isValid;
	},
	message : '密码必须有数字和字母'
};
ko.validation.registerExtenders();

function ViewModel(flag) {
	var self = this;
	self.flag = ko.observable(flag);
	self.oldPwd = ko.observable('').extend({
		required : {
			params : true,
			message : "请输入原密码"
		}
	});
	self.newPwd = ko.observable('').extend({
		required : {
			params : true,
			message : "请输入新密码"
		},
		minLength : {
			params : 6,
			message : "密码最小长度为6位"
		},
		maxLength : {
			params : 18,
			message : "密码最大长度为18位"
		},
		pwStyleValidation : self,
	});
	self.newPwdAgain = ko.observable('').extend({
		required : {
			params : true,
			message : "请再次输入新密码"
		},
		custom1 : self
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
			url : ctx + "/setting/doChangePassWord",
			dataType : "json",
			data : {
				oldPlainPwd : self.oldPwd(),
				newCryptedPwd : $.md5(self.newPwd())
			},
			success : function(data) {
				if (data.status=='success') {
					$('.Table_Panel').hide();
					$('.Panel_footer').hide();
					$('.msgDiv').html('操作成功');
					$('.msgDiv').show();
					if(self.flag()=='isFirstLogin'){
						window.location.href=ctx+'/toLogin';
					}else{
						setTimeout(closePopupWin, "1000");
					}
				} else {
					$('.msgDiv').html(data.message);
					$('.msgDiv').show();
				}
			}
		});
	};
}

// 回车提交表单
$("#changePassword").bind("keypress", function(event) {
	if (event.keyCode == 13) {
		viewModel.save();
	}
});