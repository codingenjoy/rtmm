//公司总览
function companyManagement(){
	var comNo = $("#comNoSearch").val();
    $("#first").addClass("tags1_left_on");
    $("#supComMess").addClass("tagsM tagsM_on");
    $("#midden").addClass("tags tags_left_on");
    $("#comOthAddrMess").addClass("tagsM");
    $("#last").addClass("tags tags3_r_off");
	showContent(ctx+'/supplier/company/companyManagement?comNo='+comNo);
}
//订货退货地址
function comOtherAddrManagement(){
	showContent(ctx+'/supplier/company/comOtherAddrManagement');
}
//订货退货地址查询
function comOtherAddrSearch(){
	var comNo = $("#comNoSearch").val();
	var addrNo = $("#addrNoSearch").val();
	var addrType = $("#addrTypeSearch").val();
	var provName = $("#provNameSearch").val();
	var cityName = $("#cityNameSearch").val();
	var detllAddr = $("#detllAddrSearch").val();
	var cntctName = $("#cntctNameSearch").val();
	var postCode = $("#postCodeSearch").val();
	var moblNo = $("#moblNoSearch").val();
	var phoneNo = $("#phoneNoSearch").val();
	var faxNo = $("#faxNoSearch").val();
	var emailAddr = $("#emailAddrSearch").val();
	$('#dg').datagrid(
			{
				striped:true,
				nowrap:true,
				rownumbers : false,
				singleSelect : true,
				pagination : true,
				pageSize : 20,
				url : ctx + '/supplier/company/comOtherAddrList',
				queryParams : {
					comNo:comNo,
					addrId:addrNo,
					addrType:addrType,
					provName:provName,
					cityName:cityName,
					detllAddr:detllAddr,
					cntctName:cntctName,
					postCode:postCode,
					moblNo:moblNo,
					phoneNo:phoneNo,
					faxNo:faxNo,
					emailAddr:emailAddr
				},
				columns: [[
				            { field: 'ck', checkbox: false, halign : 'center'},
				            { field: 'addrId', title: '编号', sortable: true, halign : 'center',align : 'right',
				            	formatter : function(val, rec) {
									return val+"&nbsp;&nbsp;";
				            	},
				            	width : 102
				            },
				            { field: 'addrType', 
				            	title: '地址类型', 
				            	halign : 'center',
				            	align : 'left',
								formatter : function(val, rec) {
									return getDictValue('COM_OTH_ADDRESS_ADDR_TYPE',rec.addrType);
								},
								width : 109
				            },
				            { field: 'cityName', title: '省份城市',halign : 'center',align : 'left', width : 86},
				            { field: 'detllAddr', title: '地址',halign : 'center',align : 'left',width : 224 },
				            { field: 'cntctName', title: '联系人',halign : 'center', align : 'left',width : 60},
				            { field: 'postCode', title: '邮编', halign : 'center',align : 'left',width : 60},
				            { field: 'moblNo', title: '移动电话', halign : 'center',align : 'left',width : 86},
				            { field: 'phoneNo', title: '固定电话',halign : 'center', align : 'left',width : 87},
				            { field: 'faxNo', title: '传真号码',halign : 'center',align : 'left',width : 85},
				            { field: 'emailAddr', title: '电子邮箱',halign : 'center',align : 'left',width : 129},
							{field : "temp",title : ' ',halign : 'center',width : 18}
				            ]],
							onLoadSuccess : function(){
								setBorderRig('.Content');
							}
			});
}
//创建收货退货地址
function createComOtherAddr(comNo) {
	var comNo = $('#comNoSearch').val();
	if(comNo == null || comNo == ""){
		//alert("请选择公司");
		top.jAlert('warning','请选择公司！','消息提示');
		return;
	}
	openPopupWinTwo(600,450,'/supplier/company/createComOtherAddr?comNo='+comNo);
}
//修改收货退货地址
function modifyComOtherAddr(){
	var comNo = $('#comNoSearch').val();
	if(comNo == null || comNo == ""){
		//alert("请选择公司");
		top.jAlert('warning','请选择公司！','消息提示');
		return;
	}
	//var sd = $('#dg').datagrid('getSelected');
	//if (sd == null || sd.length == "") {
		//alert("请选择地址");
	if(!$('.btable_checked') || !$('.btable_checked').attr('id')){
		top.jAlert('warning','请选择地址！','消息提示');
		return;
	} else {
		var addrId = $('.btable_checked').attr('id');
		openPopupWinTwo(600,450,"/supplier/company/modifyComOtherAddr?comNo="+comNo+"&addrId="+addrId);
	}
}
//清除地址查询条件
function clearAddrSearch(){
	$("#addrNoSearch").val(null);
	$("#addrTypeSearch").val(null);
	$("#provNameSearch").val(null);
	$("#cityNameSearch").val(null);
	$("#detllAddrSearch").val(null);
	$("#cntctNameSearch").val(null);
	$("#postCodeSearch").val(null);
	$("#moblNoSearch").val(null);
	$("#phoneNoSearch").val(null);
	$("#faxNoSearch").val(null);
	$("#emailAddrSearch").val(null);
}

