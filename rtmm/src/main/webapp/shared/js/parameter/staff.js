var tmpVar = null;
/*construct the structure of jobFun including
 *  base jobFun and other jobFun every staff
 **/
var JobFun = function(jobId, storeNo, deptId, remark, vaildFrom, vaildUntil,deptName, jobName,flag) {
	var self = this;
	self.flag = ko.observable(flag);
	self.jobId = ko.observable(jobId);
	self.storeNo = ko.observable(storeNo).extend({
		required : {
			params : true,
			message : "请设置店号"
		}
	});
	self.deptId = ko.observable(deptId);
	self.deptName = ko.observable(deptName).extend({
		required : {
			params : true,
			message : "请设置部门"
		}    
	});
	self.jobName = ko.observable(jobName).extend({
		required : {
			params : true,
			message : "请设置职位"
		},
	   valiJobFunIfExists : self
	});
	self.remark = ko.observable(remark);
	self.vaildFrom = ko.observable(vaildFrom).extend({
		required : {
			message : "请设置生效日期",
			onlyIf : function() {
				return self.flag() != 'main';
			}
		}
	});
	self.vaildUntil = ko.observable(vaildUntil).extend({
		required : {
			message : "请设置失效日期",
			onlyIf : function() {
				return self.flag() != 'main';
			}
		},
       dateCompare : self
	});
	self.chooseDept = function(obj, event) {
		if (obj.storeNo() != '') {
			tmpVar = $(event.currentTarget);
			top.window.$.zWindow.open({
				width : 450,
				height : 500,
				title : '选择部门',
				windowSrc : ctx+ '/param/chooseDept?storeId=' + obj.storeNo(),
				afterClose : function(data) {
					if (data != undefined){
						confirmChooseDeptWin(data.deptId, data.deptName);
					}
				}
			});
			afterOpenZwindow();
		} else {
			top.jAlert('warning', '请先选择门店', '消息提示');
		}
	};
	self.chooseJobFun = function(obj, event) {
		if (obj.deptId() != '') {
			tmpVar = $(event.currentTarget);
			top.window.$.zWindow.open({
				width : 450,
				height : 500,
				title : '选择职位',
				windowSrc : ctx+ '/param/chooseJobFun?deptId=' + obj.deptId(),
				afterClose : function(data) {
					if (data != undefined){
						confirmChooseJonFunWin(data.jobFuncId, data.jobFuncName);
					}
				}
			});
			afterOpenZwindow();
			
	} else {
			top.jAlert('warning', '请先选择部门', '消息提示');
		}
	};
	self.clearMainDeptJob=function(){
		self.deptName("");
		self.jobName("");
	};
	self.clearMainJob=function(){
		self.jobName("");
	};
	self.clearExtAfterStoreMsg=function(){
		self.deptName("");
		self.jobName("");
		self.vaildFrom("");
		self.vaildUntil("");
	};
	self.clearExtAfterDeptMsg=function(){
		self.jobName("");
		self.vaildFrom("");
		self.vaildUntil("");
	};
	self.clearExtAfterJobMsg=function(){
		self.vaildFrom("");
		self.vaildUntil("");
	};
};

//checking a staff coundn't have two same jobFuns. 
ko.validation.rules['valiJobFunIfExists'] = {
		validator : function(val, self) {
			var isValid=true;
			if(self.flag() == 'main'){
				return true;
			}
			if(viewModel.mainJobFunList().length==0||viewModel.extJobFunList()==0){			
				return true;
			}
			var mainDeptId=viewModel.mainJobFunList()[0].deptId();
			var mainStoreNo=viewModel.mainJobFunList()[0].storeNo();
			var mainJobId=viewModel.mainJobFunList()[0].jobId();	          
			var storeNo=self.storeNo();
			var jobId=self.jobId();
			var deptId=self.deptId();			
			var index=0;		
			if(storeNo==mainStoreNo&&deptId==mainDeptId&&jobId==mainJobId){
				index++;
			}
			$.each(viewModel.extJobFunList(),function(i,val){
				if(val.storeNo()==storeNo&&val.jobId()==jobId&&val.deptId()==deptId){
					index++;
				}
			});
			if(index>=2){
				isValid=false;
			}
			return isValid;
		},
		message : '不能新增相同的职位'
	};

