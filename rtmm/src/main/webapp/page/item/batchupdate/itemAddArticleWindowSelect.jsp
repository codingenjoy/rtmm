<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/jquery/jquery.placeholder.js" type="text/javascript"></script>
<link type="text/css"
	href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css"
	rel="Stylesheet" />
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
	<span id="supplierSpan">选择新增厂商</span>
	<div class="PanelClose" style="margin-right: 0;"
		onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto 0px auto; width: 97%; height: 100%;">
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" class="IS_input" placeholder="请输入厂商编号和名称进行查询"
					id="cancelSupplierNo" />
				<div class="cbankIcon" onclick="search()"></div>
			</div>
		</div>
		<div class="search_tb_p">
			<div id="itemBulkEditSelect" style="height: 400px;"></div>
		</div>
	</div>
</div>
<div class="Panel_footer">
	<div class="PanelBtn">
		<div class="PanelBtn1" onclick="itemAddArticleSave()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>
<input type="hidden" id="selItemNos" />
<input type="hidden" id="itemNoStr" />
<input type="hidden" id="itemNoStrUn" />
<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize" value="${page.pageSize }" />
<script type="text/javascript">

	$('#cancelSupplierNo').keydown(function(e) {
		if (e.keyCode == 13) {
			search();
			return false;
		}
	});
	$(function() {
		var cancelHidden = $("#cancelHidden").val();
		if (cancelHidden == "cancel") {
			$("#supplierSpan").text("选择需要取消的厂商");
		}
	});
    function search(){
    	$('#pageNo').val(1);
    	pageQuery();
    }
	function pageQuery() {
		var supNoOrName;
		var supName;
		var queryKey = $.trim($("#cancelSupplierNo").val()) == "请输入厂商编号和名称进行查询" ? ""
				: $.trim($("#cancelSupplierNo").val());
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
						itemNo : $.trim($("#sel_itemArticleNo").val()),
						hidden : $.trim($("#cancelHidden").val()),
						supNoOrName : supNoOrName,
						supName : supName
					},
					url : ctx + '/item/batchupdate/itemAddArticleSelectAction',
					success : function(data) {
						$('#itemBulkEditSelect').html(data);
					}
				});
	}
</script>