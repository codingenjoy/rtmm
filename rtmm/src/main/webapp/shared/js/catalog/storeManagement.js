var storeNum = null;

//只输入数字
function IsNum(){
       return ((event.keyCode >= 48) && (event.keyCode <= 57)); 
} 
//邮箱验证
function isEmail(obj){
	 var search_str = new RegExp(/^[\w-]+([\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/);
	 if(search_str.test(obj)){
		 return true;
	 } else {
		 return false;
	 }
}
//电话验证
function isTelephone(obj){
	 var search_str = new RegExp(/^[0-9]{3,4}-[0-9]{7,8}$/);
	 if(search_str.test(obj)){
		 return true;
	 } else {
		 return false;
	 }
}
//邮编验证
function ispostCode(obj){
	var search_str = new RegExp(/^[0-9]{5,6}$/);
	if (obj.value != "") {
		if(!search_str.test($.trim(obj.value))){
			$("#"+obj.id).addClass("errorInput");
		}
	}
}
//手机验证
function ismoblNo(obj){
	var search_str = new RegExp(/^[0-9]{9,11}$/);
	if (obj.value != "") {
		if(!search_str.test($.trim(obj.value))){
			$("#"+obj.id).addClass("errorInput");
		}
	}
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
//数字验证3-4位数
function three_four(obj){
	var search_str = new RegExp(/^[0-9]{3,4}$/);
	if (obj.value != "") {
		if(!search_str.test($.trim(obj.value))){
			$("#"+obj.id).addClass("errorInput");
		}
	}
}
//数字验证7-8位数
function seven_eight(obj){
	var search_str = new RegExp(/^[0-9]{7,8}$/);
	if (obj.value != "") {
		if(!search_str.test($.trim(obj.value))){
			$("#"+obj.id).addClass("errorInput");
		}
	}
}
function deleteStyles(){
	$("#areaFaxNo").removeClass("errorInput");
	$("#areaPhoneNo").removeClass("errorInput");
}
function areaNoCheck(obj){
	var areaPhoneNo = $.trim($("#areaPhoneNo").val());
	var areaFaxNo = $.trim($("#areaFaxNo").val());
	
	var search_str = new RegExp(/^[0-9]{3,4}$/);
	if (obj.value != "") {
		if(!search_str.test($.trim(obj.value))){
			$("#"+obj.id).addClass("errorInput");
		}
	}
	if (areaPhoneNo != areaFaxNo) {
		$("#areaFaxNo").addClass("errorInput");
		$("#areaPhoneNo").addClass("errorInput");
		$("#areaPhoneNo").attr("title","区号不一致");
		$("#areaFaxNo").attr("title","区号不一致");
	} else {
		$("#areaPhoneNo").attr("title","请输入区号（3-4位）");
		$("#areaFaxNo").attr("title","请输入区号（3-4位）");
		$("#areaFaxNo").removeClass("errorInput");
		$("#areaPhoneNo").removeClass("errorInput");
	}
}
//删除样式
function deleteStyle(obj){
	$("#"+obj.id).removeClass("errorInput");
}

function judgeAgreed(){
	var areaPhoneNo = $.trim($("input[name='areaPhoneNo']").val());
	var areaFaxNo = $.trim($("input[name='areaFaxNo']").val());
	if (areaPhoneNo != areaFaxNo) {
		$("input[name='areaPhoneNo']").addClass("errorInput");
		$("input[name='areaFaxNo']").addClass("errorInput");
		$("input[name='areaPhoneNo']").attr("title","区号不一致");
		$("input[name='areaFaxNo']").attr("title","区号不一致");
	} 
}
function unjudgeAgreed(){
	$("input[name='areaPhoneNo']").removeClass("errorInput");
	$("input[name='areaFaxNo']").removeClass("errorInput");
	$("input[name='areaPhoneNo']").attr("title","");
	$("input[name='areaFaxNo']").attr("title","");
}
function unjudgeAgreed1(){
	$("input[name='areaPhoneNo']").removeClass("errorInput");
	$("input[name='areaFaxNo']").removeClass("errorInput");
	$("input[name='areaPhoneNo']").attr("title","");
	$("input[name='areaFaxNo']").attr("title","");
}
function emailAddrOnfocus(){
	$("#emailAddr").removeClass("errorInput");
}
function cwhseNoOnfocus() {
	$("#cwhseNo").removeClass("errorInput");
}
function whseNameNoOnfocus() {
	$("#whseName").removeClass("errorInput");
}
function detllAddrNoOnfocus() {
	$("#detllAddr").removeClass("errorInput");
}
function postCodeNoOnfocus() {
	$("#cr_postCode").removeClass("errorInput");
}
function moblNoNoOnfocus() {
	$("#moblNo").removeClass("errorInput");
}
function phoneNoOnfocus() {
	$("#cr_phoneNo").removeClass("errorInput");
}
function faxNoOnfocus() {
	$("#cr_faxNo").removeClass("errorInput");
}
function emailAddrOnfocus() {
	$("#emailAddr").removeClass("errorInput");
}
// 分店列表
function storeSearch(obj) {
	var storeNo = $.trim($("#storeNo").val());
	var storeName = $.trim($("#storeName").val());
	var status = $.trim($("#status").val());
	var bizType = $.trim($("#bizType").val());
	var lvlNo = $.trim($("#lvlNo").val());
	var openDate = $.trim($("#openDate").val());
	var comNo = $.trim($("#companyCode").val());
	var regnNo = $.trim($("#regnNo").val());
	var cityId = $.trim($("#cityId").val());
	if ($("#storeNo").attr("class").indexOf("errorInput") < 1) {
		$("#dg").datagrid( {
			rownumbers : false,
			singleSelect : true,
			pagination : true,
			pageSize : 20,
			url : ctx + '/catalog/catalogStoreListAction',
			queryParams : {
				storeNo:storeNo,
				storeName:storeName,
				status:status,
				lvlNo:lvlNo,
				bizType:bizType,
				openDate:openDate,
				comNo:comNo,
				regnNo:regnNo,
				cityId:cityId,
				storeFlag:obj
			},
			columns : [ [ {
				field : 'ck',
				checkbox : false,width : 60,
				halign : 'center'
			}, {
				field : 'storeNo',
				title : '分店店号',width : 60,
				sortable : true,
				align : 'right',
				formatter : function(val, rec){
					return rec.storeNo + "&nbsp;&nbsp;";
				},
				halign : 'center'
			}, {
				field : 'storeName',
				title : '分店名称',width : 100,
				sortable : true,
				halign : 'center'
			}, {
				field : 'statusTitle',
				title : '分店状态',width : 70,
				halign : 'center'
			}, {
				field : 'lvlTiltle',
				title : '分店等级',width : 70,
				halign : 'center'
			}, {
				field : 'comTitle',
				title : '公司',width : 445,
				halign : 'center'
			}, {
				field : 'openDate',
				title : '开业时间',width : 102,
				halign : 'center',
				formatter : function(val, rec) {
					return new Date(val).format('yyyy-MM-dd');
				}
			}, {
				field : 'bizTitle',
				title : '分店业态',width : 100,
				halign : 'center'
			}, {
				field : 'regnName',
				title : '区域/城市',width : 80,
				halign : 'center'
			}, {
				field : 'temp',
				title : ' ',width:18,
				halign : 'center'
			} ] ],
			onClickRow : function(rowIndex, rowData) {
				$("#selectRowNo").val(rowIndex + 1);
				storeNum = rowData.storeNo;
				$("#Tools22").attr('class', "Icon-size1 Tools22");
				$("#Tools21").attr('class', "Icon-size1 Tools21_on");
				$("#Tools21").parent().addClass("ToolsBg");
			},
			onDblClickRow : function(rowIndex, rowData){
				$("#selectRowNo").val(rowIndex + 1);
				$("#pageNo").val($('.pagination-num')[0].value);
				$("#rowNo").val($(".pagination-page-list").val());
				countPage();
				storeDetailed();
			}
		});
	}
}

// 分店详细信息
function storeDetailed() {
	var sd = $('#dg').datagrid('getSelected');
	if (sd == null || sd.length == "") {
		return;
	} else {
		$.ajax( {
			type : 'post',
			url : ctx + '/catalog/storeDetailedAction',
			dataType : "html",
			data : {
			storeNum : storeNum,
			pageNos : $("#currentRow").val()
		},
		success : function(data) {
			
			$("#Tools22").attr('class', "Icon-size1 Tools22_on");
			$("#Tools21").attr('class', "Icon-size1 Tools21");
			
			$($("#Tools22").parent()).addClass("ToolsBg");
			$($("#Tools21").parent()).removeClass("ToolsBg");
			
			if (storeNum == "") {
				
			}
			$("#Tools1").attr('class', "Icon-size1 Tools1_disable").unbind('click');
			$("#storeDetailed").show();
			$("#storeDetailed").html();
			$("#storeList").hide();
			$("#storeDetailed").html(data);
		},
		error : function(data) {
			// alert(data);
		}
		});
	}
}

// 显示分店列表
function storeMessage() {
	var sd = $('#dg').datagrid('getSelected');
	if (sd != null || sd.length != "") {
		showContent(ctx + '/catalog/catalogStoreAction',null);
/*		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click", function() {
			DispOrHid('B-id');
		});
		$("#jt_tags1").text("分店信息");
		$("#storeList").show();
		$("#storeDetailed").hide();
		
		$("#Tools22").attr('class', "Icon-size1 Tools22");
		$("#Tools21").attr('class', "Icon-size1 Tools21_on");
		
		$($("#Tools22").parent()).removeClass("ToolsBg");
		$($("#Tools21").parent()).addClass("ToolsBg");*/
	}
}

// 打开所有公司列表窗口
function openCompanyWindow() {
	openPopupWin(600, 503, '/catalog/openCompanyWindowAction');
}

//打开注册城市弹出框
function openCityWindow() {
	openPopupWin(550, 450,'/commons/window/chooseCity');
}

//打开县市弹出框
function openCitysWindow() {
	$("#cr_provName").removeClass("errorInput");
	$("#cr_cityName").removeClass("errorInput");
	openPopupWin(550, 450,'/catalog/warehouseChooseCity');
}
function confirmChooseCity(regnNo,regnName){
	$('#regnNo').attr('value',regnNo);
	$('#regnName').attr('value',regnName);
	$('#cityId').attr('value',regnNo);
	$('#cityName').attr('value',regnName);
	closePopupWin();
}
function confirmWarehouseChooseCity(regnNo,regnName,code,codeName){
	$('#regnNo').attr('value',regnNo);
	$("#cr_cityName").val(regnName);
	$('#code').attr('value',code);
	$('#cr_provName').attr('value',codeName);
	closePopupWin();
}

var divsionId = null;
var spanText = null;
var comId = null;
//手动查询公司
function searchCompanyMess(comNo){
	$.ajax( {
		type : 'post',
		url : ctx + '/catalog/checkCompanyAction',
		data : {
			page : 1,
			rows : 1,
			comNo : comNo},
		success : function(data) {
			if (data.total > 0) {
				$("#companName").val(data.rows[0].comName);
			} else {
				$("#companName").val('');
			}
		}
	});
}
//选择所选公司
function selectCompany(comName){
	$("#dg2").datagrid({
		rownumbers : false,
		singleSelect : true,
		pagination : true,
		pageSize : 10,
		url : ctx + '/catalog/companyWindowAction',
		queryParams : {
			comName : comName
		},
		columns : [ [ {
			field : 'ck',
			checkbox : false,
			halign : 'center'
		}, {
			field : 'comNo',
			title : '公司编号',
			sortable : true,
			halign : 'center',
			formatter : function(val, rec){
				return rec.comNo + "&nbsp;&nbsp;";
			},
			align : 'right'
		}, {
			field : 'comTitle',
			title : '公司名称',
			sortable : true,
			halign : 'center'
		}, {
			field : 'econTitle',
			title : '公司类型',

			halign : 'center'
		}, {
			field : 'statusTitle',
			title : '状态',
			halign : 'center'
		}, {
			field : 'cityName',
			title : '注册城市',
			halign : 'center'
		}, {
			field : 'setupDate',
			title : '成立日期',
			halign : 'center',
			formatter : function(val, rec) {
				return new Date(val).format('yyyy-MM-dd');
			}
		}] ],
		onClickRow : function(rowIndex, rowData) {
			divsionId = rowData.comNo;
			spanText = rowData.comTitle;
		},
		onDblClickRow : function(rowIndex, rowData) {
			$("#companyCode").val(rowData.comNo);
			$("#companName").val(rowData.comTitle);
			closePopupWin();
		}
	});
}
//保存所选的公司
function saveCompany(){
	$("#companyCode").val(divsionId);
	$("#companName").val(spanText);
	closePopupWin();
}
//根据公司名字搜索公司
function searchCompany(){
	var se_companyName = $("#se_companyName").val();
	var companyDiv = $("#companyDiv").val();
	
	$.each(companyDiv,function(i,val){
		var v_companyDiv = companyDiv[i].find('div');
		var v_spanText = $($(v_companyDiv).find('span')[0]).text();
		if (v_spanText != se_companyName) {
			$("#"+v_companyDiv.id).hide();
		}
	});
}

var warehouseNum = null;
//仓库列表信息
/*function warehouseSearch(){
	var whseNo = $.trim($("#whseNo").val());
	var cityName = $.trim($("#cityName").val());
	var postCode = $.trim($("#postCode").val());
	var phoneNo = $.trim($("#phoneNo").val());
	var faxNo = $.trim($("#faxNo").val());
	if ($("#whseNo").attr("class").indexOf("errorInput") < 1) {
		$("#dg").datagrid( {
			rownumbers : false,
			singleSelect : true,
			pagination : true,
			pageSize : 20,
	        url: ctx + '/catalog/catalogWarehouseListAction',
	        queryParams : {
	        	whseNo:whseNo,
	        	cityName:cityName,
	        	postCode:postCode,
	        	phoneNo:phoneNo,
	        	faxNo:faxNo
	        },
	        columns: [[{
				field : 'ck',
				checkbox : false
			}, {
				field : 'whseNo',
				title : '仓库编号',width : 60,
				sortable : true,
				align : 'right',
				formatter : function(val, rec){
					return rec.whseNo + "&nbsp;&nbsp;";
				},
				halign : 'center'
			}, {
				field : 'cityName',
				title : '城市',
				sortable : true,width : 79,
				halign : 'center'
			}, {
				field : 'detllAddr',
				title : '地址',width : 537,
				halign : 'center'
			}, {
				field : 'postCode',
				title : '邮编',width : 80,
				halign : 'center'
			}, {
				field : 'phoneNo',
				title : '电话号码',width : 137,
				formatter : function(val, rec){
					return $.trim(rec.areaCode) + "-" + $.trim(rec.phoneNo);
				},
				halign : 'center'
			}, {
				field : 'faxNo',
				title : '传真号码',width : 137,
				formatter : function(val, rec){
					return $.trim(rec.areaCode) + "-" + $.trim(rec.faxNo);
				},
				halign : 'center'
			}, {
				field : 'temp',
				title : ' ',width:28,
				halign : 'center'
			} ] ],
	   		onClickRow : function(rowIndex, rowData) {
	       	 	warehouseNum = rowData.companyNo;
	       	 $("#Tools12").attr('class', "Tools12");
	   		}
	    });
	}
}*/
//创建新仓库
function saveWarehouse(){
	var warehouseForm = $("#warehouseForm").serialize();
	var whseNo = $.trim($("#cwhseNo").val());
	var whseName = $.trim($("#whseName").val());
	var provName = $.trim($("#cr_provName").val());
	var detllAddr = $.trim($("#detllAddr").val());
	var areaPhoneNo = $.trim($("#areaPhoneNo").val());
	var areaFaxNo = $.trim($("#areaFaxNo").val());
	if (whseNo != "" && whseName != "" && provName != "" && detllAddr != "" && (areaPhoneNo == areaFaxNo)){
		$("#areaFaxNo").removeClass("errorInput");
		$("#areaPhoneNo").removeClass("errorInput");
		var checkForm = $("#warehouseForm").find('input');
		var flag = true;
		$.each(checkForm, function(index, val){
			if ($(checkForm[index]).attr('class').indexOf("errorInput") > 1){
				flag = false;
				return false;
			}
		});
		if (flag) {
			$.ajax( {
				type : 'post',
				url : ctx + '/catalog/saveWarehouseAction',
				data : warehouseForm,
				success : function(data) {
					if (data.status=='success') {
						alert("创建成功");
						closePopupWinTwo();
						warehouseSearch();
					} else {
						alert(data.message);
					}
				}
			});
		}
	} else {
		if (whseNo == "") {
			$("#cwhseNo").addClass("errorInput");
		}
		if (whseName == "") {
			$("#whseName").addClass("errorInput");
		}
		if (provName == "") {
			$("#cr_provName").addClass("errorInput");
			$("#cr_cityName").addClass("errorInput");
		}
		if (detllAddr == "") {
			$("#detllAddr").addClass("errorInput");
		}
		if (areaPhoneNo != areaFaxNo) {
			$("#areaFaxNo").addClass("errorInput");
			$("#areaPhoneNo").addClass("errorInput");
			$("#areaPhoneNo").attr("title","区号不一致");
			$("#areaFaxNo").attr("title","区号不一致");
		}
	}
}

//修改仓库窗口
function warehouseUpdata(whseNo){
	if(whseNo==null || whseNo ==''){
		
		return;
	}
	openPopupWinTwo(600,360,"/catalog/updataWarehouseAction?whseNo="+whseNo);
	
}
//修改仓库信息
function updataWarehouse(){
	viewModelWHUpdate.errors = ko.validation.group(viewModelWHUpdate);
	if (!viewModelWHUpdate.isValid()) {
		viewModelWHUpdate.errors.showAllMessages();
		return;
	}
	var areaPhoneNo = $.trim($("input[name='areaCode']").val());
	var areaFaxNo = $.trim($("input[name='areaFaxNo']").val());
	var warehouseForm = $("#warehouseUpdataForm").serialize();
	if (areaPhoneNo != areaFaxNo) {
		$("input[name='areaCode']").addClass("errorInput");
		$("input[name='areaFaxNo']").addClass("errorInput");
		$("input[name='areaCode']").attr("title","区号不一致");
		$("input[name='areaFaxNo']").attr("title","区号不一致");
		return ;
	} else {
		$.ajax( {
			type : 'post',
			url : ctx + '/catalog/updataWarehouseMessAction',
			data : warehouseForm,
			success : function(data) {
				if (data) {
					//alert("操作成功");
					successAlert("操作成功", 350, 80, "提示信息");
					closePopupWinTwo();
					warehouseSearch();
				} else {
					//alert("操作失敗");
					errorAlert("操作失败", 350, 80, "提示信息");
				}
			}
		});
	}
}
//显示修改的信息
function showWarehouseMess(){
	$("#whseNos").val($('#dg').datagrid('getSelections')[0].whseNo);
	$("#codeName").val();
	$("#regnName").val();
	$("#detllAddrs").val($('#dg').datagrid('getSelections')[0].detllAddr);
	$("#postCodes").val($('#dg').datagrid('getSelections')[0].postCode);
	var phoneNo = $('#dg').datagrid('getSelections')[0].phoneNo;
	var faxNo = $('#dg').datagrid('getSelections')[0].faxNo;
	$("#telphone1s").val(phoneNo.substr(0,phoneNo.indexOf("-")));
	$("#telphone2s").val(phoneNo.substr(phoneNo.indexOf("-")+1,phoneNo.length));
	$("#faxNo1s").val(faxNo.substr(0,faxNo.indexOf("-")));
	$("#faxNo2s").val(faxNo.substr(faxNo.indexOf("-")+1,faxNo.length));
}
function warehouseSearchClean(){
	$('#whseNo').val('');
	$('#city').val('');
	$('#address').val('');
	$('#zipCode').val('');
	$('#telNo').val('');
	$('#faxNo').val('');
}

function getMouse(){
    $('.Item').live("mouseover", function () {
        if ($(this).attr("class").indexOf("Fav_On") > 0) {
            $(this).addClass("Fav_bigger2");
        } else {
            $(this).addClass("Fav_bigger1");
        }
    });
}

function cleanSearch(){
	$("table").find('input').val('');
	$("#storeNo").removeClass("errorInput");
}

//手动查询城市
function searchRegnMess(regnNo){
	$.ajax( {
		type : 'post',
		url : ctx + '/catalog/companyWindowAction',
		data : {
			page : 1,
			rows : 1,
			comNo : comNo},
		success : function(data) {
			if (data.total > 0) {
				$("#companName").val(data.rows[0].comName);
			} else {
				$("#companName").val('');
			}
		}
	});
}