//validate the end date must be bigger than the start date
ko.validation.rules['dateCompare'] = {
	validator : function(val, self) {
		if(self.flag() == 'main'){
			return true;
		}
		return (val>self.vaildFrom());
	},

	message : "失效日期必须大于生效日期"
};

//validate the length of user in the chinese RT and the TaiWan RT according by the prefix.
ko.validation.rules['RLengthValidate'] = {
		validator : function(val,self){
			var isValid=true;
			if(self.userNamePrefix()=='R'){
				if(self.userName().length!=11){
					isValid= false;
				}
			}
			return isValid;
		},
		message : '用户名必须为11位'
};

//validate the length of user in the chinese RT and the TaiWan RT according by the prefix.
ko.validation.rules['TLengthValidate'] = {
		validator : function(val,self){
			var isValid=true;
			if(self.userNamePrefix()=='T'){
				if(self.userName().length!=7){
					isValid= false;
				}
			}
			return isValid;
		},
		message : '用户名必须为7位'
};

//validate the length of user in the auchan and the others and according by the prefix.
ko.validation.rules['EVLengthValidate'] = {
		validator : function(val,self){
			var isValid=true;
			if(self.userNamePrefix()=='E'||self.userNamePrefix()=='V'){
				if(self.userName().length!=8){
					isValid= false;
				}
			}
	      return isValid;
		},
		message : '用户名必须为8位'
};

// 验证用户名前缀
ko.validation.rules['userNamePrefixValidate'] = {
	validator : function(val, self) {
		return !(self.userNamePrefix() == '');
	},
	message : '请选择用户前缀'
};

