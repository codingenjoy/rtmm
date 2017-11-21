;
if (typeof (Supplier) == "undefined") {
	Supplier = {};
};
Supplier.auditGeneralInfo = {
	//证件信息
	LicFun:function(licnceType, licnceNo, validEndDate) {
		var self = this;
		self.licnceType = ko.observable(licnceType);
		self.licnceNo = ko.observable(licnceNo);
		self.validEndDate = ko.observable(validEndDate);
	},
	//公司信息
	Company:function(comNo, comName, comEnName, unifmNo, status,
			comgrpNo, comgrpName, econType, legalRpstv, bizScopeDesc,
			setupDate, webSite) {
		var self = this;
		//公司编号
		self.comNo = ko.observable(comNo);
		//公司名称
		self.comName = ko.observable(comName);
		//公司英文名称
		self.comEnName = ko.observable(comEnName);
		//集团编号
		self.comgrpNo = ko.observable(comgrpNo);
		//集团名称
		self.comgrpName = ko.observable(comgrpName);
		//税号
		self.unifmNo = ko.observable(unifmNo);
		//公司名称
		self.status = ko.observable(status);
		//公司类型
		self.econType = ko.observable(econType);
		//法人代表
		self.legalRpstv = ko.observable(legalRpstv);
		//经营范围
		self.bizScopeDesc = ko.observable(bizScopeDesc);
		//注册日期
		self.setupDate = ko.observable(setupDate);
		self.regAddress = ko.observable(null);
		self.dlvAddress = ko.observable(null);
		self.webSite = ko.observable(webSite);
		//公司证件
		self.comLicencesList = ko.observableArray([]);
	},
	//厂商信息
	Supplier:function(supNo, status, comNo, comName, comgrpNo, comgrpName,unifmNo,
				supType, dlvryMethd, buyMethd, txtSup, cntrtType, validEndDate,
				ordAccptMethd, firstOrdQty, scmLvl,elecInvInd,ordDiscInd) {
		var self = this;
		//采购厂编
		self.supNo = ko.observable(supNo);
		//厂商状态
		self.status = ko.observable(status);
		//公司编号
		self.comNo = ko.observable(comNo);
		//公司名称
		self.comName = ko.observable(comName);
		//集团编号
		self.grpNo = ko.observable(comgrpNo);
		//集团名称
		self.grpName = ko.observable(comgrpName);
		//税号
		self.unifmNo = ko.observable(unifmNo);
		//厂商种类 todo 
		self.supType = ko.observable(supType);
		//供货方式
		self.dlvryMethd = ko.observable(dlvryMethd);
		//采购方式
		self.buyMethd = ko.observable(buyMethd);
		//txt厂编
		self.txtSup = ko.observable(txtSup);
		//合同标准
		self.cntrtType = ko.observable(cntrtType);
		//失效日期
		self.validEndDate = ko.observable(validEndDate);
		//订单发送方式
		self.ordAccptMethd = ko.observable(ordAccptMethd);
		//首订单量
		self.firstOrdQty = ko.observable(firstOrdQty);
		//网上对账级别
		self.scmLvl = ko.observable(scmLvl);
		self.elecInvInd = ko.observable(elecInvInd=='1'?true:false);
		self.ordDiscInd = ko.observable(ordDiscInd=='1'?true:false);
		self.address = ko.observable(null);
	},
	ViewModel:function(taskId,company,supplier) {
		var self = this;
		self.company = ko.observable(company);
		self.supplier = ko.observable(supplier);
		self.taskId = ko.observable(taskId);
	}	
};
var supplierauditGeneralInfo = Supplier.auditGeneralInfo;