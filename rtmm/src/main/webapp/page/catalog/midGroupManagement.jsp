<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/page/commons/taglibs.jsp"%>
<script src="${ctx}/shared/js/catalog/catalogCommon.js" type="text/javascript"></script>
<style type="text/css">
.tb_bar {
	height: 150px;
	width: 100%;
	margin-top: 10px;
	background: #f9f9f9;
}
</style>
<%@ include file="/page/commons/toolbar.jsp"%>
<div class="CTitle">
	<div class="tags1_left tags1_left_on"></div>
	<div class="tagsM tagsM_on"><auchan:i18n id="101007001"></auchan:i18n></div>
	<div class="tags tags3_r_on"></div>
</div>
<div class="Container-1">
	<form id="queryFrom" class="clean_from">
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
						<span><auchan:i18n id="101007007"></auchan:i18n></span>
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
						<span><auchan:i18n id="101007008"></auchan:i18n></span>
					</td>
					<td>
						<select id="secNo" name="secNo" class="w80"  style="width:135px;">
							<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101007002"></auchan:i18n></span>
					</td>
					<td>
						<input id="grpNo" name="grpNo" type="text" class="inputText w80" title="数字格式"  onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8"/>
					</td>
					<!-- 					<td>
					<div class="groupCodeBySection" style="display: block;">请选择课别</div>
					</td> -->
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101007003"></auchan:i18n></span>
					</td>
					<td>
						<input id="catlgNo" name="catlgNo" type="text" class="inputText w80" title="数字格式"  onkeyup="this.value=this.value.replace(/\D/g,'')" maxlength="8"/>
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101007023"></auchan:i18n></span>
					</td>
					<td>
						<input id="catlgName" name="catlgName" type="text" class="inputText w80" title="中分类名称" />
					</td>
				</tr>
				<tr>
					<td class="w35">
						<span><auchan:i18n id="101007006"></auchan:i18n></span>
					</td>
					<td>
						<select id="status" name="status" class="w80">
							<option value=''><auchan:i18n id="100000009"></auchan:i18n></option>
							<option value="0">0-尚未生效</option>
							<option value="1">1-正常</option>
							<option value="9">9-删除</option>
						</select>
						<%-- <auchan:select dataBind="value: status" mdgroup="CL_CATALOG_STATUS" id="status" name="status" _class="w80"></auchan:select> --%>
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
	<div class="Content" id="extraInfo">
		<div id="mid_group_content"></div>
		<div id="mid_group_ext_info"></div>
	</div>
	</form>
</div>
<script type="text/javascript">

	$(function() {
 		$(".SMiddle").keydown(function(e){ 
			if(e.keyCode == 13){ 
				$("#pageNo").val(1);
				pageQuery();
				return false;
			} 
		});
 		
		<auchan:operauth ifAnyGrantedCode="110421996">
			$("#Tools11").attr('class', "Tools11").bind("click", function() {
				createMidGroup();
			});
		</auchan:operauth>
		
/* 		$("#Tools10").attr('class', "Tools10_disable").bind("click",function() {
			midsizeDelete();
		}); */
		
		$("#Tools1").attr('class', "Icon-size1 Tools1 B-id").bind("click",function() {
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
		var number = new RegExp(/^[0-9]{1,8}$/);
		var grpNo = $('#grpNo').val();
		var catlgNo = $('#catlgNo').val();
		if(grpNo != "" && !number.test($.trim(grpNo))){
			top.jWarningAlert('大分类请输入数字格式',window.v_messages);
			return;
		}
		if(catlgNo != "" && !number.test($.trim(catlgNo))){
			top.jWarningAlert('中分类请输入数字格式',window.v_messages);
			return;
		}

		var param = $("#queryFrom").serialize();
		$.post(ctx + '/catalog/midGroupListPage', param,function(data){
			$('#mid_group_content').html(data);
			//默认选中表格第一行
			if($('#mid_group_content').find('table').find("tr").size()>1){
				$('#mid_group_content').find('table').find("tr:eq(0)").trigger('click');
			}else{
				$('#mid_group_ext_info').find('input').attr('value','');
			}
		},'html');
	}
	

	function onClickRow(catlgId,catlgName,catlgEnName,status,divTitle,secTitle,createDate,chngDate,chngBy){
		
		setExtInfo(catlgId,createDate,chngDate,chngBy);//设置选中项额外信息
		//绑定修改按钮
		<auchan:operauth ifAnyGrantedCode="110421996,110421002">
			$("#Tools12").removeClass("Tools12_disable").addClass("Tools12").unbind("click").bind("click",function(){
				openPopupWin(600, 460, '/catalog/updateMidGroup?midGroupId='+catlgId);
			});
		</auchan:operauth>
	}

	/*设置选中项额外信息*/
	function setExtInfo(catlgId,createDate,chngDate,chngBy){
		
		$.ajax({
			type : "post",
			async : false,
			data :{midGroupId:catlgId},
			dataType : "html",
			url : ctx + '/catalog/getMidGroupExtInfo',
			success : function(data) {
				$('#mid_group_ext_info').html(data);
			}
		});
		$('#createDate').attr('value',createDate);
		$('#chngDate').attr('value',chngDate);
		$('#chngBy').attr('value',chngBy);
		
	}

	function onDblClickRow(comNo){	
	
	}

	// 创建中分类信息
	function createMidGroup() {
		openPopupWin(600, 460, '/catalog/createMidGroup');
	}	
</script>