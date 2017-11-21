<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/datagrid.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/shared/themes/${theme}/css/easyUI/pagination.css" />
<script src="${ctx}/shared/js/supplier/othrAddr.js" charset="gbk" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",
				function() {
						DispOrHid('B-id');
						gridbar_B();
		});
		<auchan:operauth ifAnyGrantedCode="111212996"> 
			$("#Tools11").attr('class', "Icon-size1 Tools11 B-id").bind("click",
					function() {
				createComOtherAddr();
			});
		</auchan:operauth>
		
		<auchan:operauth ifAnyGrantedCode="111212996"> 
			$("#Tools12").attr('class', "Icon-size1 Tools12 B-id").bind("click",
					function() {
				modifyComOtherAddr();
			});
		</auchan:operauth>
		
 		$('#supComMess').bind('click', function() {
 			companyManagement();
		}); 
 		$(".Tools6").bind('click',function(){
 			initPage();
 			pageQuery();
 			//comOtherAddrSearch();
 		});
 		//$(".Tools20").die('click'); 这个代码不可以这样写，die之后系统所有清除按钮都会失效 Dawson 2014-09-11
 		$(".Tools20").bind('click',function(){
 			clearAddrSearch();
 		});
 		$("#comNoSearch").live('keypress', function(e) {
			var code=e.keyCode;
			if (13==code) { 
				//comOtherAddrSearch();
				pageQuery();
			} 
		});
 		if(supplier_comNo){
 			$("#comNoSearch").val(supplier_comNo);
 	 	}
 		supplier_comNo = $.trim($("#comNoSearch").val());
 		if(supplier_comNo){
 			$("#comNameSearch").val(supplier_comName);
 	 	}
 	 	if('${comNo}' || '${comName}'){
 	 		$("#comNoSearch").val('${comNo}');
 	 		$("#comNameSearch").val('${comName}');
 	 	 }
 		//comOtherAddrSearch();
 		pageQuery();
		$(".Search").find('input').keydown(function(e){ 
			if(e.keyCode == 13){ 
				pageQuery(); 
            	return false;
			} 
		}); 
		$("#comNoSearch").keydown(function(e){ 
			if(e.keyCode == 13){ 
				//根据comNo查询其注册地址填充到厂商联系方式中
				var comNoSearch = $(this).val();
				$.post("${ctx}/supplier/company/getSupCompanyInfo",{comNo:comNoSearch}, function(data){
					if(data.supCompany && data.supCompany.comNo){
						$('#comNameSearch').attr("value",data.supCompany.comName);
						pageQuery();
					}else{
						top.jAlert('warning',comNoSearch+'公司不存在，请确认后重新输入','提示消息');
						$('#comNoSearch').attr("value",'');
					}
				});
            	return false;
			} 
		});
	});
	function closeSearch(){
		DispOrHid('C-id');
		gridbar_C();
	}
	function initPage(){
		$('#pageNo').val(1);
		var pageSize = $('#pageSize').val();
		if(pageSize==""){
			$('#pageSize').val(20);
		}
	}
</script>
<style type="text/css">
    .my-head-td-ck,.ck,.my-head-td-ck div,.ck div{
        display : none;
    }
    .datagrid-body{
    	overflow-x:hidden;
    }
    .scroll_bar{overflow-x:auto;}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
    <!--第一个-->
    <div id="first" class="tags1_left"></div>
    <div id="supComMess" class="tagsM"><auchan:i18n id="102004001"></auchan:i18n></div>

     <!--中间-->

    <div id="midden" class="tags  tags_right_on"></div>

    <!--最后一个-->
    <div id="comOthAddrMess" class="tagsM  tagsM_on"><auchan:i18n id="102006068"></auchan:i18n></div><!-- 订货退货地址 -->
    <div id="last" class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<div class="Search" style="display: none;">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span><auchan:i18n id="100002013"></auchan:i18n></span>
			<!-- 查询条件 -->
			<div class="Icon-size1 CircleClose C-id" onclick="closeSearch();"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle">
			<table class="SearchTable">
				<tr>
					<td><span><auchan:i18n id="102005003"></auchan:i18n></span></td>
					<td><input type="text" class="inputText w80" id="addrNoSearch"
						onkeyup="this.value=this.value.replace(/\D/g,'')" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102005004"></auchan:i18n></span></td>
					<td><auchan:select id="addrTypeSearch" _class="w80"
							mdgroup="COM_OTH_ADDRESS_ADDR_TYPE"></auchan:select></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102005005"></auchan:i18n></span></td>
					<td><input type="text" class="inputText w80"
						id="provNameSearch" readonly="readonly" /></td>
				</tr>
				<tr>
					<td class="ST_td1"></td>
					<td class="ST_td2"><div class="iconPut w80">
							<input type="text" class="w85 Black" id="cityNameSearch" />
							<div class="ListWin" onclick="openCityAndProvWindowSear();"></div>
						</div></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102005006"></auchan:i18n></span></td>
					<td><input type="text" class="inputText w80"
						id="detllAddrSearch" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102005007"></auchan:i18n></span></td>
					<td><input type="text" class="inputText w80"
						id="cntctNameSearch" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102005008"></auchan:i18n></span></td>
					<td><input type="text" class="inputText w80"
						id="postCodeSearch" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102005009"></auchan:i18n></span></td>
					<td><input type="text" class="inputText w80" id="moblNoSearch" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102005010"></auchan:i18n></span></td>
					<td><input type="text" class="inputText w80"
						id="phoneNoSearch" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102005011"></auchan:i18n></span></td>
					<td><input type="text" class="inputText w80" id="faxNoSearch" /></td>
				</tr>
				<tr>
					<td><span><auchan:i18n id="102005012"></auchan:i18n></span></td>
					<td><input type="text" class="inputText w80"
						id="emailAddrSearch" /></td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20"></div>
			<div class="Icon-size1 Tools6"></div>
		</div>
	</div>

	<div class="Content">
          <div style="height:30px;"><span style="float:left;padding-top:3px;">&nbsp;<auchan:i18n id="102005002"></auchan:i18n>&nbsp;</span>
                <div class="iconPut" style="width:13%;float:left;">
                <input type="text" style="width:80%" id="comNoSearch"  /><div class="ListWin" onclick="openComWindow()"></div></div>
                <input type="text" class="Black inputText twoInput2" style="width:30%;" id="comNameSearch" readonly="readonly"/></div>
       <!-- <table id="dg" style="height:540px;"></table> -->
       <div id="comOtherAddrList" style="height:510px;"></div>

      </div>
</div>
