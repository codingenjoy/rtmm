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
<script type="text/javascript">

	$('#searchSupNo').keydown(function(e) {
		if (e.keyCode == 13) {
			search();
			return false;
		}
	});
    function search(){
    	$('#pageNo').val(1);
    	pageQuery();
    }
	function pageQuery() {
		var supNoOrName;
		var supName;
		var queryKey=$.trim($("#searchSupNo").val()) == "请输入厂商编号或名称查询" ? "" : $
				.trim($("#searchSupNo").val());
		if(queryKey==""||queryKey==undefined){	
			top.jAlert("warning","请输入查询条件","提示消息");
			return false;
		}
		if(/\d/.test(queryKey)){		
			supNoOrName=queryKey;
		}else{
			supName=queryKey;
		}
		var pageNo = $('#pageNo').val() || '1';
		var pageSize = $('#pageSize').val() || '10';
		$.ajax({
			type : "post",
			dataType : "html",
			data : {
				pageNo : pageNo,
				pageSize : pageSize,
				supNoOrName : supNoOrName,
				supName : supName
			},
			url : ctx + '/item/batchupdate/itemManufacturerSelectAction',
			success : function(data) {
				$('#update_items').html(data);
			}
		});
	}
</script>
<div class="Panel_top">
	<span>选择厂商</span>
	<div class="PanelClose" style="margin-right: 0;"
		onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto 0px auto; width: 97%; height: 100%;">
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" id="searchSupNo" placeholder="请输入厂商编号或名称查询"
					class="IS_input" />
				<div class="cbankIcon" onclick="search()"></div>
			</div>
		</div>
		<div class="search_tb_p">
			<div id="update_items" style="height: 400px;"></div>
		</div>
	</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div id="confirm" class="PanelBtn1" onclick="saveManufacturerNo()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize"
	value="${page.pageSize }" />

