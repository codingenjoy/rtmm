<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="${ctx}/shared/js/supplier/othrAddr.js" charset="gbk" type="text/javascript"></script>
<script src="${ctx}/shared/js/catalog/catalogCommon.js" type="text/javascript"></script>
<script src="${ctx}/shared/js/catalog/sectionAttr.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		
		$("#Tools12").attr("class", "Tools12_disable");
		$("#Tools12").unbind();
		
		$("#sec_info").unbind('click').bind('click', function() {
			showContent(ctx+'/catalog/catalogDivisionAction');
		});
		
		pageQuery();
	});
	
	/**
	 * 課別屬性: 課別選擇彈出框
	 */
	function selectSection(){
		openPopupWin(400, 200, '/catalog/openChooseSectionAction');
	}
	
	/**
	 * 課別屬性: 查詢右邊的對應屬性值列表
	 */
	function pageQuery(catlgId, attrSeqNo){
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		
		var catlgId = $("#secAttrSecNo").val();
		if (attrSeqNo == null) {
			attrSeqNo = $('#attrSeqNo').val();
		}
		$.ajax({
			type : "post",
			data :{
				catlgId : catlgId,
				secAttrSeqNo : attrSeqNo,
				pageNo : pageNo,
				pageSize : pageSize
			},
			dataType : "html",
			url : ctx + '/catalog/showSecAttrContentList',
			success : function(data) {
				$('#attrValList').html(data);
				$('#attrValUpdate').attr("class", "Icon-size2 Tools12_disable").unbind("click");
			}
		});
	}
	
	/**
	 * 課別屬性: disable 編輯課別屬性
	 */
	function disableSecAttrEdit(){
		 // disable 課別屬性編輯按鈕
		 $('#Tools12').removeClass("Tools12").addClass("Tools12_disable").unbind("click");
		 // disable 課別屬性對應值新增按鈕
		 $('#attrValCreate').removeClass("Tools11").addClass("Tools11_disable").unbind("click");	
	}
	
	/**
	 * 課別屬性: enable 編輯課別屬性
	 */
	function enableSecAttrEdit(){
		<auchan:operauth ifAnyGrantedCode="110312002">
			// enable 課別屬性編輯按鈕
			$("#Tools12").attr("class", "Tools12");
			$("#Tools12").unbind("click").bind("click", function(){
				editSecAttrFormPopWin();
			});

			// enable 課別屬性對應值新增按鈕
			$('#attrValCreate').removeClass("Tools11_disable").addClass("Tools11");	
			$('#attrValCreate').unbind("click").bind("click", function(){
				editSecAttrValFormPopWin('CREATE');	
			});
		</auchan:operauth>		
	}
	
	/**
	 * 課別屬性: enable 編輯課別屬性對應值
	 */
	function onClickRow(secAttrValNo){
		<auchan:operauth ifAnyGrantedCode="110312002">
			$("#attrValUpdate").attr('class', "Icon-size2 Tools12").unbind("click").bind("click", function() {
				editSecAttrValFormPopWin('UPDATE');
			});
		</auchan:operauth>
	}
	
 	//手动输入课别
	$("#secAttrSecNo").bind('keypress', function(e) {
		var code=e.keyCode;
		if (13==code) {
			if ($.trim($(this).val()) == $.trim($(this).attr('prevl'))) {
				return false;
			}
			var sectionNo = $("#secAttrSecNo").val();
			if(sectionNo){
				searchSectionMess(sectionNo);
			}else{
				top.jWarningAlert('请输入课别',window.v_messages);
			} 
		}
		$("#secAttrSecNo").attr("prevl",$.trim($(this).val()));
	});
 	//失去光标事件
 	$("#secAttrSecNo").unbind('blur').bind('blur', function() {
		if ($.trim($(this).val()) == $.trim($(this).attr('prevl'))) {
			return false;
		}
		$("#secAttrSecNo").attr("prevl",$.trim($(this).val()));
		var sectionNo = $.trim($("#secAttrSecNo").val());
		if(sectionNo){
			searchSectionMess(sectionNo);
		}else{
			top.jWarningAlert('请输入课别',window.v_messages);
		} 
	});

</script>
<style type="text/css">
.my-head-td-ck,.ck,.my-head-td-ck div,.ck div {
	display: none;
}

.tbx {
	height: 443px;
}

.tbx td {
	height: 30px;
}

