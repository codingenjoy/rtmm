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
				<div id="update_items" style="height: 400px;">
				</div>
			</div>
		</div>
	</div>
	<div class="Panel_footer">
		<div class="PanelBtn">
			<div id="confirm" class="PanelBtn1" onclick="confirmSelected()">确定</div>
			<div class="PanelBtn2" onclick="closePopupWin()">取消</div>
		</div>
	</div>
	<input type="hidden" name="pageNo" id="pageNo" value="${page.pageNo }" />
<input type="hidden" name="pageSize" id="pageSize" value="${page.pageSize }" />
<input type="hidden" name="catlgId" id="catlgId" value="${catlgId }" />

<script type="text/javascript">

	$('#searchSupNo').keydown(function(e) {
		if (e.keyCode == 13) {
			search();
		}
	});
	
    function search(){
    	$('#pageNo').val(1);
    	pageQuery();
    }
    
	function pageQuery() {
		var supNoOrComName="";
		var comName="";
		var queryKey=$.trim($("#searchSupNo").val()) == "请输入厂商编号或名称查询" ? "" : $
				.trim($("#searchSupNo").val());
		if(queryKey==""||queryKey==undefined){
			top.jWarningAlert("请输入查询条件");	
			return false;
		}
		if(/\d/.test(queryKey)){		
			supNoOrComName=queryKey;
		}else{
			comName=queryKey;
		}
		var pageNo = $('#pageNo').val() || '1';
		var pageSize = $('#pageSize').val() || '10';
		var catlgId = $('#catlgId').val();

		
		$.ajax({
			type : "post",
			dataType : "html",
			data : {
				pageNo : pageNo,
				pageSize : pageSize,
				supNoOrComName : supNoOrComName,
				comName : comName,
				catlgId:catlgId
			},
			url : ctx + '/hoOrderCreate/itemManufacturerSelectAction',
			success : function(data) {
				$('#update_items').html(data);
			}
		});
	}

	var supInfo = {};
	//双击事件
	function onClick(supNo,comName,comNo,unifmNo,supType){
		supInfo.supNo = supNo;
		supInfo.comName = supInfo;
		supInfo.comNo = comNo;
		supInfo.supInfo = unifmNo;
		supInfo.supType = supType;
	}

	//双击事件
	function onDbClick(supNo,comName,comNo,unifmNo,supType){
		supInfo.supNo = supNo;
		supInfo.comName = supInfo;
		supInfo.comNo = comNo;
		supInfo.supInfo = unifmNo;
		supInfo.supType = supType;
		confirmSelected();
	}

	function confirmSelected(){
		if(!supInfo||!supInfo.supNo){
			top.jWarningAlert('请选择厂商！');
			return;
		}
		saveManufacturerNo(supInfo.supNo);
		closePopupWin();
	}
</script>