//打开公司弹出框
function openComWindow() {
	openPopupWin(650, 510,'/commons/window/chooseSupCom');
}
function confirmChooseSupCom(comNo, comName,comgrpNo,comgrpName){
	$('#comNoSearch').attr('value',comNo);
	$('#comNameSearch').attr('value',comName);
	closePopupWin();
	//comOtherAddrSearch();
	//pageQuery();
	showContent(ctx+'/supplier/company/comOtherAddrManagement?comNo='+comNo+'&comName='+encodeURI(encodeURI(comName)));
}
//检索框选择城市
function openCityAndProvWindowSear() {
	openPopupWin(550, 450,'/commons/window/chooseCityAndProv?callback=confirmSear');
}
function confirmSear(cityCode,cityName,provCode,provName){
	$('#cityNameSearch').attr('value',cityName);
	$('#provNameSearch').attr('value',provName);
	closePopupWin();
}
//编辑选择城市
function openCityAndProvWindowEdit() {
	openPopupWin(550, 450,'/commons/window/chooseCityAndProv?callback=confirmEdit');
}
function confirmEdit(cityCode,cityName,provCode,provName){
	viewModel.cityName(cityName);
	viewModel.provName(provName);
	closePopupWin();
}
function pageQuery(){
	
	var pageNo = $('#pageNo').val();
	var pageSize = $('#pageSize').val();
	
	var comNo = $("#comNoSearch").val();
	var addrNo = $("#addrNoSearch").val();
	var addrType = $("#addrTypeSearch").val();
	var provName = $("#provNameSearch").val();
	var cityName = $("#cityNameSearch").val();
	var detllAddr = $("#detllAddrSearch").val();
	var cntctName = $("#cntctNameSearch").val();
	var postCode = $("#postCodeSearch").val();
	var moblNo = $("#moblNoSearch").val();
	var phoneNo = $("#phoneNoSearch").val();
	var faxNo = $("#faxNoSearch").val();
	var emailAddr = $("#emailAddrSearch").val();
	$.ajax({
	        type : "post",
	        async : false,
	        url : ctx + "/supplier/company/comOtherAddrListPage" ,
	        dataType : "html",
	        data : {
				'comNo':comNo,
				'addrId':addrNo,
				'addrType':addrType,
				'provName':provName,
				'cityName':cityName,
				'detllAddr':detllAddr,
				'cntctName':cntctName,
				'postCode':postCode,
				'moblNo':moblNo,
				'phoneNo':phoneNo,
				'faxNo':faxNo,
				'emailAddr':emailAddr,
				'pageNo' : pageNo,
				'pageSize' : pageSize
	        },
	        success : function(data) {
	           $('#comOtherAddrList').html(data);
	        }
   });
	
}