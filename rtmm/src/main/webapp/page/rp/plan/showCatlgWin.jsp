<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/iframeContent.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/default.css" />

<script type="text/javascript">

$(function(){
	showDivision();
});

function addStoreGrpType(){
	var CatlgId= $("#sectionCode").val();
	if(CatlgId.length==0){
		top.jWarningAlert('请选择要添加课');
	}else{
		var CatlgName =$("#sectionCode").find("option:selected").attr("id");
		addCatlgReturn(CatlgId,CatlgName);

	}
}

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
			groupCode.empty();
			midsizeCode.empty();
			select.empty();
			select.append("<option value=''>请选择</option>");
			$.each(data, function(index, value) {
				var option = "<option value='" + value.catlgId + "' id='"+value.catlgName+"'>" + "<p>" + value.catlgNo
				+ "</p>" + "-&nbsp;"+ value.catlgName + "</option>";
				select.append(option);
			});
		}
	});
}


</script>
<div class="Panel_top">
	<span>选择课别信息</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
    <div class="ig" style="margin-top:10px;">
        <div class="msg_txt w30" >处别</div>
        <select class="w30"  id="divisionCode" onchange="divisionSelect(this)"><option></option></select>
    </div>
    <div class="ig">
        <div class="msg_txt w30" >课别</div>
        <select class="w30"  id="sectionCode" disabled="disabled"><option></option></select>
    </div>
</div>
<div class="Panel_footer">
    <div class="PanelBtn">
        <div class="PanelBtn1" onclick="addStoreGrpType()">确定</div>
        <div class="PanelBtn2" onclick="closePopupWin()">取消</div>
    </div>
</div>
<div style="clear:both;"></div>
