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
		<span>选择子货号</span>
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
			<div class="search_tb_p" id="itemCorreSonArticleSel">
				<table id="update_items" style="height: 400px;"></table>
			</div>
		</div>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div class="PanelBtn1" onclick="saveSonCorrelationArticleNo()">确定</div>
			<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
		</div>
	</div>
<script type="text/javascript">
	$(function(){
	     $('#searchItemNo').keydown(function (e) {
             if (e.keyCode == 13) {
            	 search();
             }
       });
	});
    function search(){
    	$('#pageNo').val(1);
    	itemCorrelationArticle_datagrid();
    }
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
            singleSelect: false,
            idField : 'itemNo',
            pageSize: 10,
            queryParams : {
            	parentItemNo : $("#sel_itemArticleNo").val(),
            	itemType : $("#itemType").val(),
				itemNoOrName : itemNoOrName,
				itemName : itemName	
            },
            url: ctx + '/item/basicInformation/sonItemNoListAction',
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
            onBeforeLoad : function(node,param){
            	
            	$("#itemCorreSonArticleSel :checkbox").attr("checked",false);
            },
			onLoadSuccess : function(data) {
				if ('${itemIndex }' != '') {
					var items = '${itemIndex }'.split(",");
					$.each(items, function(index, item) {
						var i = $('#update_items').datagrid(
								"getRowIndex", item);
						if (i != -1) {
							$('#update_items').datagrid("checkRow", i);
						}
					});
				}

			},
			onCheck : function(rowIndex,rowData){
					 var itemNoStr = $("#itemNoStr").val();
					 var itemIndex=itemNoStr.indexOf(','+rowData.itemNo+',');
					 if(itemIndex<0){
						 itemNoStr = itemNoStr + rowData.itemNo + ","; 
					 }
					 $("#itemNoStr").val(itemNoStr);
			},
			onUncheck: function(rowIndex,rowData){
					 var itemNoStr = $("#itemNoStr").val();
					 var itemIndex=itemNoStr.indexOf(','+rowData.itemNo+',');
					 if(itemIndex>=0){
						 itemNoStr = itemNoStr.replace(','+rowData.itemNo+',',',');
					 }
					 $("#itemNoStr").val(itemNoStr);
			},
			onCheckAll : function(rowIndex, rowData){
				$.each(rowIndex, function(i,val){
					 var itemNoStr = $("#itemNoStr").val();
					 var itemIndex=itemNoStr.indexOf(','+val.itemNo+',');
					 if(itemIndex<0){
						 itemNoStr = itemNoStr + val.itemNo + ","; 
					 }
					 $("#itemNoStr").val(itemNoStr);
				});
			},
			onUncheckAll : function(rowIndex, rowData){
				$.each(rowIndex, function(i,val){
					 var itemNoStr = $("#itemNoStr").val();
					 var itemIndex=itemNoStr.indexOf(','+val.itemNo+',');
					 if(itemIndex>=0){
						 itemNoStr = itemNoStr.replace(','+val.itemNo+',',',');
					 }
					 $("#itemNoStr").val(itemNoStr);
				});
			}
        });
	}
    </script>
