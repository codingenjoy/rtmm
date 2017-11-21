function Record(){
	this.comGrpNo = null;
	this.comGrpName = null;
	this.comGrpEnName = null;
	this.selectedIndex = null;
}
//日历
$('#date_div').calendar({
    current: new Date()
});
//集团公司
function companyManagement(){
    $("#first").addClass("tags1_left");
    $("#comGrpMess").addClass("tagsM");
    $("#midden").addClass("tags tags_right_on");
    $("#supComMess").addClass("tagsM tagsM_on");
    $("#last").addClass("tags tags3_r_on");
	showContent(ctx+'/supplier/group/companyManagement');
}
//集团品牌
function companyBrandManagement(){
    $("#first").addClass("tags1_left");
    $("#comGrpMess").addClass("tagsM");
    $("#midden").addClass("tags tags_right_on");
    $("#supComMess").addClass("tagsM tagsM_on");
    $("#last").addClass("tags tags3_r_on");
	showContent(ctx+'/supplier/group/companyBrandManagement');
}
//集团总览
function comGrpManagement(){
    $("#first").addClass("tags1_left_on");
    $("#comGrpMess").addClass("tagsM tagsM_on");
    $("#midden").addClass("tags tags_left_on");
    $("#supComMess").addClass("tagsM");
    $("#last").addClass("tags tags3_r_off");
	showContent(ctx+'/supplier/group/groupManagement');
}
function pageQuery(){
	var pageNo = $('#pageNo').val();
	var pageSize = $('#pageSize').val();
	
	var comgrpNo = $("#comgrpNoSearch").val();
	var comgrpName = $("#comgrpNameSearch").val();
	var comgrpEnName = $("#comgrpEnNameSearch").val();
	
	$.ajax({
	        type : "post",
	        async : false,
	        url : ctx + "/supplier/group/comGrpListPage" ,
	        dataType : "html",
	        data : {
				'comgrpNo':comgrpNo,
				'comgrpName':comgrpName,
				'comgrpEnName':comgrpEnName,
				'pageNo' : pageNo,
				'pageSize' : pageSize
	        },
	        success : function(data) {
	           $('#supCompanyDetailed').html(data);
	        }
   });
	
}
//集团查询
function comGrpSearch(){
	var comgrpNo = $("#comgrpNoSearch").val();
	var comgrpName = $("#comgrpNameSearch").val();
	var comgrpEnName = $("#comgrpEnNameSearch").val();
	$('#dg').datagrid(
			{
				sortOrder:'asc',
				striped:true,
				rownumbers : false,
				singleSelect : true,
				pagination : true,
				pageSize : 20,
				url : ctx + '/supplier/group/comGrpList',
				queryParams : {
					comgrpNo:comgrpNo,
					comgrpName:comgrpName,
					comgrpEnName:comgrpEnName
				},
				columns : [ [
						{
							field : 'ck',
							checkbox : false,
							halign : 'center'
						},
						{
							field : 'comgrpNo',
							title : '集团编号',
							sortable : true,
							halign : 'center',
							align : 'right',
							formatter : function(val, rec) {
								return val+"&nbsp;&nbsp;";
							},
							width : 100
						},
						{
							field : 'comgrpName',
							title : '集团名称',
							halign : 'center',
							align : 'left',
							width : 457
						},
						{
							field : 'comgrpEnName',
							title : '集团英文名称',
							halign : 'center',
							align : 'left',
							width : 456
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
						},	
						onClickRow : function(rowIndex, rowData) {
							record.comGrpNo = rowData.comgrpNo;
							record.comGrpName = rowData.comgrpName;
							record.comGrpEnName = rowData.comgrpEnName;
						}
			});
}
//创建集团
function createComGrp() {
	openPopupWin(600,180,'/supplier/group/createComGrpManagement');
}

function modifyComGrp(){
	if($('.btable_checked') && $('.btable_checked').attr('id')){
		openPopupWin(600,180,'/supplier/group/modifyComGrpManagement?comgrpNo='+$('.btable_checked').attr('id'));
	}else{
		top.jAlert('warning', '请选择一条进行编辑','提示消息');
	}
}

//修改集团
function updateComGrp(){
	if(viewModel.comGrpName() == null || viewModel.comGrpName() == ''){
		alert("请输入集团名");
		return;
	}
	$.ajax({
		type : 'post',
		async : false,
		dataType : "json",
		url : ctx + '/supplier/group/updateComGrp',
		data : {
			comgrpNo:viewModel.comGrpNo(),
			comgrpName:viewModel.comGrpName(),
			comgrpEnName:viewModel.comGrpEnName()
		},
		success : function(data){
			if (data== true) {
				successAlert("操作成功", 350, 80, "提示信息");
				//alert("操作成功");
				closePopupWin();
				comGrpSearch();
			} else {
				errorAlert("操作失败", 350, 80, "提示信息");
				//alert("操作失败");
				$('#dg').datagrid('getSelected').comgrpName  = viewModel.comGrpName();
				$('#dg').datagrid('getSelected').comgrpEnName  = viewModel.comGrpEnName();
			}
			
		}
	});
}
//清除查询条件
function cleanSearch(){
	$("#comgrpNo").val(null);
	$("#comgrpName").val(null);
	$("#comgrpEnName").val(null);
}
//清除公司查询条件
function cleanComSearch(){
	$("#comgrpNoSearch").val(null);
	$("#comgrpNameSearch").val(null);
	$("#comNoSearch").val(null);
	$("#comNameSearch").val(null);
	$("#comEnNameSearch").val(null);
	$("#econTypeSearch").val(null);
	$("#unifmNoSearch").val(null);
	$("#cityNoSearch").val(null);
	$("#cityNameSearch").val(null);
	$("#creatDateSearch").val(null);
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
	        url : ctx + "/supplier/company/companyList" ,
	        dataType : "html",
	        data : {
				'comGrpVO.comgrpNo':comgrpNoSearch,
				'comNo':comNoSearch,
				'comName':comNameSearch,
				'comEnName':comEnNameSearch,
				'econType':econTypeSearch,
				'unifmNo':unifmNoSearch,
				'comRegstrAddress.cityName':cityNameSearch,
				'creatDate':creatDateSearch,
				'pageNo' : pageNo,
				'pageSize' : pageSize
	        },
	        success : function(data) {
	           $('#supCompanyDetailed').html(data);
	        }
   });
	
}
//集团公司查询
function companySearch(){
	
	var comgrpNoSearch =  $("#comgrpNoSearch").val();
	var comNoSearch = $("#comNoSearch").val();
	var comNameSearch = $("#comNameSearch").val();
	var comEnNameSearch = $("#comEnNameSearch").val();
	var econTypeSearch = $("#econTypeSearch").val();
	var unifmNoSearch = $("#unifmNoSearch").val();
	var cityNameSearch = $("#cityNameSearch").val();
	var creatDateSearch = $("#creatDateSearch").val();
	$('#dg').datagrid(
			{
				striped:true,
				rownumbers : false,
				singleSelect : true,
				pagination : true,
				pageSize : 20,
				nowrap: true,
				url : ctx + '/supplier/company/companyList',
				queryParams : {
					'comGrpVO.comgrpNo':comgrpNoSearch,
					'comNo':comNoSearch,
					'comName':comNameSearch,
					'comEnName':comEnNameSearch,
					'econType':econTypeSearch,
					'unifmNo':unifmNoSearch,
					'comRegstrAddress.cityName':cityNameSearch,
					'creatDate':creatDateSearch
				},
				columns : [ [
						{
							field : 'ck',
							checkbox : false,
							halign : 'center'
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
							width : 54
						},
						{
							field : 'comName',
							title : '公司名称',
							halign : 'center',
							align : 'left',
							width : 236
						},
						{
							field : 'comEnName',
							title : '公司英文名称',
							halign : 'center',
							align : 'left',
							width : 155,
							formatter : function(val, rec) {
								if(rec.comEnName){
									return rec.comEnName;
								}else{
									return "&nbsp;";
								}
							},
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
								}else{
									return "&nbsp;";
								}
							},
							width : 62
						},
						{
							field : 'comgrpName',
							title : '集团',
							halign : 'center',
							align : 'left',
							formatter : function(val, rec) {
								if(rec.comGrpVO.comgrpName){
									return rec.comGrpVO.comgrpName;
								}else{
									return "&nbsp;";
								}
							},
							width : 107
						},
						{
							field : 'econType',
							title : '公司类型',
							halign : 'center',
							align : 'left',
							formatter : function(val, rec) {
								return getDictValue('COMPANY_ECON_TYPE',rec.econType);
							},
							width : 126
						},
						{
							field : 'unifmNo',
							title : '税号',
							halign : 'center',
							align : 'left',
							width : 128
						},
						{
							field : 'regCityName',
							title : '注册城市',
							halign : 'center',
							align : 'left',
							formatter : function(val, rec) {
								return rec.comRegstrAddress.cityName;
							},
							width : 67
						},
						{
							field : 'setupDate',
							title : '创建日期',
							halign : 'center',
							align : 'left',
							formatter : function(val, rec) {
								return new Date(val).format('yyyy-MM-dd');
							},
							width : 87
						},
						{
							field : "temp",
							halign : 'center',
							width : 18
						}
						] ],
						onLoadSuccess : function(){
							setBorderRig('.Content');
							$("#Tools22").attr('class', "Icon-size1 Tools22");
							$("#Tools21").attr('class', "Icon-size1 Tools21_on");
							
							$($("#Tools22").parent()).removeClass("ToolsBg");
							$($("#Tools21").parent()).addClass("ToolsBg");
						},	
						onDblClickRow : function (rowIndex,rowData){
							$("#Tools22").attr('class', "Icon-size1 Tools22_on");
							$("#Tools21").attr('class', "Icon-size1 Tools21");
							
							$($("#Tools22").parent()).addClass("ToolsBg");
							$($("#Tools21").parent()).removeClass("ToolsBg");
							supCompanyDetailed();
						}
			});
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
//显示公司列表
function supCompanyList() {
	$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",
			function() {
				DispOrHid('B-id');
			});
	$("#Tools22").attr('class', "Icon-size1 Tools22").bind("click", function() {
		supCompanyDetailed();
	});
	/*$("#Tools2").attr('class', "Tools2_disable").unbind("click");
	$("#supComMess").text("集团公司");*/
	$("#supCompanyList").show();
	$("#supCompanyDetailed").hide();
}
//公司详细信息
function supCompanyDetailed() {
	var sd = $('#dg').datagrid('getSelected');
	if (sd == null || sd.length == "") {
		alert("请选择公司");
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
				$("#supCompanyDetailed").show();
				$("#supCompanyDetailed").html();
				$("#supCompanyList").hide();
				$("#supCompanyDetailed").html(data);
			},
		});
	}
}
//打开公司弹出框
function openSupComgrpWindow() {
	openPopupWin(540, 500,'/commons/window/chooseSupComgrp');
}
function confirmChooseComgrp(comgrpNo,comgrpName,comgrpEnName){
	$('#comgrpNoSearch').attr('value',comgrpNo);
	$('#comgrpNameSearch').attr('value',comgrpName);
	closePopupWin();
}

