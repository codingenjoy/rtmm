;
if (typeof (Supplier) == "undefined") {
	Supplier = {};
};
Supplier.createPayment = {
	ViewModel : function(action,supNo,taskId, comNo, comEnName, comName, payMethd,
			payPerd, frontPay, rtnMail, autoMatch, asignType, manulGui,bankInfo) {
		var self = this;
		self.action = ko.observable(action);
		//采购厂编
		self.supNo = ko.observable(supNo);
		//任务编号
		self.taskId = ko.observable(taskId);
		//公司编号
		self.comNo = ko.observable(comNo);
		//公司英文名称
		self.comEnName = ko.observable(comEnName);
		//公司名称
		self.comName = ko.observable(comName);
		//付款方式
		self.payMethd = ko.observable(payMethd);
		//付款批次
		self.payPerd = ko.observable(payPerd).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		//付款周期
		self.frontPay = ko.observable(frontPay);
		//退货回传
		self.rtnMail = ko.observable(rtnMail!='0'?true:false);
		//退货过账
		self.autoMatch = ko.observable(autoMatch).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		//债权状态
		self.asignType = ko.observable(asignType).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		;
		//人工销项发票开立
		self.manulGui = ko.observable(manulGui!='0'?true:false);
		//银行信息
		self.bankInfo = ko.observable(bankInfo);
		//self.bankList = ko.observableArray([bankInfo]);
		self.save = function(flag) {
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
				url : ctx + "/supplierAudit/doCreateSupPayment",
				dataType : "json",
				data : {
					'jsonStr' : ko.toJSON(viewModel),
					'action' : self.action()
				},
				success : function(data) {
					if (data.result) {
						if(flag != 'nextSetp'){
							top.jAlert('success','操作成功','提示消息');
						}
					} else {
						top.jAlert('warning','操作失败','提示消息');
					}
				}
			});
		};
	}
};
var supplierCreatePayment = Supplier.createPayment;