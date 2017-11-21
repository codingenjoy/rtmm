var groupInitial = null;
var midsizeInitial = null;
var subInitial = null;
var groupCode = null;
var subCode = null;
var midsizeCode = null;

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
function sectionIdOnchange() {
	$("#sectionCodeCreate").removeClass("errorInput");
}
function groupOnchange() {
	$("#groupCodeCreate").removeClass("errorInput");
}
function selllikewildfiresOnfocus() {
//	$("#selllikewildfire").text("");
	$("#selllikewildfire").removeClass("errorInput");
}
function outofstocksOnfocus() {
//	$("#outofstock").text("");
	$("#outofstock").removeClass("errorInput");
}
function dayOnfocus() {
//	$("#days").text("");
	$("#days").removeClass("errorInput");
}
function buyVatOnfocus(){
	$("#buyVatNo").removeClass("errorInput");
}
function sellVatOnfocus(){
	$("#sellVatNo").removeClass("errorInput");
}

// 只输入数字
function IsNum(){
       return ((event.keyCode >= 48) && (event.keyCode <= 57)); 
}
//验证数字
function idNumber(obj){
	var search_str = new RegExp(/^[0-9]{1,6}$/);
	if (obj.value != "") {
		if(!search_str.test($.trim(obj.value))){
			$("#"+obj.id).addClass("errorInput");
		}
	}
}
//删除样式
function deleteStyle(obj){
	$("#"+obj.id).removeClass("errorInput");
}
// 提交大分类创建的数据
function saveGroup() {
	var code = $.trim($("#code").val());
	var name = $.trim($("#name").val());
	var enName = $.trim($("#enName").val());
	var divisionCodeCreate = $.trim($("#divisionCodeCreate").val());
	var sectionCodeCreate = $.trim($("#sectionCodeCreate").val());
	var cr_groupFrom = $("#cr_groupFrom").serialize();
	if (code != "" && name != "" && enName != "" 
			&& divisionCodeCreate != null
			&& divisionCodeCreate != ""
			&& sectionCodeCreate != null
			&& sectionCodeCreate != "") {
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/saveGroupMessageAction',
			data : cr_groupFrom,
			success : function(data) {
				if (data.status=='success') {
					//alert("创建成功");
					successAlert(data.message, 350, 80, "提示信息");
					closePopupWin();
					groupSearch();
				} else {
					//alert(data.message);
					errorAlert(data.message, 350, 80, "提示信息");
				}
				// closePopupWin();
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
		if (divisionCodeCreate == null || divisionCodeCreate == "") {
			$("#divisionCodeCreate").addClass("errorInput");
		}
		if (sectionCodeCreate == null || sectionCodeCreate == "") {
			$("#sectionCodeCreate").addClass("errorInput");
		}
		return;
	}
}

// 显示大分类列表信息
function groupSearch() {
	$("#Tools12").attr('class', "Tools12_disable");
	$("#Tools10").attr('class', "Tools10_disable");
	var divisionId = $.trim($("#divisionCode").val());
	var sectionId = $.trim($("#sectionCode").val());
	var catlgNo = $.trim($("#catlgNo").val());
	var catlgName = $.trim($("#catlgName").val());
	var status = $.trim($("#status").val());
	if ($("#catlgNo").attr("class").indexOf("errorInput") < 1) {
		$('#dg').datagrid({
			rownumbers : false,
			singleSelect : true,
			pagination : true,
			pageSize : 20,
			url : ctx + '/catalog/groupList',
			queryParams : {
				state : $("#status").find('option:selected')[0].value,
				sectionId : sectionId,
				divisionId : divisionId,
				status:status,
				catlgNo:catlgNo,
				catlgName:catlgName
			},
			columns : [ [ {
				field : 'ck',
				checkbox : false
			}, {
				field : 'catlgNo',
				title : '大分类',width : 56,
				sortable : true,
				halign : 'center',
				formatter : function(val, rec){
					return rec.catlgNo + "&nbsp;&nbsp;";
				},
				align : 'right'
			}, {
				field : 'catlgName',
				title : '中文名称',width : 204,
				sortable : true,
				halign : 'center'
			}, {
				field : 'catlgEnName',
				title : '英文名称',width : 433,
				sortable : true,
				halign : 'center'
			}, {
				field : 'status',
				title : '状态',width : 90,
				formatter : function(val, rec) {
					return getDictValue('CL_CATALOG_STATUS',rec.status);
				},
				halign : 'center'
			}, {
				field : 'divTitle',
				title : '处别',width : 101,
				halign : 'center',
				formatter : function(val, rec) {
					return rec.divNo+'-'+rec.divTitle;
				}
			}, {
				field : 'secTitle',
				title : '课别',width : 146,
				halign : 'center',
				formatter : function(val, rec) {
					return rec.secNo+'-'+rec.secTitle;
				}
			}, {
				field : 'createDate',
				title : '创建日期',width : 50,
				halign : 'center',
				formatter : function(val, rec) {
					return new Date(val).format('yyyy-MM-dd');
				},
				hidden : true
			}, {
				field : 'chngDate',
				title : '修改日期',width : 50,
				halign : 'center',
				formatter : function(val, rec) {
					return new Date(val).format('yyyy-MM-dd');
				},
				hidden : true
			}, {
				field : 'chngBy',
				title : '修改人',width : 50,
				halign : 'center',
				hidden : true
			}, {
				field : 'temp',
				title : ' ',width:18,
				halign : 'center'
			}] ],
			onClickRow : function(rowIndex, rowData) {
				//$("#Tools10").attr('class', "Tools10");
				$("#Tools12").attr('class', "Tools12");
				groupCode = rowData.catlgId;
				$.ajax({
					type : 'post',
					url : ctx + '/catalog/groupMessageAction',
					dataType : 'json',
					data : {
						groupCode : groupCode
					},
					success : function(data) {
						viewModelBtm.m3DepreRate(data.m3DepreRate);
						viewModelBtm.m6DepreRate(data.m6DepreRate);
						viewModelBtm.m12DepreRate(data.m12DepreRate);
						viewModelBtm.createDate(new Date($('#dg').datagrid('getSelections')[0].createDate).format('yyyy-MM-dd'));
						viewModelBtm.chngDate(new Date($('#dg').datagrid('getSelections')[0].chngDate).format('yyyy-MM-dd'));
						viewModelBtm.chngBy($('#dg').datagrid('getSelections')[0].chngBy);
					},
					error : function(data) {
					}
				});
			}
		});
	}
}
// 打开创建大分类窗口
function openCreateGroup() {
	openPopupWin(600, 300, '/catalog/groupForm');
}
// 修改大分类
function groupUpdata() {
	if($('#dg').datagrid('getSelections') != 0){
		openPopupWin(600, 300, '/catalog/groupUpdataAction');
	}
}
// 提交中分类创建数据
function saveMidsize() {
	var code = $.trim($("#code").val());
	var name = $.trim($("#name").val());
	var enName = $.trim($("#enName").val());
	var divisionCodeCreate = $.trim($("#divisionCodeCreate").val());
	var sectionCodeCreate = $.trim($("#sectionCodeCreate").val());
	var groupCodeCreate = $.trim($("#groupCodeCreate").val());
	var cr_createMidsizeForm = $("#cr_createMidsizeForm").serialize();
	if (code != "" && name != "" && enName != "" && divisionCodeCreate != null
			&& divisionCodeCreate != "" && sectionCodeCreate != null
			&& sectionCodeCreate != "" && groupCodeCreate != null
			&& groupCodeCreate != "") {
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/saveMidsizeMessgaeAction',
			data : cr_createMidsizeForm,
			success : function(data) {
				if (data.status=='success') {
					alert("创建成功");
					closePopupWin();
					midGroupSearch();
				} else {
					alert(data.message);
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
		if (divisionCodeCreate == null || divisionCodeCreate == "") {
			$("#divisionCodeCreate").addClass("errorInput");
		}
		if (sectionCodeCreate == null || sectionCodeCreate == "") {
			$("#sectionCodeCreate").addClass("errorInput");
		}
		if (groupCodeCreate == null || groupCodeCreate == "") {
			$("#groupCodeCreate").addClass("errorInput");
		}
		
		return;
	}
}
// 显示中分类列表信息
/*function midGroupSearch() {
	$("#Tools12").attr('class', "Tools12_disable");
	$("#Tools10").attr('class', "Tools10_disable");
	var divisionId = $.trim($("#divisionCode").val());
	var sectionId = $.trim($("#sectionCode").val());
	var groupId = $.trim($("#groupCode").val());
	var catlgNo = $.trim($("#catlgNo").val());
	var catlgName = $.trim($("#catlgName").val());
	var status = $("#status").val();
	if ($("#groupCode").attr("class").indexOf("errorInput") < 1 && $("#catlgNo").attr("class").indexOf("errorInput") < 1 ) {
		$("#dg").datagrid({
			rownumbers : false,
			singleSelect : true,
			pagination : true,
			pageSize : 20,
			url : ctx + '/catalog/midGroupList',
			queryParams : {
				divisionId : divisionId,
				sectionId : sectionId,
				grpNo : groupId,
				catlgNo : catlgNo,
				catlgName : catlgName,
				status:status
			},
			columns : [ [ {
				field : 'ck',
				checkbox : false,
				halign : 'center'
			}, {
				field : 'grpTitle',
				title : '大分类',width : 100,
				//sortable : true,
				halign : 'center',
				formatter : function(val, rec) {
					return rec.grpNo+'-'+rec.grpTitle;
				}
			}, {
				field : 'catlgNo',
				title : '中分类',width : 55,
				sortable : true,
				formatter : function(val, rec){
					return rec.catlgNo + "&nbsp;&nbsp;";
				},
				halign : 'center',
				align : 'right'
			}, {
				field : 'catlgName',
				title : '中文名称',width : 185,
				sortable : true,
				halign : 'center'
			}, {
				field : 'catlgEnName',
				title : '英文名称',width : 390,
				sortable : true,
				halign : 'center'
			}, {
				field : 'status',
				title : '状态',width : 80,
				formatter : function(val, rec) {
					return getDictValue('CL_CATALOG_STATUS',rec.status);
				},
				halign : 'center'
			}, {
				field : 'divTitle',
				title : '处别',width : 90,
				halign : 'center',
				formatter : function(val, rec) {
					return rec.divNo+'-'+rec.divTitle;
				}
			}, {
				field : 'secTitle',
				title : '课别',width : 130,
				halign : 'center',
				formatter : function(val, rec) {
					return rec.secNo+'-'+rec.secTitle;
				}
			}, {
				field : 'createDate',
				title : '创建日期',
				halign : 'center',
				formatter : function(val, rec) {
					return new Date(val).format('yyyy-MM-dd');
				},
				hidden : true
			}, {
				field : 'chngDate',
				title : '修改日期',
				halign : 'center',
				formatter : function(val, rec) {
					return new Date(val).format('yyyy-MM-dd');
				},
				hidden : true
			}, {
				field : 'chngBy',
				title : '修改人',
				halign : 'center',
				hidden : true
			}, {
				field : 'temp',	
				title : ' ',width:24,
				halign : 'center'
			} ] ],
			onClickRow : function(rowIndex, rowData) {
				$("#Tools12").attr('class', "Tools12");
				  關閉刪除中分類功能
				$("#Tools10").attr('class', "Tools10");
				 
				midsizeCode = rowData.catlgId;
				$.ajax({
					type : 'post',
					url : ctx + '/catalog/midsizeMessagesAction',
					dataType : 'json',
					data : {
						midsizeCode : midsizeCode
					},
					success : function(data) {
						viewModelMidBtm.specialGrpCtrl(data.specialGrpCtrlValue);
						viewModelMidBtm.specialGrpCtrlValue(data.specialGrpCtrl);
						viewModelMidBtm.popDms(data.popDms);
						viewModelMidBtm.createDate(new Date($('#dg').datagrid('getSelections')[0].createDate).format('yyyy-MM-dd'));
						viewModelMidBtm.stockCtrl(data.stockCtrlValue);
						viewModelMidBtm.stockCtrlValue(data.stockCtrl);
						viewModelMidBtm.oosTimesDms(data.oosTimesDms);
						viewModelMidBtm.chngDate(new Date($('#dg').datagrid('getSelections')[0].chngDate).format('yyyy-MM-dd'));
						viewModelMidBtm.sellVatNo(data.sellVatNo);
						viewModelMidBtm.sellVat(data.sellVat);
						viewModelMidBtm.idleDays(data.idleDays);
						viewModelMidBtm.chngBy($('#dg').datagrid('getSelections')[0].chngBy);
						viewModelMidBtm.buyVatNo(data.buyVatNo);
						viewModelMidBtm.buyVat(data.buyVat);
					}
				});
			}
		});
	}
}*/

// 创建中分类信息
function createMidsize() {
	openPopupWin(600, 460, '/catalog/midGroupFormAction');
}
// 修改中分类
function midsizeUpdata() {
	if($('#dg').datagrid('getSelections') != 0){
		openPopupWin(600, 460, '/catalog/midsizeUpdataAction');
	}
}

// 提交小分类创建的数据
function saveSub() {
	var code = $.trim($("#code").val());
	var name = $.trim($("#name").val());
	var enName = $.trim($("#enName").val());
	var divisionCodeCreate = $.trim($("#divisionCodeCreate").val());
	var sectionCodeCreate = $.trim($("#sectionCodeCreate").val());
	var groupCodeCreate = $.trim($("#groupCodeCreate").val());
	var midsizeCodeCreate = $.trim($("#midsizeCodeCreate").val());
	var cr_subFrom = $("#cr_subFrom").serialize();
	if (code != "" && name != "" && enName != "" 
		&& divisionCodeCreate != null
		&& divisionCodeCreate != ""
		&& sectionCodeCreate != null
		&& sectionCodeCreate != ""
		&& groupCodeCreate != null
		&& groupCodeCreate != ""
		&& midsizeCodeCreate != null
		&& midsizeCodeCreate != "") {
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/saveSubMessageAction',
			data : cr_subFrom,
			success : function(data) {
				if (data.status=='success') {
					alert("创建成功");
					closePopupWin();
					subGroupSearch();
				} else {
					alert(data.message);
				}
				// closePopupWin();
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
		if (divisionCodeCreate == null || divisionCodeCreate == "") {
			$("#divisionCodeCreate").addClass("errorInput");
		}
		if (sectionCodeCreate == null || sectionCodeCreate == "") {
			$("#sectionCodeCreate").addClass("errorInput");
		}
		if (groupCodeCreate == null || groupCodeCreate == "") {
			$("#groupCodeCreate").addClass("errorInput");
		}
		if (midsizeCodeCreate == null || midsizeCodeCreate == "") {
			$("#midsizeCodeCreate").addClass("errorInput");
		}
		return;
	}
}

// 显示小分类列表信息
function subGroupSearch() {
	$("#Tools10").attr('class', "Tools10_disable");
	$("#Tools12").attr('class', "Tools12_disable");
	var divisionId = $.trim($("#divisionCode").val());
	var sectionId = $.trim($("#sectionCode").val());
	var groupId = $.trim($("#groupCode").val());
	var midsizeId = $.trim($("#midsizeCode").val());
	var catlgNo = $.trim($("#catlgNo").val());
	var catlgName = $.trim($("#catlgName").val());
	var status = $.trim($("#status").val());
	if ($("#groupCode").attr("class").indexOf("errorInput") < 1 && $("#catlgNo").attr("class").indexOf("errorInput") < 1 && $("#midsizeCode").attr("class").indexOf("errorInput") < 1 ) {
		$('#dg').datagrid({
			rownumbers : false,
			singleSelect : true,
			pagination : true,
			pageSize : 20,
			url : ctx + '/catalog/subGroupListAction',
			queryParams : {
				"divisionId" : divisionId,
				"sectionId" : sectionId,
				"grpNo" : groupId,
				"midNo" : midsizeId,
				"catlgNo" : catlgNo,
				"catlgName" : catlgName,
				"status":status
			},
			columns : [ [ {
				field : 'catlgId',
				halign : 'center',
				checkbox : false,
				hidden:true
			}, {
				field : 'grpTitle',
				title : '大分类',
				halign : 'center',width:100,
				formatter : function(val, rec) {
					return rec.grpNo+'-'+rec.grpTitle;
				}
			}, {
				field : 'midTitle',
				title : '中分类',
				halign : 'center',width:100,
				formatter : function(val, rec) {
					return rec.midNo+'-'+rec.midTitle;
				}
			}, {
				field : 'catlgNo',
				title : '小分类',
				halign : 'center',width:55,
				align : 'right',
				formatter : function(val, rec){
					return rec.catlgNo + "&nbsp;&nbsp;";
				},
				sortable : true
			}, {
				field : 'catlgName',
				title : '中文名称',width:180,
				sortable : true,
				halign : 'center'
			}, {
				field : 'catlgEnName',
				title : '英文名称',width:292,
				sortable : true,
				halign : 'center'
			}, {
				field : 'status',
				halign : 'center',width:80,
				formatter : function(val, rec) {
					return getDictValue('CL_CATALOG_STATUS',rec.status);
				},
				title : '状态'
			}, {
				field : 'divTitle',
				halign : 'center',
				title : '处别',width:90,
				formatter : function(val, rec) {
					return rec.divNo+'-'+rec.divTitle;
				}
					
			}, {
				field : 'secTitle',
				halign : 'center',
				title : '课别',width:130,
				formatter : function(val, rec) {
					return rec.secNo+'-'+rec.secTitle;
				}
			}, {
				field : 'createDate',
				title : '创建日期',
				halign : 'center',
				formatter : function(val, rec) {
					return new Date(val).format('yyyy-MM-dd');
				},
				hidden : true
			}, {
				field : 'chngDate',
				title : '修改日期',
				halign : 'center',
				formatter : function(val, rec) {
					return new Date(val).format('yyyy-MM-dd');
				},
				hidden : true
			}, {
				field : 'chngBy',
				title : '修改人',
				halign : 'center',
				hidden : true
			}, {
				field : 'temp',
				title : ' ',width:18,
				halign : 'center'
			} ] ],
			onClickRow : function(rowIndex, rowData) {
				/* 關閉刪除小分類功能
				$("#Tools10").attr('class', "Tools10");
				*/
				$("#Tools12").attr('class', "Tools12");
				subCode = rowData.catlgId;
				viewModelSubBtm.createDate(new Date($('#dg').datagrid('getSelections')[0].createDate).format('yyyy-MM-dd'));
				viewModelSubBtm.chngDate(new Date($('#dg').datagrid('getSelections')[0].chngDate).format('yyyy-MM-dd'));
				viewModelSubBtm.chngBy($('#dg').datagrid('getSelections')[0].chngBy);
	
				//new method for the bno and extra infomation display 
				$.ajax({
					type : 'post',
					url : ctx + '/catalog/subMessageAction',
					dataType : 'json',
					data : {
						subCode : subCode
					},
					success : function(data) {
						//华东
						viewModelSubBtm.hdmktPostn(data.dbSubgrpCtrlVO.mktPostn);
						viewModelSubBtm.hdtrgtNbrB(data.dbSubgrpCtrlVO.trgtNbrB);
						viewModelSubBtm.hdtrgtNbrN(data.dbSubgrpCtrlVO.trgtNbrN);
						viewModelSubBtm.hdtrgtNbrO(data.dbSubgrpCtrlVO.trgtNbrO);
						
						// 华北
						viewModelSubBtm.hbmktPostn(data.hbSubgrpCtrlVO.mktPostn);
						viewModelSubBtm.hbtrgtNbrB(data.hbSubgrpCtrlVO.trgtNbrB);
						viewModelSubBtm.hbtrgtNbrN(data.hbSubgrpCtrlVO.trgtNbrN);
						viewModelSubBtm.hbtrgtNbrO(data.hbSubgrpCtrlVO.trgtNbrO);
						
						//西南
						viewModelSubBtm.xnmktPostn(data.xnSubgrpCtrlVO.mktPostn);
						viewModelSubBtm.xntrgtNbrB(data.xnSubgrpCtrlVO.trgtNbrB);
						viewModelSubBtm.xntrgtNbrN(data.xnSubgrpCtrlVO.trgtNbrN);
						viewModelSubBtm.xntrgtNbrO(data.xnSubgrpCtrlVO.trgtNbrO);
						
						//华南
						viewModelSubBtm.hnmktPostn(data.hnSubgrpCtrlVO.mktPostn);
						viewModelSubBtm.hntrgtNbrB(data.hnSubgrpCtrlVO.trgtNbrB);
						viewModelSubBtm.hntrgtNbrN(data.hnSubgrpCtrlVO.trgtNbrN);
						viewModelSubBtm.hntrgtNbrO(data.hnSubgrpCtrlVO.trgtNbrO);
						
						//东北
						viewModelSubBtm.dbmktPostn(data.dbSubgrpCtrlVO.mktPostn);
						viewModelSubBtm.dbtrgtNbrB(data.dbSubgrpCtrlVO.trgtNbrB);
						viewModelSubBtm.dbtrgtNbrN(data.dbSubgrpCtrlVO.trgtNbrN);
						viewModelSubBtm.dbtrgtNbrO(data.dbSubgrpCtrlVO.trgtNbrO);
						
						//华中
						viewModelSubBtm.hzmktPostn(data.hzSubgrpCtrlVO.mktPostn);
						viewModelSubBtm.hztrgtNbrB(data.hzSubgrpCtrlVO.trgtNbrB);
						viewModelSubBtm.hztrgtNbrN(data.hzSubgrpCtrlVO.trgtNbrN);
						viewModelSubBtm.hztrgtNbrO(data.hzSubgrpCtrlVO.trgtNbrO);
						
						//西北
						viewModelSubBtm.xbmktPostn(data.xbSubgrpCtrlVO.mktPostn);
						viewModelSubBtm.xbtrgtNbrB(data.xbSubgrpCtrlVO.trgtNbrB);
						viewModelSubBtm.xbtrgtNbrN(data.xbSubgrpCtrlVO.trgtNbrN);
						viewModelSubBtm.xbtrgtNbrO(data.xbSubgrpCtrlVO.trgtNbrO);
					}
				});
			}
		});
	}
}
// 创建小分类
function openSubGroup() {
	openPopupWin(600, 340, '/catalog/subGroupFormAction');
//	openPopupWin(800, 514, '/catalog/subGroupFormAction');
}

//弹出修改小分类信息
function subGroupUpdata() {
	if($('#dg').datagrid('getSelections') != 0){
		openPopupWin(600, 340, '/catalog/subUpdataAction');
	}
}
//神州分类目标设定
function showHaseeSeting(){
	showContent(ctx + '/catalog/showHaseeSetingAction', null);
}

//神州分类目标结果
function showHaseeResult(){
	showContent(ctx + '/catalog/showHaseeResultAction', null);
}

//小分类列表显示
function subGroupShow(){
	showContent(ctx + '/catalog/subGroupManagement', null);
}
//显示神舟分类设定列表
function showSubHaseeSetingDatagrid(obj){
	
	if (obj == "allHaseeSetting") {
	    $('#dg').datagrid({
	        rownumbers: false,
	        singleSelect: true,
	        pagination: true,
	        pageSize: 20,
	        url: /*ctx + '/catalog/showSubHaseeDatagridAction'*/'',
	        columns: [[
	        { field: 'ck', checkbox: false, width: 30 },
	        { field: 'regnTitle', title: '区域', halign : 'center', width: 80},
	        { field: 'divTitle', title: '处别', halign : 'center', width: 115},
	        { field: 'secTitle', title: '课别', halign : 'center', width: 120},
	        { field: 'grpTitle', title: '大分类', sortable: true, halign : 'center', width: 130},
	        { field: 'midTitle', title: '中分类', sortable: true, halign : 'center', width: 130},
	        { field: 'catlgName', title: '小分类', sortable: true, halign : 'center', width: 100},
	        { field: 'trgtNbrB', title: 'B', halign : 'center', width: 70 },
	        { field: 'trgtNbrN', title: 'N', halign : 'center', width: 70 },
	        { field: 'trgtNbrO', title: 'O', halign : 'center', width: 70 },
	        { field: 'temp', title: '', halign : 'center', width: 18 }
	        ]]
	    });
	} else {
		
		if ($("#groupCode").attr("class").indexOf("errorInput") < 1 && $("#catlgNo").attr("class").indexOf("errorInput") < 1 && $("#midsizeCode").attr("class").indexOf("errorInput") < 1 ) {
		    $('#dg').datagrid({
		        rownumbers: false,	
		        singleSelect: true,
		        pagination: true,
		        pageSize: 20,
		        url: ctx + '/catalog/showSubHaseeDatagridAction',
		        queryParams : {
		        	divNo : $("#divisionCode").combobox('getValue') == "请选择" ? "" : $("#divisionCode").combobox('getValue'),
		        	secNo : $("#sectionCode").combobox('getValue') == "请选择" ? "" : $("#sectionCode").combobox('getValue'),
		        	grpNo : $("#groupCode").val(),
		        	midNo : $("#midsizeCode").val(),
		        	subNo : $("#catlgNo").val(),
		        	mktPostN : $("#location").val(),
		        	regnNo : $("#area").val()
		        },
		        columns: [[
		        { field: 'ck', checkbox: false, width: 30 },
		        { field: 'regnTitle', title: '区域', halign : 'center', width: 65,formatter : function(val, rec) {return rec.regnNo+'-'+rec.regnName;}},
		        { field: 'divTitle', title: '处别', halign : 'center',width: 116,formatter : function(val, rec) {return rec.divNo+'-'+rec.divTitle;}},
		        { field: 'secTitle', title: '课别', halign : 'center',width: 173,formatter : function(val, rec) {return rec.secNo+'-'+rec.secTitle;}},
		        { field: 'grpTitle', title: '大分类', sortable: true, halign : 'center',width: 173,formatter : function(val, rec) {return rec.grpNo+'-'+rec.grpTitle;}},
		        { field: 'midTitle', title: '中分类', sortable: true, halign : 'center',width: 173,formatter : function(val, rec) {return rec.midNo+'-'+rec.midTitle;}},
		        { field: 'catlgName', title: '小分类', sortable: true, halign : 'center', width: 173,formatter : function(val, rec) {return rec.catlgNo+'-'+rec.catlgTitle;}},
		        { field: 'trgtNbrB', title: 'B', halign : 'center',width: 51 },
		        { field: 'trgtNbrN', title: 'N', halign : 'center',width: 52 },
		        { field: 'trgtNbrO', title: 'O', halign : 'center',width: 52 },
		        { field: 'temp', title: '', halign : 'center',width: 18 }
		        ]]
		    });
		}
	}
}
//清除神舟分类设定列表
function clearHaseeSetting(){
	positioningShow();
	division_Select();
	section_Select(null);
	$("#groupCode").val('').removeClass("errorInput");
	$("#midsizeCode").val('').removeClass("errorInput");
	$("#catlgNo").val('').removeClass("errorInput");
}
//清除神舟分类结果列表
function clearHaseeResult(){
	areaShow();
	division_Select();
	section_Select(null);
	storeNoSelect();
	$("#groupCode").val('').removeClass("errorInput");
	$("#midsizeCode").val('').removeClass("errorInput");
	$("#catlgNo").val('').removeClass("errorInput");
}

//区域select下拉框
function areaSettingShow(){
	var websites = [{
        "id": 1,
        "text": "华北"
    }, {
        "id": 2,
        "text": "华东"
    }, {
        "id": 3,
        "text": "华南"
    }, {
        "id": 4,
        "text": "西南"
    }, {
        "id": 5,
        "text": "东北"
    }, {
        "id": 6,
        "text": "华中"
    }, {
        "id": 7,
        "text": "西北"
    }];
	$("#areaAuto").autocomplete(websites,{
		minChars: 0,
		max: 8,
		autoFill: false,
		matchContains: true,
		matchCase : false,// 不区分大小写
		scrollHeight: 220,
		dataType : 'json',
		formatItem : function(row, i, max) {
			return row.id + "-" + row.text;
		},
		formatMatch : function(row, i, max) {
			return row.id + "-" + row.text;
		},
		formatResult : function(row) {
			return row.id + "-" + row.text;
		}
	}).result(function(event, data, formatted){
		$(this).val(data.id + "-" + data.text);
		$("#area").attr("value", data.id);
		showSubHaseeSetingDatagrid('search');
	});
	
/*  $('#area').combobox({
      width: 100,
      readonly: false,
      data: [{
          "id": 1,
          "text": "1-华北"
      }, {
          "id": 2,
          "text": "2-华东"
      }, {
          "id": 3,
          "text": "3-华南"
      }, {
          "id": 4,
          "text": "4-西南"
      }, {
          "id": 5,
          "text": "5-东北"
      }, {
          "id": 6,
          "text": "6-华中"
      }, {
          "id": 7,
          "text": "7-西北"
      }],
      valueField: 'id',
      textField: 'text',
      onSelect: function (rec) {
    	  showSubHaseeSetingDatagrid('search');
      }
  });
  $("#area").combobox("setValue","请选择");*/
}
//区域select下拉框
function areaShow(){
    $('#area').combobox({
        width: 100,
        readonly: false,
        data: [{
            "id": 1,
            "text": "1-华北"
        }, {
            "id": 2,
            "text": "2-华东"
        }, {
            "id": 3,
            "text": "3-华南"
        }, {
            "id": 4,
            "text": "4-西南"
        }, {
            "id": 5,
            "text": "5-东北"
        }, {
            "id": 6,
            "text": "6-华中"
        }, {
            "id": 7,
            "text": "7-西北"
        }],
        valueField: 'id',
        textField: 'text',
        onSelect: function (rec) {
            //alert(rec.id + "....." + rec.text);
        }
    });
    $("#area").combobox("setValue","请选择");
}
//定位select下拉框
function positioningShow(){
    $('#location').combobox({
        //url: 'combobox_data.json',
        width: 137,
        readonly: false,
        data: [{
            "id": "B",
            "text": "B"
        }, {
            "id": "N",
            "text": "N"
        }, {
            "id": "O",
            "text": "O"
        }],
        valueField: 'id',
        textField: 'text',
        onSelect: function (rec) {
            //alert(rec.id + "....." + rec.text);
        }
    });
    $("#location").combobox("setValue","请选择");
}
//店号select下拉框
function storeNoSelect(){
		$.ajax({
			type : "post",
			url : ctx + "/catalog/storeShowGroupAction",
			success : function(data){
			    $("#storeNo").combobox({
			        //url: 'combobox_data.json',
			        width: 137,
			        readonly: false,
			        data: data,
			        valueField: 'storeNo',
			        textField: 'storeName',
					formatter : function(row){
						return row.storeNo + "-" + row.storeName;
					},
			        onSelect: function (rec) {
			            $("#storeNo").combobox("setText",rec.storeNo + "-" + rec.storeName);
			        }
			    });
			    $("#storeNo").combobox("setValue","请选择");
			}
		});
}
//显示神舟分类结果列表
function showSubHaseeResultDatagrid(obj){
	if (obj == "allHaseeResult") {
	    $('#dg').datagrid({
	        rownumbers: false,
	        singleSelect: true,
	        pagination: true,
	        pageSize: 20,
	        url: ctx + '/catalog/showHaseeResultDatagridAction',
	        queryParams : {
	        	resultObj : obj
	        },
	        columns : [ [{field : 'storeNo',title : '分店', halign : 'center', width : 40}, 
	  					{field : 'storeName',title : '分店名称', halign : 'center', width : 70}, 
	  					{field : 'divTitle',title : '处别', halign : 'center', width : 100}, 
	  					{field : 'secTitle',title : '课别', halign : 'center', width : 110}, 
	  					{field : 'grpTitle',title : '大分类',sortable : true, halign : 'center', width : 130}, 
	  					{field : 'midTitle',title : '中分类',sortable : true, halign : 'center', width : 130}, 
	  					{field : 'catlgName',title : '小分类',sortable : true, halign : 'center', width : 110}, 
	  					{field : 'mktPostN',title : '定位', halign : 'center', width : 40}, 
	  					{field : 'trgtNbrB',title : 'B', halign : 'center', width : 40}, 
	  					{field : 'realNbrB',title : '实际', halign : 'center', width : 40}, 
	  					{field : 'trgtNbrN',title : 'N', halign : 'center', width : 40}, 
	  					{field : 'realNrbN',title : '实际', halign : 'center', width : 40}, 
	  					{field : 'trgtNbrO',title : 'O', halign : 'center', width : 40}, 
	  					{field : 'realNbrO',title : '实际', halign : 'center', width : 40}, 
	  					{field : 'exceed',title : '超出', halign : 'center', width : 40}, 
	  					{field : 'temp',title : '', halign : 'center', width : 18
	  				} ] ]
	    });
	} else {
		if ($("#groupCode").attr("class").indexOf("errorInput") < 1 && $("#catlgNo").attr("class").indexOf("errorInput") < 1 && $("#midsizeCode").attr("class").indexOf("errorInput") < 1 ) {
		    $('#dg').datagrid({
		        rownumbers: false,
		        singleSelect: true,
		        pagination: true,
		        pageSize: 20,
		        url: ctx + '/catalog/showHaseeResultDatagridAction',
		        queryParams : {
		        	storeNo : $("#storeNo").combobox('getValue') == "请选择" ? "" : $("#storeNo").combobox('getValue'),
		        	divNo : $("#divisionCode").combobox('getValue') == "请选择" ? "" : $("#divisionCode").combobox('getValue'),
		        	secNo : $("#sectionCode").combobox('getValue') == "请选择" ? "" : $("#sectionCode").combobox('getValue'),
		        	grpNo : $.trim($("#groupCode").val()),
		        	midNo : $.trim($("#midsizeCode").val()),
		        	catlgNo : $.trim($("#catlgNo").val())
		        	//regnNo : $("#area").combobox('getValue') == "请选择" ? "" : $("#area").combobox('getValue')
		        	/*,
		        	trgtNbrN : $("#trgtNbrN").val(),
		        	trgtNbrO : $("#trgtNbrO").val(),
		        	beyondExpectaion : $("#beyondExpectaion").val()*/
		        },
		        columns : [ [ 
		           {field : 'catlgId',checkbox : false,width : 30,hidden : true}, 
					{field : 'storeNo',title : '分店',halign : 'center', width : 40}, 
					{field : 'storeName',title : '分店名字',halign : 'center', width : 70}, 
					{field : 'divTitle',title : '处别',halign : 'center', width : 102,formatter : function(val, rec) {
							return rec.divNo + '-' + rec.divTitle;
					}}, 
					{field : 'secTitle',title : '课别',halign : 'center', width : 114,formatter : function(val, rec) {
							return rec.secNo + '-' + rec.secTitle;}
					}, 
					{field : 'grpTitle',title : '大分类',sortable : true,halign : 'center', width : 135,
						formatter : function(val, rec) {
							return rec.grpNo + '-' + rec.grpTitle;
						}
					}, 
					{field : 'midTitle',title : '中分类',sortable : true,halign : 'center', width : 135,
						formatter : function(val, rec) {
							return rec.midNo + '-' + rec.midTitle;
						}
					}, 
					{field : 'catlgName',title : '小分类',sortable : true,halign : 'center', width : 113,
						formatter : function(val, rec) {
							return rec.catlgNo + '-' + rec.catlgTitle;
						}
					}, 
					{field : 'mktPostN',title : '定位',halign : 'center', width : 40}, 
					{field : 'trgtNbrB',title : 'B',halign : 'center', width : 40,
						formatter : function(val, rec) {
							if (rec.realNbrB > rec.trgtNbrB) {
								return '<div style="color:red">'+rec.trgtNbrB+'</div>';
							} else {
								return rec.trgtNbrB;
							}
						}
					}, 
					{field : 'realNbrB',title : '实际',halign : 'center', width : 39,
						formatter : function(val, rec) {
							if (rec.realNbrB > rec.trgtNbrB) {
								return '<div style="color:red">'+rec.realNbrB+'</div>';
							} else {
								return rec.realNbrB;
							}
						}
					}, 
					{field : 'trgtNbrN',title : 'N',halign : 'center', width : 40,
						formatter : function(val, rec) {
							if (rec.realNrbN > rec.trgtNbrN) {
								return '<div style="color:red">'+rec.trgtNbrN+'</div>';
							} else {
								return rec.trgtNbrN;
							}
						}
					}, 
					{field : 'realNrbN',title : '实际',halign : 'center', width : 39,
						formatter : function(val, rec) {
							if (rec.realNrbN > rec.trgtNbrN) {
								return '<div style="color:red">'+rec.realNrbN+'</div>';
							} else {
								return rec.realNrbN;
							}
						}
					}, 
					{field : 'trgtNbrO',title : 'O',halign : 'center', width : 40,
						formatter : function(val, rec) {
							if (rec.realNbrO > rec.trgtNbrO) {
								return '<div style="color:red">'+rec.trgtNbrO+'</div>';
							} else {
								return rec.trgtNbrO;
							}
						}
					}, 
					{field : 'realNbrO',title : '实际',halign : 'center', width : 36,
						formatter : function(val, rec) {
							if (rec.realNbrO > rec.trgtNbrO) {
								return '<div style="color:red">'+rec.realNbrO+'</div>';
							} else {
								return rec.realNbrO;
							}
						}
					}, 
					{field : 'exceed',title : '超出',halign : 'center', width : 40,
  						formatter : function(val, rec) {
  							if (rec.exceed == 'Y') {
  								return '<div style="color:red">'+rec.exceed+'</div>';
  							} else {
  								return rec.exceed;
  							}
  						}}, 
					{field : 'temp',title : '',width : 18
				} ] ]
		    });
		}
	}
}
//
function beyondExpectaion(){
	var websites = [{
        "id": 1,
        "text": "华北"
    }, {
        "id": 2,
        "text": "华东"
    }, {
        "id": 3,
        "text": "华南"
    }, {
        "id": 4,
        "text": "西南"
    }, {
        "id": 5,
        "text": "东北"
    }, {
        "id": 6,
        "text": "华中"
    }, {
        "id": 7,
        "text": "西北"
    }];
	$("#beyondExpectaion").autocomplete(websites,{
		minChars: 0,
		max: 5,
		autoFill: true,
		mustMatch: true,
		matchContains: true,
		scrollHeight: 220,
		dataType : 'json',
		formatItem : function(row, i, max) {
			
			return row.id + "-" + row.text;
		},
		formatMatch : function(row, i, max) {
			
			return row.id + "-" + row.text;
		},
		formatResult : function(row) {
			
			return row.id + "-" + row.text;
		}
	});
/*    $('#beyondExpectaion').combobox({
        //url: 'combobox_data.json',
        width: 100,
        readonly: false,
        data: [{
            "id": 1,
            "text": "1-华北"
        }, {
            "id": 2,
            "text": "2-华东"
        }, {
            "id": 3,
            "text": "3-华南"
        }, {
            "id": 4,
            "text": "4-西南"
        }, {
            "id": 5,
            "text": "5-东北"
        }, {
            "id": 6,
            "text": "6-华中"
        }, {
            "id": 7,
            "text": "7-西北"
        }],
        valueField: 'id',
        textField: 'text',
        onSelect: function (rec) {
            //alert(rec.id + "....." + rec.text);
        }
    });*/
}
//
function showGroupMess(){
	showContent(ctx+'/catalog/subGroupListAction');
}
//小分类清除检索参数
function subClearParames(){
	$('#divisionCode option:first-child').attr('selected', 'selected');
	$('#status option:first-child').attr('selected','selected');

	$("#sectionCode").empty();
	$("#groupCode").empty();
	$("#midsizeCode").empty();
	$("input").val('').removeClass("errorInput");
	
	$("#sectionCode").attr("disabled", "true");
	$("#groupCode select").attr("disabled", "true");
	$("select[id='groupCode']").attr("disabled","disabled");
}
// 初始大分類的額外訊息
function ViewModelBtm(){
	var self = this;
	self.createDate = ko.observable();
	self.chngDate = ko.observable();
	self.chngBy = ko.observable();
	self.m3DepreRate = ko.observable(); 
	self.m6DepreRate = ko.observable(); 
	self.m12DepreRate = ko.observable(); 
}

// 修改大分类信息
function ViewModel() {
	var self = this;
	self.catlgId = ko.observable($('#dg').datagrid('getSelections')[0].catlgId);
	self.catlgNo = ko.observable($('#dg').datagrid('getSelections')[0].catlgNo);
	self.catlgName = ko.observable($('#dg').datagrid('getSelections')[0].catlgName).extend({
		required : {
			params : true,
			message : "请输入中文名称"
		}
	});
	self.catlgEnName = ko.observable($('#dg').datagrid('getSelections')[0].catlgEnName).extend({
		required : {
			params : true,
			message : "请输入英文名称"
		}
	});
	self.divisionId = ko.observable($('#dg').datagrid('getSelections')[0].divId + "- " + $('#dg').datagrid('getSelections')[0].divTitle);
	self.sectionId = ko.observable($('#dg').datagrid('getSelections')[0].secId + "- " + $('#dg').datagrid('getSelections')[0].secTitle);

	self.statusName = [ {
		name : "1-正常",
		value : 1
	}, {
		name : "9-删除",
		value : 9
	}
	];
	self.status = ko.observable($('#dg').datagrid('getSelections')[0].status);
	self.save_updat = function() {
		// 验证表单
		viewModel.errors = ko.validation.group(viewModel);
		if (!viewModel.isValid()) {
			viewModel.errors.showAllMessages();
			return;
		}
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/saveGroupUpdataAction',
			data : {
				divisionId : $('#dg').datagrid('getSelections')[0].divNo,
				sectionId : $('#dg').datagrid('getSelections')[0].secNo,
				id : self.catlgId(),
				name : self.catlgName(),
				enName : self.catlgEnName(),
				status : self.status()
			},
			success : function(data) {
				if (data) {
					//alert("修改成功");
					top.jAlert('success', window.v_operationSuc, window.v_messages);
					closePopupWin();
					//groupSearch();
					var dg = $('#dg');
					var row = dg.datagrid('getSelected');
					if (row){
						var index = dg.datagrid('getRowIndex', row);
						dg.datagrid('updateRow',{
							index:index,
							row:{catlgName:self.catlgName(),catlgEnName:self.catlgEnName(),status:self.status()}
						});
						dg.datagrid('selectRow',index);
					}
				} else {
					top.jAlert('error', window.v_operationFail,window.v_messages);
				}
			}
		});
	};
}

//修改中分类信息

function ParamaterGroup() {
	this.groupName = null;
	this.groupenName = null;
	this.statuValue = null;
}

//初始中分類的額外訊息
function ViewModelMidBtm(){
	var self = this;
	self.specialGrpCtrl = ko.observable();
	self.specialGrpCtrlValue = ko.observable();
	self.popDms = ko.observable();
	self.createDate = ko.observable();
	self.stockCtrl = ko.observable();
	self.stockCtrlValue = ko.observable();
	self.oosTimesDms = ko.observable();
	self.chngDate = ko.observable();
	self.idleDays = ko.observable();
	self.chngBy = ko.observable();
	self.buyVat = ko.observable();
	self.buyVatNo = ko.observable();
	self.sellVat = ko.observable();
	self.sellVatNo = ko.observable();
}

// 修改中分类信息
function ViewModelMid() {
	var self = this;
	self.catlgId = ko.observable($('#dg').datagrid('getSelections')[0].catlgId);
	self.catlgNo = ko.observable($('#dg').datagrid('getSelections')[0].catlgNo);
	self.catlgName = ko.observable($('#dg').datagrid('getSelections')[0].catlgName).extend({
		required : {
			params : true,
			message : "请输入中文名称"
		}
	});
	self.catlgEnName = ko.observable($('#dg').datagrid('getSelections')[0].catlgEnName).extend({
		required : {
			params : true,
			message : "请输入英文名称"
		}
	});
	self.divisionId = ko.observable($('#dg').datagrid('getSelections')[0].divId + "- " + $('#dg').datagrid('getSelections')[0].divTitle);
	self.sectionId = ko.observable($('#dg').datagrid('getSelections')[0].secId + "- " + $('#dg').datagrid('getSelections')[0].secTitle);
	self.groupId = ko.observable($('#dg').datagrid('getSelections')[0].grpNo + "- " + $('#dg').datagrid('getSelections')[0].grpTitle);

	self.statusName = [ {
		name : "1-正常",
		value : 1
	}, {
		name : "9-删除",
		value : 9
	} ];
	self.status = ko.observable($('#dg').datagrid('getSelections')[0].status);
	self.specialGrpCtrlShow = [ {
		name : "请选择",
		value : null
	},{
		name : "1-本地控管",
		value : 1
	}, {
		name : "2-原物料",
		value : 2
	}, {
		name : "3-包材",
		value : 3
	}, {
		name : "4-进口商品",
		value : 4
	} ];
	self.specialGrpCtrl = ko.observable(viewModelMidBtm.specialGrpCtrlValue());

	self.stockCtrlShow = [ {
		name : "0-部门管理",
		value : 0
	}, {
		name : "1-单品管理",
		value : 1
	}, {
		name : "2-生鲜面销",
		value : 2
	} ];
	self.stockCtrl = ko.observable(viewModelMidBtm.stockCtrlValue());

	self.popDms = ko.observable(viewModelMidBtm.popDms());
	self.oosTimesDms = ko.observable(viewModelMidBtm.oosTimesDms());
	self.idleDays = ko.observable(viewModelMidBtm.idleDays());
	
	self.save_updat = function() {
		// 验证表单
		viewModel.errors = ko.validation.group(viewModel);
		if (!viewModel.isValid()) {
			viewModel.errors.showAllMessages();
			return;
		}
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/saveMidsizeUpdataAction',
			data : {
				divisionId : $('#dg').datagrid('getSelections')[0].divId,
				sectionId : $('#dg').datagrid('getSelections')[0].secId,			
				groupId : $('#dg').datagrid('getSelections')[0].grpId,
				id : self.catlgId(),
				code : self.catlgNo(),
				name : self.catlgName(),
				enName : self.catlgEnName(),
				status : self.status(),
				specialGrpCtrl : self.specialGrpCtrl() == null ? "" : self.specialGrpCtrl(),
				stockCtrl : self.stockCtrl(),
				popDms : self.popDms() == null ? "" : self.popDms(),
				oosTimesDms : self.oosTimesDms() == null ? "" : self.oosTimesDms(),
				IdleDays : self.idleDays() == null ? "" : self.idleDays(),
				buyVat : $.trim(viewModelMidBtm.buyVat()),
				buyVatNo : $.trim(viewModelMidBtm.buyVatNo()),
				sellVat : $.trim(viewModelMidBtm.sellVat()),
				sellVatNo : $.trim(viewModelMidBtm.sellVatNo())
			},
			success : function(data) {
				if (data.status) {
					alert(data.message);
					closePopupWin();
					//midGroupSearch();
					var dg = $('#dg');
					var row = dg.datagrid('getSelected');
					if (row){
						var index = dg.datagrid('getRowIndex', row);
						dg.datagrid('updateRow',{
							index:index,
							row:{catlgName:self.catlgName(),catlgEnName:self.catlgEnName(),status:self.status()}
						});
						dg.datagrid('selectRow',index);
					}
				} else {
					alert(data.message);
				}
			}
		});
	};

}

