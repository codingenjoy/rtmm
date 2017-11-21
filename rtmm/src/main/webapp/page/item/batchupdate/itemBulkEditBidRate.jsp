<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<script type="text/javascript">
    var itemBulkEditRateMap=new Map();
	$(document).ready(
			function() {
	           $("#Tools6").removeClass('Tools6')
						.addClass('Tools6_disable').unbind();
				$("#Tools11").removeClass('Tools11')
						.addClass('Tools11_disable').unbind();
				$("#Tools12").removeClass('Tools12')
						.addClass('Tools12_disable').unbind();
				$("#Tools2").attr('class', "Icon-size1 Tools2").bind("click",
						function() {
							saveSupItemVatChange();
						});
				getVatList();
				
				/*query the supNo and supName according by the supNo 
				  in the input box.*/  
			  $("#sel_supNo").unbind('blur').bind('blur',function(){
				  supNoAndNameQuery();
			  });
				$('#sel_supNo').keydown(function(e) {
					if (e.keyCode == 13) {
						$("#sel_supName").focus();
						supNoAndNameQuery();
						return false;
					}
				});
				  function supNoAndNameQuery(){
						var supNo;
						var queryKey=$.trim($("#sel_supNo").val()) == "请输入厂商编号或名称查询" ? "" : $
								.trim($("#sel_supNo").val());
						if(queryKey==""||queryKey==undefined){	
							return false;
						}
						if(/\d/.test(queryKey)){		
							if(/^[0-9]{1,8}$/.test(queryKey)){
								supNo=queryKey;
							}
						}
						var pageNo = $('#pageNo').val() || '1';
						var pageSize = $('#pageSize').val() || '10';
						$.ajax({
							type : "post",
							dataType : "html",
							data : {
								pageNo : pageNo,
								pageSize : pageSize,
								supNo : supNo
							},
							url : ctx + '/item/batchupdate/itemManufacturerSelectAction',
							success : function(data) {
								$("#sel_supNo").val($(data).find('input[name=supNo]').val());
								$("#sel_supName").val($(data).find('input[name=supName]').val());
							}
						});
				  }
			});
	
</script>

<style type="text/css">
.CInfo .combo,.CInfo input {
	background-color: #cccccc;
}

.sp_icon2 {
	margin-top: 8px;
}

.txtarea {
	margin-left: 15px;
	height: 200px;
}

.sp_icon4 {
	margin-top: 8px;
}

.sp_tb {
	height: 290px;
	overflow-y: auto;
}

.txm_title {
	border-top: 1px solid #ccc;
	height: 30px;
	line-height: 30px;
	margin-top: 20px;
}

.txm_info {
	margin-left: 10px;
	width: 650px;
	border-top: 1px solid #ccc;
}

.sp_icon1 {
	margin-top: 12px;
	margin-right: 5px;
}

.sp_icon3 {
	margin-top: 7px;
}

.txm_title {
	border-top: 0px;
	margin-top: 0px;
}
.CInfo{
   height : 0px;
} 
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<input type="hidden" id="itemBulkEditNo">
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM_q  tagsM_on">修改商品厂商特殊进价税率</div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Content">
		<div class="CInfo"></div>
		<div style="height: 60px;" class="CM">
			<div class="hh_item">
				<div class="icol_text w5">
					<span>厂商</span>
				</div>
				<div class="iconPut iq" style="width: 13%;">
					<input id="sel_supNo" style="width: 83%" type="text"
						onchange="itemEditRateChageSup()" />
					<div class="ListWin" onclick="supplierList()"></div>
				</div>
				<input id="sel_supName" class="inputText iq Black"
					style="width: 20%;" type="text" readonly="readonly" />

			</div>
		</div>
		<div style="height: 400px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>需要修改的商品</div>
			</div>
			<div class="CM-div">
				<div class="ig need_update_item" style="margin-left: 15px;">
					<input id="all_select" class="sp_icon1" name="1" type="radio"
						onclick="itemEditBidRateAllSelect()" />
					<div class="sp_icon2">选择全部关联商品</div>
					<div class="Icon-size2 sp_icon3 "></div>
					<input id="part_select" class="sp_icon1" name="1" type="radio"
						checked="checked" />
					<div class="sp_icon2">选择部分关联商品</div>
				</div>
				<div class="txm_info all_select" style="display: none;">
					<!--txm_title sp_tb ig-->
				</div>
				<div class="txm_info part_select">
					<div class="txm_title">
						<span style="margin-left: 60px;">货号</span><span
							style="margin-left: 155px;">品名</span> <span
							style="margin-left: 145px;">状态</span><span
							style="margin-left: 70px;">特殊进价税率(%)</span>
					</div>
					<div id="supSelectedItems" class="sp_tb"></div>
					<div class="ig">
						<input class="sp_icon1 isCheckAllss" type="checkbox" />
						<div class="Icon-size2 Tools10 sp_icon4 deleteCheckeds"
							onclick="itemBulkEditRateDel()"></div>
						<div class="Icon-size2 Line-1 sp_icon3 "></div>
						<div class="Icon-size2 Tools11 sp_icon4"
							onclick="itemEditBidRateSel($('#sel_supNo').val(), stringItemNo())"></div>
						<div class="Icon-size2 Line-1 sp_icon3 "></div>
						<div class="Icon-size2 copy sp_icon4"
							onclick="itemEditBidRatePas($('#sel_supNo').val(), stringItemNo())"></div>
					</div>
				</div>
			</div>
		</div>
		<div style="height: 60px; margin-top: 2px;" class="CM">
			<div class="CM-bar">
				<div>新税率</div>
			</div>
			<div class="CM-div">
				<div class="hh_item">
					<div class="icol_text w12_5">
						<span>新的特殊进价税率&nbsp;&nbsp;</span>
					</div>
					<select id="vatCode" class="inputText iq w10"
						onblur="$(this).removeClass('errorInput')">
					</select>
				</div>
			</div>
		</div>
	</div>
</div>