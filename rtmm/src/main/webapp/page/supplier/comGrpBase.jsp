<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript">
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
    var comgrpNo = "";
/*     var dg = $("#dg").datagrid("getSelected");
    if (dg != null) {
    	comgrpNo = dg.comgrpNo;
    } 
    if($('.btable_checked').attr('id') != undefined && $('.btable_checked').attr('id') != null){
    	comgrpNo = $('.btable_checked').attr('id');
    }*/
    if($('.btable_checked') && $('.btable_checked').attr('id')){
    	comgrpNo = $('.btable_checked').attr('id');
    }
	showContent(ctx+'/supplier/group/companyManagement?comgrpNo='+comgrpNo);
}
//集团品牌
function companyBrandManagement(){
    var comgrpNo = "";
/*     var dg = $("#dg").datagrid("getSelected");
    if (dg != null) {
    	comgrpNo = dg.comgrpNo;
    } */
    if($('.btable_checked').attr('id') != undefined && $('.btable_checked').attr('id') != null){
    	comgrpNo = $('.btable_checked').attr('id');
    	if(!($.isNumeric(comgrpNo))){
    		comgrpNo =$('.btable_checked').find('td').get(3).innerHTML;
        }
    }
	showContent(ctx+'/supplier/group/companyBrandManagement?comgrpNo='+comgrpNo);
}
//集团总览
function comGrpManagement(){
	showContent(ctx+'/supplier/group/groupManagement');
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
							title : "${comgrpNo }",
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
							title : "${comgrpName }",
							halign : 'center',
							align : 'left',
							width : 466
						},
						{
							field : 'comgrpEnName',
							title : "${comgrpEnName }",
							halign : 'center',
							align : 'left',
							width : 465
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

//创建集团品牌
function createComGrpBrand(obj) {
	if (obj != "add") {
		//var de_selected = $("#dg").datagrid("getSelected");
		//if (de_selected != null) {
		if($('.btable_checked') && $('.btable_checked').attr('id')){
			openPopupWinTwo(600,230,'/supplier/group/createComGrpBrandManagement?handleType=' + obj+'&brandId='+$('.btable_checked').attr('id'));
		}
	} else {
		openPopupWinTwo(600,230,'/supplier/group/createComGrpBrandManagement?handleType=' + obj);
	}
}
//保存集团品牌信息
function saveComgrpBrand(obj){
	var add_comgrpNo = $.trim($("#add_comgrpNo").val());
	var add_comgrpNoName = $.trim($("#add_comgrpNoName").val());
	var ty_comgrpName = $.trim($("#ty_comgrpName").val());
	var brandId = $.trim($("#brandId").val());
	if (ty_comgrpName != "" && add_comgrpNo != "") {
		$.ajax({
			type : "post",
			async : false,
			url : ctx + '/supplier/group/saveComGrpBrand',
			dataType : "json",
			data : {
				action : obj,
				comgrpNo : $.trim($("#add_comgrpNo").val()),
				brandName : $.trim($("#ty_comgrpName").val()),
				brandEnName : $.trim($("#ty_comgrpEnName").val()),
				brandId : brandId
			},
			success : function(data){
				if (data.status == "success") {
					top.jAlert('success', window.v_operationSuc,window.v_messages);
					if (data.actionType != "add") {
/* 		                var dg = $('#dg');
		                var row = dg.datagrid('getSelected');
		                if (row){
		                    var index = dg.datagrid('getRowIndex', row);
		                    dg.datagrid('updateRow',{
		                        index:index,
		                        row:{brandName : $.trim($("#ty_comgrpName").val()), brandEnName : $.trim($("#ty_comgrpEnName").val())}
		                    });
		                        //修改当前行被选中
		                    dg.datagrid('selectRow',index);
		                } */
						//companyGrpBrandSearch("");
		                companyBrandSearch();
					} else {
						companyBrandSearch();
					}
				} else {
					top.jAlert('error', window.v_operationFail,window.v_messages);
				}
				closePopupWinTwo();
			}
		});
	} else {
		if (ty_comgrpName == "") {
			$("#ty_comgrpName").addClass("errorInput");
		}
		if (add_comgrpNo == "") {
			$("#add_comgrpNo").addClass("errorInput");
		}
	}
}
function modifyComGrp(){
/* 	if(record.comGrpNo == null || record.comGrpNo == ''){
		top.jAlert('error', '请选择一条进行编辑','提示消息');
	}else {
		openPopupWin(600,180,'/supplier/group/modifyComGrpManagement?comgrpNo='+$('.btable_checked').attr('id'));
	} */

	if($('.btable_checked') && $('.btable_checked').attr('id')){
		openPopupWin(600,180,'/supplier/group/modifyComGrpManagement?comgrpNo='+$('.btable_checked').attr('id'));
	}else{
		top.jAlert('warning', '请选择一条进行编辑',window.v_messages);
	}
}

//修改集团
function updateComGrp(){
	if(viewModel.comGrpName() == null || viewModel.comGrpName() == ''){
		top.jAlert('error', '请选择一条进行编辑',window.v_messages);
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
				top.jAlert('success', window.v_operationSuc,window.v_messages);
				closePopupWin();
				comGrpSearch();
			} else {
				top.jAlert('error', window.v_operationFail,window.v_messages);
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
//集团公司查询
function companySearch(){
	
	var comgrpNoSearch =  $.trim($("#comgrpNoSearch").val());
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
							width : 238
						},
						{
							field : 'comEnName',
							title : '公司英文名称',
							halign : 'center',
							align : 'left',
							width : 156,
							formatter : function(val, rec) {
								if(rec.comEnName){
									return rec.comEnName;
								}else{
									return "&nbsp;";
								}
							}
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
							width : 63
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
							width : 110
						},
						{
							field : 'econType',
							title : '公司类型',
							halign : 'center',
							align : 'left',
							formatter : function(val, rec) {
								return getDictValue('COMPANY_ECON_TYPE',rec.econType);
							},
							width : 127
						},
						{
							field : 'unifmNo',
							title : '税号',
							halign : 'center',
							align : 'left',
							width : 129
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
/* 							$("#Tools22").attr('class', "Icon-size1 Tools22");
							$("#Tools21").attr('class', "Icon-size1 Tools21_on");
							
							$($("#Tools22").parent()).removeClass("ToolsBg");
							$($("#Tools21").parent()).addClass("ToolsBg"); */
						},
						onDblClickRow : function (rowIndex,rowData){
							$("#Tools22").attr('class', "Icon-size1 Tools22_on");
							$("#Tools21").attr('class', "Icon-size1 Tools21");
							
							$($("#Tools22").parent()).addClass("ToolsBg");
							$($("#Tools21").parent()).removeClass("ToolsBg");
							supCompanyGroupDetailed();
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

//根据集团查公司
function companyGrpSearch(obj){
	
	var comgrpNoSearch =  $.trim($("#comgrpNoSearch").val());
	if (comgrpNoSearch == "") {
		comgrpNoSearch = $.trim(obj);
	}
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
				url : ctx + '/supplier/company/companyGrpListAction',
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
							width : 238
						},
						{
							field : 'comEnName',
							title : '公司英文名称',
							halign : 'center',
							align : 'left',
							width : 156,
							formatter : function(val, rec) {
								if(rec.comEnName){
									return rec.comEnName;
								}else{
									return "&nbsp;";
								}
							}
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
							width : 63
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
							width : 110
						},
						{
							field : 'econType',
							title : '公司类型',
							halign : 'center',
							align : 'left',
							formatter : function(val, rec) {
								return getDictValue('COMPANY_ECON_TYPE',rec.econType);
							},
							width : 127
						},
						{
							field : 'unifmNo',
							title : '税号',
							halign : 'center',
							align : 'left',
							width : 129
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
/* 							$("#Tools22").attr('class', "Icon-size1 Tools22");
							$("#Tools21").attr('class', "Icon-size1 Tools21_on");
							
							$($("#Tools22").parent()).removeClass("ToolsBg");
							$($("#Tools21").parent()).addClass("ToolsBg"); */
						},
						onDblClickRow : function (rowIndex,rowData){
							$("#Tools22").attr('class', "Icon-size1 Tools22_on");
							$("#Tools21").attr('class', "Icon-size1 Tools21");
							
							$($("#Tools22").parent()).addClass("ToolsBg");
							$($("#Tools21").parent()).removeClass("ToolsBg");
							supCompanyGroupDetailed();
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

//根据集团查品牌
function companyGrpBrandSearch(obj){
/* 	var comgrpBrandNoSearch =  $.trim($("#comgrpBrandNoSearch").val());
	if (comgrpBrandNoSearch == "") {
		comgrpBrandNoSearch = $.trim(obj);
	} else {
		if (obj == "") {
			comgrpBrandNoSearch = "";
		}
	} */
	var comgrpBrandNoSearch =  $.trim($("#comgrpBrandNoSearch").val());
	if(obj){
		comgrpBrandNoSearch = $.trim(obj);
	}
	var brandNoSearch = $("#brandNoSearch").val();
	var brandNameSearch = $("#brandNameSearch").val();
	var brandEnNameSearch = $("#brandEnNameSearch").val();
	var creatDateSearch = $("#creatDateSearch").val();
	$('#dg').datagrid(
			{
				striped:true,
				rownumbers : false,
				singleSelect : true,
				pagination : true,
				pageSize : 20,
				nowrap: true,
				url : ctx + '/supplier/company/companyGrpBrandListAction',
				queryParams : {
					comgrpNo : comgrpBrandNoSearch,
					brandId : brandNoSearch,
					brandName : brandNameSearch,
					brandEnName : brandEnNameSearch,
					creatDate : creatDateSearch
				},
				columns : [ [
						{
							field : 'ck',
							checkbox : false,
							halign : 'center'
						},
						{
							field : 'comgrpNo',
							title : '集团',
							sortable : true,
							halign : 'center',
							formatter : function(val, rec) {
								return $.trim(rec.comgrpNo)+"-"+$.trim(rec.comGrpName);
							},
							width : 103
						},
						{
							field : 'brandId',
							title : '品牌编号',
							halign : 'center',
							align : 'right',
							formatter : function(val, rec) {
								return rec.brandId+"&nbsp;&nbsp;";
							},
							width : 154
						},
						{
							field : 'brandName',
							title : '品牌名称',
							halign : 'center',
							width : 309
						},
						{
							field : 'brandEnName',
							title : '品牌英文名称',
							sortable : true,
							halign : 'center',
							width : 343
						},
						{
							field : 'creatDate',
							title : '创建日期',
							halign : 'center',
							formatter : function(val, rec) {
								return new Date(val).format('yyyy-MM-dd');
							},
							width : 120
						}
						] ],
						onLoadSuccess : function(){

						},
						onDblClickRow : function (rowIndex,rowData){

						},
			            onClickRow : function(rowIndex, rowData) {
			        		$("#Tools12").attr('class', "Icon-size1 Tools12 B-id");
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
function supCompanyGroupList() {
	var Tools21 = $("#Tools21").attr('class');
	$("#Tools22").parent().removeClass('ToolsBg');
	$("#Tools22").attr('class','Icon-size1 Tools22');
	if (Tools21.indexOf('disable') < 0) {
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",
				function() {
					DispOrHid('B-id');
				});
	/* 	$("#Tools22").attr('class', "Icon-size1 Tools22").bind("click", function() {
			supCompanyDetailed();
		}); */
		/*$("#Tools2").attr('class', "Tools2_disable").unbind("click");
		$("#supComMess").text("集团公司");*/
		$("#supCompanyList").show();
		$("#supCompanyDetailed").hide();
	}
}
//公司详细信息
function supCompanyGroupDetailed() {
	var sd = $('#dg').datagrid('getSelected');
	if (sd == null) {
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
				$("#supCompanyDetailed").show();
				$("#supCompanyDetailed").html();
				$("#supCompanyList").hide();
				$("#supCompanyDetailed").html(data);
			}
		});
	}
}
//打开公司弹出框
function openSupComgrpWindow(obj) {
	openPopupWin(550, 510,'/commons/window/chooseSupComgrp?action='+obj);
}
function confirmChooseComgrp(comgrpNo,comgrpName,comgrpEnName){
	$('#comgrpNoSearch').attr('value',comgrpNo);
	$('#comgrpNameSearch').attr('value',comgrpName);
	closePopupWin();
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
	        url : ctx + "/supplier/group/comGrpListPage",
	        dataType : "html",
	        data : {
				'comgrpNo':comgrpNo,
				'comgrpName':comgrpName,
				'comgrpEnName':comgrpEnName,
				'pageNo':pageNo,
				'pageSize':pageSize
	        },
	        success : function(data) {
	           $('#supCompanyDetailed').html(data);
	        }
   });
	
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
</script>
