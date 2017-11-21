var codes = null;
var divisionName = null;
var p_attrId = null;

// 验证数字
function idNumber(obj) {
	var search_str = new RegExp(/^[0-9]{1,6}$/);
	if (obj.value != "") {
		if (!search_str.test($.trim(obj.value))) {
			$("#" + obj.id).addClass("errorInput");
		}
	}
}
// 删除样式
function deleteStyle(obj) {
	$("#" + obj.id).removeClass("errorInput");
}

function codeOnfocus() {
	$("#code").removeClass("errorInput");
	$("#code").attr('title', '数字格式');
}
function nameOnfocus() {
	$("#name").removeClass("errorInput");
}
function enNameOnfocus() {
	$("#enName").removeClass("errorInput");
}

function showDivisionData() {
	$('.datagrid').val('');
	$.post(ctx + '/catalog/showcatalogDivisionAction', {}, function(data) {
		$("#Con_Tb").html(data);
	}, "html");
	// showSection();
}

//
/*function divisionPageInitialise() {
	$("#dg").datagrid({
		rownumbers : false,
		singleSelect : true,
		pagination : true,
		pageSize : 10,
		url : ctx + '/catalog/showSectionAction',
		queryParams : {
			divisionId : 20
		},
		columns : [ [ {
			field : 'ck',
			checkbox : false,
			halign : 'center'
		}, {
			field : 'catlgNo',
			title : '课别',
			sortable : true,
			align : 'right',
			formatter : function(val, rec) {
				return rec.catlgNo + "&nbsp;&nbsp;";
			},
			halign : 'center'
		}, {
			field : 'catlgName',
			title : '中文名称',
			sortable : true,
			halign : 'center'
		}, {
			field : 'catlgEnName',
			title : '英文名称',
			halign : 'center'
		}, {
			field : 'foodNonfoodTitle',
			title : '食品/非食品',
			halign : 'center'
		}, {
			field : 'ordDeletEnbldIndTitle',
			title : '订单删除',
			halign : 'center'
		}, {
			field : 'statusTitle',
			title : '状态',
			halign : 'center'
		} ] ]
	});
}*/
// 只输入数字
function IsNum() {
	return ((event.keyCode >= 48) && (event.keyCode <= 57));
}

function showSection(code, divName) {
	// 在還沒點中一個課別之前, 關閉 edit 功能
	$("#Tools12").attr('class', "Tools12_disable");
	// $("#Tools12").unbind("click");
	if (divName != null) {
		divisionName = divName;
	}
	if (codes != code) {
		$("#Point_L" + codes).removeClass("Point_L2");
		$("#sectionTr" + codes).removeClass("item_on2");
	}
	$("#sectionTr" + code).addClass("item_on2");
	$("#Point_L" + code).addClass("Point_L2");
	codes = code;
	$("#dg").datagrid({
		rownumbers : false,
		singleSelect : true,
		pagination : true,
		pageSize : 10,
		url : ctx + '/catalog/showSectionAction',
		queryParams : {
			divisionId : code
		},
		columns : [ [ {
			field : 'ck',
			checkbox : false,
			halign : 'center'
		}, {
			field : 'catlgNo',
			title : '课别',widnt:40,
			sortable : true,
			align : 'right',
			formatter : function(val, rec) {
				return rec.catlgNo + "&nbsp;&nbsp;";
			},
			halign : 'center'
		}, {
			field : 'catlgName',
			title : '中文名称',widnt:139,
			sortable : true,
			halign : 'center'
		}, {
			field : 'catlgEnName',
			title : '英文名称',widnt:192,
			halign : 'center'
		}, {
			field : 'foodNonfoodTitle',
			title : '食品/非食品',widnt:97,
			halign : 'center'
		}, {
			field : 'ordDeletEnbldIndTitle',
			title : '订单删除',widnt:60,
			halign : 'center'
		}, {
			field : 'statusTitle',
			title : '状态',widnt:60,
			halign : 'center'
		} ] ],
		onClickCell : function(rowIndex, rowData) {
			$("#Tools12").attr('class', "Tools12");
		},
		onCheck : function(rowIndex, rowData) {
			$("#Tools12").attr('class', "Tools12");
		}
	});
}

