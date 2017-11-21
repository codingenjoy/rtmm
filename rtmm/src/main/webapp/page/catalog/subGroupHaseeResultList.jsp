<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<div class="tags1_left"></div>
    <div class="tagsM" onclick="subGroupShow()"><auchan:i18n id="101010007"></auchan:i18n></div>

     <!--中间-->
     <div class="tags"></div>
    <div class="tagsM" onclick="showHaseeSeting()"><auchan:i18n id="101009001"></auchan:i18n></div>
    <div class="tags tags_right_on"></div>

    <!--最后一个-->
    <div class="tagsM tagsM_on"><auchan:i18n id="101010001"></auchan:i18n></div>
    <div class="tags tags3_r_on"></div>
</div>
<div id="subGroupDiv" class="Container-1">
	<form id="queryForm" class="clean_from">
	<div class="Search" style="display: none">
		<!-- Bar_on-->
		<div class="SearchTop">
			<span><auchan:i18n id="100002013"></auchan:i18n></span> <!-- 查询条件 -->
			<div class="Icon-size1 CircleClose C-id" onclick="{DispOrHid('C-id');gridbar_C();}"></div>
		</div>
		<div class="line"></div>
		<div class="SMiddle">
			<table class="SearchTable">
				<tr>
					<td class="w30">
						<span><auchan:i18n id="101010002"></auchan:i18n></span>
					</td>
					<td>
						<select name="storeNo" class="w80" style="width:135px;">
							<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${storeList}" var="store">
								<option value="${store.storeNo}">${store.storeNo}-${store.storeName}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="w30">
						<span><auchan:i18n id="101010003"></auchan:i18n></span>
					</td>
					<td>
						<select id="divisionCode" name="divNo" onchange="sectionSelect(this.value,'secNo')" class="w80" style="width:135px;">
							<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${divisionList }" var="item">
								<option value="${item.id}">${item.id}-${item.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101010004"></auchan:i18n></span>
					</td>
					<td>
						<select id="secNo" name="secNo" class="w80" style="width:135px;">
							<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101010005"></auchan:i18n></span>
					</td>
					<td>
						<input id="grpNo" name="grpNo" type="text" class="inputText" style="width: 135px" title="数字格式" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101010006"></auchan:i18n></span>
					</td>
					<td>
						<input id="midNo" name="midNo" type="text" class="inputText" style="width: 135px" title="数字格式" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8"/>
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101010007"></auchan:i18n></span>
					</td>
					<td>
						<input id="catlgNo" name="catlgNo" type="text" class="inputText" style="width: 135px" title="数字格式" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8" />
					</td>
				</tr>

			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20"></div>
			<div class="Icon-size1 Tools6" onclick="search()"></div>
		</div>
	</div>

	<div class="Content">
		<div id="sub_group_content_hasee_result"></div>
	</div>
	<input type="hidden" name="resultObj" id="resultObj">
	</form>
</div>
<script src="${ctx}/shared/js/catalog/catalogCommon.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",function() {
			DispOrHid('B-id');
			gridbar_B();
		});
		$(".tagsM").die('click');
 		$(".SMiddle").keydown(function(e){ 
			if(e.keyCode == 13){ 
				$("#pageNo").val(1);
				pageQuery();
				return false;
			} 
		}); 
		pageQuery('noshowData');
	});

	function search() {
		$("#pageNo").val(1);
		pageQuery();
	}

	function pageQuery(resultObj) {

		var number = new RegExp(/^[0-9]{1,8}$/);
		var grpNo = $('#grpNo').val();
		var midNo = $('#midNo').val();
		var catlgNo = $('#catlgNo').val();
		if(grpNo != "" && !number.test($.trim(grpNo))){
			top.jWarningAlert('大分类请输入数字格式',window.v_messages);
			return;
		}
		if(midNo != "" && !number.test($.trim(midNo))){
			top.jWarningAlert('中分类请输入数字格式',window.v_messages);
			return;
		}
		if(catlgNo != "" && !number.test($.trim(catlgNo))){
			top.jWarningAlert('小分类请输入数字格式',window.v_messages);
			return;
		}
		
		$('#resultObj').attr('value',resultObj||'');
		var param = $("#queryForm").serialize();
		$.post(ctx + '/catalog/subGroupHaseeResultListPage', param,function(data){
			$('#sub_group_content_hasee_result').html(data);
		},'html');
	}

	//神州分类目标设定
	function showHaseeSeting(){
		showContent(ctx + '/catalog/subGroupHaseeList');
	}

	//小分类列表显示
	function subGroupShow(){
		showContent(ctx + '/catalog/subGroupManagement', null);
	}

	//神州分类目标结果
	function showHaseeResult(){
		showContent(ctx + '/catalog/subGroupHaseeResultList', null);
	}
	

	
</script>