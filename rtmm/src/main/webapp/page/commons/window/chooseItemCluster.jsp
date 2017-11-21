<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js"
	type="text/javascript"></script>
<script src="${ctx}/shared/js/jumpPage.js" type="text/javascript"></script>
<style type="text/css">
.Table_Panel {
	height: 450px;
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
	function pageQuery() {
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		var responsePage = "commons/window/clusterInfoPage";
		var clusterName = $('#clusterNameInput').val();
		var queryflag = true;
		if ($.trim(clusterName) == '' || $.trim(clusterName) == '输入系列编号或系列名称查询') {
			queryflag = false;
		}
		$.ajax({
			type : "post",
			data : {
				responsePage : responsePage,
				pageNo : pageNo,
				clstrName : clusterName,
				pageSize : pageSize,
				catlgId:$('#kebieInput2').val()
			},
			dataType : "html",
			url : ctx + "/item/create/getClusterListByPage",
			success : function(data) {
				$('#cluster_content').html(data);
				if(!queryflag)
				{
					top.jAlert('warning', '请输入查询条件', '消息提示');
					}
			}
		});
	}
</script>
<div class="Panel_top">
	<span>选择系列</span>
	<div class="PanelClose" style="margin-right: 0;"
		onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto; width: 97%; height: 100%;">
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" class="IS_input" value="" id="clusterNameInput"
					name="clusterName" placeholder="输入系列编号或系列名称查询" />
				<div class="cbankIcon" onclick='pageQuery()'></div>
			</div>
		</div>
		<div class="Container-1" id="clusterListDiv">
			<div class="Content" id="cluster_content">
				<%@ include file="/page/commons/window/clusterInfoPage.jsp"%>
			</div>
		</div>
	</div>
</div>