//
function sectionShowMessage() {
	$("#divisionId").val(codes + '-' + divisionName);
	$("#sectionId").val($('#dg').datagrid('getSelections')[0].catlgNo + "-"
					+ $('#dg').datagrid('getSelections')[0].catlgName);
	$("#name").val($('#dg').datagrid('getSelections')[0].catlgName);
	$("#enName").val($('#dg').datagrid('getSelections')[0].catlgEnName);
	$("#orderStatus").val(
			$('#dg').datagrid('getSelections')[0].ordDeletEnbldInd);
	$("#foodNonfood").val($('#dg').datagrid('getSelections')[0].foodNonfood);
	$("#status").val($('#dg').datagrid('getSelections')[0].status);
}
//
/*
 * function closeDivisions(){ closePopupWin(); group_u_showOrHide = 0;
 * $("#Tools12").attr('class', "Tools12").bind("click", function() {
 * editSection(); }); }
 */
// 创建课别信息
function openCreateSectionWindow() {
	openPopupWin(615, 300, '/catalog/openCreateSectionAction');
}
// 提交课别信息
function createSectionSave() {
	var code = $("#code").val();
	var name = $("#name").val();
	var enName = $("#enName").val();
	var divisionCode = $("#divisionCode").val();
	var cr_sectionDiv = $("#cr_sectionDiv").serialize();
	if ($("#code").attr("class").indexOf("errorInput") < 1 && name != "" && enName != "" && divisionCode != "") {
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/CreateSectionAction',
			data : cr_sectionDiv,
			success : function(data) {
				if (data.status == "success") {
					//alert(data.message);
					successAlert(data.message, 350, 80, "提示信息");
					closePopupWin();
					showSection(codes);
				} else {
					errorAlert(data.message, 350, 80, "提示信息");
					//alert(data.message);
				}
			}
		});
	} else {
		if (code == "") {
			$("#code").addClass("errorInput");
		}
		if (name == "") {
			$("#name").addClass("errorInput");
		}
		if (enName == "") {
			$("#enName").addClass("errorInput");
		}
		if (divisionCode == "") {
			$("#divisionCode").addClass("errorInput");
		}
	}
}

/*// 修改课信息
function editSection() {
	if ($('.datagrid-body').find('tr') != null) {
		var select = $('#dg').datagrid('getSelections');
		if (select != null && select.length == 1) {
			openPopupWin(615, 300, '/catalog/sectionEditAction');
		} else {
//			alert("请选择课");
			top.jAlert('warning', "请选择课",'提示消息');
		}
	}
}
*/
// 保存修改课信息
function saveEditSave() {
	var name = $.trim($('#name').val());
	var enName = $.trim($('#enName').val());
	if (name != "" && enName != "") {
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/doSaveSectionAction',
			data : {
				catlgId : $('#dg').datagrid('getSelections')[0].catlgId,
				catlgNo : $('#dg').datagrid('getSelections')[0].catlgNo,
				catlgName : name,
				catlgEnName : enName,
				ordDelAllowInd : $.trim($('#orderStatus').val()),
				foodNonfood : $.trim($('#foodNonfood').val()),
				status : $.trim($("#status").val())
			},
			success : function(data) {
				if (data.status == "success") {
					successAlert(data.message, 350, 80, "提示信息");
					//alert(data.message);
					closePopupWin();
					showSection(codes);
				} else {
					errorAlert(data.message, 350, 80, "提示信息");
					//alert(data.message);
				}
			}
		});
	} else {
		if (name == "") {
			$("#name").addClass("errorInput");
		}
		if (enName == "") {
			$("#enName").addClass("errorInput");
		}
	}
}
// 處課信息 : 初始化處課信息頁面
function divisionInfo(){
	$('#first').attr("class", "tags1_left tags1_left_on");
	$('#sec_info').attr("class", "tagsM tagsM_on");
	$('#midden').attr("class" , "tags tags_left_on");
	$('#sec_attr').attr("class" , "tagsM");
	$('#last').attr("class", "tags tags3_r_off");
	showContent(ctx+'/catalog/catalogDivisionAction');
}

