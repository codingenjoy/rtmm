$('#date_div').calendar({
    current: new Date()
});
function Record(){
	this.comGrpNo = null;
	this.comGrpName = null;
	this.comGrpEnName = null;
	this.selectedIndex = null;
}
//验证税号唯一
ko.validation.rules['licnceNoUnique'] = {
	validator : function(val, rec) {
		var isValid = true;
		if(viewModel.action() == 'update'){
			isValid = true;
		}else{
			$.ajax({
				async : false,
				url : ctx + '/supplier/company/licnceNoUnique',
				type : 'POST',
				data : {
					licnceNo : rec.licnceNo
				},
				success : function(response) {
					isValid = response;
				},
				error : function() {
					isValid = false; // however you would like to handle this
				}
			});
		}
		return isValid;
	},
	message : '证件号已经存在'
};
ko.validation.registerExtenders();

var LicFun = function(licnceId,licnceType,licnceNo,validEndDate,validStartDate,issueBy) {
	var self = this;
	self.isChecked = ko.observable(false);
	self.isChecked.subscribe(function() {
		if(self.isChecked()){
			var checkNum =$("input[name='licChecked']:checked").length;
			var totalNum =$("input[name='licChecked']").length;
			if(checkNum == totalNum){
				$("#allCheck").attr("checked", true);
			}else{
				$("#allCheck").attr("checked", false);
			}
		}else{
			$("#allCheck").attr("checked", false);
		}
	});
	//给当前图片层设定Id
	self.id=new Date().getTime();
	self.mouseOver = function(){
		
		//$(self).html("<img src='${ctx}' />");
		
		//alert('44'+self.licnceId());
	};
	
	self.click= function(){
		//新增图片集合点击事件
		createNewPhotoList(self.id);
	};

	
	
	self.licnceId = ko.observable(licnceId);
	self.licnceType = ko.observable(licnceType).extend({
		required : { params : true, message : "请设置证件类型"}
	});
	self.licnceNo = ko.observable(licnceNo).extend({
		required : { params : true, message : "请设置证件号"},
		maxLength: { params: 20, message: "证件号最大长度为20个字符"},
		licnceNoUnique : self//税号唯一验证
	});
	self.validStartDate = ko.observable(validStartDate).extend({
		required : { params : true, message : "请设置起始日期"}
	});
	self.validEndDate = ko.observable(validEndDate).extend({
		required : { params : true, message : "请设置截止日期"},
		dateCompare : {params : self.validStartDate, message : "截止日期必须大于起始日期"}
	});
	self.issueBy = ko.observable(issueBy).extend({
		required : { params : true, message : "请设置发证机关"},
		maxLength: { params: 40, message: "发证机关最大长度为40个字符"}
	});
};
//验证税号唯一
ko.validation.rules['unifmNoUnique'] = {
	validator : function(val, rec) {
		var isValid = true;
		if(rec.action() == 'update'){
			isValid = true;
		}else{
			$.ajax({
				async : false,
				url : ctx + '/supplier/company/unifmNoUnique',
				type : 'POST',
				data : {
					unifmNo : rec.unifmNo
				},
				success : function(response) {
					isValid = response;
				},
				error : function() {
					isValid = false; // however you would like to handle this
				}
			});
		}
		return isValid;
	},
	message : '该税号已经存在'
};
ko.validation.registerExtenders();
function ViewModel(action,comNo) {
	var self = this;
	self.action = ko.observable(action);
	self.comNo = ko.observable(comNo);
	self.status = ko.observable('');
	self.unifmNo = ko.observable('').extend({
		required : { params : true, message : "请设置税号"},
		maxLength: { params: 25, message: "公司编号最大长度为25个字符"},
		unifmNoUnique : self//税号唯一验证
	});
	self.comName = ko.observable('').extend({
		required : { params : true, message : "请设置公司名称"},
		maxLength: { params: 40, message: "公司名称的最大长度为40个字符"}
	});
	self.comEnName = ko.observable('').extend({
		maxLength: { params: 40, message: "公司英文名最大长度为40个字符"}
	});
	self.comgrpNo = ko.observable('') .extend({
		//maxLength: { params: 6, message: "集团编号最大长度为6个字符"},
		number : {
			params : true,
			message : "请输入数字"
		}
	});
	self.comgrpName = ko.observable('');
	self.econType = ko.observable('').extend({
		required : { params : true, message : "请设置公司类型"}
	});
	self.legalRpstv = ko.observable('').extend({
		required : { params : true, message : "请设置法人代表"},
		maxLength: { params: 20, message: "法人代表最大长度为20个字符"}
	});
	self.bizScopeDesc = ko.observable('').extend(
	{
		required : { params : true, message : "请设置经营范围"},
		maxLength: { params: 100, message: "经营范围最大长度为100个字符"}
	});
	self.setupDate = ko.observable('').extend({
		required : { params : true, message : "请设置成立日期"
		}
	});
	//注册地址信息
	self.regProvName = ko.observable('').extend({
		required : { params : true, message : "请设置注册省份"},
		maxLength: { params: 20, message: "注册省份最大长度为20个字符"}
	});
	self.regCityName = ko.observable('').extend({
		required : { params : true, message : "请设置注册城市"},
		maxLength: { params: 20, message: "注册城市最大长度为20个字符"}
	});
	self.regDetllAddr = ko.observable('').extend({
		required : { params : true, message : "请设置注册地址"},
		maxLength: { params: 60, message: "注册地址最大长度为60个字符"}
	});
	self.regAreaCode = ko.observable('').extend({
		maxLength: { params: 4, message: "电话区号最大长度为4个字符"},
		required : { params : true, message : "请设置电话区号"},
		number : {
			params : true,
			message : "请输入数字"
		}
	});
	self.regPhoneNo = ko.observable('').extend({
		xLength: { params: 20, message: "电话号码最大长度为20个字符"},
		required : { params : true, message : "请设置电话号码"},
		number : {
			params : true,
			message : "请输入数字"
		}
	});
	self.regEmailAddr = ko.observable('').extend({
		maxLength: { params: 30, message: "电子邮箱最大长度为30个字符"},
		email : {
			params : true,
			message : "Email格式不正确"
		}
	});
	self.webSite = ko.observable('').extend({
		required : { params : true, message : "请设置网址"},
		maxLength: { params: 30, message: "网址最大长度为30个字符"},
		webSite:{params : true,message:"无效网址,请重新输入"}
	});
	//发票地址
	self.dlvProvName = ko.observable('').extend({
		required : { params : true, message : "请设置发票送达省份"},
		maxLength: { params: 20, message: "发票送达省份最大长度为20个字符"}
	});
	self.dlvCityName = ko.observable('').extend({
		required : { params : true, message : "请设置发票送达城市"},
		maxLength: { params: 20, message: "发票送达城市最大长度为20个字符"}
	});
	self.dlvDetllAddr = ko.observable('').extend({
		required : { params : true, message : "请设置发票送达地址"},
		maxLength: { params: 60, message: "发票送达地址最大长度为60个字符"}
	});
	self.dlvPostCode = ko.observable('').extend({
		maxLength: { params: 6, message: "邮政编码最大长度为6个字符"},
		number : {
			params : true,
			message : "请输入数字"
		}
	});
	self.dlvCntctName = ko.observable('').extend({
		maxLength: { params: 30, message: "联系人最大长度为30个字符"}
	});
	//self.dlvFaxAreaCode = ko.observable('${supCompany.invDlvryAddress.provName}');
	self.dlvFaxNo = ko.observable('').extend({
		maxLength: { params: 20, message: "传真最大长度为20个字符"},
		number : {
			params : true,
			message : "请输入数字"
		}
	});
	self.dlvAreaCode = ko.observable('').extend({
		maxLength: { params: 4, message: "电话区号最大长度为4个字符"},
		number : {
			params : true,
			message : "请输入数字"
		}
	});
	self.dlvMoblNo = ko.observable('').extend({
		maxLength: { params: 20, message: "电话号码最大长度为20个字符"},
		number : {
			params : true,
			message : "请输入数字"
		}
	});
	self.dlvPhoneNo = ko.observable('').extend({
		maxLength: { params: 20, message: "手机最大长度为20个字符"},
		number : {
			params : true,
			message : "请输入数字"
		}
	});
	self.dlvEmailAddr = ko.observable('').extend({
		maxLength: { params: 30, message: "电子邮箱最大长度为30个字符"},
		email : {
			params : true,
			message : "Email格式不正确"
		}
	});
	//额外信息
	self.lawNote = ko.observable('').extend({
		maxLength: { params: 100, message: "法务注记最大长度为100个字符"}
	});
	self.debtNote = ko.observable('').extend({
		maxLength: { params: 100, message: "呆账催收注记最大长度为100个字符"}
	});
	self.credtNote = ko.observable('').extend({
		maxLength: { params: 100, message: "信用状况注记最大长度为100个字符"}
	});
	self.chngBy = ko.observable('');
	self.chngDate = ko.observable(new Date().format("yyyy-MM-dd"));
	self.creatBy = ko.observable('');
	self.creatDate = ko.observable(new Date().format("yyyy-MM-dd"));
	//公司证件
	self.allChecked = ko.observable(false);
	self.allChecked.subscribe(function() {
		if(self.allChecked()){
			if(self.comLicencesList()){
				$.each(self.comLicencesList(),function(index,item){
					item.isChecked(true);
				});
			}
		}else{
			if(self.comLicencesList()){
				$.each(self.comLicencesList(),function(index,item){
					item.isChecked(false);
				});
			}
		}
	});
	self.comLicencesList = ko.observableArray([]);
	self.addLicFun = function(o, event) {
		o.comLicencesList.push(new LicFun("","","","","",""));
		o.comLicencesList(o.comLicencesList());
		$("#allCheck").attr("checked", false);
	};
	self.removeLicFun = function(obj) {
		if(self.allChecked()){
			self.comLicencesList().splice(0,self.comLicencesList().length);
			self.allChecked(false);
			self.comLicencesList(self.comLicencesList());
		}else{
			var start = self.comLicencesList().length-1;
			for (var i=start;i<start+1;i--)
			{
				if(i < 0){
					return;
				}
				if(!self.comLicencesList()[i]){
					return;
				}
				if(self.comLicencesList()[i].isChecked()){
					self.comLicencesList().splice(i,1);
				}
				self.comLicencesList(self.comLicencesList());
			}
		}
		
	};
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
			url : ctx + "/supplier/company/saveSupCompany",
			dataType : "json",
			data : {
				'action' : viewModel.action(),
				'comNo' : viewModel.comNo(),
				'unifmNo' : viewModel.unifmNo(),
				'status' : viewModel.status(),
				'comName' : viewModel.comName(),
				'comEnName' : viewModel.comEnName(),
				'comGrpVO.comgrpNo' : viewModel.comgrpNo(),
				'econType' : viewModel.econType(),
				'legalRpstv' : viewModel.legalRpstv(),
				'bizScopeDesc' : viewModel.bizScopeDesc(),
				'setupDate' : viewModel.setupDate(),
				'comRegstrAddress.provName' : viewModel.regProvName(),
				'comRegstrAddress.cityName' : viewModel.regCityName(),
				'comRegstrAddress.detllAddr' : viewModel.regDetllAddr(),
				'comRegstrAddress.areaCode' : viewModel.regAreaCode(),
				'comRegstrAddress.phoneNo' : viewModel.regPhoneNo(),
				'comRegstrAddress.emailAddr' : viewModel.regEmailAddr(),
				'webSite' : viewModel.webSite(),
				'invDlvryAddress.provName' : viewModel.dlvProvName(),
				'invDlvryAddress.cityName' : viewModel.dlvCityName(),
				'invDlvryAddress.detllAddr' : viewModel.dlvDetllAddr(),
				'invDlvryAddress.postCode' : viewModel.dlvPostCode(),
				'invDlvryAddress.cntctName' : viewModel.dlvCntctName(),
				//'invDlvryAddress.areaCode' : viewModel.dlvFaxAreaCode,
				'invDlvryAddress.faxNo' : viewModel.dlvFaxNo(),
				'invDlvryAddress.areaCode' : viewModel.dlvAreaCode(),
				'invDlvryAddress.moblNo' : viewModel.dlvMoblNo(),
				'invDlvryAddress.phoneNo' : viewModel.dlvPhoneNo(),
				'invDlvryAddress.emailAddr' : viewModel.dlvEmailAddr(),
				'lawNote' : viewModel.lawNote(),
				'debtNote' : viewModel.debtNote(),
				'credtNote' : viewModel.credtNote(),
				'comLicencesList' : ko.toJSON(self.comLicencesList()),
				'chngBy' : viewModel.chngBy(),
				'chngDate' : viewModel.chngDate(),
				'creatBy' : viewModel.creatBy(),
				'creatDate' : viewModel.creatDate(),
				'imagesInfos':imgsListInfos
			},
			success : function(data) {
				if (data) {
					if(viewModel.action() && viewModel.action() == "add"){
						/*top.jAlert('success', '操作成功!<a href='+ctx+'/supplier/generalSearch">新增厂商</a>', '提示消息');
						createSupCompany();*/
						jConfirm("是否新增厂商","操作成功",function(data){
							if(data){
								goCreateSupplier(viewModel.comNo());
								$('#13').removeClass('Sub Sub_on').addClass('Sub');
								$('#35').removeClass('Sub').addClass('Sub Sub_on');
							}else{
								createSupCompany();
							}
						});
					}else{
						top.jAlert('success', '操作成功', '提示消息');
					}
					
				} else {
					top.jAlert('error', '操作失败', '提示消息');
				}
			}
		});
	};

}
//订货退货地址
function comOtherAddrManagement(){
    $("#first").addClass("tags1_left");
    $("#supComMess").addClass("tagsM");
    $("#midden").addClass("tags  tags_right_on");
    $("#comOthAddrMess").addClass("tagsM  tagsM_on");
    $("#last").addClass("tags tags3_r_on");
	showContent(ctx+'/supplier/company/comOtherAddrManagement?comNo=');
}
//公司查询
function supCompanySearch(){
	var comgrpNoSearch =$("#comgrpNoSearch").val();
	var comNoSearch =$("#comNoSearch").val();
	var comNameSearch =$("#comNameSearch").val();
	var comEnNameSearch =$("#comEnNameSearch").val();
	var econTypeSearch =$("#econTypeSearch").val();
	var unifmNoSearch =$("#unifmNoSearch").val();
	var cityNameSearch =$("#cityNameSearch").val();
	var creatDateSearch =$("#creatDateSearch").val();
	$('#dg').datagrid(
			{
				striped:true,
				rownumbers : false,
				singleSelect : true,
				pagination : true,
				pageSize : 20,
				url : ctx + '/supplier/company/companyList',
				queryParams : {
					'comgrpNo':comgrpNoSearch,
					'comNo':comNoSearch,
					'comName':comNameSearch,
					'comEnName':comEnNameSearch,
					'econType':econTypeSearch,
					'unifmNo':unifmNoSearch,
					'cityName':cityNameSearch,
					'creatDate':creatDateSearch
				},
				columns : [ [
						{
							field : 'ck',
							checkbox : false,
							halign : 'center',
							width : 9
						},
						{
							field : 'comNo',
							title : '公司编号',
							sortable : true,
							halign : 'center',
							align : 'right',
							formatter : function(val, rec) {
								return rec.comNo+"&nbsp;&nbsp;";
							},
							width : 53
						},
						{
							field : 'comName',
							title : '公司名称',
							halign : 'center',
							align : 'left',
							width : 215
						},
						{
							field : 'comEnName',
							title : '公司英文名称',
							halign : 'center',
							align : 'left',
							width : 213
						},
						{
							field : 'comgrpNo',
							title : '集团编号',
							sortable : true,
							halign : 'center',
							align : 'right',
							formatter : function(val, rec) {
								if(rec.comGrpVO.comgrpNo){
									return rec.comGrpVO.comgrpNo+"&nbsp;&nbsp;";
								}
							},
							width : 61
						},
						{
							field : 'comgrpName',
							title : '集团',
							halign : 'center',
							align : 'left',
							formatter : function(val, rec) {
								if(rec.comGrpVO.comgrpName){
									return rec.comGrpVO.comgrpName;
								}
							},
							width : 85
						},
						{
							field : 'econType',
							title : '公司类型',
							halign : 'center',
							align : 'left',
							formatter : function(val, rec) {
								return getDictValue('COMPANY_ECON_TYPE',rec.econType);
							},
							width : 100
						},
						{
							field : 'unifmNo',
							title : '税号',
							halign : 'center',
							align : 'left',
							width : 137
						},
						{
							field : 'regCityName',
							title : '注册城市',
							halign : 'center',
							align : 'left',
							formatter : function(val, rec) {
								return rec.comRegstrAddress.cityName;
							},
							width : 65
						},
						{
							field : 'setupDate',
							title : '创建日期',
							halign : 'center',
							align : 'left',
							formatter : function(val, rec) {
								return new Date(val).format('yyyy-MM-dd');
							},
							width : 100
						},
						{
							field : "temp",
							title : ' ',
							halign : 'center',
							width : 18
						}
						] ],
						onLoadSuccess : function(){
							setBorderRig('.Content');
/*							$("#Tools22").attr('class', "Icon-size1 Tools22");
							$("#Tools21").attr('class', "Icon-size1 Tools21_on");
							
							$($("#Tools22").parent()).removeClass("ToolsBg");
							$($("#Tools21").parent()).addClass("ToolsBg");*/
						},		
						onDblClickRow : function (rowIndex,rowData){
							$("#Tools22").attr('class', "Icon-size1 Tools22_on");
							$("#Tools21").attr('class', "Icon-size1 Tools21");
							
							$($("#Tools22").parent()).addClass("ToolsBg");
							$($("#Tools21").parent()).removeClass("ToolsBg");
							supCompanyDetailed();
						},
			            onClickRow : function(rowIndex, rowData) {
							$("#Tools22").attr('class', "Icon-size1 Tools22");
							if ($("#Tools21").parent().attr('class').indexOf('ToolsBg') > 0) {
								$("#Tools21").attr('class', "Icon-size1 Tools21_on");
							} else {
								$("#Tools21").attr('class', "Icon-size1 Tools21");
							}
			            }
				
			});
}
//创建公司
function createSupCompany() {
	showContent(ctx+'/supplier/company/createSupCompany');
}