// 初始化小分類的額外訊息
function ViewModelSubBtm(){
	var self = this;
	self.createDate = ko.observable();
	self.chngDate = ko.observable();
	self.chngBy = ko.observable();
	
	// 华东
	self.hdmktPostn = ko.observable();
	self.hdtrgtNbrB = ko.observable();
	self.hdtrgtNbrN = ko.observable();
	self.hdtrgtNbrO = ko.observable();
	
	// 华北
	self.hbmktPostn = ko.observable();
	self.hbtrgtNbrB = ko.observable();
	self.hbtrgtNbrN = ko.observable();
	self.hbtrgtNbrO = ko.observable();
	
	//西南
	self.xnmktPostn = ko.observable();
	self.xntrgtNbrB = ko.observable();
	self.xntrgtNbrN = ko.observable();
	self.xntrgtNbrO = ko.observable();
	
	//华南
	self.hnmktPostn = ko.observable();
	self.hntrgtNbrB = ko.observable();
	self.hntrgtNbrN = ko.observable();
	self.hntrgtNbrO = ko.observable();
	
	//东北
	self.dbmktPostn = ko.observable();
	self.dbtrgtNbrB = ko.observable();
	self.dbtrgtNbrN = ko.observable();
	self.dbtrgtNbrO = ko.observable();
	
	//华中
	self.hzmktPostn = ko.observable();
	self.hztrgtNbrB = ko.observable();
	self.hztrgtNbrN = ko.observable();
	self.hztrgtNbrO = ko.observable();
	
	//西北
	self.xbmktPostn = ko.observable();
	self.xbtrgtNbrB = ko.observable();
	self.xbtrgtNbrN = ko.observable();
	self.xbtrgtNbrO = ko.observable();
}

