;
if (typeof (Supplier) == "undefined") {
	Supplier = {};
};
Supplier.generalInfo = {	
	// 门店订单信息
	StoreSecInfo : function(catlgId, catlgName, storeNo, cataStatus, ordScope,
		buyrMemo, newStDiscDays, minOrdAmt, rtnAllow, leadTime, oplSched,
		dlvrySched, supRtnAddrId, supOrdAddrId,paySttus,apAmt,bpDisc,invDisc,othDisc,discMemo,visible) {
		
		var self = this;
		//店
		self.storeNo = ko.observable(storeNo);
		//课ID
		self.catlgId = ko.observable(catlgId);
		//课名称
		self.catlgName = ko.observable(catlgName);
		//切换课别信息
		self.clicCatlgName = function(obj, event) {
			
			$.each(viewModel.storeSecInfoList(), function(index, item) {
				item.visible(false);
			});
			var item = self;
			item.visible(true);
			
			//只读界面禁用下拉框(选择其他的信息)
			$("select").not("[name='storeChangeSelect']").find("option:not(:selected)").remove();
		};
		//门店课别状态
		self.cataStatus = ko.observable(cataStatus);
		//采购范围
		self.ordScope = ko.observable(ordScope);
		//备注 
		self.buyrMemo = ko.observable(buyrMemo);
		//新店折扣天数
		self.newStDiscDays = ko.observable(newStDiscDays);
		//最低订购
		self.minOrdAmt = ko.observable(minOrdAmt);
		//可否退货
		self.rtnAllow = ko.observable(rtnAllow);
		//准备天数 
		self.leadTime = ko.observable(leadTime);
		//OPL订货行程
		self.oplSched = ko.observable(new supplierCommon.WeekInfo(oplSched));
		//送货行程
		self.dlvrySched = ko.observable(new supplierCommon.WeekInfo(dlvrySched));
		//付款状态(财务系统同步过来，不需要维护)
		self.paySttus = ko.observable(paySttus);
		//应付余额(财务系统同步过来，不需要维护)
		self.apAmt = ko.observable(apAmt);
		//进价折扣(财务系统同步过来，不需要维护)
		self.bpDisc = ko.observable(bpDisc);
		//发票折扣(财务系统同步过来，不需要维护)
		self.invDisc = ko.observable(invDisc);
		//其他折扣(财务系统同步过来，不需要维护)
		self.othDisc = ko.observable(othDisc);
		//折扣备注(财务系统同步过来，不需要维护)
		self.discMemo = ko.observable(discMemo);
		
		//当前显示地址索引(0：订货地址，1：退货地址,默认显示订货地址)
		self.showAddressIndex = ko.observable('0');
		//切换定退货地址
		self.clickAddress = function(obj, event) {
			
			var index = $(event.target).find('input').val();
			self.showAddressIndex(index);
			if(index==0){
				self.supOrdAddr().visible(true);
				self.supRtnAddr().visible(false);
			}else{
				self.supOrdAddr().visible(false);
				self.supRtnAddr().visible(true);
			}
		};
		
		//定退货地址(0订货地址，1退货地址)
		var supRtnAddr = supplierCommon.fillAddressInfo(viewModel.comNo(),supRtnAddrId);
		self.supRtnAddr = ko.observable(supRtnAddr);
		
		var supOrdAddr = supplierCommon.fillAddressInfo(viewModel.comNo(),supOrdAddrId);
		self.supOrdAddr = ko.observable(supOrdAddr);
		self.supOrdAddr().visible(true);
		
		self.visible = ko.observable(visible);
	},
	ViewModel : function(supNo, status, comNo, comName, grpNo, grpName,unifmNo,
			supType, dlvryMethd, buyMethd, txtSup, cntrtType, validEndDate,
			ordAccptMethd, firstOrdQty, scmLvl,ordDiscIde,totApAmt,elecInvInd, addressInfo) {
		var self = this;
		//店号
		self.storeNo = ko.observable('');
		//采购厂编
		self.supNo = ko.observable(supNo);
		//厂商状态
		self.status = ko.observable(status);
		//公司编号
		self.comNo = ko.observable(comNo);
		//公司名称
		self.comName = ko.observable(comName);
		//集团编号
		self.grpNo = ko.observable(grpNo);
		//集团名称
		self.grpName = ko.observable(grpName);
		//公司税号
		self.unifmNo = ko.observable(unifmNo);
		//厂商种类 todo 
		self.supType = ko.observable(supType);
		//供货方式
		self.dlvryMethd = ko.observable(dlvryMethd);
		//采购方式数据
		self.buyMethdList = ko.observableArray([]);
		//采购方式
		self.buyMethd = ko.observable(buyMethd);
		//根据厂商种类获取采购方式
		self.supTypeClick = function(){
			$.ajax({
				type : 'post',
				url : ctx + '/item/create/getBuyMethd',
				data : {supId : self.supType()},
				success : function(data){
					self.buyMethdList([]);
					$.each(data, function(i, val){
						//self.buyMethdList.push(val);
						var v_supType = {};
						v_supType["code"] = val.code;
						v_supType["title"] = val.code+"-"+val.title;
						self.buyMethdList.push(v_supType);
					});
					self.buyMethd('');
				}
			});
		};
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
		//订单折让
		self.ordDiscIde = ko.observable(ordDiscIde=='1'?true:false);
		//网上对账级别
		self.totApAmt = ko.observable(totApAmt);
		//电子发票
		self.elecInvInd = ko.observable(elecInvInd);
		//地址信息
		self.addressInfo = ko.observable(addressInfo);
		self.storeSecInfoList = ko.observableArray([]);
		//新增门店课别
		self.checkSupplierModifiable = function() {
		
			$.ajax({
				type : "post",
				async : false,
				url : ctx + "/supplierAudit/checkSupplierModifiable",
				dataType : "json",
				data : {
					'supNo' : viewModel.supNo()
				},
				success : function(data) {
					
					if (data.status!='success') {
						top.jWarningAlert(data.message);
					} else {
						var param = {'supNo':viewModel.supNo(),'comNo':viewModel.comNo(),'action':'create','from':'generalInfo','comName':viewModel.comName(),'dlvryMethd':viewModel.dlvryMethd()};
						showContent(ctx + '/supplierAudit/createSupStoreSecInfo',param);
						//$("#content").load(ctx + '/supplierAudit/updateSupplierBySupNo?supNo=${supNo}&action=update');
					}
				}
			});
		};
		self.addStoreSecInfo = function(obj, event) {
			self.checkSupplierModifiable();
		};
		self.storeChange = function(obj, event) {
			if (self.storeNo() && self.storeNo() != '') {
				$.post(ctx + "/supplier/getSupplierSectionCatalog", {
					'storeNo' : self.storeNo(),
					'supNo' : self.supNo()
				}, function(data) {
					
					self.storeSecInfoList([]);
					$.each(data, function(index, item) {
						self.storeSecInfoList().push(
								new supplierGeneralInfo.StoreSecInfo(
										item.catlgId, item.catlgName,
										item.storeNo, item.status,
										item.ordScope, item.buyMemo,
										item.newStDiscDays, item.minOrdAmt,
										item.rtnAllow, item.leadTime,
										item.oplSched, item.dlvrySched,
										item.supRtnAddr, item.supOrdAddr,
										item.paySttus, item.apAmt, item.bpDisc,
										item.invDisc, item.othDisc,
										item.discMemo, false));
						self.storeSecInfoList(self.storeSecInfoList());
					});
					//只读界面禁用下拉框(选择其他的信息)
					$("select").not("[name='storeChangeSelect']").find("option:not(:selected)").remove();
					//默认选中一个课
					if($('.td2_1').size()>0){
						$($('.td2_1')[0]).trigger('click');
					}
				}, 'json');
			}
			
		};
	}
};
var supplierGeneralInfo = Supplier.generalInfo;