<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<%@ include file="/page/commons/toolbar.jsp"%>
<style type="text/css" >
    .tb_bar {
        height:160px;width:100%;margin-top:10px;background:#f9f9f9;float:left;
    }
</style>
<div class="CTitle">
	<div class="tags1_left tags1_left_off"></div>
	<div class="tagsM" onclick="subGroupShow()"><auchan:i18n id="101009007"></auchan:i18n></div>

	<!--中间-->
	<div class="tags tags_right_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="101009001"></auchan:i18n></div>
	<div class="tags tags_left_on"></div>

	<!--最后一个-->
	<div class="tagsM" onclick="showHaseeResult()"><auchan:i18n id="101010001"></auchan:i18n></div>
	<div class="tags tags3_r_off"></div>
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
					<td class="w35">
						<span><auchan:i18n id="101009003"></auchan:i18n></span>
					</td>
					<td>
						<select id="divisionCode" name="divNo" onchange="sectionSelect(this.value,'secNo')" class="w80">
							<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
							<c:forEach items="${divisionList }" var="item">
								<option value="${item.id}">${item.id}-${item.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101009004"></auchan:i18n></span>
					</td>
					<td>
						<select id="secNo" name="secNo" class="w80" style="width:135px;">
							<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101009005"></auchan:i18n></span>
					</td>
					<td>
						<input id="grpNo"  name="grpNo" type="text" class="inputText w80" title="数字格式" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8" />
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101009006"></auchan:i18n></span>
					</td>
					<td>
						<input id="midNo" name="midNo" type="text" class="inputText w80" title="数字格式" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8" />
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101009007"></auchan:i18n></span>
					</td>
					<td>
						<input id="catlgNo" name="catlgNo" type="text" class="inputText w80" title="数字格式" onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8" />
					</td>
				</tr>
				<tr>
					<td>
						<span><auchan:i18n id="101010008"></auchan:i18n></span>
					</td>
					<td>
						<!-- <input id="location" name="dept" value="" data-options="editable:false,panelHeight:'auto'" /> -->
						<select id="location" name="mktPostN">
							<option value="B">B</option>
							<option value="N">N</option>
							<option value="O">O</option>
						</select>
					</td>
				</tr>
			</table>
		</div>
		<div class="line"></div>
		<div class="SearchFooter">
			<div class="Icon-size1 Tools20"></div>
			<div class="Icon-size1 Tools6" onclick="searchPageQuery()"></div>
		</div>
	</div>
	<div class="Content">
		<div style="height: 30px; line-height: 18px;">
			<span><auchan:i18n id="101009002"></auchan:i18n></span><!-- 区域 -->
			<select id="area" name="regnNo" onchange="search()">
				<option value=""><auchan:i18n id="100000009"></auchan:i18n></option>
				<option value="1">1-<auchan:i18n id="101008014"></auchan:i18n></option>
				<option value="2">2-<auchan:i18n id="101008013"></auchan:i18n></option>
				<option value="3">3-<auchan:i18n id="101008016"></auchan:i18n></option>
				<option value="4">4-<auchan:i18n id="101008015"></auchan:i18n></option>
				<option value="5">5-<auchan:i18n id="101008017"></auchan:i18n></option>
				<option value="6">6-<auchan:i18n id="101008018"></auchan:i18n></option>
				<option value="7">7-<auchan:i18n id="101008019"></auchan:i18n></option>
			</select>
		</div>
		<div id="sub_group_content_hasee"></div>
	</div>
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
		pageQuery();
	});

	function search() {
		$("#pageNo").val(1);
		pageQuery();
	}

	function pageQuery() {
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
		
		var param = $("#queryForm").serialize();
		$.post(ctx + '/catalog/subGroupHaseeListPage', param,function(data){
			$('#sub_group_content_hasee').html(data);
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
	
	//检索查询
	function searchPageQuery(){
		var regnNo = $.trim($("select[name='regnNo']").val());
		if (regnNo == "") {
			top.jWarningAlert('请选择区域',window.v_messages);
			return ;
		} else {
			search();
		}
	}
</script>