// 验证用户名唯一
ko.validation.rules['userNameUnique'] = {
	validator : function(val, param) {
		var isValid = true;
		if (param.id() != '') {
			// 修改的时候不验证
			return isValid;
		}
		$.ajax({
			async : false,
			url : ctx + '/param/userNameUnique',
			type : 'POST',
			data : {
				userName : param.userNamePrefix() + param.userName(),
				id : param.id()
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
	message : '该用户已经存在'
};
ko.validation.registerExtenders();

/*construct the structure of staff message*/
function ViewModel() {
	var self = this;
	self.id = ko.observable('');
	self.userNamePrefix = ko.observable('');
	self.userName = ko.observable('').extend({
		required : {
			params : true,
			message : "请输入用户名"
		},
		TLengthValidate : self,
		RLengthValidate : self,
		EVLengthValidate : self,
		userNamePrefixValidate : self,
		userNameUnique : self
	});
	self.fullName = ko.observable('').extend({
		required : {
			params : true,
			message : "请设置姓名"
		}
	});
	self.englishName = ko.observable('');
	self.email=ko.observable('').extend({
		email : {
			params : true,
			message : "请设置一个有效的Email"
		}
	});
	self.initial = ko.observable('');
	self.status = ko.observable('').extend({
		required : {
			params : true,
			message : "请设置用户状态"
		}
	});
	self.showValidate = function() {
		if(self.userNamePrefix()=='V'){
			return true;
		}else{
			return false;
		}
	};
	self.validDate = ko.observable('').extend({
		required : {
			message : "请设置有效期",
			onlyIf : function() {
				return self.showValidate();
			}
		}
	});
	self.isEdit = function() {
		if (self.id() == '' || self.id() == undefined ) {
			return false;
		}
		else{
			return true;
		}
	};
	self.mainJobFunList = ko.observableArray([]);
	self.extJobFunList = ko.observableArray([]);
	self.addJobFun = function(o, event) {
		o.extJobFunList.push(new JobFun("", "", "", "", "", "", "", "","ext"));
	};
	self.removeJobFun = function(obj) {
		self.extJobFunList.remove(obj);
	};
	self.listUserJobFun = function() {
	};
	self.userNameBlur = function() {
		var str = '';
		var userName = self.userName();
		if (userName.length >= 6) {
			str = self.userName().substring(userName.length - 6,
					userName.length);
		} else {
			str = self.userName();
		}
		self.initial(str);
	};
   /*save the staff message*/
	self.save = function(form, event) {
		
		// 验证表单
		viewModel.errors = ko.validation.group(viewModel);
		if (!viewModel.isValid()) {
			viewModel.errors.showAllMessages(true);
			return;
		}
		// 提交表单
		$.post( ctx + "/param/doSaveStaff",{
			'staffId' : viewModel.id(),
			'userName' : viewModel.userName(),
			'userNamePrefix' : viewModel.userNamePrefix(),
			'fullName' : viewModel.fullName(),
			'nameEn' : viewModel.englishName(),
			'email' : viewModel.email(),
			'status' : viewModel.status(),
			'validDate' : viewModel.validDate(),
			'mainJobFunList' : ko.toJSON(self.mainJobFunList()),
			'extJobFunList' : ko.toJSON(self.extJobFunList())
		},function(data) {
			if (data.status=='success') {
				top.jAlert('success',data.message, '消息提示');
			}else if (data.status=='warn')  {
				top.jAlert('warning', data.message, '消息提示');
			}else {
				top.jAlert('error', data.message, '消息提示');
			}
			top.grid_layer_close();
			top.window.$.zWindow.close();
		},'json');
	};
}

function confirmChooseDeptWin(chooseId, chooseText) {
	if(chooseId==''){
		top.jAlert('warning', '请选择门店', '消息提示');
		return false;
	}
	$($(tmpVar).find('input')[0]).attr('value', chooseId).trigger('change');
	$($(tmpVar).find('input')[1]).attr('value', chooseText).trigger('change');
}

function confirmChooseJonFunWin(chooseId, chooseText) {

	if (chooseId == ''){
		top.jAlert('warning', '请选择职位', '消息提示');
		return false;
	}
	$($(tmpVar).find('input')[0]).attr('value', chooseId).trigger('change');
	$($(tmpVar).find('input')[1]).attr('value', chooseText).trigger('change');
}

function cancel() {
	top.window.$.zWindow.close();
}

/*edit the existed staff message.*/
function buildStaffPage(staffId) {
	if (staffId != '') {
		$.ajax({
			//async : false,
			url : ctx + '/param/getStaffInfo',
			type : 'POST',
			data : {
				'staffId' : staffId
			},
			success : function(data) {
				
				viewModel.id(data.staff.staffId);
				if (data.staff.staffNo) {
					viewModel.userNamePrefix(data.staff.staffNo.substr(0, 1));
					viewModel.userName(data.staff.staffNo.substr(1));
				}
				if(data.staff.nameEn==null||data.staff.nameEn==undefined){
				viewModel.englishName('');
				}
				else{
					viewModel.englishName(data.staff.nameEn);
				}
				viewModel.fullName(data.staff.name);
				viewModel.initial(data.staff.initial);
				viewModel.status(data.staff.status);
				if(data.staff.email==null||data.staff.email==undefined){
					viewModel.email('');
					}
					else{
					viewModel.email(data.staff.email);
					}
				
				if (data.staff.validDate) {
					viewModel.validDate(new Date(data.staff.validDate)
							.format('yyyy-MM-dd'));
				}
				$.each(data.jfList, function(index, value) {
					var vaildFrom = '';
					var vaildUntil = '';
					if (null != value.vaildFrom) {
						vaildFrom = new Date(value.vaildFrom)
								.format('yyyy-MM-dd');
					}
					if (null != value.vaildUntil) {
						vaildUntil = new Date(value.vaildUntil)
								.format('yyyy-MM-dd');
					}
					var flag = null;
					if(index == 0 ){
						flag = "main";
					}else{
						flag = "ext";
					}
					var jobFun = new JobFun(value.id, value.storeNo,value.deptId, '', vaildFrom, vaildUntil,value.deptName, value.jobFunctionName,flag);
					if (index == 0) {
						viewModel.mainJobFunList.push(jobFun);
					} else {
						viewModel.extJobFunList.push(jobFun);
					}
				});
				if (viewModel.mainJobFunList().length == 0) {
					viewModel.mainJobFunList.push(new JobFun("", "", "", "", "", "", "", "",'main'));
				}
			}
		});
	}else if (viewModel.mainJobFunList().length == 0) {
		viewModel.mainJobFunList.push(new JobFun("", "", "", "", "", "", "", "",'main'));
	}
}

// 瀏覽用戶詳細訊息
function viewStaff(staffId){
	top.window.$.zWindow.open({
		width : 1031,
		height : 490,
		title : '浏览用户',
		windowSrc : ctx+'/param/staffForm?staffId=' + staffId + '&action=view' ,
		afterClose : function(data) {
		}
	});
}


// 创建用户
function createStaff() {
	top.window.$.zWindow.open({
		width : 1031,
		height : 490,
		title : '创建新用户',
		windowSrc : ctx+'/param/staffForm',
		afterClose : function(data) {
		}
	});
}

// 编辑
function editStaff(staffId) {
	if (staffId=='' || staffId==null) {
		top.jAlert('warning', '请选择一条进行编辑', '消息提示');
		return;
	}	
	top.window.$.zWindow.open({
		width : 1031,
		height : 490,
		title : '编辑用户',
		windowSrc : ctx+'/param/staffForm?staffId='+ staffId,
		afterClose : function(data) {
		}
	});
}

//加载部门树
function initDeptTree(storeId) {
	if (storeId != '') {
		$('#deptTree').find('li').remove();// 先删除树
		$.post(ctx + "/param/loadDeptTreeData", {
			'storeId' : storeId
		}, function(data) {
			$('#deptTree').tree({
				checkbox : false,
				data : data,
				onClick : function(node) {
					
					$('#storeNo').attr('value',storeId);
					$('#deptNo').attr('value',node.id);
					pageQuery();
				}
			});
		}, "json");
	} else {
		$('#deptTree').find('li').remove();
	}
}

//用户分页查询
function pageQuery() {
	if($('#deptNo').val()==""||$('#deptNo').val()==undefined){
		top.jAlert('warning', '请先选择部门', '消息提示');
		return false;
	}
	$.ajax({
		type : "post",
		data : {
			pageNo : $('#pageNo').val(),
			pageSize : $('#pageSize').val(),
			storeNo : $('#storeNo').val(),
			deptNo : $('#deptNo').val(),
			userName : ($('#userName').val()=='请输入姓名进行查询'?"":$('#userName').val()),
			showAll : $('#showAll').attr("checked") == 'checked' ? true: false,
			showValid : $('#showValid').attr("checked") == 'checked' ? true: false
		},
		dataType : "html",
		url : ctx + '/param/userListPage',
		success : function(data) {
			$('#user_content').html(data);
		}
	});
}

/*edit the staff message if you dbclick the staff in the staffList.*/
function onDblClickStaffRow(staffId){
	viewStaff(staffId);
}

/*light the edit button if you dbclick the staff in the staffList.*/
function onClickStaffRow(staffId){	
	$("#Tools12").removeClass("Tools12_disable").addClass("Tools12").unbind("click").bind("click",function(){
		editStaff(staffId);
	});
}

/*if you want to open the second zWindow,you need 
 * change the z-index attribute of the last zWindow.
 * */
function afterOpenZwindow(){
	$(top.document).find(".zwindow_bg:last").css({"z-index":"8010"});
	$(top.document).find(".zwindow_pannel:last").css({"z-index":"8012"});
	
}