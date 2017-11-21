<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>

<script type="text/javascript">
	$(document).ready(function(){
        $("#Tools6").removeClass('Tools6')
                   .addClass('Tools6_disable').unbind();
		$("#Tools11").removeClass('Tools11')
				.addClass('Tools11_disable').unbind();
		$("#Tools12").removeClass('Tools12')
				.addClass('Tools12_disable').unbind();

		$("#Tools2").attr('class', "Icon-size1 Tools2").bind("click",
				function() {
					//companyDetailed();
					cancelItemManualfacturer();
				});
		$("#dis_supplier").bind("click", function() {
			$("#Tools2").unbind("click").bind("click", function() {
				cancelItemManualfacturer();
			});
		});
		$("#dis_item").bind("click", function() {
			$("#Tools2").unbind("click").bind("click", function() {
				cancelSupplierManualfacturer();
			});
		});
		
		/*query the itemNo and itemName according by the itemNo 
		  in the input box.*/
		  $("#sel_itemArticleNo").unbind('blur').bind('blur',function(){
			       itemNoAndNameQuery();
		  });
			$('#sel_itemArticleNo').keydown(function(e) {
				if (e.keyCode == 13) {
					$("#sel_itemArticleName").focus();
					itemNoAndNameQuery();
					return false;
				}
			});
		  function itemNoAndNameQuery(){
				var itemNo;
				var queryKey = $.trim($("#sel_itemArticleNo").val()) == "请输入商品货号或名称查询" ? "" : $
						.trim($("#sel_itemArticleNo").val());
				if(queryKey==""||queryKey==undefined){	
					return false;
				}
				if(/\d/.test(queryKey)){
					if(/^[0-9]{1,8}$/.test(queryKey)){
						itemNo=queryKey;
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
						itemNo : itemNo
					},
					url : ctx + '/item/batchupdate/itemArticleSelectAction',
					success : function(data) {
						$("#sel_itemArticleNo").val($(data).find('input[name=itemNo]').val());
						$("#sel_itemArticleName").val($(data).find('input[name=itemName]').val());
					}
				});
		  }
	/*query the supNo and supName according by the supNo 
		  in the input box.*/  
	  $("#sel_itemManufacturerNo").unbind('blur').bind('blur',function(){
		  supNoAndNameQuery();
	  });
		$('#sel_itemManufacturerNo').keydown(function(e) {
			if (e.keyCode == 13) {
				$("#sel_itemManufacturerName").focus();
				supNoAndNameQuery();
				return false;
			}
		});
		  function supNoAndNameQuery(){
				var supNo;
				var queryKey=$.trim($("#sel_itemManufacturerNo").val()) == "请输入厂商编号或名称查询" ? "" : $
						.trim($("#sel_itemManufacturerNo").val());
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
						$("#sel_itemManufacturerNo").val($(data).find('input[name=supNo]').val());
						$("#sel_itemManufacturerName").val($(data).find('input[name=supName]').val());
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
	height: 270px;
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
}

.sp_icon1 {
	margin-top: 12px;
	margin-right: 5px;
}

.sp_icon3 {
	margin-top: 7px;
}
.CInfo{
   height : 0px;
} 
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<input type="hidden" id="itemBulkEditNo">
<input type="hidden" id="supBulkEditNo">
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM_q  tagsM_on">取消商品厂商关联</div>
     <div class="tags tags3_r_on"></div>
</div>
<input type="hidden" id="cancelHidden" value="cancel" />
<div class="Container-1">
	<div class="Content">
		<div class="CInfo"></div>

		<div style="height: 60px;" class="CM">
			<div class="ig dis_item_supplier">
				<input id="dis_supplier" type="radio" name="a" checked="checked"
					onclick="cancelSupForItem()" /><span
					style="margin-left: 5px; margin-right: 50px;">为商品取消厂商</span> <input
					id="dis_item" type="radio" name="a" onclick="cancelItemForSup()" /><span
					style="margin-left: 5px;">为厂商取消商品</span>
			</div>
		</div>
		<div style="height: 60px; margin-top: 2px;" class="CM dis_supplier">
			<div class="CM-bar">
				<div>商品</div>
			</div>
			<div class="CM-div">
				<div class="hh_item">
					<div class="icol_text w5">
						<span>货号</span>
					</div>
					<div class="iconPut iq" style="width: 13%;">
						<input id="sel_itemArticleNo" style="width: 83%"
							onblur="$(this).removeClass('errorInput')" type="text" />
						<div class="ListWin" onclick="itemArticleSelect()"></div>
					</div>
					<input id="sel_itemArticleName" class="inputText iq Black"
						readonly="readonly" style="width: 20%;" type="text" />
				</div>
			</div>
		</div>
		<div style="height: 400px; margin-top: 2px;" class="CM dis_supplier">
			<div class="CM-bar">
				<div>取消关联的厂商</div>
			</div>
			<div class="CM-div">
				<div class="ig" style="margin-left: 15px;">
					<input class="sp_icon1" name="assoSup" type="radio" value="1"
						onclick="assoAllSup()" />
					<div class="sp_icon2">选择全部关联厂商</div>
					<div class="Icon-size2 sp_icon3 "></div>
					<input class="sp_icon1" name="assoSup" type="radio" value="0"
						checked="checked" onclick="assoSecSup()" />
					<div class="sp_icon2">选择部分关联厂商</div>
				</div>
				<div class="txm_info">
					<div class="txm_title">
						<span style="margin-left: 60px;">厂编</span><span
							style="margin-left: 100px;">公司名称</span> <span
							style="margin-left: 90px;">状态</span>
					</div>
					<div id="div_itemArticle" class="sp_tb" style="overflow-y: auto;">
					</div>
					<div class="ig">
						<input class="sp_icon1 isCheckAllss" type="checkbox"
							id="itemCheckAllIcon" />
						<div class="Icon-size2 deleteCheckeds Tools10 sp_icon4"
							id="itemDeleteCheckedIcon" onclick="supBulkEditDel()"></div>
						<div class="Icon-size2 Line-1 sp_icon3 "></div>
						<div class="Icon-size2 Tools11 sp_icon4" id="itemBulkEditSelIcon"
							onclick="itemSupplierAddArticleSelect()"></div>
						<div class="Icon-size2 Line-1 sp_icon3 "></div>
						<div class="Icon-size2 copy sp_icon4" id="itemBulkEditPasIcon"
							onclick="itemManualAddArticleSelect()"></div>
					</div>
				</div>
			</div>
		</div>

		<div style="height: 60px; margin-top: 2px; display: none;"
			class="CM dis_item">
			<div class="CM-bar">
				<div>厂商</div>
			</div>
			<div class="CM-div">
				<div class="hh_item">
					<div class="icol_text w5">
						<span>厂商</span>
					</div>
					<div class="iconPut iq" style="width: 13%;">
						<input id="sel_itemManufacturerNo" style="width: 83%" type="text"
							onblur="$(this).removeClass('errorInput')" />
						<div class="ListWin" onclick="itemManufacturerSelect()"></div>
					</div>
					<input id="sel_itemManufacturerName" class="inputText iq Black"
						readonly="readonly" style="width: 20%;" type="text" />
				</div>
			</div>
		</div>
		<div style="height: 400px; margin-top: 2px; display: none;"
			class="CM dis_item">
			<div class="CM-bar">
				<div>取消关联的商品</div>
			</div>
			<div class="CM-div">
				<div class="ig" style="margin-left: 15px;">
					<input class="sp_icon1" name="assoItem" type="radio" value="1"
						onclick="assoAllItem()" />
					<div class="sp_icon2">选择全部关联商品</div>
					<div class="Icon-size2 sp_icon3 "></div>
					<input class="sp_icon1" name="assoItem" onclick="isCheckAll()"
						value="0" type="radio" checked="checked" />
					<div class="sp_icon2">选择部分关联商品</div>
				</div>
				<div class="txm_info">
					<div class="txm_title">
						<span style="margin-left: 60px;">货号</span><span
							style="margin-left: 120px;">品名</span> <span
							style="margin-left: 95px;">状态</span>
					</div>
					<div id="div_itemManufacturer" class="sp_tb"
						style="overflow-y: auto;"></div>
					<div class="ig">
						<input class="sp_icon1 isCheckAllss" type="checkbox"
							id="supCheckAllIcon" />
						<div class="Icon-size2 deleteCheckeds Tools10 sp_icon4"
							id="supDeleteCheckedIcon" onclick="itemBulkEditDel()"></div>
						<div class="Icon-size2 Line-1 sp_icon3"></div>
						<div class="Icon-size2 Tools11 sp_icon4" id="supBulkEditSelIcon"
							onclick="itemAddManufacturerWindowSelect()"></div>
						<div class="Icon-size2 Line-1 sp_icon3"></div>
						<div class="Icon-size2 copy sp_icon4" id="supBulkEditPasIcon"
							onclick="itemArticleAddManufacturerWindowSelect()"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>