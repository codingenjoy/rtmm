// 公司列表
var companyNo = null;
function companySearch() {
	var comNo = $.trim($("#comNo").val());
	var comName = $.trim($("#comName").val());
	var comEnName = $.trim($("#comEnName").val());
	var status = $.trim($("#status").val());
	var legalRpstv = $.trim($("#legalRpstv").val());
	var bizScopeDesc = $.trim($("#bizScopeDesc").val());
	var setupDate = $.trim($("#setupDate").val());
	var regCity = $.trim($("#regCity").val());
	var unifmNo = $.trim($("#unifmNo").val());
	$("#dg").datagrid( {
		rownumbers : false,
		singleSelect : true,
		pagination : true,
		pageSize : 20,
		url : ctx + '/catalog/catalogCompanyListAction',
		queryParams : {
			comNo:comNo,
			comName:comName,
			comEnName:comEnName,
			status:status,
			legalRpstv:legalRpstv,
			bizScopeDesc:bizScopeDesc,
			setupDate:setupDate,
			regCity:regCity,
			unifmNo:unifmNo
		},
		columns : [ [ {
			field : 'ck',
			checkbox : false,
			halign : 'center'
		}, {
			field : 'comNo',
			title : '公司编号',
			sortable : true,width:100,
			halign : 'center',
			formatter : function(val, rec){
				$("#Tools22").attr('class', "Icon-size1 Tools22_disable");
				$("#Tools21").attr('class', "Icon-size1 Tools21_disable");
				$($("#Tools21").parent()).removeClass("ToolsBg");
				return rec.comNo + "&nbsp;&nbsp;";
			},
			align : 'right'
		}, {
			field : 'comTitle',
			title : '公司名称',
			sortable : true,width:367,
			halign : 'center'
		}, {
			field : 'econTitle',
			title : '公司类型',width:110,
			halign : 'center'
		}, {
			field : 'statusTitle',
			title : '状态',width:110,
			halign : 'center'
		}, {
			field : 'unifmNo',
			title : '税号',width:143,
			halign : 'center'
		}, {
			field : 'cityName',
			title : '注册城市',width:88,
			halign : 'center'
		}, {
			field : 'setupDate',
			title : '成立日期',
			halign : 'center',width:110,
			formatter : function(val, rec) {
				return new Date(val).format('yyyy-MM-dd');
			}
		}, {
			field : 'temp',
			title : ' ',width:18,
			halign : 'center'
		}] ],
		onClickRow : function(rowIndex, rowData) {
			$("#selectRowNo").val(rowIndex + 1);
			companyNo = rowData.comNo;
			$("#Tools22").attr('class', "Icon-size1 Tools22");
			$("#Tools21").attr('class', "Icon-size1 Tools21_on");
			$($("#Tools21").parent()).addClass("ToolsBg");
		},
		onDblClickRow : function(rowIndex, rowData){
			$("#selectRowNo").val(rowIndex + 1);
			$("#pageNo").val($('.pagination-num')[0].value);
			$("#rowNo").val($(".pagination-page-list").val());
			countPage();
			companyDetailed();
		}
	});
	

}


// 公司注册
function createCompany() {
	$.ajax( {
		type : 'post',
		url : ctx + '/catalog/createCompanyAction',
		dataType : 'html',
		success : function(data) {
			comNo = null;
			$("#Tools11").attr('class', "Tools11_disable").unbind("click");
			$("#Tools1").attr('class', "Icon-size1 Tools1_disable").unbind(
					"click");
			$("#Tools2").attr('class', "Tools2").bind("click", function() {
				viewModel.save();
			});
			$("#Tools22").attr('class', "Icon-size1 Tools22").unbind("click");
			$("#companyDetailed").show();
			$("#companyDetailed").html();
			$("#companyList").hide();
			$("#companyDetailed").html(data);
		}
	});

}
// 提交注册信息
function submitCompany() {
	var baseMessageForm = $("#baseMessageForm").serialize();
	$.ajax( {
		type : 'post',
		url : ctx + '/catalog/submitCompanyAction',
		data : baseMessageForm,
		success : function(data) {
			if (data) {
				successAlert("操作成功", 350, 80, "提示信息");
			} else {
				errorAlert("操作失败", 350, 80, "提示信息");
			}
		}
	});

}
// 公司详细信息
function companyDetailed() {
	var sd = $('#dg').datagrid('getSelected');
	if (sd == null) {
		return;
	} else {
		var compNo = sd.comNo;
		$.ajax( {
			type : 'post',
			url : ctx + '/catalog/companyDetailedAction',
			dataType : "html",
			data : {
				compNo : compNo,
				pageNos : $("#currentRow").val()
			},
			success : function(data) {
				$("#Tools22").attr('class', "Icon-size1 Tools22_on");
				$("#Tools21").attr('class', "Icon-size1 Tools21");
				
				$($("#Tools22").parent()).addClass("ToolsBg");
				$($("#Tools21").parent()).removeClass("ToolsBg");
				
				
				$("#Tools1").attr('class', "Icon-size1 Tools1_disable").unbind("click");
				$("#companyDetailed").show();
				$("#companyDetailed").html();
				$("#companyList").hide();
				$("#companyDetailed").html(data);
			}
		});
	}
}

// 显示公司列表
function companyList() {
	var sd = $('#dg').datagrid('getSelected');
	if (sd != null) {
		showContent(ctx + '/catalog/catalogCompanyAction',null);
	}
}

function cleanSearch(){
	$(".SearchTable").find('input').val('');
	$("select").prop('selectedIndex', 0);
}
// 打开注册城市弹出框
function openCityWindow() {
	openPopupWin(550, 450,'/commons/window/chooseCity');
}
function confirmChooseCity(regnNo,regnName){
	$('#cityId').attr('value',regnNo);
	$('#regCity').attr('value',regnName);
	closePopupWin();
}