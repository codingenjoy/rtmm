<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js"
	type="text/javascript"></script>
<%-- <script src="${ctx}/shared/js/jumpPage.js" type="text/javascript"></script> --%>
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
/* 	function pageQuery() {
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		var responsePage = "commons/window/vatInfoPage";
		var vatNo = $('#vatNoInput').val();
		$.ajax({
			type : "post",
			data : {
				responsePage : responsePage,
				pageNo : pageNo,
				vatNo : vatNo,
				pageSize : pageSize
			},
			dataType : "html",
			url : ctx + "/item/create/getVatListByPage",
			success : function(data) {
				$('#vat_content').html(data);
			}
		});
	} */
</script>

<div class="Panel_top">
	<span>选择税率</span>
	<div class="PanelClose" style="margin-right: 0;"
		onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto; width: 97%; height: 100%;">
<!-- 		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" class="IS_input" value="" id="vatNoInput"
					name="vatVal" placeholder="输入税号称查询" />
				<div class="cbankIcon" onclick='pageQuery()'></div>
			</div>
		</div> -->
		<div class="Container-1" id="vatListDiv">
			<div class="Content" id="vat_content">
				<%@ include file="/page/commons/window/vatInfoPage.jsp"%>
			</div>
		</div>
	</div>
</div>
