;
if (typeof (Supplier) == "undefined") {
	Supplier = {};
};
Supplier.createBaseInfo = {
	ViewModel : function(action,taskId, supNo, status, comNo, comName, grpNo, grpName,
			supType, dlvryMethd, buyMethd, txtSup, cntrtType, validEndDate,
			ordAccptMethd, firstOrdQty, scmLvl,elecInvInd, ordDiscInd,addressInfo) {
		var self = this;
		//存储临时变量
		self.tmpVal = ko.observable();
		self.action = ko.observable(action);
		//任务编号
		self.taskId = ko.observable(taskId);
		//采购厂编
		self.supNo = ko.observable(supNo);
		//厂商状态
		if (action == 'create') {
			self.status = ko.observable('0').extend({
				required : {
					params : true,
					message : "请设置厂商状态"
				}
			});
		} else {
			self.status = ko.observable(status).extend({
				required : {
					params : true,
					message : "请设置厂商状态"
				}	
			});
		}
		//公司编号
		self.comNo = ko.observable(comNo).extend({
			required : {
				params : true,
				message : "请设置公司"
			}
		});
		//公司名称
		self.comName = ko.observable(comName);
		//集团编号
		self.grpNo = ko.observable(grpNo);
		//集团名称
		self.grpName = ko.observable(grpName);
		//厂商种类 todo 
		self.supType = ko.observable(supType).extend({
			required : {
				params : true,
				message : "请设置厂商种类"
			}
		});
		//供货方式
		self.dlvryMethd = ko.observable(dlvryMethd).extend({
			required : {
				params : true,
				message : "请设置供货方式"
			}
		});
		//采购方式
		self.buyMethd = ko.observable(buyMethd).extend({
			required : {
				params : true,
				message : "请设置采购方式"
			}
		});
		self.isEdit = function() {
			
			if (self.action() != 'update' ) {
				return false;
			}
			else{
				return true;
			}
		};
		//采购方式数据
		self.buyMethdList = ko.observableArray([]);
		self.changeSupType = function(val) {
			if(self.supType()!=''){
				$.ajax({
					type : "post",
					async : false,
					url : ctx + "/supplier/handleGetBuyMethdBySupType",
					dataType : "json",
					data : {
						'supType' : self.supType()
					},
					success : function(data) {
						$("#selectHidden").css("display","none");
						$("#buyMethdHidden").css("display","block");
						self.buyMethdList.removeAll();
						$.each(data, function(index, item) {
							self.buyMethdList.push(new supplierCommon.Option(item.value+'-'+item.code,item.value));
						});
						
						//默认不显示错误消息
						viewModel.errors = ko.validation.group(viewModel);
						viewModel.errors.showAllMessages(false);
					}
				});
			}
			if(!isNaN(val)){
				self.buyMethd(val);
			}
		};
		self.changeBuyMethd = function() {
			
			if(self.buyMethd()==7){
				self.scmLvl(3);
			}
		};
		//txt厂编
		self.txtSup = ko.observable(txtSup);
		//合同标准
		self.cntrtType = ko.observable(cntrtType).extend({
			required : {
				params : true,
				message : "请设置合同标准"
			}
		});
		//失效日期
		self.validEndDate = ko.observable(validEndDate);
		//订单发送方式
		self.ordAccptMethd = ko.observable(ordAccptMethd||'2');
		//首订单量
		self.firstOrdQty = ko.observable(firstOrdQty||0).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		//网上对账级别
		self.scmLvl = ko.observable(scmLvl);
		//电子发票
		self.elecInvInd = ko.observable(elecInvInd=='0'?false:true);
		//电子发票
		self.ordDiscInd = ko.observable(ordDiscInd=='0'?false:true);
		//地址信息
		self.addressInfo = ko.observable(addressInfo);
		self.save = function(flag) {
			//清空临时变量值
			viewModel.tmpVal('');
			// 验证表单
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages(true);
				return false;
			}
			
			// 提交表单
			$.ajax({
				type : "post",
				async : false,
				url : ctx + "/supplierAudit/doCreateSupplier",
				dataType : "json",
				data : {
					'jsonStr' : ko.toJSON(viewModel),
					'action' : self.action()
				},
				success : function(data) {
					if (data.result) {
						viewModel.taskId(data.taskId);
						if(flag != 'nextSetp'){
							//alert('操作成功');
							top.jAlert('success', '操作成功','提示消息');
						}
					} else {
						//alert('操作失败');
						top.jAlert('warning', '操作失败','提示消息');
					}
				}
			});
			return true;
		};
	}
	
};
var supplierCreateBaseInfo = Supplier.createBaseInfo;