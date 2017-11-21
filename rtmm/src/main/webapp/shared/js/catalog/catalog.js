//select中显示处信息
function showDivision() {
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/groupShowDivisionsAction",
		success : function(data) {
			var select = $("#divisionCode");
			select.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id + ">" + "<p align='right'>" + value.code
				+ "</p>" + "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
		}
	});
}

// 根据处显示课信息
function divisionSelect(obj) {
	// var divisionId = obj.selectedOptions[0].value;
	// var divisionId = $("#divisionCode").find('option:selected')[0].value;
	//選了處之後, 開放選擇課
	$('#sectionCode').removeAttr("disabled");
	var divisionId = obj.value;
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/groupShowSectionAction",
		data : {
			divisionId : divisionId
		},
		success : function(data) {
			var select = $("#sectionCode");
			var groupCode = $("#groupCode");
			var midsizeCode = $("#midsizeCode");
			var catlgNo = $("#catlgNo");
			groupCode.empty();
			midsizeCode.empty();
			select.empty();
			catlgNo.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.catlgId + ">" + "<p>" + value.catlgNo
				+ "</p>" + "-&nbsp;"+ value.catlgName + "</option>";
				select.append(option);
			});
		}
	});
}

// 根据课显示大分类信息
function sectionSelect(obj) {
	var sectionId = obj.value;
	//選了課之後, 開放選擇大分類
	$('#groupCode').removeAttr("disabled");
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/midsizeShowGroupAction",
		data : {
			sectionId : sectionId
		},
		success : function(data) {
			var select = $("#groupCode");
			var midsizeCode = $("#midsizeCode");
			var catlgNo = $("#catlgNo");
			midsizeCode.empty();
			select.empty();
			catlgNo.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id + ">" + value.code
						+ "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
		}
	});

}

//根据大分类显示中分类信息
function groupSelect(obj) {
	$('#midsizeCode').removeAttr("disabled");
	var gourpCode = obj.value;
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/subShowMidsizeAction",
		data : {
		gourpCode : gourpCode
		},
		success : function(data) {
			var select = $("#midsizeCode");
			var catlgNo = $("#catlgNo");
			select.empty();
			catlgNo.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id + ">" + value.code
						+ "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
		}
	});

}
//根据中分类显示小分类信息
function midgrpSelect(obj) {
	$("#catlgNo").removeAttr("disabled");
	var midsizeId = obj.value;
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/subGroupShowGroupAction",
		data : {
			midsizeId : midsizeId
		},
		success : function(data) {
			var select = $("#catlgNo");
			select.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id + ">" + value.code
						+ "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
		}
	});
}
//创建窗口select中显示处信息
function showCreateDivision() {	
	
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/groupShowDivisionsAction",
		success : function(data) {
			var select = $("#divisionCodeCreate");
			select.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id + ">" + value.code
						+ "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
			// 把處下面的下拉式選單都disable
			$("#sectionCodeCreate").attr("disabled", "true");
			$("#groupCodeCreate").attr("disabled", "true");
			$("#midsizeCodeCreate").attr("disabled", "true");
			$("#subCodeCreate").attr("disabled", "true");
		}
	});
}


//创建窗口根据处显示课信息
function cr_divisionSelect(obj) {
	// var divisionId = obj.selectedOptions[0].value;
	// var divisionId = $("#divisionCode").find('option:selected')[0].value;
	//選了處之後, 才開放課的下拉式選單
	$("#sectionCodeCreate").removeAttr("disabled");	
	var divisionId = obj.value;
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/groupShowSectionAction",
		data : {
			divisionId : divisionId
		},
		success : function(data) {
			var select = $("#sectionCodeCreate");
			var groupCodeCreate = $("#groupCodeCreate");
			var midsizeCodeCreate = $("#midsizeCodeCreate");
			groupCodeCreate.empty();
			midsizeCodeCreate.empty();
			select.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.catlgId +">" + value.catlgNo
						+ "-&nbsp;" + value.catlgName + "</option>";
				select.append(option);
			});
		}
	});

}


//创建窗口根据课显示大分类信息
function cr_sectionSelect(obj) {
	//選了課之後, 才開放大分类的下拉式選單
	$("#groupCodeCreate").removeAttr("disabled");	
	var sectionId = obj.value;
	$("#sectionFont").text("");
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/midsizeShowGroupAction",
		data : {
			sectionId : sectionId
		},
		success : function(data) {
			var select = $("#groupCodeCreate");
			var midsizeCodeCreate = $("#midsizeCodeCreate");
			midsizeCodeCreate.empty();
			select.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id + ">" + "<font style='width:10%;float:right;'>" + value.code
				+ "</font>" + "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
		}
	});

}


