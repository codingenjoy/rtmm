<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" rel="Stylesheet" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<style type="text/css">
.Table_Panel {
	height: 450px;
	overflow: hidden;
}
.Table_Panel td {
	height: 30px;
}
</style>
	<div class="Panel_top">
		<span>选择条码</span>
		<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
	</div>
	<div class="Table_Panel">
		<div style="margin: 15px auto 0px auto; width: 97%; height: 100%;">
			<div style="height: 30px; background: #CCC;">
				<div class="Icon-div">
					<input type="text" class="IS_input" id="searchCond" placeholder="输入条码查询(支持模糊查询)"/>
					<div class="cbankIcon" onclick="searchItemByItemBarcode()"></div>
				</div>
			</div>
			<div class="search_tb_p">
				<table id="list_item_barcode" style="height: 400px;"></table>
			</div>
		</div>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
	     <div class="PanelBtn1" onclick="confirmBtn();">确认</div>
	     <div class="PanelBtn2" onclick="closePopupWin();">取消</div>
		</div>
	</div>
<script type="text/javascript">
	$(function(){
		init_datagrid();
	});
	function init_datagrid(){
		var searchCond = $.trim($('#searchCond').val()=='输入条码查询(支持模糊查询)'?'':$('#searchCond').val());
		var url = '';
		if(searchCond != null && searchCond != ""){
			url = ctx +'/commons/window/listItemBarcodeData';
		}
        $('#list_item_barcode').datagrid({
        	striped : true,
            rownumbers: false,
            pagination: true,
            singleSelect: true,
            pageSize: 10,
            queryParams : {
            	barcode : searchCond
            },
            url:  url,
            columns: [[
            {
            	field: 'ck',
                checkbox: false,
                width : 5
            },
            {
            	field: 'barcode', 
            	title: '条码', 
            	align: 'right', 
            	halign: 'center', 
				formatter : function(val, rec) {
					return rec.barcode;
				},
            	width: 115
            },
            {
            	field: 'itemNo', 
            	title: '货号', 
            	sortable: true, 
            	align: 'right', 
            	halign: 'center', 
    			formatter : function(val, rec){
    				return rec.itemNo + "&nbsp;&nbsp;";
    			},
            	width: 80 
            },
            {
            	field: 'itemName', 
            	title: '品名', 
            	sortable: true, 
            	halign: 'center', 
            	width: 280
            }
            ]],
            onDblClickRow: function(rowIndex, rowData){
            	confirmBtn();
            }
        });}
 		$("#searchCond").bind('keypress', function(e) {
			var code=e.keyCode;
			if (13==code) { 
				searchItemByItemBarcode(); 
			} 
		});
 		function searchItemByItemBarcode() {
 	 		init_datagrid();
 		}
 		function confirmBtn(){
 			var rowData = $('#list_item_barcode').datagrid('getSelected');
 			if(rowData){
	        	var callBack ="${callback}('"+rowData.itemNo+ "','"+rowData.itemName+"','"+rowData.barcode+"')";
	        	eval(callBack);
 	 		}
	        closePopupWin();
 		}
    </script>
