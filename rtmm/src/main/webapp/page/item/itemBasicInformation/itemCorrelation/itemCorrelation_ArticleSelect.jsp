<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" rel="Stylesheet" />
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
		<span>选择货号</span>
		<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
	</div>
	<div class="Table_Panel">
		<div style="margin: 15px auto 0px auto; width: 97%; height: 100%;">
			<div style="height: 30px; background: #CCC;">
				<div class="Icon-div">
					<input type="text" class="IS_input" id="searchItemNo" placeholder="请选择商品货号"/>
					<div class="cbankIcon" onclick="itemCorrelationArticle_datagrid()"></div>
				</div>
			</div>
			<div class="search_tb_p">
				<table id="update_items" style="height: 400px;"></table>
			</div>
		</div>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="saveCorrelationArticleNo()">确定</div>
			<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
		</div>
	</div>
<script type="text/javascript">
	$(function(){
		itemCorrelationArticle_datagrid();
	});
	function itemCorrelationArticle_datagrid(){
        $('#update_items').datagrid({
            rownumbers: false,
            pagination: true,
            singleSelect: true,
            pageSize: 10,
            queryParams : {
            	itemNo : $.trim($("#searchItemNo").val())=="请选择商品货号"?"":$.trim($("#searchItemNo").val())
            },
            url: ctx + '/item/basicInformation/itemCorrelationArticleSelectAction',
            columns: [[
            {
            	field: 'ck',
                checkbox: true
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
            	title: '商品名称', 
            	sortable: true, 
            	halign: 'center', 
            	width: 415
            },
            { 
            	field: 'status', 
            	title: '状态', 
            	halign: 'center', 
				formatter : function(val, rec) {
					return getDictValue('ITEM_BASIC_STATUS',rec.status);
				},
            	width: 80
            }
            ]],
            onDblClickRow: function(rowIndex, rowData){
/*             	$("#sel_itemArticleNo").val(rowData.itemNo);
            	$("#sel_itemArticleName").val(rowData.itemName); */
            	closePopupWin();
            	item_itemCorrelation(rowData.itemNo);
            }
        });
	}
    </script>