//创建窗口根据大分类显示中分类信息
function cr_groupSelect(obj) {
	//選了大分类之後, 才開放中分类的下拉式選單
	$("#midsizeCodeCreate").removeAttr("disabled");		
	var gourpCode = obj.value;
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/subShowMidsizeAction",
		data : {
		gourpCode : gourpCode
		},
		success : function(data) {
			var select = $("#midsizeCodeCreate");
			select.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id + ">" + value.code
						+ "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
		}
	});
}
//创建窗口根据中分类显示小分类信息
function cr_subGroupSelect(obj) {
	//選了大分类之後, 才開放中分类的下拉式選單
	$("#subCodeCreate").removeAttr("disabled");		
	var midsizeCode = obj.value;
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/subGroupShowGroupAction",
		data : {
			midsizeId : midsizeCode
		},
		success : function(data) {
			var select = $("#subCodeCreate");
			select.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id +">" + value.code
						+ "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
		}
	});
}
//处别select下拉框
function division_Select(){
	$.ajax({
		type : "post",
		url : ctx + "/catalog/groupShowDivisionsAction",
		success : function(data){
		    $("#divisionCode").combobox({
		        width : 137,
		        required:true,
		        readonly : false,
		        data : data,
		        valueField: 'id',
		        textField: 'name',
		        formatter : function(row){
		        	return row.code + "-" + row.name;
		        }, 
		        onSelect: function (rec) {
		        	$("#divisionCode").combobox("setText",rec.code + "-" + rec.name);
		        	section_Select(rec.id);
		        }
		    });
		    $("#divisionCode").combobox("setValue","请选择");
		}
	});

}
//课别select下拉框为空
function sectionEmpty(){
    $("#sectionCode").combobox({
        //url: 'combobox_data.json',
        width : 137,
        readonly : false,
        data : [],
        valueField : 'id',
        textField : 'catgName'
    });
    $("#sectionCode").combobox("setValue","请选择");
}
//课别select下拉框
function section_Select(obj){
	if (obj == null) {
		sectionEmpty();
	} else {
		$.ajax({
			type : "post",
			url : ctx + "/catalog/groupShowSectionAction",
			data : {
				divisionId : obj
			},
			success : function(data){
				$("#sectionCode").combobox({
					//url: 'combobox_data.json',
					width: 137,
					readonly: false,
					data: data,
					valueField: 'catlgId',
					textField: 'catlgName',
					formatter : function(row){
						return row.catlgNo + "-" + row.catlgName;
					},
					onSelect: function (rec) {
						//group_Select(rec.catlgId);
						$("#sectionCode").combobox("setText",rec.catlgNo + "-" + rec.catlgName);
					}
				});
				$("#sectionCode").combobox("setValue","请选择");
			}
		});
	}

}
//大分类select下拉框为空
function groupEmpty(){
    $("#groupCode").combobox({
        //url: 'combobox_data.json',
        width : 137,
        readonly : false,
        data : [],
        valueField : 'id',
        textField : 'name'
    });
    $("#groupCode").combobox("setValue","请选择");
}
//大分类select下拉框
function group_Select(obj){
	if (obj == null) {
		groupEmpty();
	} else {
		$.ajax({
			type : "post",
			url : ctx + "/catalog/midsizeShowGroupAction",
			data : {
				sectionId : obj
			},
			success : function(data){
				$("#groupCode").combobox({
					//url: 'combobox_data.json',
					width: 137,
					readonly: false,
					data: data,
					valueField: 'id',
					textField: 'name',
					formatter : function(row){
						return row.catlgNo + "-" + row.name;
					},
					onSelect: function (rec) {
						midsizeGroup_Select(rec.id);
					}
				});
				$("#groupCode").combobox("setValue","请选择");
			}
		});
	}
}
//中分类select下拉框为空
function midsizeEmpty(){
    $("#midsizeCode").combobox({
        //url: 'combobox_data.json',
        width: 137,
        readonly: false,
        data: [],
        valueField: 'id',
        textField: 'name'
    });
    $("#midsizeCode").combobox("setValue","请选择");
}
//中分类select下拉框
function midsizeGroup_Select(obj){
	if (obj == null) {
		midsizeEmpty();
	} else {
		$.ajax({
			type : "post",
			url : ctx + "/catalog/subShowMidsizeAction",
			data : {
				gourpCode : obj
			},
			success : function(data){
			    $("#midsizeCode").combobox({
			        //url: 'combobox_data.json',
			        width: 137,
			        readonly: false,
			        data: data,
			        valueField: 'id',
			        textField: 'name',
			        onSelect: function (rec) {
			        	subGroup_Select(rec.id);
			        }
			    });
			    $("#midsizeCode").combobox("setValue","请选择");
			}
		});
	}
}
//小分类select下拉框为空
function subGroupEmpty(){
    $("#catlgNo").combobox({
        //url: 'combobox_data.json',
        width: 137,
        readonly: false,
        data: [],
        valueField: 'id',
        textField: 'name'
    });
    $("#catlgNo").combobox("setValue","请选择");
}
//小分类select下拉框
function subGroup_Select(obj){
	if (obj == null) {
		subGroupEmpty();
	} else {
		$.ajax({
			type : "post",
			url : ctx + "/catalog/subGroupShowGroupAction",
			data : {
				midsizeId : obj
			},
			success : function(data){
			    $("#catlgNo").combobox({
			        //url: 'combobox_data.json',
			        width: 137,
			        readonly: false,
			        data: data,
			        valueField: 'id',
			        textField: 'name',
					formatter : function(row){
						return row.storeNo + "-" + row.name;
					},
			        onSelect: function (rec) {
			        	$("#storeNo").combobox("setValue",rec.storeNo + "-" + rec.storeName);
			        }
			    });
			    $("#catlgNo").combobox("setValue","请选择");
			}
		});
	}

}
