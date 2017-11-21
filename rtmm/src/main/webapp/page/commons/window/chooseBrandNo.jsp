<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.Table_Panel {
	height: 406px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}

.Panel_footer div {
	margin-top: 3px;
}
</style>
<script type="text/javascript">
$(function() {
	searchBrandNo(); 
		$("#brandNameInput").bind('keypress', function(e) {
		var code=e.keyCode;
		if (13==code) { 
			if($.trim($('#brandNameInput').val()) == '' || $.trim($('#brandNameInput').val()) == '输入品牌名称查询'){
				top.jAlert('warning', '请输入查询条件!','提示消息');
			}else{
				searchBrandNo();
			} 
		} });
}); 
function searchBrandNo() {
	var brandNameInput = $.trim($('#brandNameInput').val()) == '输入品牌名称查询'?'':$.trim($('#brandNameInput').val());
	var url = brandNameInput?'/commons/window/listBrandData':'';
	var barandName = brandNameInput?$('#brandNameInput').val():'';
	$("#dg2").datagrid({
		striped : true,
		rownumbers : false,
		singleSelect : true,
		pagination : true,
		pageSize : 10,
		queryParams : {
			brandName : barandName
		},
		url : ctx +url,
		columns : [ [ 
						{
							field : 'ck',
							checkbox : false,
							halign : 'center',
							width : 5
						},
						{
							field : 'brandId',
							title : '品牌编号',
							sortable : true,
							halign : 'center',
							align : 'right',
							width : 144,
							formatter : function(val, rec) {
								return val+"&nbsp;&nbsp;";
							}
						}, {
							field : 'brandName',
							title : '品牌名称',
							halign : 'center',
							align : 'left',
							width : 360
						}
						] ],
				        onDblClickRow : function(rowIndex, rowData){
				        	var callBack ="${callback}('"+rowData.brandId+ "','"+rowData.brandName+"')";
				        	eval(callBack);
				        	closePopupWin();
				        }  
	});		
}
function confirmBtn(){
	var rowData = $('#dg2').datagrid('getSelected');
	if(rowData){
		var callBack ="${callback}('"+rowData.brandId+ "','"+rowData.brandName+"')";
      	eval(callBack);
		closePopupWin();
	}
}
function checkInput(){
	if($.trim($('#brandNameInput').val()) == '' || $.trim($('#brandNameInput').val()) == '输入品牌名称查询'){
		top.jAlert('warning', '请输入查询条件!','提示消息');
	}else{
		searchBrandNo();
	}
}
</script>

<div class="Panel_top">
	<span>选择品牌</span>
	<div class="PanelClose" style="margin-right: 0;"
		onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto; width: 97%; height: 100%;">
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" class="IS_input" value="" id="brandNameInput"
					name="brandName" placeholder="输入品牌名称查询" />
				<div class="cbankIcon" onclick='checkInput();'></div>
			</div>
		</div>
		<div class="">
			<table id="dg2" style="height: 360px; width: 520px;"></table>
		</div>
	</div>
</div>
<div class="Panel_footer">
     <div class="PanelBtn1 pt_div" style="margin-left: 150px;" onclick="confirmBtn()">确认</div>
     <div class="PanelBtn2 pt_div" onclick="closePopupWin()">取消</div>
</div>
