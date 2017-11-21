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
		<span>选择货号</span>
		<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
	</div>
	<div class="Table_Panel">
		<div style="margin: 15px auto 0px auto; width: 97%; height: 100%;">
			<div style="height: 30px; background: #CCC;">
				<div class="Icon-div">
					<input type="text" class="IS_input" id="searchItemNo" placeholder="请选择商品货号或品名查询"/>
					<div class="cbankIcon" onclick="search()"></div>
				</div>
			</div>
			<div class="search_tb_p">
				<table id="update_items" style="height: 400px;"></table>
			</div>
		</div>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="saveSonCorrelationFullArticleNo()">确定</div>
			<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
		</div>
	</div>
	<input type="hidden" id="itemIndexHidden" value="${itemIndex }" />	
<script type="text/javascript">


      function search(){
	     $('#pageNo').val(1);
	     itemCorrelationArticle_datagrid();
      }
	$(function(){
	     $('#searchItemNo').keydown(function (e) {
             if (e.keyCode == 13) {
            	 search();
             }
       });
	});
	function itemCorrelationArticle_datagrid(){
		var itemNoOrName;
		var itemName;
		var queryKey=$.trim($("#searchItemNo").val()) == '请选择商品货号或品名查询' ? '' : $.trim($("#searchItemNo").val());
		if(queryKey==""||queryKey==undefined){	
			top.jAlert("warning","请输入查询条件","提示消息");
			return false;
		}
		if(/\d/.test(queryKey)){		
			itemNoOrName=queryKey;
		}else{
			itemName=queryKey;
		}
        $('#update_items').datagrid({
            rownumbers: false,
            pagination: true,
            singleSelect: true,
            pageSize: 10,
            queryParams : {
            	parentItemNo : $("#sel_itemArticleNo").val(),
            	itemType : $("#itemType").val(),
				itemNoOrName : itemNoOrName,
				itemName : itemName,
            },
            url: ctx + '/item/basicInformation/sonItemNoListAction',
            columns: [[
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
            	width: 385
            },
            {
            	field: 'status', 
            	title: '状态', 
            	halign: 'center', 
				formatter : function(val, rec) {
					return getDictValue('ITEM_BASIC_STATUS',rec.status);
				},
            	width: 120
            }
            ]],
            onDblClickRow: function(rowIndex, rowData){
            	saveSonCorrelationFullArticleNo();
            }
        });
	}
    </script>
