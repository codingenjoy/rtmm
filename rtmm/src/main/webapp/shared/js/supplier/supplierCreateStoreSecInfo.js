;
if (typeof (Supplier) == "undefined") {
	Supplier = {};
};
Supplier.createStoreSecInfo = {	
	//下传区域信息
	StoreOrderInfo:function(grpId,storeNo,storeName,cataStatus, minOrdAmt, rtnAllow,
			leadTime, oplSched, dlvrySched, supRtnAddrId, supOrdAddrId, visible,storeNameArea) {
		
		var self = this;
		self.visible = ko.observable(visible);
		self.grpId = ko.observable(grpId);
		self.storeNo = ko.observable(storeNo);
		self.storeName = ko.observable(storeName);
		self.storeNameArea=ko.observable(storeNameArea);
		//删除下传区域组
		self.delStoreGroupInfo = function(obj) {
			//search catalog index
			var cataIndex = null;
			$.each(viewModel.cataInfoList(), function(index, item) {
				if (item.catlgId() == viewModel.catlgId()) {
					cataIndex = index;
					return false;
				}
			});
			//remove store group
			viewModel.cataInfoList()[cataIndex].storeOrderInfoList.remove(obj);
		};
		//切换下传区域组
		self.switchStoreGroup = function(obj, event) {
			
			//search catalog index
			var cataIndex = null;
			$.each(viewModel.cataInfoList(), function(index, item) {
				if (item.visible() == true) {
					cataIndex = index;
					return false;
				}
			});
			//search store index
			$.each(viewModel.cataInfoList()[cataIndex].storeOrderInfoList(),
				function(index, item) {
					
					if (item.grpId() == obj.grpId()) {
						item.visible(true);
						item.showAddressIndex(0);
					} else {
						item.visible(false);
					}
			});
	
		};
		//门店课别状态
		self.cataStatus = ko.observable(cataStatus);
		//最低订购
		self.minOrdAmt = ko.observable(minOrdAmt||0).extend({
			required : {
				onlyIf : function() {
					return viewModel.action() != 'update';
				},
				message : "请设置最低订购"
			}
		});
		//可否退货
		self.rtnAllow = ko.observable(rtnAllow).extend({
			required : {
				onlyIf : function() {
					return viewModel.action() != 'update';
				},
				message : "请设置可否退货"
			}
		});
		//准备天数 
		self.leadTime = ko.observable(leadTime).extend({
			required : {
				onlyIf : function() {
					return viewModel.action() != 'update';
				},
				message : "请设置准备天数"
			}
		});
		//OPL订货行程
		self.oplSched = ko.observable(new supplierCommon.WeekInfo(oplSched||'0000000'));
		self.oplSchedStr = ko.computed(function() {
			return self.oplSched().toString();
		});
		self.oplSched.extend({ 
	        validation: {
		        validator: function (obj) {
					if(obj.toString() == '0000000' && viewModel.action() == 'create'){
						return false;
					}else{
					  return true;
				  }
		        },
		        message: "请设置OPL订货行程" 
	        }
		});
		//送货行程
		self.dlvrySched = ko.observable(new supplierCommon.WeekInfo(dlvrySched||'0000000'));
		self.dlvrySchedStr = ko.computed(function() {
			return self.dlvrySched().toString();
		});
		self.dlvrySched.extend({ 
	        validation: {
		        validator: function (obj) {
					if(obj.toString() == '0000000' && viewModel.action() == 'create'){
						return false;
					}else{
					  return true;
				  }
		        },
		        message: "请设置送货行程" 
	        }
		});
		//-----------------------------------------退退货地址相关操作-------------------------------------------------
		//定退货地址(0订货地址，1退货地址)
		var supOrdAddr = supplierCommon.fillAddressInfo(viewModel.comNo(),supOrdAddrId);
		self.supOrdAddr = ko.observable(supOrdAddr);
		var supRtnAddr = supplierCommon.fillAddressInfo(viewModel.comNo(),supRtnAddrId);
		self.supRtnAddr = ko.observable(supRtnAddr);
		
		supOrdAddr.validate(false);
		supRtnAddr.validate(false);
		
		//当前显示地址索引(0：订货地址，1：退货地址,默认显示订货地址)
		self.showAddressIndex = ko.observable('');
		self.showAddressIndex.subscribe(function(newValue) {
			if(newValue=='0'){
				self.supOrdAddr().visible(true);
				self.supRtnAddr().visible(false);
			}else{
				self.supOrdAddr().visible(false);
				self.supRtnAddr().visible(true);
			}
		});
		self.showAddressIndex('0');
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
		//选择地址
		self.chooseSupAddress = function(obj, event) {
			viewModel.tmpVal($(event.currentTarget));
			openPopupWin(800, 527, '/supplier/chooseComOtherAddr?comNo=' + viewModel.comNo());
		};
		//选择新地址后填充地址栏信息(弹出框确定后保存值)
		self.selectAddressId = ko.observable('');
		self.selectAddressId.subscribe(function(newValue) {
			
			var index = self.showAddressIndex();
			var address = supplierCommon.fillAddressInfo(viewModel.comNo(),newValue);
			if(viewModel.action()!='update'){
				address.validate(false);
			}
			address.visible(false);
			if(self.relatedAddress() == true){
				//勾选定退货地址关联，则两个地址都是一样的
				self.supOrdAddr(address);
				self.supRtnAddr(supplierCommon.cloneAddressInfo(address));//订货地址克隆一份
			}else if(index == '0'){
				self.supOrdAddr(address);
			}else if(index == '1'){
				self.supRtnAddr(address);
			}
			if(index=='0'){
				self.supOrdAddr().visible(true);
				self.supRtnAddr().visible(false);
			}else{
				self.supOrdAddr().visible(false);
				self.supRtnAddr().visible(true);
			}
		});
		//定退货地址关联(复选框)
		self.relatedAddress = ko.observable('');
		self.relatedAddress.subscribe(function(newValue) {
			
			if(newValue){
				var index = self.showAddressIndex();
				var supOrdAddr = self.supOrdAddr();//订货地址
				var supRtnAddr = self.supRtnAddr();//退货地址
				if(index=='0'){
					//将订货地址拷贝到退货地址
					self.supRtnAddr(supplierCommon.cloneAddressInfo(supOrdAddr));
				}else if(index=='1'){
					//将退货地址拷贝到订货地址
					self.supOrdAddr(supplierCommon.cloneAddressInfo(supRtnAddr));
				}
			}
		});
		if(viewModel.action()!='view'){
		self.relatedAddress(true);
		}
	},
	//课别信息
	CataInfo:function(catlgId, catlgName, ordScope, buyrMemo,
			newStDiscDays, storeInfoList, visible) {
		var self = this;
		//课ID
		self.catlgId = ko.observable(catlgId);
		//课名称
		self.catlgName = ko.observable(catlgName);
		//采购范围
		self.ordScope = ko.observable(ordScope);
		//采购备注
		self.buyrMemo = ko.observable(buyrMemo);
		//新店折扣天数
		self.newStDiscDays = ko.observable(newStDiscDays).extend({
			number : {
				params : true,
				message : "请设置数字"
			}
		});
		//下传区域信息
		self.storeOrderInfoList = ko.observableArray(storeInfoList);
		//是否显示
		self.visible = ko.observable(visible);
		//切换课别
		self.switchSection = function(obj,event) {
			
			$.each(viewModel.cataInfoList(), function(index, item) {
				if (obj.catlgId() == item.catlgId()) {
					item.visible(true);
					
					//先隐藏所有下传区域
					$.each(item.storeOrderInfoList(),function(index,obj){
						obj.visible(false);
					});
					//显示第一个下传区域
					if(item.storeOrderInfoList().length>0){
						item.storeOrderInfoList()[0].visible(true);
					}
				} else {
					item.visible(false);
				}
			});
			viewModel.catlgId(obj.catlgId());
			
		};
		self.joinStoreNo = function(obj,event) {
			var ret = '';
			$.each(self.storeOrderInfoList(),function(index,item){
				ret = ret + ',' + item.storeNo();
			});
			return ret;
		};
		//选择下传区域
		self.chooseDownLoadArea = function(obj, event) {
			
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages();
				return;
			}
			viewModel.catlgId(self.catlgId());
			viewModel.tmpVal('');
			if(viewModel.action()=='update'){
				$.ajax({
					type : "post",
					async : false,
					url : ctx + "/supplier/getSupplierSectionStoreByCatlgId",
					dataType : "json",
					data : {
						'supNo' : viewModel.supNo(),
						'catlgId': self.catlgId()
					},
					success : function(data) {
						viewModel.tmpVal(joinObject(data,'storeNo',','));
					}
				});	
			}
			viewModel.tmpVal(viewModel.tmpVal()+','+self.joinStoreNo());
			openPopupWin(651, 642, '/supplierAudit/chooseDownLoadArea?taskId='+viewModel.taskId()+'&from='+viewModel.from()+'&supNo='+viewModel.supNo()+'&catlgId='+self.catlgId());
		};
	},
	ViewModel : function(supNo,taskId,comNo, action,from) {
		
		var self = this;
		//存储临时变量
		self.tmpVal = ko.observable();
		//公司编号
		self.comNo = ko.observable(comNo);
		//任务编号
		self.taskId = ko.observable(taskId);
		//厂商编号
		self.supNo = ko.observable(supNo);
		//动作(create:创建,update:修改)
		self.action = ko.observable(action);
		//来源
		self.from = ko.observable(from);
		//当前选中的课别
		self.catlgId = ko.observable('');
		self.storeNo = ko.observable('');
		//课信息
		self.cataInfoList = ko.observableArray([]);
		//初始化选中课别信息
		self.initCataInfoList = function(form, event) {
			
			$.ajax({
				type : "post",
				async : false,
				url : ctx + "/supplierAudit/getSupplierSectionCatalogByTaskId",
				dataType : "json",
				data : {
					'taskId' : self.taskId()
				},
				success : function(data) {
					
					$.each(data,function(index,item){
						var storeList = [];
						$.each(item.storeList,function(index,st){
							 var storeNameArea=getExistLoadArea(st.storeNo,st.storeName);
							storeList.push(new supplierCreateStoreSecInfo.StoreOrderInfo(st.grpId,
									st.storeNo,
									st.storeName,
									st.status,
									st.minOrdAmt,
									st.rtnAllow,
									st.leadTime,
									st.oplSched,
									st.dlvrySched,
									st.supRtnAddr,
									st.supOrdAddr,
									false,
									storeNameArea
								));
						});
						viewModel.cataInfoList.push(new supplierCreateStoreSecInfo.CataInfo(item.catlgId,item.catlgName,
								item.ordScope==undefined?"":item.ordScope,item.buyrMemo==undefined?"":item.buyrMemo,item.newStDiscDays,storeList,false));
					});
				}
			});
			
			if(viewModel.action()=='update'){
				//修改的时候，列出原来的课别信息
				var currentCatlgList = null;
				$.ajax({
					type : "post",
					async : false,
					url : ctx + "/supplier/getSupplierSectionCatalogBySupNo",
					dataType : "json",
					data : {
						'supNo' : self.supNo()
					},
					success : function(data) {
						currentCatlgList = data;
					}
				});
				
				$.each(currentCatlgList,function(index,current){
					var exists = false;//判断是否已经存在
					$.each(viewModel.cataInfoList(),function(index,target){
						if(current.catlgId==target.catlgId()){
							exists = true;
							return false;
						}
					});
					if(!exists){
						viewModel.cataInfoList.push(new supplierCreateStoreSecInfo.CataInfo(current.catlgId,current.catlgName,
								'','','',[],false));
					}
				});
				
			}
			
			viewModel.cataInfoList(viewModel.cataInfoList());
			
		};
		self.save = function(doSubmit) {
			viewModel.tmpVal('');
			// 验证表单
			viewModel.errors = ko.validation.group(viewModel);
			if (!viewModel.isValid()) {
				viewModel.errors.showAllMessages();
				return;
			}
			if(viewModel.action()=='create' && self.cataInfoList().length==0){
				top.jAlert('warning', '请至少选择一个课别','提示消息');
				return;
			}
			var passValidate = true;
			$.each(self.cataInfoList(),function(index,item){
				if(viewModel.action()=='create' && item.storeOrderInfoList().length==0){
					top.jAlert('warning', item.catlgId()+'-'+item.catlgName()+'请至少选择一个下传区域','提示消息');
					passValidate = false;
					return false;
				}
			});
			if(!passValidate){
				return;
			}
			// 提交表单
			$.ajax({
				type : "post",
				async : false,
				url : ctx + "/supplierAudit/doCreateSupStoreSecInfo",
				dataType : "json",
				data : {
					'jsonStr' : ko.toJSON(viewModel),
					'action' : self.action(),
					'supNo' : self.supNo(),
					'doSubmit' : doSubmit
				},
				success : function(data) {
					if (data.status == 'success') {								
						viewModel.taskId(data.taskId);
					 if(doSubmit=='submit' && self.action() == 'create'){
							top.jConfirm('信息提交成功，您需要打印提交的信息吗','提示消息',function(ret){
									if(ret){
							top.jAlert('success', '<a href='+ctx + '/supplierAudit/downLoadPaymentPdf?taskId='+data.taskId+'><u>财务信息打印</u></a>\n'
										+'<a href='+ctx + '/supplierAudit/downLoadSupplierPdf?taskId='+data.taskId+'><u>厂商信息打印</u></a>','提示消息',function(ret){
											showContent(ctx + '/supplierAudit/createSupplier?action=create');
							     });
							 }
							});
						}
					 else{
						 top.jAlert('success','操作成功','提示消息');						
						 }
					} else {
						top.jAlert('warning', data.message,'提示消息');
					}
				}
			});
		};
	}
};
var supplierCreateStoreSecInfo = Supplier.createStoreSecInfo;

//根据storeNo和storeName生成已保存过的下传区域
function getExistLoadArea(storeNo,storeName){
	var array1 = storeNo.split(',');
	var array2 = storeName.split(',');
	var output="";
	output = output + "<div class=\"list_ex21\" >"; 
	$.each(array2, function(index, value){
		output = output + "<div id=\"oneStore\">" + value+ "<input"+ 
		" type=\"hidden\" name=\"oneStoreNo\" value=\""+array1[index]+"\"/>"+
		"<input type=\"hidden\" name=\"oneStoreName\" value=\""+value+"\"/>"+
		"</div>";
	});	
	output = output + "</div>";
	return output;
}