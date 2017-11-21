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
	function pageQuery1() {
		var pageNo = $('#pageNo1').val()||'1';
		var pageSize = $('#pageSize1').val()||'10';
		var responsePage = "item/batchupdate/itemBrandInfoPage";
		var brandIdOrName;
		var brandName;
		var queryKey=$.trim($('#brandNameInput').val()) == '请输入品牌ID或名称查询' ? '' : $.trim($("#brandNameInput").val());
		if(queryKey==""||queryKey==undefined){	
			top.jAlert("warning","请输入查询条件","提示消息");
			return false;
		}
		if(/\d/.test(queryKey)){		
			brandIdOrName=queryKey;
		}else{
			brandName=queryKey;
		}
		$.ajax({
			type : "post",
			data : {
				responsePage : responsePage,
				brandNo : '${brandNo}',
				pageNo : pageNo,
				brandIdOrName : brandIdOrName,
				brandName : brandName,
				pageSize : pageSize
			},
			dataType : "html",
			url : ctx + "/item/batchupdate/getBrandList",
			success : function(data) {
				$('#brand_content').html(data);
			}
		});
	}
</script>
<input type="hidden" name="pageNo" id="pageNo1" value="${page.pageNo }" />
<div class="Panel_top">
	<span>选择品牌</span>
	<div class="PanelClose" style="margin-right: 0;"
		onclick="closePopupWin()"></div>
</div>
<div class="Table_Panel">
	<div style="margin: 15px auto; width: 97%; height: 100%;">
		<div style="height: 30px; background: #CCC;">
			<div class="Icon-div">
				<input type="text" class="IS_input" value="" id="brandNameInput"
					name="brandName" placeholder="请输入品牌ID或名称查询" />
				<div class="cbankIcon" onclick='pageQuery1()'></div>
			</div>
		</div>
		<div class="Container-1" id="brandListDiv">
			<div class="Content" id="brand_content">
				<%@ include file="/page/item/batchupdate/itemBrandInfoPage.jsp"%>
			</div>
		</div>
	</div>
</div>
