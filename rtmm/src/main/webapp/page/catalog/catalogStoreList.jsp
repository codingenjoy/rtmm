<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/shared/js/catalog/storeManagement.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<script type="text/javascript">
	var compNo = null;
	$(function() {
		$(".Tools1").die("click");
		$('#Tools21').parent().attr('class','RightTool checked');
		
 		$("#storeList").keydown(function(e){
			if(e.keyCode == 13){ 
				$("#pageNo").val(1);
				pageQuery();
				//return false;
			} 
		}); 
		
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind( "click", function() {
			if ($(this).hasClass("Tools1_disable")) {
				return ;
			}
  			if ($(this).parent().hasClass("Tools1Parent_bg")) {
				$(this).attr("class","Icon-size1 Tools1 B-id");
				$(this).parent().removeClass("Tools1Parent_bg");
			} else {
				$(this).attr("class","Icon-size1 Tools1 B-id Tools1_on");
				$(this).parent().addClass("Tools1Parent_bg");
			}
			DispOrHid('B-id');
			gridbar_B();
		});
		search();
	});

	function search() {
		$("#pageNo").val(1);
		pageQuery();
	}

	function pageQuery() {
		var param = $("#queryFrom").serialize();
		$.ajax({
			type : "post",
			data : param,
			dataType : "html",
			url : ctx + '/catalog/catalogStoreListAction',
			success : function(data) {
				$('#content_store').html(data);
			}
		});
	}

	function onClickRow(storeNo,count){
		$('#Tools22').parent().attr('class','RightTool active');
		$('#Tools22').unbind('click').bind('click', function() {
			$('#Tools22').parent().attr('class','RightTool checked');
			$('#Tools21').parent().attr('class','RightTool active');
			showStoreDetail(storeNo,count);
		});
	}

	function showStoreDetail(storeNo,count){
 		if ($("#Tools1").parent().hasClass("Tools1Parent_bg")) {
 			DispOrHid('C-id');
 			$("#Tools1").parent().removeClass("Tools1Parent_bg");
			//$(".CircleClose").click();
 		}
		var pageNo = $('#pageNo').val();
		var pageSize = $('#pageSize').val();
		var totalCount = $('#totalCount').val();
		var currentPage = (parseInt(pageNo,10)-1)*parseInt(pageSize,10) + parseInt(count,10);
		$.ajax({
			type : "post",
			data : {storeNo:storeNo,currentPage:currentPage,totalCount:totalCount},
			dataType : "html",
			url : ctx+'/catalog/getStoreDetailedInfo',
			success : function(data) {
				$('#listTitle').hide();
				$('#storeList').hide();
				$('#detailTitle').show();
				$('#detail').show();
				$('#detail').html(data);
			}
		});
	}
	
	function onDblClickRow(storeNo,count){	
		$('#Tools22').parent().attr('class','RightTool checked');
		$('#Tools21').parent().attr('class','RightTool active');
		showStoreDetail(storeNo,count);
	}

	//手动输入公司
	$("#companyCode").blur(function(){
		var comNo = $.trim($("#companyCode").val());
		searchCompanyMess(comNo);
	});
	$("#companyCode").die("keydown").live("keydown",function(){
		var comNo = $.trim($("#companyCode").val());
		var event = e || window.event;
		var e = event || arguments.callee.caller.arguments[0];
		if (e.keyCode == 13) {
			if(comNo){
				searchCompanyMess(comNo);
				pageQuery();
			} else {
				$("#companName").val('');
			}
		}
	});

	function clearForm(){
		$(".Search input").val('');
	}
</script>
<%@ include file="/page/commons/toolbar.jsp"%>
<div id="listTitle" class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="101003001"></auchan:i18n></div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1" id="storeList">
	<form id="queryFrom" class="clean_from">
		<div class="Search" style="display: none;">
			<!-- Bar_on-->
			<div class="SearchTop">
				<span><auchan:i18n id="100002013"></auchan:i18n></span> <!-- 查询条件 -->
				<div class="Icon-size1 CircleClose C-id" onclick="{DispOrHid('C-id');gridbar_C();}"></div>
			</div>
			<div class="line"></div>
			<div class="SMiddle">
				<table class="SearchTable">
					<tr>
						<td class="w35">
							<span><auchan:i18n id="101003002"></auchan:i18n></span>
						</td>
						<td>
							<input id="storeNo" name="storeNo" type="text" class="inputText w80" maxlength="6" onkeyup="this.value=this.value.replace(/\D/g,'')" />
						</td>
					</tr>
					<tr>
						<td>
							<span><auchan:i18n id="101003003"></auchan:i18n></span>
						</td>
						<td>
							<input id="storeName" name="storeName" type="text" class="inputText w80" />
						</td>
					</tr>
					<tr>
						<td>
							<span><auchan:i18n id="101003004"></auchan:i18n></span>
						</td>
						<td>
							<auchan:select mdgroup="STORE_STATUS" _class="w80" id="status" name="status" />
						</td>
					</tr>
					<tr>
						<td>
							<span><auchan:i18n id="101003008"></auchan:i18n></span>
						</td>
						<td>
							<auchan:select mdgroup="STORE_BIZ_TYPE" _class="w80" id="bizType" name="bizType" />
						</td>
					</tr>
					<tr>
						<td>
							<span><auchan:i18n id="101003005"></auchan:i18n></span>
						</td>
						<td>
							<auchan:select mdgroup="REGION_NODE_DEVLP_GRD" _class="w80" id="lvlNo" name="lvlNo" />
						</td>
					</tr>

					<tr>
						<td>
							<span><auchan:i18n id="101003007"></auchan:i18n></span>
						</td>
						<td>
							<input id="setupDate" id="openDate" name="openDate" class="Wdate" style="width: 135px;" type="text"
								onClick="WdatePicker({isShowClear:false,readOnly:true})">
						</td>
					</tr>
					<tr>
						<td>
							<span><auchan:i18n id="101003006"></auchan:i18n></span>
						</td>
						<td>
							<div class="iconPut" style="width: 55%; float: left;">
								<input id="companyCode" name="comNo" class="combo-arrow-hover" type="text" style="width: 75%" />
								<div class="ListWin" onclick="openCompanyWindow()"></div>
							</div>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input id="companName" name="companName" type="text" class="Black inputText w80" readonly="readonly" />
						</td>
					</tr>
					<tr>
						<td>
							<span><auchan:i18n id="101003021"></auchan:i18n></span>
						</td>
						<td>
							<div class="iconPut" style="width: 47%; float: left;">
								<input id="regnNo" name="regnNo" type="text" style="width: 75%" readonly="readonly" />
								<div class="ListWin" onclick="openCityWindow()"></div>
							</div>
							<input id="regnName" type="text" class="Black inputText twoInput2 w50" readonly="readonly" />
						</td>
					</tr>
				</table>
			</div>
			<div class="line"></div>
			<div class="SearchFooter">
				<div class="Icon-size1 Tools20" onclick="clearForm()" ></div>
				<div class="Icon-size1 Tools6" onclick="search()"></div>
			</div>
		</div>
		<div id="content_store" class="Content"></div>
	</form>
</div>
<div id="detailTitle" class="CTitle" style="display: none">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="101003033"></auchan:i18n></div><!-- 分店详细信息 -->
	<div class="tags tags3_r_on"></div>
</div>
<div id="detail" class="Container-1" style="display: none"></div>

