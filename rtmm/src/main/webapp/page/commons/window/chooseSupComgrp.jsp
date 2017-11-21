<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.Table_Panel {
	height: 406px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;
}
</style>
<script type="text/javascript">
	var  groupNo =  '<auchan:i18n id="102001002"></auchan:i18n>';//集团编号
	var  groupName =  '<auchan:i18n id="102001003"></auchan:i18n>';//集团名称
	var  groupenName =  '<auchan:i18n id="102001004"></auchan:i18n>';//集团英文名称
	$(function() {
		searchSupComGrpAll();
 		$("#comgrpNameInput").bind('keypress', function(e) {
			var code=e.keyCode;
			if (13==code) { 
				searchSupComGrp(); 
			} 
		}); 
	});
	
	function searchSupComGrpAll(){
		$("#dg2").datagrid( {
			striped : true,
			rownumbers : false,
			singleSelect : true,
			pagination : true,
			pageSize : 10,
			queryParams : {
				comgrpName : $('#comgrpNameInput').val()=='输入集团名称查询'?'':$('#comgrpNameInput').val()
			},
			url : ctx + '/supplier/group/comGrpList',
			columns : [ [
							{
								field : 'ck',
								checkbox : false,
								halign : 'center',
								width : 5
							},
							{
								field : 'comgrpNo',
								title : groupNo,
								sortable : true,
								halign : 'center',
								align : 'right',
								width : 124,
								formatter : function(val, rec) {
									return val+"&nbsp;&nbsp;";
								}
							},
							{
								field : 'comgrpName',
								title : groupName,
								halign : 'center',
								align : 'left',
								width : 210
							},
							{
								field : 'comgrpEnName',
								title : groupenName,
								halign : 'center',
								align : 'left',
								width : 188
							}
							] ],
				onLoadSuccess : function(){
					setBorderRig('.Table_Panel');
				},
/* 				onClickRow : function(rowIndex, rowData) {
					confirmChooseComgrp(rowData.comgrpNo, rowData.comgrpName,rowData.comgrpEnName);
					closePopupWin();
				}, */
		        onDblClickRow : function(rowIndex, rowData){
		        	if ("${action }" == "create") {
			        	$("#add_comgrpNo").attr("value",rowData.comgrpNo).trigger('change');
			        	$("#add_comgrpNoName").attr("value",rowData.comgrpName);
		        	} else {
			        	$("#comgrpBrandNoSearch").attr("value",rowData.comgrpNo);
			        	$("#comgrpBrandNameSearch").attr("value",rowData.comgrpName);
		        	}
					confirmChooseComgrp(rowData.comgrpNo, rowData.comgrpName,rowData.comgrpEnName);
		        }  
		});
	}
	
	function searchSupComGrp() {
		searchSupComGrpAll();
	}
	function confirmBtn(obj){
		var rowData = $('#dg2').datagrid('getSelected');
		if(rowData){
			confirmChooseComgrp(rowData.comgrpNo, rowData.comgrpName,rowData.comgrpEnName);
	    	if (obj == "create") {
	        	$("#add_comgrpNo").attr("value",rowData.comgrpNo);
	        	$("#add_comgrpNoName").attr("value",rowData.comgrpName);
	    	} else {
	        	$("#comgrpBrandNoSearch").attr("value",rowData.comgrpNo);
	        	$("#comgrpBrandNameSearch").attr("value",rowData.comgrpName);
	    	}
		}else{
			top.jAlert('warning', '请选择集团',window.v_messages);
		}
	}
	function wipeBtn(){
		confirmChooseComgrp(null, null,null);
    	$("#add_comgrpNo").attr("value","");
    	$("#add_comgrpNoName").attr("value","");
    	
    	$("#comgrpBrandNoSearch").attr("value","");
    	$("#comgrpBrandNameSearch").attr("value","");

	}
</script>

<div class="Panel_top">
	<span><auchan:i18n id="102003009"></auchan:i18n></span><!-- 选择集团 -->
	<div class="PanelClose" style="margin-right: 0;"
		onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto; width: 97%; height: 100%;">
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" class="IS_input" value="" id="comgrpNameInput" placeholder="输入集团名称查询" />
				<div class="cbankIcon" onclick="searchSupComGrp()"></div>
			</div>
		</div>
		<div>
			<table id="dg2" style="height: 360px; width: 520px;"></table>
		</div>
	</div>
</div>
<div class="Panel_footer">
     <div class="PanelBtn1 pt_div" style="margin-left: 150px;" onclick="confirmBtn('${action }')"><auchan:i18n id="100000002"></auchan:i18n></div>
     <div class="PanelBtn1 pt_div" onclick="wipeBtn()">清除</div>
     <div class="PanelBtn2 pt_div" onclick="closePopupWin()"><auchan:i18n id="100000003"></auchan:i18n></div>
</div>