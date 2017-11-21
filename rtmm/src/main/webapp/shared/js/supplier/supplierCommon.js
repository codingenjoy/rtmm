;
if (typeof (Supplier) == "undefined") {
	Supplier = {};
};
Supplier.common = {
	Option:function(optionsText, optionsValue) {
		this.optionsText = optionsText;
		this.optionsValue = optionsValue;
	},
	Week:function(value, css) {
		var self = this;
		self.value = ko.observable(value);
		self.css = ko.observable(css);
		self.weekClick = function(obj,event){
			if (self.css() == 'weekon') {
				self.css('');
				self.value('0');
			} else {
				self.css('weekon');
				self.value('1');
			}
		};
	},
	WeekInfo:function(value) {
		
		var self = this;
		self.mon = ko.observable(value.substr(0,1));
		self.monClick = function(obj,event){
			if (self.mon() == '1') {
				self.mon('0');
			} else {
				self.mon('1');
			}
			self.checkAllComputed(self);
		};
		self.tue = ko.observable(value.substr(1,1));
		self.tueClick = function(obj,event){
			if (self.tue() == '1') {
				self.tue('0');
			} else {
				self.tue('1');
			}
			self.checkAllComputed(self);
		};
		self.wed = ko.observable(value.substr(2,1));
		self.wedClick = function(obj,event){
			if (self.wed() == '1') {
				self.wed('0');
			} else {
				self.wed('1');
			}
			self.checkAllComputed(self);
		};
		self.thu = ko.observable(value.substr(3,1));
		self.thuClick = function(obj,event){
			if (self.thu() == '1') {
				self.thu('0');
			} else {
				self.thu('1');
			}
			self.checkAllComputed(self);
		};
		self.fri = ko.observable(value.substr(4,1));
		self.friClick = function(obj,event){
			if (self.fri() == '1') {
				self.fri('0');
			} else {
				self.fri('1');
			}
			self.checkAllComputed(self);
		};
		self.sat = ko.observable(value.substr(5,1));
		self.satClick = function(obj,event){
			if (self.sat() == '1') {
				self.sat('0');
			} else {
				self.sat('1');
			}
			self.checkAllComputed(self);
		};
		self.sun = ko.observable(value.substr(6,1));
		self.sunClick = function(obj,event){
			if (self.sun() == '1') {
				self.sun('0');
			} else {
				self.sun('1');
			}
			self.checkAllComputed(self);
		};
		self.checkAll = ko.observable(false);
		self.checkAllClick = function(){
			
			if(!self.checkAll()){
				self.mon('1');
				self.tue('1');
				self.wed('1');
				self.thu('1');
				self.fri('1');
				self.sat('1');
				self.sun('1');
			}else{
				self.mon('0');
				self.tue('0');
				self.wed('0');
				self.thu('0');
				self.fri('0');
				self.sat('0');
				self.sun('0');
			}
		};
		self.checkAllComputed = function() {
			
			if(self.toString()=='1111111'){
				self.checkAll(true);
			}else{
				self.checkAll(false);
			}
		};
		self.toString = function() {
			var s = self.mon() + self.tue() + self.wed() + self.thu() + self.fri() + self.sat() + self.sun();
			return s;
		};
		if(value=='1111111'){
			self.checkAll(true);
		}else{
			self.checkAll(false);
		}
		
		
	},
	AddressInfo : function(addrId, provName, cityName, detailAddr, postCode,
			areaCode, cntctName, phoneNo, faxAreaCode, faxNo, moblNo,
			emailAddr, visible, validate) {
		var self = this;
		self.validate = ko.observable(validate!=undefined?validate:true);
		self.addrId = ko.observable(addrId);
		self.provName = ko.observable(provName).extend({
			required : {
				onlyIf : function() {
					return self.validate();
				},
				message : "请设置省"
			}
		});
		self.cityName = ko.observable(cityName).extend({
			required : {
				onlyIf : function() {
					return self.validate();
				},
				message : "请设置市"
			}
		});
		self.detailAddr = ko.observable(detailAddr).extend({
			required : {
				onlyIf : function() {
					return self.validate();
				},
				message : "请设置详细地址"
			}
		});
		self.postCode = ko.observable(postCode).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.areaCode = ko.observable(areaCode).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.cntctName = ko.observable(cntctName);
		self.phoneNo = ko.observable(phoneNo).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.faxAreaCode = ko.observable(faxAreaCode).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.faxNo = ko.observable(faxNo).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.moblNo = ko.observable(moblNo).extend({
			number : {
				params : true,
				message : "请输入数字"
			}
		});
		self.emailAddr = ko.observable(emailAddr).extend({
			email : {
				params : true,
				message : "Email格式不正确"
			}
		});
		self.visible = ko.observable(visible);
		self.openCityAndProvWindow = function(obj,event) {
			viewModel.tmpVal(event.currentTarget);
			openPopupWin(550, 410,'/commons/window/chooseCityAndProv?callback=confirmChooseCityAndProv');
		};
	},
	BankInfo : function(bankId, bankName, bankCnapCode, bankBranchId,
			bankBranchName, bankBranchCnapCode, bankAcctNo) {
		var self = this;
		self.bankId = ko.observable(bankId);
		self.bankName = ko.observable(bankName);
		self.bankCnapCode = ko.observable(bankCnapCode);
		self.bankBranchId = ko.observable(bankBranchId);
		self.bankBranchName = ko.observable(bankBranchName);
		self.bankBranchCnapCode = ko.observable(bankBranchCnapCode);
		self.bankBranchs = ko.observableArray([]);
		self.bankChange = function() {
			if (self.bankId() != '') {
				$.ajax({
					type : "post",
					async : false,
					url : ctx + "/supplier/getBankBranchInfo",
					dataType : "json",
					data : {
						'bankId' : self.bankId()
					},
					success : function(data) {
						self.bankBranchs.removeAll();
						$.each(data, function(index, item) {
							self.bankBranchs.push(new supplierCommon.Option(item.brnchBankId, item.brnchBankName));
						});
					}
				});
			}
		};
		//银行大额支付账号,由bankCnapCode和bankBranchCnapCode拼接而成 
		self.cnapCode = ko.observable('');
		self.cnapCodeChange = function(){
			if(self.bankCnapCode() != '' && self.bankBranchCnapCode() != ''){
				self.cnapCode(self.bankCnapCode()+self.bankBranchCnapCode());
			}
		};
		//银行账号
		self.bankAcctNo = ko.observable(bankAcctNo);
	},
	selectCompany : function() {
		openPopupWin(650, 550,'/commons/window/chooseSupCom');
	},
	selectDivision : function(status) {
		// 打开处课列表窗口
		openPopupWin(600, 500, "/commons/window/chooseSection?status="+status);
	},
	cloneAddressInfo : function(source) {
		var targetAddress = new supplierCommon.AddressInfo(
				source.addrId(), source.provName(), source.cityName(),source.detailAddr(), 
				source.postCode(),source.areaCode(), source.cntctName(), source.phoneNo(), 
				source.faxAreaCode(), source.faxNo(), source.moblNo(),
				source.emailAddr(), false, source.validate()
		);
		return targetAddress;
	},
	fillAddressInfo : function(comNo,addrId){
		
		var address = new supplierCommon.AddressInfo();
		if(comNo && comNo != '' && addrId && addrId != ''){
			$.ajax({
				type : "post",
				async : false,
				url : ctx + "/supplier/getComOtherAddressInfo",
				dataType : "json",
				data : {
					'comNo' : viewModel.comNo(),
					'addrId' : addrId
				},
				success : function(data) {
					address.addrId(data.addrId);
					address.provName(data.provName==null?'':data.provName);
					address.cityName(data.cityName==null?'':data.cityName);
					address.detailAddr(data.detllAddr==null?'':data.detllAddr);
					address.postCode(data.postCode==null?'':data.postCode);
					address.areaCode(data.areaCode==null?'':data.areaCode);
					address.cntctName(data.cntctName==null?'':data.cntctName);
					address.phoneNo(data.phoneNo==null?'':data.phoneNo);
					address.faxAreaCode(data.faxAreaCode==null?'':data.faxAreaCode);
					address.faxNo(data.faxNo==null?'':data.faxNo);
					address.moblNo(data.moblNo==null?'':data.moblNo);
					address.emailAddr(data.emailAddr==null?'':data.emailAddr);
				}
			});
		}
		return address;
	}
};
var supplierCommon = Supplier.common;