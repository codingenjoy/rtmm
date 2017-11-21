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
	height: 440px;
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
		var supNo = $('#supNoInput').val() ;
		if ($.trim(supNo) != '' && supNo != "输入厂商号或厂商名称") {
			supNo = $('#supNoInput').val();
		} else {
			top.jAlert('warning', '请输入查询条件', '消息提示');
			return;
		}
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		var responsePage = "commons/window/supplierInfoPage";
		var catlgId = null;
		var queryUrl ="/item/create/getSupListByPage";
		if(item_create_content == 5)
		{
			catlgId = $('#kebieInput2').val();
			queryUrl=queryUrl+"?catlgId=" + catlgId;
		}
		
		$.ajax({
			type : "post",
			data : {
				responsePage : responsePage,
				comName : supNo,
				pageNo : pageNo,
				pageSize : pageSize
			},
			dataType : "html",
			url : ctx + queryUrl,
			success : function(data) {
				$('#sup_content').html(data);
			}
		});
	}
	
	$(function(){
		$('#supNoInput').keydown(function (e) {
            if (e.keyCode == 13) {
            	pageQuery();
            }
        });
		inputToInputIntNumber();
	});
</script>

<div class="Panel_top">
	<span>选择厂商</span>
	<div class="PanelClose" style="margin-right: 0;"
		onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto; width: 97%; height: 100%;">
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" class="IS_input" value="" id="supNoInput"
					name="supNo" placeholder="输入厂商号或厂商名称"/>
				<div class="cbankIcon" onclick='pageQuery()'></div>				
			</div>
		</div>
		<div class="Container-1" id="supListDiv">
			<div class="Content" id="sup_content">
				<%@ include file="/page/commons/window/supplierInfoPage.jsp"%>
			</div>
		</div>
	</div>
</div>
