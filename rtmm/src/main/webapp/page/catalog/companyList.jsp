﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/catalog/companyMessage.js" type="text/javascript"></script>
<div id="listTitle" class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div id="companMess" class="tagsM tagsM_on">
		<auchan:i18n id="101001001"></auchan:i18n>
	</div>
	<div class="tags tags3_r_on"></div>
</div>
<div id="list" class="Container-1" >
	<form id="queryFrom" class="clean_from">
		<div class="Search" style="display: none" id="companyList">
			<!-- Bar_on-->
			<div class="SearchTop">
				<span>
					<auchan:i18n id="100002013"></auchan:i18n>
				</span>
				<!-- 查询条件 -->
				<div class="Icon-size1 CircleClose C-id" onclick="{DispOrHid('C-id');gridbar_C();}"></div>
			</div>
			<div class="line"></div>
			<div class="SMiddle">
				<table class="SearchTable">
					<tr>
						<td>
							<span>
								<auchan:i18n id="101001002"></auchan:i18n>
							</span>
						</td>
						<td>
							<input name="comNo" type="text" class="inputText w80" maxlength="10" value="${comNo }" />
						</td>
					</tr>
					<tr>
						<td>
							<span>
								<auchan:i18n id="101001003"></auchan:i18n>
							</span>
						</td>
						<td>
							<input name="comName" type="text" class="inputText w80" maxlength="20" value="${comName }" />
						</td>
					</tr>
					<tr>
						<td>
							<span>
								<auchan:i18n id="101001010"></auchan:i18n>
							</span>
						</td>
						<td>
							<input name="comEnName" type="text" class="inputText w80" maxlength="20" value="${comEnName }" />
						</td>
					</tr>
					<tr>
						<td>
							<span>
								<auchan:i18n id="101001005"></auchan:i18n>
							</span>
						</td>
						<td>
							<select name="status" class="w80">
								<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
								<c:forEach items="${comStatusList }" var="st">
									<option value="${st.code }">${st.code }-${st.title }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<span>
								<auchan:i18n id="101001011"></auchan:i18n>
							</span>
						</td>
						<td>
							<input name="legalRpstv" type="text" class="inputText w80" maxlength="10" value="${legalRpstv }" />
						</td>
					</tr>
					<tr>
						<td class="ST_td1">
							<span>
								<auchan:i18n id="101001012"></auchan:i18n>
							</span>
						</td>
						<td class="ST_td2">
							<input name="bizScopeDesc" type="text" class="inputText w80" maxlength="50" value="${bizScopeDesc }" />
						</td>
					</tr>
					<tr>
						<td>
							<span>
								<auchan:i18n id="101006008"></auchan:i18n>
							</span>
						</td>
						<td>
							<!--<div class="C_Func iconPut w80">
						<input id="setupDate" type="text" class="w85" readonly="readonly"/>
						<div class="Calendar"></div>
					</div> -->
							<!-- <div style="margin:1px 0;"></div><input id="setupDate" class="easyui-datebox" style="width:135px;"/> -->
							<!-- <input id="d11" type="text" onClick="WdatePicker()"/> -->
							<input name="setupDate" class="Wdate" type="text" style="width: 137px;" onClick="WdatePicker({isShowClear:false,readOnly:true})">
						</td>
					</tr>

					<tr>
						<td>
							<span>
								<auchan:i18n id="101001007"></auchan:i18n>
							</span>
						</td>
						<td>
							<input name="regCity" name="regCity" type="text" class="inputText w80" maxlength="10" />
						</td>
					</tr>
					<tr>
						<td>
							<span>
								<auchan:i18n id="101001006"></auchan:i18n>
							</span>
						</td>
						<td>
							<input name="unifmNo" type="text" class="inputText w80" maxlength="25" />
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
		<div class="Content" id="company_content"></div>
	</form>
</div>
<div id="detailTitle" class="CTitle"  style="display: none;">
	<div class="tags1_left tags1_left_on"></div>
	<div id="companMess" class="tagsM tagsM_on"><auchan:i18n id="101001027"></auchan:i18n></div><!-- 公司详细信息 -->
	<div class="tags tags3_r_on"></div>
</div>
<div id="detail" class="Container-1" style="display: none"></div>

<script type="text/javascript">
	var compNo = null;
	var param = $("#queryFrom").serialize();
	
	$(function() {
		$(".Tools1").die("click");
		$('#Tools21').parent().attr('class','RightTool checked');
		
 		$("#companyList").keydown(function(e){ 
			if(e.keyCode == 13){ 
				
				$("#pageNo").val(1);
				pageQuery();
				return false;
			} 
		});
		
		
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",function() {
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
		pageQuery();
	});
	
	function search() {
		$("#pageNo").val(1);
		pageQuery();
	}

	function pageQuery() {
		param = $("#queryFrom").serialize();
		$.ajax({
			type : "post",
			data :param,
			dataType : "html",
			url : ctx + '/catalog/getCompanyByPage',
			success : function(data) {
				$('#company_content').html(data);
			}
		});
	}

	function onClickRow(comNo,count){
		$('#Tools22').parent().attr('class','RightTool active');
		$('#Tools22').unbind('click').bind('click',function() {
			$('#Tools22').parent().attr('class','RightTool checked');
			$('#Tools21').parent().attr('class','RightTool active');
			showCompanyDetail(comNo,count);
		});
	}

	function showCompanyDetail(comNo,count){
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
			data : {comNo:comNo,currentPage:currentPage,totalCount:totalCount},
			dataType : "html",
			url : ctx+'/catalog/getCompanyDetailedInfo',
			success : function(data) {
				$('#listTitle').hide();
				$('#list').hide();
				$('#detailTitle').show();
				$('#detail').show();
				$('#detail').html(data);
			}
		});
	}

	function onDblClickRow(comNo,count){
		$('#Tools22').parent().attr('class','RightTool checked');
		$('#Tools21').parent().attr('class','RightTool active');
		showCompanyDetail(comNo,count);
	}
	function clearForm(){
		$("input").val('');
	}
</script>

