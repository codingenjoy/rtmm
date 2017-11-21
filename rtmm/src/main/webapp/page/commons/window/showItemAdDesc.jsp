<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			url : ctx + '/item/query/getItemAdDescByItemNo',
			columns : [ [ 
							{
								field : 'ck',
								checkbox : false,
								halign : 'center',
								width : 5
							},
							{
								field : 'seqNo',
								title : '编号',
								sortable : true,
								halign : 'center',
								align : 'right',
								width : 84,
								formatter : function(val, rec) {
									return val+"&nbsp;&nbsp;";
								}
							}, {
								field : 'adCnDesc',
								title : '中文',
								halign : 'center',
								align : 'left',
								width : 210,
								formatter : function(val, rec) {
									if(rec.adCnDesc){
										return "<span title='"+rec.adCnDesc+"'>"+rec.adCnDesc+"</span>";
									}else{
										return ;
									}
								}	
								
							}, {
								field : 'adEnDesc',
								title : '英文',
								halign : 'center',
								align : 'left',
								width : 210,
								formatter : function(val, rec) {
									if(rec.adEnDesc){
										return "<span title='"+rec.adEnDesc+"'>"+rec.adEnDesc+"</span>";
									}
									return ;
								}
							}
							] ],
		});
	});

</script>

<div class="Panel_top">
	<span>广告列表</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto; width: 97%; height: 100%;">
		<div class="">
			<table id="dg2" style="height: 360px; width: 520px;"></table>
		</div>
	</div>
</div>
