var storeNo="";


function Record() {
	this.supNo = null;
	this.storeNo = null;
}

//查詢 DC廠商列表
function pageQuery(type) {
	
	var pageNo = $("#pageNo").val();	
	var pageSize = $('#pageSize').val();
	if (type == 1){
		pageNo = 1;
		pageSize = 20;
	}
	
	var number = new RegExp(/^[0-9]{1,8}$/);
	var supNo = $("#supNoSearch").val();
	if(supNo != "" && !number.test($.trim(supNo))){
		top.jAlert('warning','厂编请输入数字格式','提示信息');
		return;
	}
	var applyStartDateFrom = $("#applyStartDateFromSearch").val();
	var applyStartDateEnd = $("#applyStartDateEndSearch").val();
	var lockSttus = $("#lockSttusSearch").val();
	$.ajax({
	        type : "post",
	        async : false,
	        url : ctx + "/supplier/DCSupplier" ,
	        dataType : "html",
	        data : {
				'supNo' : supNo,
				'storeName' : $('#storeNoSearch ~ span >input').val(),
				'storeNo' : storeNo,
				'applyStartDateFrom' : applyStartDateFrom,
				'applyStartDateEnd' : applyStartDateEnd,
				'lockSttus' : lockSttus,
				'pageNo' : pageNo,
				'pageSize' : pageSize
	        },
	        success : function(data) {
	           $('#dcSupplierList').html(data);
	        }
   });
	
	$("#Tools12").attr('class', "Icon-size1 Tools12_disable").unbind("click");

}
// 新增DC廠商
function createDCSupplier() {
	openPopupWin(600, 250, '/supplier/createDCSupplierAction');
}

function modifyDCSupplier() {
	var supNo = $('#dcSupplierList').find('.btable_checked').find('#dcSupNo').text();
	var storeNo = $('#dcSupplierList').find('.btable_checked').find('#dcStoreNo').text();
	
	openPopupWin(600, 250, '/supplier/modifyDCSupplierAction?supNo='
			+ supNo + "&storeNo=" + storeNo);
}

function StoreListSearch() {
	$.ajax({
		type : "post",
		url : ctx + "/supplier/getStoreList",
		success : function(data){
			$("#storeNoSearch").combobox({
		        width: 137,
		        readonly: false,
		        data: data,
		        valueField: 'storeNo',
		        textField: 'storeName',
		        onSelect : function(rec){
		        	storeNo = rec.storeNo; 
		        }
		    });
		    $("#storeNoSearch").combobox("setValue",window.pleaseSelect);
		}
	});
}

function StoreListSearch2(storeNo){
	$.ajax({
		type : "post",
		url : ctx + "/supplier/getStoreList",
		success : function(data){
			$("#storeNo").combobox({
		        width: 170,
		        readonly: false,
		        data: data,
		        valueField: 'storeNo',
		        textField: 'storeName',
		        onSelect : function(rec){
		        	$('#storeNo ~ span >input').removeClass("errorInput");
		        	$('#storeNo ~ span >input').removeAttr('title');
		        }
		    });
		    if (storeNo != ""){
		    	$("#storeNo").combobox({readonly:true});
		    	$("#storeNo").combobox("setValue",storeNo);
				$('#storeNo ~ span >input').addClass("Black");
		    }
		    else{
		    	$("#storeNo").combobox("setValue",window.pleaseSelect);
		    }
		}
	});
}

function clearSearch(){
	$("#supNoSearch").val(null);
	$("#storeNoSearch").combobox("setValue",window.pleaseSelect);
	$("#applyStartDateFromSearch").val(null);
	$("#applyStartDateEndSearch").val(null);
	$("#lockSttusSearch").val(null);
	storeNo = '';
}
