<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<style type="text/css">
.Table_Panel {
	height: 406px;
	overflow: hidden;
}

.Table_Panel td {
	height: 30px;	
}
.Panel_footer div{
margin-top:3px;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#dg2").datagrid({
			striped : true,
			rownumbers : false,
			singleSelect : true,
			pagination : true,
			pageSize : 10,
			queryParams : {
				itemNo :'${itemNoSearch}'
			},
			url : ctx + '/item/query/getItemClusterListByItemNo',
			columns : [ [ 
							{
								field : 'ck',
								checkbox : false,
								halign : 'center',
								width : 5
							},
							{
								field : 'clstrId',
								title : '系列编号',
								sortable : true,
								halign : 'center',
								align : 'right',
								width : 82,
								formatter : function(val, rec) {
									return val+"&nbsp;&nbsp;";
								}
							}, {
								field : 'clstrName',
								title : '系列名称',
								halign : 'center',
								align : 'left',
								width : 288,
							},{
								field : 'clstrType',
								title : '系列类型',
								halign : 'center',
								align : 'left',
								formatter : function(val, rec) {
									return getDictValue('ITEM_CLUSTER_CLSTR_TYPE',rec.clstrType);
								},
								width : 144
							}
							] ],
		});
	});

</script>

<div class="Panel_top">
	<span>所属系列列表</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto; width: 97%; height: 100%;">
		<div class="">
			<table id="dg2" style="height: 360px; width: 520px;"></table>
		</div>
	</div>
</div>
