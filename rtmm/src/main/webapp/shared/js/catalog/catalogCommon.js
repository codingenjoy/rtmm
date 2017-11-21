// 打开所有公司列表窗口
function openCompanyWindow() {
	openPopupWin(600, 470, '/catalog/openCompanyWindowAction');
}

//打开注册城市弹出框
function openCityWindow() {
	openPopupWin(550, 450,'/commons/window/chooseCity');
}

//根据处显示课信息
function sectionSelect(objDivisionId,targetElementId) {
	
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/groupShowSectionAction",
		data : {
			divisionId : objDivisionId
		},
		success : function(data) {
			
			var select = $("#"+targetElementId);
			select.empty();
			select.append("<option value=''>"+window.pleaseSelect+"</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.catlgNo + ">" + "<p>" 
				+ value.catlgNo+ "</p>" + "-&nbsp;"
				+ value.catlgName + "</option>";
				select.append(option);
			});
		}
	});
}

//创建窗口根据课显示大分类信息
function groupSelect(objSectionId,targetElementId) {	
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/midsizeShowGroupAction",
		data : {
			sectionId : objSectionId
		},
		success : function(data) {
			var select = $("#"+targetElementId);
			select.empty();
			select.append("<option value=''>"+window.pleaseSelect+"</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id + ">" 
				+ "<font style='width:10%;float:right;'>" + value.code
				+ "</font>" + "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
		}
	});

}


//创建窗口根据大分类显示中分类信息
function midGroupSelect(objGroupId,targetElementId) {
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/subShowMidsizeAction",
		data : {
		gourpCode : objGroupId
		},
		success : function(data) {
			var select = $("#"+targetElementId);
			select.empty();
			select.append("<option value=''>"+window.pleaseSelect+"</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id + ">" + value.code
						+ "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
		}
	});
}

//创建窗口根据中分类显示小分类信息
function subGroupSelect(objMidGroupId,targetElementId) {
	//選了大分类之後, 才開放中分类的下拉式選單
	$.ajax( {
		type : "post",
		url : ctx + "/catalog/subGroupShowGroupAction",
		data : {
			midsizeId : objMidGroupId
		},
		success : function(data) {
			var select = $("#"+targetElementId);
			select.empty();
			select.append("<option value=''>"+window.pleaseSelect+"</option>");
			$.each(data, function(index, value) {
				var option = "<option value=" + value.id +">" + value.code
						+ "-&nbsp;" + value.name + "</option>";
				select.append(option);
			});
		}
	});
}

//只输入数字
function IsNum(){
	return ((event.keyCode >= 48) && (event.keyCode <= 57)); 
}