/*// 課別屬性: 課別選擇彈出框
function selectSection(){
	openPopupWin(615, 200, '/catalog/openChooseSectionAction');
}

// 課別屬性: 確認選擇的課別 
function chooseSection() {
	if ($('#sectionCodeCreate :selected').val() == '' || $('#sectionCodeCreate :selected').val() == undefined){
		//alert("请选择处课");
		top.jAlert('warning', '请选择处课', '提示消息');
	}else{
		var section = $('#sectionCodeCreate :selected').text();
		var sectionName = $.trim(section.substring(section.indexOf('-')+1, section.length));
		
		$("#secAttrSecNo").val($("#sectionCodeCreate").val());
		$("#secAttrSecName").val(sectionName);
		
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/showSecAttrList',
			dataType  : 'html',
			data : {
				sectionId :  $.trim($("#secAttrSecNo").val())
			},
			success : function(data){
				$(".Con_tb").html(data);
			}
		});
		closePopupWin();
	}
}

//課別屬性: 顯示所選的課別屬性對應值列表
function showAttrContent(attrId){
	var showCatlgId = $.trim($("#secAttrSecNo").val());
	
	if (showCatlgId == ''){
		showCatlgId = 1;
		attrId = 1;
	}
	// Enable edit Section Attribute Function
	$("#Tools12").attr("class", "Tools12");
	$("#Tools12").bind("click", function(){
		editSecAttrFormPopWin();
	});
	
	// Enable create Section Attribute Value Function
	$('#attrValCreate').attr("class", "Icon-size2 Tools11");
	
	if (p_attrId != attrId) {
		$("#Point_L" + p_attrId).removeClass("Point_L2");
		$("#sectionTr" + p_attrId).removeClass("item_on2");
	}
	$("#attrId" + attrId).addClass("item_on2");
	$("#Point_L" + attrId).addClass("Point_L2");
	p_attrId = attrId;
	
	$('#pageNo').val('1');
	$('#pageSize').val('');
	pageQuery(showCatlgId, attrId);
}
//課別屬性: 彈出修改課別屬性視窗
function editSecAttrFormPopWin(){
	openPopupWin(615, 200, '/catalog/editSecAttrFormPopWin');
}

//課別屬性: 彈出修改課別屬性對應屬性值視窗
function editSecAttrValFormPopWin(mode){
	var select = $('.item_on2 > #seqNo').text();
	if (select != ''){
		openPopupWin(615, 300, '/catalog/editSecAttrValFormPopWin?mode=' + mode);
	}
}



// 課別屬性: 儲存課別屬性修改
function saveSecAttr() {
	var flag = true;
	var editcatlgId = $('#editcatlgId').val();
	if ($('#editsecAttrValName').val() == '') {
		$('#editsecAttrValName').addClass("errorInput");
		flag = false;
	} else {
		// 檢查是否這個屬性中文名稱已有重覆

	}
	if (flag) {
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/saveSecAttr',
			async : false,
			data : {
				catlgId : $('#editcatlgId').val(),
				seqNo : $('#editseqNo').val(),
				secAttrValName : $.trim($('#editsecAttrValName').val())
			},
			success : function(data) {
				if (data.status == "SUCCESS") {
					top.jAlert('success', data.message,'提示消息');

				} else {
					top.jAlert('error', data.message ,'提示消息');
				}
			}
		});
		closePopupWin();

		// 重新整理課別屬性列表
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/showSecAttrList',
			dataType : 'html',
			async : false,
			data : {
				sectionId : editcatlgId
			},
			success : function(result) {
				$(".Con_tb").html('');
				$(".Con_tb").html(result);
			}
		});
	}
}

// 課別屬性: 儲存課別屬性的 對應屬性值
function saveSecAttrVal() {
	var flag = true;
	if ($.trim($('#valSecAttrValName').val()) == '') {
		$('#valSecAttrValName').addClass("errorInput");
		flag = false;
	}

	if (flag) {
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/checkSecAttrVal',
			data : {
				catlgId : $('#valCatlgId').val(),
				secAttrSeqNo : $('#valSecAttrSeqNo').val(),
				secAttrValName : $('#valSecAttrValName').val(),
			},
			success : function(data) {
				if (data.exist == true) {
					$('#valSecAttrValName').addClass("errorInput");
					$('#valSecAttrValName').attr("title", "属性值中文描述不能重复");
				} else {
					$.ajax({
						type : 'post',
						url : ctx + '/catalog/saveSecAttrVal',
						async : false,
						data : {
							catlgId : $('#valCatlgId').val(),
							secAttrSeqNo : $('#valSecAttrSeqNo').val(),
							secAttrValNo : $('#valSecAttrValNo').val(),
							secAttrValName : $('#valSecAttrValName').val(),
							secAttrId : $('#secAttrId').val()
						},
						success : function(data) {
							if (data.status == "SUCCESS") {
								top.jAlert('success', data.message, '提示消息');
								$('#attrContentList').html('');
								showAttrContent($('#valSecAttrSeqNo').val());
								closePopupWin();
							} else {
								top.jAlert('error', data.message, '提示消息');
							}
						}
					});
				}
			}
		});
	}

}	
*/