function modifyCompany(){
	//var sd = $('#dg').datagrid('getSelected');
	//if (sd == null) {
	if (!$('.btable_checked') || !$('.btable_checked').attr('id')) {
		//alert("请选择公司");
		top.jAlert('warning','请选择公司！',window.v_messages);
		return;
	} else {
		var url = ctx+'/supplier/company/modifySupCompany';
		$.ajax({
			type : "post",
			url : url,
			async :false,
			dataType : "html",
			data : {
				"comNo" : $('.btable_checked').attr('id')
			},
			success : function(data) {
				$("#content").children().remove();
				$("#content").html(data);
				$("#createSupCom").text(v_EditCompany);
			}
		});
	}
}

//修改公司
function updateSupCompany(){
		$.ajax({
			type : 'post',
			async : false,
			dataType : "json",
			url : ctx + '/supplier/company/updateSupCompany',
			data : {
				'comNo' : viewModel.comNo(),
				'unifmNo' : viewModel.unifmNo(),
				'comName' : viewModel.comName(),
				'comEnName' : viewModel.comEnName(),
				'comGrpVO.comgrpNo' : viewModel.comgrpNo(),
				'econType' : viewModel.econType(),
				'legalRpstv' : viewModel.legalRpstv(),
				'bizScopeDesc' : viewModel.bizScopeDesc(),
				'setupDate' : viewModel.setupDate(),
				'comRegstrAddress.provName' : viewModel.regProvName(),
				'comRegstrAddress.cityName' : viewModel.regCityName(),
				'comRegstrAddress.detllAddr' : viewModel.regDetllAddr(),
				'comRegstrAddress.areaCode' : viewModel.regAreaCode(),
				'comRegstrAddress.phoneNo' : viewModel.regPhoneNo(),
				'comRegstrAddress.emailAddr' : viewModel.regEmailAddr(),
				'webSite' : viewModel.webSite(),
				'invDlvryAddress.provName' : viewModel.dlvProvName(),
				'invDlvryAddress.cityName' : viewModel.dlvCityName(),
				'invDlvryAddress.detllAddr' : viewModel.dlvDetllAddr(),
				'invDlvryAddress.postCode' : viewModel.dlvPostCode(),
				'invDlvryAddress.cntctName': viewModel.dlvCntctName(),
				'invDlvryAddress.faxNo' : viewModel.dlvFaxNo(),
				'invDlvryAddress.areaCode' : viewModel.dlvAreaCode(),
				'invDlvryAddress.moblNo' : viewModel.dlvMoblNo(),
				'invDlvryAddress.phoneNo' : viewModel.dlvPhoneNo(),
				'invDlvryAddress.emailAddr' :viewModel.dlvEmailAddr(),
				'lawNote' : viewModel.lawNote(),				
				'debtNote' : viewModel.debtNote(),				
				'credtNote' : viewModel.credtNote(),			
				'comLicencesList' : ko.toJSON(self.comLicencesList())	
			},
			success : function(data){
				if (data== true) {
					//alert("修改成功");
					top.jAlert('success', '操作成功', '提示消息');
				} else {
					//alert("修改失败");
					top.jAlert('error', '操作失败', '提示消息');
				}
				
			}
		});
}
//清除公司查询条件
function clearSearch(){
	$("#comgrpNoSearch").val(null);
	$("#comgrpNameSearch").val(null);
	$("#comNoSearch").val(null);
	$("#comNameSearch").val(null);
	$("#comEnNameSearch").val(null);
	$("#econTypeSearch").val(null);
	$("#unifmNoSearch").val(null);
	$("#cityNoSearch").val(null);
	$("#cityNameSearch").val(null);
	$("#provNameSearch").val(null);
	$("#creatDateSearch").val(null);
}
//显示公司列表
function supCompanyList() {
	showContent(ctx + '/supplier/company/companyManagement');
}
function goSupCompanyDetailed(comNo){
	if(!$.trim(comNo)){
		top.jAlert('warning', "请选择公司",'消息提示');
	}else{
		$("#Tools22").attr('class', "Icon-size1 Tools22_on");
		$("#Tools21").attr('class', "Icon-size1 Tools21");
		
		$($("#Tools22").parent()).addClass("ToolsBg");
		$($("#Tools21").parent()).removeClass("ToolsBg");
		
		$.ajax( {
			type : 'post',
			url : ctx + '/supplier/company/showSupCom',
			dataType : "html",
			data : {
				comNo : $.trim(comNo)
			},
			success : function(data) {
				$("#Tools22").attr('class', "Icon-size1 Tools22_on");
				$("#Tools21").attr('class', "Icon-size1 Tools21").unbind().bind('click',function(){
					$("#supCompanyContext").hide();
					$("#supCompanyList").show();
					initToolsbar();
					$($("#Tools22").parent()).removeClass("ToolsBg");
					
				});
				
				$($("#Tools22").parent()).addClass("ToolsBg");
				$($("#Tools21").parent()).removeClass("ToolsBg");
				$("#Tools1").attr('class', "Icon-size1 Tools1_disable").unbind("click");
				$("#Tools11").attr('class', "Icon-size1 Tools11_disable").unbind("click");
				$("#Tools12").attr('class', "Icon-size1 Tools12_disable").unbind("click");
				$("#supCompanyList").hide();
				$("#supCompanyContext").empty();
				$("#supCompanyContext").html(data);
				$("#supCompanyContext").show();
			}
		});
	}
}
//公司详细信息
function supCompanyDetailed() {
	var sd = $('#dg').datagrid('getSelected');
	if (sd == null || sd.length == "") {
		//alert("请选择公司");
		return;
	} else {
		var compNo = sd.comNo;
		$.ajax( {
			type : 'post',
			url : ctx + '/supplier/company/showSupCom',
			dataType : "html",
			data : {
				comNo : compNo
			},
			success : function(data) {
				$("#Tools22").attr('class', "Icon-size1 Tools22_on");
				$("#Tools21").attr('class', "Icon-size1 Tools21");
				
				$($("#Tools22").parent()).addClass("ToolsBg");
				$($("#Tools21").parent()).removeClass("ToolsBg");
				$("#Tools1").attr('class', "Icon-size1 Tools1_disable").unbind("click");
				$("#Tools11").attr('class', "Icon-size1 Tools11_disable").unbind("click");
				$("#Tools12").attr('class', "Icon-size1 Tools12_disable").unbind("click");
				
				$("#supCompanyDetailed").show();
				$("#supCompanyDetailed").html();
				$("#supCompanyList").hide();
				$("#supCompanyDetailed").html(data);
			}
		});
	}
}
//退货地址到公司详细信息
function comOtherCompanyDetailed(obj) {
	$.ajax( {
		type : 'post',
		url : ctx + '/supplier/company/showSupCom',
		dataType : "html",
		data : {
			comNo : obj
		},
		success : function(data) {
			$("#Tools22").attr('class', "Icon-size1 Tools22_on");
			$("#Tools21").attr('class', "Icon-size1 Tools21");
			
			$($("#Tools22").parent()).addClass("ToolsBg");
			$($("#Tools21").parent()).removeClass("ToolsBg");
			$("#Tools1").attr('class', "Icon-size1 Tools1_disable").unbind("click");
			$("#Tools11").attr('class', "Icon-size1 Tools11_disable").unbind("click");
			$("#Tools12").attr('class', "Icon-size1 Tools12_disable").unbind("click");
			
			$("#supCompanyDetailed").show();
			$("#supCompanyDetailed").html();
			$("#supCompanyList").hide();
			$("#supCompanyDetailed").html(data);
		}
	});
}
//关闭新增公司
function wipeAddPage(){
    $("#createSupCom,#createLast").remove();
    companyManagement();
}
//公司总览
function companyManagement(){
    $("#first").addClass("tags1_left_on");
    $("#supComMess").addClass("tagsM tagsM_on");
    $("#midden").addClass("tags tags_left_on");
    $("#comOthAddrMess").addClass("tagsM");
    $("#last").addClass("tags tags3_r_off");
	showContent(ctx+'/supplier/company/companyManagement');
}
//打开公司弹出框
function openSupComgrpWindow() {
	openPopupWin(550, 510,'/commons/window/chooseSupComgrp');
}
function confirmChooseComgrp(comgrpNo,comgrpName,comgrpEnName){
	$('#comgrpNoSearch').attr('value',comgrpNo);
	$('#comgrpNameSearch').attr('value',comgrpName);
	closePopupWin();
}
//打开注册城市弹出框
function openCityWindow() {
	openPopupWin(550, 450,'/commons/window/chooseCity');
}
function confirmChooseCity(regnNo,regnName){
	$('#cityNoSearch').attr('value',regnNo);
	$('#cityNameSearch').attr('value',regnName);
	closePopupWin();
}
function buildPage(comNo) {
	$.ajax({
		type : "post",
		async : false,
		url : ctx + "/supplier/company/getSupCompanyInfo",
		dataType : "json",
		data : {
			'comNo' : comNo
		},
		success : function(data) {
			var supComLics = data.supCompany.comLicences;
			viewModel.comNo(data.supCompany.comNo?data.supCompany.comNo:'');
			viewModel.comName(data.supCompany.comName?data.supCompany.comName:'');
			viewModel.comEnName(data.supCompany.comEnName?data.supCompany.comEnName:'');
			viewModel.unifmNo(data.supCompany.unifmNo?data.supCompany.unifmNo:'');
			viewModel.status(data.supCompany.status?data.supCompany.status:'');
			if(data.supCompany.comGrpVO){
				viewModel.comgrpNo(data.supCompany.comGrpVO.comgrpNo?data.supCompany.comGrpVO.comgrpNo:'');
				viewModel.comgrpName(data.supCompany.comGrpVO.comgrpName?data.supCompany.comGrpVO.comgrpName:'');
			}
			viewModel.econType(data.supCompany.econType?data.supCompany.econType:'');
			viewModel.legalRpstv(data.supCompany.legalRpstv?data.supCompany.legalRpstv:'');
			viewModel.bizScopeDesc(data.supCompany.bizScopeDesc?data.supCompany.bizScopeDesc:'');
			viewModel.setupDate(data.supCompany.setupDate?new Date(data.supCompany.setupDate).format('yyyy-MM-dd'):'');
			viewModel.webSite(data.supCompany.webSite?data.supCompany.webSite:'');
			viewModel.chngBy(data.supCompany.chngBy?data.supCompany.chngBy:'');
			viewModel.chngDate(data.supCompany.chngDate?new Date(data.supCompany.chngDate).format('yyyy-MM-dd'):'');
			viewModel.creatBy(data.supCompany.creatBy?data.supCompany.creatBy:'');
			viewModel.creatDate(data.supCompany.creatDate?new Date(data.supCompany.creatDate).format('yyyy-MM-dd'):'');
			//注册地址
			var comRegstrAddress = data.supCompany.comRegstrAddress;
			if(comRegstrAddress){
				viewModel.regProvName(comRegstrAddress.provName?comRegstrAddress.provName:'');
				viewModel.regCityName(comRegstrAddress.cityName?comRegstrAddress.cityName:'');
				viewModel.regDetllAddr(comRegstrAddress.detllAddr?comRegstrAddress.detllAddr:'');
				viewModel.regAreaCode(comRegstrAddress.areaCode?comRegstrAddress.areaCode:'');
				viewModel.regPhoneNo(comRegstrAddress.phoneNo?comRegstrAddress.phoneNo:'');
				viewModel.regEmailAddr(comRegstrAddress.emailAddr?comRegstrAddress.emailAddr:'');
			}
			//发票地址
			var invDlvryAddress = data.supCompany.invDlvryAddress;
			if(invDlvryAddress){
				viewModel.dlvProvName(invDlvryAddress.provName?invDlvryAddress.provName:'');
				viewModel.dlvCityName(invDlvryAddress.cityName?invDlvryAddress.cityName:'');
				viewModel.dlvDetllAddr(invDlvryAddress.detllAddr?invDlvryAddress.detllAddr:'');
				viewModel.dlvPostCode(invDlvryAddress.postCode?invDlvryAddress.postCode:'');
				viewModel.dlvCntctName(invDlvryAddress.cntctName?invDlvryAddress.cntctName:'');
				viewModel.dlvFaxNo(invDlvryAddress.faxNo?invDlvryAddress.faxNo:'');
				viewModel.dlvAreaCode(invDlvryAddress.areaCode?invDlvryAddress.areaCode:'');
				viewModel.dlvMoblNo(invDlvryAddress.moblNo?invDlvryAddress.moblNo:'');
				viewModel.dlvPhoneNo(invDlvryAddress.phoneNo?invDlvryAddress.phoneNo:'');
				viewModel.dlvEmailAddr(invDlvryAddress.emailAddr?invDlvryAddress.emailAddr:'');
			}

			//额外信息
			viewModel.lawNote(data.supCompany.lawNote?data.supCompany.lawNote:'');
			viewModel.debtNote(data.supCompany.debtNote?data.supCompany.debtNote:'');
			viewModel.credtNote(data.supCompany.credtNote?data.supCompany.credtNote:'');
			//公司证件
			if(supComLics){
  				 $.each(supComLics, function(index, item) {
					viewModel.comLicencesList().push(new LicFun(item.licnceId,item.licnceType,item.licnceNo,new Date(item.validEndDate).format('yyyy-MM-dd'),new Date(item.validStartDate).format('yyyy-MM-dd'),item.issueBy));
				}); 
			}
			viewModel.comLicencesList(viewModel.comLicencesList());
		}
	});
}
//注册城市
function openCityAndProvWindow() {
	openPopupWin(530, 450,'/commons/window/chooseCityAndProv?callback=confirmReg');
}
function confirmReg(cityCode,cityName,provCode,provName){
	viewModel.regProvName(provName);
	viewModel.regCityName(cityName);
	closePopupWin();
}
//发票城市
function openCityAndProvWindowDlv() {
	openPopupWin(550, 450,'/commons/window/chooseCityAndProv?callback=confirmDlv');
}
function confirmDlv(cityCode,cityName,provCode,provName){
	viewModel.dlvProvName(provName);
	viewModel.dlvCityName(cityName);
	closePopupWin();
}
function setAllCheck(){
	var checkedNum = $("input[name='licChecked']:checked").length;
	var totalLic = $("input[name=licChecked]").length;
    if(checkedNum === totalLic){
    	viewModel.allChecked(true);
    }else{
    	viewModel.allChecked(false);
    }
}
function pageQuery(){
	
	var pageNo = $('#pageNo').val();
	var pageSize = $('#pageSize').val();
	
	var comgrpNoSearch =  $("#comgrpNoSearch").val();
	var comNoSearch = $("#comNoSearch").val();
	var comNameSearch = $("#comNameSearch").val();
	var comEnNameSearch = $("#comEnNameSearch").val();
	var econTypeSearch = $("#econTypeSearch").val();
	var unifmNoSearch = $("#unifmNoSearch").val();
	var cityNameSearch = $("#cityNameSearch").val();
	var creatDateSearch = $("#creatDateSearch").val();
	
	$.ajax({
	        type : "post",
	        async : false,
	        url : ctx + "/supplier/company/supCompanyList" ,
	        dataType : "html",
	        data : {
				'comgrpNo':comgrpNoSearch,
				'comNo':comNoSearch,
				'comName':comNameSearch,
				'comEnName':comEnNameSearch,
				'econType':econTypeSearch,
				'unifmNo':unifmNoSearch,
				'cityName':cityNameSearch,
				'creatDate':creatDateSearch,
				'pageNo' : pageNo,
				'pageSize' : pageSize
	        },
	        success : function(data) {
	           $('#supCompanyDetailed').html(data);
	        }
   });
	
}