.tbx tr {
	border-bottom: 1px solid white;
	cursor: pointer;
}

.tbx tr:hover {
	background: #99cc66;
}

.item_on2 {
	background: #3F9673 !important;
	color: #fff;
}

.Con_tb {
	width: 35%;
	margin-top: 0px;
	height: 580px;
	float: left;
}

.Con_R {
	width: 65%;
	float: right;
	height: 580px;
}

.con_title {
	height: 30px;
	background: #EEEEEE;
	overflow: hidden;
}

.con_title table {
	margin-top: 5px;
}

.con_title td {
	height: 20px;
}

.datagrid-body {
	overflow-x: hidden;
}

.scroll_bar {
	overflow-x: auto;
}

.paging .page_list{
	width: 300px;
}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<!--第一个-->
	<div id="first" class="tags1_left"></div>
	<div id="sec_info" class="tagsM"><auchan:i18n id="101004001"></auchan:i18n></div>

	<!--中间-->
	<div id="midden" class="tags  tags_right_on"></div>

	<!--最后一个-->
	<div id="sec_attr" class="tagsM tagsM_on"><auchan:i18n id="101005001"></auchan:i18n></div>
	<div id="last" class="tags tags3_r_on"></div>
</div>
<div class="Container-1">

	<div class="Content">
		<div class="ig">
			<div class="icol_text w5">
				<span><auchan:i18n id="101005002"></auchan:i18n></span>
			</div>
			<div class="iconPut iq" style="width: 10%;">
				<input id="secAttrSecNo" class="w80" type="text" />
				<div class="ListWin" onclick="selectSection()"></div>
			</div>
			<input id="secAttrSecName" type="text" class="inputText w20" readonly="readonly"/>
		</div>
		<div class="Con_tb">
			<!-- Bar_on-->
			<div class="line" style="width: 100%;"></div>
			<div class="SearchTopx">
				<span><auchan:i18n id="101005001"></auchan:i18n></span>
			</div>
			<div class="con_title">
				<table class="w100">
					<tr>
						<td class="w10 align_center" style="border-right: 1px solid #cccccc;"></td>
						<td class="w10 align_center" style="border-right: 1px solid #cccccc;"><auchan:i18n id="101005003"></auchan:i18n></td>
						<td class="w35 align_center" style="border-right: 1px solid #cccccc;"><auchan:i18n id="101005004"></auchan:i18n></td>
					</tr>
				</table>
			</div>
			<div class="tbx">
				<table id="secAttrList" class="w100">
					<tr class="tbr">
						<td class="w10 align_center"></td>
						<td class="w10 align_center" style="text-align: right;">&nbsp;&nbsp;&nbsp;</td>
						<td class="w35">&nbsp;&nbsp;&nbsp;</td>
						<td class="w45">&nbsp;&nbsp;&nbsp;</td>
					</tr>
				</table>
			</div>
			<div class="line"></div>
		</div>
		<div class="Con_R" style="height:96%;">
			<div class="Point_L" style="height:98%">
				<div></div>
				<div></div>
				<div id="Point_L1" class="px"></div>
				<div id="Point_L2" class="px"></div>
				<div id="Point_L3" class="px"></div>
				<div id="Point_L4" class="px"></div>
				<div id="Point_L5" class="px"></div>
				<div id="Point_L6" class="px"></div>
				<div id="Point_L9" class="px"></div>
			</div>
			<div class="Point_R">
				<div style="height: 30px; line-height: 25px;">
					<span style="float: left;"><auchan:i18n id="101005005"></auchan:i18n></span>
					<auchan:operauth ifAnyGrantedCode="110312002">
						<div id="attrValCreate" class="Icon-size2 Tools11_disable" style="float: right; margin-top: 5px; margin-right: 7px;"></div>
						<div class="Icon-size2 Line-1" style="float: right; margin-top:5px;"></div>
						<div id="attrValUpdate" class="Icon-size2 Tools12_disable" style="float: right; margin-top: 5px;"></div>
						<div class="Icon-size2 Line-1" style="float: right; margin-top:5px;"></div>
						<div class="Icon-size2 Tools10_disable" style="float: right; margin-top: 5px;" onclick=""></div>
					</auchan:operauth>
				</div>
				<!-- <table id="attrContentList" style="height: 503px; width: 646px"></table> -->
				<div id="attrValList" >
				
				</div>
			</div>
		</div>
	</div>
</div>