// 修改小分类信息
function ViewModelSub() {
	var self = this;
	self.catlgId = (ko.observable($('#dg').datagrid('getSelections')[0].catlgId));
	self.catlgNo = ko.observable($('#dg').datagrid('getSelections')[0].catlgNo);
	self.catlgName = ko.observable($('#dg').datagrid('getSelections')[0].catlgName).extend({
		required : {
			params : true,
			message : "请输入中文名称"
		}
	});
	self.catlgEnName = ko.observable($('#dg').datagrid('getSelections')[0].catlgEnName).extend({
		required : {
			params : true,
			message : "请输入英文名称"
		}
	});
	self.divisionId = ko.observable($('#dg').datagrid('getSelections')[0].divId + "-" + $('#dg').datagrid('getSelections')[0].divTitle);
	self.sectionId = ko.observable($('#dg').datagrid('getSelections')[0].secId + "-" + $('#dg').datagrid('getSelections')[0].secTitle);
	self.groupId = ko.observable($('#dg').datagrid('getSelections')[0].grpNo + "-" + $('#dg').datagrid('getSelections')[0].grpTitle);
	self.subGroupId = ko.observable($('#dg').datagrid('getSelections')[0].midNo + "-" + $('#dg').datagrid('getSelections')[0].midTitle);
	self.statusName = [ {
		name : "1-正常",
		value : 1
	}, {
		name : "9-删除",
		value : 9
	}, 
	/*
	{
		name : "0-尚未生效",
		value : 0
	}
	*/
	];
	self.status = ko.observable($('#dg').datagrid('getSelections')[0].status);
	self.save_updataSub = function() {
		// 验证表单
		viewModel.errors = ko.validation.group(viewModel);
		if (!viewModel.isValid()) {
			viewModel.errors.showAllMessages();
			return;
		}
		$.ajax({
			type : 'post',
			url : ctx + '/catalog/saveSubUpdataAction',
			data : {
				id : self.catlgId(),
				name : self.catlgName(),
				enName : self.catlgEnName(),
				status : self.status()
			},
			success : function(data) {
				if (data) {
					alert("修改成功");
					closePopupWin();
					//subGroupSearch();
					var dg = $('#dg');
					var row = dg.datagrid('getSelected');
					if (row){
						var index = dg.datagrid('getRowIndex', row);
						dg.datagrid('updateRow',{
							index:index,
							row:{catlgName:self.catlgName(),catlgEnName:self.catlgEnName(),status:self.status()}
						});
						dg.datagrid('selectRow',index);
					}
				} else {
					alert("修改失败");
				}
			}
		});
	};

}

function ParamaterSub() {
	this.subName = null;
	this.subenName = null;
	this.statuValue = null;
}
