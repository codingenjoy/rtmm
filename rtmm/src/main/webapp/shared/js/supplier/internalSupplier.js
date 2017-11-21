function Record(){
	this.supNo = null;
}

function pageQuery(){
	
	var pageNo = $('#pageNo').val();
	var pageSize = $('#pageSize').val();
	if (pageSize == null){
		pageSize = 20;
	}
	
	var supNo = $("#supNoSearch").val();
	var leadTime = $("#leadTimeSearch").val();
	var number8 = new RegExp(/^[0-9]{1,8}$/);
	var number2 = new RegExp(/^[0-9]{1,2}$/);
	if(supNo != "" && !number8.test($.trim(supNo))){
		top.jAlert('warning','内部厂编请输入数字格式','提示信息');
		return;
	}
	if(leadTime != "" && !number2.test($.trim(leadTime))){
		top.jAlert('warning','准备天数请输入数字格式','提示信息');
		return;
	}
	
	var intrnSupName = $("#intrnSupNameSearch").val();
	var supType = $("#supTypeSearch").val();
	var status = $("#statusSearch").val();
	
	$.ajax({
	        type : "post",
	        async : false,
	        url : ctx + "/supplier/InternalSupplier" ,
	        dataType : "html",
	        data : {
				'supNo' : supNo,
				'intrnSupName' : intrnSupName,
				'leadTime' : leadTime,
				'supType' : supType,
				'status' : status,
				'pageNo' : pageNo,
				'pageSize' : pageSize
	        },
	        success : function(data) {
	           $('#intSupplierList').html(data);
	        }
   });
	
	$("#Tools12").attr('class', "Icon-size1 Tools12_disable").unbind("click");
	
}

// 新增內部廠商
function createInternalSupplier() {
	openPopupWin(600, 320, '/supplier/createInternalSupplierAction');
}

// 編輯內部廠商資料
function modifyInternalSupplier() {
	var supNo = $('#intSupplierList').find('.btable_checked').find('#supNo').text();
	openPopupWin(600, 320, '/supplier/modifyIntrnSupplier?supNo='+supNo);
}

function clearSearch(){
	$("#supNoSearch").val(null);
	$("#intrnSupNameSearch").val(null);
	$("#leadTimeSearch").val(null);
	$("#supTypeSearch").val(null);
	$("#statusSearch").val(null);
}