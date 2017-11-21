// 验证用户名唯一
ko.validation.rules['whseNoUnique'] = {
	validator : function(val, param) {
		var isValid = true;
		$.ajax({
			async : false,
			url : ctx + '/catalog/checkWarehouseIsExists',
			type : 'POST',
			data : {
				warehouseNo : val
			},
			success : function(response) {
				isValid = (response != true);
			},
			error : function() {
				isValid = false; // however you would like to handle this
			}
		});
		return isValid;
	},
	message : '该编号已经存在'
};
ko.validation.registerExtenders();
function ViewModel(whseNo, whseName, addrId, provName, cityName, detllAddr,
		postCode, areaCode, phoneNo, moblNo, faxNo, emailAddr, action) {
	var self = this;
	self.whseNo = ko.observable(whseNo).extend({
		required : {
			params : true,
			message : "请输入仓库编号"
		},number : {
			parmas : true,
			message : "数字格式"
		}
	});
	self.whseName = ko.observable(whseName).extend({
		required : {
			params : true,
			message : "请输入仓库名称"
		}
	});
	self.addrId = ko.observable(addrId);
	self.provName = ko.observable(provName).extend({
		required : {
			params : true,
			message : "请选择省"
		}
	});
	self.cityName = ko.observable(cityName).extend({
		required : {
			params : true,
			message : "请选择城市"
		}
	});
	self.detllAddr = ko.observable(detllAddr).extend({
		required : {
			params : true,
			message : "请输入地址"
		}
	});
	self.postCode = ko.observable(postCode).extend({
		number : {
			parmas : true,
			message : "数字格式"
		}
	});
	self.areaCode = ko.observable(areaCode).extend({
		number : {
			params : true,
			message : "数字格式"
		}
	});
	self.phoneNo = ko.observable(phoneNo).extend({
		number : {
			params : true,
			message : "数字格式"
		}
	});
	self.moblNo = ko.observable(moblNo).extend({
		number : {
			params : true,
			message : "数字格式"
		}
	});
	self.isEdit = function() {
		if (self.action() == 'create') {
			return false;
		}
		else{
			return true;
		}
	};
	self.faxNo = ko.observable(faxNo).extend({
		number : {
			params : true,
			message : "数字格式"
		}
	});
	self.emailAddr = ko.observable(emailAddr).extend({
		email : {
			params : true,
			message : "Email格式有误"
		}
	});
	self.action = ko.observable(action);
	if(self.action()=='create'){
		self.whseNo.extend({
			whseNoUnique : self
		});
	}
	self.save = function(form, event) {
		
		// 验证表单
		viewModel.errors = ko.validation.group(viewModel);
		if (!viewModel.isValid()) {
			viewModel.errors.showAllMessages(true);
			return;
		}
		var actionUrl = '';
		if(self.action()=='create'){
			actionUrl = '/catalog/doCreatWarehouse';
		}else{
			actionUrl = '/catalog/doUpdataWarehouse';
		}
		var warehouseForm = $('#warehouseForm').serialize();
		$.ajax({
			type : 'post',
			url : ctx + actionUrl,
			data : warehouseForm,
			success : function(data) {
				if(data){
					top.jAlert('success', window.v_operationSuc, window.v_messages);
					closePopupWinTwo();
					pageQuery();
				} else {
					top.jAlert('error', window.v_operationSuc, window.v_messages);
				}
			}
		});
	};
}

// 修改仓库窗口
function warehouseUpdata(whseNo) {
	openPopupWinTwo(600, 360, "/catalog/updataWarehouse?whseNo=" + whseNo);
}

function cleanSearch() {
	$("table").find('input').val('');
	$("#storeNo").removeClass("errorInput");
}

function confirmChooseCity(cityId,cityName,provId,provName){
	
	$('#cr_provName').attr('value',provName).trigger('change');
	$('#cr_cityName').attr('value',cityName).trigger('change');
	closePopupWin();
}