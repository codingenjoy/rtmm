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
			url : ctx + '/item/query/getItemSeTopicListByItemNo',
			columns : [ [ 
							{
								field : 'ck',
								checkbox : false,
								halign : 'center',
								width : 5
							},
							{
								field : 'topicNo',
								title : 'SE期数',
								sortable : true,
								halign : 'center',
								align : 'right',
								width : 84,
								formatter : function(val, rec) {
									return val+"&nbsp;&nbsp;";
								}
							}, {
								field : 'topicName',
								title : 'SE主题',
								halign : 'center',
								align : 'left',
								width : 204,
							},{
								field : 'beginDate',
								title : '开始月份',
								halign : 'center',
								align : 'left',
								width : 112,
								formatter : function(val, rec) {
									return rec.buyBeginMth+"/"+rec.buyBeginDay;
								}
							},{
								field : 'endDate',
								title : '结束月份',
								halign : 'center',
								align : 'left',
								width : 110,								
								formatter : function(val, rec) {
									return rec.buyEndMth+"/"+rec.buyEndDay;
								}
							}
							] ],
		});
	});

</script>

<div class="Panel_top">
	<span>季节期数列表</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto; width: 97%; height: 100%;">
		<div class="">
			<table id="dg2" style="height: 360px; width: 520px;"></table>
		</div>
	</div>
</div>
