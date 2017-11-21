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
	<span>选择厂商</span>
	<div class="PanelClose" style="margin-right: 0;" onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto 0px auto; width: 97%; height: 100%;">
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" id="searchSupNo" placeholder="请输入厂商编号或名称查询" class="IS_input" />
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
		<div id="confirm" class="PanelBtn1" onclick="confirmSelected()">确定</div>
		<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
	</div>
</div>

<script type="text/javascript">
	$('#searchSupNo').keydown(function(e) {
		if (e.keyCode == 13) {
			search();
		}
	});

	function search() {
		$('#pageNo').val(1);
		pageQuery();
	}

	function pageQuery() {
		var supNoOrComName = "";
		var comName = "";
		var queryKey = $.trim($("#searchSupNo").val()) == "请输入厂商编号或名称查询" ? ""
				: $.trim($("#searchSupNo").val());
		if (queryKey == "" || queryKey == undefined) {
			top.jAlert("warning", "请输入查询条件", "提示消息");
			return false;
		}
		if (/\d/.test(queryKey)) {
			supNoOrComName = queryKey;
		} else {
			comName = queryKey;
		}
		var pageNo = $('#pageNo').val() || '1';
		var pageSize = $('#pageSize').val() || '10';
		var catlgId = $('#catlgId').val();
		
		// 計算有沒有 overflow 頁數
		if (pageSize*(pageNo-1)>$("#totalCount").val()){
			pageNo = 1;
		}
		
		$.ajax({
			type : "post",
			dataType : "html",
			data : {
				pageNo : pageNo,
				pageSize : pageSize,
				supNoOrComName : supNoOrComName,
				comName : comName,
				catlgId : catlgId
			},
			url : ctx + '/hoOrderCreate/itemManufacturerSelectAction',
			success : function(data) {
				$('#update_items').html(data);
			}
		});
	}

	var supInfo = {};
	//双击事件
	function onClick(supNo, comName, comNo, unifmNo, supType,cntrtType,buyMethd) {
		supInfo.supNo = supNo;
		supInfo.comName = comName;
		supInfo.comNo = comNo;
		supInfo.unifmNo = unifmNo;
		supInfo.supType = supType;
		supInfo.cntrtType = cntrtType;
		supInfo.buyMethd = buyMethd;
	}

	//双击事件
	function onDbClick(supNo, comName, comNo, unifmNo, supType,cntrtType,buyMethd) {
		supInfo.supNo = supNo;
		supInfo.comName = comName;
		supInfo.comNo = comNo;
		supInfo.unifmNo = unifmNo;
		supInfo.supType = supType;
		supInfo.cntrtType=cntrtType;
		supInfo.buyMethd=buyMethd;
		confirmSupplierSelected(supInfo);
		closePopupWin();
	}

	function confirmSelected() {
		if (!supInfo || !supInfo.supNo) {
			top.jAlert('warning', '请选择厂商！', '提示消息');
			return;
		}
		confirmSupplierSelected(supInfo);
		closePopupWin();
	}
</script>
